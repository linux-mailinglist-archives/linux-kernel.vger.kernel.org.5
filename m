Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADE47D1706
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 22:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjJTUag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 16:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjJTUae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 16:30:34 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AB0D68
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 13:30:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507bd64814fso1775298e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 13:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697833830; x=1698438630; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6GPuaggtGD10El9ZGrri8KfDDHuU0PlPpw0GJi5kP2w=;
        b=Yv5OsElFPBRKgqrDkpz55T/JUR2eZnGKwCLLi17imW7tqP/BnLcxYzmnfCDFCex9qt
         vR2kMnjgvRM3vA2qpJ/LYhPPXQEBxxN061s3HUS1nXWj/h1ZNSQBoVGYzcHWhat+0uez
         M7ve2HYZsXAScjN6nmEf7BgyRV4BfEJLwY9T5iNpBoyQMEPg9KXgBLALfDCsZ0qgSMsW
         v16IoRw6LyX0YldY6VJpS9rNDCgc2WXkXz0RDCRAO2w+nsTPMbbShY22MKNJA9m6vU5t
         trByV6Dpch47pRjzWuEh5vo89PC5V+4h5CnZMu91pO4z0ZpVwIC6A6EwpeLix+iwYwA7
         pnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697833830; x=1698438630;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6GPuaggtGD10El9ZGrri8KfDDHuU0PlPpw0GJi5kP2w=;
        b=q1JSdF6Jg3wSIXW7s3jDEX/qhdH2vDZesQU2G6CJdtXxbmlmE4uL9CAN1Sb3wyQ+3J
         xtpGR9+mvyU30gEFgHAWl4xb327VzRbv1zVli6tTF2OrhmkXpEqQMb8qXUQ8X4iWZiI+
         Nx8VzfXlqYIzXxvt+OFQuYn4HUdAiIYbuhSyshCsmj+D2gVO1bMbAUfM/rZYltB8vcKC
         OT4+DuVSW8OjzIfOFWRcDQWNCLNWK/yGtFljEM8any0Nvp0OnJZU2SqMYEEGA0GW5ycy
         YRQjftLuIzHRhDDvIbcban2+euov9vXXSP3wAM8PxNa20idI5thIHB8V50OCtiJx9YIl
         SgBQ==
X-Gm-Message-State: AOJu0YyKTUrt4YQY0fj2srMaa1hgMhUPmd73B1xEWhqA6JOmqBHpPYi0
        IPEOebCBafo9QGdgIE6/pfTOziRMP8ZcMQ70BQg=
X-Google-Smtp-Source: AGHT+IE/jJITtXMCaFHxTcQC1SW8/hIF6htW3PSk3OTrvWF55xGx5GVpzQ947QxHb14qRj1YWfcCIQ==
X-Received: by 2002:a19:711c:0:b0:500:aa41:9d67 with SMTP id m28-20020a19711c000000b00500aa419d67mr1843149lfc.8.1697833830125;
        Fri, 20 Oct 2023 13:30:30 -0700 (PDT)
Received: from [192.168.1.2] (c-21d3225c.014-348-6c756e10.bbcust.telenor.se. [92.34.211.33])
        by smtp.gmail.com with ESMTPSA id a24-20020a056512201800b004ff6fa3f038sm509345lfb.144.2023.10.20.13.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 13:30:29 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 Oct 2023 22:30:29 +0200
Subject: [PATCH v4] mtd: cfi_cmdset_0001: Byte swap OTP info
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231020-mtd-otp-byteswap-v4-1-0d132c06aa9d@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGTjMmUC/x3MTQqAIBBA4avErBswjYSuEi00p5pFJSr9EN49a
 fkt3nshUmCK0FcvBDo58rEXtHUF02r2hZBdMUghVSOkwC05PJJH+ySKl/GorWm1ajpyWkHJfKC
 Z7385jDl/ifdQzWIAAAA=
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the offset into the device when looking for OTP
bits can go outside of the address of the MTD NOR devices,
and if that memory isn't readable, bad things happen
on the IXP4xx (added prints that illustrate the problem before
the crash):

cfi_intelext_otp_walk walk OTP on chip 0 start at reg_prot_offset 0x00000100
ixp4xx_copy_from copy from 0x00000100 to 0xc880dd78
cfi_intelext_otp_walk walk OTP on chip 0 start at reg_prot_offset 0x12000000
ixp4xx_copy_from copy from 0x12000000 to 0xc880dd78
8<--- cut here ---
Unable to handle kernel paging request at virtual address db000000
[db000000] *pgd=00000000
(...)

This happens in this case because the IXP4xx is big endian and
the 32- and 16-bit fields in the struct cfi_intelext_otpinfo are not
properly byteswapped. Compare to how the code in read_pri_intelext()
byteswaps the fields in struct cfi_pri_intelext.

Adding a small byte swapping loop for the OTP in read_pri_intelext()
and the crash goes away.

The problem went unnoticed for many years until I enabled
CONFIG_MTD_OTP on the IXP4xx as well, triggering the bug.

Cc: stable@vger.kernel.org
Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Collected Nico's ACK.
- Stalled since june! Has this been missed?
ChangeLog v2->v3:
- Link to v3:
  https://lore.kernel.org/linux-mtd/20230602204359.3493320-1-linus.walleij@linaro.org/
- Move the byte swapping to a small loop in read_pri_intelext()
  so all bytes are swapped as we reach cfi_intelext_otp_walk().
ChangeLog v1->v2:
- Drill deeper and discover a big endian compatibility issue.
---
 drivers/mtd/chips/cfi_cmdset_0001.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cmdset_0001.c
index 11b06fefaa0e..c10693ba265b 100644
--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -422,9 +422,25 @@ read_pri_intelext(struct map_info *map, __u16 adr)
 		extra_size = 0;
 
 		/* Protection Register info */
-		if (extp->NumProtectionFields)
+		if (extp->NumProtectionFields) {
+			struct cfi_intelext_otpinfo *otp =
+				(struct cfi_intelext_otpinfo *)&extp->extra[0];
+
 			extra_size += (extp->NumProtectionFields - 1) *
-				      sizeof(struct cfi_intelext_otpinfo);
+				sizeof(struct cfi_intelext_otpinfo);
+
+			if (extp_size >= sizeof(*extp) + extra_size) {
+				int i;
+
+				/* Do some byteswapping if necessary */
+				for (i = 0; i < extp->NumProtectionFields - 1; i++) {
+					otp->ProtRegAddr = le32_to_cpu(otp->ProtRegAddr);
+					otp->FactGroups = le16_to_cpu(otp->FactGroups);
+					otp->UserGroups = le16_to_cpu(otp->UserGroups);
+					otp++;
+				}
+			}
+		}
 	}
 
 	if (extp->MinorVersion >= '1') {

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20231020-mtd-otp-byteswap-7ba47316ed73

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

