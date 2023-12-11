Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E78C80C07C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 05:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjLKEzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 23:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjLKEzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 23:55:48 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C65ED
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 20:55:54 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5d33574f64eso39483907b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 20:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1702270554; x=1702875354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LaOcUMKpaO4TscNM+bwybPG9qx56qSeDWtKT8IysKk=;
        b=M3R04DG+k5gvzaElC3f8cfdbgyW2SN0/jlAMkC9xioLyoYthHoXeq0o/70HRyD/hC9
         mMCNPvjyAeIofw0hVH+aEMqMNDjLManpbBClzlJrbP8KwIlvVyFLGWn7HMfeIWYd79mQ
         Ir6P+rdfe1ruTQHr1XrqVjcTEq199D/RXum+K+DYNL95xxEGM9sj+bBdtFI5VeUI1gJa
         obiMRMwdcYuAFLc34LMY7KE4HQqOQdZEcwbiqtOnJGLpfL1/9n8ESaiZ7dIlxKNgFzZD
         tDvxBLU/cssGK6CxDnS64XwHRGS0J4yn4K3aSxVJ8a8o1+S0jZ0oFvVV/wBZ6I9r8zOH
         Pviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702270554; x=1702875354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LaOcUMKpaO4TscNM+bwybPG9qx56qSeDWtKT8IysKk=;
        b=WHgpd5eNUs7KL1BbCbzfi5lU1p+QSqpqKed0G/bbRf888lFjn555ERyXqR4MDRzIGo
         IRTn+obJY/MeDGRW6p4lZmw0RubCxYGc2JrGRr09itlbJ12AK3WWby4pBH5pdtWI2UL+
         L8aAGQAuHfxc0b23jEfk5hNWNbRaVTJ/6kTOxEbokN7AGCH0W7sY0LrfiweKkAUOHkzX
         vf3iy7iqaC7j/9qgZe81ljh441GigkxStTuublPpvfBJ80Y8wllWcjmrHSYnamLXQomt
         QD4WFzPm3C7gLWkm8D2O1kDYwbQxxk9JNX7kwcfmwvZ+fmEUBQwoWi5C+9/qpk4rWtI9
         t/uQ==
X-Gm-Message-State: AOJu0Yxt2vXt+RbcW6QGSB2ZCLQgvtDAA5QuZ7471XRqmNG6eQlGoW2W
        x5U6kbBuBBF57g8fNlV3V4ADkQ==
X-Google-Smtp-Source: AGHT+IHAF2s56Q3cvUDcAQsGiDW8PGeDXKlIoMtqxBQkR5BpVaFZyDHs+/DYtQpzmLR2hm7B1UnyWw==
X-Received: by 2002:a0d:d5cd:0:b0:5d7:1940:b36c with SMTP id x196-20020a0dd5cd000000b005d71940b36cmr3212062ywd.56.1702270554159;
        Sun, 10 Dec 2023 20:55:54 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902b78b00b001d2ffeac9d3sm3300623pls.186.2023.12.10.20.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 20:55:53 -0800 (PST)
From:   Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To:     Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marco Elver <elver@google.com>,
        Yonghong Song <yonghong.song@linux.dev>
Cc:     Robert O'Callahan <robert@ocallahan.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v3 1/4] perf/bpf: Call bpf handler directly, not through overflow machinery
Date:   Sun, 10 Dec 2023 20:55:40 -0800
Message-Id: <20231211045543.31741-2-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211045543.31741-1-khuey@kylehuey.com>
References: <20231211045543.31741-1-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ultimately allow bpf programs attached to perf events to completely
suppress all of the effects of a perf event overflow (rather than just the
sample output, as they do today), call bpf_overflow_handler() from
__perf_event_overflow() directly rather than modifying struct perf_event's
overflow_handler. Return the bpf program's return value from
bpf_overflow_handler() so that __perf_event_overflow() knows how to
proceed. Remove the now unnecessary orig_overflow_handler from struct
perf_event.

This patch is solely a refactoring and results in no behavior change.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h |  6 +-----
 kernel/events/core.c       | 28 +++++++++++++++-------------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5547ba68e6e4..312b9f31442c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -810,7 +810,6 @@ struct perf_event {
 	perf_overflow_handler_t		overflow_handler;
 	void				*overflow_handler_context;
 #ifdef CONFIG_BPF_SYSCALL
-	perf_overflow_handler_t		orig_overflow_handler;
 	struct bpf_prog			*prog;
 	u64				bpf_cookie;
 #endif
@@ -1337,10 +1336,7 @@ __is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
 #ifdef CONFIG_BPF_SYSCALL
 static inline bool uses_default_overflow_handler(struct perf_event *event)
 {
-	if (likely(is_default_overflow_handler(event)))
-		return true;
-
-	return __is_default_overflow_handler(event->orig_overflow_handler);
+	return is_default_overflow_handler(event);
 }
 #else
 #define uses_default_overflow_handler(event) \
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b704d83a28b2..54f6372d2634 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9515,6 +9515,12 @@ static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *r
 	return true;
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+static int bpf_overflow_handler(struct perf_event *event,
+				struct perf_sample_data *data,
+				struct pt_regs *regs);
+#endif
+
 /*
  * Generic event overflow handling, sampling.
  */
@@ -9584,7 +9590,10 @@ static int __perf_event_overflow(struct perf_event *event,
 		irq_work_queue(&event->pending_irq);
 	}
 
-	READ_ONCE(event->overflow_handler)(event, data, regs);
+#ifdef CONFIG_BPF_SYSCALL
+	if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
+#endif
+		READ_ONCE(event->overflow_handler)(event, data, regs);
 
 	if (*perf_event_fasync(event) && event->pending_kill) {
 		event->pending_wakeup = 1;
@@ -10394,9 +10403,9 @@ static void perf_event_free_filter(struct perf_event *event)
 }
 
 #ifdef CONFIG_BPF_SYSCALL
-static void bpf_overflow_handler(struct perf_event *event,
-				 struct perf_sample_data *data,
-				 struct pt_regs *regs)
+static int bpf_overflow_handler(struct perf_event *event,
+				struct perf_sample_data *data,
+				struct pt_regs *regs)
 {
 	struct bpf_perf_event_data_kern ctx = {
 		.data = data,
@@ -10417,10 +10426,8 @@ static void bpf_overflow_handler(struct perf_event *event,
 	rcu_read_unlock();
 out:
 	__this_cpu_dec(bpf_prog_active);
-	if (!ret)
-		return;
 
-	event->orig_overflow_handler(event, data, regs);
+	return ret;
 }
 
 static int perf_event_set_bpf_handler(struct perf_event *event,
@@ -10456,8 +10463,6 @@ static int perf_event_set_bpf_handler(struct perf_event *event,
 
 	event->prog = prog;
 	event->bpf_cookie = bpf_cookie;
-	event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
-	WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
 	return 0;
 }
 
@@ -10468,7 +10473,6 @@ static void perf_event_free_bpf_handler(struct perf_event *event)
 	if (!prog)
 		return;
 
-	WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler);
 	event->prog = NULL;
 	bpf_prog_put(prog);
 }
@@ -11928,13 +11932,11 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		overflow_handler = parent_event->overflow_handler;
 		context = parent_event->overflow_handler_context;
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
-		if (overflow_handler == bpf_overflow_handler) {
+		if (parent_event->prog) {
 			struct bpf_prog *prog = parent_event->prog;
 
 			bpf_prog_inc(prog);
 			event->prog = prog;
-			event->orig_overflow_handler =
-				parent_event->orig_overflow_handler;
 		}
 #endif
 	}
-- 
2.34.1

