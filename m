Return-Path: <linux-kernel+bounces-117577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D382988ACC8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E12D1F672E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D29312A140;
	Mon, 25 Mar 2024 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UFP9Q43o"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5EC83CD2;
	Mon, 25 Mar 2024 17:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387256; cv=none; b=mzbO/4cHtcEuEC6Jdlj6k4c6xag5PfN+mRWGuuO+XlOo/jOCFsaLAem/fnAi/am69T3O5dBW5as2jaRoTnz3p+t1bW9lLCpkaOP1QT7Hmun8lvpm8SkNHh0Q9qxaAb67bSn9NJn+2gRudYRfKKw8jKazmVttEpVf53AL6xRNBvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387256; c=relaxed/simple;
	bh=zlC9cmbZex2kU3z2t34335SHHvORlHukunlnmr6Zhjs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/CcybS8Bfmupplb0t52JsF5kWwgu/CkQomchcMAUrwlYHRly+dVUmkS5dECk3hbqx1dhqWlHnYGwoE6VXQy9OTHgtbJ6oS1j7Z6b8LsScUrJWb37SYZnQFEwxH7QUc8WWp1U7JxY7dwwjpM6iYj34shwtioaXZ+gUI2X/ngaos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UFP9Q43o; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKljh040376;
	Mon, 25 Mar 2024 12:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711387247;
	bh=jAM4nFkXipG4XRsuPLTJ3QnvHadEFnkHENwAkOMzu3c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=UFP9Q43oN4ubfEnoqjJbVW2M2hqLGwD8BgSH8qpZU6ffirZQvzTgag2m3to9pGFuJ
	 k9Z2+DxEwP9WHtdmpSyUMvynZ60Aa2qSvZuwoOLATbKb65RdEon3ZRYdmdWYW+1JpQ
	 h0Gw3y+Mi+9fyNtz2qVZ9OKBgjZ+9t9lZ3zYlyuM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PHKlQs089647
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 12:20:47 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 12:20:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 12:20:47 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKkYX075282;
	Mon, 25 Mar 2024 12:20:46 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 01/13] mailbox: omap: Remove unused omap_mbox_{enable,disable}_irq() functions
Date: Mon, 25 Mar 2024 12:20:33 -0500
Message-ID: <20240325172045.113047-2-afd@ti.com>
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

These function are not used, remove these here.

While here, remove the leading _ from the driver internal functions that
do the same thing as the functions removed.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 42 ++++++++--------------------------
 include/linux/omap-mailbox.h   |  3 ---
 2 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index c961706fe61d5..624a7ccc27285 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -197,7 +197,7 @@ static int is_mbox_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 	return (int)(enable & status & bit);
 }
 
-static void _omap_mbox_enable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
+static void omap_mbox_enable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
 	u32 l;
 	struct omap_mbox_fifo *fifo = (irq == IRQ_TX) ?
@@ -210,7 +210,7 @@ static void _omap_mbox_enable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 	mbox_write_reg(mbox->parent, l, irqenable);
 }
 
-static void _omap_mbox_disable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
+static void omap_mbox_disable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
 	struct omap_mbox_fifo *fifo = (irq == IRQ_TX) ?
 				&mbox->tx_fifo : &mbox->rx_fifo;
@@ -227,28 +227,6 @@ static void _omap_mbox_disable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 	mbox_write_reg(mbox->parent, bit, irqdisable);
 }
 
-void omap_mbox_enable_irq(struct mbox_chan *chan, omap_mbox_irq_t irq)
-{
-	struct omap_mbox *mbox = mbox_chan_to_omap_mbox(chan);
-
-	if (WARN_ON(!mbox))
-		return;
-
-	_omap_mbox_enable_irq(mbox, irq);
-}
-EXPORT_SYMBOL(omap_mbox_enable_irq);
-
-void omap_mbox_disable_irq(struct mbox_chan *chan, omap_mbox_irq_t irq)
-{
-	struct omap_mbox *mbox = mbox_chan_to_omap_mbox(chan);
-
-	if (WARN_ON(!mbox))
-		return;
-
-	_omap_mbox_disable_irq(mbox, irq);
-}
-EXPORT_SYMBOL(omap_mbox_disable_irq);
-
 /*
  * Message receiver(workqueue)
  */
@@ -269,7 +247,7 @@ static void mbox_rx_work(struct work_struct *work)
 		spin_lock_irq(&mq->lock);
 		if (mq->full) {
 			mq->full = false;
-			_omap_mbox_enable_irq(mq->mbox, IRQ_RX);
+			omap_mbox_enable_irq(mq->mbox, IRQ_RX);
 		}
 		spin_unlock_irq(&mq->lock);
 	}
@@ -280,7 +258,7 @@ static void mbox_rx_work(struct work_struct *work)
  */
 static void __mbox_tx_interrupt(struct omap_mbox *mbox)
 {
-	_omap_mbox_disable_irq(mbox, IRQ_TX);
+	omap_mbox_disable_irq(mbox, IRQ_TX);
 	ack_mbox_irq(mbox, IRQ_TX);
 	mbox_chan_txdone(mbox->chan, 0);
 }
@@ -293,7 +271,7 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 
 	while (!mbox_fifo_empty(mbox)) {
 		if (unlikely(kfifo_avail(&mq->fifo) < sizeof(msg))) {
-			_omap_mbox_disable_irq(mbox, IRQ_RX);
+			omap_mbox_disable_irq(mbox, IRQ_RX);
 			mq->full = true;
 			goto nomem;
 		}
@@ -375,7 +353,7 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 	if (mbox->send_no_irq)
 		mbox->chan->txdone_method = TXDONE_BY_ACK;
 
-	_omap_mbox_enable_irq(mbox, IRQ_RX);
+	omap_mbox_enable_irq(mbox, IRQ_RX);
 
 	return 0;
 
@@ -386,7 +364,7 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 
 static void omap_mbox_fini(struct omap_mbox *mbox)
 {
-	_omap_mbox_disable_irq(mbox, IRQ_RX);
+	omap_mbox_disable_irq(mbox, IRQ_RX);
 	free_irq(mbox->irq, mbox);
 	flush_work(&mbox->rxq->work);
 	mbox_queue_free(mbox->rxq);
@@ -533,10 +511,10 @@ static int omap_mbox_chan_send_noirq(struct omap_mbox *mbox, u32 msg)
 	int ret = -EBUSY;
 
 	if (!mbox_fifo_full(mbox)) {
-		_omap_mbox_enable_irq(mbox, IRQ_RX);
+		omap_mbox_enable_irq(mbox, IRQ_RX);
 		mbox_fifo_write(mbox, msg);
 		ret = 0;
-		_omap_mbox_disable_irq(mbox, IRQ_RX);
+		omap_mbox_disable_irq(mbox, IRQ_RX);
 
 		/* we must read and ack the interrupt directly from here */
 		mbox_fifo_read(mbox);
@@ -556,7 +534,7 @@ static int omap_mbox_chan_send(struct omap_mbox *mbox, u32 msg)
 	}
 
 	/* always enable the interrupt */
-	_omap_mbox_enable_irq(mbox, IRQ_TX);
+	omap_mbox_enable_irq(mbox, IRQ_TX);
 	return ret;
 }
 
diff --git a/include/linux/omap-mailbox.h b/include/linux/omap-mailbox.h
index 8aa984ec1f38b..426a80fb32b5c 100644
--- a/include/linux/omap-mailbox.h
+++ b/include/linux/omap-mailbox.h
@@ -20,7 +20,4 @@ struct mbox_client;
 struct mbox_chan *omap_mbox_request_channel(struct mbox_client *cl,
 					    const char *chan_name);
 
-void omap_mbox_enable_irq(struct mbox_chan *chan, omap_mbox_irq_t irq);
-void omap_mbox_disable_irq(struct mbox_chan *chan, omap_mbox_irq_t irq);
-
 #endif /* OMAP_MAILBOX_H */
-- 
2.39.2


