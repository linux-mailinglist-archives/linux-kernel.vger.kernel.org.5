Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618977512D0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjGLV7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjGLV7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:59:41 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDEF1FE1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:59:39 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6ff1ada5dso121696901fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689199178; x=1691791178;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m1iTMnOkulGAjdkSjr5sFgiGCvdDIMihPf+seTqiI5c=;
        b=Rff9hpVphO8sZK/CozjaHMwduL0CpTp5U5XQB9Rnm3jdGvQka0r4vR/Yf5ZqZ2p2Yi
         mv4rN02TsatpXcOqSLMkuMOU2oAiuHlMG3lqItBELeh7Srw3n/YZYtls5MMMZQO1QZQ3
         ncAzJTQBPULZ/LRj/tGzrVWFswy4U6jDVRhFzTJv7HyRS+kFWjyy+WB2bkeh801FqCFo
         hFzlTd0rld8pYKYv2Vd4IKM/Hm8cBEsChirPT8X+5xNy13HVDyw11V4gWacpf0YJ5cRE
         QUESAWd9BTJOMld8r+TqdAgc0+BQQQZa+6s5Nix5Jj706Z9ef/bZAEgYa9jSd4sY06M+
         cMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689199178; x=1691791178;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1iTMnOkulGAjdkSjr5sFgiGCvdDIMihPf+seTqiI5c=;
        b=PnA7ypshuq6LQGOZjt7392zoxneHzdOn/GTdrfC77DOEmTmLsXr/53PVWABZqI3KWt
         uCCUur1ITZPrWalzpdrywD08Couxu2Iz/aP4jYx5nrvr9zWdki2OLepnid7mT8LGsjVv
         vDraD7SFRnIXaaZton9/GzqyTZpmTvLhboPaXfqoQ1ymv9IIWB86qLzIxJ7R4QKEVg7T
         2SIS5mHdr1JgCSay8oNGAxosQAXHMSYd/8d3Ri/z8phlxkcmvKQm8Z5E2hB+GKZ7wTqX
         7aRspyH/oqbJZCEVoZsofH8cku4HkPeyYxqlAauNcWll7t6OaWth1dzyGE+/Wz3lGmal
         XcpQ==
X-Gm-Message-State: ABy/qLbqNauTQXTB/fHuyAXUZ/2cernlJQ/3a9nKt9/Qg54HUVOQQ4XE
        bSQ7SPye1wBH3eJx7Sb9nxLLPg==
X-Google-Smtp-Source: APBJJlG8FT+xJEc2p9cZG8IWyqOA5xyCMotLk1YtyA9AIjuryoJJsKvWqwKRdYjBdbULfBqJaGq4Dw==
X-Received: by 2002:a2e:8ed0:0:b0:2b7:3b6c:a5e4 with SMTP id e16-20020a2e8ed0000000b002b73b6ca5e4mr2754195ljl.38.1689199178232;
        Wed, 12 Jul 2023 14:59:38 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h17-20020a2e9011000000b002b6c92fa161sm1129656ljg.61.2023.07.12.14.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 14:59:37 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jul 2023 23:59:36 +0200
Subject: [PATCH v2] mtd: spi-nor: Correct flags for Winbond w25q128
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-spi-nor-winbond-w25q128-v2-1-50c9f1d58d6c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEcir2QC/3WNQQ6CMBBFr0Jm7RhmUCCuvIdhUWCASUyLrQEN6
 d2tJC5dvpf89zcI4lUCXLINvCwa1NkEfMigm4wdBbVPDJxzkVdEGGZF6zyualtne1z5/CCusWA
 yZc4iXFaQ1rOXQV97+dYknjQ8nX/vRwt97a/Jf5sLIeFQ1UPRtic21F3vao13R+dHaGKMH+AlZ
 eS/AAAA
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Winbond "w25q128" (actual vendor name W25Q128JV)
has exactly the same flags as the sibling device
"w25q128jv". The devices both require unlocking to
enable write access.

The actual product naming between devices vs the
Linux strings in winbond.c:

0xef4018: "w25q128"   W25Q128JV-IM/JM
0xef7018: "w25q128jv" W25Q128JV-IN/IQ/JQ

The latter device, "w25q128jv" supports features
named DTQ and QPI, otherwise it is the same.

Not having the right flags has the annoying side
effect that write access does not work.

After this patch I can write to the flash on the
Inteno XG6846 router.

The flash memory also supports dual and quad SPI
modes. This does not currently manifest, but by
turning on SFDP parsing, the right SPI modes are
emitted in
/sys/kernel/debug/spi-nor/spi1.0/capabilities
for this chip, so we also turn on this.

Cc: stable@vger.kernel.org
Suggested-by: Michael Walle <michael@walle.cc>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Only add the write access flags.
- Use SFDP parsing to properly detect the various
  available SPI modes.
- Link to v1: https://lore.kernel.org/r/20230712-spi-nor-winbond-w25q128-v1-1-f78f3bb42a1c@linaro.org
---
 drivers/mtd/spi-nor/winbond.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 834d6ba5ce70..6c82e525c801 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -121,7 +121,8 @@ static const struct flash_info winbond_nor_parts[] = {
 	{ "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16)
 		NO_SFDP_FLAGS(SECT_4K) },
 	{ "w25q128", INFO(0xef4018, 0, 64 * 1024, 256)
-		NO_SFDP_FLAGS(SECT_4K) },
+		PARSE_SFDP
+		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
 	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		.fixups = &w25q256_fixups },

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230711-spi-nor-winbond-w25q128-321a602ee267

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

