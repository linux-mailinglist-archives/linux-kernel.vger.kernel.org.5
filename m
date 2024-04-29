Return-Path: <linux-kernel+bounces-161870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FA48B527F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E931F21A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B402A14A90;
	Mon, 29 Apr 2024 07:41:41 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535A4EED4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714376501; cv=none; b=GyrlJP+P7fbTxykEfYS+YMY3lJQ9btQyPLGREeOjxCmgPMqG5xXP35qUXqUEi1OoMUEuDY3fOZE0zsvgobiDdhMLIJwfFekpDQ0e7NfcSi3tC2FLBQ+8Fk/PE/f/mfW/qfJfgMUefrQaVeYFTG7w7adCc7E7iyWhdWnwfSAFFoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714376501; c=relaxed/simple;
	bh=6snhrLpZm5fXvKkspgAPrTi0Vx4FvzZhbR2jxq0lRkU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RmQXpNkuMzCObydCnBHeyVI2kN27GrFIZc0x1JxCUPbuR80rviDVWdLkxJp/4DwNScIKGHmhoXjIB7O/CxGZ+IKNQkllmj689LIiegwH0GBxgsJJ1hE2ju7v7SAitGcY6Qtg4Fu0aMXC622iyJVLBeSSQZ4bBghHNwPdph+B5lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX02.aspeed.com (192.168.0.24) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 29 Apr
 2024 15:36:25 +0800
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 29 Apr
 2024 15:36:25 +0800
Received: from twmbx02.aspeed.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 29 Apr 2024 15:36:24 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <alexandre.belloni@bootlin.com>, <dylan_hung@aspeedtech.com>,
	<gustavoars@kernel.org>, <keescook@chromium.org>,
	<billy_tsai@aspeedtech.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] i3c: dw: Add hot-join support.
Date: Mon, 29 Apr 2024 15:36:24 +0800
Message-ID: <20240429073624.256830-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: Fail (TWMBX02.aspeed.com: domain of billy_tsai@aspeedtech.com
 does not designate 192.168.10.10 as permitted sender)
 receiver=TWMBX02.aspeed.com; client-ip=192.168.10.10;
 helo=twmbx02.aspeed.com;

Add hot-join support for dw i3c master controller.
By default, the hot-join acknowledgment is disabled, and the hardware will
automatically send the DISEC CCC when it receives the hot-join request.
Users can use the sys entry to enable it.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/i3c/master/dw-i3c-master.c | 67 ++++++++++++++++++++++++------
 drivers/i3c/master/dw-i3c-master.h |  2 +
 2 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 276153e10f5a..0ec00e644bd4 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1136,6 +1136,23 @@ static void dw_i3c_master_free_ibi(struct i3c_dev_desc *dev)
 	data->ibi_pool = NULL;
 }
 
+static void dw_i3c_master_enable_sir_signal(struct dw_i3c_master *master, bool enable)
+{
+	u32 reg;
+
+	reg = readl(master->regs + INTR_STATUS_EN);
+	reg &= ~INTR_IBI_THLD_STAT;
+	if (enable)
+		reg |= INTR_IBI_THLD_STAT;
+	writel(reg, master->regs + INTR_STATUS_EN);
+
+	reg = readl(master->regs + INTR_SIGNAL_EN);
+	reg &= ~INTR_IBI_THLD_STAT;
+	if (enable)
+		reg |= INTR_IBI_THLD_STAT;
+	writel(reg, master->regs + INTR_SIGNAL_EN);
+}
+
 static void dw_i3c_master_set_sir_enabled(struct dw_i3c_master *master,
 					  struct i3c_dev_desc *dev,
 					  u8 idx, bool enable)
@@ -1170,23 +1187,34 @@ static void dw_i3c_master_set_sir_enabled(struct dw_i3c_master *master,
 	}
 	writel(reg, master->regs + IBI_SIR_REQ_REJECT);
 
-	if (global) {
-		reg = readl(master->regs + INTR_STATUS_EN);
-		reg &= ~INTR_IBI_THLD_STAT;
-		if (enable)
-			reg |= INTR_IBI_THLD_STAT;
-		writel(reg, master->regs + INTR_STATUS_EN);
-
-		reg = readl(master->regs + INTR_SIGNAL_EN);
-		reg &= ~INTR_IBI_THLD_STAT;
-		if (enable)
-			reg |= INTR_IBI_THLD_STAT;
-		writel(reg, master->regs + INTR_SIGNAL_EN);
-	}
+	if (global)
+		dw_i3c_master_enable_sir_signal(master, enable);
+
 
 	spin_unlock_irqrestore(&master->devs_lock, flags);
 }
 
+static int dw_i3c_master_enable_hotjoin(struct i3c_master_controller *m)
+{
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+
+	dw_i3c_master_enable_sir_signal(master, true);
+	writel(readl(master->regs + DEVICE_CTRL) & ~DEV_CTRL_HOT_JOIN_NACK,
+	       master->regs + DEVICE_CTRL);
+
+	return 0;
+}
+
+static int dw_i3c_master_disable_hotjoin(struct i3c_master_controller *m)
+{
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+
+	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_HOT_JOIN_NACK,
+	       master->regs + DEVICE_CTRL);
+
+	return 0;
+}
+
 static int dw_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
 {
 	struct dw_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
@@ -1326,6 +1354,8 @@ static void dw_i3c_master_irq_handle_ibis(struct dw_i3c_master *master)
 
 		if (IBI_TYPE_SIRQ(reg)) {
 			dw_i3c_master_handle_ibi_sir(master, reg);
+		} else if (IBI_TYPE_HJ(reg)) {
+			queue_work(master->base.wq, &master->hj_work);
 		} else {
 			len = IBI_QUEUE_STATUS_DATA_LEN(reg);
 			dev_info(&master->base.dev,
@@ -1393,6 +1423,8 @@ static const struct i3c_master_controller_ops dw_mipi_i3c_ibi_ops = {
 	.enable_ibi = dw_i3c_master_enable_ibi,
 	.disable_ibi = dw_i3c_master_disable_ibi,
 	.recycle_ibi_slot = dw_i3c_master_recycle_ibi_slot,
+	.enable_hotjoin = dw_i3c_master_enable_hotjoin,
+	.disable_hotjoin = dw_i3c_master_disable_hotjoin,
 };
 
 /* default platform ops implementations */
@@ -1412,6 +1444,14 @@ static const struct dw_i3c_platform_ops dw_i3c_platform_ops_default = {
 	.set_dat_ibi = dw_i3c_platform_set_dat_ibi_nop,
 };
 
+static void dw_i3c_hj_work(struct work_struct *work)
+{
+	struct dw_i3c_master *master =
+		container_of(work, typeof(*master), hj_work);
+
+	i3c_master_do_daa(&master->base);
+}
+
 int dw_i3c_common_probe(struct dw_i3c_master *master,
 			struct platform_device *pdev)
 {
@@ -1469,6 +1509,7 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	if (master->ibi_capable)
 		ops = &dw_mipi_i3c_ibi_ops;
 
+	INIT_WORK(&master->hj_work, dw_i3c_hj_work);
 	ret = i3c_master_register(&master->base, &pdev->dev, ops, false);
 	if (ret)
 		goto err_assert_rst;
diff --git a/drivers/i3c/master/dw-i3c-master.h b/drivers/i3c/master/dw-i3c-master.h
index ab862c5d15fe..4ab94aa72252 100644
--- a/drivers/i3c/master/dw-i3c-master.h
+++ b/drivers/i3c/master/dw-i3c-master.h
@@ -57,6 +57,8 @@ struct dw_i3c_master {
 
 	/* platform-specific data */
 	const struct dw_i3c_platform_ops *platform_ops;
+
+	struct work_struct hj_work;
 };
 
 struct dw_i3c_platform_ops {
-- 
2.25.1


