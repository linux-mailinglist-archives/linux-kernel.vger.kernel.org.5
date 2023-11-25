Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AA37F8AD0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjKYMgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjKYMfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:35:53 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0BB19B6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:35:56 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54afdbdb7d2so1762719a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700915754; x=1701520554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcXs8DG65Rtg58oE+up88Lq4hTYhaQzAZwdBNatPv3E=;
        b=c82j5qXo0XNniDBJR6Fr9PNjZPHTPVqanITi0G8ofo2YiiEvE3ESlb3N1IIf1WHFc6
         1wBplVZgQIaWMYrceTyBcRtoVgm+505sArBWzydXLltvTwnyD0+AO2MbB5CnvSJCZPqi
         aoEFPDk0F736uVqx1JTlHXn7dKY/5RVRjx3R/LwTm/9clYJpsIjOk+kGlbtuhTimQmPJ
         XfHKEvDc7Op7Y1pYT1T9OYKVUzecmg9CwQNEOHOt6ShSHY0k1tg52gBj9+XcmHaaSUOt
         pP4sRT6oaeGpUBCuefaJ0FTBBcGJxppUKVzzbzYhjbShJGItavfZBqvQwS0gx3lUQP7b
         BvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700915755; x=1701520555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcXs8DG65Rtg58oE+up88Lq4hTYhaQzAZwdBNatPv3E=;
        b=mKWEcLY9LAIxwBYxKJdk3SD8HvXjylmG6LDrzC0FOKVwWnmm7FSiUprj7lJlpbocLM
         c8VoBKTcZWntPVEFzZL33ADs6OAyNyf4cW0zkAoa/qnSSBVHw3Xh0g8/cHrl24SgHmsD
         9a7vpVI3GRVrebOEx+ZEQte7V/6CcEJsuU8Z1fW29CClHlJxm8//qTT62AniOhIvU3Ha
         UFhGw/7eonP5AoWG53Pdr9LvdZHYK1wlRqbi0RxW0uGrvm921CI2+Fi9j+E/4PSjNtaM
         N15SFdPX9sOOLIfR+XhiCrPAqPGhCV6HC1swJ18MEIMTBgoAehtMvHUXKohJrd76GJj3
         rLKw==
X-Gm-Message-State: AOJu0YxTM4RhK1X4Cy6Xo/t9kvsgFChb4c0q14u+/AAtVhOFK4TrJTLK
        GyqUCJN1vlJdCuK7xEOhpLJKfQ==
X-Google-Smtp-Source: AGHT+IHdeYl/OJTLXATqbQBrqR9h57XosEk+PYRoSMKkDelPWWmhTNWK1ojD/74xFrBnLuDA9IZh0Q==
X-Received: by 2002:a17:906:9e08:b0:a03:4acd:750f with SMTP id fp8-20020a1709069e0800b00a034acd750fmr3994977ejc.20.1700915754802;
        Sat, 25 Nov 2023 04:35:54 -0800 (PST)
Received: from 1.. ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id lv23-20020a170906bc9700b009f28db2b702sm3390163ejb.209.2023.11.25.04.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 04:35:54 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     pratyush@kernel.org, michael@walle.cc, fastevam@denx.de
Cc:     linux-mtd@lists.infradead.org, takahiro.kuwano@infineon.com,
        bacem.daassi@infineon.com, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 5/5] mtd: spi-nor: micron-st: Add support for mt25qu01g
Date:   Sat, 25 Nov 2023 14:35:29 +0200
Message-Id: <20231125123529.55686-6-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231125123529.55686-1-tudor.ambarus@linaro.org>
References: <20231125123529.55686-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2040; i=tudor.ambarus@linaro.org; h=from:subject; bh=qdPCdEgUWxvGLhVyUwHlXAj47Qi5sR15BlnuG/9ieeo=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlYeoRDj5E4PFoxCRL/3RvCsy7w+UgyF0bJ7L0g GgDTQENszOJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZWHqEQAKCRBLVU9HpY0U 6UMzCACZkv+KkQDtK9Sp9Q28aV734tjYoM3xi8jyX50siPTnkCfEL7b16dE+YjCIpq/pamgVI87 oVbj35cv+nkAsguGeV7t2csTEZhL3G8YtjYgQjBsm5wT4a7fw/G23sVMJVmCOGm5Cdm8IfTp1rI U/8W06YQXPHySueKChRgJetNWByFKjcrqe7Ud387Mj+LnffKk30aPwYZTTtIy4Ymgxk6OVHdxRV l9LaSKQ91etjOk8ixjOa7GFgRdbwKTsPnJaa9KpUx9VYyfXspK7Y7PuXWLtTAR/RCHpJz97yfGO j9awPMW/+e4gBGRVcUoixIICbiTJOztAepE9gV8yE6CKDlrz
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
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

From: Fabio Estevam <festevam@denx.de>

Add support for the MT25QU01G 128MB Micron Serial NOR Flash Memory
model.

Link: https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-b/mt25q_qlkt_u_01g_bbb_0.pdf
Signed-off-by: Fabio Estevam <festevam@denx.de>
[ta: introduce die erase]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/micron-st.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index b63f1e9b97d0..3c6499fdb712 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -209,10 +209,30 @@ static int st_nor_four_die_late_init(struct spi_nor *nor)
 	return spi_nor_set_4byte_addr_mode(nor, true);
 }
 
+static int st_nor_two_die_late_init(struct spi_nor *nor)
+{
+	struct spi_nor_flash_parameter *params = nor->params;
+
+	params->die_erase_opcode = SPINOR_OP_MT_DIE_ERASE;
+	params->n_dice = 2;
+
+	/*
+	 * Unfortunately the die erase opcode does not have a 4-byte opcode
+	 * correspondent for these flashes. The SFDP 4BAIT table fails to
+	 * consider the die erase too. We're forced to enter in the 4 byte
+	 * address mode in order to benefit of the die erase.
+	 */
+	return spi_nor_set_4byte_addr_mode(nor, true);
+}
+
 static struct spi_nor_fixups n25q00_fixups = {
 	.late_init = st_nor_four_die_late_init,
 };
 
+static struct spi_nor_fixups mt25q01_fixups = {
+	.late_init = st_nor_two_die_late_init,
+};
+
 static struct spi_nor_fixups mt25q02_fixups = {
 	.late_init = st_nor_four_die_late_init,
 };
@@ -455,6 +475,11 @@ static const struct flash_info st_nor_parts[] = {
 			 SPI_NOR_BP3_SR_BIT6,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
 		.mfr_flags = USE_FSR,
+	}, {
+		.id = SNOR_ID(0x20, 0xbb, 0x21, 0x10, 0x44, 0x00),
+		.name = "mt25qu01g",
+		.mfr_flags = USE_FSR,
+		.fixups = &mt25q01_fixups,
 	}, {
 		.id = SNOR_ID(0x20, 0xbb, 0x21),
 		.name = "n25q00a",
-- 
2.34.1

