Return-Path: <linux-kernel+bounces-69922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E86859059
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63A42831D2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349187CF12;
	Sat, 17 Feb 2024 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk3HLJ7y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C57C69DE6;
	Sat, 17 Feb 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708182183; cv=none; b=gM8RWOfn6NNZ68WQz7UT9hMzZiVHcW74gbNNYuDeKHdjkd/PYw9Rywoh+gtcGnMV1ZmWWD7/Yz8l4kEbWNhf/+g/ophwB7727sKrS97XgUSaTZAMHQsK5lKrI/vDyZKbw8t7tPQV5/ws1WOpWhjzoGTg3qPGcPHtDirAVjC/l3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708182183; c=relaxed/simple;
	bh=E7peNP5XvxWfotZQJXcvlEV4QrXxAGb8fVXnSMSgPFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZJzgc/FrqRSoY0oAUvFEBcCrK/VV+eip2dXuU9tCmAr5v+yJVWZ3fQkACnriFgWrvatSTDRvai2ghIRGlbUzNPu36QDWg8tfEM7QLUJMPwohxMF6XOKzKCFuq6lFctGy9KtvFuasoTxfnOKm1HeeRgd+7ZTtVQR9C+2d4YMJRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk3HLJ7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E98C433F1;
	Sat, 17 Feb 2024 15:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708182183;
	bh=E7peNP5XvxWfotZQJXcvlEV4QrXxAGb8fVXnSMSgPFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dk3HLJ7yF2q4ypNSoZdXkmm0aPgQCR7FYvJT9iw+lGINaaGvc2xX2ebCULvFlg36z
	 kg3r/qLyz+ERxutx4KEI5MbR/7iNf/Lpm/fYTcaE+tSB7UCJwcQKuJhvet4uGTQvbj
	 rof9weCUaGRieOlItOAbq7is6pzcG8M8db3wJjwnOFJ/7zE/wgx/Qr+R0/0bmWe4xC
	 tgkDLMNz3/jO7oNW6ZrSxB6yKgxga37TRMVA5DSDXRnjIws81+QskGbPRszwbtPE/b
	 NUhdJgV3ly89vY/6IBys0iGEqVscmwG5scY0CA2Nod9ifVSTAzeYdt0OSDnzlv+eyP
	 5eDMgBOxAdAvA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rbMDW-000000001Vy-47Zd;
	Sat, 17 Feb 2024 16:03:03 +0100
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
Subject: [PATCH 6/6] phy: qcom-qmp-combo: fix type-c switch registration
Date: Sat, 17 Feb 2024 16:02:28 +0100
Message-ID: <20240217150228.5788-7-johan+linaro@kernel.org>
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

Move registration of the typec switch to after looking up clocks and
other resources.

Note that PHY creation can in theory also trigger a probe deferral when
a 'phy' supply is used. This does not seem to affect the QMP PHY driver
but the PHY subsystem should be reworked to address this (i.e. by
separating initialisation and registration of the PHY).

Fixes: 2851117f8f42 ("phy: qcom-qmp-combo: Introduce orientation switching")
Cc: stable@vger.kernel.org      # 6.5
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index e19d6a084f10..17c4ad7553a5 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -3562,10 +3562,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = qmp_combo_typec_switch_register(qmp);
-	if (ret)
-		return ret;
-
 	/* Check for legacy binding with child nodes. */
 	usb_np = of_get_child_by_name(dev->of_node, "usb3-phy");
 	if (usb_np) {
@@ -3585,6 +3581,10 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_node_put;
 
+	ret = qmp_combo_typec_switch_register(qmp);
+	if (ret)
+		goto err_node_put;
+
 	ret = drm_aux_bridge_register(dev);
 	if (ret)
 		goto err_node_put;
-- 
2.43.0


