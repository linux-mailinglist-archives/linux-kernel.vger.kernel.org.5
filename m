Return-Path: <linux-kernel+bounces-138698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD35089F925
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3A71C27048
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F98D16E86F;
	Wed, 10 Apr 2024 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PaHPCmp0"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF27E16D9CA;
	Wed, 10 Apr 2024 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757592; cv=none; b=DfrTL6npkQ959fUFXzz47S5PDFe5cjov6FMnIoFl6+SOXaZNs6BZ9aFesu7qccrxFUrOObBT22AXcWnbtQ2juKeS8DwIshOVKLE62IOFCcoaZcggA5pBwb4C5h7ea964uXqDDqRopQd6auP9YUimfe/yfC5+SSSczXw5YiKxgHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757592; c=relaxed/simple;
	bh=+4mYsDwEIK4ZWqyyDgyiPzXKtR3LJEx4RZaVrdGLE0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MehUJm8GJmBbsQgUhEFPjbLGXl09aoEBzP16Ynvg7SWMSlk60uEaE1I5X2iQkOoNfDO1hOCa8u+2cj0EDY3quZhr3Y74TTuPVMMVx0UyDlKfTjYFkwuYPW5ng5TxPznyYa8/cqP8gzN1cU2sUkA4aOJQbn2zNKQDklQ5ou65BhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PaHPCmp0; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43ADxjYL024573;
	Wed, 10 Apr 2024 08:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712757585;
	bh=LRIF3E/X3Th7qLH/f1ml5/H5LIqNgItmvNfm9KSSj1I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PaHPCmp0vWk96rryVw3LARH9hXjb6Zud9xZiem+tgOWQy1N1HeYThY8pQMp1rKy7u
	 TTJNWkMJcFxkF5hMV4FO2poJgpoGljd+U9SE5tArZi0zwWik/ATECTc9tjenPiudLn
	 IQDnaFwQVYQV+hVoUFMJy39VXEJLsp/FEzPnZ1HA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43ADxjtd020060
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 08:59:45 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 08:59:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 08:59:45 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43ADxhao067183;
	Wed, 10 Apr 2024 08:59:44 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH v2 04/13] mailbox: omap: Move fifo size check to point of use
Date: Wed, 10 Apr 2024 08:59:33 -0500
Message-ID: <20240410135942.61667-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410135942.61667-1-afd@ti.com>
References: <20240410135942.61667-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The mbox_kfifo_size can be changed at runtime, the sanity
check on it's value should be done when it is used, not
only once at init time.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index c083734b6954c..167348fb1b33b 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -310,6 +310,7 @@ static struct omap_mbox_queue *mbox_queue_alloc(struct omap_mbox *mbox,
 					void (*work)(struct work_struct *))
 {
 	struct omap_mbox_queue *mq;
+	unsigned int size;
 
 	if (!work)
 		return NULL;
@@ -320,7 +321,10 @@ static struct omap_mbox_queue *mbox_queue_alloc(struct omap_mbox *mbox,
 
 	spin_lock_init(&mq->lock);
 
-	if (kfifo_alloc(&mq->fifo, mbox_kfifo_size, GFP_KERNEL))
+	/* kfifo size sanity check: alignment and minimal size */
+	size = ALIGN(mbox_kfifo_size, sizeof(u32));
+	size = max_t(unsigned int, size, sizeof(u32));
+	if (kfifo_alloc(&mq->fifo, size, GFP_KERNEL))
 		goto error;
 
 	INIT_WORK(&mq->work, work);
@@ -838,10 +842,6 @@ static int __init omap_mbox_init(void)
 	if (err)
 		return err;
 
-	/* kfifo size sanity check: alignment and minimal size */
-	mbox_kfifo_size = ALIGN(mbox_kfifo_size, sizeof(u32));
-	mbox_kfifo_size = max_t(unsigned int, mbox_kfifo_size, sizeof(u32));
-
 	err = platform_driver_register(&omap_mbox_driver);
 	if (err)
 		class_unregister(&omap_mbox_class);
-- 
2.39.2


