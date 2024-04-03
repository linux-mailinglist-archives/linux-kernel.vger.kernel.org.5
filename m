Return-Path: <linux-kernel+bounces-129208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC6C896700
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF67B24E8D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1051D5D74C;
	Wed,  3 Apr 2024 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uWJXGLGT"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA2E5C614
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130405; cv=none; b=UK1fTMjEbCdjYIzRkO3gzoO38JJBQzrTvvU0zyTY2OFJOfhHu0+lwusBKFkEUSnuPzP+Gf8854IgnxxF043j/4AOy98AbmliasD+qHpWbFX0YUPuHMXfL3DjQ6GmSOpRvbc+O12Eilu4enpQcHXvZJ82/qXwFQqNxR7mBBZ9bSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130405; c=relaxed/simple;
	bh=aEM9Na1E19MklSmNSuW8iA22W0ERaeQmoCjkiGVlIKE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bAK+4z8q6z5cDjwynKlOE1+uHYKnz6NcmujX0btwl++2RCNf+HK1tWctSH3tJQa0ewJVG69wv7yxZKanz/pzUvHOcH6RrbCDgRewrkh6QuRGh0/3qpOCNmNPCvpz8wA8iCAilNJPA3H38O4FTki9QA7yoNrtPNXkJw8+kQZ/f5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uWJXGLGT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34339f01cd2so3653292f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 00:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712130401; x=1712735201; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DgA3Xl8NwLbQEb1I2dslsED25sNgXx7L9wZQN4DRB8k=;
        b=uWJXGLGTfn7fsvKUyPf487emkZur2f3d+rMvthIa5lBxRjJiD1/j4aS36i1W9XCytp
         hZXRPCqAxSqngMrmJ5BjgbWhavKKevdkauEOfYpfwyDcRQdciUw0En95KzXWgseHLqKn
         zACUiVVrTvFKOjBlqSZkaG6CJ7Mjrpjt0Dr7oVeBXDcYHrlPZk3gXRyv09duo4d3CDt2
         rgVOpmIHgt63+LUT0caMh5gAH8eKXTja2UqzeHlvtHzhfF0ocY5Psp+MKDjlW/ff/AFc
         DWzggnIlPiIjYlzW1GfWQ5cGcBRM3PK6OvL+d/I/BXQ93h8uHVz/FK53pBbkQkd1FQlE
         t5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712130401; x=1712735201;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgA3Xl8NwLbQEb1I2dslsED25sNgXx7L9wZQN4DRB8k=;
        b=PzcKVMwsLcqN/1NMeNXyYIX6cucvpm/SVkJ729MAplQchftESnre7I5TqOApkoShux
         IYJupRYiOnMGkw9o0cBfYvldtV+LWkINf63KqLFAN/woxWJtClJSmV17/UqqrGZIKzw2
         igOYdErpnDFo8whscGh/7/xt6qEzpRWpJsvf6oisV6KAdVN7JWrYyIrMK28/bf417z46
         IeR7JDV5WZlnAZHpnkqF4Mw3Y81nHuIiOZhFaGg/tWzq4gwChWjuwPj17s9GW+bWK3UJ
         ZNFJ0yon9fz9kHo1ZRkq+Wd7XlSFxbiuu14wKkcMRhmX+kQ59Bfcgms+6ARhYh0Eo0Db
         UtdA==
X-Forwarded-Encrypted: i=1; AJvYcCXUCiFf7NdCR33ainJ/rQH69Adi8NDpnLZdfClNT3tq+5CweO6yPotRqK1wdVdkboHd5JGrSOkOYlIG0Rojvr8G6YEC59t2IAqYTi1O
X-Gm-Message-State: AOJu0YwzenWrv6pb5Am1c9gnpigmC2kLyNlRXycInDHNF1yXfbToGgee
	PTd4Me5tdkph2qFZjISrYMHu1ceOLX0bHK6/O/R/CZKLdITLp+TsKKc/Ln1nIO0=
X-Google-Smtp-Source: AGHT+IFMjG1vdNJVFYE8mg1DVFjPhwU9QdLDSDGRH3V0PpqQ6CsUjyghuPq4TXRvvtCJewDiTFEFHQ==
X-Received: by 2002:a05:6000:1085:b0:343:2d7a:143e with SMTP id y5-20020a056000108500b003432d7a143emr1209096wrw.48.1712130401299;
        Wed, 03 Apr 2024 00:46:41 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id cc13-20020a5d5c0d000000b00341b8edbe8csm14021282wrb.87.2024.04.03.00.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 00:46:40 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v12 0/7] drm/meson: add support for MIPI DSI Display
Date: Wed, 03 Apr 2024 09:46:31 +0200
Message-Id: <20240403-amlogic-v6-4-upstream-dsi-ccf-vim3-v12-0-99ecdfdc87fc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFcJDWYC/5XQTW7CMBAF4Ksgr+vKHv+z6j2qLhx7ApZCgmyIW
 iHu3gGppVU2YTlv8b2ZubCGtWBj282FVZxLK9NIg4SXDUv7OO6Ql0wBAwFKGAk8HoZpVxKfLdf
 8fGynivHAcys8pZ7P5aB459GAdCh7HRlBXWzIuxrHtCdqPA8DhceKffm8V79/0Lwv7TTVr/sms
 76lT3XOmgsOJkCCgBGsehvKGOv0OtUdu/mzed40ZBqLnYs6G7pqYdrnTUtmnyGm4LXRDhame5h
 eqFWmI9NZABn6ZDrwC9P/mlKKsMr0ZHqJOiLmKMPyn+GPCXqVGcgMBuilWaqAdmFK8YNqAcKsQ
 qUgNSdhhVPZKCWWqnyoClaqklShe2Myam2F/qder9dvQqQKljsDAAA=
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Nicolas Belin <nbelin@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 "Lukas F. Hartmann" <lukas@mntre.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6741;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=aEM9Na1E19MklSmNSuW8iA22W0ERaeQmoCjkiGVlIKE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmDQlcVdDx00Oh76x+vyFJ924OUDv9Fu9OQ6xIMwoO
 BO7hsB6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg0JXAAKCRB33NvayMhJ0QFfD/
 4jQg1fn2MuwLT/8aWKll71dka1V8Rx5Z4p43Xml+QKrzhc4HeZ9sqisCt8I8Nba801A0tD4iPx5B6c
 gNafEXq/DMQx2QWEplY1vN0bPLyxdLAI15KcZND/4WcObaOBLC2jnIc1E/FTu4T4SfYj2R86ji8Ek6
 VDiWXok8Z/u6Y3GBPxFF1/MhaRO1ro4bEBRVT2S+w5wr0YXCm5O9izWdFn6UrrjXXjORhwUnFLVxHl
 EeWRgzbbECAoBpMde9FIxkmWKxoEOyswo6cwrm3QYwc57e5MQkwnpOTVmkKDyuYGn0RPkareYRWGdo
 wSLivTAi3yLdIbP6tA6N+O00iFRtt0c+BLrf15na3rmF6KA/t/egTthMnw/guEGjZZ8Fz5ECl1vMBH
 P3Qdr3s4QFT50lMQRU1PZrzRFS5SUf/x1zHRZ0inuM1s8AH1RG6YsN2MrEBKkIr9xw0SwjCchzknbC
 VPysOXYYo/esWp8PTUnS28ZbgS1j3bw5r2kQTYUTUOf4c4THOZO0mrfU4p4u+fm1kPgW5hy35VMXp5
 pnsSeIKP+F1IyIU1yTfEXaJF7zzu/JHbxqnSeJSAzyPpqnves9IvrMgVLiXYlTQ5jIPwkkMZ8Nbz5p
 s+ZKr3rYIojJaluB9ZLX5hL1JMgOZD2hrYYbeg0XFCsF2ZipSmDFUCE04Pkg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Amlogic G12A, G12B & SM1 SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a),
with a custom glue managing the IP resets, clock and data input similar to the DW-HDMI
glue on the same Amlogic SoCs.

This is a follow-up of v5 now the DRM patches are applied, the clk & DT changes
remains for a full DSI support on G12A & SM1 platforms.

The DW-MIPI-DSI transceiver + D-PHY are clocked by the GP0 PLL, and the ENCL encoder + VIU
pixel reader by the VCLK2 clock using the HDMI PLL.

The DW-MIPI-DSI transceiver gets this pixel stream as input clocked with the VCLK2 clock.

An optional "MEAS" clock can be enabled to measure the delay between each vsync feeding the
DW-MIPI-DSI transceiver.

The clock setup has been redesigned to use CCF, a common PLL (GP0) and the VCLK2 clock
path for DSI in preparation of full CCF support and possibly dual display with HDMI.

The change from v5 is that now we use a "VCLK" driver instead of notifier and rely
on CLK_SET_RATE_GATE to ensure the VCLK gate operation are called.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v12:
- fix parameters alignment in patch 2
- update g12a_mipi_dsi_pxclk_div_table comment with jerome's suggestions
- fix dtbs overlay build, fix missed v11... thx khadas for reporting it off-list & testing
- Link to v11: https://lore.kernel.org/r/20240325-amlogic-v6-4-upstream-dsi-ccf-vim3-v11-0-04f55de44604@linaro.org

Changes in v11:
- Rebased on v6.9-rc1
- Fixed overlay handling/creation
- Link to v10: https://lore.kernel.org/r/20240205-amlogic-v6-4-upstream-dsi-ccf-vim3-v10-0-dc06073d5330@linaro.org

Changes in v10:
- Rename regmap_vclk to meson_clk and add _gate for the gate
- Move COMMON_CLK_MESON_VCLK to following patch
- Remove CLK_SET_RATE_PARENT from g12a_vclk2_sel, keep it only on mipi_dsi_pxclk_sel
- Add more info on commit message to specify how clock setup is designed
- Remove forgotten CLK_IGNORE_UNUSED on g12a_vclk2_input
- Remove useless CLK_SET_RATE_PARENT on g12a_vclk2_div to stop propagatting rate _after_ vclk2_div
- Remove invalid CLK_SET_RATE_GATE on g12a_vclk2 since it's not a divider...
- Drop already applied patches
- move Khadas TS050 changes as an overlay
- Link to v9: https://lore.kernel.org/r/20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-0-95256ed139e6@linaro.org

Changes in v9:
- Colledte reviewed-bys
- Fixed patches 2 & 4, commit messages and bindings format
- Link to v8: https://lore.kernel.org/r/20231109-amlogic-v6-4-upstream-dsi-ccf-vim3-v8-0-81e4aeeda193@linaro.org

Changes in v8:
- Switch vclk clk driver to parm as requested by Jerome
- Added bindings fixes to amlogic,meson-axg-mipi-pcie-analog & amlogic,g12a-mipi-dphy-analog
- Fixed DT errors in vim3 example and MNT Reform DT
- Rebased on next-20231107, successfully tested on VIM3L
- Link to v7: https://lore.kernel.org/r/20230803-amlogic-v6-4-upstream-dsi-ccf-vim3-v7-0-762219fc5b28@linaro.org

Changes in v7:
- Added review tags
- Fixed patch 5 thanks to George
- Link to v6: https://lore.kernel.org/r/20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v6-0-fd2ac9845472@linaro.org

Changes in v6:
- dropped applied DRM patches
- dropped clk private prefix patches
- rebased on top of 20230607-topic-amlogic-upstream-clkid-public-migration-v2-0-38172d17c27a@linaro.org
- re-ordered/cleaned ENCL patches to match clkid public migration
- Added new "vclk" driver
- uses vclk driver instead of notifier
- cleaned VCLK2 clk flags
- add px_clk gating from DSI driver
- Link to v5: https://lore.kernel.org/r/20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-0-56eb7a4d5b8e@linaro.org

Changes in v5:
- Aded PRIV all the G12 internal clk IDS to simplify public exposing
- Fixed the DSI bindings
- Fixed the DSI HSYNC/VSYNC polarity handling
- Fixed the DSI clock setup
- Fixed the DSI phy timings
- Dropped components for DSI, only keeping it for HDMI
- Added MNT Reform 2 CM4 DT
- Dropped already applied PHY fix
- Link to v4: https://lore.kernel.org/r/20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org

Changes from v3 at [3]:
- switched all clk setup via CCF
- using single PLL for DSI controller & ENCL encoder
- added ENCL clocks to CCF
- make the VCLK2 clocks configuration by CCF
- fixed probe/bind of DSI controller to work with panels & bridges
- added bit_clk to controller to it can setup the BIT clock aswell
- added fix for components unbind
- added fix for analog phy setup value
- added TS050 timings fix
- dropped previous clk control patch

Changes from v2 at [2]:
- Fixed patch 3
- Added reviews from Jagan
- Rebased on v5.19-rc1

Changes from v1 at [1]:
- fixed DSI host bindings
- add reviewed-by tags for bindings
- moved magic values to defines thanks to Martin's searches
- added proper prefixes to defines
- moved phy_configure to phy_init() dw-mipi-dsi callback
- moved phy_on to a new phy_power_on() dw-mipi-dsi callback
- correctly return phy_init/configure errors to callback returns

[1] https://lore.kernel.org/r/20200907081825.1654-1-narmstrong@baylibre.com
[2] https://lore.kernel.org/r/20220120083357.1541262-1-narmstrong@baylibre.com
[3] https://lore.kernel.org/r/20220617072723.1742668-1-narmstrong@baylibre.com

---
Neil Armstrong (7):
      dt-bindings: arm: amlogic: Document the MNT Reform 2 CM4 adapter with a BPI-CM4 Module
      clk: meson: add vclk driver
      clk: meson: g12a: make VCLK2 and ENCL clock path configurable by CCF
      drm/meson: gate px_clk when setting rate
      arm64: meson: g12-common: add the MIPI DSI nodes
      arm64: meson: khadas-vim3l: add TS050 DSI panel overlay
      arm64: dts: amlogic: meson-g12b-bananapi-cm4: add support for MNT Reform2 with CM4 adaper

 Documentation/devicetree/bindings/arm/amlogic.yaml |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   5 +
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  |  70 ++++
 .../meson-g12b-bananapi-cm4-mnt-reform2.dts        | 384 +++++++++++++++++++++
 .../boot/dts/amlogic/meson-khadas-vim3-ts050.dtso  | 108 ++++++
 drivers/clk/meson/Kconfig                          |   5 +
 drivers/clk/meson/Makefile                         |   1 +
 drivers/clk/meson/g12a.c                           |  76 ++--
 drivers/clk/meson/vclk.c                           | 141 ++++++++
 drivers/clk/meson/vclk.h                           |  51 +++
 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c          |   7 +
 11 files changed, 829 insertions(+), 20 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-b8e5217e1f4a

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


