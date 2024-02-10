Return-Path: <linux-kernel+bounces-60267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9276A850270
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 04:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13225B21C78
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 03:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5810333CD2;
	Sat, 10 Feb 2024 03:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnYdjP3H"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D932134B
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 03:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707535089; cv=none; b=nTkEtvwOn0szViifTSwDtL/nZKYY7LLy+6mY5dOv1Gr5FbvNj9p4iUAc5Ho2aElMe1HDbxXcrNQKilBGBy1eBqmgyPGb7tSahNpnb6x5boUOG+ZcA2ll9iYHOkx4KcEkmtOqV+ks8DLau4Tuql1ovAomC05RUDWADtjgrnChA28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707535089; c=relaxed/simple;
	bh=NlbGPHUjvYPN2VcnjTROsgfVOvtX5wfc2jhlMdVGruM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=mCbibVHKMI42wukzGXomVR9kksJ10jjdc6QROUMsIPOIq8TNin/tJfshrb/HUogpuIZC7/nlhcFDKvSRtiq35zg0YxrMudFmZybn6tPl+mznHU/MeSKUGCy0DF30mlAjtyEJbfns5KxqKsGCva/+a8sdHJN/K0CYm4u/7o6oEcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnYdjP3H; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5efe82b835fso40458267b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 19:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707535085; x=1708139885; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cCmA44GmuSEQ6KR355fhhypmUscD3id2lD2Aj801jbU=;
        b=ZnYdjP3HtTkPU+JzmqOwUWgjDDX8DA/CozgrchtAixilebiDQGVKBnXI9Ji17tUQ2r
         g/SQFMyiDWjZaXi6VHnsIBKSWiy4Oj9aw5/FgDgfAVbDl3HkJ5mfZuNBogE1lb6Idg2+
         9jjfqLMhIzaeT4bgKjpXe9Hx+KL1B9DB6tplU1O+9OqZOABB/Fc6AZxpeJ/+/PJBWtjY
         tSa4i77a/+wplygoZ9OQuJ64g/QA1j4fYIdtUJioTkML3VUYHMTXkgky8DuBNoiUXJXV
         EMYlSal2aiF+SxqLzadbqLo6eQPvsIMigVgWUr3sItk9OJy6HI2xM0YCG7HP8TQnbes/
         tdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707535085; x=1708139885;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCmA44GmuSEQ6KR355fhhypmUscD3id2lD2Aj801jbU=;
        b=d7AXglc7Ei2U2d9BnBlxLb5jRE1JBg01V4GtLcUBZzPWsSvcV/1ejJmr1oeJ0GI/Eh
         MuKZi2hZglRgQibZCsT4y5kOwQ6pvyg1xn5Oyn2ZNeXnHDnG0aLK9d3+JQ6REkTNK0s+
         xtUIvdlm9PtPVlFIW9/N7deXMRVCF7+WQPz+GtqV6AxDoagEd4O9GNapXYgoSK2Ao65g
         Ouc5RPpdZAzNxzgGzp6mNkT5qEk8TuEDAwBz6R0i8FM8eGA10b3ffIak3uJO8ocYpkz9
         4PHt/+BfX4cy1SECgV2FPQiM3G3xHHJyl/aup4MeQGqBz3+sB+uFNBhc+HVlczTaYQKV
         tKng==
X-Forwarded-Encrypted: i=1; AJvYcCXPad2SJlDbcvXUJcReid9D+jPqdr/aoOV7nhmSTwrEhV/Y/Irq91LmYikUBaUwOxwKlcs5fQSMvHEwv5iwUqauB3eIIptpkdj/VvBV
X-Gm-Message-State: AOJu0YxgUaSEy8Tz9oyK/lpQb/GAnhBRZCPfbNKh4lfEgpCzM88NhvWM
	LlekIkGnCipncC5lKgdXO8EGrUDux50Sx1LWl0kXh6c62akNLsvxbf+bi0XbhTW2SAaa9WKaNfS
	UWxdUBg==
X-Google-Smtp-Source: AGHT+IE+Fj4pzKGvpjOG4c0i+qY8ApmS6WRhnUjNga2NlY4vxZvK+caBXOIKF5xvEAVx8bP8oFyl7nh+BLe1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:877:241d:8c35:1c5b])
 (user=irogers job=sendgmr) by 2002:a25:ce05:0:b0:dc7:31f3:9f98 with SMTP id
 x5-20020a25ce05000000b00dc731f39f98mr241172ybe.9.1707535085769; Fri, 09 Feb
 2024 19:18:05 -0800 (PST)
Date: Fri,  9 Feb 2024 19:17:44 -0800
In-Reply-To: <20240210031746.4057262-1-irogers@google.com>
Message-Id: <20240210031746.4057262-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240210031746.4057262-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v3 4/6] perf maps: Get map before returning in maps__find_next_entry
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Liam Howlett <liam.howlett@oracle.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Artem Savkov <asavkov@redhat.com>, 
	Changbin Du <changbin.du@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>, 
	James Clark <james.clark@arm.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Finding a map is done under a lock, returning the map without a
reference count means it can be removed without notice and causing
uses after free. Grab a reference count to the map within the lock
region and return this. Fix up locations that need a map__put
following this.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/machine.c | 4 +++-
 tools/perf/util/maps.c    | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7031f6fddcae..4911734411b5 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1761,8 +1761,10 @@ int machine__create_kernel_maps(struct machine *machine)
 		struct map *next = maps__find_next_entry(machine__kernel_maps(machine),
 							 machine__kernel_map(machine));
 
-		if (next)
+		if (next) {
 			machine__set_kernel_mmap(machine, start, map__start(next));
+			map__put(next);
+		}
 	}
 
 out_put:
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index ea8fa684e8c6..df0c8041899e 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -962,7 +962,7 @@ struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 	down_read(maps__lock(maps));
 	i = maps__by_address_index(maps, map);
 	if (i < maps__nr_maps(maps))
-		result = maps__maps_by_address(maps)[i]; // TODO: map__get
+		result = map__get(maps__maps_by_address(maps)[i]);
 
 	up_read(maps__lock(maps));
 	return result;
-- 
2.43.0.687.g38aa6559b0-goog


