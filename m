Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4D17CB171
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjJPRgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPRgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:36:21 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739D69F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:36:18 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1ea48ef2cbfso740691fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697477777; x=1698082577; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wPqNuOKCfINBcA4JkEYIZMV2tOMunrhVNGKlfAdiW0k=;
        b=CPfyj7bOqS9wRvKPj0DPacoyjGFhaAiL1CzeupxZfqMM/TZQKtbLWWsm+HRf6YCJP9
         xMFkfRnjihCCnKmnzC/+VxXXCrlkrf0ADhg8/9PFS1Ovg3b0GpntbK7i/JMiCKzZykkw
         Fq3GlYGIYZXJDj9FXRtrNkY0X615NVYolX8uxMLttS8LjQDEvJyC9BS/9sX0rW7ZH0U3
         CORASV1CUA0vrZYEDkx0VaxSqx5UOPSs7LlfaQdzk7krXyKaLOOFCY99BD6apwKIp55L
         XWb38xHCkGOgpDL5ZaeeqLJ1cFZL/BehendG825q45QgOiGMmhN4lTm87piW0NVu5fr3
         tUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697477777; x=1698082577;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPqNuOKCfINBcA4JkEYIZMV2tOMunrhVNGKlfAdiW0k=;
        b=KKwvVHTFK3JqX1X5u0dWX4lrQn4N/BFhRab65A0hsAw0kdSkxQsmGCdEyq719S9oNc
         B8fyoaF1M+4HVOmhSdjRlXP8IMgAURRr/0hFWYoBb8242UG354BPZkuxArIAU/A3b++S
         +Eh5/El0bTd3tbjCF+MSZ7B7Ioxq8lp3KPZaOjHORdU8sXJe/zHLGnhRn5V4KvjNDpG8
         8NdPJtp11hieIbi+WfqYOXrPC5z+776x5zZUXv2ttxlQfP5aKI281qNCK/RlEq6JWMZX
         CIxSpDLxiC3lztH+dyHfxZqGm3BTU9UFYBbOYU6ezE3eCjNE//v166b0Ih/skA1Hd4+w
         QWrw==
X-Gm-Message-State: AOJu0YzEfOQvROAezVN7h8GURDQSvfnq4Bp+zsZi5/cswrerkB5UGGBA
        n3mAylmBC1/XG+FQhjnemZ4vVGYtyGL66PliJRj/4g==
X-Google-Smtp-Source: AGHT+IFjy7wWtg4cLzRfrDjTXhyzIN/arrlQSsc1LKoPaM1CIh1aS1d1idcXizO/mGXqU+9/QHsVCQ==
X-Received: by 2002:a05:6871:5319:b0:1e9:9469:a858 with SMTP id hx25-20020a056871531900b001e99469a858mr16940767oac.39.1697477777557;
        Mon, 16 Oct 2023 10:36:17 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id lv15-20020a056871318f00b001e0fd4c9b9asm2092936oac.6.2023.10.16.10.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 10:36:17 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v3 0/2] riscv: Add remaining module relocations and tests
Date:   Mon, 16 Oct 2023 10:36:08 -0700
Message-Id: <20231016-module_relocations-v3-0-a667fd6071e9@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIh0LWUC/23NSw6CMBCA4auQrq3pA1pw5T2MMdAOMglQ02KjI
 dzdQowLw/KfzHwzkwAeIZBTNhMPEQO6MYU8ZMR09XgHijY1EUxIVrGSDs4+e7h56J2pp7QdaKu
 kAasK3lhN0uHDQ4uvDb1cU3cYJuff24/I1+mX43KPi5wy2jTSlrnSoCt59hhdwNEcjRvIKkbxU
 zhjalcRScl1oVReyBas+VOWZfkALPixp/0AAAA=
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
 arch/riscv/include/uapi/asm/elf.h                  |   6 +-
 arch/riscv/kernel/Makefile                         |   1 +
 arch/riscv/kernel/module.c                         | 207 ++++++++++++++++++---
 arch/riscv/kernel/tests/Kconfig.debug              |  32 ++++
 arch/riscv/kernel/tests/Makefile                   |   1 +
 arch/riscv/kernel/tests/module_test/Makefile       |  15 ++
 .../tests/module_test/test_module_linking_main.c   |  78 ++++++++
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
 18 files changed, 539 insertions(+), 26 deletions(-)
---
base-commit: 4d320c2d9a2b22f53523a1b012cda17a50220965
change-id: 20230908-module_relocations-f63ced651bd7
-- 
- Charlie

