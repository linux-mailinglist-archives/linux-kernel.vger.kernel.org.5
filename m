Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C283776970C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjGaNEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjGaNEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:04:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DCA10E3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:04:46 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 17B9F66003AC;
        Mon, 31 Jul 2023 14:04:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690808685;
        bh=xhmK2szNqpATULb/U51CKDpINT6FFCktw50/f6Vdp6M=;
        h=From:To:Cc:Subject:Date:From;
        b=f3Xw23WXSDOTX3n42XOeXtF64zWHP14NhBaJwBAehO+pweMEZxhZNRgO6SWVtMz+l
         UDlcmKD5YRT7VxpVqELKZLE318GfCHCP0zIey4/McEl6TJwR0Baialm+Fysmxa0PxI
         TzArTj7WYcALdFQSl+AZ/c/euMzaPOMo2QM5EsxKLupgNJI+a0QVok6HQcAnNHY0W8
         Gg2CvR2ytuCUaST0qSmrZ1uQjWBEXV90IW9CNQmR+cUhc06z9zxktZp/2gXOO5vv68
         gap9okmDxGqXnny6n3DYHw2ZLbNlGegljBgE3D4EDmXCURhKu1s8t/Q6ko0wILWgEg
         gFwzoyzwSGwwg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com, ehristev@collabora.com
Subject: [PATCH v7 00/13] MediaTek DDP GAMMA - 12-bit LUT support
Date:   Mon, 31 Jul 2023 15:04:28 +0200
Message-ID: <20230731130441.173960-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v7:
 - Added check for NULL dev for AAL-gamma case
 - Added get_lut_size callback for AAL-gamma
 - Added comment to clarify SoC 10/12 bits support and old vs new
   register layout as suggested by Alexandre M.

Changes in v6:
 - Fixed smatch warning in patch 11/11, ref.:
   https://lore.kernel.org/all/202306101458.lRXHEE0Z-lkp@intel.com/

Changes in v5:
 - Removed incorrect comment on default LUT size and bits
 - Removed useless check for num_lut_banks
 - Added comment about CMDQ implementation on patch 5
 - Evaluated passing lut size/bits from AAL, idea discarded as
   the implementation would be rather tricky while bringing no
   benefits.

Changes in v4:
 - Fixed assignment typo appeared in v3

Changes in v3:
 - Fixed issues due to variables renaming during cleanup (oops)
 - This is actually the right series, since v2 was taken from the
   wrong kernel tree.... :-)

Changes in v2:
 - Added explicit inclusion of linux/bitfield.h in patch [06/11]

This series adds support for GAMMA IP requiring and/or supporting
a 12-bits LUT using a slightly different register layout and programming
sequence for multiple LUT banks: this IP version is currently found
on a number of SoCs, not only including the Chromebook/IoT oriented
Kompanio 1200/1380 MT8195/MT8195T, but also Smartphone chips such as
the Dimensity 9200 (MT6985) and others.

This series was tested on MT8195, MT8192, MT8173, MT6795:
 * MT6795, MT8192, MT8173: No regression, works fine.
 * MT8195: Color correction is finally working!

AngeloGioacchino Del Regno (12):
  drm/mediatek: gamma: Reduce indentation in mtk_gamma_set_common()
  drm/mediatek: gamma: Support SoC specific LUT size
  drm/mediatek: gamma: Improve and simplify HW LUT calculation
  drm/mediatek: gamma: Enable the Gamma LUT table only after programming
  drm/mediatek: gamma: Use bitfield macros
  drm/mediatek: gamma: Support specifying number of bits per LUT
    component
  drm/mediatek: gamma: Support multi-bank gamma LUT
  drm/mediatek: gamma: Add support for 12-bit LUT and MT8195
  drm/mediatek: gamma: Make sure relay mode is disabled
  drm/mediatek: gamma: Program gamma LUT type for descending or rising
  drm/mediatek: aal: Rewrite kerneldoc for struct mtk_disp_aal
  drm/mediatek: gamma: Add kerneldoc for struct mtk_disp_gamma

Jason-JH.Lin (1):
  drm/mediatek: gamma: Adjust mtk_drm_gamma_set_common parameters

 drivers/gpu/drm/mediatek/mtk_disp_aal.c     |  27 ++-
 drivers/gpu/drm/mediatek/mtk_disp_drv.h     |   4 +-
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c   | 217 +++++++++++++++++---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |   8 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |   1 -
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   2 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   9 +
 7 files changed, 226 insertions(+), 42 deletions(-)

-- 
2.41.0

