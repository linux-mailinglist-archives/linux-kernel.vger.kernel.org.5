Return-Path: <linux-kernel+bounces-143570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B365F8A3AF8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 06:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E64B227AD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 04:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2841BF37;
	Sat, 13 Apr 2024 04:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnlUx/Vm"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93500199B0
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 04:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712981299; cv=none; b=eOSL0yzq4cFxVplL7NfGVi2QC8w8bGIs0JQxLI7ORTXQrMobROxPFTgWNmsZJuLm26HnCOSXBdhu6qXBSIa4w2Vtev9HSQo2Kq+F5+kxbJeBYrLR+LrdS0lN3MVRxLtWfih/wq1lZLnbdzTe+BR65rDYnXdj6UJynr2MNmI4H20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712981299; c=relaxed/simple;
	bh=psg6T4xGQd7JrMIyC4K0Af0EDOUtPx/yuI+ni4g9NhA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=iVSy6jIXrtqHIW4cJ0sSg7iPmcnW451kVDMe+P/m2my+K5P1g9pVt6b5tlrAmchyuiusXNauSddwzqwk7x35DctwLN1Yj6hf4NZbc1EZgU94kd+a/BKglkYZ8TU6d9WVsgPKCwm5xnNvNvvuy8yPpNtMHNKBpL8s1H5gZnGihiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jnlUx/Vm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cc00203faso28621607b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 21:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712981295; x=1713586095; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1vfm6D8vbfikeYPBREDbfZMw+ntrB8izme+ZrPR5K4g=;
        b=jnlUx/Vm7xS7cK4wn4FmWlBvrQFc5piwalUmAgG1dqtNq0WTj4YpOjbOxndfw3wrPq
         vITcySn76KJoMfUkrQXbdtCEWJ8/OCADAjD+88bgkoekN3oEwOP96tJ/mJLWKq77590b
         qYq+7xPxHRsMB44GdMvPYiEXCelRuuLCXPbXEbhCdenJWZkELpfbNqvfJJy9LQWtuSnK
         E1RAgtBBNaF6RaQDiKFGHcQhNxcKFzKj3aQAFyTHVCaT+MWINNode5xt/+TYELo7QTbP
         P0EeLlBWVnyHGT5YKvkHcL+ApFjo4/dlV0qkFheDz8QCffDA8rqzhxJYLBgqnDQdEAJZ
         +onA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712981295; x=1713586095;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1vfm6D8vbfikeYPBREDbfZMw+ntrB8izme+ZrPR5K4g=;
        b=guMbPFqp8v1uzljiTe79AcswMXaVPC6zpbMKcwBrh/FMDBHn56rIaEDW2IItwb5ZtD
         A6UC+uxdR60wrtDHqFM0RYHw8+ldbfpUPf8pGz7Xfp5FBz2vqAgjo/6BBtbI5h1IXgyq
         RRQYoZcgoaRJfdKdUBfoBHnhiYLj/58nrJh9RzUaX0cDetEzSc6Zw5+Mbau5GRuwqhWz
         gCm1gl6146lPagwkcPcuk8Wvh2Isntf4+IQ4Xxju8AYG1iZwB/jcpuBxHVx94MoUvG7Z
         d/27IW1P/tlsw8hQvpYXZxHFY8tHdIGHdbg8rE87GOVAKtFRUmtl1Zh3N3c6m998EciI
         P9wA==
X-Forwarded-Encrypted: i=1; AJvYcCVOaLHTzy5spABvG1AjWIXGDgWYoFOaw1C3SupGeooesEyYOTZ12qnWWp0P3GohyehyaBEyMyYDKOkMi1nKDzHToO+BT8j94F3T0jIR
X-Gm-Message-State: AOJu0Yy7Rs7yUjbWOJizr0LpudtF7HJI2N24/GQNJjuh5pvjSdwuCQwR
	UAj+jdqZyxSBOtO21Ew2p3vngt2/ohZRMo+KmJPwsLz1QgUujAuGWoyO1XHmzusxheEx6eOHtj0
	OLR/Jug==
X-Google-Smtp-Source: AGHT+IGc68h3ITmPYl/wBrgeY+RnGa0UfYbf173Yk6snhK1Y/ir4lgI2FATkpMn60saSN8j3ruRp60tnjfKQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bcbe:4239:4b57:df45])
 (user=irogers job=sendgmr) by 2002:a81:49c7:0:b0:615:4295:2871 with SMTP id
 w190-20020a8149c7000000b0061542952871mr1016283ywa.7.1712981295572; Fri, 12
 Apr 2024 21:08:15 -0700 (PDT)
Date: Fri, 12 Apr 2024 21:08:12 -0700
Message-Id: <20240413040812.4042051-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [RFC PATCH v1] perf pmu: Assume sysfs events are always lowercase
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Perf event names aren't case sensitive. For sysfs events the entire
directory of events is read then iterated comparing names in a case
insensitive way, most often to see if an event is present.

Consider:
$ perf stat -e inst_retired.any true

The event inst_retired.any may be present in any PMU, so every PMU's
sysfs events are loaded and then searched with strcasecmp to see if
any match. This event is only present on the cpu PMU as a json event
so a lot of events were loaded from sysfs unnecessarily just to prove
an event didn't exist there.

This change avoids loading all the events by assuming sysfs event
names are always lowercase. It then uses file exists and only loads
the events when the desired event is present.

For the example above, the number of openat calls measured by perf
trace on a tigerlake laptop goes from 325 down to 255. The reduction
will be larger for machines with many PMUs, particularly replicated
uncore PMUs.

Make pmu_aliases_parse early return when aliases are loaded, ensure
the function is called before all uses of the aliases list.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ab30f22eaf10..ce72c99e4f61 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -425,9 +425,16 @@ static struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu,
 {
 	struct perf_pmu_alias *alias;
 
-	if (load && !pmu->sysfs_aliases_loaded)
-		pmu_aliases_parse(pmu);
+	if (load && !pmu->sysfs_aliases_loaded) {
+		char event_file_name[FILENAME_MAX + 8];
 
+		scnprintf(event_file_name, sizeof(event_file_name), "events/%s", name);
+		for (size_t i = 7, n = 7 + strlen(name); i < n; i++)
+			event_file_name[i] = tolower(event_file_name[i]);
+
+		if (perf_pmu__file_exists(pmu, event_file_name))
+			pmu_aliases_parse(pmu);
+	}
 	list_for_each_entry(alias, &pmu->aliases, list) {
 		if (!strcasecmp(alias->name, name))
 			return alias;
@@ -605,6 +612,9 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
 	size_t len;
 	int fd, dir_fd;
 
+	if (pmu->sysfs_aliases_loaded)
+		return 0;
+
 	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
 	if (!len)
 		return 0;
@@ -1689,9 +1699,7 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 {
 	size_t nr;
 
-	if (!pmu->sysfs_aliases_loaded)
-		pmu_aliases_parse(pmu);
-
+	pmu_aliases_parse(pmu);
 	nr = pmu->sysfs_aliases;
 
 	if (pmu->cpu_aliases_added)
@@ -1750,6 +1758,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	struct strbuf sb;
 
 	strbuf_init(&sb, /*hint=*/ 0);
+	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
 		size_t buf_used;
@@ -2154,6 +2163,7 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 	if (!pmu)
 		return NULL;
 
+	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
 		struct perf_event_attr attr = {.config = 0,};
-- 
2.44.0.683.g7961c838ac-goog


