Return-Path: <linux-kernel+bounces-79404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4493E8621A7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9401F2675B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9CC63DF;
	Sat, 24 Feb 2024 01:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N20h/Dzh"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BF64C69
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737276; cv=none; b=KrngY3gndlqSqvHMi2EeZKaUfmiC2kh4s1E2A9oB1d4hCzTv6Lfm41vLdnwOxjAUJH5k3m0zB0+OllUcOqZeeaOJXpZS3qKwD9vUjlzDDgayVMg1ROGRKq1fh8WyHloXcbhxfC7Ir6+tdRPcFsJ7fWaKgZNwVURZ1aiUrsUDQsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737276; c=relaxed/simple;
	bh=SMuNfkStfp7m84t++OujGgQIFGUkm03rcf3YONhAgWg=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=RyFjsXR+6slgsiejvforClYOUteLFbtbJQ3/hh5D5s0bGFdRmiEtDT8CzrqHlMO9ZMtQp7ErG3LEaEAxFDXIjXPP89YozVWqSLaWoo8OgFAVjIaFp3oN+udyDqh6ZYWgUrBjx2Q5nD03NysU/Cgmo2Pt+yInFlkt45CYZNXDuyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N20h/Dzh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608cf009bcfso5666577b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708737273; x=1709342073; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8txlAXE3kVJW8nyQ1VElcIl0nKZolbY0q/6ha7e2fxE=;
        b=N20h/DzhIDLoa5/B/fOpsfdnX2U3TGeXSMSUQqs37Q6IjvRvKSI1JPt+y+CMqKym9z
         xMhOUBG9l3HGZDqvguY0TVC0DrgFQ6Kyh/9A2lQIEIICJqICpqd1fbokSeiMZozDm6VG
         DJS0kweaZd18wYXqfhSZiEyaw3l20hOgmxeOQV6jU68YbJqHO4xyvpUfzum8JqwW8E7m
         EilBNNHYu2/Tl+hpPVALw/a546ros6O/rqtjq/m0kBK0xb/vxh1t1nit8138P6vsbj/0
         xBkfcf5c3golCgsQEMmCltTuZ9cNbIlV25bajmYGmFm0rFk/OxiPNqd+VsBBxKFhsswv
         R/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708737273; x=1709342073;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8txlAXE3kVJW8nyQ1VElcIl0nKZolbY0q/6ha7e2fxE=;
        b=Z2vN34FuTrvXuJTB6S9vj4yMl3HaZV7iPyhcy6LQ2F0+aBmuN8tYCMDxgLPAejAnmR
         9NzntneKQ1jghQAGf70+sQWU87RiEbUfznnPt7lblg+mZb8VlDNY9XjHf1FVee+/6Y5g
         pbm+K9JRqQ2YeikScleEzkZow77mKGkFjgPt5wR93AzH2eiTCU3d6iCYF6kjyCplp5WQ
         RzfQvreWjm7UgLbGsFTTaq4IZyBiXLGGD4Q1mTmgevzr88TKZkRlmy5wvuo4CMZFsqOb
         2GjiZehYELHRajMLai84rjWWmvg/dDl2imssoto84G5EDI8V3n6sAhDWcOgKXVfIRHfe
         tFPg==
X-Forwarded-Encrypted: i=1; AJvYcCUr9+CR0gYXRLLkYx0RyE0zZT8B+FYPrwxXo7VSWSZjAXlICPpN8h9NhHZmwdUjb2JKf+90CbguqM1V+DzA3T5N8F9ZrtNjo4g7XoNE
X-Gm-Message-State: AOJu0Yybgx3NdoXERkEXYfXPUq4cxkqZEYnr3VopzXrqDQwmQIkHdk/z
	Uwo0bPtbLIy5sDzsZ6yRZSPI7fmo+KZeYxP1IspV7btOUwIa1mI8yoM0QtfJ/fb/yISJlpg5fNs
	nKD+/+g==
X-Google-Smtp-Source: AGHT+IGfbjPMKikwPwUK4BBr0sUlTbd9KQ7ODiJsvAJ5y+y7I2SW8IIsabX9/0fSj15betRz8cL0wU2eqQrP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3cf6:588d:1bf:3fa8])
 (user=irogers job=sendgmr) by 2002:a05:6902:100b:b0:dcc:8be2:7cb0 with SMTP
 id w11-20020a056902100b00b00dcc8be27cb0mr51925ybt.0.1708737273529; Fri, 23
 Feb 2024 17:14:33 -0800 (PST)
Date: Fri, 23 Feb 2024 17:14:19 -0800
Message-Id: <20240224011420.3066322-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v1 1/2] perf metrics: Fix metric matching
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The metric match function fails for cases like looking for "metric" in
the string "all;foo_metric;metric" as the "metric" in "foo_metric"
matches but isn't preceeded by a ';'. Fix this by matching the first
list item and recursively matching on failure the next item after a
semicolon.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index b24a1c177a80..2d6865c392ef 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -352,25 +352,23 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 	return 0;
 }
 
-static bool match_metric(const char *n, const char *list)
+static bool match_metric(const char *metric_or_groups, const char *sought)
 {
 	int len;
 	char *m;
 
-	if (!list)
+	if (!sought)
 		return false;
-	if (!strcmp(list, "all"))
+	if (!strcmp(sought, "all"))
 		return true;
-	if (!n)
-		return !strcasecmp(list, "No_group");
-	len = strlen(list);
-	m = strcasestr(n, list);
-	if (!m)
-		return false;
-	if ((m == n || m[-1] == ';' || m[-1] == ' ') &&
-	    (m[len] == 0 || m[len] == ';'))
+	if (!metric_or_groups)
+		return !strcasecmp(sought, "No_group");
+	len = strlen(sought);
+	if (!strncasecmp(metric_or_groups, sought, len) &&
+	    (metric_or_groups[len] == 0 || metric_or_groups[len] == ';'))
 		return true;
-	return false;
+	m = strchr(metric_or_groups, ';');
+	return m && match_metric(m + 1, sought);
 }
 
 static bool match_pm_metric(const struct pmu_metric *pm, const char *pmu, const char *metric)
-- 
2.44.0.rc0.258.g7320e95886-goog


