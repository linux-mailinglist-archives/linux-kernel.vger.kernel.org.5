Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29D5778CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbjHKLDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbjHKLDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:03:11 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5889A1718
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:03:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe5c0e57d2so16201295e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691751787; x=1692356587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T5iAe6E8YopchFIRubf33eym0ZyKWuOCfagjLL9eNGQ=;
        b=4jTMNejEAHGjjdu5dt8hMdVIR18zFTNB23v5xfp1DbngEKKqPM3LxeD22bbMR7489w
         SW1hKZanHIl7go1DSioiE/bZzAEonHuybk6hbVmssovIsAXgqA+PlBw0OLiLGYqBfpCD
         RZnZjSKfELh+G5hCy+F4RhZOvPTj4Y4dfbWbBgxayHB5neawBUxxXGrLzhAjozmPmn6B
         neVCO1hLrP54QzdesuJGsxGfFBSFZLVkL4KdJ+4ePAWxlDQHk4vAHrVZx9wSz1soSGmy
         Rl06TCI4KxH+J//mLP7BSNINuH68ssv1cM8sQWYfPai5tra1Lap8wSjq9Z9Yu7HKDyna
         cA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691751787; x=1692356587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5iAe6E8YopchFIRubf33eym0ZyKWuOCfagjLL9eNGQ=;
        b=gAmtiVYjolIZyM/aN6CippAHXaaguyecudyAC7RDzOUVyr1sekmWfs/PX2z6O9UVxK
         /tHAihTiX8Fltu5ze+1DnBAJZzylMPXZkrNHJRGNe+C842ajvcmf1p4OOesZvt5M6So5
         Tebe/1ZEdpZ9D4d3ECOX3vYxU6GPzvLAomHE9JJW6FuOtMuWrWKQZN4WoMKUGQmyvQhe
         hHEtOLW50AzK+Ujhc1DND9V7VkPplm/PUpPkmGf/Dv6yHaFLXk+DsWjBUH1u9uRdGbxR
         wKUTFj9QaL9vQRtSmJeGBv7Lcyjv3IgttJTC9w7H1bskfoF7IayJ7SvFU7L3UJdbWefk
         4Upg==
X-Gm-Message-State: AOJu0Yx5zbL9CXgxofprqq2IO4WEmSb9gLFFyglZF37ZVZUwucIaRh0m
        INGUPAI67gHn5U2C3tZaRE6Lpg==
X-Google-Smtp-Source: AGHT+IGVS30kGNuOv76M3JVuz7IIWVQx5L1DSQDg9iM0/gb6fA0D/Qg6IWcvCu3bOqveE9RTec3ZJw==
X-Received: by 2002:a05:600c:22da:b0:3f7:e3dd:8a47 with SMTP id 26-20020a05600c22da00b003f7e3dd8a47mr1371440wmg.11.1691751786608;
        Fri, 11 Aug 2023 04:03:06 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id f21-20020a7bcc15000000b003fc01189b0dsm4792119wmh.42.2023.08.11.04.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 04:03:06 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Bo YU <tsu.yubo@gmail.com>,
        Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH -fixes] riscv: uaccess: Return the number of bytes effectively copied
Date:   Fri, 11 Aug 2023 13:03:04 +0200
Message-Id: <20230811110304.1613032-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was reported that the riscv kernel hangs while executing the test
in [1].

Indeed, the test hangs when trying to write a buffer to a file. The
problem is that the riscv implementation of raw_copy_from_user() does not
return the number of bytes written when an exception happens and is fixed
up.

generic_perform_write() pre-faults the user pages and bails out if nothing
can be written, otherwise it will access the userspace buffer: here the
riscv implementation keeps returning it was not able to copy any byte
though the pre-faulting indicates otherwise. So generic_perform_write()
keeps retrying to access the user memory and ends up in an infinite
loop.

Note that before the commit mentioned in [1] that introduced this
regression, it worked because generic_perform_write() would bail out if
only one byte could not be written.

So fix this by returning the number of bytes effectively written in
__asm_copy_[to|from]_user() and __clear_user(), as it is expected.

[1] https://lore.kernel.org/linux-riscv/20230309151841.bomov6hq3ybyp42a@debian/

Fixes: ebcbd75e3962 ("riscv: Fix the bug in memory access fixup code")
Reported-by: Bo YU <tsu.yubo@gmail.com>
Closes: https://lore.kernel.org/linux-riscv/20230309151841.bomov6hq3ybyp42a@debian/#t
Reported-by: Aurelien Jarno <aurelien@aurel32.net>
Closes: https://lore.kernel.org/linux-riscv/ZNOnCakhwIeue3yr@aurel32.net/
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/lib/uaccess.S | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index ec486e5369d9..09b47ebacf2e 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -17,8 +17,11 @@ ENTRY(__asm_copy_from_user)
 	li t6, SR_SUM
 	csrs CSR_STATUS, t6
 
-	/* Save for return value */
-	mv	t5, a2
+	/*
+	 * Save the terminal address which will be used to compute the number
+	 * of bytes copied in case of a fixup exception.
+	 */
+	add	t5, a0, a2
 
 	/*
 	 * Register allocation for code below:
@@ -176,7 +179,7 @@ ENTRY(__asm_copy_from_user)
 10:
 	/* Disable access to user memory */
 	csrc CSR_STATUS, t6
-	mv a0, t5
+	sub a0, t5, a0
 	ret
 ENDPROC(__asm_copy_to_user)
 ENDPROC(__asm_copy_from_user)
@@ -228,7 +231,7 @@ ENTRY(__clear_user)
 11:
 	/* Disable access to user memory */
 	csrc CSR_STATUS, t6
-	mv a0, a1
+	sub a0, a3, a0
 	ret
 ENDPROC(__clear_user)
 EXPORT_SYMBOL(__clear_user)
-- 
2.39.2

