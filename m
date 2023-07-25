Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC1F7623B4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjGYUlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjGYUlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:41:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7A32118;
        Tue, 25 Jul 2023 13:40:54 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 83EEB66003AA;
        Tue, 25 Jul 2023 21:40:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690317653;
        bh=iMBQ+s+wbpCm8QUbxfi+mfkOxoIlRyEKgUUo7g7/1i0=;
        h=From:To:Cc:Subject:Date:From;
        b=Cx3GrVj1e1Yf45KTfHj6nGdGPQwkfC3ZGbMopZLX6d+wmXEe1nUa0jxLgNGbS5soN
         mufw/QA1mUdaewY1A0DPSBvDbuMK9TGGIdm2CTUcuJckYGHZWDQtal+lspXcc74Kfz
         F6wSs1M7e5tKpWvgQF+3x/qEwvomKgU3uslCF5WAYcgsnxKSmp1PfIWNDYmXQrp66h
         CkvL7tDh0R5JwSBqKu+cs5nL6YoaZ/n9msdvVuV0vG5+ANjmlGSSqpMpdGwS1n8ia5
         AjUGAhWHbAN1+KjI70aaiaChZPlJwLT5K0nLsLIkBaL3rCuTSOqR5RU3kSsUTT+hfY
         BR8+sbXOms5HQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] media: mediatek: vcodec: Consider vdecsys presence in reg range check
Date:   Tue, 25 Jul 2023 16:40:39 -0400
Message-ID: <20230725204043.569799-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fe8a33978383 ("media: mediatek: vcodec: Read HW active status
from syscon") allowed the driver to read the VDEC_SYS io space from a
syscon instead of from the reg property when reg-names are supplied.
However as part of that change, a smatch warning was introduced:

drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c:142 mtk_vcodec_get_reg_bases() error: buffer overflow 'mtk_dec_reg_names' 11 <= 11

With a correct Devicetree, that is, one that follows the dt-binding, it
wouldn't be possible to trigger such a buffer overflow. Even so, update
the range validation of the reg property, so that the smatch warning is
fixed and if an incorrect Devicetree is ever supplied the code errors
out instead of causing memory corruption.

Reported-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Closes: https://lore.kernel.org/all/b5fd2dff-14a5-3ad8-9698-d1a50f4516fa@xs4all.nl
Fixes: fe8a33978383 ("media: mediatek: vcodec: Read HW active status from syscon")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index 742b6903d030..cd62b3f68072 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -124,7 +124,8 @@ static int mtk_vcodec_get_reg_bases(struct mtk_vcodec_dev *dev)
 	/* Sizeof(u32) * 4 bytes for each register base. */
 	reg_num = of_property_count_elems_of_size(pdev->dev.of_node, "reg",
 						  sizeof(u32) * 4);
-	if (reg_num <= 0 || reg_num > NUM_MAX_VDEC_REG_BASE) {
+	if (reg_num <= 0 || reg_num > NUM_MAX_VDEC_REG_BASE ||
+	    (!has_vdecsys_reg && reg_num > NUM_MAX_VDEC_REG_BASE - 1)) {
 		dev_err(&pdev->dev, "Invalid register property size: %d\n", reg_num);
 		return -EINVAL;
 	}
-- 
2.41.0

