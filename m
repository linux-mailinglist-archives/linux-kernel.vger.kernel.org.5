Return-Path: <linux-kernel+bounces-69926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB6D85905E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2001F21933
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAE07E10C;
	Sat, 17 Feb 2024 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEqGR0C+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF37C0B2;
	Sat, 17 Feb 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708182183; cv=none; b=CCoKO7Hg7fdIT2keUiUAWP01m1eXRKD8AKYcnEj0U6+FlihDjxcAh8Q+T2dnJypmoeIE9+irhjIxXl2Nendw+dUWsDyrSWp2VbXDptZeH6mG3Q2SoYSNzfpg4r1KkiDmkWexegV62kCSRwGBcPIegFIW3I2oE8k1M0oEqxJxoCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708182183; c=relaxed/simple;
	bh=POmhG3XikVsaXc0RusI64Jf3HUeMzGtS54gIumrv1I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gy0UdPF/6SgLV2fqa2DD/a/eOGnC2H273mobdv9NNxfkgg9hs+wui+w78Tq3wRQSKx/X45K2+vLJLWxhDPXbEsfHOvMMrBgG6z6V5vhWDT45eYGUrDpbotiMQNTzsnNJIRvxX23zP6lrVC/RPfc+qr0i72CB4rHWjoP3EQTZScM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEqGR0C+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17518C433B1;
	Sat, 17 Feb 2024 15:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708182183;
	bh=POmhG3XikVsaXc0RusI64Jf3HUeMzGtS54gIumrv1I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eEqGR0C+9C6T6cV2g4R/ygaPvBNcGscgTTbDfWpt6RqNCVCSNemlDmMiBjLINFF9K
	 vNOWBEXAul5FUj2axKYGDdckCtDO4TfXoy/tk+8sx+M+Nax3pT9M4+S/bHKHCxiynt
	 JVidLDi1X3iyquM1kp0a0kub0LV/yLpN3RHEru2kNVYZ1+NxnuinFZsD6q3h74J/bF
	 QqKCFNwEidPJOkwPHGJM73U2yVQ+4BuksOAvfFpAIVLuaZV050HXeu1xqCZl2QDBHY
	 upv4mvxbKoOiSRj0B/wbcx4RIR8QiHUJlV8SjhAA3Z57ya1yYljjfWRvPgLGCifDKc
	 1sh5+H+c0Jn0g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rbMDW-000000001Vo-2L8p;
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
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/6] drm/bridge: aux-hpd: fix OF node leaks
Date: Sat, 17 Feb 2024 16:02:23 +0100
Message-ID: <20240217150228.5788-2-johan+linaro@kernel.org>
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

The two device node references taken during allocation need to be
dropped when the auxiliary device is freed.

Fixes: 6914968a0b52 ("drm/bridge: properly refcount DT nodes in aux bridge drivers")
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/gpu/drm/bridge/aux-hpd-bridge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
index bb55f697a181..9e71daf95bde 100644
--- a/drivers/gpu/drm/bridge/aux-hpd-bridge.c
+++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
@@ -25,6 +25,7 @@ static void drm_aux_hpd_bridge_release(struct device *dev)
 	ida_free(&drm_aux_hpd_bridge_ida, adev->id);
 
 	of_node_put(adev->dev.platform_data);
+	of_node_put(adev->dev.of_node);
 
 	kfree(adev);
 }
@@ -74,6 +75,8 @@ struct device *drm_dp_hpd_bridge_register(struct device *parent,
 
 	ret = auxiliary_device_init(adev);
 	if (ret) {
+		of_node_put(adev->dev.platform_data);
+		of_node_put(adev->dev.of_node);
 		ida_free(&drm_aux_hpd_bridge_ida, adev->id);
 		kfree(adev);
 		return ERR_PTR(ret);
-- 
2.43.0


