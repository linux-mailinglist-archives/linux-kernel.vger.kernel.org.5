Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F7A76FCEB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjHDJKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjHDJJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:09:40 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF2B658F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:06:54 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-31400956ce8so1160212f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 02:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691140013; x=1691744813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GKmfKWa1C9dNl3H8pIKLebOm0SSKHLFe115my+PvGn0=;
        b=2ZPhM3agmEsbxcqIzSenTzOTGpZ1asd1w1Q2izGb4kgJmfmxUYGz5Y9l6+EQeZrOBE
         wKNBntVb39K0eFYcJF0q4Es5nWqxHHrmUx+v1Q/g0CkO2lOICunT8LA+Vx4EqT2mdLzK
         cRWPMBoIUiovuVrezWfy5xGenDsixAjKv/5i0TSx4k1iLk6obBIMG2LYCuzlFGn3VAks
         5WkXmXZihY4ic5RGw4NuwPhAR0NgdnMdfTxwUNhSzbzRS4sx30z/hws6Fm9aRaveEx7V
         u57wZrcpE/D0hKVRYaMo+T6207xMAPr2dei4NhD4al1cMBvDnRZaf1WlEA36L9tlh2l1
         5ZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691140013; x=1691744813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKmfKWa1C9dNl3H8pIKLebOm0SSKHLFe115my+PvGn0=;
        b=XAt/jmOKZemlkEy6n45iUfBRqBk8xwxt5X6IgoUhLcatSFwGfG7FoTEJSJ5VkVoS5M
         H1Q1EcIVySKsReo0BpeFWo/BCf5I5F7bsKY9REgj+w8MSN3vN+iL3bW3okRyh8HtzDKl
         Q1Hpw28dEEfv5I/ZxZz1rK6/4lp500qV7EQv2kWKKYICgP6DHvFownv5YiZ4jUoOuyzh
         olTLNM7mqYWJNxOshsoI04pRNpUTvhLwMPvYikqGr4348XYXm2nE+FZ8rnhQk8wMTdpP
         sTJRqaVFmJLDUQM1XGOsioTTRg1XIrgBybjdJ8yKq1hoI6XgUGJzIgjXXpJyLwcyk6AD
         2tBQ==
X-Gm-Message-State: AOJu0YzOIiQDkd9Chin1upMszG93gunc9jlCabkBO8kpIXevw9KjuNx0
        +7ECWmjrt9b1HRqw9ishblpUI1IL9g==
X-Google-Smtp-Source: AGHT+IE7VnI4i6X3QPJu2b4ARgq1Vxe4AP1Aorl0SMtRyhheu21XgeM+lzw0MQMQiOQdWXUYokuSwpw2pg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:2ebf:f3ea:4841:53b6])
 (user=elver job=sendgmr) by 2002:a5d:457c:0:b0:317:4ce5:c4b4 with SMTP id
 a28-20020a5d457c000000b003174ce5c4b4mr6475wrc.13.1691140012752; Fri, 04 Aug
 2023 02:06:52 -0700 (PDT)
Date:   Fri,  4 Aug 2023 11:02:57 +0200
In-Reply-To: <20230804090621.400-1-elver@google.com>
Mime-Version: 1.0
References: <20230804090621.400-1-elver@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230804090621.400-2-elver@google.com>
Subject: [PATCH v2 2/3] list_debug: Introduce inline wrappers for debug checks
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 arch/arm64/kvm/hyp/nvhe/list_debug.c |  6 +++---
 include/linux/list.h                 | 15 +++++++++++++--
 lib/list_debug.c                     | 11 +++++------
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/list_debug.c b/arch/arm64/kvm/hyp/nvhe/list_debug.c
index d68abd7ea124..589284496ac5 100644
--- a/arch/arm64/kvm/hyp/nvhe/list_debug.c
+++ b/arch/arm64/kvm/hyp/nvhe/list_debug.c
@@ -26,8 +26,8 @@ static inline __must_check bool nvhe_check_data_corruption(bool v)
 
 /* The predicates checked here are taken from lib/list_debug.c. */
 
-bool __list_add_valid(struct list_head *new, struct list_head *prev,
-		      struct list_head *next)
+bool ___list_add_valid(struct list_head *new, struct list_head *prev,
+		       struct list_head *next)
 {
 	if (NVHE_CHECK_DATA_CORRUPTION(next->prev != prev) ||
 	    NVHE_CHECK_DATA_CORRUPTION(prev->next != next) ||
@@ -37,7 +37,7 @@ bool __list_add_valid(struct list_head *new, struct list_head *prev,
 	return true;
 }
 
-bool __list_del_entry_valid(struct list_head *entry)
+bool ___list_del_entry_valid(struct list_head *entry)
 {
 	struct list_head *prev, *next;
 
diff --git a/include/linux/list.h b/include/linux/list.h
index f10344dbad4d..e0b2cf904409 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -39,10 +39,21 @@ static inline void INIT_LIST_HEAD(struct list_head *list)
 }
 
 #ifdef CONFIG_DEBUG_LIST
-extern bool __list_add_valid(struct list_head *new,
+extern bool ___list_add_valid(struct list_head *new,
 			      struct list_head *prev,
 			      struct list_head *next);
-extern bool __list_del_entry_valid(struct list_head *entry);
+static __always_inline bool __list_add_valid(struct list_head *new,
+					     struct list_head *prev,
+					     struct list_head *next)
+{
+	return ___list_add_valid(new, prev, next);
+}
+
+extern bool ___list_del_entry_valid(struct list_head *entry);
+static __always_inline bool __list_del_entry_valid(struct list_head *entry)
+{
+	return ___list_del_entry_valid(entry);
+}
 #else
 static inline bool __list_add_valid(struct list_head *new,
 				struct list_head *prev,
diff --git a/lib/list_debug.c b/lib/list_debug.c
index d98d43f80958..fd69009cc696 100644
--- a/lib/list_debug.c
+++ b/lib/list_debug.c
@@ -17,8 +17,8 @@
  * attempt).
  */
 
-bool __list_add_valid(struct list_head *new, struct list_head *prev,
-		      struct list_head *next)
+bool ___list_add_valid(struct list_head *new, struct list_head *prev,
+		       struct list_head *next)
 {
 	if (CHECK_DATA_CORRUPTION(prev == NULL,
 			"list_add corruption. prev is NULL.\n") ||
@@ -37,9 +37,9 @@ bool __list_add_valid(struct list_head *new, struct list_head *prev,
 
 	return true;
 }
-EXPORT_SYMBOL(__list_add_valid);
+EXPORT_SYMBOL(___list_add_valid);
 
-bool __list_del_entry_valid(struct list_head *entry)
+bool ___list_del_entry_valid(struct list_head *entry)
 {
 	struct list_head *prev, *next;
 
@@ -65,6 +65,5 @@ bool __list_del_entry_valid(struct list_head *entry)
 		return false;
 
 	return true;
-
 }
-EXPORT_SYMBOL(__list_del_entry_valid);
+EXPORT_SYMBOL(___list_del_entry_valid);
-- 
2.41.0.640.ga95def55d0-goog

