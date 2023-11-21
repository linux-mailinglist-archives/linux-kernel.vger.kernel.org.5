Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C7C7F2DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjKUMvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjKUMvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:51:15 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE2F10CA;
        Tue, 21 Nov 2023 04:51:05 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F2D156607314;
        Tue, 21 Nov 2023 12:51:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700571064;
        bh=8hsTcNhO6pxrVZKfxLeF/xkr1pZ2hVQ5uEBZ0ICc55k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nmoGRWIypByB7QtqvoL5JTa8TqDXOQZ4A0ih7PRveZ8JVpqM0wu53jXz0Z2a6cv74
         QWqflMRgdduut4HJGceb4XwQDT2cd7B1yIeQsX7QI8OVmS/N5q6thiWkkvL/22AJNM
         2BGzq60E1HV6MURl6nWU+613mgZSj30mNzso7kF1HkYerkfLTb2zVCc6GT10/50yeD
         X3pfrswRsgGcC+UEOOn39riImoTl9+g4YjySg+aSLLq616R4WkQzLv+xj+j7UxbPxj
         O3O2c6nOiG0sBSfvLuhptlin8XJznOxILTR5u8RW86F1Nyq+qNSrL8Sh1XsRYIE/GR
         +608jeQ/2nZ0A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v3 13/20] soc: mediatek: mtk-svs: Remove redundant print in svs_get_efuse_data
Date:   Tue, 21 Nov 2023 13:50:37 +0100
Message-ID: <20231121125044.78642-14-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121125044.78642-1-angelogioacchino.delregno@collabora.com>
References: <20231121125044.78642-1-angelogioacchino.delregno@collabora.com>
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

Callers of svs_get_efuse_data() are already printing an error in case
anything goes wrong, and the error print for nvmem_cell_read() failure
is redundant: remove it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index cd5064683506..5fd9884dd20f 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -1822,8 +1822,6 @@ static int svs_get_efuse_data(struct svs_platform *svsp,
 
 	*svsp_efuse = nvmem_cell_read(cell, svsp_efuse_max);
 	if (IS_ERR(*svsp_efuse)) {
-		dev_err(svsp->dev, "cannot read \"%s\" efuse: %ld\n",
-			nvmem_cell_name, PTR_ERR(*svsp_efuse));
 		nvmem_cell_put(cell);
 		return PTR_ERR(*svsp_efuse);
 	}
-- 
2.42.0

