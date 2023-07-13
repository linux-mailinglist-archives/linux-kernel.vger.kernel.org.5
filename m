Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB1A752626
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjGMPIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjGMPIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:08:05 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EDFE4F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:08:04 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbfcc6daa9so7505635e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689260883; x=1691852883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lni4UWIKw2Lp7DjCo96CHQnoSYyoodWrf2lKDIVVpbc=;
        b=sj9ClK4NUhpnKCFC64kQfjD96nMZznWfZOzxrC+tZLrM1q7eZdMEVU36AmLtzZWyqZ
         H6+I7eSk0aJUB1k7vSzG482QGgPU/0XqZFaIN+pg8qIPfc0O1ATxLn59uro47OIXQRHu
         smE7ZGMkgM7EbkVohrtbrq4EZ+Ifju7QRZHwhopYWfN+cWn043aolj9vwoY34rfHLYEF
         lEwlBxTl3XMuywyv08PZ++OJmunWTMSCfslBQkUgEUQ/6xLypwGlUgtlrmVPpgBPxkhy
         6gjUbcYX8FMl91FdywZ3e9ETsXxF4QmsXNK/VACDBO4j167+y0TEY6UnmS5zY7ljU8go
         lDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689260883; x=1691852883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lni4UWIKw2Lp7DjCo96CHQnoSYyoodWrf2lKDIVVpbc=;
        b=RX88Z6N22bD9TFQs2NB6VdYHT6K5tUsTgyme6VSmPZFb3AqY6rwSyX6Su90Y6GjCeJ
         ylvd3yE9vIru2SFNM+6RV9mIh7xa+kOSGAwxd3PcmL/zls50Q2EM6qsu61x85JGbKveQ
         LKu8+qK2yFnsztXEqvgxYqAJy4v4v13RVbaIcwSYb8uAAP9zeaevBcHSksnV+seCnMTW
         inygjmRh2E+FZij2vjQSlyCkc4zgbTiCyV9RRljj+RH8RBFib47/z+aZswRgUmUMUGeZ
         vaZrIlvGjIT3nqzf397cN1ypQpkwAj0DKEpO6Zey74bL6+fBlI12qsqoH6H4Bv6e3bqy
         FDzA==
X-Gm-Message-State: ABy/qLaNBCuLkab7melpGF3P17bH5wGWpGmQ2MbinT31XqVleUnkYi66
        tqS1L47VjrSPDyalP23EZ8NjYg==
X-Google-Smtp-Source: APBJJlFBxezJWxszuwCwiBNF3orxllOlCtInhGKmw3C6zySX0L1qcmDavDq6eTidrxiBhLiTKAAyiw==
X-Received: by 2002:a05:600c:11cf:b0:3fb:e4ce:cc65 with SMTP id b15-20020a05600c11cf00b003fbe4cecc65mr1638951wmi.25.1689260882792;
        Thu, 13 Jul 2023 08:08:02 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id c26-20020a05600c0ada00b003fbcdba1a52sm18645597wmr.3.2023.07.13.08.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:08:02 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH RESEND v4 0/5] riscv: Introduce KASLR
Date:   Thu, 13 Jul 2023 17:07:55 +0200
Message-Id: <20230713150800.120821-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following KASLR implementation allows to randomize the kernel mapping:

- virtually: we expect the bootloader to provide a seed in the device-tree
- physically: only implemented in the EFI stub, it relies on the firmware to
  provide a seed using EFI_RNG_PROTOCOL. arm64 has a similar implementation
  hence the patch 3 factorizes KASLR related functions for riscv to take
  advantage.

The new virtual kernel location is limited by the early page table that only
has one PUD and with the PMD alignment constraint, the kernel can only take
< 512 positions.

base-commit-tag: v6.5-rc1

Changes in v4:
  * Fix efi_get_kimg macro that returned nothing
  * Moved new kaslr functions into their own files to avoid zboot link
    failures, as suggested by Ard

Changes in v3:
  * Rebase on top of 6.4-rc2
  * Make RANDOMIZE_BASE depend on 64bit
  * Fix efi_icache_sync and efi_get_kimg_min_align which were undefined
    in x86 (and certainly other archs)
  * Add patch 4 to fix warning on rv32

Changes in v2:
  * Rebase on top of 6.3-rc1
  * Add a riscv cache sync after memcpying the kernel
  * Add kaslr_offset implementation for KCOV
  * Add forward declaration to quiet LLVM

Alexandre Ghiti (5):
  riscv: Introduce virtual kernel mapping KASLR
  riscv: Dump out kernel offset information on panic
  arm64: libstub: Move KASLR handling functions to efi-stub-helper.c
  libstub: Fix compilation warning for rv32
  riscv: libstub: Implement KASLR by using generic functions

 arch/arm64/include/asm/efi.h                  |   4 +
 arch/riscv/Kconfig                            |  19 +++
 arch/riscv/include/asm/efi.h                  |   4 +
 arch/riscv/include/asm/page.h                 |   3 +
 arch/riscv/kernel/image-vars.h                |   1 +
 arch/riscv/kernel/pi/Makefile                 |   2 +-
 arch/riscv/kernel/pi/cmdline_early.c          |  13 ++
 arch/riscv/kernel/pi/fdt_early.c              |  30 ++++
 arch/riscv/kernel/setup.c                     |  25 +++
 arch/riscv/mm/init.c                          |  36 +++-
 drivers/firmware/efi/libstub/Makefile         |   3 +-
 drivers/firmware/efi/libstub/arm64-stub.c     | 117 ++-----------
 drivers/firmware/efi/libstub/efi-stub-kaslr.c | 159 ++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h        |  18 ++
 drivers/firmware/efi/libstub/riscv-stub.c     |  33 ++--
 15 files changed, 342 insertions(+), 125 deletions(-)
 create mode 100644 arch/riscv/kernel/pi/fdt_early.c
 create mode 100644 drivers/firmware/efi/libstub/efi-stub-kaslr.c

-- 
2.39.2

