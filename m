Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315107DD837
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 23:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346690AbjJaWZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 18:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344898AbjJaWZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:25:24 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817AFF3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:25:21 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b3e13fc1f7so3969886b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698791120; x=1699395920; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K8Ul6j8QrEIyS00FFqomsmEEIf38jX8XQ6bvZNd2Kps=;
        b=c7OhI2cBQNp5O9PWQuvPxpg/E1tRxrxsXpGxQQJEPGDsASWUGRENWWsXrAKCjhWNb3
         H+bSATMxNbOIYgBectuyH6w1+xwVA59ni7ywUr65dfN8JawhdyWSVU5G5YV3p4ywOQEe
         3KzIiciVS34ccYQzMRhvF6p/5oQn0Bjstr9EQyvmbnd08O9zdbQRHc9E7EkIunwMZ0vD
         aVqOqQHIlGjZH6wiatB6M1fTRzrqzEAUwB0RT+cNFj1hm7D/LTUTr3mjvYWZrJmMuIzz
         ohHGxE5c6f3fH9c9psSJe4tzCgmfcjs8ZGPpwRDzkVNz5aea6DOfYl7UwOdPF4K7ON22
         0ITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698791120; x=1699395920;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8Ul6j8QrEIyS00FFqomsmEEIf38jX8XQ6bvZNd2Kps=;
        b=C9N7UsAg0yyovROPkR2EttXoNu6KwdI7b494IzIKV3w7XYxEnZ0qGTME4BXOTcm7a3
         pDzrjWgtCv7MkXEM4Khcq4BfPEnB8Xn+FGfz1H2Xb9f/aYEDp8QNWwaGFlwAPOlnEAnd
         v1Oo6aBOczmkFHQ1rZ6MpQc+Q/Ng3v6ETgfttgG33PnV0OSUJ1nC4tTmef6+MryN6tML
         luUCK/ccPK0RlpWIhwoFHSBzigqbrUk0PNa4bcYbU0F4zTZ1a5ajb/XTriG4B2MDPOYx
         31wiXJty6uLP+XFopVQKPdVYWAIpiJ203ZFn1A2tDjyxy+3GkhF0nhu4vi1GuoGZk8Xt
         euhg==
X-Gm-Message-State: AOJu0YwVjcnlHY7ENoZleDK71wVjQMlxoztu+QWzv/LAPDjKBa/DVzuD
        8uSVFksu+AP5WOxyR6hIv0O/4lWV/HedDzHOtxY=
X-Google-Smtp-Source: AGHT+IHHDAQnxryUkRQd0J/N4G2ONc59iCfJ5q1P5zTNnC6+DMwlrUqoWf7HvR58EemTACIUosIxPA==
X-Received: by 2002:a54:4691:0:b0:3a7:2456:6af6 with SMTP id k17-20020a544691000000b003a724566af6mr12828146oic.31.1698791120624;
        Tue, 31 Oct 2023 15:25:20 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id k16-20020a544410000000b003b2e7231faasm42975oiw.28.2023.10.31.15.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 15:25:19 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v8 0/3] riscv: Add remaining module relocations and tests
Date:   Tue, 31 Oct 2023 15:25:12 -0700
Message-Id: <20231031-module_relocations-v8-0-09b5b720c1fe@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMh+QWUC/23QwWrDMAwG4FcpPi/Dthyp3mnvMcZIbHk1tPGwO
 7NR8u5zyhhh+PgL6ZPQTRTOkYt4OtxE5hpLTEsLx4eDcKdpeech+paFlhqklcfhkvznmd8yn5O
 brq27DAHBscdRzZ5EG/zIHOLXHX15bfkUyzXl7/uOqrbqL6egx1U1yGGewR8NEpOF5xxrKnFxj
 y5dxCZW/acoKbGr6KYYGhHNCIG96yiwU1RfgaZMiBQ8SlJsO4rZK9RVTFMsUBg5gMIgO8q4V7p
 vrmNTfGAG7Y0PrvcX3Cu2q+B2iyGNjMaAVh2FdgqorkJNwWBI2RnNHOifsq7rD2L0G9dbAgAA
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v8:
- Fix up riscv_insn_rmw to work with big-endian systems (Andreas/Emil)
- Improve readability of bitops throughout module.c (Emil)
- Consolidate all relocation handler functions into a single struct so
  array doesn't need to be duplicated 3 times
- Use .space assember op instead of .rept
- Fix up name of uleb128 testcase
- Define prototypes of some new functions to conform to -Wmissing-prototypes
- Remove unused variable "first"
- Link to v7: https://lore.kernel.org/r/20231031-module_relocations-v7-0-6f4719b64bf7@rivosinc.com

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
 arch/riscv/kernel/module.c                         | 650 +++++++++++++++++----
 arch/riscv/kernel/tests/Kconfig.debug              |  35 ++
 arch/riscv/kernel/tests/Makefile                   |   1 +
 arch/riscv/kernel/tests/module_test/Makefile       |  15 +
 .../tests/module_test/test_module_linking_main.c   |  88 +++
 arch/riscv/kernel/tests/module_test/test_set16.S   |  23 +
 arch/riscv/kernel/tests/module_test/test_set32.S   |  20 +
 arch/riscv/kernel/tests/module_test/test_set6.S    |  23 +
 arch/riscv/kernel/tests/module_test/test_set8.S    |  23 +
 arch/riscv/kernel/tests/module_test/test_sub16.S   |  20 +
 arch/riscv/kernel/tests/module_test/test_sub32.S   |  20 +
 arch/riscv/kernel/tests/module_test/test_sub6.S    |  20 +
 arch/riscv/kernel/tests/module_test/test_sub64.S   |  25 +
 arch/riscv/kernel/tests/module_test/test_sub8.S    |  20 +
 arch/riscv/kernel/tests/module_test/test_uleb128.S |  31 +
 18 files changed, 916 insertions(+), 105 deletions(-)
---
base-commit: 3bcce01fcbcd868b8cf3a5632fde283e122d7213
change-id: 20230908-module_relocations-f63ced651bd7
-- 
- Charlie

