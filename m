Return-Path: <linux-kernel+bounces-114312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FA48889B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2A01C20B62
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5F6264225;
	Sun, 24 Mar 2024 23:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehUuCCYS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362C715357F;
	Sun, 24 Mar 2024 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321691; cv=none; b=W4DN7/Wn/UPicrgm4M0jVRKuBeBuatMXGkSKGEMOm9cSJAVd4VNghLGnizmbmcNRqNurUfKo4JZyfWQVucxlWjtoYLWdDve8i1MzEocc3rZY2Otzg4m6BmMUNp3jVr+fXwaIb2Yo+TPqfMo0HbKZ7i118ZZAAWGoFnsuMyuz924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321691; c=relaxed/simple;
	bh=YMb9kBOxiWxNoEAmO9PyoK7mjuoWuCq+Pz7od0vzq4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6HKCwbMtq625IrRllTQHQ0t0rPflXvQu8XQyhc60R7U4QczTfUwnb6Sydmwrvz43zYW31OdMtpNSU9zIiGgBid4tAdx/2PZhayekH8QTyth4eSTc27ioA0vpCfKw7iz+Stib3k9qkYGXPUbsFVfAJ1aVJHZdEBH23mEj5Xx2Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehUuCCYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741E9C43399;
	Sun, 24 Mar 2024 23:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321690;
	bh=YMb9kBOxiWxNoEAmO9PyoK7mjuoWuCq+Pz7od0vzq4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ehUuCCYSeJ5PCgFqP8xCDpL5nGdcjdJCAc7GxERIlrY06ZUtYdH/au8S7M63eewDL
	 6EQc1fGOU2DPtLlAbqVos47K/W7aujsnSXeymbgszvG4M6zoI4I9wSe6qomPdiUW9O
	 EzZrBVugiwLx2G0Ca2SKu5mg3ksjkWTDTSmLOmLEtITHGeREsADcEFAUDwrJv6hvZC
	 zCX9itGZDM95LuUWW+7Y8MDJ/HnWnq0ZuSMZd0OmsJGcyuv9emSdyn4u+5Yl/EvwOn
	 xcVHGVeAba8VJqa+7B/n0GbdMCdKWQVigpMHihRgOVN0JLfqAyz3q8Y84Vii2o7FWm
	 OMQmQYlUYyTnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 418/638] media: sun8i-di: Fix coefficient writes
Date: Sun, 24 Mar 2024 18:57:35 -0400
Message-ID: <20240324230116.1348576-419-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jernej Skrabec <jernej.skrabec@gmail.com>

[ Upstream commit 794b581f8c6eb7b60fe468ccb96dd3cd38ff779f ]

Currently coefficients are applied only once, since they don't change.
However, this is done before enable bit is set and thus it doesn't get
applied properly.

Fix that by applying coefficients after enable bit is set. While this
means that it will be done evey time, it doesn't bring much time
penalty.

Fixes: a4260ea49547 ("media: sun4i: Add H3 deinterlace driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/sunxi/sun8i-di/sun8i-di.c  | 42 +++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
index 90ab1d77b6a5e..34e0999392842 100644
--- a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
+++ b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
@@ -66,6 +66,7 @@ static void deinterlace_device_run(void *priv)
 	struct vb2_v4l2_buffer *src, *dst;
 	unsigned int hstep, vstep;
 	dma_addr_t addr;
+	int i;
 
 	src = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
 	dst = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
@@ -160,6 +161,26 @@ static void deinterlace_device_run(void *priv)
 	deinterlace_write(dev, DEINTERLACE_CH1_HORZ_FACT, hstep);
 	deinterlace_write(dev, DEINTERLACE_CH1_VERT_FACT, vstep);
 
+	/* neutral filter coefficients */
+	deinterlace_set_bits(dev, DEINTERLACE_FRM_CTRL,
+			     DEINTERLACE_FRM_CTRL_COEF_ACCESS);
+	readl_poll_timeout(dev->base + DEINTERLACE_STATUS, val,
+			   val & DEINTERLACE_STATUS_COEF_STATUS, 2, 40);
+
+	for (i = 0; i < 32; i++) {
+		deinterlace_write(dev, DEINTERLACE_CH0_HORZ_COEF0 + i * 4,
+				  DEINTERLACE_IDENTITY_COEF);
+		deinterlace_write(dev, DEINTERLACE_CH0_VERT_COEF + i * 4,
+				  DEINTERLACE_IDENTITY_COEF);
+		deinterlace_write(dev, DEINTERLACE_CH1_HORZ_COEF0 + i * 4,
+				  DEINTERLACE_IDENTITY_COEF);
+		deinterlace_write(dev, DEINTERLACE_CH1_VERT_COEF + i * 4,
+				  DEINTERLACE_IDENTITY_COEF);
+	}
+
+	deinterlace_clr_set_bits(dev, DEINTERLACE_FRM_CTRL,
+				 DEINTERLACE_FRM_CTRL_COEF_ACCESS, 0);
+
 	deinterlace_clr_set_bits(dev, DEINTERLACE_FIELD_CTRL,
 				 DEINTERLACE_FIELD_CTRL_FIELD_CNT_MSK,
 				 DEINTERLACE_FIELD_CTRL_FIELD_CNT(ctx->field));
@@ -248,7 +269,6 @@ static irqreturn_t deinterlace_irq(int irq, void *data)
 static void deinterlace_init(struct deinterlace_dev *dev)
 {
 	u32 val;
-	int i;
 
 	deinterlace_write(dev, DEINTERLACE_BYPASS,
 			  DEINTERLACE_BYPASS_CSC);
@@ -285,26 +305,6 @@ static void deinterlace_init(struct deinterlace_dev *dev)
 	deinterlace_clr_set_bits(dev, DEINTERLACE_CHROMA_DIFF,
 				 DEINTERLACE_CHROMA_DIFF_TH_MSK,
 				 DEINTERLACE_CHROMA_DIFF_TH(5));
-
-	/* neutral filter coefficients */
-	deinterlace_set_bits(dev, DEINTERLACE_FRM_CTRL,
-			     DEINTERLACE_FRM_CTRL_COEF_ACCESS);
-	readl_poll_timeout(dev->base + DEINTERLACE_STATUS, val,
-			   val & DEINTERLACE_STATUS_COEF_STATUS, 2, 40);
-
-	for (i = 0; i < 32; i++) {
-		deinterlace_write(dev, DEINTERLACE_CH0_HORZ_COEF0 + i * 4,
-				  DEINTERLACE_IDENTITY_COEF);
-		deinterlace_write(dev, DEINTERLACE_CH0_VERT_COEF + i * 4,
-				  DEINTERLACE_IDENTITY_COEF);
-		deinterlace_write(dev, DEINTERLACE_CH1_HORZ_COEF0 + i * 4,
-				  DEINTERLACE_IDENTITY_COEF);
-		deinterlace_write(dev, DEINTERLACE_CH1_VERT_COEF + i * 4,
-				  DEINTERLACE_IDENTITY_COEF);
-	}
-
-	deinterlace_clr_set_bits(dev, DEINTERLACE_FRM_CTRL,
-				 DEINTERLACE_FRM_CTRL_COEF_ACCESS, 0);
 }
 
 static inline struct deinterlace_ctx *deinterlace_file2ctx(struct file *file)
-- 
2.43.0


