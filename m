Return-Path: <linux-kernel+bounces-86977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BAD86CDC8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469101C20DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74683757FF;
	Thu, 29 Feb 2024 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLtbrTsi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45C6757E6;
	Thu, 29 Feb 2024 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221790; cv=none; b=m6/iG4QWu4FdidgsvvCZm4vMXcUDvZyfryqf1wS122hl4KKjEhIi/OnWmL9C4uvfF0jYEifiuVT02g9gVFhQMTWKc/dGPRM+/lUxhfG045WkqXc3oD0cRRFvCIb/ffK5aCjqT1BN2Tl5wDqdjzGsio9RXpHDGSwoX/dBm2C4L1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221790; c=relaxed/simple;
	bh=JvLxDW07Gt/27exbqBLUQLZ3ITh8Gwx3ZVFx5ssdy/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMkRQr08fL9WMV3pcabYiIs5+859UpAsr4vEcItod+ff2IPrkeYkkXiv9RogglVZ6fPmQELg5Qz6nDa9u6WvkGQgA+llYMzJkfcNGdowtaBa/Vg7THe7b0Y3sds7gJsOI94Sr1HJbpCp4UYGL6r+eauk2+8c5fRvF/7ihA8ysFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLtbrTsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC999C433C7;
	Thu, 29 Feb 2024 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221790;
	bh=JvLxDW07Gt/27exbqBLUQLZ3ITh8Gwx3ZVFx5ssdy/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MLtbrTsiRJ5hwxhZzazgBJ2t/uthkFfTKLifwG8Ip4p88gj+NEL615cd9HaQjIL/l
	 gXp+sNiCXeVMzSJWd2nXDnvyq1EfjumG/9bYMgLUrzk3om3HKj/FfK7EDhMKLsux96
	 MjmpO4jpKL2Jo3o1bGkNqO6nJgUjvMUqKXj3JjLfWcZ9dOkcOYId43xeGnYpnkRZIu
	 AnXdurfgcBIkpabnoRPrdJddRDJMoauXQ9FCTEvoRoL7ZW5kBlrujLBeRmmyqjwILy
	 xFQi3ZzdI11BFMbPYFdYx0kO08OSeVsOe1D/2iDpdaiGxMzzIFbDFrWLkp8W6EQymy
	 YYng7UvyS3b6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dafna@fastmail.com,
	heiko@sntech.de,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 02/21] media: rkisp1: Fix IRQ handling due to shared interrupts
Date: Thu, 29 Feb 2024 10:49:22 -0500
Message-ID: <20240229154946.2850012-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154946.2850012-1-sashal@kernel.org>
References: <20240229154946.2850012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
Content-Transfer-Encoding: 8bit

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit ffb635bb398fc07cb38f8a7b4a82cbe5f412f08e ]

The driver requests the interrupts as IRQF_SHARED, so the interrupt
handlers can be called at any time. If such a call happens while the ISP
is powered down, the SoC will hang as the driver tries to access the
ISP registers.

This can be reproduced even without the platform sharing the IRQ line:
Enable CONFIG_DEBUG_SHIRQ and unload the driver, and the board will
hang.

Fix this by adding a new field, 'irqs_enabled', which is used to bail
out from the interrupt handler when the ISP is not operational.

Link: https://lore.kernel.org/r/20231218-rkisp-shirq-fix-v1-2-173007628248@ideasonboard.com

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/rockchip/rkisp1/rkisp1-capture.c |  3 +++
 .../platform/rockchip/rkisp1/rkisp1-common.h  |  2 ++
 .../platform/rockchip/rkisp1/rkisp1-csi.c     |  3 +++
 .../platform/rockchip/rkisp1/rkisp1-dev.c     | 22 +++++++++++++++++++
 .../platform/rockchip/rkisp1/rkisp1-isp.c     |  3 +++
 5 files changed, 33 insertions(+)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
index 8f3cba3197623..c584bb6d31998 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
@@ -723,6 +723,9 @@ irqreturn_t rkisp1_capture_isr(int irq, void *ctx)
 	unsigned int i;
 	u32 status;
 
+	if (!rkisp1->irqs_enabled)
+		return IRQ_NONE;
+
 	status = rkisp1_read(rkisp1, RKISP1_CIF_MI_MIS);
 	if (!status)
 		return IRQ_NONE;
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
index 104a1dbeff433..e9bc6c155d2fc 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
@@ -467,6 +467,7 @@ struct rkisp1_debug {
  * @debug:	   debug params to be exposed on debugfs
  * @info:	   version-specific ISP information
  * @irqs:          IRQ line numbers
+ * @irqs_enabled:  the hardware is enabled and can cause interrupts
  */
 struct rkisp1_device {
 	void __iomem *base_addr;
@@ -488,6 +489,7 @@ struct rkisp1_device {
 	struct rkisp1_debug debug;
 	const struct rkisp1_info *info;
 	int irqs[RKISP1_NUM_IRQS];
+	bool irqs_enabled;
 };
 
 /*
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
index 0a67eb96402cb..1537dccbd2e28 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
@@ -211,6 +211,9 @@ irqreturn_t rkisp1_csi_isr(int irq, void *ctx)
 	struct rkisp1_device *rkisp1 = dev_get_drvdata(dev);
 	u32 val, status;
 
+	if (!rkisp1->irqs_enabled)
+		return IRQ_NONE;
+
 	status = rkisp1_read(rkisp1, RKISP1_CIF_MIPI_MIS);
 	if (!status)
 		return IRQ_NONE;
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index acc559652d6eb..73cf08a740118 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -305,6 +305,24 @@ static int __maybe_unused rkisp1_runtime_suspend(struct device *dev)
 {
 	struct rkisp1_device *rkisp1 = dev_get_drvdata(dev);
 
+	rkisp1->irqs_enabled = false;
+	/* Make sure the IRQ handler will see the above */
+	mb();
+
+	/*
+	 * Wait until any running IRQ handler has returned. The IRQ handler
+	 * may get called even after this (as it's a shared interrupt line)
+	 * but the 'irqs_enabled' flag will make the handler return immediately.
+	 */
+	for (unsigned int il = 0; il < ARRAY_SIZE(rkisp1->irqs); ++il) {
+		if (rkisp1->irqs[il] == -1)
+			continue;
+
+		/* Skip if the irq line is the same as previous */
+		if (il == 0 || rkisp1->irqs[il - 1] != rkisp1->irqs[il])
+			synchronize_irq(rkisp1->irqs[il]);
+	}
+
 	clk_bulk_disable_unprepare(rkisp1->clk_size, rkisp1->clks);
 	return pinctrl_pm_select_sleep_state(dev);
 }
@@ -321,6 +339,10 @@ static int __maybe_unused rkisp1_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	rkisp1->irqs_enabled = true;
+	/* Make sure the IRQ handler will see the above */
+	mb();
+
 	return 0;
 }
 
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
index 2239fb6c7d393..8fc9c1c116f1d 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
@@ -1027,6 +1027,9 @@ irqreturn_t rkisp1_isp_isr(int irq, void *ctx)
 	struct rkisp1_device *rkisp1 = dev_get_drvdata(dev);
 	u32 status, isp_err;
 
+	if (!rkisp1->irqs_enabled)
+		return IRQ_NONE;
+
 	status = rkisp1_read(rkisp1, RKISP1_CIF_ISP_MIS);
 	if (!status)
 		return IRQ_NONE;
-- 
2.43.0


