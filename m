Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B35977DF0F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243642AbjHPKm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243954AbjHPKmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:42:54 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4672110
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:42:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bddac1b7bfso21608845ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692182572; x=1692787372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7PnvIFrpSGnja4bvJtTn8bJ0Kfic4a2Wxy3t2tdxXRU=;
        b=CoAp7Fc1Cacsc2lmTyKEL5Lgy0D1mtYvNUWh/lzpXdMqI76zMeZUv1o3cpEgTmRLP/
         kQ3Leidt/qHEmucA2U/DXSpGAbR1wh7SMHtLueY98tqpRiXqKsul9R38jTyghIwV4Bez
         ZLQZnBLtq0Fiv4ucAAh1wbSGG1XqddS8CIm7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692182572; x=1692787372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PnvIFrpSGnja4bvJtTn8bJ0Kfic4a2Wxy3t2tdxXRU=;
        b=F0UabxyUSV9Yl/DTCNghCteriAD6mUnR42eBm9Nv7Dml6kc8jPaLzi+XK09I29g8sR
         LN/ZA7xeegrmQ8uhaXRZvcTOY5j7lpZJHZ+V8EHIvID1hWFPQ+LAhR9aXYQHXiLGHTgQ
         G2SLdXVbmjoPr3O4qbPRdNDtq4zIy2T/39hdfjOmWs9R3JjiUsFAh47L0O1xVcZR8se0
         ABQ82cwooaXsqgzsb+1riW/AKMaokV5qSRUtVNQpTfo3zwHgfQNjavxbjVsRARru5j3C
         zHySCO776nPl7Bc70Z5xPrLKGooJsZFcKv8rEumVEozgpoQOnUjW80EY1kka6FIPE35W
         sG0Q==
X-Gm-Message-State: AOJu0Yyouvkw/C7wGZEAEJ3aor7ulagvBp5A40PZLt9ADIVm7OtTGz/n
        Jybm1tParLOYw+NhaNClaR5c2A==
X-Google-Smtp-Source: AGHT+IFPXnWFX4zJxPA3lPUtxu59Q9sGZo/xVnTX67kYXuB7P1GInWKjqj/biOIS/1y+wH4+4gntTQ==
X-Received: by 2002:a17:902:c70c:b0:1bd:f69e:a407 with SMTP id p12-20020a170902c70c00b001bdf69ea407mr4771921plp.8.1692182572401;
        Wed, 16 Aug 2023 03:42:52 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:40cf:3807:f8c8:2d76])
        by smtp.gmail.com with ESMTPSA id kx14-20020a170902f94e00b001b8a3dd5a4asm2899270plb.283.2023.08.16.03.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 03:42:52 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        "Miquel Raynal )" <miquel.raynal@bootlin.com>,
        "Richard Weinberger )" <richard@nod.at>,
        "Vignesh Raghavendra )" <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2,1/2] mtd: spi-nor: giga: gd25lq64c: Disable quad mode according to bus width
Date:   Wed, 16 Aug 2023 18:38:32 +0800
Message-ID: <20230816104245.2676965-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gd25lq64c has Quad Enable Requirement flag parsed as
BFPT_DWORD15_QER_SR2_BIT1_BUGGY in BFPT, even if spi-{rx/tx}-bus-width
set as non QUAD, eg. 0, 1, 2... Thus quad_enable will not be NULL and
quad enable (QE) bit will be set to 1 by default. According to
datasheet[1], if QE bit is enabled, WP pin will become IO pin and the
system can't use write protection feature, and it's also not recommended
to set QE bit to 1[1].

Add a post_bfpt fixup that reads spi-rx-bus-width to remove quad_enable
if the width is set to below QUAD mode.

[1]
https://www.gigadevice.com.cn/Public/Uploads/uploadfile/files/20220714/DS-00012-GD25LQ64C-Rev3.4.pdf
page 13

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/mtd/spi-nor/gigadevice.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
index d57ddaf1525b3..8ea89e1858f9b 100644
--- a/drivers/mtd/spi-nor/gigadevice.c
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -33,6 +33,31 @@ static const struct spi_nor_fixups gd25q256_fixups = {
 	.post_bfpt = gd25q256_post_bfpt,
 };
 
+static int
+gd25lq64c_post_bfpt(struct spi_nor *nor,
+		    const struct sfdp_parameter_header *bfpt_header,
+		    const struct sfdp_bfpt *bfpt)
+{
+	struct device_node *np = spi_nor_get_flash_node(nor);
+	u32 value;
+
+	/*
+	 * Even if spi-{tx,rx}-bus-width is set to DUAL mode, due to the QER
+	 * flag parsed from BFPT is BFPT_DWORD15_QER_SR2_BIT1_BUGGY, so the
+	 * quad_enable will be set and QE bit set to 1.
+	 */
+	if (!of_property_read_u32(np, "spi-rx-bus-width", &value)) {
+		if (value <= 2)
+			nor->params->quad_enable = NULL;
+	}
+
+	return 0;
+}
+
+static struct spi_nor_fixups gd25lq64c_fixups = {
+	.post_bfpt = gd25lq64c_post_bfpt,
+};
+
 static const struct flash_info gigadevice_nor_parts[] = {
 	{ "gd25q16", INFO(0xc84015, 0, 64 * 1024,  32)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
@@ -53,7 +78,8 @@ static const struct flash_info gigadevice_nor_parts[] = {
 	{ "gd25lq64c", INFO(0xc86017, 0, 64 * 1024, 128)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
+			      SPI_NOR_QUAD_READ)
+		.fixups = &gd25lq64c_fixups },
 	{ "gd25lq128d", INFO(0xc86018, 0, 64 * 1024, 256)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-- 
2.41.0.694.ge786442a9b-goog

