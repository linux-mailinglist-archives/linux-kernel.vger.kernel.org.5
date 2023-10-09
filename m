Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246E77BEB9F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377896AbjJIUbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346674AbjJIUbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:31:45 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2616DAF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:31:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9936b3d0286so892237066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 13:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696883501; x=1697488301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V9TaY+1/D3Blq76vaecFciRsnp/iTpZr7tVAbHJ+j0I=;
        b=UsWz9cE2zv1NSlSUab41KnOqCHGQBOSbxI5ojryqkvhhJ9js11myRvegScTxHTEF5X
         zYTS2iCsswq14XoGueeSZ6xmYXcqieWSVpLj1ODkiy6AbTk34IK2o1c7a5QsJ7VCEp1D
         VhMoLnP55nSEjIN+Y+o3TZhUYGFCQ0cix8+ixIpbHKLD5Z04XODd0/Ej11xWHytqMtod
         7hjGRN7Tm0y1CeNqpBMnWatliZRnCQK2NjfYcvoWGC2oL/za+0I+TYMogR353FcI1tGm
         OSnOTopmafS4NZV/QHFw7jbecSyTCyRBD5dpMMPT8ha9KRpoH/B+vFV1G5erm+Nn/Ll0
         vW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696883501; x=1697488301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9TaY+1/D3Blq76vaecFciRsnp/iTpZr7tVAbHJ+j0I=;
        b=nzLNymjSbRQpbJBIkNtbcF4GatmYIH81o/87oXVIlKGJiedk7D9pRP8WqaZ3+aOVwh
         BNIwjLtXsU39ScDTbdUFBDanODpM0A0IWNr0kRXhwq2VFT48n+FphJjKfOXtImnJ1tVP
         vQZVRSOQAXIvU97YaZHxzJEWLkF+/aa/PQ+qmaLu2UmQS+mhj6Y7BnOpB3smMXwnOWtj
         AkwOlprWyQC0ul5nMBhO6D63jL/BEuNBY3jb+1K0Ts3ivltbskM7k228/wQNxa1VrRO3
         4ANNtFW4H1ftsuD/+PkE70kXe7yX0ev6WGxt7ar5PzoGz94fq2R+CAcIZJf1EBO4gaoj
         znUQ==
X-Gm-Message-State: AOJu0YyDm2hx0739uzoDw/xkMVDpqsRdeS9OGjm7NjxLEdFPUeRucgeG
        XfX0Xe3pUAINJ/h7oVhqHho=
X-Google-Smtp-Source: AGHT+IGQmeHU7DgdWHS0ezKAtRqO1ga8ziJik+enp1NhMJU1PtwcJiJ7z58UuX3JcZznOmETIfL/Ng==
X-Received: by 2002:a17:906:221c:b0:9a5:b876:b1e3 with SMTP id s28-20020a170906221c00b009a5b876b1e3mr13674670ejs.20.1696883501377;
        Mon, 09 Oct 2023 13:31:41 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id l12-20020a170906078c00b009b94fe3fc47sm7153601ejc.159.2023.10.09.13.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 13:31:41 -0700 (PDT)
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
Subject: [PATCH tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Date:   Mon,  9 Oct 2023 22:29:33 +0200
Message-ID: <20231009203132.82773-1-ubizjak@gmail.com>
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
 arch/x86/include/asm/percpu.h | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 60ea7755c0fe..aa48c061abd9 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -39,16 +39,23 @@
 
 #define __percpu_prefix		""
 
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
+
 #else /* CONFIG_CC_HAS_NAMED_AS */
 
 #define __percpu_seg_override
 #define __percpu_prefix		"%%"__stringify(__percpu_seg)":"
 
-#endif /* CONFIG_CC_HAS_NAMED_AS */
-
-#define __force_percpu_prefix	"%%"__stringify(__percpu_seg)":"
-#define __my_cpu_offset		this_cpu_read(this_cpu_off)
-
 /*
  * Compared to the generic __my_cpu_offset version, the following
  * saves one instruction and avoids clobbering a temp register.
@@ -61,6 +68,12 @@
 	     : "m" (__my_cpu_var(this_cpu_off)), "0" (ptr));	\
 	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
 })
+
+#endif /* CONFIG_CC_HAS_NAMED_AS */
+
+#define __force_percpu_prefix	"%%"__stringify(__percpu_seg)":"
+#define __my_cpu_offset		this_cpu_read(this_cpu_off)
+
 #else /* CONFIG_SMP */
 #define __percpu_seg_override
 #define __percpu_prefix		""
-- 
2.41.0

