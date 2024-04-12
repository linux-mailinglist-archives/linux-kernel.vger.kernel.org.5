Return-Path: <linux-kernel+bounces-141783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 043678A2365
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E611C213C8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4DD15AF1;
	Fri, 12 Apr 2024 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="ikZxtLYP"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22C113FEE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886654; cv=none; b=hWQDzaEm4do4mSlUU4i/W0vmnnICV1kWgF0PBiJ9pj3f9pwXkcJv7py6eHrK8RBg6JNpRCx97dC6IkO1YWaM3a2gBb3XilZrPyuwQdUuJmmOBsttyXEViH+Dw5xWY62B6WDV8Kwi7+Qs/DistRip0wnBqWeBv64iwX5DqfBp9JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886654; c=relaxed/simple;
	bh=mqvWJPjJTCHg1USd6XVsQJr18Mdq8CtI+8+xAlWcLkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gZaiHe78b7xljmwBXAscLmPeefquomEIBqIGLcpwt4GK/9DXMxNac4Mjb2TaDhqtJ0cdabJpr7vjtfAfSSXoeksevJTzysTlZqKlK4z60U6kl8U0U3LlYmD/XGg1DVnvlWjJTM+drNwEUmHfxHO7ItUF7X2UY2XSQVjIp1bEClA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=ikZxtLYP; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78d777d7d1fso23518785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 18:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1712886652; x=1713491452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQsjAVDSJojOvZcYxeh0Pu2aG5e5UAQY3ALs9BYs2YU=;
        b=ikZxtLYPc50oIz/X4NEG7KZwqzRruUor+I3VOuDCfG1LQyrc5eylNrOuhZSfmSHmAc
         am3oTb/lwx3Jy6pqHyzqgcZfOwSkwSbeGQex0IwdoOT4Kt6dbEVbigxJTP7RF3khhV0I
         17fNqUWNiycdyHmG0bKl0Keqnqw+5Tc7G+k6rsLoJdlBuT0zmfU0DjBrMYAAA5Lrpglz
         l/cDG6eWN7C2FIUjo5yOr1CznpuXnDd6ImjaEGKYf66XxFnVXfc2oV6BRvzJpCWDMobG
         Af7OOslT8s9085vEGyCOAduaWwbVuKC+1AGlV3iSK6iA5dt1gegimT+XMjesqDuym9+u
         MQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712886652; x=1713491452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQsjAVDSJojOvZcYxeh0Pu2aG5e5UAQY3ALs9BYs2YU=;
        b=RgBX/D/0LQ25Zapck7z2mSJq11qU+BeEADUOxYCw3gu533DO6KSOdRJ5q72fkxsJ6L
         UUJY5Y8HyucJmJiXIu+qN0XbwiZMHEhU0xn9Hlc4ppwCjNGc2v6U+zRz4RB8NlX4oxsY
         aSK0cUpqqSxnn7CF12ZK33W2ALNFqu2oDX5dTb10IpvefpJfLG9PH0jvYpb8jcMa5l99
         tIfaWbNI9qHWCgGhW+CxDeAngV4ucL8Njt3IZUdP+qWkWz9rLZgCqMmicUoiZx8LGaxh
         dXJQ5P7Ya+As113zHV9QEhZ9gFcravvCyiZmQqjKmgtdCZLKDE1OWBMXtbjparISjFMl
         UiGg==
X-Forwarded-Encrypted: i=1; AJvYcCWiNE3SpGvhAGHmMLgLt4+VOlbE4i3zfMmoBOQFUh40YZnebfPFPlcOWdSVSkn0fW0tWoDgxY6Pu0DeMorZSi0cL8keFDqy4T6GBPR6
X-Gm-Message-State: AOJu0Yw/C90PV5JzLj+0ti4HGstiMUhJVvRz0Iu/p+rzxNpfVVcxlW+s
	+IJnWImIj6DJsMkAtoiA5sWPq36+SPsgX7wA3PIoDbEeETyifvmZMs+y2VqS3g==
X-Google-Smtp-Source: AGHT+IGKuvAU3YlymoVRT8hC2x9jWoKM60y5jVQlZXrkYD5Z3LF1GHcVUdYxkusrFaNEaXHiGScCmQ==
X-Received: by 2002:a05:620a:15ac:b0:78d:3b3f:50cd with SMTP id f12-20020a05620a15ac00b0078d3b3f50cdmr1344767qkk.65.1712886651836;
        Thu, 11 Apr 2024 18:50:51 -0700 (PDT)
Received: from ip-172-31-44-15.us-east-2.compute.internal (ec2-52-15-100-147.us-east-2.compute.amazonaws.com. [52.15.100.147])
        by smtp.googlemail.com with ESMTPSA id f10-20020a05620a15aa00b0078d76c1178esm1756677qkk.119.2024.04.11.18.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 18:50:51 -0700 (PDT)
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
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	bpf@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v6 3/7] perf/bpf: Remove #ifdef CONFIG_BPF_SYSCALL from struct perf_event members
Date: Thu, 11 Apr 2024 18:50:15 -0700
Message-Id: <20240412015019.7060-4-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412015019.7060-1-khuey@kylehuey.com>
References: <20240412015019.7060-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will allow __perf_event_overflow() (which is independent of
CONFIG_BPF_SYSCALL) to use struct perf_event's prog to decide whether to
call bpf_overflow_handler().

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 include/linux/perf_event.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a..07cd4722dedb 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -809,11 +809,9 @@ struct perf_event {
 	u64				(*clock)(void);
 	perf_overflow_handler_t		overflow_handler;
 	void				*overflow_handler_context;
-#ifdef CONFIG_BPF_SYSCALL
 	perf_overflow_handler_t		orig_overflow_handler;
 	struct bpf_prog			*prog;
 	u64				bpf_cookie;
-#endif
 
 #ifdef CONFIG_EVENT_TRACING
 	struct trace_event_call		*tp_event;
-- 
2.34.1


