Return-Path: <linux-kernel+bounces-135148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F4989BBB8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C8B282967
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363014AEF8;
	Mon,  8 Apr 2024 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d70hueG3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2CD4AEC2;
	Mon,  8 Apr 2024 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712568657; cv=none; b=FbpQdtNTGZ2VRVroqNKM6G50BTopQlTK/BHNdZDhkRQTvymh7k6XQHELW5aPieO88Za1XsoK08QfrCQ1ntjof8/LBDW1pDGG/7/L+JfN6ZGE1yF2mGS0ZxvthuE1NsKmfzseX60iBLlFRq3imKyz4HYs5JogTfxsakFF6Zye8ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712568657; c=relaxed/simple;
	bh=YTvBQpF8N5UpnJKoybhSeGafUbBY3tM0aAczZzHt0T0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dGo549vzb0m/7Fo3IdDg1v7ydBg0L5sXYtX8egasX8j+ug47haoot5auv0Fw+20voZggqib2gUn4a/B2JGrAEaIUmOLVhDhmldFKZTOWV4SD9r02Qgzi4TnqUh03N9iDSCPiVf+Yko/1KtmeErEdzfsHVGAC2+kJjam9rycAtO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d70hueG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456C5C433C7;
	Mon,  8 Apr 2024 09:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712568657;
	bh=YTvBQpF8N5UpnJKoybhSeGafUbBY3tM0aAczZzHt0T0=;
	h=From:To:Cc:Subject:Date:From;
	b=d70hueG3GTfMf47ltZrYYL8BlExMVT7ZwmEdVzCx2FYmieUEinUJX5DntW1FnKIcK
	 NcoJNi6V1dJiKcVSvAkyQs7+JinfUlV7TOF0Llaj0wdUhgc2qNjKXXaIK5rYkwM/B2
	 KTbMtGh3TvOUdU/w49EuE6JkqVvYuM3u3Pcg/yKJdYoGrlmThuJbTleWhE82zXoicg
	 A/aSWfjpfkcPV3oLNGzvBZRMdYDYHuI4FmzorXirnniUga/BvkkgHcTU0Oilyz/9lE
	 yPbEkdG8ECae4j5CMMwVaD6vJmq4CyPR6kkswHuRrLbH7edwGlaliZUUIhwLrhnx0v
	 Vf0tD1LkWmLmg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rtlL0-0000000008u-2g79;
	Mon, 08 Apr 2024 11:30:51 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Stephen Boyd <swboyd@chromium.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH] phy: qcom: qmp-combo: fix VCO div offset on v5_5nm and v6
Date: Mon,  8 Apr 2024 11:30:23 +0200
Message-ID: <20240408093023.506-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 2 ++
 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v5.h | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v6.h | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index a03b6f6881df..e48e87c3cb05 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -153,6 +153,7 @@ static const unsigned int qmp_v5_5nm_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_COM_BIAS_EN_CLKBUFLR_EN]	= QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN,
 
 	[QPHY_DP_PHY_STATUS]		= QSERDES_V5_DP_PHY_STATUS,
+	[QPHY_DP_PHY_VCO_DIV]		= QSERDES_V5_DP_PHY_VCO_DIV,
 
 	[QPHY_TX_TX_POL_INV]		= QSERDES_V5_5NM_TX_TX_POL_INV,
 	[QPHY_TX_TX_DRV_LVL]		= QSERDES_V5_5NM_TX_TX_DRV_LVL,
@@ -177,6 +178,7 @@ static const unsigned int qmp_v6_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_COM_BIAS_EN_CLKBUFLR_EN]	= QSERDES_V6_COM_PLL_BIAS_EN_CLK_BUFLR_EN,
 
 	[QPHY_DP_PHY_STATUS]		= QSERDES_V6_DP_PHY_STATUS,
+	[QPHY_DP_PHY_VCO_DIV]		= QSERDES_V6_DP_PHY_VCO_DIV,
 
 	[QPHY_TX_TX_POL_INV]		= QSERDES_V6_TX_TX_POL_INV,
 	[QPHY_TX_TX_DRV_LVL]		= QSERDES_V6_TX_TX_DRV_LVL,
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v5.h
index f5cfacf9be96..181057421c11 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v5.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v5.h
@@ -7,6 +7,7 @@
 #define QCOM_PHY_QMP_DP_PHY_V5_H_
 
 /* Only for QMP V5 PHY - DP PHY registers */
+#define QSERDES_V5_DP_PHY_VCO_DIV			0x070
 #define QSERDES_V5_DP_PHY_AUX_INTERRUPT_STATUS		0x0d8
 #define QSERDES_V5_DP_PHY_STATUS			0x0dc
 
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v6.h
index 01a20d3be4b8..fa967a1af058 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v6.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v6.h
@@ -7,6 +7,7 @@
 #define QCOM_PHY_QMP_DP_PHY_V6_H_
 
 /* Only for QMP V6 PHY - DP PHY registers */
+#define QSERDES_V6_DP_PHY_VCO_DIV			0x070
 #define QSERDES_V6_DP_PHY_AUX_INTERRUPT_STATUS		0x0e0
 #define QSERDES_V6_DP_PHY_STATUS			0x0e4
 
-- 
2.43.2


