Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF70D7F53AD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344604AbjKVWrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344572AbjKVWri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:47:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90C9D40
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:47:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8338C433C8;
        Wed, 22 Nov 2023 22:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700693253;
        bh=tirI9jsS9I0Ud4YA2mWLBGFR/GeO4TdPnDgDvqDAWOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dHYYuw2Wf0mGECKQiIvqxUVhZPskvK0mCYfcFhSgc0GheH7K4LDEEx/OLTMgXZC6b
         dQRfBZQJEAiyh7mObHD9Z+6o+FgJuRXhzWT3+yzlzJOdlG+0oPL27TzHtMwsNifDXh
         FHRzr/VHPAErPKMr0Rn9jSrdRrTswxZyTyzUtrXDEMtuGcYKROKjBJlhE5SnI8W8ID
         Co8i1z550dK8PYv1WvnvxqTjIx274e0N4gL/9e5vz6si9j7+WlZy/Z4djJmXpl/H0D
         wCPmwHkR/mj/Ty3H36D5p3FunNWHvVlgf+icJrtHBlreSQJHpm3EVMyOiXlKzMU5tU
         VdoGWdkEuzk1Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-nvme@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] nvme: tcp: fix compile-time checks for TLS mode
Date:   Wed, 22 Nov 2023 23:47:19 +0100
Message-Id: <20231122224719.4042108-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231122224719.4042108-1-arnd@kernel.org>
References: <20231122224719.4042108-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_NVME_KEYRING is enabled as a loadable module, but the TCP
host code is built-in, it fails to link:

arm-linux-gnueabi-ld: drivers/nvme/host/tcp.o: in function `nvme_tcp_setup_ctrl':
tcp.c:(.text+0x1940): undefined reference to `nvme_tls_psk_default'

The problem is that the compile-time conditionals are inconsistent here,
using a mix of #ifdef CONFIG_NVME_TCP_TLS, IS_ENABLED(CONFIG_NVME_TCP_TLS)
and IS_ENABLED(CONFIG_NVME_KEYRING) checks, with CONFIG_NVME_KEYRING
controlling whether the implementation is actually built.

Change it to use IS_ENABLED(CONFIG_NVME_KEYRING) checks consistently,
which should help readability and make it less error-prone. Combining
it with the check for the ctrl->opts->tls flag lets the compiler drop
all the TLS code in configurations without this feature, which also
helps runtime behavior in addition to avoiding the link failure.

To make it possible for the compiler to build the dead code, both
the tls_handshake_timeout variable and the TLS specific members
of nvme_tcp_queue need to be moved out of the #ifdef block as well,
but at least the former of these gets optimized out again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvme/host/tcp.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 89661a9cf850..ee7aa8478cfb 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -36,11 +36,11 @@ static int so_priority;
 module_param(so_priority, int, 0644);
 MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
 
-#ifdef CONFIG_NVME_TCP_TLS
 /*
  * TLS handshake timeout
  */
 static int tls_handshake_timeout = 10;
+#ifdef CONFIG_NVME_TCP_TLS
 module_param(tls_handshake_timeout, int, 0644);
 MODULE_PARM_DESC(tls_handshake_timeout,
 		 "nvme TLS handshake timeout in seconds (default 10)");
@@ -161,10 +161,8 @@ struct nvme_tcp_queue {
 	struct ahash_request	*snd_hash;
 	__le32			exp_ddgst;
 	__le32			recv_ddgst;
-#ifdef CONFIG_NVME_TCP_TLS
 	struct completion       tls_complete;
 	int                     tls_err;
-#endif
 	struct page_frag_cache	pf_cache;
 
 	void (*state_change)(struct sock *);
@@ -207,6 +205,14 @@ static inline int nvme_tcp_queue_id(struct nvme_tcp_queue *queue)
 	return queue - queue->ctrl->queues;
 }
 
+static inline bool nvme_tcp_tls(struct nvme_ctrl *ctrl)
+{
+	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS))
+		return 0;
+
+	return ctrl->opts->tls;
+}
+
 static inline struct blk_mq_tags *nvme_tcp_tagset(struct nvme_tcp_queue *queue)
 {
 	u32 queue_idx = nvme_tcp_queue_id(queue);
@@ -1412,7 +1418,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	memset(&msg, 0, sizeof(msg));
 	iov.iov_base = icresp;
 	iov.iov_len = sizeof(*icresp);
-	if (queue->ctrl->ctrl.opts->tls) {
+	if (nvme_tcp_tls(&queue->ctrl->ctrl)) {
 		msg.msg_control = cbuf;
 		msg.msg_controllen = sizeof(cbuf);
 	}
@@ -1424,7 +1430,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 		goto free_icresp;
 	}
 	ret = -ENOTCONN;
-	if (queue->ctrl->ctrl.opts->tls) {
+	if (nvme_tcp_tls(&queue->ctrl->ctrl)) {
 		ctype = tls_get_record_type(queue->sock->sk,
 					    (struct cmsghdr *)cbuf);
 		if (ctype != TLS_RECORD_TYPE_DATA) {
@@ -1548,7 +1554,6 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
 }
 
-#ifdef CONFIG_NVME_TCP_TLS
 static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
 {
 	struct nvme_tcp_queue *queue = data;
@@ -1625,14 +1630,6 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	}
 	return ret;
 }
-#else
-static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
-			      struct nvme_tcp_queue *queue,
-			      key_serial_t pskid)
-{
-	return -EPROTONOSUPPORT;
-}
-#endif
 
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 				key_serial_t pskid)
@@ -1759,7 +1756,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	}
 
 	/* If PSKs are configured try to start TLS */
-	if (pskid) {
+	if (IS_ENABLED(CONFIG_NVME_TCP_TLS) && pskid) {
 		ret = nvme_tcp_start_tls(nctrl, queue, pskid);
 		if (ret)
 			goto err_init_connect;
@@ -1916,7 +1913,7 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 	int ret;
 	key_serial_t pskid = 0;
 
-	if (ctrl->opts->tls) {
+	if (nvme_tcp_tls(ctrl)) {
 		if (ctrl->opts->tls_key)
 			pskid = key_serial(ctrl->opts->tls_key);
 		else
@@ -1949,7 +1946,7 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
 	int i, ret;
 
-	if (ctrl->opts->tls && !ctrl->tls_key) {
+	if (nvme_tcp_tls(ctrl) && !ctrl->tls_key) {
 		dev_err(ctrl->device, "no PSK negotiated\n");
 		return -ENOKEY;
 	}
-- 
2.39.2

