Return-Path: <linux-kernel+bounces-39769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BD183D5E8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F301C264CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650DD1CF98;
	Fri, 26 Jan 2024 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LQ4WIBMd"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10CB199B9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258295; cv=none; b=UuEcPOVE2yi5aPw9Dp9tgoDX+Q/5a/PgRunkegtZBFKEzFNJ4Abwei0c/aF7pLHL9mit7XOTwvX6KSAvGD7OwJ3iwuVdLtRND8g+Du4hF6RiPvs6WTLJ4hCjAAUmOAHo5LMEArAJ/YxdXauHMTl1wVvQiaQA6sq8C96pj0T21/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258295; c=relaxed/simple;
	bh=+Oji32cn+wEslAukjYiFRQK/2R8LpXwnxdujfaQWWPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dBq50f8YYt7iH1mYKl59oEGIAT3J0Rcy3uAcYqXz94NoBcQNTXofd/Q82Z/hJdBshHpKnoUv8IuKA/evAnJvuZ6/l7hT3ZsPF89zdjiGDYYDBuMoH2PVZCxQyb8kVG92uR8k/6A69MTqbEm+q5yfFRE1fT/TKs1cpIEefCldTtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LQ4WIBMd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d8a66a2976so694825ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706258293; x=1706863093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LE7g+mEs4EmMyt4VHboAWdRj+3LgbdJ4gLhc76izr6g=;
        b=LQ4WIBMdd/OEBrtY/P2j1U4y5xOY95VSIH4QN6l8Pd8d62YvH+bIV9xxZ7ZjtHdslA
         9o5zpqDbJkN6DhmZb+ZGxc2kyWT6CkPsar/aWOxszwiwh4OykK2szuqxG8Ktm3GIC3gy
         ecWky+wzT9Chm/fJgnx9gJDxAG3BnJC9bgZOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706258293; x=1706863093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LE7g+mEs4EmMyt4VHboAWdRj+3LgbdJ4gLhc76izr6g=;
        b=Lgt0peR5OxHeicqx8ARPE3tbbp6IxY2F6gMRGoHskprWxASU7bsjtPEYpsaayKrkcK
         SQrUlSvk5CCG62dCBYehATA2AghuwhafHfRhPapjbQ/aXBzcb5HsMYyUMwfub4yNZlvJ
         tzku+JIE/K7Bjt+Ftt5ZG82/TyUSycI3z6uYkCxwMCuyyI95ln8mGezu4FOkMOi9YGOy
         UGgNdgaMV5iQ+ioPwfijUgJx3sCCeKu0YkU7kpl9k+swuqDO/GIOt867uuD89LFY7kes
         lRf2UwHyQjVr6IyYIKLOHr0M51i3wbvEJqqhinhmHDeIPYp5R+Tdgofmfz22kynX1ToI
         qGgw==
X-Gm-Message-State: AOJu0Yx5hj17hpTrp6i4KZeumjl3iXtBnHt3fWtrvSHaDoXMz4MflymR
	YyiLonixz4odUtUGYCzjzAcS5U1E33rtupHmxZbfLv3f89XqZPNMa0EMAqy9BQ==
X-Google-Smtp-Source: AGHT+IH9479eT9ZV5ZGeD7MxCUFXOVWUme3HzZZg1vKYs/E2JQ6acszehvT1G36Pz3F285bmX/WI+g==
X-Received: by 2002:a17:902:7805:b0:1d7:6f15:7869 with SMTP id p5-20020a170902780500b001d76f157869mr1122776pll.73.1706258293199;
        Fri, 26 Jan 2024 00:38:13 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2614:bbbd:8db2:1f54])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902a9c200b001d6ff1795aesm589529plr.8.2024.01.26.00.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:38:12 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/9] arm64: dts: mediatek: Add MT8186 Corsola Chromebooks
Date: Fri, 26 Jan 2024 16:37:49 +0800
Message-ID: <20240126083802.2728610-1-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This is v5 of the MT8186 Chromebook device tree series. This series also
depends on MT7921S Bluetooth [1] and IT6505 audio [2] bindings.

Changes since v4:
- Rebase and fit in mt8188-evb in board DT binding
- Change "touchpad" to "trackpad" in descriptions and commit logs
- Drop #address-cells and #size-cells from it6505 and usb_host1 nodes
- Drop "ports" nodes from type-c nodes
- Fix pinmux node names
- Split anx7625 reset and power-en pins into separate pinmux nodes

Not changed: "/delete-node/ trackpad@15" is still present. See patch 6
footer.

Changes since v3:
- Collected reviewed-by from Angelo
- Reorder some properties to conform better to the newly proposed DT
  style guidelines
- Drop unused labels
- Rename bt-sco node name to bt-sco-codec
- Drop i2s*-share properties from afe node
- Drop aud_gpio_tdm_{on,off} pinctrl nodes
- Replace interrupts with interrupts-extended in tpm node
- Enable adsp device

Changes since v2:
- Picked up Conor's ack
- Renamed remaining "touchpad" nodes to "trackpad"
- Dropped pinctrl from tentacruel/tentacool second source trackpad

Changes since v1:
- Reorder SKU numbers in descending order.
- Fixed pinconfig node names
- Moved pinctrl-* properties after interrupts-*
- Switched to interrupts-extended for external components
- Marked ADSP as explicitly disabled, with a comment explaining that it
  stalls the system
- Renamed "touchpad" to "trackpad"
- Dropped bogus "no-laneswap" property from it6505 node
- Moved "realtek,jd-src" property to after all the regulator supplies
- Switched to macros for MT6366 regulator "regulator-allowed-modes"
- Renamed "vgpu" regulator name to allow coupling, with a comment
  containing the name used in the design
- Renamed "cr50" node name to "tpm"
- Moved trackpad_pins reference up to i2c2; workaround for second source
  component resource sharing.
- Fix copyright year
- Fixed touchscreen supply name
- Mark missing components as disabled instead of deleting the node
- Dropped reset-gpios from touchscreen nodes
- Drop status = "okay", which is the default


This series adds device trees for the various MT8186 Chromebooks that
were initially released. These are the Tentacruel / Tentacool devices
released by ASUS, and the Steelix / Rusty / Magneton devices released
by Lenovo. The device trees are taken from the downstream ChromeOS v5.15
kernel, ported to mainline and cleaned up.

Corsola is the Google codename given to the MT8186 platform. This
platform has two reference designs, Krabby and Kingler. Kingler was not
used in any actual product, and is therefor not included. Steelix is
an alternative design put forward and is effectively a mix-and-match of
the two reference designs.

Most of the core design is shared between the variants. The differences
are on which external components, such as the display bridges, are used.

Patch 1 cleans up the current list of MediaTek boards. The entries are
reordered by SoC model first, then by board name.

Patch 2 through 5 add DT binding entries for the Tentacruel/Tentacool,
Steelix, Rusty, and Magneton Chromebooks.

Patch 6 through 9 add board device tree files for these devices. Patch 6
also adds the corsola dtsi file for the commonalities between the designs,
as well as a dtsi file for the krabby reference design.

Currently external display support is missing. Audio is not working, as
enabling the audio DSP causes my test systems to hang.

Please have a look and test if possible.


Regards
ChenYu

[1] https://lore.kernel.org/all/20240126063500.2684087-1-wenst@chromium.org/
[2] https://lore.kernel.org/all/20240126073511.2708574-1-wenst@chromium.org/


Chen-Yu Tsai (9):
  dt-bindings: arm: mediatek: Sort entries by SoC then board compatibles
  dt-bindings: arm: mediatek: Add MT8186 Tentacruel / Tentacool
    Chromebooks
  dt-bindings: arm: mediatek: Add MT8186 Steelix Chromebook
  dt-bindings: arm: mediatek: Add MT8186 Rusty Chromebook
  dt-bindings: arm: mediatek: Add MT8186 Magneton Chromebooks
  arm64: dts: mediatek: Add MT8186 Krabby platform based Tentacruel /
    Tentacool
  arm64: dts: mediatek: Introduce MT8186 Steelix
  arm64: dts: mediatek: Add MT8186 Steelix platform based Rusty
  arm64: dts: mediatek: Add MT8186 Magneton Chromebooks

 .../devicetree/bindings/arm/mediatek.yaml     |  188 +-
 arch/arm64/boot/dts/mediatek/Makefile         |   10 +
 .../dts/mediatek/mt8186-corsola-krabby.dtsi   |  129 ++
 .../mt8186-corsola-magneton-sku393216.dts     |   39 +
 .../mt8186-corsola-magneton-sku393217.dts     |   39 +
 .../mt8186-corsola-magneton-sku393218.dts     |   26 +
 .../mt8186-corsola-rusty-sku196608.dts        |   26 +
 .../mt8186-corsola-steelix-sku131072.dts      |   18 +
 .../mt8186-corsola-steelix-sku131073.dts      |   18 +
 .../dts/mediatek/mt8186-corsola-steelix.dtsi  |  199 ++
 .../mt8186-corsola-tentacool-sku327681.dts    |   57 +
 .../mt8186-corsola-tentacool-sku327683.dts    |   24 +
 .../mt8186-corsola-tentacruel-sku262144.dts   |   44 +
 .../mt8186-corsola-tentacruel-sku262148.dts   |   26 +
 .../boot/dts/mediatek/mt8186-corsola.dtsi     | 1681 +++++++++++++++++
 15 files changed, 2459 insertions(+), 65 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-magneton-sku393216.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-magneton-sku393217.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-magneton-sku393218.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-rusty-sku196608.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix-sku131072.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix-sku131073.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327681.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi

-- 
2.43.0.429.g432eaa2c6b-goog


