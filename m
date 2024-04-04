Return-Path: <linux-kernel+bounces-131877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4C5898D09
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9DB1C21C29
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7222412DD9E;
	Thu,  4 Apr 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vpn91npP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AE512BF22
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712250708; cv=none; b=Rslg7eSRCvbUvJ0PfzEk9pIuUq+aRJ2EY7xiYBGWXHyDNTNGs0JL5vnAw5h0wbuLh/Gb2gv+vphZDx6QND+Cy+yMgzDei5VKC90HUOKvmPJSjQZs+OG0U81ixQdFHzDXoTMHJ7yHhDD7i4ii+5BJ/L2MJpRlPXx9o6LLsVermuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712250708; c=relaxed/simple;
	bh=zpcDdIVvxk4yTaOZWfHubR8U8kouQobSWnPDR+JrX58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kqejjBft5L6wdbv/EcH0UhSyf7YCGVkJ6Y2iFqPBNsTs7BrybhIAqrn2sgp9ysS8Bcez8ovQYKYBHGbB+AfFSDFCR0nttT8U48w6iBI8yWbjI9qdArdNRYY5LV+e5PuWeMG20TPD+39P1Co0OY0BgBg/A96wnk19afgYHj1DUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vpn91npP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D32C433C7;
	Thu,  4 Apr 2024 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712250708;
	bh=zpcDdIVvxk4yTaOZWfHubR8U8kouQobSWnPDR+JrX58=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vpn91npP+4SFkyWtexpENgtpgeswQ9B0bIVQK6cvg993MJ7PSBRnBpzlVKt4Z1rw4
	 umkOq8L1cEC6fwcY+1cXndxMJG41IYU0h4Gm/FC5hMNhA8ec+LfrRVLZq2KTd10D3+
	 CnHvz58YYAeNpsBH4lrRqbcZ7t7PadXFgRoVO4rxGO5w90nXvojIzAjLmUESswNByf
	 YlXUXtgXhrPmd+2PHhpsfYta90F1KRWi+7oCaUwFAkT3n7DzLtd5LaJ5Q/zqQmk0Yn
	 sDZTN5DECxFBEq1oItcaI2ZOJX3PNGWYdmmT+IeicrOCUSc6Ku0lMxxlNLzI2KZuBk
	 5x8oWwffhffLA==
Received: by jupiter.universe (Postfix, from userid 1000)
	id F2E3E4800CB; Thu,  4 Apr 2024 19:11:45 +0200 (CEST)
From: Sebastian Reichel <sre@kernel.org>
Date: Thu, 04 Apr 2024 19:11:26 +0200
Subject: [PATCH 1/3] phy: rockchip-snps-pcie3: fix bifurcation on rk3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-rk3588-pcie-bifurcation-fixes-v1-1-9907136eeafd@kernel.org>
References: <20240404-rk3588-pcie-bifurcation-fixes-v1-0-9907136eeafd@kernel.org>
In-Reply-To: <20240404-rk3588-pcie-bifurcation-fixes-v1-0-9907136eeafd@kernel.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Michal Tomek <mtdev79b@gmail.com>, 
 linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3163; i=sre@kernel.org;
 h=from:subject:message-id; bh=QBfngFq0t7GnmHjYosXbtXgARP5FS0HHZVN+7PXAdds=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGYO31EoJzzZciMxD/AnSu9WNJkPBP8UOvq8b
 2QdhSn5KuPcMokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJmDt9RAAoJENju1/PI
 O/qazSkP/Rpb4faAepRPTwOYYIWVDNQr9ZFkTsxGFAOa+QR5F2IvVOFh8jD2AI4FD9VnCbgE4IC
 efLWrIuR8gKuo2ykqtLEc5T+V0SvURfcD8QNDE9Twk/8zT+PZuROpDVfrBsWou00rgHAKrJah5+
 tMKGrq4q/OOsBQxfNZG1jABtIiFpWecrLd5zY4Kb8Rj+1lnFzKj3ivFCbMuMYCPPcCqJBdjycOf
 m7geZ0CNNLvIwOCTUXy6PWtbMiUwdCP40JRJxCIMtovKAnb4ARE19hMNUKhECuo6UWRQ5E/ALxe
 iuvTNBGCvevPryJ13RqqVE27ZnUzWa+zh0Y1FC1jOndKKGG7Zd90wNjJ5BqnMiXeOn+ME/1iIp4
 3eE4wWO+vXcL6kIxz0UGZuW9QTFAlOTCAtqNpAmlPdtIJuFtj8+aub1cD/mxy5ezmwvPEmtmYrO
 AxmzGaI1Ajq7EJAWmKRdrmkbR84UmGDTbWEV+tSQHhB29KK7exNPIzjudBp7j/4HkdM9T9SjTxC
 ttuDp8waxJjXix7P6BaAPtt/jrQF7cO1vfEY/MfEJGlR7GAMEFfL4aPkpsp55gpoXI/+2QwFogB
 2grBx4BAWdS9alx0KaaS0aiPxeSE5bqx6rNyshgyFY9Ak/fN0FiuA97BmSgTfolFQZaMzWM4shF
 qi8GOhaCg5tqCJUV66/knjA==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Michal Tomek <mtdev79b@gmail.com>

So far all RK3588 boards use fully aggregated PCIe. CM3588 is one
of the few boards using this feature and apparently it is broken.

The PHY offers the following mapping options:

  port 0 lane 0 - always mapped to controller 0 (4L)
  port 0 lane 1 - to controller 0 or 2 (1L0)
  port 1 lane 0 - to controller 0 or 1 (2L)
  port 1 lane 1 - to controller 0, 1 or 3 (1L1)

The data-lanes DT property maps these as follows:

  0 = no controller (unsupported by the HW)
  1 = 4L
  2 = 2L
  3 = 1L0
  4 = 1L1

That allows the following configurations with first column being the
mainline data-lane mapping, second column being the downstream name,
third column being PCIE3PHY_GRF_CMN_CON0 and PHP_GRF_PCIESEL register
values and final column being the user visible lane setup:

  <1 1 1 1> = AGGREG = [4 0] = x4 (aggregation)
  <1 1 2 2> = NANBNB = [0 0] = x2 x2 (no bif.)
  <1 3 2 2> = NANBBI = [1 1] = x2 x1x1 (bif. of port 0)
  <1 1 2 4> = NABINB = [2 2] = x1x1 x2 (bif. of port 1)
  <1 3 2 4> = NABIBI = [3 3] = x1x1 x1x1 (bif. of both ports)

The driver currently does not program PHP_GRF_PCIESEL correctly, which
is fixed by this patch. As a side-effect the new logic is much simpler
than the old logic.

Fixes: 2e9bffc4f713 ("phy: rockchip: Support PCIe v3")
Signed-off-by: Michal Tomek <mtdev79b@gmail.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
index 121e5961ce11..d5bcc9c42b28 100644
--- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
+++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
@@ -132,7 +132,7 @@ static const struct rockchip_p3phy_ops rk3568_ops = {
 static int rockchip_p3phy_rk3588_init(struct rockchip_p3phy_priv *priv)
 {
 	u32 reg = 0;
-	u8 mode = 0;
+	u8 mode = RK3588_LANE_AGGREGATION; /* default */
 	int ret;
 
 	/* Deassert PCIe PMA output clamp mode */
@@ -140,28 +140,20 @@ static int rockchip_p3phy_rk3588_init(struct rockchip_p3phy_priv *priv)
 
 	/* Set bifurcation if needed */
 	for (int i = 0; i < priv->num_lanes; i++) {
-		if (!priv->lanes[i])
-			mode |= (BIT(i) << 3);
-
 		if (priv->lanes[i] > 1)
-			mode |= (BIT(i) >> 1);
-	}
-
-	if (!mode)
-		reg = RK3588_LANE_AGGREGATION;
-	else {
-		if (mode & (BIT(0) | BIT(1)))
-			reg |= RK3588_BIFURCATION_LANE_0_1;
-
-		if (mode & (BIT(2) | BIT(3)))
-			reg |= RK3588_BIFURCATION_LANE_2_3;
+			mode &= ~RK3588_LANE_AGGREGATION;
+		if (priv->lanes[i] == 3)
+			mode |= RK3588_BIFURCATION_LANE_0_1;
+		if (priv->lanes[i] == 4)
+			mode |= RK3588_BIFURCATION_LANE_2_3;
 	}
 
+	reg = mode;
 	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_CMN_CON0, (0x7<<16) | reg);
 
 	/* Set pcie1ln_sel in PHP_GRF_PCIESEL_CON */
 	if (!IS_ERR(priv->pipe_grf)) {
-		reg = (mode & (BIT(6) | BIT(7))) >> 6;
+		reg = mode & 3;
 		if (reg)
 			regmap_write(priv->pipe_grf, PHP_GRF_PCIESEL_CON,
 				     (reg << 16) | reg);

-- 
2.43.0


