Return-Path: <linux-kernel+bounces-112698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ABD887D1A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19DA281739
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDAE381D0;
	Sun, 24 Mar 2024 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eZHWjYjW"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C1E374FC;
	Sun, 24 Mar 2024 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711288559; cv=none; b=n+Cp9xa4yLzzSHSrwvUBD6Y3cNeFLV9wchTcDPAIaAlklXlmvzU/ims0hgTQJTSdj9Z08U2UqnJUfXzWFB+Y38GYP3T7/BLIKhqWRBP/2TJ5CPfUpsc5nUTYlW+g5mV5N4Dnd2TzjG0thaArOJ/pB5KiBgx1F/bOgfm9jBltx54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711288559; c=relaxed/simple;
	bh=+l8zWQElahWaPkmyYvk6aEolLdDlyQu2GF741usRILk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TLgiDfQLgAYQBXM+vNAyo1S3c8lVWguHgjI5Wlx1xhWHRunrFfo/DgQCKus6ydTt+TggShM7Vrk0c6W3bGsIRjiNKIcd0u1imN7o0N5iEsrjWWqPNro6TRCMRMrJO/IWRyAK52iB0MG+RhIoLn22VDLvtlAdbylEg/4Y/C9ndb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eZHWjYjW; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711288549; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Nb2nmxeq5eLGuWB1JKOUkoCi1VXxe+Li0Jy9GmclvdY=;
	b=eZHWjYjWUOHM4FvD6iXM8ZEJkAtsdeUUOHiLVi1jYjI2kDBhzqgNzGwuNkjo6Gmi81SdneEc/z01KcOCfesJqZtKeFDO1KjqOL+qercMr2v0oUIKE3D9XuIeCZ3Nu5bmBlqhFtiN/D4dx8vFuRQGfYYclncOBB1j5qDg1oCY63s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W373cto_1711288546;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W373cto_1711288546)
          by smtp.aliyun-inc.com;
          Sun, 24 Mar 2024 21:55:48 +0800
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
Subject: [RFC PATCH net-next v5 10/11] net/smc: adapt cursor update when sndbuf and peer DMB are merged
Date: Sun, 24 Mar 2024 21:55:21 +0800
Message-Id: <20240324135522.108564-11-guwen@linux.alibaba.com>
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

If the local sndbuf shares the same physical memory with peer DMB,
the cursor update processing needs to be adapted to ensure that the
data to be consumed won't be overwritten.

So in this case, the fin_curs and sndbuf_space that were originally
updated after sending the CDC message should be modified to not be
update until the peer updates cons_curs.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_cdc.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 3c06625ceb20..5e95347ae497 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -18,6 +18,7 @@
 #include "smc_tx.h"
 #include "smc_rx.h"
 #include "smc_close.h"
+#include "smc_ism.h"
 
 /********************************** send *************************************/
 
@@ -255,6 +256,14 @@ int smcd_cdc_msg_send(struct smc_connection *conn)
 		return rc;
 	smc_curs_copy(&conn->rx_curs_confirmed, &curs, conn);
 	conn->local_rx_ctrl.prod_flags.cons_curs_upd_req = 0;
+
+	if (smc_ism_support_dmb_nocopy(conn->lgr->smcd))
+		/* if local sndbuf shares the same memory region with
+		 * peer DMB, then don't update the tx_curs_fin
+		 * and sndbuf_space until peer has consumed the data.
+		 */
+		return rc;
+
 	/* Calculate transmitted data and increment free send buffer space */
 	diff = smc_curs_diff(conn->sndbuf_desc->len, &conn->tx_curs_fin,
 			     &conn->tx_curs_sent);
@@ -323,7 +332,7 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 {
 	union smc_host_cursor cons_old, prod_old;
 	struct smc_connection *conn = &smc->conn;
-	int diff_cons, diff_prod;
+	int diff_cons, diff_prod, diff_tx;
 
 	smc_curs_copy(&prod_old, &conn->local_rx_ctrl.prod, conn);
 	smc_curs_copy(&cons_old, &conn->local_rx_ctrl.cons, conn);
@@ -339,6 +348,29 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 		atomic_add(diff_cons, &conn->peer_rmbe_space);
 		/* guarantee 0 <= peer_rmbe_space <= peer_rmbe_size */
 		smp_mb__after_atomic();
+
+		/* if local sndbuf shares the same memory region with
+		 * peer RMB, then update tx_curs_fin and sndbuf_space
+		 * here since peer has already consumed the data.
+		 */
+		if (conn->lgr->is_smcd &&
+		    smc_ism_support_dmb_nocopy(conn->lgr->smcd)) {
+			/* Calculate consumed data and
+			 * increment free send buffer space.
+			 */
+			diff_tx = smc_curs_diff(conn->sndbuf_desc->len,
+						&conn->tx_curs_fin,
+						&conn->local_rx_ctrl.cons);
+			/* increase local sndbuf space and fin_curs */
+			smp_mb__before_atomic();
+			atomic_add(diff_tx, &conn->sndbuf_space);
+			/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
+			smp_mb__after_atomic();
+			smc_curs_copy(&conn->tx_curs_fin,
+				      &conn->local_rx_ctrl.cons, conn);
+
+			smc_tx_sndbuf_nonfull(smc);
+		}
 	}
 
 	diff_prod = smc_curs_diff(conn->rmb_desc->len, &prod_old,
-- 
2.32.0.3.g01195cf9f


