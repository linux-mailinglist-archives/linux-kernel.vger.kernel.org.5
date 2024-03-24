Return-Path: <linux-kernel+bounces-112695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE52887D11
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79DAF1F21492
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B3525543;
	Sun, 24 Mar 2024 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YaGzzEEY"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D60F22630;
	Sun, 24 Mar 2024 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711288551; cv=none; b=pTuyXPIvh10d+F4ojL1WcJIhJGnd+mPkZv2qA0s1LOcENSy/WNnp74zADRhoFhh5ayxds2qEoCV633xRgPYN9t9W33cP+VDy6fq0fwb5XLkNAJ2+PMkCxcJF666WaSYMNj0Ydut71YwKbNXuwouD9/QxhLK0hs/WnLm9jefRRm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711288551; c=relaxed/simple;
	bh=MMNxnhVXiuvL/v2wl7ftONrloXMRBH7Ks6z0vtQ0bmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MK8lQOzOFdTrJ5/5uF52TuqqQLdsJ3LlFz4JP9wAI8up9w7Ju9N2OTM7kO6571SXDUcGjClauGCXcu5KHLpVxutE0IruI0vQLZ4FELD4F8ohMNI9ISOaMraVQf4Vxs4NxVC0gvZNjHZ+SPGBo4c2KCw9zwtACBOLobG5f2VlXwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YaGzzEEY; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711288547; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9qAgp4/Q2G47rGp9yB613ewCTZswLcW3m9wyY7yp0hU=;
	b=YaGzzEEYuv7YQ4m0yldNhkVqSxW3ZJ/fm8cm6Lm34mNANEaa85vt7Bw+vmQOJIrTuyW5Ym+6bIiSyMGv88P+U3n8GUScmsI1f5ySWWVmJqWjtR7v9P3neootvvTZajSydwONngNz5Dugi8loPoeqeQKsvmOcst4LdDYxHD5eFos=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W372W8q_1711288544;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W372W8q_1711288544)
          by smtp.aliyun-inc.com;
          Sun, 24 Mar 2024 21:55:46 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	twinkler@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH net-next v5 09/11] net/smc: {at|de}tach sndbuf to peer DMB if supported
Date: Sun, 24 Mar 2024 21:55:20 +0800
Message-Id: <20240324135522.108564-10-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240324135522.108564-1-guwen@linux.alibaba.com>
References: <20240324135522.108564-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the device used by SMC-D supports merging local sndbuf to peer DMB,
then create sndbuf descriptor and attach it to peer DMB once peer
token is obtained, and detach and free the sndbuf descriptor when the
connection is freed.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/af_smc.c   | 16 ++++++++++++
 net/smc/smc_core.c | 61 +++++++++++++++++++++++++++++++++++++++++++++-
 net/smc/smc_core.h |  1 +
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 751a8fdd6eb0..fce7a5b2ce5c 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1438,6 +1438,14 @@ static int smc_connect_ism(struct smc_sock *smc,
 	}
 
 	smc_conn_save_peer_info(smc, aclc);
+
+	if (smc_ism_support_dmb_nocopy(smc->conn.lgr->smcd)) {
+		rc = smcd_buf_attach(smc);
+		if (rc) {
+			rc = SMC_CLC_DECL_MEM;	/* try to fallback */
+			goto connect_abort;
+		}
+	}
 	smc_close_init(smc);
 	smc_rx_init(smc);
 	smc_tx_init(smc);
@@ -2542,6 +2550,14 @@ static void smc_listen_work(struct work_struct *work)
 		mutex_unlock(&smc_server_lgr_pending);
 	}
 	smc_conn_save_peer_info(new_smc, cclc);
+
+	if (ini->is_smcd &&
+	    smc_ism_support_dmb_nocopy(new_smc->conn.lgr->smcd)) {
+		rc = smcd_buf_attach(new_smc);
+		if (rc)
+			goto out_decl;
+	}
+
 	smc_listen_out_connected(new_smc);
 	SMC_STAT_SERV_SUCC_INC(sock_net(newclcsock->sk), ini);
 	goto out_free;
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 9b84d5897aa5..fafdb97adfad 100644
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
+		if (smc_ism_support_dmb_nocopy(lgr->smcd))
+			smcd_buf_detach(conn);
 		tasklet_kill(&conn->rx_tsklet);
 	} else {
 		smc_cdc_wait_pend_tx_wr(conn);
@@ -1445,6 +1461,8 @@ static void smc_conn_kill(struct smc_connection *conn, bool soft)
 	smc_sk_wake_ups(smc);
 	if (conn->lgr->is_smcd) {
 		smc_ism_unset_conn(conn);
+		if (smc_ism_support_dmb_nocopy(conn->lgr->smcd))
+			smcd_buf_detach(conn);
 		if (soft)
 			tasklet_kill(&conn->rx_tsklet);
 		else
@@ -2464,12 +2482,18 @@ int smc_buf_create(struct smc_sock *smc, bool is_smcd)
 	int rc;
 
 	/* create send buffer */
+	if (is_smcd &&
+	    smc_ism_support_dmb_nocopy(smc->conn.lgr->smcd))
+		goto create_rmb;
+
 	rc = __smc_buf_create(smc, is_smcd, false);
 	if (rc)
 		return rc;
+
+create_rmb:
 	/* create rmb */
 	rc = __smc_buf_create(smc, is_smcd, true);
-	if (rc) {
+	if (rc && smc->conn.sndbuf_desc) {
 		down_write(&smc->conn.lgr->sndbufs_lock);
 		list_del(&smc->conn.sndbuf_desc->list);
 		up_write(&smc->conn.lgr->sndbufs_lock);
@@ -2479,6 +2503,41 @@ int smc_buf_create(struct smc_sock *smc, bool is_smcd)
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
+	kfree(buf_desc);
+	return rc;
+}
+
 static inline int smc_rmb_reserve_rtoken_idx(struct smc_link_group *lgr)
 {
 	int i;
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 1f175376037b..d93cf51dbd7c 100644
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
2.32.0.3.g01195cf9f


