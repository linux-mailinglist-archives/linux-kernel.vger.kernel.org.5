Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280E77DE623
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjKASdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjKASdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:33:08 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8A910F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:33:05 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-586cf3eccbeso40988eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698863584; x=1699468384; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YlYNLy4VnSwlzJ5T98YglMe9qEBY6q8tyB3afSFZj/k=;
        b=Re9FW4j3/JO1CEhH2/Tm4xSCrPmkL8dt2Ztb7IvEz3z5YX7/qKUIHPKE97EAbgK6kY
         F8ti1hrlnMPVfJwziDK4VTEgakQrGIji64aSBy+HIOVNeBIPhAwcVFzkqWHIOeDcEfZq
         cyrZIaKX3TpxQ/U+KvlcO1KWu4ZFA3wmKkWsNINFBPF+YrIBvPvU0XgjvNNdIx304YBZ
         yJwYxRa0xMPYSahyALBUl57eg3Wz32Z/58hJxolpet2SIHeMBz3+21hG6ae6rZ98Wfal
         DvA60Fgnk1UYd+8DCzQ9GHiJ/6uR/068s+O491Ak6GbwueFoboV8NKSEGe4zRtjbf7Se
         KxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698863584; x=1699468384;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlYNLy4VnSwlzJ5T98YglMe9qEBY6q8tyB3afSFZj/k=;
        b=Rdyb8vnUnyQx09KpcpMvAWMw9Stg8MA0G/A0Uw+zBGP/pL5XahWfGzYH8cUOdzjWrR
         xxpFKkAIfP4U6KoQi+b33+AlBQpno54ggkS133oOHqlyU487WJlYEXzCQI2r8P6jJb/v
         pnzYP8uxAawBkG3j1+UXgYvbheAsIgaDtskFxxzsIFzV50w7hLkDFEXPtkf94vLsBxP7
         3luvvHo7Ko9YNWvTbqiyCBcwg4//IAa+5ariByBA/xos+QnfFVbdsGB1JcnUQjt91EM/
         +KYr4/HnoElXEfz2HTMlMfdBbL4frAWXWLYiOIn8Zyww5EI+j3oXUEbeJc1ONke31GXq
         dvdw==
X-Gm-Message-State: AOJu0YwiGbJD2AgPS0/3+XdtIgYT2T/wUXNx2WpIoSkIoBTS2sDtLxxD
        582w6855y7+171l6RFYVv8x45Q==
X-Google-Smtp-Source: AGHT+IEjD1wkkctBbU+7K5oihsH7H4HSTVQxge9RCOX/Hymo2C9jI2bYeaR39S7Le6kXF5cz9OqAFw==
X-Received: by 2002:a4a:c885:0:b0:587:2b9b:985a with SMTP id t5-20020a4ac885000000b005872b9b985amr5701208ooq.9.1698863584599;
        Wed, 01 Nov 2023 11:33:04 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id m14-20020a4aab8e000000b00581e090fd1fsm686331oon.8.2023.11.01.11.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 11:33:04 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v9 0/3] riscv: Add remaining module relocations and tests
Date:   Wed, 01 Nov 2023 11:32:58 -0700
Message-Id: <20231101-module_relocations-v9-0-8dfa3483c400@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANqZQmUC/4XQwWrDMAwG4FcpPi/Dtmwp7mnvMcaobXk1tM1Iu
 rBR8u5zyhhhCHb8hfRJ6KYmHitPar+7qZHnOtXh0kJ42Kl0PFzeuKu5ZWW1BR10352H/HHi15F
 PQzpcW/fUFYTEGb2JmVQbfB+51M87+vzS8rFO12H8uu+YzVr94QxI3Gw63cUIuXdITAGexjoPU
 72kxzSc1SrO9lcxWqOo2KY48ojOQ+GcBAU2ipEVaMoBkUpGTYaDoLitQqLimhKAiucCBosWFL9
 VxDfPvim5MIPNLpck/QW3ShAVXG9xZJHRObBGUGijgBEVagoWRyZEdLGQoPT/K31TdIg+ktXJF
 P6jLMvyDSROhxShAgAA
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
Changes in v9:
- Use uintptr_t where applicable (Emil)
- Split up insn_rmw changes into correct patch (Emil)
- Make reloc_handlers const and simplify struct (Emil)
- Link to v8: https://lore.kernel.org/r/20231031-module_relocations-v8-0-09b5b720c1fe@rivosinc.com

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
 arch/riscv/kernel/module.c                         | 603 +++++++++++++++++----
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
 arch/riscv/kernel/tests/module_test/test_uleb128.S |  31 ++
 18 files changed, 869 insertions(+), 105 deletions(-)
---
base-commit: 3bcce01fcbcd868b8cf3a5632fde283e122d7213
change-id: 20230908-module_relocations-f63ced651bd7
-- 
- Charlie

