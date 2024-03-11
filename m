Return-Path: <linux-kernel+bounces-98929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C9887811E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1194F288FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543443FB3E;
	Mon, 11 Mar 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MFXVQPP2"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E385F3F9F8;
	Mon, 11 Mar 2024 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165594; cv=none; b=K5MVteW33HSGOYH6C308IOBetAmjKiGUDahiuqKRxGkVbffLOutyxJDYkF6NFmGcpZCKG8C59mC4QHm2CUapApo603lN2Dr8xnrpC7XFJDrCX+E4P4Jjd7DiIaN7A8+y5StDiY8VvdosrMmcBM0u22AvvlRNs/M8p2FJySHMwZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165594; c=relaxed/simple;
	bh=w0U72Ycmq844X9KX4KpHGr0JX6G/1oC6LAYxW4A8Lyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ny2ENuNSvRfv3G/C0jXyJV8KXp7YFbVY+OuEJ6sDfYV8Tf/Mxw99HaT5I6wT1pI4ZDiOZz5ehRvjDnDKrD0jgpmDBXb19sgdq7iHInJZqi0CVTvLfg9QsiQZtGgoRX7RzoTy3OkMEz/ICNLpW8nTN5RU9S+w4li1fX8TQjMZP2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MFXVQPP2; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 937C5E000E;
	Mon, 11 Mar 2024 13:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710165590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BIqCSEXEHAQQ7uGBrLNSPsM/8U6DguluqZGvnINBf78=;
	b=MFXVQPP2fSaleun8lVC/lcWcQXSTFneu2IzH5/ZmYQDKRBhqifKx9mDV1UccOtdvroDLNa
	zG3nKJB2tQ6zPUSLKa3J54cQVjDPkynHr1bzmfC4Ih/CpTnzL8OZAINZqNjoJOoV+EXmMZ
	tw82OAkNvSwHCLze3Q3rwmQS1M9rVCw4rK+OmbGDoUzHuJDkwqqNAOgQ0tdIu5BgdcOzaJ
	lKllUEF9dhqg80plRlrQKfGhbGRsm7uuyFlTxmkjfxK+KOI/8o/F/nBhTAIsvYn5LA40aU
	XHHbi+f+HXqYXYksLO61LcmHNj37YdROpdynr088rxQsSdvRyBB9jy0jZHA0jQ==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v3 net-next] ptp: Move from simple ida to xarray
Date: Mon, 11 Mar 2024 14:59:47 +0100
Message-Id: <20240311135949.1180157-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

Move from simple ida to xarray for storing and loading the ptp_clock
pointer. This prepares support for future hardware timestamp selection by
being able to link the ptp clock index to its pointer.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v2:
- Update an err value missing.

Change in v3:
- Refactor err management.
---
 drivers/ptp/ptp_clock.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 3aaf1a3430c5..8eebf1373ca3 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -31,7 +31,7 @@ struct class *ptp_class;
 
 static dev_t ptp_devt;
 
-static DEFINE_IDA(ptp_clocks_map);
+static DEFINE_XARRAY_ALLOC(ptp_clocks_map);
 
 /* time stamp event queue operations */
 
@@ -201,7 +201,7 @@ static void ptp_clock_release(struct device *dev)
 	bitmap_free(tsevq->mask);
 	kfree(tsevq);
 	debugfs_remove(ptp->debugfs_root);
-	ida_free(&ptp_clocks_map, ptp->index);
+	xa_erase(&ptp_clocks_map, ptp->index);
 	kfree(ptp);
 }
 
@@ -241,16 +241,16 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 		return ERR_PTR(-EINVAL);
 
 	/* Initialize a clock structure. */
-	err = -ENOMEM;
 	ptp = kzalloc(sizeof(struct ptp_clock), GFP_KERNEL);
-	if (ptp == NULL)
+	if (!ptp) {
+		err = -ENOMEM;
 		goto no_memory;
+	}
 
-	index = ida_alloc_max(&ptp_clocks_map, MINORMASK, GFP_KERNEL);
-	if (index < 0) {
-		err = index;
+	err = xa_alloc(&ptp_clocks_map, &index, ptp, xa_limit_31b,
+		       GFP_KERNEL);
+	if (err)
 		goto no_slot;
-	}
 
 	ptp->clock.ops = ptp_clock_ops;
 	ptp->info = info;
@@ -258,13 +258,17 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	ptp->index = index;
 	INIT_LIST_HEAD(&ptp->tsevqs);
 	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
-	if (!queue)
+	if (!queue) {
+		err = -ENOMEM;
 		goto no_memory_queue;
+	}
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
 	spin_lock_init(&ptp->tsevqs_lock);
 	queue->mask = bitmap_alloc(PTP_MAX_CHANNELS, GFP_KERNEL);
-	if (!queue->mask)
+	if (!queue->mask) {
+		err = -ENOMEM;
 		goto no_memory_bitmap;
+	}
 	bitmap_set(queue->mask, 0, PTP_MAX_CHANNELS);
 	spin_lock_init(&queue->lock);
 	mutex_init(&ptp->pincfg_mux);
@@ -378,7 +382,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	list_del(&queue->qlist);
 	kfree(queue);
 no_memory_queue:
-	ida_free(&ptp_clocks_map, index);
+	xa_erase(&ptp_clocks_map, index);
 no_slot:
 	kfree(ptp);
 no_memory:
@@ -511,7 +515,7 @@ static void __exit ptp_exit(void)
 {
 	class_destroy(ptp_class);
 	unregister_chrdev_region(ptp_devt, MINORMASK + 1);
-	ida_destroy(&ptp_clocks_map);
+	xa_destroy(&ptp_clocks_map);
 }
 
 static int __init ptp_init(void)
-- 
2.25.1


