Return-Path: <linux-kernel+bounces-138706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E253389F937
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBCF1C29036
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDC1171659;
	Wed, 10 Apr 2024 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XlTmcwf6"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3628416E88F;
	Wed, 10 Apr 2024 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757595; cv=none; b=mJ8XZ25Piu+WcgVeQDuJK4XsdUoEzPQWU9J6y72eQ0cICZMjgSwrlursskMbl5vPPOOgFOFQ0baLi9RuOhOrGrGT3TlamxqFxSVtju+w3OodOaNt1Gv6uFZxj6H2rsAnCz/weqgbQimyFfca9uQJ2Ri6U0+UUszjhQd2yvUeYgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757595; c=relaxed/simple;
	bh=/5bhpjeazwlvZ3hJGomrgefM1rAHoqOK4j10YLbq5Vw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLcJlutQFIB+z2ZWGdBDdOT19CO/9Zx+lLdVzs5kpMUVWX8OqyW2z2po11QoTbEWz7/PWYaVKxFEGm20ICC4Iou3zwFH8rwuKvySO/l5NRLtA+KI34vtkJvVwTXSJ7rx4z6LgO2uvTCcMk+N8qsrMJo0su3dBR2+PrThVvPC5/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XlTmcwf6; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43ADxju0067933;
	Wed, 10 Apr 2024 08:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712757585;
	bh=oMpPV8zNvq5esbarJKEFc3uZfciTRaGsILmKJ6oGFvE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XlTmcwf6y5zkStFb3IkU/FDddaPLWKsefhgGCU8SFegRrlaM/es+rwPzHahgGw594
	 F5DMq1tZHNJTyULw1QYSxXlIYJ8HQLlDlxC1izi1dySaO0drK/46nhWBX/u3L1g2A4
	 udneHfXewNGXmaT2bBL9XjSrrEsUr9FpSo9ohOgg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43ADxjai011492
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 08:59:45 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 08:59:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 08:59:45 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43ADxhap067183;
	Wed, 10 Apr 2024 08:59:45 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH v2 05/13] mailbox: omap: Remove unneeded header omap-mailbox.h
Date: Wed, 10 Apr 2024 08:59:34 -0500
Message-ID: <20240410135942.61667-6-afd@ti.com>
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

The type of message sent using omap-mailbox is always u32. The definition
of mbox_msg_t is uintptr_t which is wrong as that type changes based on
the architecture (32bit vs 64bit). This type should have been defined as
u32. Instead of making that change here, simply remove the header usage
and fix the last couple users of the same in this driver.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 167348fb1b33b..4c673cb732ed1 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -19,7 +19,6 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/omap-mailbox.h>
 #include <linux/mailbox_controller.h>
 #include <linux/mailbox_client.h>
 
@@ -239,16 +238,14 @@ static void mbox_rx_work(struct work_struct *work)
 {
 	struct omap_mbox_queue *mq =
 			container_of(work, struct omap_mbox_queue, work);
-	mbox_msg_t data;
 	u32 msg;
 	int len;
 
 	while (kfifo_len(&mq->fifo) >= sizeof(msg)) {
 		len = kfifo_out(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
 		WARN_ON(len != sizeof(msg));
-		data = msg;
 
-		mbox_chan_received_data(mq->mbox->chan, (void *)data);
+		mbox_chan_received_data(mq->mbox->chan, (void *)(uintptr_t)msg);
 		spin_lock_irq(&mq->lock);
 		if (mq->full) {
 			mq->full = false;
@@ -515,7 +512,7 @@ static int omap_mbox_chan_send_data(struct mbox_chan *chan, void *data)
 {
 	struct omap_mbox *mbox = mbox_chan_to_omap_mbox(chan);
 	int ret;
-	u32 msg = omap_mbox_message(data);
+	u32 msg = (u32)(uintptr_t)(data);
 
 	if (!mbox)
 		return -EINVAL;
-- 
2.39.2


