Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB917C01DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjJJQnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjJJQnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:43:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D16697
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:42:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53627feca49so9804420a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696956178; x=1697560978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E+NYW0H/78mpIgnIj6WGSptNiQypZq9GKR0ivlCmwmg=;
        b=R0h13VOLr/fu2AXtLqOb3I5EdOvRXUYdJoNKLE87p2KZ2Hn92zwRP4q9PzsDez3oby
         8RvNchu3nRQBrYpR2pGtYnziFZef4U7m8694tDaurtLYQQ86plrchUPVjfocwzoa7tRa
         UI209GgjmkEaRHBJOP4+2ODqWYfXOu2T3pUASP4Xdx7/96qmUh74y/YtRDPBoYi/5+Hx
         7iMvoI6HCQbJEwtvee8rJBWyNf4d7t/Vqok2xLcrSU4EFH9BWMz48BzFk8few6qqM6Cd
         JNIv8HRPiSO9Y8hyFV6PiuB9E4EhiL3/EE45HhfKAC2aqmXhTnJPy/aRN5VQjFvYB31d
         QUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696956178; x=1697560978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+NYW0H/78mpIgnIj6WGSptNiQypZq9GKR0ivlCmwmg=;
        b=bKFGFXM0TX5etEoOJO9WtVig0zEuzKoFwsLgIMJJMTCiIelxeDJYbJJdjDS8mqPB3a
         HuC4kwGM8VM/lIj1+dXHgkL38VqAmWZuJFCXB5Kj19B9LnenFVDII4y6A3VnAMHPccCK
         eHyliorLFkvPfXZorNDhwU7/kyJMXZtqAfGmGz/aYy7JPyH1aUa44elvbUKpUUfcQ9cT
         uiv5Jzpu1Q3IuiidgY7BgK5jt5Xve/PfPr9D7D6zscAtTVLm3Xt5uAjtjaNg1n1UlaLU
         dvPkp8lKiSsgFAJhQ0RYGl4iO0z81XD3QfjMHhHMqoo5jTSBY5UxEhD4ZU2bRkwd0E1t
         UpbQ==
X-Gm-Message-State: AOJu0YyWsoAtRSP6BPUgpp+zF6IAJTlOb4OJT/MqP1zXcWqL+z4j6eRy
        9J2QlMVv1Om3sIIYDvg2beM=
X-Google-Smtp-Source: AGHT+IGkKxxNPZTgZFSK+6SQI29JmPT9zoFi1y/tuylA4GxlTJLUW4HnXKHpGWntfaedFnMDqJ4RpA==
X-Received: by 2002:a17:906:cb:b0:9ae:4eb7:ae8b with SMTP id 11-20020a17090600cb00b009ae4eb7ae8bmr18984075eji.7.1696956177615;
        Tue, 10 Oct 2023 09:42:57 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ks8-20020a170906f84800b00982a92a849asm8668525ejb.91.2023.10.10.09.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 09:42:57 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Date:   Tue, 10 Oct 2023 18:42:29 +0200
Message-ID: <20231010164234.140750-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Implementing arch_raw_cpu_ptr() in C, allows the compiler to perform
better optimizations, such as setting an appropriate base to compute
the address instead of an add instruction.

E.g.: address calcuation in amd_pmu_enable_virt() improves from:

    48 c7 c0 00 00 00 00 	mov    $0x0,%rax
	87b7: R_X86_64_32S	cpu_hw_events

    65 48 03 05 00 00 00 	add    %gs:0x0(%rip),%rax
    00
	87bf: R_X86_64_PC32	this_cpu_off-0x4

    48 c7 80 28 13 00 00 	movq   $0x0,0x1328(%rax)
    00 00 00 00

to:

    65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax
    00
	8798: R_X86_64_PC32	this_cpu_off-0x4
    48 c7 80 00 00 00 00 	movq   $0x0,0x0(%rax)
    00 00 00 00
	87a6: R_X86_64_32S	cpu_hw_events+0x1328

Co-developed-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/percpu.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 60ea7755c0fe..cdc188279c5a 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -49,6 +49,19 @@
 #define __force_percpu_prefix	"%%"__stringify(__percpu_seg)":"
 #define __my_cpu_offset		this_cpu_read(this_cpu_off)
 
+#ifdef CONFIG_USE_X86_SEG_SUPPORT
+/*
+ * Efficient implementation for cases in which the compiler supports
+ * named address spaces.  Allows the compiler to perform additional
+ * optimizations that can save more instructions.
+ */
+#define arch_raw_cpu_ptr(ptr)					\
+({								\
+	unsigned long tcp_ptr__;				\
+	tcp_ptr__ = __raw_cpu_read(, this_cpu_off) + (unsigned long)(ptr); \
+	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
+})
+#else /* CONFIG_USE_X86_SEG_SUPPORT */
 /*
  * Compared to the generic __my_cpu_offset version, the following
  * saves one instruction and avoids clobbering a temp register.
@@ -61,6 +74,8 @@
 	     : "m" (__my_cpu_var(this_cpu_off)), "0" (ptr));	\
 	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
 })
+#endif /* CONFIG_USE_X86_SEG_SUPPORT */
+
 #else /* CONFIG_SMP */
 #define __percpu_seg_override
 #define __percpu_prefix		""
-- 
2.41.0

