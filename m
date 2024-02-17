Return-Path: <linux-kernel+bounces-70016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD27F8591CB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62439B21033
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F567E0E8;
	Sat, 17 Feb 2024 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="uvw3HgWW"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED4A1D681
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708195195; cv=none; b=BHS2yekYW1YqdzA4COUgKbgPuoi+6zGqblu7PYNil9aBa0fOdXn2ByQDoq+vwOd2r1lkUqPQl6wVlMg85sau68YD1uzEtSrOvO1JmNQ/HK/mHZvYXBELsqmi97B/aU6pqy7/v8bGcPrq7QJqzYZxi8NTcjERcyxOUQcWK0KljjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708195195; c=relaxed/simple;
	bh=RGT4BBgnm1LR3lAuyD4pvnFiAKoTJKy/hJEE6iV4fGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CaR3M1D6CZBBqfntptrlpJpSZMoq+iW49I6XaRiXGqDD/CuPtb9X/XryZ7Q/PhfIylzAjmResPmt6dGk2iGFxyUvg6PkWQJpTUMeWPtoYCM/cavWSU29DKvV4oRd226qouhMDCOfvDHd1DK3AueZTtK01WCaKH8Kk8zdBWuGo68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=uvw3HgWW; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708195188; bh=RGT4BBgnm1LR3lAuyD4pvnFiAKoTJKy/hJEE6iV4fGM=;
	h=From:To:Cc:Subject:Date:From;
	b=uvw3HgWWmY7+Xkbi4vxj22xCzuVWwCZ39hTQkerpKso/6Ibs1WEJS6+0wQH1pQlGF
	 OddB8sxShAxmi6ngu4OMAuvttfPFJotsZuSXhLlOm5AD6V+wU+BL3+SyC3eSg5S1JS
	 QiStiQtoBi5I88joo1223xC97L8PRTi8hW263ePA=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org
Cc: Ondrej Jirman <megi@xff.cz>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ROCKCHIP),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH] drm: rockchip: Don't require MIPI DSI device when it's used for ISP
Date: Sat, 17 Feb 2024 19:39:40 +0100
Message-ID: <20240217183941.1752463-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

On RK3399 one MIPI DSI device can be alternatively used with the ISP1,
to provide RX DPHY. When this is the case (ISP1 is enabled in device
tree), probe success of DRM is tied to probe success of ISP1 connected
camera sensor. This can fail if the user is able to killswitch the camera
power, like on Pinephone Pro.

Detect use of MIPI DSI controller by ISP, and don't include it in
component match list in that case.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 47 +++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index ab55d7132550..f47de94ad576 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -354,6 +354,43 @@ static void rockchip_drm_match_remove(struct device *dev)
 		device_link_del(link);
 }
 
+/*
+ * Check if ISP block linked to a mipi-dsi device via phys phandle is
+ * enabled in device tree.
+ */
+static bool rockchip_drm_is_mipi1_and_used_by_isp(struct device *dev)
+{
+	struct device_node *np = NULL, *phy_np;
+
+	if (!of_device_is_compatible(dev->of_node, "rockchip,rk3399-mipi-dsi"))
+		return false;
+
+	while (true) {
+		np = of_find_compatible_node(np, NULL, "rockchip,rk3399-cif-isp");
+		if (!np)
+			break;
+
+		if (!of_device_is_available(np)) {
+			of_node_put(np);
+			continue;
+		}
+
+		phy_np = of_parse_phandle(np, "phys", 0);
+		if (!phy_np) {
+			of_node_put(np);
+			continue;
+		}
+
+		of_node_put(phy_np);
+		of_node_put(np);
+
+		if (phy_np == dev->of_node)
+			return true;
+	}
+
+	return false;
+}
+
 static struct component_match *rockchip_drm_match_add(struct device *dev)
 {
 	struct component_match *match = NULL;
@@ -371,6 +408,16 @@ static struct component_match *rockchip_drm_match_add(struct device *dev)
 			if (!d)
 				break;
 
+			/*
+			 * If mipi1 is connected to ISP, we don't want to wait for mipi1 component,
+			 * because it will not be used by DRM anyway, to not tie success of camera
+			 * driver probe to display pipeline initialization.
+			 */
+			if (rockchip_drm_is_mipi1_and_used_by_isp(d)) {
+				dev_info(d, "used by ISP1, skipping from DRM\n");
+				continue;
+			}
+
 			device_link_add(dev, d, DL_FLAG_STATELESS);
 			component_match_add(dev, &match, component_compare_dev, d);
 		} while (true);
-- 
2.43.0


