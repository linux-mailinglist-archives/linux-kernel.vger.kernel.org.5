Return-Path: <linux-kernel+bounces-10473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865A281D4CB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A77B28329F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1F6FBF0;
	Sat, 23 Dec 2023 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="A/Y10Bnz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EDEDF4D;
	Sat, 23 Dec 2023 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1703344837; bh=gjmk34cgD8+7am+EzGIKiXzgLsLe0EolSOD4WblBzXo=;
	h=From:Subject:Date:To:Cc:From;
	b=A/Y10BnzEC6vegjs4Djnb775+rgfUD+izHRI2vOAXaddj9y+xDeWc1cCiVOXsSaDr
	 9FeTvsE1pggSdnnKBMrZM1XcwqFMA35s7yU1u3OsMyRrGInTmyThVMwigLRrD4/Wpa
	 pL4WSlewSef/lucS2PHuGwIYwINkPf68X6K/DpiDBSo41GsfI/tsW6E5h1Mrh8nAlA
	 awl06zHCw4fCkUfcfmijp/dkunt87aRRbdZg72AxyBL5JDzHdsLgdfhd7HYsM71XAj
	 B+7VLnRShQUQ3uga0jdxgQ2fGrLNKQNXdbxxezczjqBUZNHKPmzVL0sBh6wvAwoOi+
	 2dHkN48NQicfw==
Received: from arthur.fritz.box (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id 13CDF371958;
	Sat, 23 Dec 2023 16:20:37 +0100 (CET)
From: Manuel Traut <manut@mecka.net>
Subject: [PATCH v2 0/4] arm64: rockchip: Pine64 pinetab2 support
Date: Sat, 23 Dec 2023 16:20:14 +0100
Message-Id: <20231223-pinetab2-v2-0-ec1856d0030e@mecka.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK76hmUC/22MQQ7CIBBFr9LMWgwzmmJceQ/TBZTBToy0gYZoG
 u4udu3y/f/yNsichDNcuw0SF8kyxwZ06GCcbHywEt8YSNMJiUgtEnm1jlSw1hjW6F0foOlL4iD
 vPXUfGk+S1zl99nLB3/onUlBpxXi+WBN6dB5vLx6f9thuGGqtX90PBjmgAAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sandy Huang <hjc@rock-chips.com>, Mark Yao <markyao0591@gmail.com>, 
 Diederik de Haas <didi.debian@cknow.org>, 
 Segfault <awarnecke002@hotmail.com>, Arnaud Ferraris <aferraris@debian.org>, 
 Danct12 <danct12@riseup.net>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Manuel Traut <manut@mecka.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4

This adds support for the BOE TH101MB31IG002 LCD Panel used in Pinetab2 [1] and
Pinetab-V [2] as well as the devictrees for the Pinetab2 v0.1 and v2.0.

The BOE LCD Panel patch was retrieved from [3]. The function-name prefix has
been adapted and the LCD init section was simplified.

The Pinetab2 devicetree patch was retrieved from [4]. Some renaming was needed
to pass the dtb-checks, the brightness-levels are specified as range and steps
instead of a list of values.

[5] was also used as source for this queue.

The last to patches fix some dtb-checker warnings that showed up with the new
device-trees.

[1] https://wiki.pine64.org/wiki/PineTab2
[2] https://wiki.pine64.org/wiki/PineTab-V
[3] https://salsa.debian.org/Mobian-team/devices/kernels/rockchip-linux/-/blob/mobian-6.6/debian/patches/display/0018-drm-panel-add-BOE-TH101MB31IG002-28A-driver.patch?ref_type=heads
[4] https://salsa.debian.org/Mobian-team/devices/kernels/rockchip-linux/-/blob/mobian-6.6/debian/patches/device-tree/0134-arch-arm64-add-Pine64-PineTab2-device-trees.patch?ref_type=heads
[5] https://github.com/dreemurrs-embedded/linux-pinetab2/tree/v6.6.7-danctnix1

Signed-off-by: Manuel Traut <manut@mecka.net>
---
Changes in v2:
- Removed dtb-checker fixups, cause I am not sure if they are correct
- Applied review comments for dt bindings
- pinetab2 dts:
    * Remove unverified WLAN entries, as in [5]
    * Simplify flash LED definition, as in [5]
    * Fix headphone detection and sound routing, as in [5]
    * Fix CRU clock configuration
- BOE TH101MB31IG002 LCD Panel:
    * Reworked prepare/enable unprepare/disable, as in [5]
- Replaced nicknames by realnames in author and signed-offs

- Link to v1: https://lore.kernel.org/r/20231222-pinetab2-v1-0-e148a7f61bd1@mecka.net

---
Alexander Warnecke (2):
      drm/panel: Add driver for BOE TH101MB31IG002-28A panel
      arm64: dts: rockchip: Add devicetree for Pine64 Pinetab2

Manuel Traut (2):
      dt-bindings: display: panel: Add BOE TH101MB31IG002-28A panel
      dt-bindings: arm64: rockchip: Add Pine64 Pinetab2

 .../devicetree/bindings/arm/rockchip.yaml          |   8 +
 .../display/panel/boe,th101mb31ig002-28a.yaml      |  58 ++
 arch/arm64/boot/dts/rockchip/Makefile              |   2 +
 .../boot/dts/rockchip/rk3566-pinetab2-v0.1.dts     |  26 +
 .../boot/dts/rockchip/rk3566-pinetab2-v2.0.dts     |  46 +
 arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi  | 979 +++++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                      |  11 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 .../gpu/drm/panel/panel-boe-th101mb31ig002-28a.c   | 348 ++++++++
 9 files changed, 1479 insertions(+)
---
base-commit: 5254c0cbc92d2a08e75443bdb914f1c4839cdf5a
change-id: 20231222-pinetab2-faa77e01db6f

Best regards,
-- 
Manuel Traut <manut@mecka.net>


