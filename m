Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BDA773EAC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjHHQeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjHHQc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:32:57 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D816F73CA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:52:06 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id af79cd13be357-765ab532883so775233085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691509919; x=1692114719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LIkYxQB49dC0FQNHu2erIkpIfETNvfhvCz995ch8SuY=;
        b=4J5UJXTw0Py1AdJh0ELDZh/u/WEtd03kuFPlSoj8Rs2Q2KxtD4/lW5wti/fFo/E6Zh
         NNlr0ZvgsFAxiAaz97ncPLORsd5mftX9lQAMA/xmT0s1qKCXC74PdVHrAtSj5FNdpS65
         6a2nn4xDzzMqsy/dRQ8LVGnDzBfegj2fwzIJiR+Sgo6FZy6yuRAZRNKMIjFBF4WZNyA+
         hpvv4b5hBaCWv1RDFo6R7LND8t4hX5Yr/HFfBKe49JjYDiCMEVckmPTFwmxfxShT3QyM
         gftXLmU6HX/EpXRqrPj9jyNrlxhQgU5I69aOFz5V0AJiRwdB9FNl1QbwOT9Usqqi7E4v
         hp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509919; x=1692114719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LIkYxQB49dC0FQNHu2erIkpIfETNvfhvCz995ch8SuY=;
        b=AQzEVYIiJT6AeNQPD2KIFYDinoonFvqtm/aYmwV66pDaAGZVFM8oLRWE2OgIDlX2ZS
         OW1KHo/GHnnJksE5byGwVvRatvHW+toPQMa2gc36vP5hfhhUXzsaLLeLQ6ct9qAGdPf3
         2utOIn7nmsoSaM+Lf5cTKpbVOOtLIYeEahQXSIlou8pfsMmkAy+jje3u/igFL93E15Qr
         dlId8WQ+sNnvJT/AxbupFd5la7MhFDy10t1DmXYiCgchfLU9fhEa9mulyDAIEt0J9OHm
         z7e7kQB3dMSOSC9KK3fFDrxesuaPqLdsxGwm0ifQVBw5Hg1jbd+cDlYk3oUKjPQa2F+c
         pdJw==
X-Gm-Message-State: AOJu0YyLNB6+ZA2tEaMbVcCGzfrK2i7z1tp8eEqrIguQxX7pPbMxtYkw
        fJyCSPR+QJF20rRLS9RCe1NTdXfP4Q==
X-Google-Smtp-Source: AGHT+IHxvhUVKdMAT1tPy5MkypgIrF/CSoYfvgc0eKx9Lu6TYjeI7LJ8ieHcAdveSGPemZkzK5rR5O62Ng==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:39c0:833d:c267:7f64])
 (user=elver job=sendgmr) by 2002:a81:451f:0:b0:577:617b:f881 with SMTP id
 s31-20020a81451f000000b00577617bf881mr88047ywa.8.1691490089320; Tue, 08 Aug
 2023 03:21:29 -0700 (PDT)
Date:   Tue,  8 Aug 2023 12:17:26 +0200
In-Reply-To: <20230808102049.465864-1-elver@google.com>
Mime-Version: 1.0
References: <20230808102049.465864-1-elver@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230808102049.465864-2-elver@google.com>
Subject: [PATCH v3 2/3] list_debug: Introduce inline wrappers for debug checks
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
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn the list debug checking functions __list_*_valid() into inline
functions that wrap the out-of-line functions. Care is taken to ensure
the inline wrappers are always inlined, so that additional compiler
instrumentation (such as sanitizers) does not result in redundant
outlining.

This change is preparation for performing checks in the inline wrappers.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Rename ___list_*_valid() to __list_*_valid_or_report().
* Some documentation.
---
 arch/arm64/kvm/hyp/nvhe/list_debug.c |  6 ++---
 include/linux/list.h                 | 37 +++++++++++++++++++++++++---
 lib/list_debug.c                     | 11 ++++-----
 3 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/list_debug.c b/arch/arm64/kvm/hyp/nvhe/list_debug.c
index d68abd7ea124..16266a939a4c 100644
--- a/arch/arm64/kvm/hyp/nvhe/list_debug.c
+++ b/arch/arm64/kvm/hyp/nvhe/list_debug.c
@@ -26,8 +26,8 @@ static inline __must_check bool nvhe_check_data_corruption(bool v)
 
 /* The predicates checked here are taken from lib/list_debug.c. */
 
-bool __list_add_valid(struct list_head *new, struct list_head *prev,
-		      struct list_head *next)
+bool __list_add_valid_or_report(struct list_head *new, struct list_head *prev,
+				struct list_head *next)
 {
 	if (NVHE_CHECK_DATA_CORRUPTION(next->prev != prev) ||
 	    NVHE_CHECK_DATA_CORRUPTION(prev->next != next) ||
@@ -37,7 +37,7 @@ bool __list_add_valid(struct list_head *new, struct list_head *prev,
 	return true;
 }
 
-bool __list_del_entry_valid(struct list_head *entry)
+bool __list_del_entry_valid_or_report(struct list_head *entry)
 {
 	struct list_head *prev, *next;
 
diff --git a/include/linux/list.h b/include/linux/list.h
index f10344dbad4d..130c6a1bb45c 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -39,10 +39,39 @@ static inline void INIT_LIST_HEAD(struct list_head *list)
 }
 
 #ifdef CONFIG_DEBUG_LIST
-extern bool __list_add_valid(struct list_head *new,
-			      struct list_head *prev,
-			      struct list_head *next);
-extern bool __list_del_entry_valid(struct list_head *entry);
+/*
+ * Performs the full set of list corruption checks before __list_add().
+ * On list corruption reports a warning, and returns false.
+ */
+extern bool __list_add_valid_or_report(struct list_head *new,
+				       struct list_head *prev,
+				       struct list_head *next);
+
+/*
+ * Performs list corruption checks before __list_add(). Returns false if a
+ * corruption is detected, true otherwise.
+ */
+static __always_inline bool __list_add_valid(struct list_head *new,
+					     struct list_head *prev,
+					     struct list_head *next)
+{
+	return __list_add_valid_or_report(new, prev, next);
+}
+
+/*
+ * Performs the full set of list corruption checks before __list_del_entry().
+ * On list corruption reports a warning, and returns false.
+ */
+extern bool __list_del_entry_valid_or_report(struct list_head *entry);
+
+/*
+ * Performs list corruption checks before __list_del_entry(). Returns false if a
+ * corruption is detected, true otherwise.
+ */
+static __always_inline bool __list_del_entry_valid(struct list_head *entry)
+{
+	return __list_del_entry_valid_or_report(entry);
+}
 #else
 static inline bool __list_add_valid(struct list_head *new,
 				struct list_head *prev,
diff --git a/lib/list_debug.c b/lib/list_debug.c
index d98d43f80958..2def33b1491f 100644
--- a/lib/list_debug.c
+++ b/lib/list_debug.c
@@ -17,8 +17,8 @@
  * attempt).
  */
 
-bool __list_add_valid(struct list_head *new, struct list_head *prev,
-		      struct list_head *next)
+bool __list_add_valid_or_report(struct list_head *new, struct list_head *prev,
+				struct list_head *next)
 {
 	if (CHECK_DATA_CORRUPTION(prev == NULL,
 			"list_add corruption. prev is NULL.\n") ||
@@ -37,9 +37,9 @@ bool __list_add_valid(struct list_head *new, struct list_head *prev,
 
 	return true;
 }
-EXPORT_SYMBOL(__list_add_valid);
+EXPORT_SYMBOL(__list_add_valid_or_report);
 
-bool __list_del_entry_valid(struct list_head *entry)
+bool __list_del_entry_valid_or_report(struct list_head *entry)
 {
 	struct list_head *prev, *next;
 
@@ -65,6 +65,5 @@ bool __list_del_entry_valid(struct list_head *entry)
 		return false;
 
 	return true;
-
 }
-EXPORT_SYMBOL(__list_del_entry_valid);
+EXPORT_SYMBOL(__list_del_entry_valid_or_report);
-- 
2.41.0.640.ga95def55d0-goog

