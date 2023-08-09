Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BDB7756BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjHIJ5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjHIJ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:57:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4C21FCA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 02:57:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso63586865e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 02:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691575047; x=1692179847;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rmEnk1g8Unm9TjBDd1nYGxjvPpnWaZtUFtYH71EmO0=;
        b=zrFX/lyuS1Z8xnbtzpce6hDvet9q21gy05mTvo4dzgluuV4jCIVRZIwM8DpAqVr0je
         SpPAtnaNykmtJAJskcZE1CjzOBYUYMDZ4MPRS0Mpph+AF3KqGHKMcljIjwkmtyXpgac/
         qbfOnGiT2TIUCvLuGutLmvJSBHRHdDBrWmIZIg0067XZT0qzwS/luicPD1WTBZzYLK09
         OmJww5lDhce1XMbLUtQfPE67fvA7nvDB938XQm5cXu8jkz3BJaCoIrt+FPTK/bSeFgXh
         iYyN0BSUyxlTNCJrYNUrkJ9H9vnqvb9Blzx7BBJVUyomhmeDTTGbUu66BxxipYS/U7w+
         dbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691575047; x=1692179847;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rmEnk1g8Unm9TjBDd1nYGxjvPpnWaZtUFtYH71EmO0=;
        b=RbYQCKwLXkagQUPbMXN3X7nY0ZbeooOe8qqWZ+dOQ2J+IJI+g4SmyvyZYZ8i0hGTL9
         rLP/MwEWVE5aBn/R79xQADCbrhiFAyJgCw7TD4I1JsqraJfUgc0x6FWX6jeDiZcfk0ce
         hCUVFMtRjhB36mNRLUirjsFpHi2Mv1dwiDebVeDD9bwUtU9hOxRndE6MZp49VXTDsMlJ
         v/pnoFGmCFVbNLLI8d8SdPMprwWJMsp39UwuvBzmK+E0Xzwi0Kivlyxm4mJGt/a7W8Bi
         BD6ZxwHlWLeVlIAYUSMSg2aaxsMLPzhLsnJ2e8KtYvE+vqXjxvQTQ1q3MXjdoqb64CvA
         ZhxA==
X-Gm-Message-State: AOJu0YxTBq8WUDHmZA8zeo70kJIDbtEla2Zjo2CJ8IpY/hZLqRN09lWB
        Gh+g301ztJIPJUMOa7VImG8heA==
X-Google-Smtp-Source: AGHT+IHn+CGz9CoURGc+L1iYofdZgIMRwp6uPgN5OhPNo0J4iMMDCIEPm6uBtj2a9yAjeaEWUXS37g==
X-Received: by 2002:a05:600c:210:b0:3fe:ad3:b066 with SMTP id 16-20020a05600c021000b003fe0ad3b066mr1884370wmi.41.1691575046903;
        Wed, 09 Aug 2023 02:57:26 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:9ce0:327a:6e5a:3533])
        by smtp.gmail.com with ESMTPSA id h18-20020a1ccc12000000b003fbd9e390e1sm1479988wmb.47.2023.08.09.02.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 02:57:25 -0700 (PDT)
Date:   Wed, 9 Aug 2023 11:57:19 +0200
From:   Marco Elver <elver@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v3 3/3] list_debug: Introduce CONFIG_DEBUG_LIST_MINIMAL
Message-ID: <ZNNi/4L1mD8XPNix@elver.google.com>
References: <20230808102049.465864-1-elver@google.com>
 <20230808102049.465864-3-elver@google.com>
 <202308081424.1DC7AA4AE3@keescook>
 <CANpmjNM3rc8ih7wvFc2GLuMDLpWcdA8uWfut-5tOajqtVG952A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM3rc8ih7wvFc2GLuMDLpWcdA8uWfut-5tOajqtVG952A@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:35AM +0200, Marco Elver wrote:

> > I'd really like to get away from calling this "DEBUG", since it's used
> > more for hardening (CONFIG_LIST_HARDENED?). Will Deacon spent some time
> > making this better a while back, but the series never landed. Do you
> > have a bit of time to look through it?
> >
> > https://github.com/KSPP/linux/issues/10
> > https://lore.kernel.org/lkml/20200324153643.15527-1-will@kernel.org/
> 
> I'm fine renaming this one. But there are other issues that Will's
> series solves, which I don't want this series to depend on. We can try
> to sort them out separately.
> 
> The main problem here is that DEBUG_LIST has been designed to be
> friendly for debugging (incl. checking poison values and NULL). Some
> kernel devs may still want that, but for production use is pointless
> and wasteful.
> 
> So what I can propose is to introduce CONFIG_LIST_HARDENED that
> doesn't depend on CONFIG_DEBUG_LIST, but instead selects it, because
> we still use that code to produce a report.

How about the below?

We'll add CONFIG_HARDEN_LIST (in Kconfig.hardening), which is
independent of CONFIG_DEBUG_LIST. For the implementation it selects
DEBUG_LIST, but irrelevant for users.

This will get us the best of both worlds: a version for hardening that
should remain as fast as possible, and one for debugging with better
reports.

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Thu, 27 Jul 2023 22:19:02 +0200
Subject: [PATCH v4 3/3] list: Introduce CONFIG_HARDEN_LIST

Numerous production kernel configs (see [1, 2]) are choosing to enable
CONFIG_DEBUG_LIST, which is also being recommended by KSPP for hardened
configs [3]. The motivation behind this is that the option can be used
as a security hardening feature (e.g. CVE-2019-2215 and CVE-2019-2025
are mitigated by the option [4]).

The feature has never been designed with performance in mind, yet common
list manipulation is happening across hot paths all over the kernel.

Introduce CONFIG_HARDEN_LIST, which performs list pointer checking
inline, and only upon list corruption calls the reporting slow path.

To generate optimal machine code with CONFIG_HARDEN_LIST:

  1. Elide checking for pointer values which upon dereference would
     result in an immediate access fault -- therefore "minimal" checks.
     The trade-off is lower-quality error reports.

  2. Use the newly introduced __preserve_most function attribute
     (available with Clang, but not yet with GCC) to minimize the code
     footprint for calling the reporting slow path. As a result,
     function size of callers is reduced by avoiding saving registers
     before calling the rarely called reporting slow path.

     Note that all TUs in lib/Makefile already disable function tracing,
     including list_debug.c, and __preserve_most's implied notrace has
     no effect in this case.

  3. Because the inline checks are a subset of the full set of checks in
     __list_*_valid_or_report(), always return false if the inline
     checks failed.  This avoids redundant compare and conditional
     branch right after return from the slow path.

As a side-effect of the checks being inline, if the compiler can prove
some condition to always be true, it can completely elide some checks.

Running netperf with CONFIG_HARDEN_LIST (using a Clang compiler with
"preserve_most") shows throughput improvements, in my case of ~7% on
average (up to 20-30% on some test cases).

Link: https://r.android.com/1266735 [1]
Link: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/blob/main/config [2]
Link: https://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project/Recommended_Settings [3]
Link: https://googleprojectzero.blogspot.com/2019/11/bad-binder-android-in-wild-exploit.html [4]
Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Rename to CONFIG_HARDEN_LIST, which can independently be selected from
  CONFIG_DEBUG_LIST.

v3:
* Rename ___list_*_valid() to __list_*_valid_or_report().
* More comments.

v2:
* Note that lib/Makefile disables function tracing for everything and
  __preserve_most's implied notrace is a noop here.
---
 arch/arm64/kvm/hyp/nvhe/list_debug.c |  2 +
 include/linux/list.h                 | 64 +++++++++++++++++++++++++---
 lib/Kconfig.debug                    | 12 ++++--
 lib/list_debug.c                     |  2 +
 security/Kconfig.hardening           | 14 ++++++
 5 files changed, 84 insertions(+), 10 deletions(-)

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
diff --git a/include/linux/list.h b/include/linux/list.h
index 130c6a1bb45c..1c7f70b7cc7a 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -39,38 +39,90 @@ static inline void INIT_LIST_HEAD(struct list_head *list)
 }
 
 #ifdef CONFIG_DEBUG_LIST
+
+#ifdef CONFIG_HARDEN_LIST
+# define __list_valid_slowpath __cold __preserve_most
+#else
+# define __list_valid_slowpath
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
+ * With CONFIG_HARDEN_LIST set, performs minimal list integrity checking (that
+ * do not result in a fault) inline, and only if a corruption is detected calls
+ * the reporting function __list_add_valid_or_report().
  */
 static __always_inline bool __list_add_valid(struct list_head *new,
 					     struct list_head *prev,
 					     struct list_head *next)
 {
-	return __list_add_valid_or_report(new, prev, next);
+	bool ret = true;
+
+	if (IS_ENABLED(CONFIG_HARDEN_LIST)) {
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
+ * With CONFIG_HARDEN_LIST set, performs minimal list integrity checking (that
+ * do not result in a fault) inline, and only if a corruption is detected calls
+ * the reporting function __list_del_entry_valid_or_report().
  */
 static __always_inline bool __list_del_entry_valid(struct list_head *entry)
 {
-	return __list_del_entry_valid_or_report(entry);
+	bool ret = true;
+
+	if (IS_ENABLED(CONFIG_HARDEN_LIST)) {
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
index fbc89baf7de6..6b0de78fb2da 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1672,11 +1672,15 @@ config HAVE_DEBUG_BUGVERBOSE
 menu "Debug kernel data structures"
 
 config DEBUG_LIST
-	bool "Debug linked list manipulation"
-	depends on DEBUG_KERNEL || BUG_ON_DATA_CORRUPTION
+	bool "Debug linked list manipulation" if !HARDEN_LIST
+	depends on DEBUG_KERNEL || BUG_ON_DATA_CORRUPTION || HARDEN_LIST
 	help
-	  Enable this to turn on extended checks in the linked-list
-	  walking routines.
+	  Enable this to turn on extended checks in the linked-list walking
+	  routines.
+
+	  If you care about performance, you should enable CONFIG_HARDEN_LIST
+	  instead.  This option alone trades better quality error reports for
+	  worse performance, and is more suitable for debugging.
 
 	  If unsure, say N.
 
diff --git a/lib/list_debug.c b/lib/list_debug.c
index 2def33b1491f..0ff547910dd0 100644
--- a/lib/list_debug.c
+++ b/lib/list_debug.c
@@ -17,6 +17,7 @@
  * attempt).
  */
 
+__list_valid_slowpath
 bool __list_add_valid_or_report(struct list_head *new, struct list_head *prev,
 				struct list_head *next)
 {
@@ -39,6 +40,7 @@ bool __list_add_valid_or_report(struct list_head *new, struct list_head *prev,
 }
 EXPORT_SYMBOL(__list_add_valid_or_report);
 
+__list_valid_slowpath
 bool __list_del_entry_valid_or_report(struct list_head *entry)
 {
 	struct list_head *prev, *next;
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 0f295961e773..a8aef895f13d 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -279,6 +279,20 @@ config ZERO_CALL_USED_REGS
 
 endmenu
 
+menu "Hardening of kernel data structures"
+
+config HARDEN_LIST
+	bool "Check integrity of linked list manipulation"
+	select DEBUG_LIST
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
2.41.0.640.ga95def55d0-goog

