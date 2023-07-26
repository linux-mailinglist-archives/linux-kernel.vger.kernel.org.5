Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A1D762F0E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjGZICX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjGZIBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:01:16 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2969B4C23
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso52881935e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690357994; x=1690962794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRwCsCVO3o3aM9vhw4WDE//m6gXQY0sVfiQwqyQBByI=;
        b=YXxVeyvyh2kk+2npRszeRvUdhL2tu2M+9pz5dYrvUt3W7dIX7I+BLUZ2D6DZh58eAu
         X+byLqf53pdHS5MUQgXg87+w48KYO4dt5Io4LhL/u15dIYbx0bNXkFbL0rpmN+VkQ9U4
         2Iw6dUen4pZA4/SM/xIvBvo2CAmeCAjQyRKtrY7in5jHPob2qD6w6hD9r0qINF9Fv12Y
         ygV6Yq3Kl5Ow1+T2WcoZ3C4641u0Z7qls+13hZjZ9VuQZFjv1Z9/zh3j0J4CQVXHvabc
         zreB7HebJ/y5/5aDBV0KbOqX/1ObTYS7lcuC/z8USf9h71Js4kSGYKiR4H0zr6j8izYa
         yKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690357994; x=1690962794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRwCsCVO3o3aM9vhw4WDE//m6gXQY0sVfiQwqyQBByI=;
        b=Prz9QNZdPHzZdn92Ap8vUSKkEzz1s4xmUmRDr84ggUv2UygNciJj1BTWleWwHAyyIv
         nehC3ZESKNaaSYPrYayiih1VTc60XKIrEng3cUb89DxywgFtP2oWdBJr5GulTWN6NLqA
         jRofrw5q97r5kBHMwqe0QXS6C135GzEpBxsNc9PDqy9s6N5FQyQr+QSz9ho/7g1BBfQm
         Fd9zgQbl5HMrv319lge01ww1KbKD2pOcx6hY5Lm/R2JFavUDlsyiFILWuO/3lcJCkXtH
         nTkBRmE3yic5+53HSOL3GDnY/1Gyx0FcQuTYcQ7ou2veMznj9NXirQ/XA6rb0x14l+gp
         g0Aw==
X-Gm-Message-State: ABy/qLZiPe1ZP6gOgxHQPJGTacByaBuVwVvaCJmJ89fiagmz02tqj3ue
        u38sKUapU+48F2fqHLxii/cUeg==
X-Google-Smtp-Source: APBJJlF8IgGEtSvq2AwcZD4JVeCePRGhSZj99SgDX4tKedd8NAOTK9iVdemTe03ZncVNXZe13rGCeg==
X-Received: by 2002:a1c:ed04:0:b0:3fc:586:ccb4 with SMTP id l4-20020a1ced04000000b003fc0586ccb4mr759069wmh.36.1690357994753;
        Wed, 26 Jul 2023 00:53:14 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c260e00b003fbca942499sm1264346wma.14.2023.07.26.00.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:53:14 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 08/11] mtd: spi-nor: spansion: add support for S28HS02GT
Date:   Wed, 26 Jul 2023 10:52:54 +0300
Message-Id: <20230726075257.12985-9-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726075257.12985-1-tudor.ambarus@linaro.org>
References: <20230726075257.12985-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2496; i=tudor.ambarus@linaro.org; h=from:subject; bh=BGQp+yPvPvQ1vo1DVawT4hLAY/tUideX2TLncpyul4o=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkwNDYcqZvVLq6lYHgbxnZoNm+XYaMiaT00ViYF o/ZctOKx1OJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZMDQ2AAKCRBLVU9HpY0U 6fxICACCwpHJXaHk90+tNOaqFRWA3xj6/36wYT8q1V+U0IXxgHz3ON+5UrMyETEx/KPSHVUDGKm IH/lUMAlKmLTGB4j6OGN+DAS3EHu/kULd7bJo8sBWoj2D7hPLZPMXEdUPRjeiH0HsXNcrmJTx9Q AbPodOoikjjeHmXbjn6BoZvIX96vkZLVgFOeeKniSmXkaK07uOKfj/7qujbGHBeTBa7SstGLZp9 QZ25iwAnT8q1uIswcAh6zLM2clJ6H+p58W59v4Lc7nL5grhRDT7ptZsQRi339j9sp0djHUx1p9k r0iKd8kyL/3iAYvK9KoiZVPvroW0kyDpZOqHUrfdALB6l28k
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Add support for S28HS02GT. Infineon S28HS02GT is a 2Gb,
multi-chip package, Octal SPI Flash.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/spansion.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index d7aa0a90949a..1c5671a3751a 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -693,22 +693,23 @@ static int cypress_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
 
 static int s28hx_t_post_sfdp_fixup(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = nor->params;
 	/*
 	 * On older versions of the flash the xSPI Profile 1.0 table has the
 	 * 8D-8D-8D Fast Read opcode as 0x00. But it actually should be 0xEE.
 	 */
-	if (nor->params->reads[SNOR_CMD_READ_8_8_8_DTR].opcode == 0)
-		nor->params->reads[SNOR_CMD_READ_8_8_8_DTR].opcode =
+	if (params->reads[SNOR_CMD_READ_8_8_8_DTR].opcode == 0)
+		params->reads[SNOR_CMD_READ_8_8_8_DTR].opcode =
 			SPINOR_OP_CYPRESS_RD_FAST;
 
 	/* This flash is also missing the 4-byte Page Program opcode bit. */
-	spi_nor_set_pp_settings(&nor->params->page_programs[SNOR_CMD_PP],
+	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP],
 				SPINOR_OP_PP_4B, SNOR_PROTO_1_1_1);
 	/*
 	 * Since xSPI Page Program opcode is backward compatible with
 	 * Legacy SPI, use Legacy SPI opcode there as well.
 	 */
-	spi_nor_set_pp_settings(&nor->params->page_programs[SNOR_CMD_PP_8_8_8_DTR],
+	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_8_8_8_DTR],
 				SPINOR_OP_PP_4B, SNOR_PROTO_8_8_8_DTR);
 
 	/*
@@ -716,7 +717,11 @@ static int s28hx_t_post_sfdp_fixup(struct spi_nor *nor)
 	 * address bytes needed for Read Status Register command as 0 but the
 	 * actual value for that is 4.
 	 */
-	nor->params->rdsr_addr_nbytes = 4;
+	params->rdsr_addr_nbytes = 4;
+
+	/* The 2 Gb parts duplicate info and advertise 4 dice instead of 2. */
+	if (params->size == SZ_256M)
+		params->n_dice = 2;
 
 	return cypress_nor_get_page_size(nor);
 }
@@ -916,6 +921,11 @@ static const struct flash_info spansion_nor_parts[] = {
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s28hx_t_fixups,
 	},
+	{ "s28hs02gt",   INFO(0x345b1c,      0, 0, 0)
+		PARSE_SFDP
+		MFR_FLAGS(USE_CLPEF)
+		.fixups = &s28hx_t_fixups,
+	},
 };
 
 /**
-- 
2.34.1

