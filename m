Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FBE7CEB7A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjJRWvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJRWvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:51:08 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3CF113
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:51:04 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6cd1918afb2so484581a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697669464; x=1698274264; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9/6gRB6PKN0zKg0UrM+QY05Z/ZteQMJLVCSifjerBXY=;
        b=1XH9a8+ryFE5WeaBN+sisfHmnHN9cfZaMFEiFCxrZ6gp0UwwSj934h0X6+6l8GtJk6
         1DBlzWWfHQu0J1iP5bTLCz38KT5qwzgmw+soqiTnuvRbjeXfdorMFgxrMqXkTOgMcko0
         P+mJFZX3pFOw0AFKTMPWr6jXQNauNQuMQnozARb/yB8RlvTowsE6xXqkNlVQm2yyZQUR
         M7omp9mPrzfcmbdj+zrCPSNX84tI3F3uEigaHlnuVjMVqgzVN++BRfv6Zn7GEAJWkqR7
         FAk96t3UIX/qy92XTHjxWOOu/x8XaVkbU9fE3debuGT2yfnG9pJ5XlbC7TZpPC7y3+kr
         aP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697669464; x=1698274264;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/6gRB6PKN0zKg0UrM+QY05Z/ZteQMJLVCSifjerBXY=;
        b=VX0VktGvjrghT2/7FiZadiesB+6kQT43ZRW4KbnMjgRzE57O5uOEn6mTPslGh095M/
         N83dSFBEdj2FGP7gXzaYCyFe5aJjLsfPlb3PUQzNK7FzPeY9GoNBD0RUKnLWorclTgrB
         tTEeVBJKFITfZ1B5RN9ErYzSdwHpJ6W7VHShZnJeQi7ZsVUP6apykQPwU1SWSy9MJdhd
         wnqcc+GuSmjWuCnYCwwqSmPovGe9COyPZhoVNjrnpo6sz2xpnfD4mAKqOWbLEozj8DSY
         5iIaHYE1y1bf5agyBrpnrqBSEF83S1HnodK1OrC+z+MQMTOqwB1ZQGY/OYTSzJvyC3z6
         LFjQ==
X-Gm-Message-State: AOJu0YyX05Jjw+3nOA2+jEI50xCcNHBF+ivBjQ9z4VWFzB+IJfNR9SOj
        uFaXXp7ToxicL3q2c6vKFWldsg==
X-Google-Smtp-Source: AGHT+IHPM5SEb3p3yXI6+cmxTQEe9iGrXUotAOK1ZPi+82laCIzaDi0NMhLemTRTVTsPi8QNYprGKw==
X-Received: by 2002:a9d:7398:0:b0:6ce:21c:28a9 with SMTP id j24-20020a9d7398000000b006ce021c28a9mr634585otk.34.1697669463891;
        Wed, 18 Oct 2023 15:51:03 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id r195-20020a4a37cc000000b00581e7506f2fsm641134oor.9.2023.10.18.15.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 15:51:03 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v5 0/3] riscv: Add remaining module relocations and tests
Date:   Wed, 18 Oct 2023 15:51:00 -0700
Message-Id: <20231018-module_relocations-v5-0-dfee32d4dfc3@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFRhMGUC/23NwWoDIRCA4VcJnmvQHR2zPeU9Qii7OjZCshZNJ
 CHsu9ddQgnF4z/MfPNkmVKgzD43T5aohBziVEN/bJg9DdM38eBqs050IHqx45fobmf6SnSOdrj
 W7cw9giWHWo7OsHr4k8iH+4oejrVPIV9jeqw/ilymL05CiyuSCz6O4HYKDZke9imUmMNktzZe2
 CKW7k+RQmBT6aqijEZUGjw521DgTZFtBaoyIBrvUBhJfUNR74ppKqoqPRivyYNEL/4p8zz/Ai9
 cJJSJAQAA
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
        Charlie Jenkins <charlie@rivosinc.com>,
        Emil Renner Berthing <kernel@esmil.dk>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

ULEB128 handling is a bit special because SET and SUB relocations must
happen together, and SET must happen before SUB. A psABI proposal [1]
mandates that the first SET_ULEB128 that appears before a SUB_ULEB128
is the associated SET_ULEB128.

This can be tested by enabling KUNIT, RUNTIME_KERNEL_TESTING_MENU, and
RISCV_MODULE_LINKING_KUNIT.

[1] https://github.com/riscv-non-isa/riscv-elf-psabi-doc/pull/403

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
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
 arch/riscv/kernel/module.c                         | 371 +++++++++++++++------
 arch/riscv/kernel/tests/Kconfig.debug              |  35 ++
 arch/riscv/kernel/tests/Makefile                   |   1 +
 arch/riscv/kernel/tests/module_test/Makefile       |  15 +
 .../tests/module_test/test_module_linking_main.c   |  85 +++++
 arch/riscv/kernel/tests/module_test/test_set16.S   |  23 ++
 arch/riscv/kernel/tests/module_test/test_set32.S   |  20 ++
 arch/riscv/kernel/tests/module_test/test_set6.S    |  23 ++
 arch/riscv/kernel/tests/module_test/test_set8.S    |  23 ++
 arch/riscv/kernel/tests/module_test/test_sub16.S   |  22 ++
 arch/riscv/kernel/tests/module_test/test_sub32.S   |  22 ++
 arch/riscv/kernel/tests/module_test/test_sub6.S    |  22 ++
 arch/riscv/kernel/tests/module_test/test_sub64.S   |  27 ++
 arch/riscv/kernel/tests/module_test/test_sub8.S    |  22 ++
 arch/riscv/kernel/tests/module_test/test_uleb128.S |  20 ++
 18 files changed, 637 insertions(+), 101 deletions(-)
---
base-commit: 4d320c2d9a2b22f53523a1b012cda17a50220965
change-id: 20230908-module_relocations-f63ced651bd7
-- 
- Charlie

