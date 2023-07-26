Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1DA763D12
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGZQ6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjGZQ5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:57:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EE89C;
        Wed, 26 Jul 2023 09:57:53 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A2852660709C;
        Wed, 26 Jul 2023 17:57:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690390672;
        bh=GlSb/Bi4XjuFoQXGAU8G64f+6li+1Qu1vQWug/7FS4g=;
        h=From:To:Cc:Subject:Date:From;
        b=Y6BeWLgMrfIcehv5Ih0vL+HDn+bwY/cr2pesUVlIOakGBv2jPOsnhgCHHMoLQfonw
         5n4dnGMiYpWm+DJEToZmn1iUqHIazQJ+WEd/rw+B+dfxnwttftEpKYYlNEPJ0LMRQZ
         VElt4B1JoxD92zSWdD+vcjJ+2YsvEIIU1IYifPCyJwU4AIioe/JWHJuzFLZgjqUlev
         NNQ2KRAiCa7f6K6uLij5Wmpwc3soLAoXy+3WAhTpIhu5OAzqUhSMVL42Ih4y5iQpcu
         s8ce4GJ9a53q2gZBYUU40Jxg9qfwG1DGNgCWS3jn2WjigPEfwMHdHZMAhSj/Vx29E1
         Y2VVSGXhTgy8g==
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
Subject: [PATCH v2] media: mediatek: vcodec: Consider vdecsys presence in reg range check
Date:   Wed, 26 Jul 2023 12:57:39 -0400
Message-ID: <20230726165742.614248-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Tidied logic by moving number of maximum regs to separate variable
- Rebased on top of Hans' for-v6.6i branch

 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index 6cf5f88a3a8e..f5b8c37f32f5 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -96,6 +96,7 @@ static int mtk_vcodec_get_reg_bases(struct mtk_vcodec_dev *dev)
 	int reg_num, i;
 	struct resource *res;
 	bool has_vdecsys_reg;
+	int num_max_vdec_regs;
 	static const char * const mtk_dec_reg_names[] = {
 		"misc",
 		"ld",
@@ -122,10 +123,13 @@ static int mtk_vcodec_get_reg_bases(struct mtk_vcodec_dev *dev)
 	else
 		has_vdecsys_reg = true;
 
+	num_max_vdec_regs = has_vdecsys_reg ? NUM_MAX_VDEC_REG_BASE :
+					      ARRAY_SIZE(mtk_dec_reg_names);
+
 	/* Sizeof(u32) * 4 bytes for each register base. */
 	reg_num = of_property_count_elems_of_size(pdev->dev.of_node, "reg",
 						  sizeof(u32) * 4);
-	if (reg_num <= 0 || reg_num > NUM_MAX_VDEC_REG_BASE) {
+	if (reg_num <= 0 || reg_num > num_max_vdec_regs) {
 		dev_err(&pdev->dev, "Invalid register property size: %d\n", reg_num);
 		return -EINVAL;
 	}
-- 
2.41.0

