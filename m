Return-Path: <linux-kernel+bounces-161280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEF78B4A0D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436E81C20A27
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 06:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767C652F83;
	Sun, 28 Apr 2024 06:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uPyM6bBH"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673CB4AED9;
	Sun, 28 Apr 2024 06:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714284496; cv=none; b=ZZBfCHMF8Lj4Tua668RmyX3PC/cVK2C4XAKSxCT5jcJ8Agl2ffKWVrhSFSkBp0Yo69GxTTJk525ipgojNVknpPhPE8WuEoBhUZbKZb2rMrqZsoDy6QjIaJCr7qHdnvxH95C0hlz8CUQkGE6X6YAmo0ll3YRgQwTWD2FCsqL99uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714284496; c=relaxed/simple;
	bh=dYVOZ5uv5kzjH64+MEFvDOxuaVg/4gd/nxDGY/qDbA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fjb6VfsmW5sx2lWK+aqBurbyvpjIIWl3olexlvqqwHFYSYI1eCXJip05JNhMZDIR8rsnpiCgXqqRnZD7lNu+8iD8Zmtg5eUqOCbov6x32ya0tirYN0kE6ptN2MMb8djEgE6uoUwnEtLLLdkPvfG5BlzYGo1fJ0PTGhi69EZ9tN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uPyM6bBH; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714284486; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Gi+M/EoleW0EgcdBRIvdzYOSiAW9UaYiBQlrK1/nYTE=;
	b=uPyM6bBH9xw4DrAEsvE0E4VAZIcJbo0WeIhGgPR1eBgsybOX7iVH9G4vzOPF66DhtpRNrNKnBB44tSTPuvr5ZULkDbwcfk7x3+SwfrL9BGuupM9SB0U4Dcw14l8jVswS0hu0YjMSkUgxDEQNQ2slCvHyI3116zJmg6lkcKr05sE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W5NS3H9_1714284483;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W5NS3H9_1714284483)
          by smtp.aliyun-inc.com;
          Sun, 28 Apr 2024 14:08:05 +0800
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
Subject: [PATCH net-next v7 10/11] net/smc: adapt cursor update when sndbuf and peer DMB are merged
Date: Sun, 28 Apr 2024 14:07:37 +0800
Message-Id: <20240428060738.60843-11-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240428060738.60843-1-guwen@linux.alibaba.com>
References: <20240428060738.60843-1-guwen@linux.alibaba.com>
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
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-and-tested-by: Jan Karcher <jaka@linux.ibm.com>
---
 net/smc/smc_cdc.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 3c06625ceb20..619b3bab3824 100644
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
+		return 0;
+
 	/* Calculate transmitted data and increment free send buffer space */
 	diff = smc_curs_diff(conn->sndbuf_desc->len, &conn->tx_curs_fin,
 			     &conn->tx_curs_sent);
@@ -266,7 +275,7 @@ int smcd_cdc_msg_send(struct smc_connection *conn)
 	smc_curs_copy(&conn->tx_curs_fin, &conn->tx_curs_sent, conn);
 
 	smc_tx_sndbuf_nonfull(smc);
-	return rc;
+	return 0;
 }
 
 /********************************* receive ***********************************/
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


