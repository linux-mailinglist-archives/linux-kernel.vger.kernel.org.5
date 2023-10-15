Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAC27C9B6C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjJOUZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjJOUZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:25:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233B4B7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 13:25:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso622903066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 13:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697401536; x=1698006336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byi+rJWVYPv0yk6j35YrE2dkJDgxKKRYHdOnNqV3rg0=;
        b=aPLc9AhTdrRbuOS3oHZdiOXvrxfRng5AEJtVm2W/CjPTsviiPEdZKp6E2boVf54JoS
         LoM5NYu+6SiHoRDqC7tIx/bf67uNIJbbgq7a5UZA3kyqmhrn2MEsjRiRBIvEPkcEJs02
         5hjBrBmbFou0puddXgkPry2tuIljpJ7ggoONXSn6zTX7xXD/ScQbIuF0Ry71AAyt9VUb
         28LQCkPmZV0vg7Rblx+y9UjH92bYPRg6Zc9+myJUmx6imL2nZ1I5/If+npkr43YhI76L
         ORYa8cNGZOVvC3u8T4Fb3mO/B0SlR5un7iV1PJptKNT1uZjjmeNiQw1t5jwFjgwXXY0B
         EbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697401536; x=1698006336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byi+rJWVYPv0yk6j35YrE2dkJDgxKKRYHdOnNqV3rg0=;
        b=PHlNZw5xR72fxP7IKCc9DZHfMV6M4mYCKuzCeglmf7CfrXmp/vGXSo0zXmYQ+N485a
         bheObZtXo6cb5Uizufnv/hsB4icFaR2K/SnsZRT/c2lhnWwheVQCtioEdPgG/AOlAHWT
         RFAizpR5+1nruNGmHj+7kmZ77ucF/CSHNbEXy5UI5V2BbKScriUMXq7JvKV3hu6fzndO
         EyRW5ImTCdsD98daVp0fHqioZT5VTFsBU3qPeKr1KhjwsZ67AR0jsWMzyOc+qypmoTtJ
         doxTE0G+o1wCbPXDdz0BFBgRijgvSduZv7agNF/vr349nt3AAujrpQ0T/wdLiDcG1Qpl
         YqPA==
X-Gm-Message-State: AOJu0Yz4BC+Tz6gNRV35H+haQd2Vv6Vn3QHH+LsHtEC8oET9f1GZZ/ai
        FsAh19d2N5XLazuGQ8RWJ+A=
X-Google-Smtp-Source: AGHT+IEHCXS4sPtNCXzWSLhl+kpUlP/lLXOnBZjVTxWWL25y2Y/vYdKZ6PLWhDX4XY4+5SJlbaUcDw==
X-Received: by 2002:a17:906:8b:b0:9b2:b149:b81a with SMTP id 11-20020a170906008b00b009b2b149b81amr31570078ejc.64.1697401536137;
        Sun, 15 Oct 2023 13:25:36 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709067d9700b009b97d9ae329sm2686943ejo.198.2023.10.15.13.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 13:25:35 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH -tip 3/3] x86/percpu: *NOT FOR MERGE* Implement arch_raw_cpu_ptr() with RDGSBASE
Date:   Sun, 15 Oct 2023 22:24:41 +0200
Message-ID: <20231015202523.189168-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231015202523.189168-1-ubizjak@gmail.com>
References: <20231015202523.189168-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*EXPERIMENTAL PATCH, NOT FOR MERGE*

The patch introduces 'rdgsbase' alternative for CPUs with
X86_FEATURE_FSGSBASE. The rdgsbase instruction *probably* will end up
only decoding in the first decoder etc. But we're talking single-cycle
kind of effects, and the rdgsbase case should be much better from
a cache perspective and might use fewer memory pipeline resources to
offset the fact that it uses an unusual front end decoder resource...

The drawback of the patch is also larger binary size:

   text    data     bss     dec     hex filename
25549518        4388100  808452 30746070        1d525d6 vmlinux-new.o
25523192        4388212  808452 30719856        1d4bf70 vmlinux-old.o

that increases by 25.7k (0.103%), due to 1578 rdgsbase altinstructions
that are placed in the text section. The increase in text-size is not
"real" - the 'rdgsbase' instruction should be smaller than a 'mov %gs';
binary size increases because we obviously have two instructions, but
the actual *executable* part likely stays the same, and it's just that
we grow the altinstruction metadata.

Sean says:

"A significant percentage of data accesses in Intel's TDX-Module[*] use
this pattern, e.g. even global data is relative to GS.base in the module
due its rather odd and restricted environment.  Back in the early days
of TDX, the module used RD{FS,GS}BASE instead of prefixes to get
pointers to per-CPU and global data structures in the TDX-Module.  It's
been a few years so I forget the exact numbers, but at the time a single
transition between guest and host would have something like ~100 reads
of FS.base or GS.base.  Switching from RD{FS,GS}BASE to prefixed accesses
reduced the latency for a guest<->host transition through the TDX-Module
by several thousand cycles, as every RD{FS,GS}BASE had a latency of
~18 cycles (again, going off 3+ year old memories).

The TDX-Module code is pretty much a pathological worth case scenario,
but I suspect its usage is very similar to most usage of raw_cpu_ptr(),
e.g. get a pointer to some data structure and then do multiple
reads/writes from/to that data structure.

The other wrinkle with RD{FS,FS}GSBASE is that they are trivially easy
to emulate. If a hypervisor/VMM is advertising FSGSBASE even when it's
not supported by hardware, e.g. to migrate VMs to older hardware, then
every RDGSBASE will end up taking a few thousand cycles
(#UD -> VM-Exit -> emulate).  I would be surprised if any hypervisor
actually does this as it would be easier/smarter to simply not advertise
FSGSBASE if migrating to older hardware might be necessary, e.g. KVM
doesn't support emulating RD{FS,GS}BASE.  But at the same time, the whole
reason I stumbled on the TDX-Module's sub-optimal RD{FS,GS}BASE usage was
because I had hacked KVM to emulate RD{FS,GS}BASE so that I could do KVM
TDX development on older hardware.  I.e. it's not impossible that this
code could run on hardware where RDGSBASE is emulated in software.

{RD,WR}{FS,GS}BASE were added as faster alternatives to {RD,WR}MSR,
not to accelerate actual accesses to per-CPU data, TLS, etc.  E.g.
loading a 64-bit base via a MOV to FS/GS is impossible.  And presumably
saving a userspace controlled by actually accessing FS/GS is dangerous
for one reason or another.

The instructions are guarded by a CR4 bit, the ucode cost just to check
CR4.FSGSBASE is probably non-trivial."

Cc: Sean Christopherson <seanjc@google.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/percpu.h | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 54746903b8c3..e047a0bc5554 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -49,36 +49,31 @@
 #define __force_percpu_prefix	"%%"__stringify(__percpu_seg)":"
 #define __my_cpu_offset		this_cpu_read(this_cpu_off)
 
-#ifdef CONFIG_USE_X86_SEG_SUPPORT
-/*
- * Efficient implementation for cases in which the compiler supports
- * named address spaces.  Allows the compiler to perform additional
- * optimizations that can save more instructions.
- */
+#ifdef CONFIG_X86_64
 #define arch_raw_cpu_ptr(ptr)					\
 ({								\
 	unsigned long tcp_ptr__;				\
-	tcp_ptr__ = __raw_cpu_read(, this_cpu_off);		\
+	asm (ALTERNATIVE("movq " __percpu_arg(1) ", %0",	\
+			 "rdgsbase %0",				\
+			 X86_FEATURE_FSGSBASE)			\
+	     : "=r" (tcp_ptr__)					\
+	     : "m" (__my_cpu_var(this_cpu_off)));		\
 								\
 	tcp_ptr__ += (unsigned long)(ptr);			\
 	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
 })
-#else /* CONFIG_USE_X86_SEG_SUPPORT */
-/*
- * Compared to the generic __my_cpu_offset version, the following
- * saves one instruction and avoids clobbering a temp register.
- */
+#else /* CONFIG_X86_64 */
 #define arch_raw_cpu_ptr(ptr)					\
 ({								\
 	unsigned long tcp_ptr__;				\
-	asm ("mov " __percpu_arg(1) ", %0"			\
+	asm ("movl " __percpu_arg(1) ", %0"			\
 	     : "=r" (tcp_ptr__)					\
 	     : "m" (__my_cpu_var(this_cpu_off)));		\
 								\
 	tcp_ptr__ += (unsigned long)(ptr);			\
 	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
 })
-#endif /* CONFIG_USE_X86_SEG_SUPPORT */
+#endif /* CONFIG_X86_64 */
 
 #else /* CONFIG_SMP */
 #define __percpu_seg_override
-- 
2.41.0

