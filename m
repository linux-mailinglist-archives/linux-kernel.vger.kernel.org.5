Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4B97ACA6E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 17:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjIXPS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 11:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjIXPSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 11:18:08 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4B010FA;
        Sun, 24 Sep 2023 08:17:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VsilXnY_1695568653;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsilXnY_1695568653)
          by smtp.aliyun-inc.com;
          Sun, 24 Sep 2023 23:17:36 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     wintera@linux.ibm.com, schnelle@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, guwen@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 16/18] net/smc: avoid data copy from sndbuf to peer RMB in SMC-D
Date:   Sun, 24 Sep 2023 23:16:51 +0800
Message-Id: <1695568613-125057-17-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aims to avoid data copy from local sndbuf to peer RMB by mapping
local sndbuf to peer RMB when DMBs have ISM_ATTR_DMB_MAP attribute.

After this, local sndbuf and peer RMB share the same physical memory.

 +----------+                     +----------+
 | socket A |                     | socket B |
 +----------+                     +----------+
       |                               ^
       |         +---------+           |
  regard as      |         |     regard as
  local sndbuf   |  B's    |     local RMB
       |         |  RMB    |           |
       |-------> |         |-----------|
                 +---------+

1. From the perspective of RMB:

     a. Created or reused when connection is created.
     b. Unused and recycled to lgr buffer pool when connection is freed.
     c. Freed when link group is freed.

2. From the perspective of sndbuf:

     a. Mapped to peer RMB by the rtoken exchanged through CLC message.
        Then accessing local sndbuf is equivalent to accessing peer RMB.
     c. Unmapped from peer RMB and freed when connection is freed. Won't be
        recycled to lgr buffer pool.

Therefore, the data written to local sndbuf will directly reach peer RMB.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/af_smc.c   | 14 +++++++++++
 net/smc/smc_core.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 net/smc/smc_core.h |  1 +
 3 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 6435659..47556c3 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1442,6 +1442,12 @@ static int smc_connect_ism(struct smc_sock *smc,
 	}
 
 	smc_conn_save_peer_info(smc, aclc);
+
+	if (smc_ism_dmb_mappable(smc->conn.lgr->smcd)) {
+		rc = smcd_buf_attach(smc);
+		if (rc)
+			goto connect_abort;
+	}
 	smc_close_init(smc);
 	smc_rx_init(smc);
 	smc_tx_init(smc);
@@ -2550,6 +2556,14 @@ static void smc_listen_work(struct work_struct *work)
 		mutex_unlock(&smc_server_lgr_pending);
 	}
 	smc_conn_save_peer_info(new_smc, cclc);
+
+	if (ini->is_smcd &&
+	    smc_ism_dmb_mappable(new_smc->conn.lgr->smcd)) {
+		rc = smcd_buf_attach(new_smc);
+		if (rc)
+			goto out_decl;
+	}
+
 	smc_listen_out_connected(new_smc);
 	SMC_STAT_SERV_SUCC_INC(sock_net(newclcsock->sk), ini);
 	goto out_free;
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 6d7c738..96b1def 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1154,6 +1154,20 @@ static void smcr_buf_unuse(struct smc_buf_desc *buf_desc, bool is_rmb,
 	}
 }
 
+static void smcd_buf_detach(struct smc_connection *conn)
+{
+	struct smcd_dev *smcd = conn->lgr->smcd;
+	u64 peer_token = conn->peer_token;
+
+	if (!conn->sndbuf_desc)
+		return;
+
+	smc_ism_detach_dmb(smcd, peer_token);
+
+	kfree(conn->sndbuf_desc);
+	conn->sndbuf_desc = NULL;
+}
+
 static void smc_buf_unuse(struct smc_connection *conn,
 			  struct smc_link_group *lgr)
 {
@@ -1198,6 +1212,10 @@ void smc_conn_free(struct smc_connection *conn)
 		if (!list_empty(&lgr->list))
 			smc_ism_unset_conn(conn);
 		tasklet_kill(&conn->rx_tsklet);
+
+		/* detach sndbuf from peer RMB */
+		if (smc_ism_dmb_mappable(lgr->smcd))
+			smcd_buf_detach(conn);
 	} else {
 		smc_cdc_wait_pend_tx_wr(conn);
 		if (current_work() != &conn->abort_work)
@@ -2459,15 +2477,23 @@ void smc_rmb_sync_sg_for_cpu(struct smc_connection *conn)
  */
 int smc_buf_create(struct smc_sock *smc, bool is_smcd)
 {
+	bool sndbuf_created = false;
 	int rc;
 
+	if (is_smcd &&
+	    smc_ism_dmb_mappable(smc->conn.lgr->smcd))
+		goto create_rmb;
+
 	/* create send buffer */
 	rc = __smc_buf_create(smc, is_smcd, false);
 	if (rc)
 		return rc;
+	sndbuf_created = true;
+
+create_rmb:
 	/* create rmb */
 	rc = __smc_buf_create(smc, is_smcd, true);
-	if (rc) {
+	if (rc && sndbuf_created) {
 		down_write(&smc->conn.lgr->sndbufs_lock);
 		list_del(&smc->conn.sndbuf_desc->list);
 		up_write(&smc->conn.lgr->sndbufs_lock);
@@ -2477,6 +2503,48 @@ int smc_buf_create(struct smc_sock *smc, bool is_smcd)
 	return rc;
 }
 
+int smcd_buf_attach(struct smc_sock *smc)
+{
+	struct smc_connection *conn = &smc->conn;
+	struct smcd_dev *smcd = conn->lgr->smcd;
+	u64 peer_token = conn->peer_token;
+	struct smc_buf_desc *buf_desc;
+	int rc;
+
+	buf_desc = kzalloc(sizeof(*buf_desc), GFP_KERNEL);
+	if (!buf_desc)
+		return -ENOMEM;
+
+	/* map local sndbuf desc to peer RMB, so operations on local
+	 * sndbuf are equivalent to operations on peer RMB.
+	 */
+	rc = smc_ism_attach_dmb(smcd, peer_token, buf_desc);
+	if (rc) {
+		rc = SMC_CLC_DECL_MEM;
+		goto free;
+	}
+
+	smc->sk.sk_sndbuf = buf_desc->len;
+	buf_desc->cpu_addr = (u8 *)buf_desc->cpu_addr + sizeof(struct smcd_cdc_msg);
+	buf_desc->len -= sizeof(struct smcd_cdc_msg);
+	conn->sndbuf_desc = buf_desc;
+	conn->sndbuf_desc->used = 1;
+	atomic_set(&conn->sndbuf_space, conn->sndbuf_desc->len);
+	return 0;
+
+free:
+	if (conn->rmb_desc) {
+		/* free local RMB as well */
+		down_write(&conn->lgr->rmbs_lock);
+		list_del(&conn->rmb_desc->list);
+		up_write(&conn->lgr->rmbs_lock);
+		smc_buf_free(conn->lgr, true, conn->rmb_desc);
+		conn->rmb_desc = NULL;
+	}
+	kfree(buf_desc);
+	return rc;
+}
+
 static inline int smc_rmb_reserve_rtoken_idx(struct smc_link_group *lgr)
 {
 	int i;
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index d57eb9b..2cba119 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -551,6 +551,7 @@ void smc_smcd_terminate(struct smcd_dev *dev, struct smcd_gid *peer_gid,
 void smc_smcd_terminate_all(struct smcd_dev *dev);
 void smc_smcr_terminate_all(struct smc_ib_device *smcibdev);
 int smc_buf_create(struct smc_sock *smc, bool is_smcd);
+int smcd_buf_attach(struct smc_sock *smc);
 int smc_uncompress_bufsize(u8 compressed);
 int smc_rmb_rtoken_handling(struct smc_connection *conn, struct smc_link *link,
 			    struct smc_clc_msg_accept_confirm *clc);
-- 
1.8.3.1

