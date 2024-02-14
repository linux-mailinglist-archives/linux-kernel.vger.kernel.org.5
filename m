Return-Path: <linux-kernel+bounces-65699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4330C85508E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0052128D2A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90EE84FD8;
	Wed, 14 Feb 2024 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="OPM2+jI5"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A339185651
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932449; cv=none; b=uSfiFVxdV8OgnIB+5NPxFaJhGi/qf0TjFz6SBqhhIMIQ71ivNNvNZRAfH3Lyf+AruA5dkP6b9e6oE1m/Wk+yBO4zuWxnS+oP54K5vokpquuBQiu1ga39kihZ9l9AFO4EHHEGlIXyOSL2TlLW0oa/IsSKbzoAPFCe/ySUMUyGdNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932449; c=relaxed/simple;
	bh=PX2QIRe/Ic85BaGVX4Y1MwT3KJ9EiLQ96IEJSBjyAmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MnrFyiJ3MdIt7mACB0Q+2eRvMHab4QohJgby1NlEGCz++4PzZHqGFeAxThiJuKJgDLTfdyYUN58Yut6JxAN/VesI/WaYuyHIAirvGsXy10Rpjl2kNgdJZaBe08SNX83tiQ8ddPa05V05C1il61pJ7zT9Xs3yFk+SyDk33w7sX9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=OPM2+jI5; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e0a37751cbso33305b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1707932447; x=1708537247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HG1Z9345f9l/NkzG8Y/mlPsfRpv6azyFKs0IWGP/jfI=;
        b=OPM2+jI5a1lsGQN7mpklD9h+LInX4e/9Kti3Ophc6GHXLnrZIOULn5dEbwoQ+cnVSM
         /LsWpst9DYAO7/0u9Uz0o9wnwtFGILz9q0YRJvKVNfmG0Jl5aqKvirnRNa5OUWa8B1GP
         SR5yGTs9QKvKp5Js+L7mzTpFNSZ3eJxEAYSFdvIr+twcCP+Le1AT6LQx+UWbpQMZQAN8
         SVPyITIlvaUcFzbyLV9AMY7dzZHIQCDVthQwfXelaRmMkwC95H+OG+sUTSbWpfiCu+ns
         CaITZlwXfkv6RMcdQ7UAgaKHQFCEHRhTs+xBtgga0XFo4XdmmTMdXRsIzUFjM1LfEOYj
         m/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707932447; x=1708537247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HG1Z9345f9l/NkzG8Y/mlPsfRpv6azyFKs0IWGP/jfI=;
        b=wCxja54g+TN//nsiIvjiKDIQmcFKovBDAN2WPmmw5mvVwLAK0FVdpNx4CNtfGmTCQ5
         3gu4avKNhVC27K0GFsaik6VFMU5Vd/zLLzQLTo7zfwa0COWV8fODWGJW1pcgh40+TYXL
         n5iZ9N+uF8+4OSr+3QjApgzS3XQW1AzLY7Nn68mnj9V8HTE7xGoW7ClW+xk7RoN6RlMK
         KaIc2mh+Y0bovPV+FM7yZhRcDwo8GjhxRTw5vC0K6CuRnvSdozL8yGv1Whsy8WmpSaU4
         9Boin65d58UwCqvfu1iDfF7FA65W6N/ttaFZ2bYzWdW9m79hTHlD6OgmGThia3lujWoI
         Ag5A==
X-Forwarded-Encrypted: i=1; AJvYcCXuUk8gr0J9laWZLodOFxboDorEWXjSRXdJZloUXtfgfNn4eHy/IkGRlpk6c4GcwuuJJ7OxCaYxqKzPbPArOCyOSlVlR7ar+6bduqGY
X-Gm-Message-State: AOJu0YyzzpPDdztnBf1WmnygLAIO9fOr+qSPZvJIY/FhHm/npsx9O63r
	4ymYrZxSIKRsLrlhlMPyFc30naKNVXVORZFr7eDk2pithRDnh8el1YWnpY408w==
X-Google-Smtp-Source: AGHT+IENtoExpR4R0UgDDuR65Iu+tEswvgeW9/vs4xc1NOLROh77IEBzJgo5ubBcFQUYKsn2dOKbyw==
X-Received: by 2002:a05:6a20:5a05:b0:19e:34ea:36ab with SMTP id jz5-20020a056a205a0500b0019e34ea36abmr2596022pzb.16.1707932446967;
        Wed, 14 Feb 2024 09:40:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXCVm9x2c70Y3aUaKd5dJ9CyzyMqThObPmrRdxYZr+tKeNMU1F1t+87B11jHOCr3NjPSIjrc8unAoIFwG9j0ZWYfOUjq8Y//B8Ho60+jtM9/uIvVF7wEczEsKXfEZdbu4k/Y9gDo56B4zs5WTz7e8HU/vqmCrH6Z6MWpoEhr0laUxGnMeEoblbsvak/hKw7m0PitxNEgtda/ZfHIx0dItrJ+KMd2YuYqP6+nIRaMrV0tkWBYd60QoHOrxAP1b91xYjlvSOiS+hrHyKD+87Vj1ixhRsn3cZeOHk/i5mZamezp2z0CE4R0OzfEWoHj2rf9Ebdhn1/cnVD7Y+EXw1jOIXyYLZaQiQ2HfJEXyp/cgEvJd9nuISq0xMvVvHjqsdlKV2SDcOmjp1mCfBjDHkRZLt2pQEMu/cQUcGGi9PpWFjBJ0N3u1KcM3kfAj3rOcfBr8ouBYBh3YG/6Dn+nmnZP3fQNVfkKmR6Ilx/c0SR4B7kSy7dcKwVlQwpXqUThPCp6ernnDjQJbXCLoZAo4D5a47aC5fgS7he5A8wX+LihWY1lh8=
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id p5-20020aa78605000000b006e0874cbaefsm9567604pfn.27.2024.02.14.09.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 09:40:46 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	Song Liu <song@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RESEND PATCH v5 3/4] perf/bpf: Allow a bpf program to suppress all sample side effects
Date: Wed, 14 Feb 2024 09:39:34 -0800
Message-Id: <20240214173950.18570-4-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214173950.18570-1-khuey@kylehuey.com>
References: <20240214173950.18570-1-khuey@kylehuey.com>
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


