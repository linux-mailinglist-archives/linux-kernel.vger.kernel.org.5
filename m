Return-Path: <linux-kernel+bounces-9639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3443381C8D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42EB281D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5717E17983;
	Fri, 22 Dec 2023 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="E7ei35fE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D82B17743;
	Fri, 22 Dec 2023 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1703243143; bh=0fR2LDFcxwDpap7qMyCNCyANGL/FAUTkYz5H7M+mUm8=;
	h=From:Subject:Date:To:Cc:From;
	b=E7ei35fEyNQLV6kQpHiNwkAdt2o4MDhvff5xMX2p+pxe6p+w8dI04tejBk5yVnzzh
	 veVgo0e1+YojtbRNvZQx+YdqQ8PowrU1BUtbRUs7WakAfmdSFqS1qvJy/X2/vV43Fz
	 NAzHgQ6mGnGi9cqPc0s5OgMXM+aVKCYO7tHyoxEsfZoJeFNupw9i/xbPCXx09BT8Vp
	 SZ+7IfqRkROge97dRETC0k42t6vLUkWRf8XGS+2gzxIP/0P6OoB2Ga8uih050pDNcr
	 j6FLVuQvOcrmsNY8DXCNMgva0zWv2R9gwd2G6PnoM/i2vMj1qGYkFNtlSKt1wKK1K3
	 gvUh4643vzCew==
Received: from arthur.fritz.box (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id 8BFC3370D3B;
	Fri, 22 Dec 2023 12:05:42 +0100 (CET)
From: Manuel Traut <manut@mecka.net>
Subject: [PATCH 0/6] arm64: rockchip: Pine64 pinetab2 support
Date: Fri, 22 Dec 2023 12:05:40 +0100
Message-Id: <20231222-pinetab2-v1-0-e148a7f61bd1@mecka.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIRthWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDIyMj3YLMvNSSxCQj3bTERHPzVAPDlCSzNCWg8oKi1LTMCrBR0bG1tQA
 RoX8xWgAAAA==
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
 Segfault <awarnecke002@hotmail.com>, Arnaud Ferraris <aferraris@debian.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Manuel Traut <manut@mecka.net>
X-Mailer: b4 0.12.4

This adds support for the BOE TH101MB31IG002 LCD Panel used in Pinetab2 [1] and
Pinetab-V [2] as well as the devictrees for the Pinetab2 v0.1 and v2.0.

The BOE LCD Panel patch was retrieved from [3]. The function-name prefix has
been adapted and the LCD init section was simplified.

The Pinetab2 devicetree patch was retrieved from [4]. Some renaming was needed
to pass the dtb-checks, the brightness-levels are specified as range and steps
instead of a list of values.

The last to patches fix some dtb-checker warnings that showed up with the new
device-trees.

[1] https://wiki.pine64.org/wiki/PineTab2
[2] https://wiki.pine64.org/wiki/PineTab-V
[3] https://salsa.debian.org/Mobian-team/devices/kernels/rockchip-linux/-/blob/mobian-6.6/debian/patches/display/0018-drm-panel-add-BOE-TH101MB31IG002-28A-driver.patch?ref_type=heads
[4] https://salsa.debian.org/Mobian-team/devices/kernels/rockchip-linux/-/blob/mobian-6.6/debian/patches/device-tree/0134-arch-arm64-add-Pine64-PineTab2-device-trees.patch?ref_type=heads

Signed-off-by: Manuel Traut <manut@mecka.net>
---
Manuel Traut (4):
      dt-bindings: display: panel: Add BOE TH101MB31IG002-28A panel
      dt-bindings: arm64: rockchip: Add Pine64 Pinetab2
      arm64: dts: rockchip: Fix some dtb-check warnings
      dt-bindings: display: rockchip: dw-hdmi: Add missing sound-dai-cells property

Segfault (2):
      drm/panel: Add driver for BOE TH101MB31IG002-28A panel
      arm64: dts: rockchip: Add devicetree for Pine64 Pinetab2

 .../devicetree/bindings/arm/rockchip.yaml          |    8 +
 .../display/panel/boe,th101mb31ig002-28a.yaml      |   73 ++
 .../display/rockchip/rockchip,dw-hdmi.yaml         |    4 +
 arch/arm64/boot/dts/rockchip/Makefile              |    2 +
 .../boot/dts/rockchip/rk3566-pinetab2-v0.1.dts     |   26 +
 .../boot/dts/rockchip/rk3566-pinetab2-v2.0.dts     |   46 +
 arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi  | 1032 ++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi           |    5 +-
 drivers/gpu/drm/panel/Kconfig                      |   11 +
 drivers/gpu/drm/panel/Makefile                     |    1 +
 .../gpu/drm/panel/panel-boe-th101mb31ig002-28a.c   |  307 ++++++
 11 files changed, 1513 insertions(+), 2 deletions(-)
---
base-commit: 24e0d2e527a39f64caeb2e6be39ad5396fb2da5e
change-id: 20231222-pinetab2-faa77e01db6f

Best regards,
-- 
Manuel Traut <manut@mecka.net>


