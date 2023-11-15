Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD497EC9C4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjKORha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKORh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:37:28 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7D8196
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:25 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b2e72fe47fso4590564b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700069844; x=1700674644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E9JaYSUMlUNj9iGPu8qtYwBLemqvJN+yaOMZ5z5lUk0=;
        b=TzIjeGwaj8agTQLeaUC4KqFNQluAyTLOwr0VBMto7/WLHi3XxK/r4Rf0V26UDIbY2u
         Y/eUqpITEViM4v4mL2IMpZtAGqSMwAr/RgnFoMocMqNzAjATvRgVl6JOVP1dw+FBD0QB
         3b+hV3GcxEiMkNybmco1omHHFFaWgMhGfm4bcYtGYeVxqoreC94lNRU0jLCAH7UaM8QG
         4xsu9Aak74px/d75IwLJY4dYxFhAoNcZmxlz33/ELV7LRo1S+X8JCvCcMLXX2dp6KsCQ
         RisAcjmMxZwfO9JmkHvIT44MW/gtOj7+E6O2D3AbUIim1VLuCoe9unBXOhxHW9Sal47W
         FscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700069844; x=1700674644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9JaYSUMlUNj9iGPu8qtYwBLemqvJN+yaOMZ5z5lUk0=;
        b=kAuLDGLGhptlkO3tqo9RgBLq/z1YvjQiPIRp+c/IQVNuEFHbS8TG/yGC7pTUs1lq4z
         YNHtcrA2iaBx7B9748OnZonHDj8LrRRZipJOdBQXp2QblRTPBI54Ob4WbntkYIEEOPoV
         tZoPS3g/cUzmUybTqRzOeoGFjECbAC8ecMDzQZHuzcEitojRzHfUhxvsG620nsenfNw+
         GeYLkNFEsYoQmzBX0XWNzojJ704T/vfQkp1IGXJRedI55AtSrHVmI9CSOgi3oCmFcxAZ
         Aap67GBvxZOIphI4SILfxJgbIxT1w5O5Q7t/dc8cmy1HGG9Na/YsxZU6qbjcKM/m0hJO
         XyRg==
X-Gm-Message-State: AOJu0YxqEKg+fb9EAeOPkid8NSMrrhwZOyJX9YRIMnocRDbG6Wy+dEoC
        1/buit0wO/W1XciIOu5SHvQbVJ61aA==
X-Google-Smtp-Source: AGHT+IFNlFFy0WpWam+s42vhESabON0g8mxd8aqudGqTJhPoCP6Ef1zyCKu5eDBtXzPp9ZpO86b3WA==
X-Received: by 2002:a05:6808:448d:b0:3b2:e3e5:6b58 with SMTP id eq13-20020a056808448d00b003b2e3e56b58mr18468966oib.12.1700069844044;
        Wed, 15 Nov 2023 09:37:24 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b0077bda014d8esm3260099qkg.87.2023.11.15.09.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 09:37:23 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>, David.Laight@aculab.com,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 00/14] x86-64: Stack protector and percpu improvements
Date:   Wed, 15 Nov 2023 12:36:54 -0500
Message-ID: <20231115173708.108316-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, x86-64 uses an unusual percpu layout, where the percpu section
is linked at absolute address 0.  The reason behind this is that older GCC
versions placed the stack protector (if enabled) at a fixed offset from the
GS segment base.  Since the GS segement is also used for percpu variables,
this forced the current layout.

GCC since version 8.1 supports a configurable location for the stack
protector value, which allows removal of the restriction on how the percpu
section is linked.  This allows the percpu section to be linked
normally, like most other architectures.  In turn, this allows removal
of code that was needed to support the zero-based percpu section.

The major change with this iteration is adding support to objtool for
older compilers that can't change the location of the stackprotector
canary value.

v3:
- Add objtool suport to convert stackprotector code from older compilers.
- Handle R_X86_64_REX_GOTPCRELX relocations from clang
 
v2:
- Include PVH boot in GSBASE changes.
- Split out removal of 64-bit test script to give full context on why
  it's not needed anymore.
- Formatting and comment cleanups.

Brian Gerst (14):
  x86/stackprotector/32: Remove stack protector test script
  x86/stackprotector/64: Remove stack protector test script
  x86/boot: Disable stack protector for early boot code
  x86/pvh: Use fixed_percpu_data for early boot GSBASE
  x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
  objtool: Allow adding relocations to an existing section
  objtool: Convert fixed location stack protector accesses
  x86/stackprotector/64: Convert to normal percpu variable
  x86/percpu/64: Use relative percpu offsets
  x86/percpu/64: Remove fixed_percpu_data
  x86/boot/64: Remove inverse relocations
  x86/percpu/64: Remove INIT_PER_CPU macros
  percpu: Remove PER_CPU_FIRST_SECTION
  kallsyms: Remove KALLSYMS_ABSOLUTE_PERCPU

 arch/x86/Kconfig                          |  16 +--
 arch/x86/Makefile                         |  21 ++--
 arch/x86/boot/compressed/misc.c           |  14 +--
 arch/x86/entry/entry_64.S                 |   2 +-
 arch/x86/include/asm/percpu.h             |  22 ----
 arch/x86/include/asm/processor.h          |  28 +----
 arch/x86/include/asm/stackprotector.h     |  36 +-----
 arch/x86/kernel/Makefile                  |   2 +
 arch/x86/kernel/asm-offsets_64.c          |   6 -
 arch/x86/kernel/cpu/common.c              |   8 +-
 arch/x86/kernel/head_64.S                 |  20 ++-
 arch/x86/kernel/irq_64.c                  |   1 -
 arch/x86/kernel/setup_percpu.c            |  12 +-
 arch/x86/kernel/vmlinux.lds.S             |  35 ------
 arch/x86/platform/pvh/head.S              |  10 +-
 arch/x86/tools/relocs.c                   | 143 ++--------------------
 arch/x86/xen/xen-head.S                   |  10 +-
 include/asm-generic/vmlinux.lds.h         |   1 -
 include/linux/percpu-defs.h               |  12 --
 init/Kconfig                              |  11 +-
 kernel/kallsyms.c                         |  12 +-
 scripts/Makefile.lib                      |   2 +
 scripts/gcc-x86_32-has-stack-protector.sh |   8 --
 scripts/gcc-x86_64-has-stack-protector.sh |   4 -
 scripts/kallsyms.c                        |  80 +++---------
 scripts/link-vmlinux.sh                   |   4 -
 tools/objtool/arch/x86/decode.c           |  46 +++++++
 tools/objtool/arch/x86/special.c          |  88 +++++++++++++
 tools/objtool/builtin-check.c             |   9 +-
 tools/objtool/check.c                     |  14 ++-
 tools/objtool/elf.c                       | 133 ++++++++++++++++----
 tools/objtool/include/objtool/arch.h      |   3 +
 tools/objtool/include/objtool/builtin.h   |   2 +
 tools/objtool/include/objtool/elf.h       |  90 +++++++++++---
 34 files changed, 433 insertions(+), 472 deletions(-)
 delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh
 delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh

-- 
2.41.0

