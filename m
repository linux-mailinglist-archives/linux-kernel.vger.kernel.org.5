Return-Path: <linux-kernel+bounces-66559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A045855E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0BD1C22609
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41971BDC9;
	Thu, 15 Feb 2024 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="czqseyJv"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF86B19BA2
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989825; cv=none; b=qoc/NlQpYnLNz7t1I2B1nErAG5Xa3kAiGHCNL+kmaYTXVMnPyyk4ig+6WaUXFJjt6CCCMBiYbaAkDbteVXbuUX76UfrI9nzTcJtoGEP+C4g6x87DGlcW2guYy8knhSET/1BP6xXszb167DvnYm4RygxC41d5E97eZ1P+uv8a2jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989825; c=relaxed/simple;
	bh=CdEuuuBkx27AhOlXJUVeX0lAXi7og7ZMYumDFcK6vwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OSuO9RoUIAHeohqSjuuZwKqNgJI/wJCaIZfgg5AKqnkugXH9yBt9W5PfhtitI/jph8U67Htox8wjCXlY7SqiwAIpPgYM1cyGehhQSJ0BUbEb8GYPIWy+nfUGzTbF5vq1u1y4Vb26U19wyhcEhqLlE+oBdNPI4llP/m7/5hw5XPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=czqseyJv; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a389ea940f1so80090166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707989820; x=1708594620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJvnBCQWBBDb6zNhkGV5El1e2yPo8rIgW0kOJAtMnfQ=;
        b=czqseyJvkJp6rC0dxUwnNYq15BUbDylSYhkZwRVuyxee7QAqQMaGLfGCN9Q3lBHIAu
         mNUHdcpPGAt+yYY5Tlx3HS1sTUJb4Xph78bTL87wMiZqLBahnwgsT0VV+lHIbHEG2Rlx
         olaTEmCkrsSpL+FXHfci5Jcg8oCQWVBKOX5d4Qk+E+VB9XPSumuL6k8GoI8geOuTvTfC
         kMgmiHCksIRH55VsCNYbtrJy0S+f3dI022l+4LUf//ZuVRMiOz8anECY33qIVR5K6GD1
         Zxuoerkm2/j5sMnQu0/isHh1fWwUizD4DMM1qFEQPKi7P6WJxuk98+SSp+9qiHdk89Ow
         lnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989820; x=1708594620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJvnBCQWBBDb6zNhkGV5El1e2yPo8rIgW0kOJAtMnfQ=;
        b=kLqF4mqAAOpcUrMdqYNei6Aqz7vvWbaz1pD0uCX3ZtZjyv6Hi7gUQ9qvrWkgBEQ++b
         Ny05/KDSxuFeG7sSGY8fMhyrH/8MQAGEnDfnHXQ7oH8d7woAD0loiFyTLLWOA/g2KCVp
         ZaxjFQxJE9vxSJBMRGPZsdxFWBnYm4Digf1eM8O+7awA6w396+m+6LcVo0ho34ue9Wfr
         ugKipXiHAqzcbePWd3WSYBesnNJxsW0YgpxQy84ReTq8IjIB6TxrufUHdUwwCU0xn0ti
         OXVaf7v2USFVmscNtedHkoKSwptL3vSNgkplteSs33kcL7psSDVytIDCPWsVkLIsSkS1
         LbgQ==
X-Gm-Message-State: AOJu0YzfCKLo0bgMKAMnqdbLpCY9BefreZ7+arAGi7Z0b/stVR/Wlg2f
	4tNI3B2D/kmhUZZ5EJF5UWiaHX8mXObiwqTFye9qiBskFqnsKhMTL6WIbhvnLu+9kE2LbOgv0LW
	H
X-Google-Smtp-Source: AGHT+IFYtxVlr5GCb+SwzUl58JUMU+GfVqWXvAo8YhrYMfVlZQPjqvQH5d2FDoPJl5X2WJFmsWho1A==
X-Received: by 2002:a17:906:138b:b0:a31:7dc1:c7c1 with SMTP id f11-20020a170906138b00b00a317dc1c7c1mr721493ejc.65.1707989820315;
        Thu, 15 Feb 2024 01:37:00 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id rg14-20020a1709076b8e00b00a3d09d09e90sm362059ejc.59.2024.02.15.01.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:36:59 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 5/8] linux/kernel.h: move might_sleep(), ... to sched/debug_atomic_sleep.h
Date: Thu, 15 Feb 2024 10:36:43 +0100
Message-Id: <20240215093646.3265823-6-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215093646.3265823-1-max.kellermann@ionos.com>
References: <20240215093646.3265823-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reducing dependencies on the header linux/kernel.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/clk.h                      |   1 +
 include/linux/gpio/consumer.h            |   2 +-
 include/linux/kernel.h                   | 106 ---------------------
 include/linux/mmu_notifier.h             |   1 +
 include/linux/pwm.h                      |   2 +
 include/linux/rcutiny.h                  |   1 +
 include/linux/sched.h                    |   1 +
 include/linux/sched/debug_atomic_sleep.h | 114 +++++++++++++++++++++++
 include/linux/sched/mm.h                 |   2 +-
 include/linux/uaccess.h                  |   1 +
 include/linux/wait.h                     |   1 +
 include/linux/wait_bit.h                 |   1 +
 security/landlock/object.c               |   1 +
 security/landlock/ruleset.c              |   1 +
 14 files changed, 127 insertions(+), 108 deletions(-)
 create mode 100644 include/linux/sched/debug_atomic_sleep.h

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 06f1b292f8a0..2fcae620703b 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/notifier.h>
+#include <linux/sched/debug_atomic_sleep.h> // for might_sleep()
 
 struct device;
 struct clk;
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index db2dfbae8edb..a02927330429 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -184,7 +184,7 @@ struct gpio_desc *devm_fwnode_gpiod_get_index(struct device *dev,
 #else /* CONFIG_GPIOLIB */
 
 #include <linux/err.h>
-#include <linux/kernel.h>
+#include <linux/sched/debug_atomic_sleep.h> // for might_sleep()
 
 #include <asm/bug.h>
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 86dd8939c2cd..f6a978d51c1d 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -57,112 +57,6 @@
 struct completion;
 struct user;
 
-#ifdef CONFIG_PREEMPT_VOLUNTARY_BUILD
-
-extern int __cond_resched(void);
-# define might_resched() __cond_resched()
-
-#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
-
-extern int __cond_resched(void);
-
-DECLARE_STATIC_CALL(might_resched, __cond_resched);
-
-static __always_inline void might_resched(void)
-{
-	static_call_mod(might_resched)();
-}
-
-#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-
-extern int dynamic_might_resched(void);
-# define might_resched() dynamic_might_resched()
-
-#else
-
-# define might_resched() do { } while (0)
-
-#endif /* CONFIG_PREEMPT_* */
-
-#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-extern void __might_resched(const char *file, int line, unsigned int offsets);
-extern void __might_sleep(const char *file, int line);
-extern void __cant_sleep(const char *file, int line, int preempt_offset);
-extern void __cant_migrate(const char *file, int line);
-
-/**
- * might_sleep - annotation for functions that can sleep
- *
- * this macro will print a stack trace if it is executed in an atomic
- * context (spinlock, irq-handler, ...). Additional sections where blocking is
- * not allowed can be annotated with non_block_start() and non_block_end()
- * pairs.
- *
- * This is a useful debugging help to be able to catch problems early and not
- * be bitten later when the calling function happens to sleep when it is not
- * supposed to.
- */
-# define might_sleep() \
-	do { __might_sleep(__FILE__, __LINE__); might_resched(); } while (0)
-/**
- * cant_sleep - annotation for functions that cannot sleep
- *
- * this macro will print a stack trace if it is executed with preemption enabled
- */
-# define cant_sleep() \
-	do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
-# define sched_annotate_sleep()	(current->task_state_change = 0)
-
-/**
- * cant_migrate - annotation for functions that cannot migrate
- *
- * Will print a stack trace if executed in code which is migratable
- */
-# define cant_migrate()							\
-	do {								\
-		if (IS_ENABLED(CONFIG_SMP))				\
-			__cant_migrate(__FILE__, __LINE__);		\
-	} while (0)
-
-/**
- * non_block_start - annotate the start of section where sleeping is prohibited
- *
- * This is on behalf of the oom reaper, specifically when it is calling the mmu
- * notifiers. The problem is that if the notifier were to block on, for example,
- * mutex_lock() and if the process which holds that mutex were to perform a
- * sleeping memory allocation, the oom reaper is now blocked on completion of
- * that memory allocation. Other blocking calls like wait_event() pose similar
- * issues.
- */
-# define non_block_start() (current->non_block_count++)
-/**
- * non_block_end - annotate the end of section where sleeping is prohibited
- *
- * Closes a section opened by non_block_start().
- */
-# define non_block_end() WARN_ON(current->non_block_count-- == 0)
-#else
-  static inline void __might_resched(const char *file, int line,
-				     unsigned int offsets) { }
-static inline void __might_sleep(const char *file, int line) { }
-# define might_sleep() do { might_resched(); } while (0)
-# define cant_sleep() do { } while (0)
-# define cant_migrate()		do { } while (0)
-# define sched_annotate_sleep() do { } while (0)
-# define non_block_start() do { } while (0)
-# define non_block_end() do { } while (0)
-#endif
-
-#define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
-
-#if defined(CONFIG_MMU) && \
-	(defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_DEBUG_ATOMIC_SLEEP))
-#define might_fault() __might_fault(__FILE__, __LINE__)
-void __might_fault(const char *file, int line);
-#else
-static inline void might_fault(void) { }
-#endif
-
 void do_exit(long error_code) __noreturn;
 
 extern int get_option(char **str, int *pint);
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index f349e08a9dfe..ac6bca927257 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -6,6 +6,7 @@
 #include <linux/spinlock.h>
 #include <linux/mm_types.h>
 #include <linux/mmap_lock.h>
+#include <linux/sched/debug_atomic_sleep.h> // for might_sleep()
 #include <linux/srcu.h>
 #include <linux/interval_tree.h>
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 8ffe9ae7a23a..334cacfcb74a 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -402,6 +402,8 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
 				       struct fwnode_handle *fwnode,
 				       const char *con_id);
 #else
+#include <linux/sched/debug_atomic_sleep.h> // for might_sleep()
+
 static inline bool pwm_might_sleep(struct pwm_device *pwm)
 {
 	return true;
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index d9ac7b136aea..e7b6acfbf054 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -12,6 +12,7 @@
 #ifndef __LINUX_TINY_H
 #define __LINUX_TINY_H
 
+#include <linux/sched/debug_atomic_sleep.h> // for might_sleep()
 #include <asm/param.h> /* for HZ */
 
 struct rcu_gp_oldstate {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3c2abbc587b4..74167388ca72 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -31,6 +31,7 @@
 #include <linux/refcount_types.h>
 #include <linux/resource.h>
 #include <linux/latencytop.h>
+#include <linux/sched/debug_atomic_sleep.h> // for __might_resched()
 #include <linux/sched/prio.h>
 #include <linux/sched/types.h>
 #include <linux/signal_types.h>
diff --git a/include/linux/sched/debug_atomic_sleep.h b/include/linux/sched/debug_atomic_sleep.h
new file mode 100644
index 000000000000..018d4a421a80
--- /dev/null
+++ b/include/linux/sched/debug_atomic_sleep.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SCHED_DEBUG_ATOMIC_SLEEP_H
+#define _LINUX_SCHED_DEBUG_ATOMIC_SLEEP_H
+
+#ifdef CONFIG_PREEMPT_VOLUNTARY_BUILD
+
+extern int __cond_resched(void);
+# define might_resched() __cond_resched()
+
+#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
+
+#include <linux/static_call_types.h>
+
+extern int __cond_resched(void);
+
+DECLARE_STATIC_CALL(might_resched, __cond_resched);
+
+static __always_inline void might_resched(void)
+{
+	static_call_mod(might_resched)();
+}
+
+#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+
+extern int dynamic_might_resched(void);
+# define might_resched() dynamic_might_resched()
+
+#else
+
+# define might_resched() do { } while (0)
+
+#endif /* CONFIG_PREEMPT_* */
+
+#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
+extern void __might_resched(const char *file, int line, unsigned int offsets);
+extern void __might_sleep(const char *file, int line);
+extern void __cant_sleep(const char *file, int line, int preempt_offset);
+extern void __cant_migrate(const char *file, int line);
+
+/**
+ * might_sleep - annotation for functions that can sleep
+ *
+ * this macro will print a stack trace if it is executed in an atomic
+ * context (spinlock, irq-handler, ...). Additional sections where blocking is
+ * not allowed can be annotated with non_block_start() and non_block_end()
+ * pairs.
+ *
+ * This is a useful debugging help to be able to catch problems early and not
+ * be bitten later when the calling function happens to sleep when it is not
+ * supposed to.
+ */
+# define might_sleep() \
+	do { __might_sleep(__FILE__, __LINE__); might_resched(); } while (0)
+/**
+ * cant_sleep - annotation for functions that cannot sleep
+ *
+ * this macro will print a stack trace if it is executed with preemption enabled
+ */
+# define cant_sleep() \
+	do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
+# define sched_annotate_sleep()	(current->task_state_change = 0)
+
+/**
+ * cant_migrate - annotation for functions that cannot migrate
+ *
+ * Will print a stack trace if executed in code which is migratable
+ */
+# define cant_migrate()							\
+	do {								\
+		if (IS_ENABLED(CONFIG_SMP))				\
+			__cant_migrate(__FILE__, __LINE__);		\
+	} while (0)
+
+/**
+ * non_block_start - annotate the start of section where sleeping is prohibited
+ *
+ * This is on behalf of the oom reaper, specifically when it is calling the mmu
+ * notifiers. The problem is that if the notifier were to block on, for example,
+ * mutex_lock() and if the process which holds that mutex were to perform a
+ * sleeping memory allocation, the oom reaper is now blocked on completion of
+ * that memory allocation. Other blocking calls like wait_event() pose similar
+ * issues.
+ */
+# define non_block_start() (current->non_block_count++)
+/**
+ * non_block_end - annotate the end of section where sleeping is prohibited
+ *
+ * Closes a section opened by non_block_start().
+ */
+# define non_block_end() WARN_ON(current->non_block_count-- == 0)
+#else
+  static inline void __might_resched(const char *file, int line,
+				     unsigned int offsets) { }
+static inline void __might_sleep(const char *file, int line) { }
+# define might_sleep() do { might_resched(); } while (0)
+# define cant_sleep() do { } while (0)
+# define cant_migrate()		do { } while (0)
+# define sched_annotate_sleep() do { } while (0)
+# define non_block_start() do { } while (0)
+# define non_block_end() do { } while (0)
+#endif
+
+#define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
+
+#if defined(CONFIG_MMU) && \
+	(defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_DEBUG_ATOMIC_SLEEP))
+#define might_fault() __might_fault(__FILE__, __LINE__)
+void __might_fault(const char *file, int line);
+#else
+static inline void might_fault(void) { }
+#endif
+
+
+#endif
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index d6eb56934068..62ac412a5dae 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -2,9 +2,9 @@
 #ifndef _LINUX_SCHED_MM_H
 #define _LINUX_SCHED_MM_H
 
-#include <linux/kernel.h>
 #include <linux/atomic.h>
 #include <linux/sched.h>
+#include <linux/sched/debug_atomic_sleep.h> // for might_sleep_if()
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 3064314f4832..8ea27d05f17e 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -6,6 +6,7 @@
 #include <linux/instrumented.h>
 #include <linux/minmax.h>
 #include <linux/sched.h>
+#include <linux/sched/debug_atomic_sleep.h> // for might_faul()
 #include <linux/thread_info.h>
 
 #include <asm/uaccess.h>
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 8aa3372f21a0..61e7f0d9f07e 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -5,6 +5,7 @@
  * Linux wait queue related types and methods
  */
 #include <linux/list.h>
+#include <linux/sched/debug_atomic_sleep.h> // for might_sleep()
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
 
diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 7725b7579b78..708d3b3534f6 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -6,6 +6,7 @@
  * Linux wait-bit related types and methods:
  */
 #include <linux/wait.h>
+#include <linux/sched/debug_atomic_sleep.h> // for might_sleep()
 
 struct wait_bit_key {
 	void			*flags;
diff --git a/security/landlock/object.c b/security/landlock/object.c
index 1f50612f0185..feb2dec3d89a 100644
--- a/security/landlock/object.c
+++ b/security/landlock/object.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/rcupdate.h>
 #include <linux/refcount.h>
+#include <linux/sched/debug_atomic_sleep.h> // for might_sleep()
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index e0a5fbf9201a..36396959a0e9 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -16,6 +16,7 @@
 #include <linux/overflow.h>
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
+#include <linux/sched/debug_atomic_sleep.h> // for might_sleep_if()
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
-- 
2.39.2


