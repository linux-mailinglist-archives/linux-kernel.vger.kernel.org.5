Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A4E7F606B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345512AbjKWNhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345501AbjKWNhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:37:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD031A8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:38:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39466C433C8;
        Thu, 23 Nov 2023 13:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700746681;
        bh=Kbejb0pedrawxY+pi+DDjvZjKDSamA1YE5y/xYy428I=;
        h=From:To:Cc:Subject:Date:From;
        b=UMAztWdfrWZb+e0C/ri4ppoNy2OFRDYeBO2/klDT6OSA68JTnvdYMOGPwHiOlbKII
         jfRew+TsZO9d1yfQcIA8PzXJbCrv2wn/kqG1GrZKDmQP2QhN+Lb9VO50CqIiIrD3Lg
         eqQWxCEOkX1FrL/OTu8q+YB9Oqwd72zg7VVuGRz2Nv/05vSY343Sh/FtJJf+6Z4Q1N
         3R9Q72CXgM6+HzPcywTBMtlFPVG8PC6MyjKHwRcubfAcX4v/XoMd4K57ExZU9NkYyV
         T7cexV+whxMegO8gqovedEzEPEi0kt+P9/n7f3dcbkiEgi5yh/185+/2Mgq+3hZd+G
         J2gf0uf60LdrA==
From:   Michael Walle <mwalle@kernel.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, Michael Walle <mwalle@kernel.org>
Subject: [PATCH 0/4] drm/mediatek: support DSI output on MT8195
Date:   Thu, 23 Nov 2023 14:37:45 +0100
Message-Id: <20231123133749.2030661-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for a DSI output on VDOSYS0. Luckily, there is a new
feature to support dynamic selections of the output (connector).
Use it to add support for a DSI output.

Apart from that, this is pretty straghtforward by just adding new
compatibles and add the correct DSI nodes to the SoC dtsi.

This was tested with a Toshiba TC358775 DSI-to-LVDS bridge and
three different panels. Please note, that the driver for this
bridge doesn't work well and needs a more or less complete rework,
which will be posted on a separate series.

Michael Walle (4):
  dt-bindings: display: mediatek: dsi: add compatible for MediaTek
    MT8195
  dt-bindings: phy: add compatible for Mediatek MT8195
  arm64: dts: mediatek: mt8195: add DSI and MIPI DPHY nodes
  drm/mediatek: support the DSI0 output on the MT8195 VDOSYS0

 .../display/mediatek/mediatek,dsi.yaml        |  4 ++
 .../bindings/phy/mediatek,dsi-phy.yaml        |  1 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 48 +++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  8 +++-
 4 files changed, 60 insertions(+), 1 deletion(-)

-- 
2.39.2

