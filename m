Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C553B7F55B8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 02:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjKWBD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 20:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjKWBDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 20:03:25 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FABBD40
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:03:25 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1f066fc2a28so275500fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700701404; x=1701306204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVkyC6PZB7dezKGwlai9RtxoLm4mQaLK4fj0JbxGOM8=;
        b=TaJ/VOu3Bri4FJaROCRMjVUenC92M6X17TRVJKTLnAQ0wxX+Fl3/CdujIZm8+gSr4L
         aTbf0whE9uIw6hqk2M0nmQGuhdAxWiLxh6izOnhd479xcctDRtie/cUwH6YfZocbMfrc
         czy45HqZgecnngSJhDoboC/9IyxF/WfG3ELfO4fpw55+vDvD1lJijYaqcBVc/cdFZPOD
         vgLetjNgrHoAod2isg0TiHqnTV5i0VYQlHpHDeehG4ahVDDsVfJCt7JAb5uIpwIaZoIg
         RUbQIb+LnG45oFIDaaqg9I02NarrEn9iXJALyefYHgZc8MCU7tA9WiJQKOdjHxEadX5f
         nBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700701404; x=1701306204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVkyC6PZB7dezKGwlai9RtxoLm4mQaLK4fj0JbxGOM8=;
        b=rEMgoIe7TP+JHp/OwYuw/lX9iE4JmHOFJ55gHl+2GGj+/g84KfFObGC3oo7PzkiV2M
         RHZMs6AVXRXiBKwwT0OLBOU9589WDmlgFoM/cTRD/pLhnP4dpmyeoG+RYdYBn2SMj3zh
         8V3RP9nWfjCCGJo5pL7P6T4Cmf9ws+geZaqiySzj9JtyrDZTXxFnREBEtbhsin4W/fII
         sZEYTmDTgJI1kVRmPgHUhgBkcWVuheC8NRHh9YTOqYb5CqvYDGvRMLEvTz/obJRl4bDS
         qLlSEjY2JrA0dTwFobDxkdNzO/fiXogc9PyxbTb0aU9IZ9DD2SrUF0qTQ9stdKvFaNL6
         XhHQ==
X-Gm-Message-State: AOJu0YwZTHFVnkroU8p8flAIu4HQZGsaGb926nnnWDJlNHHIfOlvhmeg
        PVwjX6Kq+I+FqY1vQplkpBNZ/A==
X-Google-Smtp-Source: AGHT+IEodBf9g1G+tyRO8UTIlhuFj5nTh0XchENIQ6Z7EexAsdxCiJ1BQNqRTwDQmzUwO1iUtDys8g==
X-Received: by 2002:a05:6870:4507:b0:1ef:9f6c:3dea with SMTP id e7-20020a056870450700b001ef9f6c3deamr5104346oao.39.1700701404455;
        Wed, 22 Nov 2023 17:03:24 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id oq12-20020a0568707d8c00b001dcfaba6d22sm65834oab.46.2023.11.22.17.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 17:03:23 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Wed, 22 Nov 2023 17:03:20 -0800
Subject: [PATCH 1/2] riscv: Include riscv_set_icache_flush_ctx prctl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-fencei-v1-1-bec0811cb212@rivosinc.com>
References: <20231122-fencei-v1-0-bec0811cb212@rivosinc.com>
In-Reply-To: <20231122-fencei-v1-0-bec0811cb212@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700701402; l=6097;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=p1/wVG4oK4tPyVEB1cAzIfwRdweH+n5SlbZADGl3HN0=;
 b=pHKTD7SgU0wmTpzFJLgvdn97KMxLFMphUzl+8fEBoD15qhhADhhnZxPbG9z6yByxWqwDDvYtR
 lZoZJpQmJvLC/hLDA8UBCzU/UWEcG0NwYl5rQi08FMJS4xAZ4Z7rtbU
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support new prctl with key PR_RISCV_SET_ICACHE_FLUSH_CTX to enable
optimization of cross modifying code. This prctl enables userspace code
to use icache flushing instructions such as fence.i with the guarantee
that the icache will continue to be clean after thread migration.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/mmu.h       |  2 ++
 arch/riscv/include/asm/processor.h |  6 ++++++
 arch/riscv/mm/cacheflush.c         | 37 +++++++++++++++++++++++++++++++++++++
 arch/riscv/mm/context.c            |  8 +++++---
 include/uapi/linux/prctl.h         |  3 +++
 kernel/sys.c                       |  6 ++++++
 6 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index 355504b37f8e..60be458e94da 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -19,6 +19,8 @@ typedef struct {
 #ifdef CONFIG_SMP
 	/* A local icache flush is needed before user execution can resume. */
 	cpumask_t icache_stale_mask;
+	/* Force local icache flush on all migrations. */
+	bool force_icache_flush;
 #endif
 #ifdef CONFIG_BINFMT_ELF_FDPIC
 	unsigned long exec_fdpic_loadmap;
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index f19f861cda54..7eda6c75e0f2 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -84,6 +84,9 @@ struct thread_struct {
 	unsigned long vstate_ctrl;
 	struct __riscv_v_ext_state vstate;
 	unsigned long align_ctl;
+#ifdef CONFIG_SMP
+	bool force_icache_flush;
+#endif
 };
 
 /* Whitelist the fstate from the task_struct for hardened usercopy */
@@ -145,6 +148,9 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
 #define GET_UNALIGN_CTL(tsk, addr)	get_unalign_ctl((tsk), (addr))
 #define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
 
+#define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2)	riscv_set_icache_flush_ctx(arg1, arg2)
+extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 55a34f2020a8..36f69c71026a 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -5,6 +5,7 @@
 
 #include <linux/acpi.h>
 #include <linux/of.h>
+#include <linux/prctl.h>
 #include <asm/acpi.h>
 #include <asm/cacheflush.h>
 
@@ -152,3 +153,39 @@ void __init riscv_init_cbo_blocksizes(void)
 	if (cboz_block_size)
 		riscv_cboz_block_size = cboz_block_size;
 }
+
+/**
+ * Enable userspace to emit icache flushing instructions.
+ *
+ * When in per-process context, there may be multiple threads using the same mm.
+ * Therefore, the icache can never be assumed clean when. Multiple threads in
+ * the process may modify instructions in the mm concurrently.
+ *
+ * In per-thread context, it can be assumed that all modifications to
+ * instructions in memory will be performed by this thread. When the thread is
+ * migrated the icache will be flushed.
+ *
+ * @arg arg: Sets the type of context
+ *  - PR_RISCV_CTX_SW_FENCEI: Allow fence.i in userspace. Another fence.i will
+ *			      emitted on thread/process migration.
+ * @arg per_thread: When set to 0, will use the default behavior of setting the
+ *  icache flush context per process. When set to 1, will use a per thread
+ *  context.
+ */
+int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread)
+{
+#ifdef CONFIG_SMP
+	switch (ctx) {
+	case PR_RISCV_CTX_SW_FENCEI:
+		if (per_thread)
+			current->thread.force_icache_flush = true;
+		else
+			current->mm->context.force_icache_flush = true;
+		break;
+
+	default:
+		break;
+	}
+#endif
+	return 0;
+}
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 217fd4de6134..a394b146e78a 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -297,12 +297,14 @@ static inline void set_mm(struct mm_struct *prev,
  *
  * The "cpu" argument must be the current local CPU number.
  */
-static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu)
+static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu,
+					 struct task_struct *task)
 {
 #ifdef CONFIG_SMP
 	cpumask_t *mask = &mm->context.icache_stale_mask;
 
-	if (cpumask_test_cpu(cpu, mask)) {
+	if (cpumask_test_cpu(cpu, mask) || mm->context.force_icache_flush ||
+	    mm->context.force_icache_flush) {
 		cpumask_clear_cpu(cpu, mask);
 		/*
 		 * Ensure the remote hart's writes are visible to this hart.
@@ -332,5 +334,5 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
 	set_mm(prev, next, cpu);
 
-	flush_icache_deferred(next, cpu);
+	flush_icache_deferred(next, cpu, task);
 }
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 370ed14b1ae0..472801ea78cc 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -306,4 +306,7 @@ struct prctl_mm_map {
 # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
 # define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
 
+#define PR_RISCV_SET_ICACHE_FLUSH_CTX	71
+# define PR_RISCV_CTX_SW_FENCEI		0
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 420d9cb9cc8e..e806a8a67c36 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -146,6 +146,9 @@
 #ifndef RISCV_V_GET_CONTROL
 # define RISCV_V_GET_CONTROL()		(-EINVAL)
 #endif
+#ifndef RISCV_SET_ICACHE_FLUSH_CTX
+# define RISCV_SET_ICACHE_FLUSH_CTX(a, b)	(-EINVAL)
+#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2739,6 +2742,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_RISCV_V_GET_CONTROL:
 		error = RISCV_V_GET_CONTROL();
 		break;
+	case PR_RISCV_SET_ICACHE_FLUSH_CTX:
+		error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
+		break;
 	default:
 		error = -EINVAL;
 		break;

-- 
2.42.0

