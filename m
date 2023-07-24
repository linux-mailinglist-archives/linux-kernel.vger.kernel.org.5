Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A5975ED24
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjGXINR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjGXINL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:13:11 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944E31BF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:13:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991f956fb5aso606724266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690186382; x=1690791182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1X6ZNWe7KmsdOhe9OS7Rrilt+XPjdCv43wNon4Ix9Y=;
        b=rZc/HThDDCTkEHUbzOlgeQs1dsskn6riY8jUBAHqsDkAKWwKfXkqZQx4G47lxpdx7m
         nd8s+AlIz76w+SDrXxRCXv+kVwwUlpK03TSZ9931P+XZ6BPgGKzg270lnDkuT3F2VN8M
         BEDYSpXlsZy65JGKsYrPenLN3m3+c9XMvPOgrtW3rD17kVQorugjFfBlOtGa9OVMpNoD
         1neGHtEcklUlVCL9R4PgODSSlW929TgmJGOnTxhBpCv6rvsrA4a7IwghzNcmHIuJWUK7
         ao2XUOlHh+3vcklnogYlcE9NnjcIt/ddtjXFnqRcVOfortXwQxysmY0L2djjhOEfjSZR
         oIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690186382; x=1690791182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1X6ZNWe7KmsdOhe9OS7Rrilt+XPjdCv43wNon4Ix9Y=;
        b=GfphCdWInoUhNPhdl1xV8P2YwuVestJxmVPnxamLKejAG1LAUkLIQeK1ck1p4AV8mx
         sNFT430OmVbuYvJpjXcC5P+Oc7Bdt2ftm/06V1V2ORtwUsSQxUWSLZQdhJBKqrHp3qCd
         VESfBjvR+8tsULpUMUlNO6Xh/AzgyxTcHUpCARdLIrcBw43NrJlid8xdMn4GwPNTw2V0
         TwuwqToq9YGDy0PzMIG0mR4VcAsxBK+gnC8RyCTDSNLQvEg3RLm1/UpBaMfpgXE2gEvl
         oubqwQ+DUmf51zIqajCn2V/rSYrb/A5g0VFar5VPiycFMkrqnSn2VlvnPRxY4awvwqBC
         WJSw==
X-Gm-Message-State: ABy/qLaDhDMXOQAjSRfmIH06/lUBEBmCPWWW2mVfpuCCKLxcaYHmNse1
        LLGoeGEeP/6vizWUZxyq3yameA==
X-Google-Smtp-Source: APBJJlHqJYCfSz/MTO7jJORcnGXPH40baCU805RSFxNYKz8+bECTv8+o6uOBhHnLOAXFrmUL73OfwA==
X-Received: by 2002:a17:906:3f1e:b0:992:4d30:dc4a with SMTP id c30-20020a1709063f1e00b009924d30dc4amr8639057ejj.74.1690186381836;
        Mon, 24 Jul 2023 01:13:01 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709065f8600b0098ec690e6d7sm6355395eju.73.2023.07.24.01.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:13:00 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH v3 04/11] mtd: spi-nor: spansion: switch set_octal_dtr method to use vreg_offset
Date:   Mon, 24 Jul 2023 11:12:40 +0300
Message-Id: <20230724081247.4779-5-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724081247.4779-1-tudor.ambarus@linaro.org>
References: <20230724081247.4779-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2594; i=tudor.ambarus@linaro.org; h=from:subject; bh=kgTcomoQU7JsYNjD2ojxcF6vrGgWFcnW4j+zTTO9fWg=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkvjJ+F1McRGWHDR/dosXymqrH8LFtXFXqWHGWg YCEuhu05uqJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZL4yfgAKCRBLVU9HpY0U 6THrB/9hGcQ+dUFmN1EHMfc9PNt80BWHmBTNhdkusNicxLfEwfliKYVTpYiOuZlHUzBmLCAkCff xIqfJb9TryAKIA+tr1YQjaVCRdlHoB+rqDf1R0mpU5vEN5VI/jtjgV9gr62Di1m9D/AdsY/0HhG OsNOIVhYQSHXQ1R2IehWb9T7ntb5CJmPDNP/PezvC1U9bBqneaSgYfBuJsjFjV7SMdrbChMghSl RbtbnsvYdVjE1we9rdOwglgQM1Ia1Zx6hT8nn3T0ssebFiQei6ILrueLwV+xN8EOCOEMN0JpMbl e2bH9KS+8auJq/Yh5hBMp42eaNMy8XmxTgiSLn9/guMiar1S
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

All the Infineon flashes that currently support octal DTR mode
define the optional SCCR SFDP table, thus all retrieve vreg_offset.
Switch all the available octal DTR Infineon flashes to use the
volatile register offset to set the configuration registers. The goal
is to have a single pair of methods for both single/multi-chip package
devices.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi-nor/spansion.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 51eabddf2b16..dc4841891b74 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -6,6 +6,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/mtd/spi-nor.h>
 
 #include "core.h"
@@ -202,14 +203,18 @@ static int cypress_nor_set_octal_dtr_bits(struct spi_nor *nor, u64 addr)
 
 static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
 {
+	const struct spi_nor_flash_parameter *params = nor->params;
 	u8 *buf = nor->bouncebuf;
+	u64 addr;
 	int ret;
 
-	ret = cypress_nor_set_memlat(nor, SPINOR_REG_CYPRESS_CFR2V);
+	addr = params->vreg_offset[0] + SPINOR_REG_CYPRESS_CFR2;
+	ret = cypress_nor_set_memlat(nor, addr);
 	if (ret)
 		return ret;
 
-	ret = cypress_nor_set_octal_dtr_bits(nor, SPINOR_REG_CYPRESS_CFR5V);
+	addr = params->vreg_offset[0] + SPINOR_REG_CYPRESS_CFR5;
+	ret = cypress_nor_set_octal_dtr_bits(nor, addr);
 	if (ret)
 		return ret;
 
@@ -247,9 +252,11 @@ static int cypress_nor_set_single_spi_bits(struct spi_nor *nor, u64 addr)
 static int cypress_nor_octal_dtr_dis(struct spi_nor *nor)
 {
 	u8 *buf = nor->bouncebuf;
+	u64 addr;
 	int ret;
 
-	ret = cypress_nor_set_single_spi_bits(nor, SPINOR_REG_CYPRESS_CFR5V);
+	addr = nor->params->vreg_offset[0] + SPINOR_REG_CYPRESS_CFR5;
+	ret = cypress_nor_set_single_spi_bits(nor, addr);
 	if (ret)
 		return ret;
 
@@ -714,7 +721,15 @@ static int s28hx_t_post_bfpt_fixup(struct spi_nor *nor,
 
 static int s28hx_t_late_init(struct spi_nor *nor)
 {
-	nor->params->set_octal_dtr = cypress_nor_set_octal_dtr;
+	struct spi_nor_flash_parameter *params = nor->params;
+
+	if (!params->n_dice || !params->vreg_offset) {
+		dev_err(nor->dev, "%s failed. The volatile register offset could not be retrieved from SFDP.\n",
+			__func__);
+		return -EOPNOTSUPP;
+	}
+
+	params->set_octal_dtr = cypress_nor_set_octal_dtr;
 	cypress_nor_ecc_init(nor);
 
 	return 0;
-- 
2.34.1

