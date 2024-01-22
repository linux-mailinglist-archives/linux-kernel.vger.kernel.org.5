Return-Path: <linux-kernel+bounces-32383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7468835AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C2B6B253D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C36E544;
	Mon, 22 Jan 2024 06:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="RuPZaiMO"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CBD63D8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705904747; cv=none; b=knJ0ytAAaViLkqoNRz5ypwdbBtP6mUB7ZJcRxvYRc6py7bKiWCPS20pvun410bODPhH4xzD++w54JAJHI8cGEnZ5jdAtPXUiiiCJFM+bvRHl3nUXV8QDEE00cFMSCbGPdVYzuURoC2CNyihPXc9AjPXclidZM2D3fXNRRayWhRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705904747; c=relaxed/simple;
	bh=BIEPrj8REzhp6IWPrzPDboiwJzkYVpJOVlkhzZJPWM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c06v10vJwszan8zZLYMdr2thH3u3JYTbuTvsySieiJa1jkwZsLiSjMeCgW1uzZjuuvazBFh3odcWE7fhNrZRuHSrawda4UHVa6KVgq8+HPTP/lISy9KZY5CnIWWR4zIiReOJT1tv7ukaNRu23WqJDgPuv07qamNEefrkRbdXIeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=RuPZaiMO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d75c97ea6aso1453375ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 22:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1705904746; x=1706509546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43jjz2Dnzl3sNSNdkk4MoD6bg1Ygi5eixyO/ZKWqbHM=;
        b=RuPZaiMO68P3w575sh+zLwFuFvTts15y9QC7sVQoHxZIH5xDd8V56m3T3cKdRRrlM1
         zNpWbFItcw9wyI0BqrO+86MAaUUvSXLS3tD2Zyz0r/4U3ExHijXxFxDMbSEMTBljFDan
         //bKz5cO75A9MozGw48QeGGOAngHszMfjue5GXNZ75FnEmuZtlttID75n7UBjydgrImM
         8o7LJlrtBGXGNVok69wyZliPh5IbCGX39xP8LR3Jl7972yTCUFYYeXgqX8jbJFxQAPs0
         DEcoe/Wu/n7JjBC5abH9VTtMdH+Ksfpt+DfjPGCWWtKxXfdWWeFMz5PB4dQ8oDiem4JC
         hFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705904746; x=1706509546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43jjz2Dnzl3sNSNdkk4MoD6bg1Ygi5eixyO/ZKWqbHM=;
        b=dt7rGntbct0uMP5iXaeN96HZ18btd9h9aMFX+mIjE1iIkDM7XKP417skrZdb62H2We
         o7JXzpFsSZvT+IIB6f5hT0eqLVSM/Yx2luR24ibTFY+Od8cUlikir9QsA+kRy4GbGzZC
         oTFajIomLQpzGeSHFIve+z7oBqjspdVNJS9vC5odB2/SYasUFrSgFr3RMLEQkMKyqLye
         WN0eSvTnDJ2SuYCgmlM8g9gX9Xirjv+w28oRt/9vnwaN89ObZWTViQbHiZcKXfJeN8/m
         K4VVA6eI2WqPbB9fiqu+gfA0GkM1pMaX53ZhQImx/wh2Q6V5eaInlzxoF5mBzPDtrkcE
         rT8Q==
X-Gm-Message-State: AOJu0YwhiGSVSMR41edxJMhoE6xvvlqezeL4TPH561eOHn2duJvPDopM
	jlu/TWhOV2dEsxZHTFnaLQ3NZNpTEuz1cNbdP0sLugz5aWxMYzQr12YfAPlF7g==
X-Google-Smtp-Source: AGHT+IEomlRroVz8nzSmtKhcaaGBs692domhzxkZ5V7+Xote4F1HRdHF+uUtdXnAAOCKYpbULE+7SA==
X-Received: by 2002:a17:903:2447:b0:1d6:ff29:1007 with SMTP id l7-20020a170903244700b001d6ff291007mr4865690pls.43.1705904746052;
        Sun, 21 Jan 2024 22:25:46 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090282c500b001d7248fdc26sm4317771plz.69.2024.01.21.22.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 22:25:45 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	Song Liu <song@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v5 1/4] perf/bpf: Call bpf handler directly, not through overflow machinery
Date: Sun, 21 Jan 2024 22:25:32 -0800
Message-Id: <20240122062535.8265-2-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122062535.8265-1-khuey@kylehuey.com>
References: <20240122062535.8265-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Acked-by: Song Liu <song@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/perf_event.h |  6 +-----
 kernel/events/core.c       | 28 +++++++++++++++-------------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a..c7f54fd74d89 100644
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
@@ -1357,10 +1356,7 @@ __is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
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
index f0f0f71213a1..24a718e7eb98 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9548,6 +9548,12 @@ static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *r
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
@@ -9617,7 +9623,10 @@ static int __perf_event_overflow(struct perf_event *event,
 		irq_work_queue(&event->pending_irq);
 	}
 
-	READ_ONCE(event->overflow_handler)(event, data, regs);
+#ifdef CONFIG_BPF_SYSCALL
+	if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
+#endif
+		READ_ONCE(event->overflow_handler)(event, data, regs);
 
 	if (*perf_event_fasync(event) && event->pending_kill) {
 		event->pending_wakeup = 1;
@@ -10427,9 +10436,9 @@ static void perf_event_free_filter(struct perf_event *event)
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
@@ -10450,10 +10459,8 @@ static void bpf_overflow_handler(struct perf_event *event,
 	rcu_read_unlock();
 out:
 	__this_cpu_dec(bpf_prog_active);
-	if (!ret)
-		return;
 
-	event->orig_overflow_handler(event, data, regs);
+	return ret;
 }
 
 static int perf_event_set_bpf_handler(struct perf_event *event,
@@ -10489,8 +10496,6 @@ static int perf_event_set_bpf_handler(struct perf_event *event,
 
 	event->prog = prog;
 	event->bpf_cookie = bpf_cookie;
-	event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
-	WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
 	return 0;
 }
 
@@ -10501,7 +10506,6 @@ static void perf_event_free_bpf_handler(struct perf_event *event)
 	if (!prog)
 		return;
 
-	WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler);
 	event->prog = NULL;
 	bpf_prog_put(prog);
 }
@@ -11975,13 +11979,11 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
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


