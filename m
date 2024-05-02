Return-Path: <linux-kernel+bounces-166943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2F18BA25A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6B41C22D6D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670341836EF;
	Thu,  2 May 2024 21:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E+IyvtLr"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6820C181CEC
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685714; cv=none; b=PdeaG5u1cnSESsDA1DowJHdYR1z0FIrJFPKEiBlx4/c1VarSzfMuSKunrTXqgSmbqVKCOZohI7qEZAEqlzJMxjbV0nb3gHDMI68kS7zVJBQkkohp77n4RiZecSDM8AcRRiTb8MvH3AKonaTbEdl1BWJTd5nqWftgOnvQZ1CPPPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685714; c=relaxed/simple;
	bh=tOBCq5saQrvaRbLejKaKunkpMMX6Ijqd8fdc3WGaBWs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=k5X+lbb7FJesoPx99/2vNQerG8LZ6voCIX7b0RNCbfSIq5wCp/jzd87uMLy/HaF0Su4lXA8IVfQFvaty491oppgUdFfRVphjZH/h0ppJHy1JoAmaBkB1F3kC8Nddh9sYnQDteP6Q3kxwd9afpMubs7g+NCnSfAFEZ+YniNydGaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E+IyvtLr; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be26af113so74452577b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 14:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714685712; x=1715290512; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dFxWFm3XAkSXgRMvbK6qHWYFEQhk7mOXO6rOJepfIcg=;
        b=E+IyvtLrE+ta45BkDrFrm/un0HEYJbQ7HG8iGmlIKL7SUgBoftftFssyMvSmFLNIql
         FDk03Dq0LM8sWGKkbylwm6lWHHXj7cIbpfuX8zBOG8kyVT2nzD4C30auJPhkXO3Sy3sl
         JN6iiA/vNfvH3K+LRmkBwyYSLcvzQXtlBZv3EaKUuR5NqPAXm5kpowd6T/GpxMf+c1R7
         lYN3ng7izVsEJ5KRooFOWMek93F907K7CRKkUbjAZeeNtUOLLrzl5FQJXHIW1lMAYN+p
         4glbcaAkiR1pxE6+Nuajy5z+M5RGvKsiEZpmp+lJAHI859aRA7gK919ng/kVMuRTtI0u
         KXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685712; x=1715290512;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFxWFm3XAkSXgRMvbK6qHWYFEQhk7mOXO6rOJepfIcg=;
        b=fIL+xCOFHknnA4zXoxrSLjL5SN0c185UV+jKeofSTMjOkLTjT7lbYyQBK0PdggWgkf
         FN+CYHmhlg2iNdjrh/lAOlTLTYlqojL+ow0ECJ8FH+rYd4Y3hvwL/Qk/L9Nmn0sM+s00
         dbTES9a78B21bDD+i/8b5p8ZxIqLI+VSPU0kiEqKuFuIhckqIR+LNTrow58zEORAf4w8
         CaWXZYzxIqOu4kS+TcALeS2XWHAatwZ6HyFRz1ZVKmElZZ1JD4BvYZJ152LMANQupzEN
         XhDiQikatH7bVKBJZM1g1iaXAwDViIbcX7sUZ15uZyIeXhysRDdMYxJ5zDL6MvUpMGXo
         rDTg==
X-Forwarded-Encrypted: i=1; AJvYcCVi+4dp0LBQZruj/AVbQF2cmAU/XQDwjRhKLOWvEEeC0yr3Vc1H3zq3ckh4QKSs6mf8lZq5w8Ftzv7WbUs7AEqfZuCRAjEWxFJgRilJ
X-Gm-Message-State: AOJu0Yy+j7RHqzJe0Gm0Xvc0HILZIGpfbPPdopd7sla92U9EKqGx1OHz
	HivKhsDv0zmeWRXaIVJUMrfuRNIYAdLpn18VYaLy/378WUXMFypYBv/XjS7ZDII9AWke/7v/nMq
	+Z9g2ug==
X-Google-Smtp-Source: AGHT+IEk1ODDvzdT8Cb7sSOH6uOhMZt/Y9YdELjl+b5F3Z2u0EmkSmoN0mV5UaRdfxOH1tTAE0u7bHdeFpJO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:deba:378d:2d3a:2641])
 (user=irogers job=sendgmr) by 2002:a05:6902:f88:b0:de4:fa0d:ab3e with SMTP id
 ft8-20020a0569020f8800b00de4fa0dab3emr169767ybb.8.1714685712509; Thu, 02 May
 2024 14:35:12 -0700 (PDT)
Date: Thu,  2 May 2024 14:35:02 -0700
In-Reply-To: <20240502213507.2339733-1-irogers@google.com>
Message-Id: <20240502213507.2339733-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240502213507.2339733-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v5 1/6] perf test pmu-events: Make it clearer that pmu-events
 tests json events
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add json to the test name.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/pmu-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 47a7c3277540..7b2c34462fcb 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -1105,6 +1105,6 @@ static struct test_case pmu_events_tests[] = {
 };
 
 struct test_suite suite__pmu_events = {
-	.desc = "PMU events",
+	.desc = "PMU json event tests",
 	.test_cases = pmu_events_tests,
 };
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


