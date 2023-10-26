Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91D67D865D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345505AbjJZQBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbjJZQB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:01:29 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D701B2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:01:25 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7ac4c3666so8104627b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698336084; x=1698940884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t1bUUN6vHuW7FqswnSb6NfkZGgmml0e1Kvzb5bPNt6Y=;
        b=NjO0b99U+CkAzI4czFyyowtNpz8IhXHeGabO2hvU1XgM5bHmkcE1RFXbTaSP8NqXWY
         t2x7k1a0+on2xtU2dYLOzaA7FeZ4fkEVFjJSQxCqiQRkhC+k3mT90fxqCxzLCQI/0xcm
         5w2s9/kGqXgcOwHxyUNA9eogYlRDL94MfjtDmRzZzcbtFZQqMGmNcuE3tQqq2PEnGYBj
         xOUJ19WooaRRng6nwnZifthIS4tVbAZ3/cc/+Uam7VMCpBx9iMEsX4QmhlD488FuccOE
         ZXiDIBpzsMhYTGQWIoG91/KmTa9V/iHWJNd9SIlvVY3S73LLLoQ1lwzX1awAwqg9M5du
         0Fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698336084; x=1698940884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1bUUN6vHuW7FqswnSb6NfkZGgmml0e1Kvzb5bPNt6Y=;
        b=lfexUm5aZeJDv91Jp7rE3kGkCbZjSXNJm8sj8M9iMV5j9ZFU2mWiT5KYZqqgS2Gf10
         tTJcx1nUTSMeaowNTjsI0+QVf6ykHh2EJOj+Fw+noCBNFm8uszaAWcqlqekqnqLs0KM7
         P0V7x2Ovr76z84QSDwQTMXiEP1hFyX6bqnUHAqpCyh0c6TSFCsmZgNY8O3m8rCs1opMh
         TYonWjjk2wX9IsgyxvpcfS3oVUHqb5VXhKFeDqVoT28mP0cU5WO5pYI9hn1+/K28YiDh
         /cR/5ogD7Nh8p+WLb7dHgPYhHE7o579fgJp5yamhjnUCk5Hx7VmUaQixrXQ+g/flEJm7
         pMjQ==
X-Gm-Message-State: AOJu0YxJ+IiY1GmZMk37YpCwIhLlY1BklfNSbXtq3eOF8+tWJH/S/ju9
        byTrGpztc48sdbCuITgY3Ecn/NZfWA==
X-Google-Smtp-Source: AGHT+IHvwTxWwLMKznOWOqy+m4C6RFGAazhUOpelKRMe8KIH4lmbE9nLfkeuX0X4DAolE4eADiJQqg==
X-Received: by 2002:a05:690c:ecf:b0:58e:fa3c:9401 with SMTP id cs15-20020a05690c0ecf00b0058efa3c9401mr23091144ywb.12.1698336084605;
        Thu, 26 Oct 2023 09:01:24 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id a71-20020a0dd84a000000b005a20ab8a184sm6130129ywe.31.2023.10.26.09.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:01:24 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 00/11] x86-64: Stack protector and percpu improvements
Date:   Thu, 26 Oct 2023 12:00:49 -0400
Message-ID: <20231026160100.195099-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
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

v2:
- Include PVH boot in GSBASE changes.
- Split out removal of 64-bit test script to give full context on why
  it's not needed anymore.
- Formatting and comment cleanups.

Brian Gerst (11):
  x86/stackprotector/32: Remove stack protector test script
  x86/stackprotector/64: Remove stack protector test script
  x86/boot: Disable stack protector for early boot code
  x86/pvh: Use fixed_percpu_data for early boot GSBASE
  x86/stackprotector/64: Convert stack protector to normal percpu
    variable
  x86/percpu/64: Remove fixed_percpu_data
  x86/percpu/64: Use relative percpu offsets
  x86/boot/64: Remove inverse relocations
  x86/percpu/64: Remove INIT_PER_CPU macros
  percpu: Remove PER_CPU_FIRST_SECTION
  kallsyms: Remove KALLSYMS_ABSOLUTE_PERCPU

 arch/x86/Kconfig                          |   7 +-
 arch/x86/Makefile                         |  19 +--
 arch/x86/boot/compressed/misc.c           |  14 +--
 arch/x86/entry/entry_64.S                 |   2 +-
 arch/x86/include/asm/percpu.h             |  22 ----
 arch/x86/include/asm/processor.h          |  28 +----
 arch/x86/include/asm/stackprotector.h     |  37 ++----
 arch/x86/kernel/Makefile                  |   2 +
 arch/x86/kernel/asm-offsets_64.c          |   6 -
 arch/x86/kernel/cpu/common.c              |   8 +-
 arch/x86/kernel/head_64.S                 |  10 +-
 arch/x86/kernel/irq_64.c                  |   1 -
 arch/x86/kernel/setup_percpu.c            |  12 +-
 arch/x86/kernel/vmlinux.lds.S             |  35 ------
 arch/x86/platform/pvh/head.S              |   4 +-
 arch/x86/tools/relocs.c                   | 136 +---------------------
 arch/x86/xen/xen-head.S                   |   6 +-
 include/asm-generic/vmlinux.lds.h         |   1 -
 include/linux/percpu-defs.h               |  12 --
 init/Kconfig                              |  11 +-
 kernel/kallsyms.c                         |  12 +-
 scripts/gcc-x86_32-has-stack-protector.sh |   8 --
 scripts/gcc-x86_64-has-stack-protector.sh |   4 -
 scripts/kallsyms.c                        |  80 +++----------
 scripts/link-vmlinux.sh                   |   4 -
 25 files changed, 61 insertions(+), 420 deletions(-)
 delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh
 delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh

-- 
2.41.0

