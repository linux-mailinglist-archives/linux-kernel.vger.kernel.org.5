Return-Path: <linux-kernel+bounces-62231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF524851D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4BA1C22505
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39C24177B;
	Mon, 12 Feb 2024 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pqnR+JiL"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B7941C87;
	Mon, 12 Feb 2024 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763990; cv=none; b=RALEd2YlfrJVQVPHaNQKyCpqdolvKhMx/tS2i3ulRRxet+3r+L7dYYqdjhh+LqWwHEI7akI28wIHHR1q6UskXi0Wg+K3qQBEQbv2EadfcwaHZgVqDrZmPOFSaxfbvqJ2mGm99IH35gsc2wSJXbipSNxPpadBgNT168MOvVUIL8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763990; c=relaxed/simple;
	bh=7nBNtyOe9B7di3tlfXkDPiWXRmeY0kYi18klzwAbx7M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SFF7JUghCQbArIwGhvh0KwWW0f7ecQhsg5EBBfX7sRHjon7dLshOWbuuZJek2pPQw7bspqDz1w1UC1C2RQM2COoVGyG8F+fqe2kL6bVX8quy/7OA5Awd0IINrqW1ZdzDak0cL7EVxRDugeVb7rJtNkFD15196M6uri8kPfph1d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pqnR+JiL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707763986;
	bh=7nBNtyOe9B7di3tlfXkDPiWXRmeY0kYi18klzwAbx7M=;
	h=From:Subject:Date:To:Cc:From;
	b=pqnR+JiLiFvgv1Kduw36CAl7PtOEjrU2Qg1ijPxf8BpEuVsk6/mFsV6Dnc/y6xEzv
	 z2DUMWYek26avU3H837Uh2E89fLMSxkcgn0Z+w5cZWYLKTJYNFpLUPOah44HM4fZBs
	 R7RcYFqdQQpvOnptNofsr5L16RVzML/J183dPhyRQoQPOrCcMDxB5po8iT4KCrraMz
	 +NoRMIelwcoPGJl35Q3fJFb7m9raQRu/xsgG+6oKJ2ANtsMXIKOBLAiE00FIueZRPj
	 Ha8EOtzYqHDp9LD1/lI1YufgREeYc6UUaq599MI0gD6I3BDUZz9Y1M3TKWBANXSS4D
	 9xVuSSR2LrZSw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 977C63782059;
	Mon, 12 Feb 2024 18:53:06 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v3 0/2] Add support for RK3588 HDMI/eDP Combo PHY
Date: Mon, 12 Feb 2024 20:52:28 +0200
Message-Id: <20240212-phy-hdptx-v3-0-2cde680cd024@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOxoymUC/6WPQQ6CMBBFr2K6dshMqVJceQ/jYijFNkFKSkM0h
 Ltb3GjcunzJn/f/LGKy0dtJnHaLiHb2kw9DhnK/E8bxcLPg28xColRIUsPonuDaMT1Ac625OWJ
 L2oqcH6Pt/OPtulwzdzHcIblo+ctANdWlxmNBWKIkBQQm+il5Hgrjg+E+WT6b0PfchMiFCffN7
 XIkxOd75kxbwx++bdwsPxKJh6+3ZgkIXNEBNSmDqvq9Xtf1BbKtoQc3AQAA
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Andy Yan <andy.yan@rock-chips.com>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Algea Cao <algea.cao@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, kernel@collabora.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-a684c

Add driver and bindings to add initial support the Rockchip HDMI/eDP TX
Combo PHY found on RK3588 SoC.

The PHY is based on a Samsung IP block and supports HDMI 2.1 TMDS, FRL
and eDP links.

Please note that currently only the TMDS related functionality has been
implemented.  This has been tested on Radxa ROCK 5B and Rockchip EVB1
boards.

Changes in v3:
- Collected R-b & T-b tags from Heiko
- Converted all *_REG() args to lowercase (Vinod)
- Dropped unnecessary register read/write wrappers (Vinod)
- Added rate overflow check in hdptx_phy_clk_pll_calc() (Luis)
- Link to v2:
  https://lore.kernel.org/r/20240205-phy-hdptx-v2-0-a7150814c047@collabora.com

Changes in v2:
- Rebased series onto next-20240129
- Removed patch 'dt-bindings: soc: rockchip: Add rk3588 hdptxphy syscon'
  already applied by Heiko
- For consistency with SoC TRM, replaced all references to DP with eDP
- Updated PHY schema per Krzysztof's review; also collected his R-b tag
- Dropped FRL, EARC and 10-bit color depth functionality until the HDMI
  configuration options become available in PHY API
- Squashed lots of regmap_write operations via regmap_multi_reg_write
  (Sebastian)
- Introduced parametrized {CMN|SB|LNTOP|LANE}_REG() macros to replace
  the long list of register defines
- Optimized handling of the config arrays by using ARRAY_SIZE() (Sascha)
- Link to v1:
  https://lore.kernel.org/r/20240119193806.1030214-1-cristian.ciocaltea@collabora.com

---
Cristian Ciocaltea (2):
      dt-bindings: phy: Add Rockchip HDMI/eDP Combo PHY schema
      phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver

 .../bindings/phy/rockchip,rk3588-hdptx-phy.yaml    |   91 ++
 drivers/phy/rockchip/Kconfig                       |    8 +
 drivers/phy/rockchip/Makefile                      |    1 +
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c  | 1028 ++++++++++++++++++++
 4 files changed, 1128 insertions(+)
---
base-commit: 596764183be8ebb13352b281a442a1f1151c9b06
change-id: 20240128-phy-hdptx-8a98ab60d18e


