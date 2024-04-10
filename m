Return-Path: <linux-kernel+bounces-138701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C2B89F930
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01AD228D08B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D4116F0DF;
	Wed, 10 Apr 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D6AG8/Yz"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C992016DEDA;
	Wed, 10 Apr 2024 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757594; cv=none; b=FEd+S3qvP+ECHBMrSRPgtH+/m8lPRO5AI1KK3HsUGbdt8gE4w48N2xMU+v++YXrmfej57+ay/vWqe4UF2UewsUsuFUS6cwPCpgNM8/4y+271meVvmFdO/5MaPLNAZ4jzYKYddFqDNerLzZrKolW5sRzNQ4nwsO0W+g8koykHKh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757594; c=relaxed/simple;
	bh=R1WUXZH6NvJXZIW+AVDPYVj8JHUdfaLxcMfuJ+Z3tRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6jUIuTO6b0puTDbROy8dN6jhv4t+b68JOu7EiL6bLnAF8abUwAge5REf+70r9Tk+vBQ6zXaU3TxReJqOqhBsjustVdUgrK3F7rJADz0PQ2Nq/5sli2GpI7BxfoTKJaITo4oEWQvtvoBmOz8wJYtW7i3hg0Wru5boNqZSKTgjiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D6AG8/Yz; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43ADxlho024595;
	Wed, 10 Apr 2024 08:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712757587;
	bh=BSjhEIQgB4xQ5LpqF3Ho5CnJ8F2Hjtf+UQHpF8YH8Vg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=D6AG8/YzMJRYBsRYtEkYlGfs2CUP1EwG13PzGBjiQ0KWhmDs3GGCli5iC9GDjdV+i
	 27Del0igCuZt6CXm3MI0dbt14dvqbAmiv57fguluQQnSMmesCoUnFIO07E2Yliu+Xm
	 Q+l0GNmCmNGrLyUgIbioruDskJXtZEFdbSxvzLBE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43ADxlSW072427
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 08:59:47 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 08:59:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 08:59:47 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43ADxhaw067183;
	Wed, 10 Apr 2024 08:59:47 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH v2 12/13] mailbox: omap: Reverse FIFO busy check logic
Date: Wed, 10 Apr 2024 08:59:41 -0500
Message-ID: <20240410135942.61667-13-afd@ti.com>
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


