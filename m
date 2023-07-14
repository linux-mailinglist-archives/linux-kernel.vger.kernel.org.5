Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C602754399
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbjGNUND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjGNUNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:13:01 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6593930F4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:13:00 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b8413671b9so9104961fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689365578; x=1691957578;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AVpCnbLaBgVTA+rTPArzFniZktR5rBwb5IqYWVlTxBE=;
        b=tcaPbSmSvfaof4pt7tyb47FeyTUQl9yD6/H8icyv9cwe4ONCd6pxh58tL+iBTn4Pcr
         AinFD2P4zlB1otXk2/hN5lm4YM9MtYdlZK9stDpbCULalZ8Dq7X/3cUNzNqWml1cUGr5
         cQ6PkeSkdBp9qycFcDAlyVRzp3epmMW7VaaiHu1EILBxC0/6kXlwq+1vj5J9g5Gl/z9H
         EgeY+z3zpHOah0oCZv88lxaiJR5194yg8vrl1xgZSg7siUtfOG9X7fkXBYYjebhCyyaC
         you4pTSacFm4MbQtiz77nq84N1Fg/3Pt47nDg1gjwoywBvP0UotqDJU8Cd6gLNgypeYx
         Osmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689365578; x=1691957578;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVpCnbLaBgVTA+rTPArzFniZktR5rBwb5IqYWVlTxBE=;
        b=UhwvzAIJNHjc5kJ4ZpL+LZwY8x17Fw498rxColMNazChIHjeisD93K+5BHrIb8Dulz
         zmF0poY+hkTvHTKz1SczzFFOO4ArHYab7UpzkYP2swVoy7Oo4owG7Iaig2zFp/H81Yvz
         5zEcmb3L4+Gwp6CtR96HBHV0u1U25dtLjCneuwW+B3wpmNumb3u3W67Q1LYfy2JYdrgC
         LxU3tv54KOsLOssAXU8dstcgItezN8XQZFBJK2RAUotC8QMGWtRe1o+Lr/TRNQ/RTgfl
         Wo+YF4nurcUJeBAfa6V60MRPFzXcF3l0wa7st03K2Lf7uzQ2MkkD5YfdnMvnfpbyL7nn
         /P/A==
X-Gm-Message-State: ABy/qLZBz5zSH7O6nbLBW86qtl4LyeeJ1qcLeFRX/8NqhSRNvJf3uvbO
        gmsRXvctWwOEF7J74bkw534W4A==
X-Google-Smtp-Source: APBJJlHvCv9b6EVGr/n40LgSUuOm4Q6WSxY+EfIM6NpUprAZZBwajk4qtMsTgEkKoDnJTa2sPvZR/A==
X-Received: by 2002:a05:6512:3ba0:b0:4f8:6831:fd70 with SMTP id g32-20020a0565123ba000b004f86831fd70mr1647233lfv.3.1689365578044;
        Fri, 14 Jul 2023 13:12:58 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id er16-20020a05651248d000b004fbbe647c00sm1593845lfb.299.2023.07.14.13.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 13:12:57 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Jul 2023 22:12:57 +0200
Subject: [PATCH v4] mtd: spi-nor: Correct flags for Winbond w25q128
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230714-spi-nor-winbond-w25q128-v4-1-89c5971df343@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEissWQC/43NTQrCMBCG4atI1kYyk/668h7iomkSHZCkJtIqp
 Xc3LQiKFFy+H8wzI4smkIlsvxlZMD1F8i5Ftt2w9tK4s+GkUzMUKEUJwGNH3PnAB3LKO80HzG+
 AFZcITSHQGCxKlq67YCw9Fvl4Sn2hePfhuTzqYV7fJq6aPXDgtqysVCrDBtrDlVwT/M6HM5vRH
 v+EMEG5aGsLOq908QvJTyhbh2SClFYINVpR1uoLmqbpBRYX5WdRAQAA
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Winbond "w25q128" (actual vendor name W25Q128JV) has
exactly the same flags as the sibling device "w25q128jv".
The devices both require unlocking to enable write access.

The actual product naming between devices vs the Linux
strings in winbond.c:

0xef4018: "w25q128"   W25Q128JV-IN/IQ/JQ
0xef7018: "w25q128jv" W25Q128JV-IM/JM

The latter device, "w25q128jv" supports features named DTQ
and QPI, otherwise it is the same.

Not having the right flags has the annoying side effect
that write access does not work.

After this patch I can write to the flash on the Inteno
XG6846 router.

The flash memory also supports dual and quad SPI modes.
This does not currently manifest, but by turning on SFDP
parsing, the right SPI modes are emitted in
/sys/kernel/debug/spi-nor/spi1.0/capabilities
for this chip, so we also turn on this.

Since we suspect that older chips may be using the same
device ID, we need to keep NO_SFDP_FLAGS(SECT_4K) as these
older chips may not support SFDP.

cat jedec_id
ef4018
cat manufacturer
winbond
cat partname
w25q128
hexdump -v -C sfdp
00000000  53 46 44 50 05 01 00 ff  00 05 01 10 80 00 00 ff
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
00000020  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
00000030  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
00000040  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
00000050  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
00000060  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
00000070  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
00000080  e5 20 f9 ff ff ff ff 07  44 eb 08 6b 08 3b 42 bb
00000090  fe ff ff ff ff ff 00 00  ff ff 40 eb 0c 20 0f 52
000000a0  10 d8 00 00 36 02 a6 00  82 ea 14 c9 e9 63 76 33
000000b0  7a 75 7a 75 f7 a2 d5 5c  19 f7 4d ff e9 30 f8 80

Cc: stable@vger.kernel.org
Suggested-by: Michael Walle <michael@walle.cc>
Reviewed-by: Michael Walle <michael@walle.cc>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v4:
- Fix up error in commit message.
- Pick up Michael's ACK.
- Link to v3: https://lore.kernel.org/r/20230714-spi-nor-winbond-w25q128-v3-1-bdb2192f079b@linaro.org

Changes in v3:
- Keep NO_SFDP_FLAGS(SECT_4K) around.
- Update commit message
- Link to v2: https://lore.kernel.org/r/20230712-spi-nor-winbond-w25q128-v2-1-50c9f1d58d6c@linaro.org

Changes in v2:
- Only add the write access flags.
- Use SFDP parsing to properly detect the various
  available SPI modes.
- Link to v1: https://lore.kernel.org/r/20230712-spi-nor-winbond-w25q128-v1-1-f78f3bb42a1c@linaro.org
---
 drivers/mtd/spi-nor/winbond.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 834d6ba5ce70..8f30a67cd27a 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -121,6 +121,8 @@ static const struct flash_info winbond_nor_parts[] = {
 	{ "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16)
 		NO_SFDP_FLAGS(SECT_4K) },
 	{ "w25q128", INFO(0xef4018, 0, 64 * 1024, 256)
+		PARSE_SFDP
+		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 		NO_SFDP_FLAGS(SECT_4K) },
 	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230711-spi-nor-winbond-w25q128-321a602ee267

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

