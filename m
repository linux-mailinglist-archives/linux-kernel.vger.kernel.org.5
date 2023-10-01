Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B187B478A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbjJANQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbjJANQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:16:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFF0B7
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:16:36 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso2171841566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 06:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696166195; x=1696770995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=utaYa8TToXgtZfLZe7a7LnNsIVzGY6WBq/HmTDXvJtA=;
        b=clV2U5utmyK03kvnY77srX72IyPBvKIVFfMIsfFnhtTnAoT/RJKdrzBHGxOzKrbBJ/
         QN+B2wgxU92+rsY3+Pv2hCcoRx3VkMwUIVS3Sn4RU3Tp/dTFcBK0/DbvSiuZoLH0DTjy
         vHXlj+31g4hNRotGHbDi6/a4wdN1pixmjvO+2zurWFABCUURaV/OXaWkBCVy5hnQEbJL
         UBPa+j40LjJsps20SwQdFdQ43Cp4sxuqvG8hl/55HbfMeQTui1gBmFaM8F3rASzbwL1U
         84qFxoaq39hss8QAYFxIk+Yy1V2Q8ARhrpBR6g1sXpjz3RD74hjIgqq289tXjkd9Fu+X
         tdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696166195; x=1696770995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utaYa8TToXgtZfLZe7a7LnNsIVzGY6WBq/HmTDXvJtA=;
        b=IPvy59hZmcQZQt8LsgkIVMEzDs6qLa7YdFqtozV85TqBkqlYRz/Xtdhq/t8k/v/T9y
         iTAKl8lpyfdT6OUF/iOJs0q/LKGJPMJkvSPQ6aCt/8nknmDgMvZ4WQHQ26TUb8+hchhw
         gz34lmyzBudVjc67b9lBpz14uHo3jNnEOcKdiuWn/lzqzxTB3p7HzpQMR7MXhmtsIu5s
         L/kcaLvG9nW3RYeecCqx4ffmAHy+mo4J/r3vMumqe10QSd/yXoCJp97n3536h/3Zg3re
         HhccwyTSXWS3jys1HGTVrOmzNHWRO7IFbo5Lw1DP1udf9OH0X8+nx2QmgtQeu/BajWYn
         Q2ww==
X-Gm-Message-State: AOJu0YwrsvhDGoDGtiuaiQa4amAr2z25iKmswi0jtbvp1VYdlWVlSWw9
        h0Qw9wod1EiR0SiAmZUPyC4=
X-Google-Smtp-Source: AGHT+IEvqaxAZc59UdggaHi4AvFk0uHPDupKYoqFt3Ci03MMKulh7ovHY0yuOEHvtm7UmWuHhlWamA==
X-Received: by 2002:a17:906:eb82:b0:9ae:69b3:3e18 with SMTP id mh2-20020a170906eb8200b009ae69b33e18mr8588220ejb.25.1696166195028;
        Sun, 01 Oct 2023 06:16:35 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id lv23-20020a170906bc9700b0099d798a6bb5sm15504272ejb.67.2023.10.01.06.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 06:16:34 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC PATCH 0/4] x86/percpu: Use segment qualifiers
Date:   Sun,  1 Oct 2023 15:14:32 +0200
Message-ID: <20231001131620.112484-1-ubizjak@gmail.com>
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

This patchset resurrect the work of Richard Henderson [1] and Nadav Amit [2]
to introduce named address spaces compiler extension [3,4] into the linux kernel.

On the x86 target, variables may be declared as being relative to the %fs or %gs segments.

__seg_fs
__seg_gs

The object is accessed with the respective segment override prefix.

The following patchset takes a bit more cautious approach and converts only moves,
currently implemented as an asm, to generic moves to/from named address space. The
compiler is then able to propagate memory arguments into instructions that use these
memory references, producing more compact assembly, in addition to avoiding using
a register as a temporary to hold value from the memory.

The patchset enables propagation of hundreds of memory arguments, resulting in
the cumulative code size reduction of 7.94kB (please note that the kernel is
compiled with -O2, so the code size is not entirely correct measure; some
parts of the code can now be duplicated for better performance due to -O2,
etc...).

Some examples of propagations:

a) into sign/zero extensions:

 110b54:       65 0f b6 05 00 00 00    movzbl %gs:0x0(%rip),%eax
 11ab90:       65 0f b6 15 00 00 00    movzbl %gs:0x0(%rip),%edx
 14484a:       65 0f b7 35 00 00 00    movzwl %gs:0x0(%rip),%esi
 1a08a9:       65 0f b6 43 78          movzbl %gs:0x78(%rbx),%eax
 1a08f9:       65 0f b6 43 78          movzbl %gs:0x78(%rbx),%eax

 4ab29a:       65 48 63 15 00 00 00    movslq %gs:0x0(%rip),%rdx
 4be128:       65 4c 63 25 00 00 00    movslq %gs:0x0(%rip),%r12
 547468:       65 48 63 1f             movslq %gs:(%rdi),%rbx
 5474e7:       65 48 63 0a             movslq %gs:(%rdx),%rcx
 54d05d:       65 48 63 0d 00 00 00    movslq %gs:0x0(%rip),%rcx

b) into compares:

 b40804:       65 f7 05 00 00 00 00    testl  $0xf0000,%gs:0x0(%rip)
 b487e8:       65 f7 05 00 00 00 00    testl  $0xf0000,%gs:0x0(%rip)
 b6f14c:       65 f6 05 00 00 00 00    testb  $0x1,%gs:0x0(%rip)
 bac1b8:       65 f6 05 00 00 00 00    testb  $0x1,%gs:0x0(%rip)
 df2244:       65 f7 05 00 00 00 00    testl  $0xff00,%gs:0x0(%rip)

 9a7517:       65 80 3d 00 00 00 00    cmpb   $0x0,%gs:0x0(%rip)
 b282ba:       65 44 3b 35 00 00 00    cmp    %gs:0x0(%rip),%r14d
 b48f61:       65 66 83 3d 00 00 00    cmpw   $0x8,%gs:0x0(%rip)
 b493fe:       65 80 38 00             cmpb   $0x0,%gs:(%rax)
 b73867:       65 66 83 3d 00 00 00    cmpw   $0x8,%gs:0x0(%rip)

c) into other insns:

 65ec02:       65 0f 44 15 00 00 00    cmove  %gs:0x0(%rip),%edx
 6c98ac:       65 0f 44 15 00 00 00    cmove  %gs:0x0(%rip),%edx
 9aafaf:       65 0f 44 15 00 00 00    cmove  %gs:0x0(%rip),%edx
 b45868:       65 0f 48 35 00 00 00    cmovs  %gs:0x0(%rip),%esi
 d276f8:       65 0f 44 15 00 00 00    cmove  %gs:0x0(%rip),%edx

The above propagations result in the following code size
improvements for current mainline kernel (with the default config),
compiled with

gcc (GCC) 12.3.1 20230508 (Red Hat 12.3.1-1)

   text    data     bss     dec     hex filename
25508862        4386540  808388 30703790        1d480ae vmlinux-vanilla.o
25500922        4386532  808388 30695842        1d461a2 vmlinux-new.o

The conversion of other read-modify-write instructions does not bring us any
benefits, the compiler has some problems when constructing RMW instructions
from the generic code and easily misses some opportunities.

There are other optimizations possible involving arch_raw_cpu_ptr and
aggressive caching of current that are implemented in the original
patch series. These can be implemented as follow-ups at some later
time.

The patcshet was tested on Fedora 38 with kernel 6.5.5 and gcc 13.2.1
(In fact, I'm writing this message on the patched kernel.)

[1] https://lore.kernel.org/lkml/1454483253-11246-1-git-send-email-rth@twiddle.net/
[2] https://lore.kernel.org/lkml/20190823224424.15296-1-namit@vmware.com/
[3] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html
[4] https://clang.llvm.org/docs/LanguageExtensions.html#target-specific-extensions

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>

Uros Bizjak (4):
  x86/percpu: Update arch/x86/include/asm/percpu.h to the current tip
  x86/percpu: Detect compiler support for named address spaces
  x86/percpu: Use compiler segment prefix qualifier
  x86/percpu: Use C for percpu read/write accessors

 arch/x86/Kconfig               |   7 +
 arch/x86/include/asm/percpu.h  | 237 ++++++++++++++++++++++++++++-----
 arch/x86/include/asm/preempt.h |   2 +-
 3 files changed, 209 insertions(+), 37 deletions(-)

-- 
2.41.0

