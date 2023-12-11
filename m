Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE4680C07E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 05:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjLKEz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 23:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjLKEzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 23:55:50 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E521FED
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 20:55:56 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2866af9d73bso2792198a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 20:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1702270556; x=1702875356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MD1CGVptJqB75nV04X/vQRYGuHl6l1SpLkm2NuE80OA=;
        b=MTnHAGWt+qRvHekeTQ34DLhn3CKxjyXAQxPHsdHOZCFMr1OeQBEcgCZAi+dte3F9e4
         Tv0s7kcJDYTpMmHnWyqNzMxUxd31ROM/qPQjsrbcLJd6U0IW+99p29Xh8JrWDOAXh9sm
         fS8YNpXfvpllHfkuBg4tKTSslrTIk1xSjSWghPb7WnH3fipst/Hb3SbWpx2tHPJftNE9
         1yve8XSVYvSYpPbP9c8Nob1B6LR7vR/nQihHjBizydeA/O+MLG21kPtqlHpatqEMr503
         JOKYWJjCWZcfcXqdIk/ozkCVwI6tEaKawHO7yMpfJ1RUVFD6TyriSnrhIWUKH+ppH6dD
         St5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702270556; x=1702875356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MD1CGVptJqB75nV04X/vQRYGuHl6l1SpLkm2NuE80OA=;
        b=lOt6P4lLz+EHsGtCiiBegjRIVXXhOX+hktt4JWFe6Xu1r7tqGcqVXVIgvkveihcnfZ
         HNjGHkqJEQWV4UhDkLsgTKRe6bAn9Ef1r6UPwyOcFIad2fUKqURu53CH1kt+k61IwT7u
         AmofzqvI6gVOT5WONKww8L8znVctpYmBvB5iCUAsGTNdchr8PGVoCUJsOLxdqase4y57
         c5MsnvdMsuHPu/b5vMFYOLM7z8xmFhd3Tx/ZzuqlKJFVDBUoohs5lk3yB31hsh7V3cNs
         tEikWzztb5isV5f3Iu3EKEJV0obMipEwlKsm8a5hZoBcBmETLxtCCh4KIZk4kMPnoPbY
         DxHQ==
X-Gm-Message-State: AOJu0YxvgwKF4+wkgAi/GsXVN4xRiM/w9SWtSSwPWCJJtqQT9JEEkLpJ
        vD7HmUS60Vm3fAzyDMofUGH8qA==
X-Google-Smtp-Source: AGHT+IFk4Rw49zHj089ze8JCHt9tGAvA1DX6jp40Y61tz9veBn8RRGtYiMdt7+m5TnCHgq0Zz4xZqQ==
X-Received: by 2002:a17:902:da89:b0:1d0:6ffe:1e63 with SMTP id j9-20020a170902da8900b001d06ffe1e63mr2161568plx.70.1702270556361;
        Sun, 10 Dec 2023 20:55:56 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902b78b00b001d2ffeac9d3sm3300623pls.186.2023.12.10.20.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 20:55:55 -0800 (PST)
From:   Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To:     Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marco Elver <elver@google.com>,
        Yonghong Song <yonghong.song@linux.dev>
Cc:     Robert O'Callahan <robert@ocallahan.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v3 2/4] perf/bpf: Remove unneeded uses_default_overflow_handler.
Date:   Sun, 10 Dec 2023 20:55:41 -0800
Message-Id: <20231211045543.31741-3-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211045543.31741-1-khuey@kylehuey.com>
References: <20231211045543.31741-1-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that struct perf_event's orig_overflow_handler is gone, there's no need
for the functions and macros to support looking past overflow_handler to
orig_overflow_handler.

This patch is solely a refactoring and results in no behavior change.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 arch/arm/kernel/hw_breakpoint.c   |  8 ++++----
 arch/arm64/kernel/hw_breakpoint.c |  4 ++--
 include/linux/perf_event.h        | 16 ++--------------
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index dc0fb7a81371..054e9199f30d 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -626,7 +626,7 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 	hw->address &= ~alignment_mask;
 	hw->ctrl.len <<= offset;
 
-	if (uses_default_overflow_handler(bp)) {
+	if (is_default_overflow_handler(bp)) {
 		/*
 		 * Mismatch breakpoints are required for single-stepping
 		 * breakpoints.
@@ -798,7 +798,7 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
 		 * Otherwise, insert a temporary mismatch breakpoint so that
 		 * we can single-step over the watchpoint trigger.
 		 */
-		if (!uses_default_overflow_handler(wp))
+		if (!is_default_overflow_handler(wp))
 			continue;
 step:
 		enable_single_step(wp, instruction_pointer(regs));
@@ -811,7 +811,7 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
 		info->trigger = addr;
 		pr_debug("watchpoint fired: address = 0x%x\n", info->trigger);
 		perf_bp_event(wp, regs);
-		if (uses_default_overflow_handler(wp))
+		if (is_default_overflow_handler(wp))
 			enable_single_step(wp, instruction_pointer(regs));
 	}
 
@@ -886,7 +886,7 @@ static void breakpoint_handler(unsigned long unknown, struct pt_regs *regs)
 			info->trigger = addr;
 			pr_debug("breakpoint fired: address = 0x%x\n", addr);
 			perf_bp_event(bp, regs);
-			if (uses_default_overflow_handler(bp))
+			if (is_default_overflow_handler(bp))
 				enable_single_step(bp, addr);
 			goto unlock;
 		}
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 35225632d70a..db2a1861bb97 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -654,7 +654,7 @@ static int breakpoint_handler(unsigned long unused, unsigned long esr,
 		perf_bp_event(bp, regs);
 
 		/* Do we need to handle the stepping? */
-		if (uses_default_overflow_handler(bp))
+		if (is_default_overflow_handler(bp))
 			step = 1;
 unlock:
 		rcu_read_unlock();
@@ -733,7 +733,7 @@ static u64 get_distance_from_watchpoint(unsigned long addr, u64 val,
 static int watchpoint_report(struct perf_event *wp, unsigned long addr,
 			     struct pt_regs *regs)
 {
-	int step = uses_default_overflow_handler(wp);
+	int step = is_default_overflow_handler(wp);
 	struct arch_hw_breakpoint *info = counter_arch_bp(wp);
 
 	info->trigger = addr;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 312b9f31442c..7fef6299151b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1321,8 +1321,9 @@ extern int perf_event_output(struct perf_event *event,
 			     struct pt_regs *regs);
 
 static inline bool
-__is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
+is_default_overflow_handler(struct perf_event *event)
 {
+	perf_overflow_handler_t overflow_handler = event->overflow_handler;
 	if (likely(overflow_handler == perf_event_output_forward))
 		return true;
 	if (unlikely(overflow_handler == perf_event_output_backward))
@@ -1330,19 +1331,6 @@ __is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
 	return false;
 }
 
-#define is_default_overflow_handler(event) \
-	__is_default_overflow_handler((event)->overflow_handler)
-
-#ifdef CONFIG_BPF_SYSCALL
-static inline bool uses_default_overflow_handler(struct perf_event *event)
-{
-	return is_default_overflow_handler(event);
-}
-#else
-#define uses_default_overflow_handler(event) \
-	is_default_overflow_handler(event)
-#endif
-
 extern void
 perf_event_header__init_id(struct perf_event_header *header,
 			   struct perf_sample_data *data,
-- 
2.34.1

