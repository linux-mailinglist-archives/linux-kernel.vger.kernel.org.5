Return-Path: <linux-kernel+bounces-132271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 309BE899249
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42EDA1C22595
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFC313C696;
	Thu,  4 Apr 2024 23:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YDCPsRK8"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF913C3DE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712274232; cv=none; b=scoHDt2yc+/7Bn32OEE1GJQj0c9MtBx+iCtX7DMS6Vc6DB0MErZRTiHvvW2ob1woaIS74r0XPJNEz524N11Dk10W7re3bo3Efk39TjR4ay4QkCO41eLxqKmjAtomryvwjVE8E7+pz5gh/d5B/z5vpNlCV7w3lxI6tX2U1AG/e8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712274232; c=relaxed/simple;
	bh=JJPz/P2CcR2ZufWiDJCZzZH/1OFiSj5m3Mdo8cC++Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=okclUya1HwfCSf+qoC9Zc7aIF65DyzSbqG2YEr0vGo8+P4bH9zhKZGft1FIZyxlnYfRbMnWmMVykUiST6OiQi318LhZ/DYhCEe4obDMYFl0ClVeVfMWDE/baG60WgFG9zFlYF1YxTXD0kDUqfTFLOdfVJZjKZF06gOUwr4/8NQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YDCPsRK8; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so1451211a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 16:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712274229; x=1712879029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RMI5yWOLAVIgIkbCc96VWxktkn/9P3095VY77NHNd1o=;
        b=YDCPsRK8OhajbKvIhfTJub2L64/s9EM6WJdQPsXmJ7Sc/0oPsmAJrtX5Z1dTLr1yva
         sKQIJy8w9rdGGLt9mVG9XiYKzf44O6N6O6gE/qZOJK7u/cjX/zFkZZ01dfxSBWWsTlp1
         nym5Ay1AzbiYtrpInNNcN7GX/KeStG3Hs9TM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712274229; x=1712879029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMI5yWOLAVIgIkbCc96VWxktkn/9P3095VY77NHNd1o=;
        b=XElWHY2nXpEcKMbpd2Monu2SlU13cWvqqkk/ev+zBAHPx79kitMsdiiNdeX1JPikhY
         vilzqWPaDXJNUbwVlxgUb2Jhq7lizsbgtyGRc4PvyG9Z0qKyVfehnesv7gj3gNcJR9SU
         bLAlgHPP2nloAICpFLouhOqpE3PAd55iq2OxUfEYk3taXZhp6V4F4olNAolksOUSohOE
         nV+PIG7ukANUyj9mqyJhZ+JV635yLGP8gKlhlEcjstwgNB0TmAK0pcEvPp9elRwyij9s
         lTn6WXYC+/ZuqHJuItSRw+Jq6LOa5nBZZx6IanAy7cjK9mPJRDHirwSfx0VRonzZh6V1
         +xnQ==
X-Gm-Message-State: AOJu0YyKeHl83WxwJdBWQEEYIS366rFGapf3LuCnwGpe8pfO74clLcTn
	Z3pj5fLt+R+4tWQPcyK3tiz7wubI4/Z2YTsZAVLceGVWUqA7ywAGMeMncwJTbp2bzilPIWH4dtw
	=
X-Google-Smtp-Source: AGHT+IEXZdsBDxClfnWn4V8ckwcGELQZihfoKdxkgEQZf2dDcxavcBDgDIZ9TfrbOn0Q57NFbPr69Q==
X-Received: by 2002:a05:6a20:1057:b0:1a3:6bb1:92fb with SMTP id gt23-20020a056a20105700b001a36bb192fbmr45166pzc.19.1712274228928;
        Thu, 04 Apr 2024 16:43:48 -0700 (PDT)
Received: from localhost (4.198.125.34.bc.googleusercontent.com. [34.125.198.4])
        by smtp.gmail.com with UTF8SMTPSA id ga16-20020a17090b039000b002a2b06cbe46sm269450pjb.22.2024.04.04.16.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 16:43:47 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-phy@lists.infradead.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	freedreno@lists.freedesktop.org,
	Douglas Anderson <dianders@chromium.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH] phy: qcom: qmp-combo: Fix VCO div offset on v3
Date: Thu,  4 Apr 2024 16:43:44 -0700
Message-ID: <20240404234345.1446300-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ec17373aebd0 ("phy: qcom: qmp-combo: extract common function to
setup clocks") changed the offset that is used to write to
DP_PHY_VCO_DIV from QSERDES_V3_DP_PHY_VCO_DIV to
QSERDES_V4_DP_PHY_VCO_DIV. Unfortunately, this offset is different
between v3 and v4 phys:

 #define QSERDES_V3_DP_PHY_VCO_DIV                 0x064
 #define QSERDES_V4_DP_PHY_VCO_DIV                 0x070

meaning that we write the wrong register on v3 phys now. Add another
generic register to 'regs' and use it here instead of a version specific
define to fix this.

This was discovered after Abhinav looked over register dumps with me
from sc7180 Trogdor devices that started failing to light up the
external display with v6.6 based kernels. It turns out that some
monitors are very specific about their link clk frequency and if the
default power on reset value is still there the monitor will show a
blank screen or a garbled display. Other monitors are perfectly happy to
get a bad clock signal.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: ec17373aebd0 ("phy: qcom: qmp-combo: extract common function to setup clocks")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 7d585a4bbbba..3b19d8ebf467 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -77,6 +77,7 @@ enum qphy_reg_layout {
 	QPHY_COM_BIAS_EN_CLKBUFLR_EN,
 
 	QPHY_DP_PHY_STATUS,
+	QPHY_DP_PHY_VCO_DIV,
 
 	QPHY_TX_TX_POL_INV,
 	QPHY_TX_TX_DRV_LVL,
@@ -102,6 +103,7 @@ static const unsigned int qmp_v3_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_COM_BIAS_EN_CLKBUFLR_EN]	= QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN,
 
 	[QPHY_DP_PHY_STATUS]		= QSERDES_V3_DP_PHY_STATUS,
+	[QPHY_DP_PHY_VCO_DIV]		= QSERDES_V3_DP_PHY_VCO_DIV,
 
 	[QPHY_TX_TX_POL_INV]		= QSERDES_V3_TX_TX_POL_INV,
 	[QPHY_TX_TX_DRV_LVL]		= QSERDES_V3_TX_TX_DRV_LVL,
@@ -126,6 +128,7 @@ static const unsigned int qmp_v45_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_COM_BIAS_EN_CLKBUFLR_EN]	= QSERDES_V4_COM_BIAS_EN_CLKBUFLR_EN,
 
 	[QPHY_DP_PHY_STATUS]		= QSERDES_V4_DP_PHY_STATUS,
+	[QPHY_DP_PHY_VCO_DIV]		= QSERDES_V4_DP_PHY_VCO_DIV,
 
 	[QPHY_TX_TX_POL_INV]		= QSERDES_V4_TX_TX_POL_INV,
 	[QPHY_TX_TX_DRV_LVL]		= QSERDES_V4_TX_TX_DRV_LVL,
@@ -2162,6 +2165,7 @@ static int qmp_combo_configure_dp_clocks(struct qmp_combo *qmp)
 	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
 	u32 phy_vco_div;
 	unsigned long pixel_freq;
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
 
 	switch (dp_opts->link_rate) {
 	case 1620:
@@ -2184,7 +2188,7 @@ static int qmp_combo_configure_dp_clocks(struct qmp_combo *qmp)
 		/* Other link rates aren't supported */
 		return -EINVAL;
 	}
-	writel(phy_vco_div, qmp->dp_dp_phy + QSERDES_V4_DP_PHY_VCO_DIV);
+	writel(phy_vco_div, qmp->dp_dp_phy + cfg->regs[QPHY_DP_PHY_VCO_DIV]);
 
 	clk_set_rate(qmp->dp_link_hw.clk, dp_opts->link_rate * 100000);
 	clk_set_rate(qmp->dp_pixel_hw.clk, pixel_freq);

base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
https://chromeos.dev


