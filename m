Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C19980284D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 23:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjLCWL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 17:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCWL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 17:11:56 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD07D7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 14:12:01 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3316c6e299eso3316772f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 14:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701641520; x=1702246320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vjaWk/H6fGuuhYYTA47sTH4UdRNJkcMj7wuTjo7KtFY=;
        b=dhh2gu4Nakycu7CZMnasfriLEScoXJd7p4HHJIwIz9eLZunuosEGd9HlBMrlAvOWN5
         ouWU9wFXIQDeEaDKptTwk9QZcN+OvjmQzChcxCU5Ev5FzJZk65z7Xxq0mViVoOfBNcf8
         8VlCG9SAYsaEnokOdUhM3Co72LHdDnSRib+hpgiAX9SUGb+GH3cz4z73p29Dmq8/qEre
         wWl2oEXXUuA/EzxnCVX9yvrZ2RS1Dw/5zl5jP7py152cdUdG6dv1YTzXzVHnL2uP+V2g
         ENG7WVUoV5grcjEtX20F4wxm2Fc9kMJfZdpc2/D6cx0Brv6ZI8uVcsW3nCGUl9Wosy+V
         ereQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701641520; x=1702246320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjaWk/H6fGuuhYYTA47sTH4UdRNJkcMj7wuTjo7KtFY=;
        b=I5oAKoKklWQYtR7vTOfraf45ooFp0R1Ot0XVL4UKgJ79uj3pWjwclV8ZKgBNONVrop
         AlJClxjHTYQA4q6dH8c2hTPZhlp2s86bqmgQhhVtLPebkzfYjEuubrufX3IajNRRV4bb
         s19odWc/CCYWtuLfWPVYSDZs0vFdFwgR7dTX4mi6xiDxICGWPPvzu5RjJNGWbW6R4WRb
         QSvAmZVhC4jFq7KLeXGbCTjA0L7vIeTG5oZnBNRUmC8HpZpvtpdZ7aALfQ4ph5ia6WqX
         e0fBt45EnjAJQgCF8dq89wAPOOJWgKt5tMs+1PwDmxWLOKH9fOHfCs9kMqT+0KHdSBPp
         FevQ==
X-Gm-Message-State: AOJu0Yzzzj4KUWn3vbVPXFXP/k8TTeo7MVxGdUlVGy1/Q7TloMCxMkBU
        RO50n8ThNHUvrPvt1AJzhEY=
X-Google-Smtp-Source: AGHT+IHAG5WAygFzB0AUCfTycsHgZ/nbf7FHAz30D+9nE6Ov0+GHNuMPBI5ryITBN+6HVsQdCmTEXQ==
X-Received: by 2002:a05:600c:43d4:b0:40c:91f:506e with SMTP id f20-20020a05600c43d400b0040c091f506emr507792wmn.126.1701641519870;
        Sun, 03 Dec 2023 14:11:59 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ay10-20020a05600c1e0a00b0040b397787d3sm16589181wmb.24.2023.12.03.14.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 14:11:59 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH -tip 1/3] x86/percpu: Fix "const_pcpu_hot" version generation failure
Date:   Sun,  3 Dec 2023 23:10:52 +0100
Message-ID: <20231203221151.794615-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
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

Version generation for "const_pcpu_hot" symbol failed because genksyms
doesn't know the __seg_gs keyword. Revert commit 4604c052b84d
"x86/percpu: Declare const_pcpu_hot as extern const variable" and
use this_cpu_read_const instead to avoid "sparse: dereference of
noderef expression" warning when reading const_pcpu_hot.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/current.h   | 5 +++--
 arch/x86/include/asm/percpu.h    | 7 +++++++
 arch/x86/include/asm/processor.h | 2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 9fbd7cb2dc86..c8c5674d69f6 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -37,12 +37,13 @@ static_assert(sizeof(struct pcpu_hot) == 64);
 DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
 
 /* const-qualified alias to pcpu_hot, aliased by linker. */
-extern const struct pcpu_hot __percpu_seg_override const_pcpu_hot;
+DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
+			const_pcpu_hot);
 
 static __always_inline struct task_struct *get_current(void)
 {
 	if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
-		return const_pcpu_hot.current_task;
+		return this_cpu_read_const(const_pcpu_hot.current_task);
 
 	return this_cpu_read_stable(pcpu_hot.current_task);
 }
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 0f12b2004b94..7f6e978e21b1 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -28,6 +28,7 @@
 
 #else /* ...!ASSEMBLY */
 
+#include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 
@@ -462,6 +463,7 @@ do {									\
 #define this_cpu_write_8(pcp, val)	__raw_cpu_write(volatile, pcp, val)
 #endif
 
+#define this_cpu_read_const(pcp)	__raw_cpu_read(, pcp)
 #else /* CONFIG_USE_X86_SEG_SUPPORT */
 
 #define raw_cpu_read_1(pcp)		percpu_from_op(1, , "mov", pcp)
@@ -486,6 +488,11 @@ do {									\
 #define this_cpu_write_8(pcp, val)	percpu_to_op(8, volatile, "mov", (pcp), val)
 #endif
 
+/*
+ * The generic per-cpu infrastrucutre is not suitable for
+ * reading const-qualified variables.
+ */
+#define this_cpu_read_const(pcp)	({ BUG(); (typeof(pcp))0; })
 #endif /* CONFIG_USE_X86_SEG_SUPPORT */
 
 #define raw_cpu_add_1(pcp, val)		percpu_add_op(1, , (pcp), val)
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 061aa86b4662..1188e8bf76a2 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -534,7 +534,7 @@ static __always_inline unsigned long current_top_of_stack(void)
 	 *  entry trampoline.
 	 */
 	if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
-		return const_pcpu_hot.top_of_stack;
+		return this_cpu_read_const(const_pcpu_hot.top_of_stack);
 
 	return this_cpu_read_stable(pcpu_hot.top_of_stack);
 }
-- 
2.42.0

