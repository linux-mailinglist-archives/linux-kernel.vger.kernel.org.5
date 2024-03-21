Return-Path: <linux-kernel+bounces-109741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E21988551D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68AA28219B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BC969972;
	Thu, 21 Mar 2024 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maCKJeOO"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7EE58AC8;
	Thu, 21 Mar 2024 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711007414; cv=none; b=H+wjd/tDO+mOBCGDuwZ0HUIuiejARZ7aLsfLm1Ell+Kbp+fmp/tPAEOOOk1vyXjz9MLHQmTCi3YCWq+nFaf7m0vDCbcsfB8gc9oExs8XZJd20WH1hD11cPMxNhI3H/Lv8tF+7aGOPGxj3dIm40FabXEYtdrRDUUs2FDsIhwMn78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711007414; c=relaxed/simple;
	bh=gkYIn34lV6cArKfOi+z58a1urGMGre3p+FPo1kVOAZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SO7g69wVWsS9AFRVlXpgRvUPETVrnwrshgp/8sZtwXa9JVElZaCw0xNkd9x6LSJsKL+CF34KTnshATFee9Z9Yq3F0+ZbBlmLz0+AGLyLmDEK0xiPpSV3X4D4SQ1qsaBX831y7/YTERLtvLdHaFhBuQK2vaiojGdEwrCkpyaz9Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maCKJeOO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d6a1af9c07so4800981fa.3;
        Thu, 21 Mar 2024 00:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711007410; x=1711612210; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlzptlKCan7FzrZvOG6zSbotTVIToSrb2LNogTEvEVs=;
        b=maCKJeOOafytkf73Igyk6lWaNDtgp14FxTNFVQ/oww0PQALvjJRxiYiN3RWCRcNR8w
         6F9g5GTeop2s1E6FIhrFvK7neVWVIjgctD1cFHKfvA44yr1yLH3e9XZOoRN0rX3qNHFS
         8FwNhvjIMBrhKliNRWQp2e7Pgb5Y3YitPXkFuKvn0tDGN7TtGdja6mf1843nFaB3NGrC
         /bbbmvS3NzrKJ9u40Sy8Ak/AFjIe5qwEU6f0HKWs3FLYXZtdGjupwKgDJHbDOXWRNybg
         bAEaSJS+detJm9hA1Ev1XBkEMknaZKauGp5Drv5rUjuv/j6JEQapnOIP8Je5w+81XIFN
         n+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711007410; x=1711612210;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlzptlKCan7FzrZvOG6zSbotTVIToSrb2LNogTEvEVs=;
        b=njDVY1nKY+x6GvysXyQRBJQOQ6ywXeswrJcZo0oneiQOpzd3pktPSwaxzRy3AwiTNJ
         0ctHWylcOcEWHTQWOtOEYTPmzZfVdyDNRtmG/spUhqtyZCHM5bznOBMuix5zMF1qYI01
         BEA+3QnvOUVmxn1ZHi+Ex61LuN+SNYr84/EWgjRa2JCPqu/Mq4dgK164todZYFL4ru/6
         1Nv9nwg7dmLALBX0aXBCIGHLuJ6be2EwV1KwcZI8apiSvtz4o6gBVMuWdXsKLB8JQ96f
         80a789Ux0R2I3SojfJxCk2OXyePXaTPLABXFhx92lccQYunreUehTAulQeLEPNIjT0LW
         IRxw==
X-Forwarded-Encrypted: i=1; AJvYcCUmgn3zrzSQNsJlotbqo1p2+TpOXckUkIJWXkBWms6cG/Gj9g6Jsexuj0nreAPUIt3+4daHCBJHN4TzR6hW0EXK1mUbXmL07zM1c6883tgo8G2ZKSbzMa3rYbEkETe+oQB1ThHbBE8W
X-Gm-Message-State: AOJu0YwrW0NrRhHE6kAQstvMq8/ifh0p/80jZYpGPCoioz2PpJfbEfdZ
	nwsfqWStH6WOdFkcVsMMnC3iVAHBjfUxVwCnitCsQPvbgGI7QkvaDSEbnW9E
X-Google-Smtp-Source: AGHT+IHOu64Q+AOIZIcgcE9O20EUksyFd4Kg/L7XKUtFsmYTYUpbXQJ+vxC0vIUzEo/ddmfn7Veeww==
X-Received: by 2002:a2e:874d:0:b0:2d2:af88:8947 with SMTP id q13-20020a2e874d000000b002d2af888947mr13948457ljj.15.1711007410309;
        Thu, 21 Mar 2024 00:50:10 -0700 (PDT)
Received: from [192.168.1.253] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id p1-20020a05600c1d8100b004146bda6c32sm4637096wms.9.2024.03.21.00.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 00:50:09 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 21 Mar 2024 08:49:55 +0100
Subject: [PATCH v2 2/6] clk: qcom: apss-ipq-pll: move Huayra register map
 to 'clk_alpha_pll_regs'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-apss-ipq-pll-cleanup-v2-2-201f3cf79fd4@gmail.com>
References: <20240321-apss-ipq-pll-cleanup-v2-0-201f3cf79fd4@gmail.com>
In-Reply-To: <20240321-apss-ipq-pll-cleanup-v2-0-201f3cf79fd4@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

Move the locally defined Huayra register map to 'clk_alpha_pll_regs'
in order to allow using that by other drivers, like the clk-cbf-8996.

No functional changes.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v2:
 - rework the patch as requested by Dmitry Baryshkov by moving the register
   map into clk-alpha-pll.c instead of keeping that locally
 - Link to v1: https://lore.kernel.org/r/20240318-apss-ipq-pll-cleanup-v1-2-52f795429d5d@gmail.com
---
 drivers/clk/qcom/apss-ipq-pll.c  | 20 +-------------------
 drivers/clk/qcom/clk-alpha-pll.c | 10 ++++++++++
 drivers/clk/qcom/clk-alpha-pll.h |  1 +
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index ed3e6405f99cb..8cf17374a2e2a 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -8,27 +8,9 @@
 
 #include "clk-alpha-pll.h"
 
-/*
- * Even though APSS PLL type is of existing one (like Huayra), its offsets
- * are different from the one mentioned in the clk-alpha-pll.c, since the
- * PLL is specific to APSS, so lets the define the same.
- */
-static const u8 ipq_pll_offsets[][PLL_OFF_MAX_REGS] = {
-	[CLK_ALPHA_PLL_TYPE_HUAYRA] =  {
-		[PLL_OFF_L_VAL] = 0x08,
-		[PLL_OFF_ALPHA_VAL] = 0x10,
-		[PLL_OFF_USER_CTL] = 0x18,
-		[PLL_OFF_CONFIG_CTL] = 0x20,
-		[PLL_OFF_CONFIG_CTL_U] = 0x24,
-		[PLL_OFF_STATUS] = 0x28,
-		[PLL_OFF_TEST_CTL] = 0x30,
-		[PLL_OFF_TEST_CTL_U] = 0x34,
-	},
-};
-
 static struct clk_alpha_pll ipq_pll_huayra = {
 	.offset = 0x0,
-	.regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_HUAYRA],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_HUAYRA_APSS],
 	.flags = SUPPORTS_DYNAMIC_UPDATE,
 	.clkr = {
 		.enable_reg = 0x0,
diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 55a77e36dc44c..ba039b2b24a09 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -82,6 +82,16 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_TEST_CTL_U] = 0x20,
 		[PLL_OFF_STATUS] = 0x24,
 	},
+	[CLK_ALPHA_PLL_TYPE_HUAYRA_APSS] =  {
+		[PLL_OFF_L_VAL] = 0x08,
+		[PLL_OFF_ALPHA_VAL] = 0x10,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_CONFIG_CTL] = 0x20,
+		[PLL_OFF_CONFIG_CTL_U] = 0x24,
+		[PLL_OFF_STATUS] = 0x28,
+		[PLL_OFF_TEST_CTL] = 0x30,
+		[PLL_OFF_TEST_CTL_U] = 0x34,
+	},
 	[CLK_ALPHA_PLL_TYPE_BRAMMO] =  {
 		[PLL_OFF_L_VAL] = 0x04,
 		[PLL_OFF_ALPHA_VAL] = 0x08,
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index a1a75bb12fe88..d057955138952 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -15,6 +15,7 @@
 enum {
 	CLK_ALPHA_PLL_TYPE_DEFAULT,
 	CLK_ALPHA_PLL_TYPE_HUAYRA,
+	CLK_ALPHA_PLL_TYPE_HUAYRA_APSS,
 	CLK_ALPHA_PLL_TYPE_BRAMMO,
 	CLK_ALPHA_PLL_TYPE_FABIA,
 	CLK_ALPHA_PLL_TYPE_TRION,

-- 
2.44.0


