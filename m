Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2518028F5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 00:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbjLCXUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 18:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjLCXUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 18:20:36 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A6CE5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 15:20:41 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b54261524so46230375e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 15:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701645639; x=1702250439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/WOpD6r5y0Ok3tYpWvI/WXVRtBKW+2PA57aZ1Qk9dM=;
        b=B2iCgx1z0ACts2HyK1PnF1HqWHwTsqbqOeWXwxlhKjYW8h6lIfQOwTd065g75oCae9
         sdAQzJIe/Sw63usMQwDwdi5z8Qh33zCzItcLJIg4LWgFmrRll4xW71v4hyM1TsOfDT8h
         nYXXfqJksHF/fQZOzOHM4V3VPiqDM79hNPuOxmv5KFl7oK1Mrbz5t1+0pAAfYd5ApvNr
         srtZA9/uDevWx7hIIX5RQhPBSjvyI8imFgki8ar/NeYqItN3ooE8teQBe3zJDwk2vEjz
         t66eOxfn0FK6mIdojXxW7Oic52qnihfgNSgHW/yxMXimTTL4/1jZ3gUUX8O8KVSnmc8g
         BInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701645639; x=1702250439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/WOpD6r5y0Ok3tYpWvI/WXVRtBKW+2PA57aZ1Qk9dM=;
        b=sNhuOpv1cFdh6OqAjFzvg349DAnsRm5HPoHowtcC2h4E880wsn3fDXPL316vzBT+mg
         BodEI8aCvK3hoVmYfNzFxJ7u3ZY1QrpYkmS/l8872+tkeE59qYAXueHulDW0eqKZRZY3
         cCJCQyulONgxoWiFWLOSsmgiYZLmtSMSaubaxVXWn97iL4i0tZVWMNeVOaNY6hQHQCjv
         mc/hU/eCGHmFwmH8bPbPUQExmPBBMDwbRVQao6ZQLl7Eo0dNdcOPFsDK0c0Z3GAvQ7dl
         S5JBMZsK0AdA466mETviLZBIXav/egM2GHOwA+TAvQhPfRNTJ1Cwfyu6a58OSsU5qgev
         avLw==
X-Gm-Message-State: AOJu0YyM5qi6UgstP7vkShmbUp0oqBVmT2hFvwENG3SUep5l0R7QCOEv
        M0mdUuA7aJcb4P3mTnm8JGIPnLXADaY74myp
X-Google-Smtp-Source: AGHT+IE4Ji2N73Op8xj9SI4dB3P2zQj7o8b4sZ3TiwyY0iRq5d+C0txL7IWIeml5BKVHn2jvv1TsvQ==
X-Received: by 2002:a05:600c:11d2:b0:409:19a0:d247 with SMTP id b18-20020a05600c11d200b0040919a0d247mr2303177wmi.18.1701645639202;
        Sun, 03 Dec 2023 15:20:39 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c510f00b004064cd71aa8sm11566222wms.34.2023.12.03.15.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 15:20:38 -0800 (PST)
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
Subject: [PATCH -tip v2 1/3] x86/percpu: Fix "const_pcpu_hot" version generation failure
Date:   Mon,  4 Dec 2023 00:19:38 +0100
Message-ID: <20231203232017.994963-1-ubizjak@gmail.com>
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
v2: Use BUILD_BUG() instead of BUG().
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
index 0f12b2004b94..3859abad19ec 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -28,6 +28,7 @@
 
 #else /* ...!ASSEMBLY */
 
+#include <linux/build_bug.h>
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
+#define this_cpu_read_const(pcp)	({ BUILD_BUG(); (typeof(pcp))0; })
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

