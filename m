Return-Path: <linux-kernel+bounces-122445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B7988F793
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD228B22F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417964F1FA;
	Thu, 28 Mar 2024 05:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TYs5yBS8"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF0C4EB4E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711605558; cv=none; b=caeWQPT4d1ESgh7Jm1E8ltuWvlvShR1Td698xK6nmr+wR1W8p+lZvD6D6/O7qwvPNYYYCthHwA1Mj2pfx8H5gTDUsZmSOqJjiMTLamRcZ57sqFM1XtLFytk3ULr2QYmK1aXGjZDBV/vZbzBzCkm7TOHw5Z84PopPEjethZBeYhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711605558; c=relaxed/simple;
	bh=EWZfbU+atOauhnn6eeT76S7ghdEOEJqps5k8nRkOICc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wic1Qm0thBcT1Dv7v6gpK8dzx3fuPtgyTadBxe9opUakYtgOkNWGGWUWk8tGIPjuA6wYlUM6y3+sCCIwRW4Y9nQItYbdN1RKZrtYbnrIsY7mrrceja0YZeimowB8+O/JwSAWqZ9aTFRu6c7Mz3fJ+TVUHlkUz7wV4C4cIwgfyWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TYs5yBS8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1df01161b39so5256455ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711605554; x=1712210354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irQLRsi22SkraHK4lMxqFBwPYj6fd+go4MNyv3pAG9Y=;
        b=TYs5yBS8XJKFeTDn+0HELCB9zGvagMTmJWaUKYLXcGUJWZRFuh6FemLHD/uAO4LvcD
         I2Fo9VTKqVPFahvw4nsYsryjZQ0qxU3uI/WDlnEOfufuxDd/2iy02uAalpIJ0SsC+r3j
         L1Ak88eH1AM3KLc/aLaPo9uCKhdDMNzt+k5n3YPkP+9IFdrMZOgpdZBrBA7u2/LNYxAu
         xDO9rhdf2t8Yfsw1lu0BpGRJ3rOFaTjVGZTo4ppVEdu8JXjvV3Lmk9vE8a9+p3v5V6Hj
         /+tDZkYc7HfzvCueMJpoOBVJmYYWgu4n5xEwA6f4ugOfzX4E6Hb2KWETaqtZqacZGWuY
         M+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711605554; x=1712210354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irQLRsi22SkraHK4lMxqFBwPYj6fd+go4MNyv3pAG9Y=;
        b=eXsS6QpU8u1pcYxkieyppYFOupBlG66iB6g9krn2AUQJuHqZ+E8aw4tmzRM2nUQvb0
         ZP7xwq9hbJJFW9kMZj5w2QiTHqkbVtORN5ZmmOj1s8/Qy9kKw05qV7RWjbApdRK7ENCl
         /sP8n6kap1Js3R4+j1Ngepu9IkrtyT69BQlNdN5Idqd1XNL66F/br407SZf0VzWgx93j
         CS9ERLSJsLUUsGIW8cxL6XPblu+/l36WPbCmrM9HYzrhp9FBL7bNDC3NHc0ryT1YO5oU
         wqVFR5qV+xW/hc6SiRYhCluLjE1lcu6mH5+tBksZZ+KhS+brzPMe1cLuORdZLxBxtopH
         O1xA==
X-Forwarded-Encrypted: i=1; AJvYcCXpVeWuG3Q7yK5YPerx4ejWgKP3HILpMB14rylg2/1x683eK0QQGwWWxTkHGIA/Kb8WpXFcrbnk1obig50of2h+zZQ3JGhhfn4Deyr4
X-Gm-Message-State: AOJu0YxpxqG47PPeQbDuycuLklvYkzXgw4wpFCscrEs3ihWpD7+slIKt
	Q2cwbMpn8n0OYCC36yj8l3OsOLkoBy0mEwIyBJvBvN+gCDwdTU19AkWltEVN+TQ=
X-Google-Smtp-Source: AGHT+IGxL8g/d32e19PrXxu6Kp/faCdNfJNa6+6FITTlKuZg+NQhRbIo6OP8iZKzSLZu0zLul61+cg==
X-Received: by 2002:a17:902:e884:b0:1e0:2c80:2aaf with SMTP id w4-20020a170902e88400b001e02c802aafmr2348711plg.44.1711605554542;
        Wed, 27 Mar 2024 22:59:14 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.8])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902d34900b001e0b461d104sm595984plk.67.2024.03.27.22.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 22:59:14 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH 2/2] perf evsel: Use evsel__name_is() helper
Date: Thu, 28 Mar 2024 13:58:57 +0800
Message-Id: <20240328055857.383180-2-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328055857.383180-1-yangjihong@bytedance.com>
References: <20240328055857.383180-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Code cleanup, replace strcmp(evsel__name(evsel, {NAME})) with
evsel__name_is() helper.

No functional change.

Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/builtin-kmem.c               |  2 +-
 tools/perf/builtin-sched.c              |  4 +--
 tools/perf/builtin-script.c             |  2 +-
 tools/perf/builtin-trace.c              |  4 +--
 tools/perf/tests/evsel-roundtrip-name.c |  4 +--
 tools/perf/tests/parse-events.c         | 39 +++++++++----------------
 6 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 9714327fd0ea..6fd95be5032b 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1408,7 +1408,7 @@ static int __cmd_kmem(struct perf_session *session)
 	}
 
 	evlist__for_each_entry(session->evlist, evsel) {
-		if (!strcmp(evsel__name(evsel), "kmem:mm_page_alloc") &&
+		if (evsel__name_is(evsel, "kmem:mm_page_alloc") &&
 		    evsel__field(evsel, "pfn")) {
 			use_pfn = true;
 			break;
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 1bfb22347371..0fce7d8986c0 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2148,7 +2148,7 @@ static bool is_idle_sample(struct perf_sample *sample,
 			   struct evsel *evsel)
 {
 	/* pid 0 == swapper == idle task */
-	if (strcmp(evsel__name(evsel), "sched:sched_switch") == 0)
+	if (evsel__name_is(evsel, "sched:sched_switch"))
 		return evsel__intval(evsel, sample, "prev_pid") == 0;
 
 	return sample->pid == 0;
@@ -2375,7 +2375,7 @@ static bool timehist_skip_sample(struct perf_sched *sched,
 	}
 
 	if (sched->idle_hist) {
-		if (strcmp(evsel__name(evsel), "sched:sched_switch"))
+		if (!evsel__name_is(evsel, "sched:sched_switch"))
 			rc = true;
 		else if (evsel__intval(evsel, sample, "prev_pid") != 0 &&
 			 evsel__intval(evsel, sample, "next_pid") != 0)
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 37088cc0ff1b..cc981531ec00 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3471,7 +3471,7 @@ static int check_ev_match(char *dir_name, char *scriptname,
 
 			match = 0;
 			evlist__for_each_entry(session->evlist, pos) {
-				if (!strcmp(evsel__name(pos), evname)) {
+				if (evsel__name_is(pos, evname)) {
 					match = 1;
 					break;
 				}
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 90eaff8c0f6e..9b93807a1906 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4902,7 +4902,7 @@ int cmd_trace(int argc, const char **argv)
 		goto out;
 	}
 	trace.syscalls.events.bpf_output = evlist__last(trace.evlist);
-	assert(!strcmp(evsel__name(trace.syscalls.events.bpf_output), "__augmented_syscalls__"));
+	assert(evsel__name_is(trace.syscalls.events.bpf_output), "__augmented_syscalls__");
 skip_augmentation:
 #endif
 	err = -1;
@@ -4959,7 +4959,7 @@ int cmd_trace(int argc, const char **argv)
 	 */
 	if (trace.syscalls.events.bpf_output) {
 		evlist__for_each_entry(trace.evlist, evsel) {
-			bool raw_syscalls_sys_exit = strcmp(evsel__name(evsel), "raw_syscalls:sys_exit") == 0;
+			bool raw_syscalls_sys_exit = evsel__name_is(evsel, "raw_syscalls:sys_exit");
 
 			if (raw_syscalls_sys_exit) {
 				trace.raw_augmented_syscalls = true;
diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index 15ff86f9da0b..1922cac13a24 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -37,7 +37,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 					continue;
 				}
 				evlist__for_each_entry(evlist, evsel) {
-					if (strcmp(evsel__name(evsel), name)) {
+					if (!evsel__name_is(evsel, name)) {
 						pr_debug("%s != %s\n", evsel__name(evsel), name);
 						ret = TEST_FAIL;
 					}
@@ -71,7 +71,7 @@ static int perf_evsel__name_array_test(const char *const names[], int nr_names)
 			continue;
 		}
 		evlist__for_each_entry(evlist, evsel) {
-			if (strcmp(evsel__name(evsel), names[i])) {
+			if (!evsel__name_is(evsel, names[i])) {
 				pr_debug("%s != %s\n", evsel__name(evsel), names[i]);
 				ret = TEST_FAIL;
 			}
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index feb5727584d1..0b70451451b3 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -470,8 +470,7 @@ static int test__checkevent_breakpoint_modifier(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong name",
-			!strcmp(evsel__name(evsel), "mem:0:u"));
+	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "mem:0:u"));
 
 	return test__checkevent_breakpoint(evlist);
 }
@@ -484,8 +483,7 @@ static int test__checkevent_breakpoint_x_modifier(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong name",
-			!strcmp(evsel__name(evsel), "mem:0:x:k"));
+	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "mem:0:x:k"));
 
 	return test__checkevent_breakpoint_x(evlist);
 }
@@ -498,8 +496,7 @@ static int test__checkevent_breakpoint_r_modifier(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong name",
-			!strcmp(evsel__name(evsel), "mem:0:r:hp"));
+	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "mem:0:r:hp"));
 
 	return test__checkevent_breakpoint_r(evlist);
 }
@@ -512,8 +509,7 @@ static int test__checkevent_breakpoint_w_modifier(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong name",
-			!strcmp(evsel__name(evsel), "mem:0:w:up"));
+	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "mem:0:w:up"));
 
 	return test__checkevent_breakpoint_w(evlist);
 }
@@ -526,8 +522,7 @@ static int test__checkevent_breakpoint_rw_modifier(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong name",
-			!strcmp(evsel__name(evsel), "mem:0:rw:kp"));
+	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "mem:0:rw:kp"));
 
 	return test__checkevent_breakpoint_rw(evlist);
 }
@@ -540,8 +535,7 @@ static int test__checkevent_breakpoint_modifier_name(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong name",
-			!strcmp(evsel__name(evsel), "breakpoint"));
+	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint"));
 
 	return test__checkevent_breakpoint(evlist);
 }
@@ -554,8 +548,7 @@ static int test__checkevent_breakpoint_x_modifier_name(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong name",
-			!strcmp(evsel__name(evsel), "breakpoint"));
+	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint"));
 
 	return test__checkevent_breakpoint_x(evlist);
 }
@@ -568,8 +561,7 @@ static int test__checkevent_breakpoint_r_modifier_name(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong name",
-			!strcmp(evsel__name(evsel), "breakpoint"));
+	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint"));
 
 	return test__checkevent_breakpoint_r(evlist);
 }
@@ -582,8 +574,7 @@ static int test__checkevent_breakpoint_w_modifier_name(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong name",
-			!strcmp(evsel__name(evsel), "breakpoint"));
+	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint"));
 
 	return test__checkevent_breakpoint_w(evlist);
 }
@@ -596,8 +587,7 @@ static int test__checkevent_breakpoint_rw_modifier_name(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong name",
-			!strcmp(evsel__name(evsel), "breakpoint"));
+	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint"));
 
 	return test__checkevent_breakpoint_rw(evlist);
 }
@@ -609,12 +599,12 @@ static int test__checkevent_breakpoint_2_events(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong name", !strcmp(evsel__name(evsel), "breakpoint1"));
+	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint1"));
 
 	evsel = evsel__next(evsel);
 
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong name", !strcmp(evsel__name(evsel), "breakpoint2"));
+	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint2"));
 
 	return TEST_OK;
 }
@@ -691,15 +681,14 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
-	TEST_ASSERT_VAL("wrong name", !strcmp(evsel__name(evsel), "krava"));
+	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "krava"));
 
 	/* cpu/config=2/u" */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", test_config(evsel, 2));
-	TEST_ASSERT_VAL("wrong name",
-			!strcmp(evsel__name(evsel), "cpu/config=2/u"));
+	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "cpu/config=2/u"));
 
 	return TEST_OK;
 }
-- 
2.25.1


