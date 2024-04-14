Return-Path: <linux-kernel+bounces-143965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9739E8A4024
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A001C2108C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E007E2E657;
	Sun, 14 Apr 2024 04:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bA6RFt7V"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED823748;
	Sun, 14 Apr 2024 04:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713067413; cv=none; b=NmfNjHmxYtHDSMpX+lXcySbUAISmDjos8tVlgKTwomObvADlp9mszFswJlWVDfxzPOuP9sC++NmQ65sUF0SDbakIjVB3FpaMzzKozLCkAQ5wn78etEhGTAUb+vN2i+wu0jeDC69/j6UCOn/TghZYFjYDEmRJn1wwdw9C0iw2AUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713067413; c=relaxed/simple;
	bh=+l8zWQElahWaPkmyYvk6aEolLdDlyQu2GF741usRILk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nj+MzwRNvd8BTTaB1/1yqTUsKA+lrsUKSWdTg5QapgROogIBed4gA6w0qyjsx4YABrmI1t3YiadKzqIYxPUz+EAnG6ZtrGpF7XHsnrvpYuk+BW3YJmGxgmr9W9lIiFSyQ7kx7HeCB2xhJc5daAPptF1+iCPh7j2bX31iFby8pL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bA6RFt7V; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713067408; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Nb2nmxeq5eLGuWB1JKOUkoCi1VXxe+Li0Jy9GmclvdY=;
	b=bA6RFt7VvXoGzXqERbqQwMVC1sKSJ6nFdGgFq16ale+KJcvWQNkhI7KABsbvj6hltUo9c/nR51sG+R2WOF/jKxHSQtib2L3Jbsn7r/3gW9hb0lWyibKJ3fUhPKbF7I9+oiNcZKLNPrY06dM/B/lRjB3uDgSNlnVleijxYifaBzI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W4Ru4ZW_1713067406;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W4Ru4ZW_1713067406)
          by smtp.aliyun-inc.com;
          Sun, 14 Apr 2024 12:03:27 +0800
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
Subject: [PATCH net-next v6 10/11] net/smc: adapt cursor update when sndbuf and peer DMB are merged
Date: Sun, 14 Apr 2024 12:03:03 +0800
Message-Id: <20240414040304.54255-11-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240414040304.54255-1-guwen@linux.alibaba.com>
References: <20240414040304.54255-1-guwen@linux.alibaba.com>
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


