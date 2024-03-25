Return-Path: <linux-kernel+bounces-117582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF8788ACD5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DB51F63DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955041422D1;
	Mon, 25 Mar 2024 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rOsy2nDr"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570EF12C7FC;
	Mon, 25 Mar 2024 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387269; cv=none; b=rvPP9VVeg7KjNLu+veG2h/RqO2WGsrKNlDvm95CUbnGsY91CWGCQQebrQmy2yoEp9vh8MolvZMtgs9EbYAXRZNLVkGIghRB5F0nRBGXwKSsHJnDcwpUtvIQsWXlP5PueiCOs9JmQORi2eaMOjOHUSUUfOURJhbJDABxyH5/8524=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387269; c=relaxed/simple;
	bh=R1WUXZH6NvJXZIW+AVDPYVj8JHUdfaLxcMfuJ+Z3tRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnqe3l92jCKcmUnV9kWiwzqR5lalttocYS59/XrsyyNjSBvpShrQ3CNeopyg41yrkWtL6WbAGIeWYJnR0/CmShFSs2n5v/4yYgKywXTj1EuwidBKSZlnQpcTC/45+ve6suvn0TVOt6VsLZPQc2PnVjD3yuWJuj0hA2rJIOPMR84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rOsy2nDr; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKp1i022688;
	Mon, 25 Mar 2024 12:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711387251;
	bh=BSjhEIQgB4xQ5LpqF3Ho5CnJ8F2Hjtf+UQHpF8YH8Vg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=rOsy2nDr9AtpOwUuSJHc56xUGOrQhPzmnjEpqG3Bf2yYp+D470U4O6aqd0R4WEZiI
	 tYOOoR8nPCqO5nAYSdkq5+DPMe7Ja2A87wJcLwP4lsCnoYi4/MaVdetXtN7/r0Mbyi
	 fEHQqlu19xnTljca2iqUE73uyBcKyKNwSy0VAtus=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PHKpU8105045
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 12:20:51 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 12:20:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 12:20:51 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKkYi075282;
	Mon, 25 Mar 2024 12:20:50 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 12/13] mailbox: omap: Reverse FIFO busy check logic
Date: Mon, 25 Mar 2024 12:20:44 -0500
Message-ID: <20240325172045.113047-13-afd@ti.com>
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

It is much more clear to check if the hardware FIFO is full and return
EBUSY if true. This allows us to also remove one level of indention
from the core of this function. It also makes the similarities between
omap_mbox_chan_send_noirq() and omap_mbox_chan_send() more obvious.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 8e2760d2c5b0c..c5d4083125856 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -375,34 +375,33 @@ static void omap_mbox_chan_shutdown(struct mbox_chan *chan)
 
 static int omap_mbox_chan_send_noirq(struct omap_mbox *mbox, u32 msg)
 {
-	int ret = -EBUSY;
+	if (mbox_fifo_full(mbox))
+		return -EBUSY;
 
-	if (!mbox_fifo_full(mbox)) {
-		omap_mbox_enable_irq(mbox, IRQ_RX);
-		mbox_fifo_write(mbox, msg);
-		ret = 0;
-		omap_mbox_disable_irq(mbox, IRQ_RX);
+	omap_mbox_enable_irq(mbox, IRQ_RX);
+	mbox_fifo_write(mbox, msg);
+	omap_mbox_disable_irq(mbox, IRQ_RX);
 
-		/* we must read and ack the interrupt directly from here */
-		mbox_fifo_read(mbox);
-		ack_mbox_irq(mbox, IRQ_RX);
-	}
+	/* we must read and ack the interrupt directly from here */
+	mbox_fifo_read(mbox);
+	ack_mbox_irq(mbox, IRQ_RX);
 
-	return ret;
+	return 0;
 }
 
 static int omap_mbox_chan_send(struct omap_mbox *mbox, u32 msg)
 {
-	int ret = -EBUSY;
-
-	if (!mbox_fifo_full(mbox)) {
-		mbox_fifo_write(mbox, msg);
-		ret = 0;
+	if (mbox_fifo_full(mbox)) {
+		/* always enable the interrupt */
+		omap_mbox_enable_irq(mbox, IRQ_TX);
+		return -EBUSY;
 	}
 
+	mbox_fifo_write(mbox, msg);
+
 	/* always enable the interrupt */
 	omap_mbox_enable_irq(mbox, IRQ_TX);
-	return ret;
+	return 0;
 }
 
 static int omap_mbox_chan_send_data(struct mbox_chan *chan, void *data)
-- 
2.39.2


