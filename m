Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FEF80BB08
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 14:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjLJNZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 08:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjLJNY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 08:24:57 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17FC19AB;
        Sun, 10 Dec 2023 05:24:45 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Vy8H5PM_1702214680;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vy8H5PM_1702214680)
          by smtp.aliyun-inc.com;
          Sun, 10 Dec 2023 21:24:42 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 11/13] net/smc: attach or detach ghost sndbuf to peer DMB.
Date:   Sun, 10 Dec 2023 21:24:12 +0800
Message-Id: <1702214654-32069-12-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702214654-32069-1-git-send-email-guwen@linux.alibaba.com>
References: <1702214654-32069-1-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ghost sndbuf descriptor will be created and attached to peer DMB
once peer token is obtained and it will be detach and freed when the
connection is freed.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/af_smc.c   | 21 ++++++++++++++++
 net/smc/smc_core.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 net/smc/smc_core.h |  1 +
 3 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 6c0e381..838cf9c 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1449,6 +1449,14 @@ static int smc_connect_ism(struct smc_sock *smc,
 	}
 
 	smc_conn_save_peer_info(smc, aclc);
+
+	if (smc_ism_dmb_mappable(smc->conn.lgr->smcd)) {
+		rc = smcd_buf_attach(smc);
+		if (rc) {
+			rc = SMC_CLC_DECL_MEM;	/* try to fallback */
+			goto connect_abort;
+		}
+	}
 	smc_close_init(smc);
 	smc_rx_init(smc);
 	smc_tx_init(smc);
@@ -2559,6 +2567,19 @@ static void smc_listen_work(struct work_struct *work)
 		mutex_unlock(&smc_server_lgr_pending);
 	}
 	smc_conn_save_peer_info(new_smc, cclc);
+
+	if (ini->is_smcd &&
+	    smc_ism_dmb_mappable(new_smc->conn.lgr->smcd)) {
+		rc = smcd_buf_attach(new_smc);
+		if (rc)
+			/* SMC-D client has completed the CLC process,
+			 * so server can not send decline any more.
+			 * This requires the rc returned here no larger
+			 * than 0.
+			 */
+			goto out_decl;
+	}
+
 	smc_listen_out_connected(new_smc);
 	SMC_STAT_SERV_SUCC_INC(sock_net(newclcsock->sk), ini);
 	goto out_free;
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 95cc954..4a76e38 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1149,6 +1149,20 @@ static void smcr_buf_unuse(struct smc_buf_desc *buf_desc, bool is_rmb,
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
@@ -1192,6 +1206,8 @@ void smc_conn_free(struct smc_connection *conn)
 	if (lgr->is_smcd) {
 		if (!list_empty(&lgr->list))
 			smc_ism_unset_conn(conn);
+		if (smc_ism_dmb_mappable(lgr->smcd))
+			smcd_buf_detach(conn);
 		tasklet_kill(&conn->rx_tsklet);
 	} else {
 		smc_cdc_wait_pend_tx_wr(conn);
@@ -1445,6 +1461,8 @@ static void smc_conn_kill(struct smc_connection *conn, bool soft)
 	smc_sk_wake_ups(smc);
 	if (conn->lgr->is_smcd) {
 		smc_ism_unset_conn(conn);
+		if (smc_ism_dmb_mappable(conn->lgr->smcd))
+			smcd_buf_detach(conn);
 		if (soft)
 			tasklet_kill(&conn->rx_tsklet);
 		else
@@ -2455,15 +2473,23 @@ void smc_rmb_sync_sg_for_cpu(struct smc_connection *conn)
  */
 int smc_buf_create(struct smc_sock *smc, bool is_smcd)
 {
+	bool sndbuf_created = false;
 	int rc;
 
 	/* create send buffer */
+	if (is_smcd &&
+	    smc_ism_dmb_mappable(smc->conn.lgr->smcd))
+		goto create_rmb;
+
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
@@ -2473,6 +2499,49 @@ int smc_buf_create(struct smc_sock *smc, bool is_smcd)
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
+	/* The ghost sndbuf_desc describes the same memory region as
+	 * peer RMB. Its lifecycle is consistent with the connection's
+	 * and it will be freed with the connections instead of the
+	 * link group.
+	 */
+	rc = smc_ism_attach_dmb(smcd, peer_token, buf_desc);
+	if (rc)
+		goto free;
+
+	smc->sk.sk_sndbuf = buf_desc->len;
+	buf_desc->cpu_addr =
+		(u8 *)buf_desc->cpu_addr + sizeof(struct smcd_cdc_msg);
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
index 1f17537..d93cf51 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -557,6 +557,7 @@ void smc_smcd_terminate(struct smcd_dev *dev, struct smcd_gid *peer_gid,
 void smc_smcd_terminate_all(struct smcd_dev *dev);
 void smc_smcr_terminate_all(struct smc_ib_device *smcibdev);
 int smc_buf_create(struct smc_sock *smc, bool is_smcd);
+int smcd_buf_attach(struct smc_sock *smc);
 int smc_uncompress_bufsize(u8 compressed);
 int smc_rmb_rtoken_handling(struct smc_connection *conn, struct smc_link *link,
 			    struct smc_clc_msg_accept_confirm *clc);
-- 
1.8.3.1

