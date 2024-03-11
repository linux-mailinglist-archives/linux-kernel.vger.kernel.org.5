Return-Path: <linux-kernel+bounces-98988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDE88781F5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BECA3282E2F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E6240870;
	Mon, 11 Mar 2024 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ME9I65hw"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAE41E4A4;
	Mon, 11 Mar 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168455; cv=none; b=JuTunmowsRBjYBOx94XHhbhF2zpS2g1QG905O+71kGfo77Nbb0c+DqLVWNMJkNrFkWyPc9aT3QTvU2ARUjKLDjeH1iwOq7mWnKimiCZGRrkYbv+WPykU7PgdUE011kCczrROZtxm48NqoSNp/aJACyKBQ1GIwKc+HUSbWbjRiS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168455; c=relaxed/simple;
	bh=mQXbuf91ZGqc0/FW7JST9LvaYVs66Pk9EWKyVUxqaOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rt9EQGaTJbWLxvHZxD+CeKePsJ7AKUADiiv+r5qNA8UmJ1SbhMxkfPVrK/O2x1PsSzUO+FmQkIHtmzK8ujddBzvtnOX6O4d5NvIxNbUHd2beCL58JP6R5YPYtzD3hydLlVzcjmAb5V5s1SjltjYRhDlIvxw8vKjAjUtk3KcrrJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ME9I65hw; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9181120004;
	Mon, 11 Mar 2024 14:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710168451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HE2HlRBk0CBdOeSYlTEx7Aew3iPhhdjEpCgk9BsO9gQ=;
	b=ME9I65hwjLbO2WQWF9QhXRqs2ZIq/wUMSUiT6DcXHioA0Vn52PY+Kv5C4MEagpn0CBOzzN
	kEoDSOSWs23+4zjGB2edNFf+68spN5UiP0hyOamcAfDgULY60OoZWJSUcdFoU/xgrLSUg5
	xkwk5mJYoRsuwKvOd239R2mwZ/spHcUHrvz0M7I9YeE1RMgyVd+MmdWFaOS8kMi6sojsLw
	TzQB1Tdw9vhmtsJsINlCo5XiQ+GTPlJDC4qvigITzqTEQAEb5VjWPDfZjgfEMsfmpwcKYI
	reGN4+MzM2fAy2TqoKtCHUKaaoBlrgYoNdPYpVdSOjkV9QEENRM750PGgLVZKw==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v4 net-next] ptp: Move from simple ida to xarray
Date: Mon, 11 Mar 2024 15:47:29 +0100
Message-Id: <20240311144730.1239594-1-kory.maincent@bootlin.com>
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
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---

Change in v2:
- Update an err value missing.

Change in v3:
- Refactor err management.

Change in v4:
- Remove useless 0-init of err in ptp_clock_register.
- Use the right xarray header.
---
 drivers/ptp/ptp_clock.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 3aaf1a3430c5..dd024bb33426 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -4,7 +4,6 @@
  *
  * Copyright (C) 2010 OMICRON electronics GmbH
  */
-#include <linux/idr.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -16,6 +15,7 @@
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 #include <linux/debugfs.h>
+#include <linux/xarray.h>
 #include <uapi/linux/sched/types.h>
 
 #include "ptp_private.h"
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
 
@@ -233,7 +233,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 {
 	struct ptp_clock *ptp;
 	struct timestamp_event_queue *queue = NULL;
-	int err = 0, index, major = MAJOR(ptp_devt);
+	int err, index, major = MAJOR(ptp_devt);
 	char debugfsname[16];
 	size_t size;
 
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


