Return-Path: <linux-kernel+bounces-32385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C609C835AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F00C281499
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ECA111B4;
	Mon, 22 Jan 2024 06:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="I6iPxPpg"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A503FBF3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705904752; cv=none; b=YGgUA1lxK3PHY17Az+VL7+NWtZimu2/ZeP/qY0AwAyKvcYfsMGGKWkiKtbN5pngt5wrYR8MDRvYjIfNxSbNUThk1L99V8Z15oZp5xNPs2FiM1I2KBeIWtu4x0VYh5S4Y0blh/G5PFi+lYoHt4oYMAJC1CX8EPR2WqZawWGF8AQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705904752; c=relaxed/simple;
	bh=PX2QIRe/Ic85BaGVX4Y1MwT3KJ9EiLQ96IEJSBjyAmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JMfzCaS5wv3W8Pxk8k/rZfWYYa7p2vITVAPTStjyY4X4H7p2LVgAhcM0LVhSujhUosZssgCh7m9/pLrL9frkqeL1jRwxCDrwkOwejt2zjaDXol4J5wzfozlixJQqGP/YNK+6E7/hgj4ljaA8Nb7HRr5wfCQTnKkNErs7KbDuANo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=I6iPxPpg; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d71c844811so9544675ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 22:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1705904750; x=1706509550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HG1Z9345f9l/NkzG8Y/mlPsfRpv6azyFKs0IWGP/jfI=;
        b=I6iPxPpgibdZmdGTFHQ3YWOZDl3GyH3s2NYG0Rx4+Cih6gJ2JsArkBciumk59fxrKK
         nh8SfP5VylN6We9SpQ+vRuAdIvEExLSZq8JjOxZL5cG9QgWqzTkHWgEk4qj/9m6dpv/3
         U5yUIOXndWH5zVsn8GIvzjDKwa9Jfbhfp038ORPkmqovMxvEtNdQS5flBVozKyEQU8vj
         rw7n4OPzlPYYV2heM6g6J5kzvrDC8iw616N/YVefDFcKxmuG35M9UBLbpLMIxtdI7aTK
         1Ovhco2IlJeGpvV/vSp3elrt2fdahanZz7Su/Lz0RM/X86wi0Uhop1xFimDz47oh6RsR
         iClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705904750; x=1706509550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HG1Z9345f9l/NkzG8Y/mlPsfRpv6azyFKs0IWGP/jfI=;
        b=sv4zIfdcTXdoKyelQ+LZreSpK5cvBkVdaRyR0zhe/sc7yFJdbBOrQmUQaSqnO6Wa00
         36osu2MmXbetGiiLE8LC+WjRjzivaETMq58mnSdbGdiWcxBiP5xwoV8MhlW4CMyhc4I6
         YfZ7jOIAOOyrrQJAW5EIzOvUrdDB0enJ+QLP5uy/fYgxiua8LFUou0N9J7srA4t0fG6L
         vC0m+isFz3varmiBTdvSExDr/4VTyMCTsymlG5DGDp2oi2LyqhJksAyze6kSs5jxxsaw
         SAe8xaOwlcwM6/VUyr2nUoqG3saqIPRuobcLhVvWhRABKOskUPwfWJJxujKNMVB/D4JT
         Y4Mw==
X-Gm-Message-State: AOJu0YwSyDQAssotIIWwZgm1bAyvWYXB9bCMmVRjou7aciE7HioNtVA6
	3SUezXmvXWReI7nArZcjEgk67sQ0G+YiWep4G985r+V+xL37gNeawiRIVYR7WA==
X-Google-Smtp-Source: AGHT+IGjwwlnVe73yDG0DhM2YMf89F/r9yfjLGi1/9gc8G0ZQeVTjIN2iKAG0BT0jk+WB4Z4UIUUgA==
X-Received: by 2002:a17:902:e5c5:b0:1d7:4060:78b3 with SMTP id u5-20020a170902e5c500b001d7406078b3mr821096plf.39.1705904750581;
        Sun, 21 Jan 2024 22:25:50 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090282c500b001d7248fdc26sm4317771plz.69.2024.01.21.22.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 22:25:50 -0800 (PST)
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
Subject: [PATCH v5 3/4] perf/bpf: Allow a bpf program to suppress all sample side effects
Date: Sun, 21 Jan 2024 22:25:34 -0800
Message-Id: <20240122062535.8265-4-khuey@kylehuey.com>
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

Returning zero from a bpf program attached to a perf event already
suppresses any data output. Return early from __perf_event_overflow() in
this case so it will also suppress event_limit accounting, SIGTRAP
generation, and F_ASYNC signalling.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 24a718e7eb98..a329bec42c4d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9574,6 +9574,11 @@ static int __perf_event_overflow(struct perf_event *event,
 
 	ret = __perf_event_account_interrupt(event, throttle);
 
+#ifdef CONFIG_BPF_SYSCALL
+	if (event->prog && !bpf_overflow_handler(event, data, regs))
+		return ret;
+#endif
+
 	/*
 	 * XXX event_limit might not quite work as expected on inherited
 	 * events
@@ -9623,10 +9628,7 @@ static int __perf_event_overflow(struct perf_event *event,
 		irq_work_queue(&event->pending_irq);
 	}
 
-#ifdef CONFIG_BPF_SYSCALL
-	if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
-#endif
-		READ_ONCE(event->overflow_handler)(event, data, regs);
+	READ_ONCE(event->overflow_handler)(event, data, regs);
 
 	if (*perf_event_fasync(event) && event->pending_kill) {
 		event->pending_wakeup = 1;
-- 
2.34.1


