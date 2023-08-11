Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429667792E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjHKPVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbjHKPU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:20:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F223593
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:20:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-589cd098d24so3055977b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691767203; x=1692372003;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rS381it9UYEeasrqdhU1KJ8J8i5NBjxji31IXhusmao=;
        b=0RjpBwJrzgeXin8kd9VtD/TpU1nO0tcnVnWiPRnWJoK9gi3W5Fg17hl+vXwGvZIljA
         kw8SYfOFFrVtiwVd106RhSppMOs83UI6jMHkcmrnrIgaJxZdlxMhfJyAr8GCU3y6+nRK
         L8PIVzltiILW5EDqGGpJsGbZwk71qplFSuYLVkEeO+w0bczy0xma9S2JYaqb/1hkIA0C
         vFFFSfZlravJtrce4iZRMd1snq50pCpYGo2O0El3h0g/o7A0GwA9VQmPvrvWLWSrYNMy
         6/Dlz+aYuCsIUd8Jn4oTJ8CINC4Vrydfkk3C4zVOJR7hpfY9gSJU/fu7SIjfaYxgbvqd
         CJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691767203; x=1692372003;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rS381it9UYEeasrqdhU1KJ8J8i5NBjxji31IXhusmao=;
        b=JV+fdxPUHsrPFKW5rKwx2ihoC7/QFYHJzi/6DjIDRSJo6QOTYTR7c6xDSZ+rInvwwN
         Ik6rJ/6Lc7OCXzv8aSeglxM5pal9ZhBa9XmUxvAsJHBIOafdMBYuJNj/4gqHgxPC8v6G
         O8iwKSwZIkWIytpY1f1hdAxnamfjROVmmb5Z8cVwxS7fZNO/ZiIRpugKjIv9QPB1PsWx
         yihDUIfeIAzxXqW+ftMc6evEAGDMQzobExdOZngkZJprcfHcSWQ6Y0OgE+R40h1us9r0
         nTwcPjYoiOLI/Ljmf9CO4m4ZDXi6xuDqTBI1o0aiHfl5bLsIxMsuVy5pl4hp6/oCVevJ
         afdg==
X-Gm-Message-State: AOJu0Yz4YBhy4hc6zw3bf/Zryk+XbgvHqwQ2trkXa2V6KD9VPazVsM/K
        rOKV+eqj/7eCiGEC9SpoypB3keQVng==
X-Google-Smtp-Source: AGHT+IGvyLGtUNPZhteOMFluIBpRP+ZKfeuN4QTlO0H17E3Cg5hxH+tKL22yhbgf3NaEi0/ZHPusNq4WxQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:8dc0:5176:6fda:46a0])
 (user=elver job=sendgmr) by 2002:a05:690c:709:b0:57a:118a:f31 with SMTP id
 bs9-20020a05690c070900b0057a118a0f31mr45931ywb.7.1691767203457; Fri, 11 Aug
 2023 08:20:03 -0700 (PDT)
Date:   Fri, 11 Aug 2023 17:18:40 +0200
In-Reply-To: <20230811151847.1594958-1-elver@google.com>
Mime-Version: 1.0
References: <20230811151847.1594958-1-elver@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230811151847.1594958-3-elver@google.com>
Subject: [PATCH v4 3/4] list: Introduce CONFIG_LIST_HARDENED
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Numerous production kernel configs (see [1, 2]) are choosing to enable
CONFIG_DEBUG_LIST, which is also being recommended by KSPP for hardened
configs [3]. The motivation behind this is that the option can be used
as a security hardening feature (e.g. CVE-2019-2215 and CVE-2019-2025
are mitigated by the option [4]).

The feature has never been designed with performance in mind, yet common
list manipulation is happening across hot paths all over the kernel.

Introduce CONFIG_LIST_HARDENED, which performs list pointer checking
inline, and only upon list corruption calls the reporting slow path.

To generate optimal machine code with CONFIG_LIST_HARDENED:

  1. Elide checking for pointer values which upon dereference would
     result in an immediate access fault (i.e. minimal hardening
     checks).  The trade-off is lower-quality error reports.

  2. Use the __preserve_most function attribute (available with Clang,
     but not yet with GCC) to minimize the code footprint for calling
     the reporting slow path. As a result, function size of callers is
     reduced by avoiding saving registers before calling the rarely
     called reporting slow path.

     Note that all TUs in lib/Makefile already disable function tracing,
     including list_debug.c, and __preserve_most's implied notrace has
     no effect in this case.

  3. Because the inline checks are a subset of the full set of checks in
     __list_*_valid_or_report(), always return false if the inline
     checks failed.  This avoids redundant compare and conditional
     branch right after return from the slow path.

As a side-effect of the checks being inline, if the compiler can prove
some condition to always be true, it can completely elide some checks.

Since DEBUG_LIST is functionally a superset of LIST_HARDENED, the
Kconfig variables are changed to reflect that: DEBUG_LIST selects
LIST_HARDENED, whereas LIST_HARDENED itself has no dependency on
DEBUG_LIST.

Running netperf with CONFIG_LIST_HARDENED (using a Clang compiler with
"preserve_most") shows throughput improvements, in my case of ~7% on
average (up to 20-30% on some test cases).

Link: https://r.android.com/1266735 [1]
Link: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/blob/main/config [2]
Link: https://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project/Recommended_Settings [3]
Link: https://googleprojectzero.blogspot.com/2019/11/bad-binder-android-in-wild-exploit.html [4]
Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Rename to CONFIG_LIST_HARDENED, which can independently be selected
  from CONFIG_DEBUG_LIST.
* LKDTM test should just check CONFIG_LIST_HARDENED (which is also
  implied by DEBUG_LIST).
* Comment word smithing.

v3:
* Rename ___list_*_valid() to __list_*_valid_or_report().
* More comments.

v2:
* Note that lib/Makefile disables function tracing for everything and
  __preserve_most's implied notrace is a noop here.
---
 arch/arm64/kvm/hyp/nvhe/Makefile     |  2 +-
 arch/arm64/kvm/hyp/nvhe/list_debug.c |  2 +
 drivers/misc/lkdtm/bugs.c            |  4 +-
 include/linux/list.h                 | 64 +++++++++++++++++++++++++---
 lib/Kconfig.debug                    |  9 +++-
 lib/Makefile                         |  2 +-
 lib/list_debug.c                     |  5 ++-
 security/Kconfig.hardening           | 13 ++++++
 8 files changed, 88 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 9ddc025e4b86..2250253a6429 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -25,7 +25,7 @@ hyp-obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o
 	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o stacktrace.o ffa.o
 hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
-hyp-obj-$(CONFIG_DEBUG_LIST) += list_debug.o
+hyp-obj-$(CONFIG_LIST_HARDENED) += list_debug.o
 hyp-obj-y += $(lib-objs)
 
 ##
diff --git a/arch/arm64/kvm/hyp/nvhe/list_debug.c b/arch/arm64/kvm/hyp/nvhe/list_debug.c
index 16266a939a4c..46a2d4f2b3c6 100644
--- a/arch/arm64/kvm/hyp/nvhe/list_debug.c
+++ b/arch/arm64/kvm/hyp/nvhe/list_debug.c
@@ -26,6 +26,7 @@ static inline __must_check bool nvhe_check_data_corruption(bool v)
 
 /* The predicates checked here are taken from lib/list_debug.c. */
 
+__list_valid_slowpath
 bool __list_add_valid_or_report(struct list_head *new, struct list_head *prev,
 				struct list_head *next)
 {
@@ -37,6 +38,7 @@ bool __list_add_valid_or_report(struct list_head *new, struct list_head *prev,
 	return true;
 }
 
+__list_valid_slowpath
 bool __list_del_entry_valid_or_report(struct list_head *entry)
 {
 	struct list_head *prev, *next;
diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 3c95600ab2f7..963b4dee6a7d 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -393,7 +393,7 @@ static void lkdtm_CORRUPT_LIST_ADD(void)
 		pr_err("Overwrite did not happen, but no BUG?!\n");
 	else {
 		pr_err("list_add() corruption not detected!\n");
-		pr_expected_config(CONFIG_DEBUG_LIST);
+		pr_expected_config(CONFIG_LIST_HARDENED);
 	}
 }
 
@@ -420,7 +420,7 @@ static void lkdtm_CORRUPT_LIST_DEL(void)
 		pr_err("Overwrite did not happen, but no BUG?!\n");
 	else {
 		pr_err("list_del() corruption not detected!\n");
-		pr_expected_config(CONFIG_DEBUG_LIST);
+		pr_expected_config(CONFIG_LIST_HARDENED);
 	}
 }
 
diff --git a/include/linux/list.h b/include/linux/list.h
index 130c6a1bb45c..164b4d0e9d2a 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -38,39 +38,91 @@ static inline void INIT_LIST_HEAD(struct list_head *list)
 	WRITE_ONCE(list->prev, list);
 }
 
+#ifdef CONFIG_LIST_HARDENED
+
 #ifdef CONFIG_DEBUG_LIST
+# define __list_valid_slowpath
+#else
+# define __list_valid_slowpath __cold __preserve_most
+#endif
+
 /*
  * Performs the full set of list corruption checks before __list_add().
  * On list corruption reports a warning, and returns false.
  */
-extern bool __list_add_valid_or_report(struct list_head *new,
-				       struct list_head *prev,
-				       struct list_head *next);
+extern bool __list_valid_slowpath __list_add_valid_or_report(struct list_head *new,
+							     struct list_head *prev,
+							     struct list_head *next);
 
 /*
  * Performs list corruption checks before __list_add(). Returns false if a
  * corruption is detected, true otherwise.
+ *
+ * With CONFIG_LIST_HARDENED only, performs minimal list integrity checking
+ * inline to catch non-faulting corruptions, and only if a corruption is
+ * detected calls the reporting function __list_add_valid_or_report().
  */
 static __always_inline bool __list_add_valid(struct list_head *new,
 					     struct list_head *prev,
 					     struct list_head *next)
 {
-	return __list_add_valid_or_report(new, prev, next);
+	bool ret = true;
+
+	if (!IS_ENABLED(CONFIG_DEBUG_LIST)) {
+		/*
+		 * With the hardening version, elide checking if next and prev
+		 * are NULL, since the immediate dereference of them below would
+		 * result in a fault if NULL.
+		 *
+		 * With the reduced set of checks, we can afford to inline the
+		 * checks, which also gives the compiler a chance to elide some
+		 * of them completely if they can be proven at compile-time. If
+		 * one of the pre-conditions does not hold, the slow-path will
+		 * show a report which pre-condition failed.
+		 */
+		if (likely(next->prev == prev && prev->next == next && new != prev && new != next))
+			return true;
+		ret = false;
+	}
+
+	ret &= __list_add_valid_or_report(new, prev, next);
+	return ret;
 }
 
 /*
  * Performs the full set of list corruption checks before __list_del_entry().
  * On list corruption reports a warning, and returns false.
  */
-extern bool __list_del_entry_valid_or_report(struct list_head *entry);
+extern bool __list_valid_slowpath __list_del_entry_valid_or_report(struct list_head *entry);
 
 /*
  * Performs list corruption checks before __list_del_entry(). Returns false if a
  * corruption is detected, true otherwise.
+ *
+ * With CONFIG_LIST_HARDENED only, performs minimal list integrity checking
+ * inline to catch non-faulting corruptions, and only if a corruption is
+ * detected calls the reporting function __list_del_entry_valid_or_report().
  */
 static __always_inline bool __list_del_entry_valid(struct list_head *entry)
 {
-	return __list_del_entry_valid_or_report(entry);
+	bool ret = true;
+
+	if (!IS_ENABLED(CONFIG_DEBUG_LIST)) {
+		struct list_head *prev = entry->prev;
+		struct list_head *next = entry->next;
+
+		/*
+		 * With the hardening version, elide checking if next and prev
+		 * are NULL, LIST_POISON1 or LIST_POISON2, since the immediate
+		 * dereference of them below would result in a fault.
+		 */
+		if (likely(prev->next == entry && next->prev == entry))
+			return true;
+		ret = false;
+	}
+
+	ret &= __list_del_entry_valid_or_report(entry);
+	return ret;
 }
 #else
 static inline bool __list_add_valid(struct list_head *new,
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index fbc89baf7de6..c38745ad46eb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1674,9 +1674,14 @@ menu "Debug kernel data structures"
 config DEBUG_LIST
 	bool "Debug linked list manipulation"
 	depends on DEBUG_KERNEL || BUG_ON_DATA_CORRUPTION
+	select LIST_HARDENED
 	help
-	  Enable this to turn on extended checks in the linked-list
-	  walking routines.
+	  Enable this to turn on extended checks in the linked-list walking
+	  routines.
+
+	  This option trades better quality error reports for performance, and
+	  is more suitable for kernel debugging. If you care about performance,
+	  you should only enable CONFIG_LIST_HARDENED instead.
 
 	  If unsure, say N.
 
diff --git a/lib/Makefile b/lib/Makefile
index 1ffae65bb7ee..d1397785ec16 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -167,7 +167,7 @@ obj-$(CONFIG_BTREE) += btree.o
 obj-$(CONFIG_INTERVAL_TREE) += interval_tree.o
 obj-$(CONFIG_ASSOCIATIVE_ARRAY) += assoc_array.o
 obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
-obj-$(CONFIG_DEBUG_LIST) += list_debug.o
+obj-$(CONFIG_LIST_HARDENED) += list_debug.o
 obj-$(CONFIG_DEBUG_OBJECTS) += debugobjects.o
 
 obj-$(CONFIG_BITREVERSE) += bitrev.o
diff --git a/lib/list_debug.c b/lib/list_debug.c
index 2def33b1491f..db602417febf 100644
--- a/lib/list_debug.c
+++ b/lib/list_debug.c
@@ -2,7 +2,8 @@
  * Copyright 2006, Red Hat, Inc., Dave Jones
  * Released under the General Public License (GPL).
  *
- * This file contains the linked list validation for DEBUG_LIST.
+ * This file contains the linked list validation and error reporting for
+ * LIST_HARDENED and DEBUG_LIST.
  */
 
 #include <linux/export.h>
@@ -17,6 +18,7 @@
  * attempt).
  */
 
+__list_valid_slowpath
 bool __list_add_valid_or_report(struct list_head *new, struct list_head *prev,
 				struct list_head *next)
 {
@@ -39,6 +41,7 @@ bool __list_add_valid_or_report(struct list_head *new, struct list_head *prev,
 }
 EXPORT_SYMBOL(__list_add_valid_or_report);
 
+__list_valid_slowpath
 bool __list_del_entry_valid_or_report(struct list_head *entry)
 {
 	struct list_head *prev, *next;
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 0f295961e773..ffc3c702b461 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -279,6 +279,19 @@ config ZERO_CALL_USED_REGS
 
 endmenu
 
+menu "Hardening of kernel data structures"
+
+config LIST_HARDENED
+	bool "Check integrity of linked list manipulation"
+	help
+	  Minimal integrity checking in the linked-list manipulation routines
+	  to catch memory corruptions that are not guaranteed to result in an
+	  immediate access fault.
+
+	  If unsure, say N.
+
+endmenu
+
 config CC_HAS_RANDSTRUCT
 	def_bool $(cc-option,-frandomize-layout-seed-file=/dev/null)
 	# Randstruct was first added in Clang 15, but it isn't safe to use until
-- 
2.41.0.694.ge786442a9b-goog

