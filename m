Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8785B7F2C52
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjKUL45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbjKUL4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:56:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE5492;
        Tue, 21 Nov 2023 03:56:33 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 01C9F6607286;
        Tue, 21 Nov 2023 11:56:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700567791;
        bh=n/QwQ/VSC58UKI+cZu75pBr4SUUF9z59vdJN4z8NLnc=;
        h=From:To:Cc:Subject:Date:From;
        b=dR5aJJ2W6ufYnNy+jo2wFOFXWbjt4WdKVz1g/0y0p/qTaFVCoUKcY0/3E8lqAaeTW
         bm5W1BUBrDFsNOufuYq32f7iOdH5cCR3eg6nxuRNOPwgucODmRUiNfDtbNGHpfv9sP
         OSPbAenSl5suOgw/rekOTp1CueyPACYgtYYsg+lUk7RqYYjSzaK68eRaxAphC5nGxL
         jRyV84K4metj/B14TdvGNEaYIWLJxR2xPbl96kO4bISNi2XWomktGRMI8uDe+n/ngU
         +6/tFu40o0sf12/jwHh+4V45KErteXcukGNKIcaiamYyU3z8+LkFX8pVwNSpgfqQga
         hZdYVmdqZvecQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v2 00/20]  MediaTek SVS driver partial refactoring
Date:   Tue, 21 Nov 2023 12:56:04 +0100
Message-ID: <20231121115624.56855-1-angelogioacchino.delregno@collabora.com>
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
 drivers/soc/mediatek/mtk-svs.c           | 1996 +++++++++++-----------
 4 files changed, 993 insertions(+), 1058 deletions(-)

-- 
2.42.0

