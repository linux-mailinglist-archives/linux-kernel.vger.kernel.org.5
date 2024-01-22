Return-Path: <linux-kernel+bounces-33352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B74C8368AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E67283647
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C7565BD2;
	Mon, 22 Jan 2024 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTGiKfT3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A615B65BBF;
	Mon, 22 Jan 2024 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935956; cv=none; b=DLMeGS4ifIy/pkbrYxdgcsDqjWnVEfsafwgQPZe8OUfSnqZ5hQ9MbDL5z8LH6a5hCSWMIHIpUj4NhIkBoRJZncw1GEqXjnb3ENvMiW8/VzJ3017scR4b5mp3E0uCWIwkX6t3b4616ybxTin3rDEEC6SBsmu7gv8owpIzo42IVjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935956; c=relaxed/simple;
	bh=xD9xpuiZUPrSvYzQ2YyguGL/6fOMJQL/RT0rBtUxc7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtEZTPl7nVqRee1/S7LN+NWm19DH2ywFNl6dmFKK8wk50fp5oUidzRKNWjNc2zh2Z5oncJ8hNB4LppJG8dJVHCKDjI//D85IuD6MziNAcdjAspU5aaUPuXYiQc8QkpB6yZMM3rDaBE4d9nL14dA7X5xq3KMy6rr7RPRZgbiE47I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTGiKfT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D515EC433F1;
	Mon, 22 Jan 2024 15:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935956;
	bh=xD9xpuiZUPrSvYzQ2YyguGL/6fOMJQL/RT0rBtUxc7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gTGiKfT3YGgckVWmnEPDXeJ7PisZJnxhfX2/7GwJWXy+eHpal//LZnAZ79wFKdvRP
	 DuwhLNycUlODRYh+WwvM4bD61JzZ4B3UFmZrhplRv07pCnrGPHvXhe/EMla9kTMgV8
	 lje2sO6KF/jxzh1wgcQxKL4d+yG94PeqKCXh2LuS2710wL/ydYHDztbTzHF+tHpyVE
	 bI2oX9n4dNcnY37aizcfCVpdn8R+PWL9OYGX4w+4wKRzD/y17ddvB8KEBbYwTJfLFl
	 JtN6L4EcQery9el/JG1KyEDTGxC9VuuJV1D5WgciNjmSuX+LXEqaRyEjpfuJD/HzLB
	 RCf+Aguqfu0kA==
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
Subject: [PATCH AUTOSEL 6.6 30/73] media: rkisp1: Fix IRQ handler return values
Date: Mon, 22 Jan 2024 10:01:44 -0500
Message-ID: <20240122150432.992458-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
Content-Transfer-Encoding: 8bit

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 3eb7910e1b16a2c136be26a8380f21469225b2f6 ]

The IRQ handler rkisp1_isr() calls sub-handlers, all of which returns an
irqreturn_t value, but rkisp1_isr() ignores those values and always
returns IRQ_HANDLED.

Fix this by collecting the return values, and returning IRQ_HANDLED or
IRQ_NONE as appropriate.

Link: https://lore.kernel.org/r/20231207-rkisp-irq-fix-v3-2-358a2c871a3c@ideasonboard.com

Tested-by: Adam Ford <aford173@gmail.com>  #imx8mp-beacon
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/rockchip/rkisp1/rkisp1-dev.c  | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index 4c4514e20673..22b2ae0e89c4 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -442,17 +442,25 @@ static int rkisp1_entities_register(struct rkisp1_device *rkisp1)
 
 static irqreturn_t rkisp1_isr(int irq, void *ctx)
 {
+	irqreturn_t ret = IRQ_NONE;
+
 	/*
 	 * Call rkisp1_capture_isr() first to handle the frame that
 	 * potentially completed using the current frame_sequence number before
 	 * it is potentially incremented by rkisp1_isp_isr() in the vertical
 	 * sync.
 	 */
-	rkisp1_capture_isr(irq, ctx);
-	rkisp1_isp_isr(irq, ctx);
-	rkisp1_csi_isr(irq, ctx);
 
-	return IRQ_HANDLED;
+	if (rkisp1_capture_isr(irq, ctx) == IRQ_HANDLED)
+		ret = IRQ_HANDLED;
+
+	if (rkisp1_isp_isr(irq, ctx) == IRQ_HANDLED)
+		ret = IRQ_HANDLED;
+
+	if (rkisp1_csi_isr(irq, ctx) == IRQ_HANDLED)
+		ret = IRQ_HANDLED;
+
+	return ret;
 }
 
 static const char * const px30_isp_clks[] = {
-- 
2.43.0


