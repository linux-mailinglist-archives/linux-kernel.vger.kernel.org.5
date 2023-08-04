Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4441076FCEC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjHDJKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjHDJJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:09:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9427C659A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:06:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58440eb872aso22063607b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 02:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691140015; x=1691744815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MzWCD4HwKY1r1A6RBU3efg4gsiTlnVjc3j6YbCfBqUM=;
        b=X1qQHJBN0yCJmiiCOnUz6+pj65LuFmL9UZz8FfdlIEiWrVdg46nOF6JPHUsBf46tyT
         gu/cU7tVPjn5xggOa6K89RQzk9Xs2SR+GfyZp18F5E0spipr3dg5dVvX7DslvcvYCFRD
         2gvOVVugZtDQlWRnRsapExEDo9j1EfKY2zqVkvdakxjxG7T1dXj/JefW2y72bQ2yBMMe
         weUy74bSRSwjfV9CAKw48V+vgo+KAzLIPbCDKTWEXh9SxkSClJWIQsafkhKswHn4G16r
         tvs0P0LXkXbfRVlSTUqEog1H3rU0OIcvaDaBHXz9cepHqF4vObfSkJ5xxrTUelL8NE+l
         pocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691140015; x=1691744815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzWCD4HwKY1r1A6RBU3efg4gsiTlnVjc3j6YbCfBqUM=;
        b=ET8Xbr41ld5ptnf+1fWL0zv41NYcO+cbRP7NVICtRLUeRgkyIfc4dSlYb5KxvU/pYL
         gKeT/guztvQXZCk2T35kPdjPK76fqM4unCp36nFN9JnLtKgisDlBEXS8w7aZvYEJchZ+
         8HZh0o/HQYD0qhOK/MLNrpDIh24DwhzkqR6g2YplOprrzmrcRrIDVfxm7VwpiwtnK7WV
         3cM307B7qXPjN3JNNbmlhET1c3ahMGgNNlMJe9PhRV1Jf7ot7N0JfvC7bxy1scrOeV93
         1G9Gm7bLHP2xc9caZbpvzDdpab8NHaBPS4wB3K8TULjJp2l8D1tSTMWeXdyFysr3I7ky
         QIfg==
X-Gm-Message-State: AOJu0YzsDkGP7OXOu+X8GouR14P5MCqLEBiZ+inSRI2ayo2+tTp+AOyR
        49SGT+wjBwdl48MjOamQpek07Oysmg==
X-Google-Smtp-Source: AGHT+IHb47om6RdVmuoXy9g0+Rz+FIp330BgZAdxPKXZUIucVRKYEj76dp9OQ4SsePP+7+HTjAkoWKdCsg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:2ebf:f3ea:4841:53b6])
 (user=elver job=sendgmr) by 2002:a81:af41:0:b0:573:8316:8d04 with SMTP id
 x1-20020a81af41000000b0057383168d04mr7391ywj.4.1691140015704; Fri, 04 Aug
 2023 02:06:55 -0700 (PDT)
Date:   Fri,  4 Aug 2023 11:02:58 +0200
In-Reply-To: <20230804090621.400-1-elver@google.com>
Mime-Version: 1.0
References: <20230804090621.400-1-elver@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230804090621.400-3-elver@google.com>
Subject: [PATCH v2 3/3] list_debug: Introduce CONFIG_DEBUG_LIST_MINIMAL
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
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
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
configs [3]. The feature has never been designed with performance in
mind, yet common list manipulation is happening across hot paths all
over the kernel.

Introduce CONFIG_DEBUG_LIST_MINIMAL, which performs list pointer
checking inline, and only upon list corruption delegates to the
reporting slow path.

To generate optimal machine code with CONFIG_DEBUG_LIST_MINIMAL:

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
     ___list_*_valid(), always return false if the inline checks failed.
     This avoids redundant compare and conditional branch right after
     return from the slow path.

As a side-effect of the checks being inline, if the compiler can prove
some condition to always be true, it can completely elide some checks.

Running netperf with CONFIG_DEBUG_LIST_MINIMAL (using a Clang compiler
with "preserve_most") shows throughput improvements, in my case of ~7%
on average (up to 20-30% on some test cases).

Link: https://r.android.com/1266735 [1]
Link: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/blob/main/config [2]
Link: https://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project/Recommended_Settings [3]
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Note that lib/Makefile disables function tracing for everything and
  __preserve_most's implied notrace is a noop here.
---
 arch/arm64/kvm/hyp/nvhe/list_debug.c |  2 +
 include/linux/list.h                 | 56 +++++++++++++++++++++++++---
 lib/Kconfig.debug                    | 15 ++++++++
 lib/list_debug.c                     |  2 +
 4 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/list_debug.c b/arch/arm64/kvm/hyp/nvhe/list_debug.c
index 589284496ac5..df718e29f6d4 100644
--- a/arch/arm64/kvm/hyp/nvhe/list_debug.c
+++ b/arch/arm64/kvm/hyp/nvhe/list_debug.c
@@ -26,6 +26,7 @@ static inline __must_check bool nvhe_check_data_corruption(bool v)
 
 /* The predicates checked here are taken from lib/list_debug.c. */
 
+__list_valid_slowpath
 bool ___list_add_valid(struct list_head *new, struct list_head *prev,
 		       struct list_head *next)
 {
@@ -37,6 +38,7 @@ bool ___list_add_valid(struct list_head *new, struct list_head *prev,
 	return true;
 }
 
+__list_valid_slowpath
 bool ___list_del_entry_valid(struct list_head *entry)
 {
 	struct list_head *prev, *next;
diff --git a/include/linux/list.h b/include/linux/list.h
index e0b2cf904409..a28a215a3eb1 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -39,20 +39,64 @@ static inline void INIT_LIST_HEAD(struct list_head *list)
 }
 
 #ifdef CONFIG_DEBUG_LIST
-extern bool ___list_add_valid(struct list_head *new,
-			      struct list_head *prev,
-			      struct list_head *next);
+
+#ifdef CONFIG_DEBUG_LIST_MINIMAL
+# define __list_valid_slowpath __cold __preserve_most
+#else
+# define __list_valid_slowpath
+#endif
+
+extern bool __list_valid_slowpath ___list_add_valid(struct list_head *new,
+						    struct list_head *prev,
+						    struct list_head *next);
 static __always_inline bool __list_add_valid(struct list_head *new,
 					     struct list_head *prev,
 					     struct list_head *next)
 {
-	return ___list_add_valid(new, prev, next);
+	bool ret = true;
+
+	if (IS_ENABLED(CONFIG_DEBUG_LIST_MINIMAL)) {
+		/*
+		 * In the minimal config, elide checking if next and prev are
+		 * NULL, since the immediate dereference of them below would
+		 * result in a fault if NULL.
+		 *
+		 * With the minimal config we can afford to inline the checks,
+		 * which also gives the compiler a chance to elide some of them
+		 * completely if they can be proven at compile-time. If one of
+		 * the pre-conditions does not hold, the slow-path will show a
+		 * report which pre-condition failed.
+		 */
+		if (likely(next->prev == prev && prev->next == next && new != prev && new != next))
+			return true;
+		ret = false;
+	}
+
+	ret &= ___list_add_valid(new, prev, next);
+	return ret;
 }
 
-extern bool ___list_del_entry_valid(struct list_head *entry);
+extern bool __list_valid_slowpath ___list_del_entry_valid(struct list_head *entry);
 static __always_inline bool __list_del_entry_valid(struct list_head *entry)
 {
-	return ___list_del_entry_valid(entry);
+	bool ret = true;
+
+	if (IS_ENABLED(CONFIG_DEBUG_LIST_MINIMAL)) {
+		struct list_head *prev = entry->prev;
+		struct list_head *next = entry->next;
+
+		/*
+		 * In the minimal config, elide checking if next and prev are
+		 * NULL, LIST_POISON1 or LIST_POISON2, since the immediate
+		 * dereference of them below would result in a fault.
+		 */
+		if (likely(prev->next == entry && next->prev == entry))
+			return true;
+		ret = false;
+	}
+
+	ret &= ___list_del_entry_valid(entry);
+	return ret;
 }
 #else
 static inline bool __list_add_valid(struct list_head *new,
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index fbc89baf7de6..e72cf08af0fa 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1680,6 +1680,21 @@ config DEBUG_LIST
 
 	  If unsure, say N.
 
+config DEBUG_LIST_MINIMAL
+	bool "Minimal linked list debug checks"
+	default !DEBUG_KERNEL
+	depends on DEBUG_LIST
+	help
+	  Only perform the minimal set of checks in the linked-list walking
+	  routines to catch corruptions that are not guaranteed to result in an
+	  immediate access fault.
+
+	  This trades lower quality error reports for improved performance: the
+	  generated code should be more optimal and provide trade-offs that may
+	  better serve safety- and performance- critical environments.
+
+	  If unsure, say Y.
+
 config DEBUG_PLIST
 	bool "Debug priority linked list manipulation"
 	depends on DEBUG_KERNEL
diff --git a/lib/list_debug.c b/lib/list_debug.c
index fd69009cc696..daad32855f0d 100644
--- a/lib/list_debug.c
+++ b/lib/list_debug.c
@@ -17,6 +17,7 @@
  * attempt).
  */
 
+__list_valid_slowpath
 bool ___list_add_valid(struct list_head *new, struct list_head *prev,
 		       struct list_head *next)
 {
@@ -39,6 +40,7 @@ bool ___list_add_valid(struct list_head *new, struct list_head *prev,
 }
 EXPORT_SYMBOL(___list_add_valid);
 
+__list_valid_slowpath
 bool ___list_del_entry_valid(struct list_head *entry)
 {
 	struct list_head *prev, *next;
-- 
2.41.0.640.ga95def55d0-goog

