Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D777E65DA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjKIJAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjKIJAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:00:17 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E1818C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:00:15 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40839807e82so3521085e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 01:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699520414; x=1700125214; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H3Ds8ZpgCrvCcost0dp5cuIUflgwiKCaqiDpNQ2wAlw=;
        b=hczhxLPt2lxMMwx29f28p47TRqqNZugCiTpk8RghyEfMqUwJ7P2PwwgYhjxzt5HcDf
         Y+C34sr/YQq7aP0z940iujE2nHBL02e53iez37gT4TBMb27/vIzgqWc2LRwP1ZI2x6Nb
         3F8NwW1L3G3INdnvoEnZKafDj4EuZFWBvmOYrXouhWobSkDCng7111+rGHc4+VYpO3Wa
         Q3a66S996LkXRE57iyOs/QfPalAL0VX7JZiy1znZxdM7d+WMd2+Ja9RmfNMJ/9VkSneh
         MJZ/8/NYz89aZjP+GCcSWOyC1ij4NkDaC1A8fEqlSl/e8ZuhODG1wMF8/pO/0Mxw7liM
         FK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699520414; x=1700125214;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3Ds8ZpgCrvCcost0dp5cuIUflgwiKCaqiDpNQ2wAlw=;
        b=vw1EWMEwmXUsNLg7jChUvvCm21SlqU+YzmPiDM/SWXU0vHoWG0sBm7THNqLtpIS3lz
         spjoXTzNC+XoKcdt5FISr5wx2daPSec3zsxg6DC5DL4Nm2R5GyryVC/ADotQ5YbieF2R
         25lQZSo7cFVv48jJ3DrGpqSCvIId2Mwpa54iOYAUC1WkLmfj9dnQrL5Sv9NUHgjzIRpj
         yM888xIVqjPhvgEziB3o5JAZmRrfDNItl6n3XW+g4/Qm+lI7y4wJW1igQa3YT5smjWmV
         +o2aGh6FSBDj4IYZKGSr01Qc1Wah+FHaw3HhfKUK4y8SSdpcCrB5D9nbKcPVS+AAuUGz
         zonA==
X-Gm-Message-State: AOJu0YyXroEiVIsuZdz5Wp+LAgEFuD6H0bQL3AEkR7ylrwnlmt772PqW
        0MVKc3UKqRtVpgp1/UfUhEdjxQ==
X-Google-Smtp-Source: AGHT+IF5WRyRrsPYdE6yoiaje9gsTiMsVUgql5u/Q2njzx3Fctv6hNFNp2V5P5ydrXi4y3Nvp0sAkw==
X-Received: by 2002:a05:600c:538f:b0:400:5962:6aa9 with SMTP id hg15-20020a05600c538f00b0040059626aa9mr10744641wmb.11.1699520412260;
        Thu, 09 Nov 2023 01:00:12 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ay36-20020a05600c1e2400b0040472ad9a3dsm1428484wmb.14.2023.11.09.01.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 01:00:11 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v8 00/12] drm/meson: add support for MIPI DSI Display
Date:   Thu, 09 Nov 2023 10:00:01 +0100
Message-Id: <20231109-amlogic-v6-4-upstream-dsi-ccf-vim3-v8-0-81e4aeeda193@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJGfTGUC/5XPTW7DIBAF4KtErDuVPebPXfUeVReABxvJhggS1
 Cry3Uuyqaps6uV7i+/N3FihHKiwt9ONZaqhhBRb0C8n5hYTZ4Iwtcyww6ETPYLZ1jQHB1UCh+u
 5XDKZDaYSwDkPNWwDWE0Ce0W954Y1yJpCYLOJbmlUvK5rK8+ZfPh6LH98tryEckn5+3FI5ff20
 Gbl0AGKER2OZFAO72uIJqfXlGd296s4bopmCklWGT6J9tWTKY+bspl+QuNGzQVX+GSqX1N3w79
 M1UwlEfvRO2FR/zH3ff8ByFk1UOYBAAA=
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Lukas F. Hartmann" <lukas@mntre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6066;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=VtqVpMW4Oqauicm9xV/MqmakvcGBhXTA5UAvHnDwNdQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlTJ+VIskmW0piYOecFu8ECJXkqP++lHoMcQirlLCK
 t9bzba6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUyflQAKCRB33NvayMhJ0ZJ8D/
 kBLY1/dJFvxfhrOHcHr8v/JW4n1farnobNtB+sE5Pp4d7lM9z6HkNhDe7mmqJAiuDNqJufKaxvp4bE
 lom6dYx6HIPOsQhQjJHgmCD29A5vAvDcQM/AUHK75ZYdVdNpZzKukYZRY/e5QrxfgS2bCpo4g6TWg5
 edVkVtPSST7boCJsvp1ybNJ/cT5sy1qUUgWJWfE0npmrNq0ySeDuxNFkdS1V4wETWE+Y0dpi2VV41r
 rEKMe5cmZL3YSuxFiPgLPmKZmn3GH9eZ07pzweGiGcu8t59RvFK8082x+oKfXdvAnh/oC5r+U25/k7
 EGjiD0fVKlrxhgE/Ps5DuiuJOpKtT9ef/rn3iwSsZW2G5Mgd+WT7IGe9Ms/p/Yowm0iTIZFRJ7PD57
 CB9UNBwGzXc1CiASoNN8VK6CNHmys5rpUW7m+WZpQ9PcDMxWL99xMKYdSqkxVHKW3rxUqub8ktZW/p
 Yime4QJ+YV3yxutEmuMiyhC+GcyueStkk+wfq0EDcmRbxQTb/U7mYuv5BRT+4x6jfpetRa1pLrXSyE
 SQFmYfgfc6ovv3kKyc7hAK91G0VBySq0n6ldDjjj1ngSJYC+42ru3k+5LVTi0oSyB+3Ns8WQ2YuWVV
 SXAovq91VxwPeWNhMow30azKWPcpaDP/PmeUoDtcnYXhglrfgc0s9ZpI0zvw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A, G12B & SM1 SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a),
with a custom glue managing the IP resets, clock and data input similar to the DW-HDMI
glue on the same Amlogic SoCs.

This is a follow-up of v5  now the DRM patches are applied, the clk & DT changes
remains for a full DSI support on G12A & SM1 platforms.

The DW-MIPI-DSI transceiver + D-PHY are clocked by the GP0 PLL, and the ENCL encoder + VIU
pixel reader by the VCLK2 clock using the HDMI PLL.

The DW-MIPI-DSI transceiver gets this pixel stream as input clocked with the VCLK2 clock.

An optional "MEAS" clock can be enabled to measure the delay between each vsync feeding the
DW-MIPI-DSI transceiver.

The clock setup has been redesigned to use CCF, a common PLL (GP0) and the VCLK2 clock
path for DSI in preparation of full CCF support and possibly dual display with HDMI.

The change from v5 is that now we use a "VCLK" driver instea dof notifier and rely
on CLK_SET_RATE_GATE to ensure the VCLK gate operation are called.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
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
Neil Armstrong (12):
      dt-bindings: clk: g12a-clkc: add CTS_ENCL clock ids
      dt-bindings: soc: amlogic,meson-gx-hhi-sysctrl: add example covering meson-axg-hhi-sysctrl
      dt-bindings: phy: amlogic,meson-axg-mipi-pcie-analog: drop text about parent syscon and drop example
      dt-bindings: phy: amlogic,g12a-mipi-dphy-analog: drop unneeded reg property and example
      dt-bindings: arm: amlogic: Document the MNT Reform 2 CM4 adapter with a BPI-CM4 Module
      clk: meson: g12a: add CTS_ENCL & CTS_ENCL_SEL clocks
      clk: meson: add vclk driver
      clk: meson: g12a: make VCLK2 and ENCL clock path configurable by CCF
      drm/meson: gate px_clk when setting rate
      arm64: meson: g12-common: add the MIPI DSI nodes
      DONOTMERGE: arm64: meson: khadas-vim3l: add DSI panel
      arm64: dts: amlogic: meson-g12b-bananapi-cm4: add support for MNT Reform2 with CM4 adaper

 Documentation/devicetree/bindings/arm/amlogic.yaml |   1 +
 .../phy/amlogic,g12a-mipi-dphy-analog.yaml         |  12 -
 .../phy/amlogic,meson-axg-mipi-pcie-analog.yaml    |  17 -
 .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml  |  41 +++
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  |  70 ++++
 .../meson-g12b-bananapi-cm4-mnt-reform2.dts        | 384 +++++++++++++++++++++
 .../boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi   |   2 +-
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi |  74 ++++
 .../boot/dts/amlogic/meson-sm1-khadas-vim3l.dts    |   2 +-
 drivers/clk/meson/Kconfig                          |   5 +
 drivers/clk/meson/Makefile                         |   1 +
 drivers/clk/meson/g12a.c                           | 106 ++++--
 drivers/clk/meson/vclk.c                           | 141 ++++++++
 drivers/clk/meson/vclk.h                           |  51 +++
 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c          |   7 +
 include/dt-bindings/clock/g12a-clkc.h              |   2 +
 17 files changed, 866 insertions(+), 51 deletions(-)
---
base-commit: 5cd631a52568a18b12fd2563418985c8cb63e4b0
change-id: 20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-b8e5217e1f4a

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

