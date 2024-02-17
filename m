Return-Path: <linux-kernel+bounces-69921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6210185905A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182E81F219FA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EED57CF18;
	Sat, 17 Feb 2024 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYCrcRG2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5CA7B3D0;
	Sat, 17 Feb 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708182183; cv=none; b=PMggC/IGKfVt4fITT+X9KR3YntsvIBOAlljdQTwpxYKXpxUx7TW3d8s/JFGuUMAjNuYY8hELxAzxq2f4MU6KBsO6zozdMezxR1tBGPyQ63SNR6ZLLizBX+1ux36AUNi5KjSLv1vwHK4XP9HBxSU5hRlSUAEahMMohrzjbZWq3H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708182183; c=relaxed/simple;
	bh=gXXEjah83df2mjIZE6PBMMf9QLss5RTOxJWznY2GGWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkLjS7Tarl/0VQ5x/BLpigBRZzt4Zl1pzWFTd2D+fDLf7Tr5B5zt+u4GC7g1R7p9WpJb3rgSkToLfq8/VDLV43bFUq+X5Aww53c+xf4Bg6CuRRucJ0NuXaFmp7C5LRnwt7nWmJjtLMFb6VL9qsXAAVUXbWizRi34mxmFkNwKZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYCrcRG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7A2C43394;
	Sat, 17 Feb 2024 15:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708182183;
	bh=gXXEjah83df2mjIZE6PBMMf9QLss5RTOxJWznY2GGWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YYCrcRG2Bd4HtdSjVhBFoyvNHGakjwLypXKacKIBHXJrLfhpQut/AO/LcBQ3Y0KjF
	 sPdXqHSXykK74eTVnJeNok7niPfXO0Czt/1YPR768rWKLabFR6u9U6X5zIoNHXtfCO
	 USZHcA9Rm8QSNKTbGnvdNY/kIjWyg4w+1ZXDETyizCJSpTAN1qQacxjTa7UDJF9A2O
	 msphIG/8uQP28WXSj7qoecFU1NmlhQEAP7CJjIeye7CoVAI4y/049aiTpZjWH59Xcd
	 XI5S8l0Qbk9Ya0xxP0z0xuzlJ6QUvVP0P3e4nAwJAmqIZ/HBGy+WfJdIV0A5NlROZa
	 yxMde5QWQVT1A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rbMDW-000000001Vw-3n8S;
	Sat, 17 Feb 2024 16:03:02 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: [PATCH 5/6] phy: qcom-qmp-combo: fix drm bridge registration
Date: Sat, 17 Feb 2024 16:02:27 +0100
Message-ID: <20240217150228.5788-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217150228.5788-1-johan+linaro@kernel.org>
References: <20240217150228.5788-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to a long-standing issue in driver core, drivers may not probe defer
after having registered child devices to avoid triggering a probe
deferral loop (see fbc35b45f9f6 ("Add documentation on meaning of
-EPROBE_DEFER")).

This could potentially also trigger a bug in the DRM bridge
implementation which does not expect bridges to go away even if device
links may avoid triggering this (when enabled).

Move registration of the DRM aux bridge to after looking up clocks and
other resources.

Note that PHY creation can in theory also trigger a probe deferral when
a 'phy' supply is used. This does not seem to affect the QMP PHY driver
but the PHY subsystem should be reworked to address this (i.e. by
separating initialisation and registration of the PHY).

Fixes: 35921910bbd0 ("phy: qcom: qmp-combo: switch to DRM_AUX_BRIDGE")
Fixes: 1904c3f578dc ("phy: qcom-qmp-combo: Introduce drm_bridge")
Cc: stable@vger.kernel.org      # 6.5
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 1ad10110dd25..e19d6a084f10 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -3566,10 +3566,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = drm_aux_bridge_register(dev);
-	if (ret)
-		return ret;
-
 	/* Check for legacy binding with child nodes. */
 	usb_np = of_get_child_by_name(dev->of_node, "usb3-phy");
 	if (usb_np) {
@@ -3589,6 +3585,10 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_node_put;
 
+	ret = drm_aux_bridge_register(dev);
+	if (ret)
+		goto err_node_put;
+
 	pm_runtime_set_active(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
-- 
2.43.0


