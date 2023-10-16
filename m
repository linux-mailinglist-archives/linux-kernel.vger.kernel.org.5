Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D627CA64B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjJPLJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjJPLJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:09:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6808AB;
        Mon, 16 Oct 2023 04:09:14 -0700 (PDT)
Date:   Mon, 16 Oct 2023 11:09:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697454552;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DO/jszgKO0c4D8xdawhnlJ187SlWK3qG10hYY5gd9cs=;
        b=jiTuDnk9H4/WmuCMeVUU90NUskOH7wpr5GXxJJEJa4BsIgJekRbA4pL+objqZqxvWBZb9P
        wVWPbjF26R3y4YLSkjPKH0erJDATill+yelOB+HMIAsz350Cl2C5X2QCNTLX8k92V+4U72
        iDYDd3GpT38IpykWrqncSt8l5uLy7fg0S3CEBbLGq3FZJL7funzFqukT3kmGpq4wC8Hx9F
        4jA8HDBN+4jspH3QoTzbSr9MLxsDsGU9LJklvMg0voyd6mxg86SNHfiM78HwbZz8b7QOED
        gT2qpd074xe2Ycss9OCDYbOPJMS4CGSEh2Pt/OqH3ZA+wB5DNz29Yae+QvfhFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697454552;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DO/jszgKO0c4D8xdawhnlJ187SlWK3qG10hYY5gd9cs=;
        b=WnuHjy4ERMKQjDBKbenxwbepRvn67xU94M5bdXTK5C+4pwzsTvL1SylVdmHAmsWvMcVHH/
        xeMB5h/QmwOfBJCQ==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Use C for arch_raw_cpu_ptr(), to
 improve code generation
Cc:     Nadav Amit <namit@vmware.com>, Uros Bizjak <ubizjak@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231015202523.189168-2-ubizjak@gmail.com>
References: <20231015202523.189168-2-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169745455193.3135.696745948211732755.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     1d10f3aec2bb734b4b594afe8c1bd0aa656a7e4d
Gitweb:        https://git.kernel.org/tip/1d10f3aec2bb734b4b594afe8c1bd0aa656a7e4d
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Sun, 15 Oct 2023 22:24:40 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 16 Oct 2023 12:52:02 +02:00

x86/percpu: Use C for arch_raw_cpu_ptr(), to improve code generation

Implement arch_raw_cpu_ptr() in C to allow the compiler to perform
better optimizations, such as setting an appropriate base to compute
the address. The compiler is free to choose either MOV or ADD from
this_cpu_off address to construct the optimal final address.

There are some other issues when memory access to the percpu area is
implemented with an asm. Compilers can not eliminate asm common
subexpressions over basic block boundaries, but are extremely good
at optimizing memory access. By implementing arch_raw_cpu_ptr() in C,
the compiler can eliminate additional redundant loads from this_cpu_off,
further reducing the number of percpu offset reads from 1646 to 1631
on a test build, a -0.9% reduction.

Co-developed-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20231015202523.189168-2-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 915675f..5474690 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -49,6 +49,21 @@
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
+	tcp_ptr__ = __raw_cpu_read(, this_cpu_off);		\
+								\
+	tcp_ptr__ += (unsigned long)(ptr);			\
+	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
+})
+#else /* CONFIG_USE_X86_SEG_SUPPORT */
 /*
  * Compared to the generic __my_cpu_offset version, the following
  * saves one instruction and avoids clobbering a temp register.
@@ -63,6 +78,8 @@
 	tcp_ptr__ += (unsigned long)(ptr);			\
 	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
 })
+#endif /* CONFIG_USE_X86_SEG_SUPPORT */
+
 #else /* CONFIG_SMP */
 #define __percpu_seg_override
 #define __percpu_prefix		""
