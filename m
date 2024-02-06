Return-Path: <linux-kernel+bounces-54352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD37084AE0E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9150E1F2248C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B957F7DD;
	Tue,  6 Feb 2024 05:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EdpKSXY5"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E17F484
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 05:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196919; cv=none; b=UQhQ9/GDIyzaiE4gIo7rCPhHry9vFbQ8zuUbmIC9dI55lV0oIjmvHYaEvP/OA+5Q/f/Obal4Oj3FpgsLJyGE6LFPmCZXQBvuATgosG/aFNudtARtcz8RJjCT/BKMSCm+GBSWfOFp3sRcWhwSC/tgLzrh6z4MJ8LZ2lYICdLbkAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196919; c=relaxed/simple;
	bh=9A41tRMvVT0HRkVDL46qeI1eqNXMwP9Vk2At0gdP17A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WKRSvo9N5YqmVoX6f7poX7RiPFO1x/H/CYPuvVacxYLtJ+Mm1NkYMkgDVBQcd9L34K5alWb8A/qPNhxTqES1E6x7hzAOYzfEDZfQWg9sfpw5vGaXfjJvvEqfBKt/eKoAf2XRpkBQELi+kZAZwxbAV4hhwY1tf8nwLp+uJHpN0Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=EdpKSXY5; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.251.226.97])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3A157975;
	Tue,  6 Feb 2024 06:20:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1707196831;
	bh=9A41tRMvVT0HRkVDL46qeI1eqNXMwP9Vk2At0gdP17A=;
	h=From:To:Cc:Subject:Date:From;
	b=EdpKSXY54c/nF68oGCaOegx1rI3C4z46fUilCKS0NdFnj6/gLQR8vHCOVSl7yDJKO
	 243Kswou8Y+ahqb8rgAVe9O7GN5dxYRbZeCp2+AUSlPfy3/m6gxunRFKZx7fjFzuU/
	 E//MjvyYMPac1l9KkpyCM6tsamcFqpQ93E57HOF8=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Adam Ford <aford173@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Rob Herring <robh@kernel.org>,
	NXP Linux Team <linux-imx@nxp.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Liu Ying <victor.liu@nxp.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH] drm/imx: Replace of_device.h with explicit includes
Date: Tue,  6 Feb 2024 10:51:46 +0530
Message-ID: <20240206052146.69779-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h.

of_device.h isn't needed, but of.h is for of_node_put().

This fixes the following build errors:
error: implicit declaration of function ‘platform_set_drvdata’ [-Werror=implicit-function-declaration]
error: implicit declaration of function ‘of_node_put’ [-Werror=implicit-function-declaration]

Fixes: 3075f087680b ("drm/imx: add driver for HDMI TX Parallel Video Interface")
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
index 962779dc539e..8a51a2ac8df1 100644
--- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
+++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
@@ -8,9 +8,10 @@
 #include <drm/drm_bridge.h>
 #include <drm/drm_crtc.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
 
 #define HTX_PVI_CTL	0x0
 #define  PVI_CTL_OP_VSYNC_POL	BIT(18)
-- 
2.41.0


