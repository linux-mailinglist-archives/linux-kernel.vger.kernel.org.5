Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB814752650
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjGMPNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbjGMPNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:13:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E7FB4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:13:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3142a9ff6d8so848836f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689261188; x=1691853188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLw9kTvaEkAjy+qjwvRpscnMKlwPFJS0kuzz8CxiZVE=;
        b=gmqrfMFLOBX25S3+JUn/UZ07X4KBYapInPrcBiBweYAsrSJp787PLElVaURtOVqked
         xXaN4wQIr9V1r5Hq+V/ONFLo6QZ5lBYJw+F+sR96caaiPXAlMwopiAY4+CZEb3Aw2Gjo
         OQcl2JHm5ow8OTDTNrM0cTUVZSVCAbLqdrZO8/EHwUQtonSa0wMPv+VcTZJ1WuyaF8Lz
         uCyrQeG4b2F04KtbUNt8Tjg+aKQBtyMooZqFFtJs++Dji0NROoIG27/O9gggaOXssvlD
         xiO8UnfX1ebjVdaXxWVM3Hk/ajBO0+Ucl+9Qo4BCAaFmeO9xGdeCIHGJoVXl8uhNfcwn
         AAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689261188; x=1691853188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLw9kTvaEkAjy+qjwvRpscnMKlwPFJS0kuzz8CxiZVE=;
        b=VBDlaHUtBCBL8PSTtefnNrswO2qPByLsTnXKKSltVuyJFWTHiA8G6lpXBvcv1pNnng
         nNFJL+XEBxxjjiAxEH9GecTyrCf8tEYf6+SNBN533YM6gsCpyaoOnig4P3GqEv0eTcLR
         lw8vBuyL21Z0jOp/lKrOLQZmJ5r7A+1NWv5mYxCKl5wHAZoMBp9Y79eXxPnP/yxxCScV
         dJ4d7bSQkEVa25Y/CLgIG98rPKGzwu9lcjgYzj2iSNhQXYeNtBaEqWuNpoJIsiP2ziTQ
         HgDkzE63UpDWfEz0VhZ0TottvE4kgN6kXsP/W0o4nq8l/QCqadN9i4BngSC4pgD+mz4P
         TTCQ==
X-Gm-Message-State: ABy/qLaI0yV59L1CXB6VLyBE+axnyU3k5oEhCIjEQSEmEmQjgyYYog3d
        GTrnet2gpYN6FH18N/SrfskTCw==
X-Google-Smtp-Source: APBJJlGs36PgSwm46u3XZJ4EUOUmqIiNs5C73pLmPTFSWMqj0iA0kL/WuS2IjEk/CnWvfdtlsVEuBA==
X-Received: by 2002:adf:ef07:0:b0:313:ee4b:b58f with SMTP id e7-20020adfef07000000b00313ee4bb58fmr1967432wro.31.1689261187786;
        Thu, 13 Jul 2023 08:13:07 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id p7-20020a5d6387000000b003143801f8d8sm8236839wru.103.2023.07.13.08.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:13:07 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH RESEND v4 5/5] riscv: libstub: Implement KASLR by using generic functions
Date:   Thu, 13 Jul 2023 17:08:00 +0200
Message-Id: <20230713150800.120821-6-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230713150800.120821-1-alexghiti@rivosinc.com>
References: <20230713150800.120821-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can now use arm64 functions to handle the move of the kernel physical
mapping: if KASLR is enabled, we will try to get a random seed from the
firmware, if not possible, the kernel will be moved to a location that
suits its alignment constraints.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/efi.h              |  3 +++
 arch/riscv/kernel/image-vars.h            |  1 +
 drivers/firmware/efi/libstub/riscv-stub.c | 33 +++++++++++------------
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
index c3dafaab36a2..6f99e8812dfd 100644
--- a/arch/riscv/include/asm/efi.h
+++ b/arch/riscv/include/asm/efi.h
@@ -52,4 +52,7 @@ void efi_virtmap_unload(void);
 
 unsigned long stext_offset(void);
 
+void efi_icache_sync(unsigned long start, unsigned long end);
+#define efi_icache_sync	efi_icache_sync
+
 #endif /* _ASM_EFI_H */
diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
index 15616155008c..ea1a10355ce9 100644
--- a/arch/riscv/kernel/image-vars.h
+++ b/arch/riscv/kernel/image-vars.h
@@ -27,6 +27,7 @@ __efistub__start		= _start;
 __efistub__start_kernel		= _start_kernel;
 __efistub__end			= _end;
 __efistub__edata		= _edata;
+__efistub___init_text_end	= __init_text_end;
 __efistub_screen_info		= screen_info;
 
 #endif
diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
index 145c9f0ba217..c96d6dcee86c 100644
--- a/drivers/firmware/efi/libstub/riscv-stub.c
+++ b/drivers/firmware/efi/libstub/riscv-stub.c
@@ -30,32 +30,29 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 efi_loaded_image_t *image,
 				 efi_handle_t image_handle)
 {
-	unsigned long kernel_size = 0;
-	unsigned long preferred_addr;
+	unsigned long kernel_size, kernel_codesize, kernel_memsize;
 	efi_status_t status;
 
 	kernel_size = _edata - _start;
+	kernel_codesize = __init_text_end - _start;
+	kernel_memsize = kernel_size + (_end - _edata);
 	*image_addr = (unsigned long)_start;
-	*image_size = kernel_size + (_end - _edata);
-
-	/*
-	 * RISC-V kernel maps PAGE_OFFSET virtual address to the same physical
-	 * address where kernel is booted. That's why kernel should boot from
-	 * as low as possible to avoid wastage of memory. Currently, dram_base
-	 * is occupied by the firmware. So the preferred address for kernel to
-	 * boot is next aligned address. If preferred address is not available,
-	 * relocate_kernel will fall back to efi_low_alloc_above to allocate
-	 * lowest possible memory region as long as the address and size meets
-	 * the alignment constraints.
-	 */
-	preferred_addr = EFI_KIMG_PREFERRED_ADDRESS;
-	status = efi_relocate_kernel(image_addr, kernel_size, *image_size,
-				     preferred_addr, efi_get_kimg_min_align(),
-				     0x0);
+	*image_size = kernel_memsize;
+	*reserve_size = *image_size;
 
+	status = efi_kaslr_relocate_kernel(image_addr,
+					   reserve_addr, reserve_size,
+					   kernel_size, kernel_codesize, kernel_memsize,
+					   efi_kaslr_get_phys_seed(image_handle));
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to relocate kernel\n");
 		*image_size = 0;
 	}
+
 	return status;
 }
+
+void efi_icache_sync(unsigned long start, unsigned long end)
+{
+	asm volatile ("fence.i" ::: "memory");
+}
-- 
2.39.2

