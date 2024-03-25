Return-Path: <linux-kernel+bounces-117573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEA388ADF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA70CB65E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A77886AC0;
	Mon, 25 Mar 2024 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FIM1iRfN"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F86083A19;
	Mon, 25 Mar 2024 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387254; cv=none; b=hrCnPpdLObW+i6ezvr8TE2Z5QYWH5GXy/DMF5kdGw53laYgUpifisHnHOECYTTz4IaYBRJPsm5eaEfY+MERY6TjFaCJZix7D8YNez6PFqHmdUsXPiNm1zeO3eOwvROl76ZIwTyJIsfC3fktnmoNN+c+R6Iu68Cx89xK8K1ZhtQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387254; c=relaxed/simple;
	bh=/5bhpjeazwlvZ3hJGomrgefM1rAHoqOK4j10YLbq5Vw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDoBdGBJ0bV+OZmZ3JMIJtxnh4of3WlE0Mo7/A/ipDBor300CHeTnXDdSXdC0z/rck3kBxILyTBqhRPGys5qv85tgUAVT9+lNw85q84wEI+0tQPN8gOZe4E1/9lhc+jDlnWtusDBzQA3jS/BpyKr7gwmi4UFwpN9R1gzTKuuKjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FIM1iRfN; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKml7061076;
	Mon, 25 Mar 2024 12:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711387248;
	bh=oMpPV8zNvq5esbarJKEFc3uZfciTRaGsILmKJ6oGFvE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FIM1iRfNUUFsovQyEoHgilVidR8oDOySd5qGlosvYvIq1x7Lxwp0WZRnoGl8UpQGz
	 i6JdMX2HSFLE+2DAz+yV8SFacYyHcUV7YKGQ07EIbvu2o/IvTjzMfj4msW+JPVvCLj
	 5Lso4V1uvMfXNSJzaW7LxhGFFPdgTrqFKdEd8w7g=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PHKmaj042969
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 12:20:48 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 12:20:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 12:20:48 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKkYb075282;
	Mon, 25 Mar 2024 12:20:48 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 05/13] mailbox: omap: Remove unneeded header omap-mailbox.h
Date: Mon, 25 Mar 2024 12:20:37 -0500
Message-ID: <20240325172045.113047-6-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325172045.113047-1-afd@ti.com>
References: <20240325172045.113047-1-afd@ti.com>
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


