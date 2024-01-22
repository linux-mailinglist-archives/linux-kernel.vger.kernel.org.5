Return-Path: <linux-kernel+bounces-33257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3323E8367BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A28B2A79F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E50653E38;
	Mon, 22 Jan 2024 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPmoFAwI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D7753E17;
	Mon, 22 Jan 2024 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935507; cv=none; b=P8yjLpaLFifAvaVmafStlSNKEUxP07iUAHuj+G57Jwnv1Zw/4zh+6fHMsl0fr3ZZTDjwn3tQHJ1s45qgJ9ph87vzSQaLyiFnWEqmB2Q8/JTWsBLg4wuD1oalhSi0GwoRo5Yg3oGa2CdD8FkX2JQZHNZq7ydB/g7jFa1RRvPaZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935507; c=relaxed/simple;
	bh=1rhpbTEV4z8DnN43nGy8wsyD+6mjYsPqciJT7U/+yyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BihrV0dg62vQmqhvuxfsmQmYfFuP0HEOOFSJrCLVbu3P2u/hGHmwArdBaVCl8k4NXAUKS0rDpgDZOesGYE1OY4/eREKgf/hSmS8eHYDg5PtT1SF8X3EkNHb2WW8GM7t2nRMMOZy+l6i2f47YBDYD4iUvRi8e7lODqfR4cy9IwNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPmoFAwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC568C433C7;
	Mon, 22 Jan 2024 14:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935507;
	bh=1rhpbTEV4z8DnN43nGy8wsyD+6mjYsPqciJT7U/+yyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IPmoFAwIGlm+xJUOBPhnjGfudKM8+QzXJ75A/1dakONcnxo2JF6GbYyZhZWjWS7cN
	 xVNzSWcOcC8V4yGTTXALe8wN0LEC6pUtkJ1SNZenTWc6UcjzUD0Izo+loB6z52bwSB
	 3I2UtE173USEw34eKoKADwiaFbf2H03UCFa63HvRtB3zYwVm5yzdxW/dDcp/vLlmfq
	 j5cWHzL6U+grESAFmZUE+00zD8O49b67+0Ib4mZVaeflllQ1IYj032OO5cm5ikwGbe
	 D1H6MhWU9iqpKZdtp/3pg0jvE/2lCCcbgAkFL+L7RjShXkmKoW60K1Z/Oduep0JAr2
	 NB2MwXiQKFusg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Adam Ford <aford173@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dafna@fastmail.com,
	heiko@sntech.de,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 38/88] media: rkisp1: Fix IRQ disable race issue
Date: Mon, 22 Jan 2024 09:51:11 -0500
Message-ID: <20240122145608.990137-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 870565f063a58576e8a4529f122cac4325c6b395 ]

In rkisp1_isp_stop() and rkisp1_csi_disable() the driver masks the
interrupts and then apparently assumes that the interrupt handler won't
be running, and proceeds in the stop procedure. This is not the case, as
the interrupt handler can already be running, which would lead to the
ISP being disabled while the interrupt handler handling a captured
frame.

This brings up two issues: 1) the ISP could be powered off while the
interrupt handler is still running and accessing registers, leading to
board lockup, and 2) the interrupt handler code and the code that
disables the streaming might do things that conflict.

It is not clear to me if 2) causes a real issue, but 1) can be seen with
a suitable delay (or printk in my case) in the interrupt handler,
leading to board lockup.

Link: https://lore.kernel.org/r/20231207-rkisp-irq-fix-v3-4-358a2c871a3c@ideasonboard.com

Tested-by: Adam Ford <aford173@gmail.com>  #imx8mp-beacon
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/rockchip/rkisp1/rkisp1-csi.c     | 14 ++++++++++++-
 .../platform/rockchip/rkisp1/rkisp1-isp.c     | 20 ++++++++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
index 6e17b2817e61..702adee83322 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
@@ -125,8 +125,20 @@ static void rkisp1_csi_disable(struct rkisp1_csi *csi)
 	struct rkisp1_device *rkisp1 = csi->rkisp1;
 	u32 val;
 
-	/* Mask and clear interrupts. */
+	/* Mask MIPI interrupts. */
 	rkisp1_write(rkisp1, RKISP1_CIF_MIPI_IMSC, 0);
+
+	/* Flush posted writes */
+	rkisp1_read(rkisp1, RKISP1_CIF_MIPI_IMSC);
+
+	/*
+	 * Wait until the IRQ handler has ended. The IRQ handler may get called
+	 * even after this, but it will return immediately as the MIPI
+	 * interrupts have been masked.
+	 */
+	synchronize_irq(rkisp1->irqs[RKISP1_IRQ_MIPI]);
+
+	/* Clear MIPI interrupt status */
 	rkisp1_write(rkisp1, RKISP1_CIF_MIPI_ICR, ~0);
 
 	val = rkisp1_read(rkisp1, RKISP1_CIF_MIPI_CTRL);
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
index 88ca8b2283b7..61d4816186e7 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
@@ -254,11 +254,25 @@ static void rkisp1_isp_stop(struct rkisp1_isp *isp)
 	 * ISP(mi) stop in mi frame end -> Stop ISP(mipi) ->
 	 * Stop ISP(isp) ->wait for ISP isp off
 	 */
-	/* stop and clear MI and ISP interrupts */
-	rkisp1_write(rkisp1, RKISP1_CIF_ISP_IMSC, 0);
-	rkisp1_write(rkisp1, RKISP1_CIF_ISP_ICR, ~0);
 
+	/* Mask MI and ISP interrupts */
+	rkisp1_write(rkisp1, RKISP1_CIF_ISP_IMSC, 0);
 	rkisp1_write(rkisp1, RKISP1_CIF_MI_IMSC, 0);
+
+	/* Flush posted writes */
+	rkisp1_read(rkisp1, RKISP1_CIF_MI_IMSC);
+
+	/*
+	 * Wait until the IRQ handler has ended. The IRQ handler may get called
+	 * even after this, but it will return immediately as the MI and ISP
+	 * interrupts have been masked.
+	 */
+	synchronize_irq(rkisp1->irqs[RKISP1_IRQ_ISP]);
+	if (rkisp1->irqs[RKISP1_IRQ_ISP] != rkisp1->irqs[RKISP1_IRQ_MI])
+		synchronize_irq(rkisp1->irqs[RKISP1_IRQ_MI]);
+
+	/* Clear MI and ISP interrupt status */
+	rkisp1_write(rkisp1, RKISP1_CIF_ISP_ICR, ~0);
 	rkisp1_write(rkisp1, RKISP1_CIF_MI_ICR, ~0);
 
 	/* stop ISP */
-- 
2.43.0


