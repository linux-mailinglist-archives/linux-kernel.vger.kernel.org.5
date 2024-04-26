Return-Path: <linux-kernel+bounces-160464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57378B3DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57541289D51
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9B216F262;
	Fri, 26 Apr 2024 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yHmgU9w2"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA3B168AEA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152162; cv=none; b=Q4q56PYjpeEMTBkas+z9IbK4rWxB10ftA8crCt7hyiahe2XOfmOmSj2SNCAGWA07PJx7pmDBkoRxHhT3ZGX/ASkIrx494VXI1BFZnB6SDb5Pp5vY5R3FvAUAL/UTGvJKUW6s4Ez0H1aSX5UXExT3xmfcTzgcM9TC/uiVezJm5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152162; c=relaxed/simple;
	bh=mQ0BYdLeInE8BFr/mP/QEGIogjhZGjK/zMNc0uGi9AI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=vDyllekKor2KUs7bgshz1Nv+5tENP6rkX2nDP0K4df2Xs1jmyOV3jurjHK4zPyC6j/T7s2t4pWzt4GTU3XSAJfHXopmjOtm+k+nFK256HiwBRF5IJDXpuBCzFkXhp2TJO/o0AOzFiRa1ibr5LdgBRxpd+trXnmL0V9BEuXIKmmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yHmgU9w2; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso3865420e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714152157; x=1714756957; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k71hSoN15yH9F3aB+h2wTv9pphh17yQUdnB0/yDtnY0=;
        b=yHmgU9w24uIAIRwkIymVQY/xcNOYARJ3Qx0A+rspsxrG+6CFQOJ41ZvBu6Obe1jRKz
         7byXihOiaomlt+S3/Mu7mHa9bGacg+Prua3hQJeupu7ZlA10JdauSaf8duE+3/1Zc1A3
         3hfFaiQXrQwcbeA1cWVTVGT1PdM1zyMqaDtBno+tYF2+loxAMtYMuOvrPBCP382DQPYQ
         nQHcL4N3jbAgpcioUkeLkKekR3KkGbimgSF5R7T+cJTnjwa/dqo9a0EkEEVe0dPQLnF2
         /fErtIE3afdufiTiH771ZX+WlHOKuwxmouI3NLTiNrh/vLJIU+sbA3VNZ1QqAUJQ/0M7
         kYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152157; x=1714756957;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k71hSoN15yH9F3aB+h2wTv9pphh17yQUdnB0/yDtnY0=;
        b=OWW3lRbzAt9DXSPCiI/ocKB/mTvxmMSV81sO79T27ONp+4bs4I9k6QFbAtmw0yTHnL
         4QscdVadRWRVwBi5nU4KajCLfStXLoUp6vEaWsJZ6jusJ2fhTETS6RLZPTQuyjDVvksR
         eYjinb1w/IIjnKdXSmoBtan3Ler1ssIZbtcVX0iDjRp3tX2HSxJ7NgbXYXVsb8wNrdfV
         16SPmXKeejTuluxK5/NrZI6vaMFxY2SKKOTxyfgkOI5d+xHXAoK/TLONgOYG+hm5FWjQ
         iFTJbISOefNfx1uYERPrB5gPu+CfsjkRdlqAERbxpDvjbu1T8uG4OU7kBr6jOW7hMrYD
         Yb7A==
X-Forwarded-Encrypted: i=1; AJvYcCUSkoH5YJW3ta3G98y/elVqk1nzaJVB0K8ZJMnuAXml3excTYvuSnV4tf32U1/Q2Sh1mbl//ff0HsmLuSN1Kq2T5Wdw7TTgFvC+JLmE
X-Gm-Message-State: AOJu0YyrifZT+8D30CbvvBzQNQZvLLt+dOW1OQRMXzOEfoEqGL7XVwKk
	64SSXyeikPxpEA5tWVZF7021iC3BgTWzSqIu13uoouPdDrqHyZqdTs526NEfL0c=
X-Google-Smtp-Source: AGHT+IGGmltkw3FmOHr203oPQ7PadAy3RzH/8PcaNuMZJezQtl+Y6hzfXyYMaq2zC3qzqc9g35yFQw==
X-Received: by 2002:ac2:48b5:0:b0:519:60da:56fa with SMTP id u21-20020ac248b5000000b0051960da56famr2471353lfg.42.1714152156558;
        Fri, 26 Apr 2024 10:22:36 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id ot15-20020a170906cccf00b00a5239720044sm10763363ejb.8.2024.04.26.10.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:22:36 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v4 00/16] Add audio support for the MediaTek Genio 350-evk
 board
Date: Fri, 26 Apr 2024 19:22:29 +0200
Message-Id: <20240226-audio-i350-v4-0-082b22186d4c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANbiK2YC/3XOTYoCMRAF4KtI1hPNv62ruccgUkmq7QJNS6JBk
 b676V4OunwF33v1YgUzYWH71YtlrFRoTC2YnxULA6QTcootMyWUEUo5DvdIIydtBTcoZQTRdWg
 ta8BDQe4zpDDMBC6YTwlum+rWHc9BbhZ7DGeEdL/O4pqxp8cy/3doeaByG/Nz+abK+fpxuEre1
 nuQAUE6t+1/PTzP5DOuw3hhc1NV37VqWgujo+l0RBE/aP1d66al816F3dYEa//paZremeg4HVU
 BAAA=
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Nicolas Belin <nbelin@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5460; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=mQ0BYdLeInE8BFr/mP/QEGIogjhZGjK/zMNc0uGi9AI=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmK+LaBBB9GBTBfqJRRntnZS0wN4RhMFnbwrVXpvKv
 4RbT6smJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZivi2gAKCRArRkmdfjHURTukD/
 9ZA1bVQD8tdglKELx0M3xSVDXl47/YL1/2elfF64Arp1qCSdF7Van1DdKyb3ieKkVPCU4olo/xBUqW
 cftyKa0PRqNKM9ATv4y2tKV50HdA9f4nhKUm6nExjNyiUZlUsdN67DcbfZxYcVcm/Fyt6fPTGL7vrj
 E/oYmOV2e2QwUvijE0K/Q17zfOspVPBZd+ycv2EJ0EDEjTSTj+OqfKP37I6jYAs0kRDwPL9aZtZa1m
 /4A6ZYehxVx25/BhdcOW3gM++4YY48FTdGOaxlbSR69YCWSXVbV7kR4xEHDSKUdKon9naiL8m2Cws6
 CCoo8oyKbrMXXcT4DPf+MpRfxLFaot8PN9esfQ1r/oSHzr3u1jMxvSNMfEfqoeyKkKOPZv1lq0x+Cz
 2kk52JFdh0zGunuPMOL+UHtV/vPLnEllWTo4NOvJ6H4A3JJIzqnSFKqt9e8hfaaMNc4e456wCuvHUg
 6Ubn7mVX4HcY26XWXYy7bzSV0PuZoYU8M602dUTQ3ZEzBVZn7ZA7SnQMMuobZYHkypU4dDZKuBXziU
 pgNAvdID5d3vSjY092Kv4aSPqhEejO/Rn4itpLT4p9La231ZP7bC88JWHSruGQQi3vgL+sdLzi26OD
 NT5imPmWAdw29ibUw5PPTWZxp+ANduIBrQjZIpE828wRyylw9vvzYGMkmTxg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

This serie aim to add the following audio support for the Genio 350-evk:
- Playback
  - 2ch Headset Jack (Earphone)
  - 1ch Line-out Jack (Speaker)
  - 8ch HDMI Tx
- Capture
  - 1ch DMIC (On-board Digital Microphone)
  - 1ch AMIC (On-board Analogic Microphone)
  - 1ch Headset Jack (External Analogic Microphone)

Of course, HDMI playback need the MT8365 display patches [1] and a DTS
change documented in "mediatek,mt8365-mt6357.yaml".

Applied patch:
- mfd: mt6397-core: register mt6357 sound codec

Test passed:
- mixer-test log: [3]
- pcm-test log: [4]

[1]: https://lore.kernel.org/all/20231023-display-support-v1-0-5c860ed5c33b@baylibre.com/
[2]: https://lore.kernel.org/all/20240313110147.1267793-1-angelogioacchino.delregno@collabora.com/
[3]: https://pastebin.com/pc43AVrT
[4]: https://pastebin.com/cCtGhDpg
[5]: https://gitlab.baylibre.com/baylibre/mediatek/bsp/linux/-/commits/sound/for-next/add-i350-audio-support

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Changes in v4:
- Rebase to "next-20240422" branch.
- Re-pass dt_binding_check, functionnal tests, mixer test and pcm test.
- Remove copyright changes.
- Move mt6357 audio codec documention from mt6357.yaml
  to mediatek,mt6357.yaml
- Fix broken indentation in mt8365-evk.dts
- Remove empty node.
- Add more dai link name according to the HW capability.
- Remove spurious property (mediatek,topckgen)
  from mediatek,mt8365-afe.yaml
- Rename "afe" to "audio-controller" in the documentation.
- Link to v3: https://lore.kernel.org/r/20240226-audio-i350-v3-0-16bb2c974c55@baylibre.com

Changes in v3:
- Re-order documentation commit to fix dt_binding_check error.
- Remove $ref and add "mediatek," prefix to vaud28-supply property.
- Link to v2: https://lore.kernel.org/r/20240226-audio-i350-v2-0-3043d483de0d@baylibre.com

Changes in v2:
- Documentation fixed:
  - Remove spurious description.
  - Change property order to fit with dts coding style rules.
  - micbias property: use microvolt value instead of index.
  - mediatek,i2s-shared-clock property removed.
  - mediatek,dmic-iir-on property removed.
  - mediatek,dmic-irr-mode property removed.
  - Change dmic-two-wire-mode => dmic-mode to be aligned with another SoC
  - Remove the spurious 2nd reg of the afe.
- Manage IIR filter feature using audio controls.
- Fix audio controls to pass mixer-test and pcm-test.
- Refactor some const name according to feedbacks.
- Rework the codec to remove spurious driver data.
- Use the new common MTK probe functions for AFE PCM and sound card.
- Rework pinctrl probe in the soundcard driver.
- Remove spurious "const" variables in all files.
- Link to v1: https://lore.kernel.org/r/20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com

---
Alexandre Mergnat (14):
      ASoC: dt-bindings: mediatek,mt8365-afe: Add audio afe document
      ASoC: dt-bindings: mediatek,mt8365-mt6357: Add audio sound card document
      dt-bindings: mfd: mediatek: Add codec property for MT6357 PMIC
      ASoC: mediatek: mt8365: Add common header
      SoC: mediatek: mt8365: support audio clock control
      ASoC: mediatek: mt8365: Add I2S DAI support
      ASoC: mediatek: mt8365: Add ADDA DAI support
      ASoC: mediatek: mt8365: Add DMIC DAI support
      ASoC: mediatek: mt8365: Add PCM DAI support
      ASoC: mediatek: mt8365: Add platform driver
      ASoC: mediatek: Add MT8365 support
      arm64: defconfig: enable mt8365 sound
      arm64: dts: mediatek: add afe support for mt8365 SoC
      arm64: dts: mediatek: add audio support for mt8365-evk

Nicolas Belin (2):
      ASoc: mediatek: mt8365: Add a specific soundcard for EVK
      ASoC: codecs: add MT6357 support

 .../devicetree/bindings/mfd/mediatek,mt6357.yaml   |   34 +
 .../bindings/sound/mediatek,mt8365-afe.yaml        |  130 ++
 .../bindings/sound/mediatek,mt8365-mt6357.yaml     |  107 +
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts        |   89 +
 arch/arm64/boot/dts/mediatek/mt8365.dtsi           |   43 +-
 arch/arm64/configs/defconfig                       |    2 +
 sound/soc/codecs/Kconfig                           |    7 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/mt6357.c                          | 1898 ++++++++++++++++
 sound/soc/codecs/mt6357.h                          |  662 ++++++
 sound/soc/mediatek/Kconfig                         |   20 +
 sound/soc/mediatek/Makefile                        |    1 +
 sound/soc/mediatek/mt8365/Makefile                 |   15 +
 sound/soc/mediatek/mt8365/mt8365-afe-clk.c         |  443 ++++
 sound/soc/mediatek/mt8365/mt8365-afe-clk.h         |   49 +
 sound/soc/mediatek/mt8365/mt8365-afe-common.h      |  491 +++++
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c         | 2275 ++++++++++++++++++++
 sound/soc/mediatek/mt8365/mt8365-dai-adda.c        |  315 +++
 sound/soc/mediatek/mt8365/mt8365-dai-dmic.c        |  347 +++
 sound/soc/mediatek/mt8365/mt8365-dai-i2s.c         |  854 ++++++++
 sound/soc/mediatek/mt8365/mt8365-dai-pcm.c         |  293 +++
 sound/soc/mediatek/mt8365/mt8365-mt6357.c          |  348 +++
 sound/soc/mediatek/mt8365/mt8365-reg.h             |  991 +++++++++
 23 files changed, 9414 insertions(+), 2 deletions(-)
---
base-commit: f529a6d274b3b8c75899e949649d231298f30a32
change-id: 20240226-audio-i350-4e11da088e55

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>


