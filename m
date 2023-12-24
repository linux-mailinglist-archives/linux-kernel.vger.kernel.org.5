Return-Path: <linux-kernel+bounces-10694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DEB81D8E0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 12:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098761F2193A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 11:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8BE53A7;
	Sun, 24 Dec 2023 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zUVpwJx5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C30A23CD
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5542a7f1f3cso3254607a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 03:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703418561; x=1704023361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+AICZB/3i+9hmEPe7EXcGEewYuTAI7wt2ZhMt/aXAs=;
        b=zUVpwJx5ORGRP5+0ffSCyEPq7qG4r609b3zERmixme+gomAcQ58PLomyGJCjEY5oyN
         NEtLBnUpBoT9mNPZYl+sD2Uhve3uXdFrobPa709DOdu76qbyKYmXw7vkFteQwo5olZ2A
         VlwSkgnTBooebXE/F+n+yng19KBdpT8cXH/m4R+sov+mluFGCRgI3chWl9es2pPA1Z5j
         b+PWC+PwnnftqYW7VnbsYDpwUPSk7/9BPRSIy7acUHiU4nuJlQTG0AWH759tiiI1BoMe
         IgYxs0i3w2cCeqcKIJKCoCf4osQo/NTBY9QYZp5FI7UD1feUfcW5oOTjOX4vguNQZk7q
         r7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703418561; x=1704023361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+AICZB/3i+9hmEPe7EXcGEewYuTAI7wt2ZhMt/aXAs=;
        b=mxLHFYo95YEzaqnRPdanYLhIZaGE4C3kjKNHLa2GJ6MYbb4CjPNTEJ+3f+fep3Yxjn
         piGzuuUXp888NwnAL4DGse3MJs4xyjZSTzXaFJXRZWVE3AuNeoOsXjg1P/CpyQMLKQiH
         xKPq9QfVDtAUnXe19Wxvu9gQD9se8RfXpVoxfmyRjzJXvhQheIEFSs39iD+WioQSJW03
         k/ihBfCkmEN7kBqi39ovLmwDlTxSLfGWh4POZsJkih5ICfpJNHlN5eXBXjLmzA+377OQ
         rUBs/IdANfPsYlurofrZ8uE9+B8MNksTkyeXBvVgoeg/+GuAUDTf9+xP3+iSJDgSMWE8
         FYGw==
X-Gm-Message-State: AOJu0YypwOldR2XpEmd2tWq0Dr0uV6J5J1JITbehR7P/t/jI9Pg5Ssdd
	qzS3VV15L6G/FBmg8+qvAcFBS9HMyFVJrQ==
X-Google-Smtp-Source: AGHT+IGP4i5Vx4NxrbazqvNFKOlVMGjmeKM/kcE56oix1x4xDKdCU+tWsPzNnnKD9g8ezMl8dASzjQ==
X-Received: by 2002:a05:6402:12d2:b0:552:e50f:524e with SMTP id k18-20020a05640212d200b00552e50f524emr2858705edx.79.1703418561604;
        Sun, 24 Dec 2023 03:49:21 -0800 (PST)
Received: from krzk-bin.. ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id z23-20020aa7c657000000b0054ccac03945sm4999771edr.12.2023.12.24.03.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 03:49:20 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] media: fimc-lite: constify several pointers in function arguments
Date: Sun, 24 Dec 2023 12:49:06 +0100
Message-Id: <20231224114916.111433-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231224114916.111433-1-krzysztof.kozlowski@linaro.org>
References: <20231224114916.111433-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several functions do not modify pointed structure, thus the pointer can
point to const data for additional safety and self-documenting intention
of the function.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../platform/samsung/exynos4-is/fimc-lite-reg.c     | 13 +++++++------
 .../platform/samsung/exynos4-is/fimc-lite-reg.h     | 10 +++++-----
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-lite-reg.c b/drivers/media/platform/samsung/exynos4-is/fimc-lite-reg.c
index 57996b4104b4..2483277a6cb0 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-lite-reg.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-lite-reg.c
@@ -124,7 +124,7 @@ static const u32 src_pixfmt_map[8][3] = {
 };
 
 /* Set camera input pixel format and resolution */
-void flite_hw_set_source_format(struct fimc_lite *dev, struct flite_frame *f)
+void flite_hw_set_source_format(struct fimc_lite *dev, const struct flite_frame *f)
 {
 	u32 pixelcode = f->fmt->mbus_code;
 	int i = ARRAY_SIZE(src_pixfmt_map);
@@ -155,7 +155,7 @@ void flite_hw_set_source_format(struct fimc_lite *dev, struct flite_frame *f)
 }
 
 /* Set the camera host input window offsets (cropping) */
-void flite_hw_set_window_offset(struct fimc_lite *dev, struct flite_frame *f)
+void flite_hw_set_window_offset(struct fimc_lite *dev, const struct flite_frame *f)
 {
 	u32 hoff2, voff2;
 	u32 cfg;
@@ -186,7 +186,7 @@ static void flite_hw_set_camera_port(struct fimc_lite *dev, int id)
 
 /* Select serial or parallel bus, camera port (A,B) and set signals polarity */
 void flite_hw_set_camera_bus(struct fimc_lite *dev,
-			     struct fimc_source_info *si)
+			     const struct fimc_source_info *si)
 {
 	u32 cfg = readl(dev->regs + FLITE_REG_CIGCTRL);
 	unsigned int flags = si->flags;
@@ -226,7 +226,8 @@ static void flite_hw_set_pack12(struct fimc_lite *dev, int on)
 	writel(cfg, dev->regs + FLITE_REG_CIODMAFMT);
 }
 
-static void flite_hw_set_out_order(struct fimc_lite *dev, struct flite_frame *f)
+static void flite_hw_set_out_order(struct fimc_lite *dev,
+				   const struct flite_frame *f)
 {
 	static const u32 pixcode[4][2] = {
 		{ MEDIA_BUS_FMT_YUYV8_2X8, FLITE_REG_CIODMAFMT_YCBYCR },
@@ -244,7 +245,7 @@ static void flite_hw_set_out_order(struct fimc_lite *dev, struct flite_frame *f)
 	writel(cfg | pixcode[i][1], dev->regs + FLITE_REG_CIODMAFMT);
 }
 
-void flite_hw_set_dma_window(struct fimc_lite *dev, struct flite_frame *f)
+void flite_hw_set_dma_window(struct fimc_lite *dev, const struct flite_frame *f)
 {
 	u32 cfg;
 
@@ -294,7 +295,7 @@ void flite_hw_mask_dma_buffer(struct fimc_lite *dev, u32 index)
 }
 
 /* Enable/disable output DMA, set output pixel size and offsets (composition) */
-void flite_hw_set_output_dma(struct fimc_lite *dev, struct flite_frame *f,
+void flite_hw_set_output_dma(struct fimc_lite *dev, const struct flite_frame *f,
 			     bool enable)
 {
 	u32 cfg = readl(dev->regs + FLITE_REG_CIGCTRL);
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-lite-reg.h b/drivers/media/platform/samsung/exynos4-is/fimc-lite-reg.h
index 3b8af3ce1838..c5ec36dfb2f9 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-lite-reg.h
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-lite-reg.h
@@ -133,13 +133,13 @@ void flite_hw_set_interrupt_mask(struct fimc_lite *dev);
 void flite_hw_capture_start(struct fimc_lite *dev);
 void flite_hw_capture_stop(struct fimc_lite *dev);
 void flite_hw_set_camera_bus(struct fimc_lite *dev,
-			     struct fimc_source_info *s_info);
-void flite_hw_set_window_offset(struct fimc_lite *dev, struct flite_frame *f);
-void flite_hw_set_source_format(struct fimc_lite *dev, struct flite_frame *f);
+			     const struct fimc_source_info *s_info);
+void flite_hw_set_window_offset(struct fimc_lite *dev, const struct flite_frame *f);
+void flite_hw_set_source_format(struct fimc_lite *dev, const struct flite_frame *f);
 
-void flite_hw_set_output_dma(struct fimc_lite *dev, struct flite_frame *f,
+void flite_hw_set_output_dma(struct fimc_lite *dev, const struct flite_frame *f,
 			     bool enable);
-void flite_hw_set_dma_window(struct fimc_lite *dev, struct flite_frame *f);
+void flite_hw_set_dma_window(struct fimc_lite *dev, const struct flite_frame *f);
 void flite_hw_set_test_pattern(struct fimc_lite *dev, bool on);
 void flite_hw_dump_regs(struct fimc_lite *dev, const char *label);
 void flite_hw_set_dma_buffer(struct fimc_lite *dev, struct flite_buffer *buf);
-- 
2.34.1


