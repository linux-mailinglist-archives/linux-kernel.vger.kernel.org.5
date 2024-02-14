Return-Path: <linux-kernel+bounces-65157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 767EA8548B3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161611F2A0BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF2E1AAC4;
	Wed, 14 Feb 2024 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YA70RvpR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60A218EB9;
	Wed, 14 Feb 2024 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707911201; cv=none; b=sVvVOdqYqJ3CXK4E1nSVCbxLpEIR57zvXJ7lO2bcLRCqAtArisd1ul44JVcqwK+9PLpZFkmwyP4MzrcOzs3xN1DkKB5IfraBCr/u0nsMXKI4VWuhwjbfWf9mbBPrSpg8hkJgq+h+ekhw25p3vFIPi2L3Cm/l0AHSz70umv2FyIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707911201; c=relaxed/simple;
	bh=jvl3Y+wH/gfbOOMoVy7joBUO4CawoZUoJ7kw1HD0z/U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MNwOpVzrFYaXM+bfhLsrCY1wMZit4b/lAELclDX7cTvGt81t7TtAPs/8uyZE6wisqvuKJqL4tmdUVB6gcyHcbQWE8yhq2Eh/AenlYUf9qS9SUBRU/rC+pFK931U1spV4PzcriFTA0mBfXrvnCziTPjyRNXsjPjjDAaxQJF9n2fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YA70RvpR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707911198;
	bh=jvl3Y+wH/gfbOOMoVy7joBUO4CawoZUoJ7kw1HD0z/U=;
	h=From:Subject:Date:To:Cc:From;
	b=YA70RvpRZSuQsZE/wvgVmxVw45f0rXLs1tzxXs8bLKLUP9AAeBHDmszfK4g7Z9rzM
	 pH6rRBh3vkUoWFAlaD6C0kde9ObclosTzemb+pih8zB2DTRmYucPsoABSUiZZRb+k2
	 7fMkq/pk01jgSz2yyrwPzaxAbvFbAYGutm4b5VpNCaDYqygBOMrhPCyGuw2nifwT9s
	 ymoZZi+WYj0afGQzgYIQfgcauusscL0U6I9Sw3UDsXy4nDj1nby0dZ63kmeVLOx5kX
	 wXd/yjUWOlJILX0Loah1ucl3ufmj5z5TFF6CC5z+clt+x7LLH2YzsANmoVgnvhT7kJ
	 SXoYHO42DCx8g==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BF758378045F;
	Wed, 14 Feb 2024 11:46:37 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v4 0/2] Add support for RK3588 HDMI/eDP Combo PHY
Date: Wed, 14 Feb 2024 13:45:35 +0200
Message-Id: <20240214-phy-hdptx-v4-0-e7974f46c1a7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN+nzGUC/6WPQY7CMAxFr4KyxpWdhpKy4h5oFiYxJFJpqrSqQ
 Kh3n5TNVKPZzfLL/z3bbzVKjjKq0+6tssxxjKkvwex3ygXu7wLRl6w0aoOkLQzhBcEP0xMst5a
 vDXqyokp/yHKLz4/r8lXyLacHTCELbwzUUltbbCrCGjUZIHA5jlPkvnIxOe4m4bNLXcfXlLly6
 bG6Q6mk/PqcOdO64R++9bhZ/0g0HjZvzRoQ+EgHtGQcmuNfdL2hSW/putDaeWksOl/mv+llWb4
 Bo3cFUXUBAAA=
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

Changes in v4:
- Used consistent naming by replacing hdptx_*/rockchip_* with rk_hdptx_*
  (Johan)
- Link to v3:
  https://lore.kernel.org/r/20240212-phy-hdptx-v3-0-2cde680cd024@collabora.com

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


