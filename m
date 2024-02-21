Return-Path: <linux-kernel+bounces-74007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0B685CED9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27791F22342
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C50E39859;
	Wed, 21 Feb 2024 03:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvs0jjKY"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6ED38DE6
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486927; cv=none; b=eCv+nGSQBmQYOk6Na9xrPmffHZJ4SO9/Qo3b2dcdx3se+bRv7yg7gchcvu4PF3zK8TLG3SlB7ydi5AnPMWIZA7zhCFJ1korA3o7A2hylsjQal9C69/7hVqWHMmtoP+r6ldsvvQ4rnDz6t5pntLybOduqiR4VotioTtuACgULSfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486927; c=relaxed/simple;
	bh=o/osGCI+hvlD14sD3OCM5ESdLYEEWx1V7jgoXENiCKc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bZ9mz9mnXPRTFPibPRgfUKv6IlyzWnFf29chPDpm7EF3IOO6BDuZJlC9AeTslrevU2RiDRoNqg1Lv/PMkzjsqMyCNPr22lCVyBV/ilTEckBdRt4weoydtQ7+sT29JTAuf0hMmVSzXkbvVU9hHlPe33ImFXpkM00AOafUb3cHyuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bvs0jjKY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607cd6c11d7so89979957b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708486925; x=1709091725; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uv/9NgKdLz0z52mqtvy0vTSbbBgaPJcb0Vk69+L979Q=;
        b=bvs0jjKYG21ZkB+YgfE5BE740UXuO77Aq3aGQVuxlIvR4Api1Wd4UkAzo8tzSYpyxu
         qgIcKEqtQo9kzYmWGUOYEzQqHm3T419K97jcCG6JD54rA6kt9TW3725qnQ91FWLCSKld
         DkO2R3m1FoX6F5W9P+Lz18oSTagIl5/cO6lUWg1G7Uw/eXm39MRhHadPE9CjR24Tt3FS
         w8g6c+vm1zP/XJcMZJ9rTkmPOW5IHsHgB9NA5KU0rMlj3wY9F4rKgehtcnq40to/jKhT
         GaZmDyaiksQFqofW5FfXSwirlu2KlyFgPt0WQcQmCX1WZ6nZR/aWrE31NPuKo38UqC21
         W9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708486925; x=1709091725;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uv/9NgKdLz0z52mqtvy0vTSbbBgaPJcb0Vk69+L979Q=;
        b=FiSE3G/wbQeeZHE2Yyxj96B+pbzEA9YdCXNDZhjv1mXCpy13cdQ+ooVhKlLHC5zIXO
         SREMRVAR78iWfzQOuPAfflkbbILjJi/MtKvLVo5xHQo+E9CRUmbnx0cpD8JeIiwsuOi7
         jIPh8byUHMVhkVxlt7aEPY/uiTYWkphKYDbh/lYQR+jVcoUHu4ja9UaHox6zmpIPUF9a
         1RHoujmP1XC0xuU0DBLZs2MHQo+jPfUJQAKUNuDk9agDRWeW3Z/Tz48BWwsbMHunsoki
         yrxPlxZLGSwzCsNoLTtSSyHnuzsV848hL2AwN4W9pgL3DUh4uB1Cwm0bn18hjsUg51rj
         Y9AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtQxHnKdxUa5ft6FxY0TE8f9c4FkSX46hJ51HrvpG/g+zKh6acWPeYzBiKCh7sXjdsPEPwvnW+wlpQN+hox5QWocmgjiN7SqDDX5je
X-Gm-Message-State: AOJu0YxhNijls3m6aAbKPZQEQVBVT9XXSF9NUyo1+qN5F13VgRpvZkcZ
	LCwJX1iAZjqBZgmW1gfSif08HEPEsi1PL1Z5eWYuDdIg1P1hgLaEA0RzWUqvUrJ7FXw4kqWshkB
	BtBnN+Q==
X-Google-Smtp-Source: AGHT+IGqHOfbFeUMm04fgBII6BGPdq0HLJ7wcSG61rdgw+C9Xjypqm77xVwuEi9AZKTTTzR7Hwymw6gQ+OLN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3c02:f882:5876:b7ab])
 (user=irogers job=sendgmr) by 2002:a25:db93:0:b0:dc7:9218:df3b with SMTP id
 g141-20020a25db93000000b00dc79218df3bmr708882ybf.10.1708486924814; Tue, 20
 Feb 2024 19:42:04 -0800 (PST)
Date: Tue, 20 Feb 2024 19:41:48 -0800
In-Reply-To: <20240221034155.1500118-1-irogers@google.com>
Message-Id: <20240221034155.1500118-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221034155.1500118-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v6 1/8] perf thread_map: Skip exited threads when scanning /proc
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Scanning /proc is inherently racy. Scanning /proc/pid/task within that
is also racy as the pid can terminate. Rather than failing in
__thread_map__new_all_cpus, skip pids for such failures.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/thread_map.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index ea3b431b9783..b5f12390c355 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -109,9 +109,10 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 
 		snprintf(path, sizeof(path), "/proc/%d/task", pid);
 		items = scandir(path, &namelist, filter, NULL);
-		if (items <= 0)
-			goto out_free_closedir;
-
+		if (items <= 0) {
+			pr_debug("scandir for %d returned empty, skipping\n", pid);
+			continue;
+		}
 		while (threads->nr + items >= max_threads) {
 			max_threads *= 2;
 			grow = true;
@@ -152,8 +153,6 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 	for (i = 0; i < items; i++)
 		zfree(&namelist[i]);
 	free(namelist);
-
-out_free_closedir:
 	zfree(&threads);
 	goto out_closedir;
 }
-- 
2.44.0.rc0.258.g7320e95886-goog


