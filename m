Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2C2757B00
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjGRL4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjGRL4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:56:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F451A8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:56:14 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fd32e611e0so4842556e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689681372; x=1690286172;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oRKIOUpFqHN91Ar5wcA4OkAo3bcs3Z398gafNkSZn8s=;
        b=j/MU0UXt41CYH0gnbYYl/tkTjDedMm2CgVYronCMGHRv6UUU/iNedJRkb2Pctbazwl
         itjSzmH9YoBouc16ZlJ08MV/qrTttrnXrBb357I59MaD54vVKJySlouGde1sBL/qciAl
         D8inDDuNU2Knef24FF86PEJPgqaxENsVDUhsmQoIeAl4rW9HSX8cKgvEIsm5EUw07m1L
         i1W30uTPPfxiQ3zXcMJEeZtU3RzOxlpdU6CJ8KVxEoQj0DL1mfaJItm591EoXCYzLUuE
         zQxZxbAvKdYc2PTa2pgL8mtZUZDR3/U27Ki/MFe+r1H2muMtMia/L6dasfDpt42Aw29k
         i7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689681372; x=1690286172;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRKIOUpFqHN91Ar5wcA4OkAo3bcs3Z398gafNkSZn8s=;
        b=I0tJgR9c0Mt9Mfr6pZGdQxmNoegBqzknoyHQKAS+fmdrQv8g4xf6pmmpUxlE3FAYlg
         pWIke46l+WnePDZ0l/6JGnZZgVrK+FGoRRqeUc08K0o1Dayv4uShtnAtO3weyVFfhK90
         IcEdwtW5MmV8/uiQECg5190JkAkvht40NNmll5mZ7YRnsgle0fL5brLFdm5iamAy4K/T
         XfSY4nwK1D/3FsIZnN8DEuXVEVUg7B5nBpV6mrpuE5oasezRFDY1fb+ZX1xDbYo8WhCX
         EhcO2seAirE4+HWRd4qu+S+7pX3vJS4tVbnhcHCc2W5c3zzbV3GzTJZ9gwOH3SKZBZkp
         Q0wQ==
X-Gm-Message-State: ABy/qLZyorGKI5Zy3OOSnlMzJMM+F4f9rTy/SXx/TDUDZ8+NBZAY2ujU
        kqUm3/tKn9rYBnmLiO/rRSXjew==
X-Google-Smtp-Source: APBJJlEmPvdXYby95fB2yf4R3hT7I+AOsJzeVLKpc9pCxbUt189y94nzaQre+EXzB9SClBl75GlmDA==
X-Received: by 2002:a19:6557:0:b0:4f8:5ede:d453 with SMTP id c23-20020a196557000000b004f85eded453mr3606355lfj.23.1689681372392;
        Tue, 18 Jul 2023 04:56:12 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id j28-20020ac253bc000000b004fba101946dsm407961lfh.187.2023.07.18.04.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 04:56:11 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Jul 2023 13:56:11 +0200
Subject: [PATCH v5] mtd: spi-nor: Correct flags for Winbond w25q128
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-spi-nor-winbond-w25q128-v5-1-a73653ee46c3@linaro.org>
X-B4-Tracking: v=1; b=H4sIANp9tmQC/43NwWoDIRDG8VcJnmtxRl3XnvoeIYd11WSgaKJhk
 xD23WMChZawsMf/B/ObO6uhUKjsa3NnJUxUKacW+mPDxsOQ9oGTb81QoBQGgNcj8ZQLv1ByOXl
 +QX0C7LlEGDqBIWBnWLs+lhDp+pK3u9YHqudcbq9HEzzXXxMXzQk48Gj6KJ1TOMD4/UNpKPkzl
 z17ohOuhLBBWow2gte9794h+RdSy5BskPMOwWIUxro3SK2EVIN6O2prwEep5D9onucHDmonVpo
 BAAA=
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

Since we now have determined that SFDP parsing works on
the device, we also detect the geometry using SFDP.

After this dmesg and sysfs says:
[    1.062401] spi-nor spi1.0: w25q128 (16384 Kbytes)
cat erasesize
65536
(16384*1024)/65536 = 256 sectors

spi-nor sysfs:
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
Changes in v5:
- Detect also geometry from the SFDP table.
- Link to v4: https://lore.kernel.org/r/20230714-spi-nor-winbond-w25q128-v4-1-89c5971df343@linaro.org

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
 drivers/mtd/spi-nor/winbond.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 834d6ba5ce70..63ba8e3a96f5 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -120,8 +120,9 @@ static const struct flash_info winbond_nor_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K) },
 	{ "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16)
 		NO_SFDP_FLAGS(SECT_4K) },
-	{ "w25q128", INFO(0xef4018, 0, 64 * 1024, 256)
-		NO_SFDP_FLAGS(SECT_4K) },
+	{ "w25q128", INFO(0xef4018, 0, 0, 0)
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

