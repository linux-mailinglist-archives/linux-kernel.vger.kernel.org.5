Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1F67D418E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjJWVRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjJWVRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:17:39 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074EB10A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:17:38 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6ce2988d62eso2416994a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698095857; x=1698700657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RjuCpZkTOQea0lODerpoBhUBPsuFVkeaJK9dO2sch2U=;
        b=P8nEBo+/FJO88zARo8MrYpwquNuXA5LnkT+jrDoVzglCyxNYnJFmc49OFTC1KYEFmT
         AeO16lxgOcdCdtfv2ceLGFyNE37AkB+0xhSniRD+uiPvq1t6XtpugE0vxF+2T7FRCXi5
         ZDNd3rtRlT7fr8/g0kywJkBOWxfMj3Y0TZO1HQCZ55hesLsQOuQAm6YCE1rAEluEBiM6
         v6jLSsn19zN69j+HtbkvuT/V/ZUSIiktvQ4PUecCbRa/QxDfMXYqiUC6BqroDqXDdWLq
         k6pyEZXdpoPjqOsWJQMjjDDZaEdA4W7d7/jEvAn4RZWuh2fFLgKNbXEc4S5SPmu1I4X8
         t3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698095857; x=1698700657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjuCpZkTOQea0lODerpoBhUBPsuFVkeaJK9dO2sch2U=;
        b=PpIMeFaHMQiY8at7ohkRcfzCDduzv/I+tgVjSKUL+8mO5lnM0jczPbCWp1fWh12WoS
         m/B3Km5tOaynV7U4nq97z/tCNc2c16XXGDxzMgbqSAxmD5K/c6PkEz52b11Nn6LKvhZx
         n3Ozp4g5gkoscwp2pje32lEAQvytPU06zDDIgVlS6Pbfayjwe3MSjBegT4kct1VaZvR/
         8+H1iGwtW4Ct0LaMWO3FjjtLBjCkz7RzKKu3glkp87JQt2j/NCqpiu1NCincjq1vFXOX
         Wkw0Pb5Wk6KJGZ0t/c4Bkf6zX7ReE4k+VHzjQ9VsspNqVGWuAGfNB+PASI381U6pP+9E
         GOUA==
X-Gm-Message-State: AOJu0Yxl13hVnek1cLytYQXP21QEswbRjY5gfWQzDEFE0piig46OQcVk
        s1cRS8Vgg997Dd79ayK7y/m9bDK9RA==
X-Google-Smtp-Source: AGHT+IHPczHusIo0syP63L85pDXFu9VHkCbL4GggPRnet55dLTKKwgYLPLohQCSMK3b2EOsc6wWbPw==
X-Received: by 2002:a9d:6a13:0:b0:6bf:df:66d5 with SMTP id g19-20020a9d6a13000000b006bf00df66d5mr10673224otn.35.1698095856874;
        Mon, 23 Oct 2023 14:17:36 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id o139-20020a0dcc91000000b00583e52232f1sm3485430ywd.112.2023.10.23.14.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:17:36 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 0/9] x86-64: Stack protector and percpu improvements
Date:   Mon, 23 Oct 2023 17:17:21 -0400
Message-ID: <20231023211730.40566-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, x86-64 uses an unusual per-cpu layout, where the percpu section
is linked at absolute address 0.  The reason behind this is that older GCC
versions placed the stack protector (if enabled) at a fixed offset from the
GS segment base.  Since the GS segement is also used for percpu variables,
this forced the current layout.

GCC since version 8.1 supports a configurable location for the stack
protector value, which allows removal of the restriction on how the percpu
section is linked.  This allows the percpu section to be linked
normally, like most other architectures.  In turn, this allows removal
of code that was needed to support the zero-based percpu section.

P.S.:  I posted this series back in 2021, and at the time it appeared that
GCC 8.1 was too recent (released May 2, 2018) to be a requirement to keep
stack protector support.  Two years later, support for the new compiler
options should be much more widespread.

Brian Gerst (9):
  x86/stackprotector/32: Remove stack protector test script
  x86/boot: Disable stack protector for early boot code
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
 24 files changed, 60 insertions(+), 417 deletions(-)
 delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh
 delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh

-- 
2.41.0

