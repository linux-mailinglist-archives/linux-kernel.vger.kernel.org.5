Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618F97DC735
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343677AbjJaHZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343611AbjJaHZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:25:01 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C16C1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 00:24:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc2575dfc7so26332305ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 00:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698737098; x=1699341898; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vhAhMlUaphHl5V7P6XcsEBHb1Aahpw8dSDQur0cX8zw=;
        b=1Zj2xfsEM8yuLQ0p1aVRsOU7MIt+b4pHcVfkRmKwEWYgmiVJHpGww412QxfyPJUV6v
         ayKIrkWFCaSaQGn5642AVp3wFeO0AEpetk3d6HKHF7eYUYSNg0yQF6F+MTckoUBmttpO
         XeI5JiODH+myEdYo332VByjZhEv4EPvaaUKK9ngeMtTNPJ0tUTkN9txVDJLqLRsacxVn
         UTuLUiosys3ZwNPySgUn1Dc69t/LJmfLpNkiz02keVqzc6cvPDHhN6Au5D5jHp40EyzR
         h/lPsOYSTDMdMZyn6giE2ZYTsG55/Q5W0Bzhr8voh/Ljt3iRRx6B5WswfeF+lI+N1pn9
         o/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698737098; x=1699341898;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhAhMlUaphHl5V7P6XcsEBHb1Aahpw8dSDQur0cX8zw=;
        b=g13X72W5wb7UA08Oap2NziQPK5uiHk07t6JXWhKULyl8JOw3Nul27/gou95EOc4qlr
         mDt3UNmW1UjS0JVvCA9kAMWz6rYk1Uzt5yCmbqoj39oTE1D95f7L3qYbZGalKlePNhsk
         u31NftETc6QCy7RHYT+TAR/5A3MxASsf5+KZ5Hs35ZKHWxu4MNGpVVYLXNoj0dVKfEFT
         CiXdN5qr/cj3M/seSeVC+rEq9pYV6RUJ+3HfSBPAzjDQCNaTu8FKetft8n0ZoJx+B4Sg
         ecSKLu0yQwBmq/DI9h2+ha6V9zgsiDLYHrRHM0ZdeosLLHg1J1jKXGjlGAPWZQhs3S3W
         txEQ==
X-Gm-Message-State: AOJu0Ywm7k/Lhf8xgWVkbjdq9I4AqMZhZNMJHLP5n3dkbBcBJBXA7Sg5
        QNm/30wk41FURi5d7JYin/pNHQ==
X-Google-Smtp-Source: AGHT+IGD/aZU9vUfXBx6ayFBL19n5/oM54mKqlA9X4PoucNNNDI8a+afCb9T5z81BufqYr+mzRHhMg==
X-Received: by 2002:a17:902:ce8e:b0:1cc:636f:f38a with SMTP id f14-20020a170902ce8e00b001cc636ff38amr1759360plg.57.1698737098025;
        Tue, 31 Oct 2023 00:24:58 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902d90400b001c74876f018sm652575plz.18.2023.10.31.00.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 00:24:57 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v7 0/3] riscv: Add remaining module relocations and tests
Date:   Tue, 31 Oct 2023 00:24:49 -0700
Message-Id: <20231031-module_relocations-v7-0-6f4719b64bf7@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMGrQGUC/23QwWoEIQwG4FdZPNeiRuPaU9+jlDKjsSvsjkW30
 rLMu9dZShmKxz8kX0JurFJJVNnT4cYKtVRTXnqwDwfmT9PyTjyFnpkSCoQTR37J4fNMb4XO2U/
 X3l15RPAU0Mg5WNYHPwrF9HVHX157PqV6zeX7vqPJrfrLSRhxTXLB5xnCUaMl6+C5pJZrWvyjz
 xe2iU39KVIIHCqqK9oaRG0gUvADBXaKHCvQlQnRxoDCSnIDRe8VO1R0VxzYaCiCxCgGitkrwzc
 305UQiUAFHaIf/QX3ihsquN2irUJCrUHJf8q6rj/THr9CFQIAAA==
To:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        Nelson Chu <nelson@rivosinc.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Emil Renner Berthing <kernel@esmil.dk>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A handful of module relocations were missing, this patch includes the
remaining ones. I also wrote some test cases to ensure that module
loading works properly. Some relocations cannot be supported in the
kernel, these include the ones that rely on thread local storage and
dynamic linking.

This patch also overhauls the implementation of ADD/SUB/SET/ULEB128
relocations to handle overflow. "Overflow" is different for ULEB128
since it is a variable-length encoding that the compiler can be expected
to generate enough space for. Instead of overflowing, ULEB128 will
expand into the next 8-bit segment of the location.

A psABI proposal [1] was merged that mandates that SET_ULEB128 and
SUB_ULEB128 are paired, however the discussion following the merging of
the pull request revealed that while the pull request was valid, it
would be better for linkers to properly handle this overflow. This patch
proactively implements this methodology for future compatibility.

This can be tested by enabling KUNIT, RUNTIME_KERNEL_TESTING_MENU, and
RISCV_MODULE_LINKING_KUNIT.

[1] https://github.com/riscv-non-isa/riscv-elf-psabi-doc/pull/403

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v7:
- Overhaul ADD/SUB/SET/ULEB128 relocations
- Fix ULEB128 so it produces correct values when more than 1 byte is
  needed
- Link to v6: https://lore.kernel.org/r/20231019-module_relocations-v6-0-94726e644321@rivosinc.com

Changes in v6:
- Use (void *) instead of (u32 *) for handler type
- Constrain ULEB128 to be consecutive relocations
- Link to v5: https://lore.kernel.org/r/20231018-module_relocations-v5-0-dfee32d4dfc3@rivosinc.com

Changes in v5:
- Brought in patch by Emil and fixed it up to force little endian
- Fixed up issues with apply_r_riscv_32_pcrel_rela and
  apply_r_riscv_plt32_rela (Samuel)
- Added u8 cast in apply_r_riscv_sub6_rela (Andreas) 
- Link to v4: https://lore.kernel.org/r/20231017-module_relocations-v4-0-937f5ef316f0@rivosinc.com

Changes in v4:
- Complete removal of R_RISCV_RVC_LUI
- Fix bug in R_RISCV_SUB6 linking
- Only build ULEB128 tests if supported by toolchain
- Link to v3: https://lore.kernel.org/r/20231016-module_relocations-v3-0-a667fd6071e9@rivosinc.com

Changes in v3:
- Add prototypes to test_module_linking_main as recommended by intel
  zero day bot
- Improve efficiency of ULEB128 pair matching
- Link to v2: https://lore.kernel.org/r/20231006-module_relocations-v2-0-47566453fedc@rivosinc.com

Changes in v2:
- Added ULEB128 relocations
- Link to v1: https://lore.kernel.org/r/20230913-module_relocations-v1-0-bb3d8467e793@rivosinc.com

---
Charlie Jenkins (2):
      riscv: Add remaining module relocations
      riscv: Add tests for riscv module loading

Emil Renner Berthing (1):
      riscv: Avoid unaligned access when relocating modules

 arch/riscv/Kconfig.debug                           |   1 +
 arch/riscv/include/uapi/asm/elf.h                  |   5 +-
 arch/riscv/kernel/Makefile                         |   1 +
 arch/riscv/kernel/module.c                         | 685 ++++++++++++++++++---
 arch/riscv/kernel/tests/Kconfig.debug              |  35 ++
 arch/riscv/kernel/tests/Makefile                   |   1 +
 arch/riscv/kernel/tests/module_test/Makefile       |  15 +
 .../tests/module_test/test_module_linking_main.c   |  88 +++
 arch/riscv/kernel/tests/module_test/test_set16.S   |  23 +
 arch/riscv/kernel/tests/module_test/test_set32.S   |  20 +
 arch/riscv/kernel/tests/module_test/test_set6.S    |  23 +
 arch/riscv/kernel/tests/module_test/test_set8.S    |  23 +
 arch/riscv/kernel/tests/module_test/test_sub16.S   |  22 +
 arch/riscv/kernel/tests/module_test/test_sub32.S   |  22 +
 arch/riscv/kernel/tests/module_test/test_sub6.S    |  22 +
 arch/riscv/kernel/tests/module_test/test_sub64.S   |  27 +
 arch/riscv/kernel/tests/module_test/test_sub8.S    |  22 +
 arch/riscv/kernel/tests/module_test/test_uleb128.S |  31 +
 18 files changed, 963 insertions(+), 103 deletions(-)
---
base-commit: 3bcce01fcbcd868b8cf3a5632fde283e122d7213
change-id: 20230908-module_relocations-f63ced651bd7
-- 
- Charlie

