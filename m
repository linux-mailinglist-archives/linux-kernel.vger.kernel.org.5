Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1405679F36C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjIMVFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjIMVFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:05:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D851BCA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:05:40 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf1935f6c2so2281165ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694639140; x=1695243940; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IrM1G1X1joN9C/3rPYTl47RElW8sRiJaPs6T25r1A0k=;
        b=NgBTjcdtOrsiRkm0kEhYSpOj6GqY+fj3G0PJIPBra+G5WbtT3XMrxx7TNq/hTrrnDb
         6+8Bfxcox1wsPpeiFdYrFOEb7ZZraT69fQ+LGzvGqrhBjV5gvkEICpLb1aO0zdzURgCe
         f0/oPWrxcIl9j9HJ9GNEbB1yy9fF6zIM/NU7nJTJjkvNmrq1SFprPpy/njtR2F7cVyld
         VZQEo9zbGpPMjR+gnodfJcm02HxbUzxP8mzhJaLnah6rPQpddCCdCO1tVKW1pbLj33HQ
         flBd+RMOdX28SYw3aVLs7IyNZxiNDLTdYPjZ28GqX2ozoGUsQnl/DR+5+MQnlz1rPY4V
         rGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694639140; x=1695243940;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IrM1G1X1joN9C/3rPYTl47RElW8sRiJaPs6T25r1A0k=;
        b=qk2ocfwNKG0nUknFpF5Irn9IR1YknvNmR3WVRkF9R3LZZGvtx2l+pj+Tlc0D/semrl
         Z5vpSOGu5vNyL91JWI6ArgLCV+/Iu4feiraAvHUEe4xWxcSGwls68FqkE6YJZduCTGlb
         Wagnkqd+GzRljHGQ8z8qBYFEvx718xc7A4bBsY6CwOLJD2nteLet3nbDBytpu2ZzHdlp
         BrTWMEMOHb7+1nbVPPUHBd0U8CqSsftmNVUQXqDmNoHV/k/hNXIH8HyAy4Ry9DC7UDnk
         3nvz1nj2xo5YMrlVZqhY9diE6CkkK64p8uGm8mWKVslmvyVYEfkNPYI6/TgvrkhsfPaY
         MQsg==
X-Gm-Message-State: AOJu0Yw9yf8zgwvNzw25aVd5/3JgVWWc3C/y62+aR18czpztgZaxI0jw
        rgP5TKamUfhzbayYgbhmxBy/zg==
X-Google-Smtp-Source: AGHT+IHGL3wuen0cvdY0OmpjQGjsmcKpwlYbOm7HmVx+lfYDGKmJjed11FXMUCYGBl/R3WLTRhQF2Q==
X-Received: by 2002:a17:902:d487:b0:1c3:e3b1:98f9 with SMTP id c7-20020a170902d48700b001c3e3b198f9mr5880198plg.24.1694639140186;
        Wed, 13 Sep 2023 14:05:40 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id z16-20020a170903019000b001ab2b4105ddsm66323plg.60.2023.09.13.14.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 14:05:39 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 0/2] riscv: Add remaining module relocations and tests
Date:   Wed, 13 Sep 2023 14:04:48 -0700
Message-Id: <20230913-module_relocations-v1-0-bb3d8467e793@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPAjAmUC/x2MWwqAIBAAryL7nWBKz6tERLlbLVSGVgTR3ZM+B
 2bmgUCeKUAtHvB0cWC3RUgTAXbut4kkY2TQShtVqVKuDs+FOk+Ls/0R7SDH3FjCPEsHLCCGu6e
 R73/atO/7AV7LNqRkAAAA
To:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A handful of module relocations were missing, this patch includes the
remaining ones. I also wrote some test cases to ensure that module
loading works properly. Some relocations cannot be supported in the
kernel, these include the ones that rely on thread local storage and
dynamic linking. The ULEB128 relocations also seem to be stripped out
of kernel module binaries.

This can be tested by enabling KUNIT, RUNTIME_KERNEL_TESTING_MENU, and
RISCV_MODULE_LINKING_KUNIT.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Charlie Jenkins (2):
      riscv: Add remaining module relocations
      riscv: Add tests for riscv module loading

 arch/riscv/Kconfig.debug                           |   1 +
 arch/riscv/include/uapi/asm/elf.h                  |   6 +-
 arch/riscv/kernel/Makefile                         |   1 +
 arch/riscv/kernel/module.c                         | 191 ++++++++++++++++++---
 arch/riscv/kernel/tests/Kconfig.debug              |  32 ++++
 arch/riscv/kernel/tests/Makefile                   |   1 +
 arch/riscv/kernel/tests/module_test/Makefile       |  11 ++
 .../tests/module_test/test_module_linking_main.c   |  64 +++++++
 arch/riscv/kernel/tests/module_test/test_set16.S   |  23 +++
 arch/riscv/kernel/tests/module_test/test_set32.S   |  20 +++
 arch/riscv/kernel/tests/module_test/test_set6.S    |  23 +++
 arch/riscv/kernel/tests/module_test/test_set8.S    |  23 +++
 arch/riscv/kernel/tests/module_test/test_sub16.S   |  22 +++
 arch/riscv/kernel/tests/module_test/test_sub32.S   |  22 +++
 arch/riscv/kernel/tests/module_test/test_sub6.S    |  22 +++
 arch/riscv/kernel/tests/module_test/test_sub64.S   |  27 +++
 arch/riscv/kernel/tests/module_test/test_sub8.S    |  22 +++
 17 files changed, 485 insertions(+), 26 deletions(-)
---
base-commit: a48fa7efaf1161c1c898931fe4c7f0070964233a
change-id: 20230908-module_relocations-f63ced651bd7
-- 
- Charlie

