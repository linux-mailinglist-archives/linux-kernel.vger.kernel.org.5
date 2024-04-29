Return-Path: <linux-kernel+bounces-162965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78208B62C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBAE9283813
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F87413B2BC;
	Mon, 29 Apr 2024 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M7EWROTE"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352913AD3E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419976; cv=none; b=BZlyZfMoJQXpbk1pmpWCejwihEczwXFoR5nneI4ZjPXWASODjQWk6Z7C//XD84Wgyl57rY2ZgHhpD6fsk29MdtyfIU9yXk/1XsnzzWRcskOc0BIOjfFEHh9T25RIq6sDk7Yxrr5+znxBFOA6iV6crQQorGSBA/GowCHy0bG1wT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419976; c=relaxed/simple;
	bh=Fflv2happyBtuC7pAoLoJyMtZKZg3vbQFe9oCckEd2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRyI/wYd8U1ZmFKSS51KJ7lPhCGTXaaYncBujVJSVenjkqA0HuUfISgEOROK82StalYu+jynrj2juGJFXSbd8cCHVewJSTqSVy6yTUlsqHC/HY9U93zEri6ke0TXeql0glHBLR+CIQPrIljoxqWl2pNEFIs85jedQ67MDwjiJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M7EWROTE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so40056075ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714419975; x=1715024775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QjCg8SYenXS+XuIi5qqPpTiXsYXZeRvUkEwlZZQZlc=;
        b=M7EWROTEIEMVgjPqceUVtdRpjHqOZrJVFvgyTMEe4QpVpUbyj76J5RGydPOPZG21Ib
         bgqS667BfYX/rXh4SW/oR1j+8EIHw4umY1hoW8ThQeruDYc/2OpxRJdS9+49GkXdJ9Zy
         qU0cBsIp7zJWK+PBAQzL5t7z1Kly1cko4P3MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419975; x=1715024775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QjCg8SYenXS+XuIi5qqPpTiXsYXZeRvUkEwlZZQZlc=;
        b=wcHCPF00WcVxDT9iCWRzoXaXv7+pgcbbqd9kTlY7rd9+sqD3R61nJmERmIuO2mGPU2
         RP+cj+tc31gYMq1MRdtP6plNb7RWxr96ZICIDyZkVI9UczdVrFVzazwcPTN00hDZ+2VM
         XzpZaTy9WY/gVMDpd/ke3OtwQ4cGv5ix0SbIA5T2Olu/q/x7nFeR6JM2k/SzsHtBtpXh
         g0vi3QufDhCPipG2jTTMjMj2NB+hryeVOQIHa8aoC2994H9eD7eQN0+CwU/amMXAlNYS
         CclyNUTECjiV+y8lQfHNQGzrPuVMSfMcxd7kxfBuVkLJPcKzyJvX2oUXMNsXdtU741GG
         5KkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeiQRWX/OK4QgRCGOrdb8cwrZFF4q4zM/eTZGAFbCn81cHWo49sao47WwhWKbnbmF9kL193x1jLmVDMuappl+rFUpHDQYIVXpizjBB
X-Gm-Message-State: AOJu0YxgEJZu0Jy/JQ/acF/D9wQ+ZfuFg+Q3+ro+uRY6S9XFqCuK0VPR
	FsT8p1fG079T9B6GskM/2o1a0+ofoU7B+p3pVG0XWSVGxLAjHmILFGoAgll/EA==
X-Google-Smtp-Source: AGHT+IFvxwrm+Nf34l1bmpd2F1KsT83NJku+4ZXZlMzkvoySXOfcschxgtys9x2RHfgzmnb0ut+qdA==
X-Received: by 2002:a17:903:40cc:b0:1e4:a667:550e with SMTP id t12-20020a17090340cc00b001e4a667550emr10072628pld.20.1714419974796;
        Mon, 29 Apr 2024 12:46:14 -0700 (PDT)
Received: from localhost (4.198.125.34.bc.googleusercontent.com. [34.125.198.4])
        by smtp.gmail.com with UTF8SMTPSA id o16-20020a170902d4d000b001eb3f4e96c2sm5236162plg.157.2024.04.29.12.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 12:46:14 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.8.y] phy: qcom: qmp-combo: fix VCO div offset on v5_5nm and v6
Date: Mon, 29 Apr 2024 12:46:12 -0700
Message-ID: <20240429194612.3412821-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
In-Reply-To: <2024042918-jet-harmonica-e767@gregkh>
References: <2024042918-jet-harmonica-e767@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan+linaro@kernel.org>

Commit 5abed58a8bde ("phy: qcom: qmp-combo: Fix VCO div offset on v3")
fixed a regression introduced in 6.5 by making sure that the correct
offset is used for the DP_PHY_VCO_DIV register on v3 hardware.

Unfortunately, that fix instead broke DisplayPort on v5_5nm and v6
hardware as it failed to add the corresponding offsets also to those
register tables.

Fixes: 815891eee668 ("phy: qcom-qmp-combo: Introduce orientation variable")
Fixes: 5abed58a8bde ("phy: qcom: qmp-combo: Fix VCO div offset on v3")
Cc: stable@vger.kernel.org	# 6.5: 5abed58a8bde
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Link: https://lore.kernel.org/r/20240408093023.506-1-johan+linaro@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
(cherry picked from commit 025a6f7448f7bb5f4fceb62498ee33d89ae266bb)
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 2 ++
 drivers/phy/qualcomm/phy-qcom-qmp.h       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index d83859e955a8..dee666f8e29e 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -188,6 +188,7 @@ static const unsigned int qmp_v5_5nm_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_COM_BIAS_EN_CLKBUFLR_EN]	= QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN,
 
 	[QPHY_DP_PHY_STATUS]		= QSERDES_V5_DP_PHY_STATUS,
+	[QPHY_DP_PHY_VCO_DIV]		= QSERDES_V5_DP_PHY_VCO_DIV,
 
 	[QPHY_TX_TX_POL_INV]		= QSERDES_V5_5NM_TX_TX_POL_INV,
 	[QPHY_TX_TX_DRV_LVL]		= QSERDES_V5_5NM_TX_TX_DRV_LVL,
@@ -212,6 +213,7 @@ static const unsigned int qmp_v6_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_COM_BIAS_EN_CLKBUFLR_EN]	= QSERDES_V6_COM_PLL_BIAS_EN_CLK_BUFLR_EN,
 
 	[QPHY_DP_PHY_STATUS]		= QSERDES_V6_DP_PHY_STATUS,
+	[QPHY_DP_PHY_VCO_DIV]		= QSERDES_V6_DP_PHY_VCO_DIV,
 
 	[QPHY_TX_TX_POL_INV]		= QSERDES_V6_TX_TX_POL_INV,
 	[QPHY_TX_TX_DRV_LVL]		= QSERDES_V6_TX_TX_DRV_LVL,
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 6923496cbfee..49ceded9b3cb 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -132,9 +132,11 @@
 #define QSERDES_V4_DP_PHY_AUX_INTERRUPT_STATUS		0x0d8
 #define QSERDES_V4_DP_PHY_STATUS			0x0dc
 
+#define QSERDES_V5_DP_PHY_VCO_DIV			0x070
 #define QSERDES_V5_DP_PHY_STATUS			0x0dc
 
 /* Only for QMP V6 PHY - DP PHY registers */
+#define QSERDES_V6_DP_PHY_VCO_DIV			0x070
 #define QSERDES_V6_DP_PHY_AUX_INTERRUPT_STATUS		0x0e0
 #define QSERDES_V6_DP_PHY_STATUS			0x0e4
 
-- 
https://chromeos.dev


