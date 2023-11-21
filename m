Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9407F2D91
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjKUMu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjKUMu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:50:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B871AA;
        Tue, 21 Nov 2023 04:50:52 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 63E306607314;
        Tue, 21 Nov 2023 12:50:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700571051;
        bh=tChGrRD783h6BgpHePb4MPftUfyiwkFDBoUMzwOe+Ts=;
        h=From:To:Cc:Subject:Date:From;
        b=U1taiTBrm7oRGIdK+/S0PbjT1BwBrSnI9B8N2OiLGt99ocohaB+aq3vQALxDVVA0q
         jvZSBjW3OQaxPg9BayWVt2so4fgk0TrdEH8Q/hV17tHdehsEcVM82G8uHmtf80YRf1
         wSXO56qeGRY8Q+78mF6fd8uhPLov3Uf0H/fd8bAZyCphc4UMxEP8OBg9qE8rhGIWX9
         KeTftokLvZYhDnBaBruhmTDHJSHJPi81o0GVA4difTFJ9eAb3BJLBjyTQLzSLuRluV
         my2EtRf0TeTvjABGAviX0pdrsDKevSakBHLoyXU1v+wkNmq+bmJf+a36X+lPNQ/f9n
         6p0xyp88TcAOw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v3 00/20] MediaTek SVS driver partial refactoring
Date:   Tue, 21 Nov 2023 13:50:24 +0100
Message-ID: <20231121125044.78642-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
 - Fix patch [18/20] for tzone_name moved to pdata

Changes in v2:
 - Fixed some style issues in patch [18/20]


This is a partial refactoring of the MediaTek Smart Voltage Scaling
driver.
Long story short: this driver never worked as expected on any platform
because of various issues so in this series there are some changes that
will break compatibility with older device trees (of which, only MT8183
ever had the SVS node), but those are acceptable because... it never
really worked fine anyway, so there's no regression.

This series was tested on MT8186, MT8192, MT8195 Chromebooks.


Depends on

MT8192 thermal node:
https://lore.kernel.org/lkml/20231017190545.157282-5-bero@baylibre.com/

MT8186 and MT8195 SVS support:
https://lore.kernel.org/all/20231011034307.24641-1-chun-jen.tseng@mediatek.com/

Note: one commit was omitted because I haven't got feedback yet on
the thermal-zones devicetree consumers implementation at [1], but I
still wanted to send this series to the lists to get feedback.
Please keep in mind that the one omitted commit is supposed to go
on top of this series anyway, and that an useful example of how the
SVS node will look with the DT thermal zones is provided at [1].

[1]: https://lore.kernel.org/all/20231115144857.424005-1-angelogioacchino.delregno@collabora.com/

AngeloGioacchino Del Regno (20):
  arm64: dts: mediatek: mt8183: Change iospaces for thermal and svs
  soc: mediatek: mtk-svs: Subtract offset from regs_v2 to avoid conflict
  soc: mediatek: mtk-svs: Convert sw_id and type to enumerations
  soc: mediatek: mtk-svs: Build bank name string dynamically
  soc: mediatek: mtk-svs: Reduce memory footprint of struct svs_bank
  soc: mediatek: mtk-svs: Change the thermal sensor device name
  soc: mediatek: mtk-svs: Add a map to retrieve fused values
  soc: mediatek: mtk-svs: Add SVS-Thermal coefficient to SoC platform
    data
  soc: mediatek: mtk-svs: Move t-calibration-data retrieval to
    svs_probe()
  soc: mediatek: mtk-svs: Commonize efuse parse function for most SoCs
  soc: mediatek: mtk-svs: Drop supplementary svs per-bank pointer
  soc: mediatek: mtk-svs: Commonize MT8192 probe function for MT8186
  soc: mediatek: mtk-svs: Remove redundant print in svs_get_efuse_data
  soc: mediatek: mtk-svs: Compress of_device_id entries
  soc: mediatek: mtk-svs: Cleanup of svs_probe() function
  soc: mediatek: mtk-svs: Check if SVS mode is available in the
    beginning
  soc: mediatek: mtk-svs: Use ULONG_MAX to compare floor frequency
  soc: mediatek: mtk-svs: Constify runtime-immutable members of svs_bank
  arm64: dts: mediatek: mt8192: Add Smart Voltage Scaling node
  arm64: dts: mediatek: mt8195: Add SVS node and reduce LVTS_AP iospace

 arch/arm64/boot/dts/mediatek/mt8183.dtsi |   26 +-
 arch/arm64/boot/dts/mediatek/mt8192.dtsi |   12 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi |   17 +-
 drivers/soc/mediatek/mtk-svs.c           | 2002 +++++++++++-----------
 4 files changed, 996 insertions(+), 1061 deletions(-)

-- 
2.42.0

