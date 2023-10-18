Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A747CD392
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 07:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjJRFeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 01:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjJRFeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 01:34:21 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0B9B0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 22:34:19 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b0dcbf3672so3932738b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 22:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697607259; x=1698212059; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zcA19DI8JxNOsatUyRCutdloslAvaeKjMvE3flJ53dg=;
        b=gv8a2RWaPf8xdy/oifB3e9wYwO+0rbd2JLjNPe8N1lrJ3e5N1xtECXOyvlNTZurmG3
         NM1pzoEfiPOXWM/vmnAj1uiHAI1XZlPnNHzan0izJL1fj8Kw43ueCaqhHY+6bnPMDGnU
         rGsry14y+5hljMBSEgdFlkk99pLYEED0XiKkX7RhbtP5Nq/+YXeUIvV2st2cHftpwc1R
         Jnr6IvZlF8PjBzHWYGMVAgdSKAexeqVSPkWvNto1GQIf+TwIS0v5PoTsGi2XloGSBNye
         4au60wVYQiMxI3x17EzPwp4+xsyWDLF6xz0tqxudAQFpgb8p6n6+2CHsFlFMyGDMw9Bz
         ps7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697607259; x=1698212059;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zcA19DI8JxNOsatUyRCutdloslAvaeKjMvE3flJ53dg=;
        b=Sp3dedCJUDPSAH5rcXXRAaO1T9a10g4cdqmIw5aFihmCPaUmGGavvZATiQn1nTTcX3
         aU6Du256zJg1aaRKByxkuy6Hp1A7K48rssa6Xq5mzUKLU+i21BWQ4NmRC6UCH8FS9H5+
         wVZpx1KhH/Kc5TGgSLIBJm++JFk4Rl34OeEDwj5CAFh17292fed2SW/lU/ub/Ji280zO
         wAjlP/MGm9hId02zihYOcS+aOJXHifNy8PB2EP9kADSSFYOdvm4CPa8wXvqOuUeAfQZD
         ZnniS6mVVnfhxUindqlmm6XCPjXxmIgG+/u7duQS6rxRLIllixGoJaVaXUPxr394n9qu
         Hx4g==
X-Gm-Message-State: AOJu0YxxYYZJ8gkBHvfYU1C1g2BO+R2WYmO9ixmujuMk2yjOuajq/g7P
        EkBATYZXAtVlMPGAsX4mkYNVQA==
X-Google-Smtp-Source: AGHT+IGK/wCHRdzqyE+f30dZhC8keLR9CdSNY1bxU9dNVzNKpnZmQTzobu7h+SvnIzAMMQwoVz2Syg==
X-Received: by 2002:a05:6808:8b:b0:3ae:156f:d325 with SMTP id s11-20020a056808008b00b003ae156fd325mr4197727oic.58.1697607258872;
        Tue, 17 Oct 2023 22:34:18 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id z26-20020a54459a000000b003af60f06629sm527977oib.6.2023.10.17.22.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 22:34:18 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v4 0/2] riscv: Add remaining module relocations and tests
Date:   Tue, 17 Oct 2023 22:34:15 -0700
Message-Id: <20231017-module_relocations-v4-0-937f5ef316f0@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFduL2UC/23N3QqCMBTA8VeRXbfYh55pV71HROh2zIG52GwU4
 rs3JSLCy//hnN+ZSEBvMZBDNhGP0QbrhhT5LiO6q4crUmtSE8GEZBUr6c2ZR48Xj73T9Zi2A21
 BajRQ8MYokg7vHlv7XNHTOXVnw+j8a/0R+TL9cFxucZFTRptGmjIHhaqSR2+jC3bQe+1uZBGj+
 CqcMdhURFJyVQDkhWzR6A1F/ih8W5FJqQFUa4ApjtWfMs/zGxPwXQpDAQAA
To:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Charlie Jenkins <charlie@rivosinc.com>
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

 arch/riscv/Kconfig.debug                           |   1 +
 arch/riscv/include/uapi/asm/elf.h                  |   5 +-
 arch/riscv/kernel/Makefile                         |   1 +
 arch/riscv/kernel/module.c                         | 207 ++++++++++++++++++---
 arch/riscv/kernel/tests/Kconfig.debug              |  35 ++++
 arch/riscv/kernel/tests/Makefile                   |   1 +
 arch/riscv/kernel/tests/module_test/Makefile       |  15 ++
 .../tests/module_test/test_module_linking_main.c   |  85 +++++++++
 arch/riscv/kernel/tests/module_test/test_set16.S   |  23 +++
 arch/riscv/kernel/tests/module_test/test_set32.S   |  20 ++
 arch/riscv/kernel/tests/module_test/test_set6.S    |  23 +++
 arch/riscv/kernel/tests/module_test/test_set8.S    |  23 +++
 arch/riscv/kernel/tests/module_test/test_sub16.S   |  22 +++
 arch/riscv/kernel/tests/module_test/test_sub32.S   |  22 +++
 arch/riscv/kernel/tests/module_test/test_sub6.S    |  22 +++
 arch/riscv/kernel/tests/module_test/test_sub64.S   |  27 +++
 arch/riscv/kernel/tests/module_test/test_sub8.S    |  22 +++
 arch/riscv/kernel/tests/module_test/test_uleb128.S |  20 ++
 18 files changed, 548 insertions(+), 26 deletions(-)
---
base-commit: 4d320c2d9a2b22f53523a1b012cda17a50220965
change-id: 20230908-module_relocations-f63ced651bd7
-- 
- Charlie

