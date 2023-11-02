Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83ABD7DFD52
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 00:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjKBXkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 19:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBXkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 19:40:18 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5F4191;
        Thu,  2 Nov 2023 16:40:15 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so1612356b3a.2;
        Thu, 02 Nov 2023 16:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698968415; x=1699573215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nwx33ziTZV4oUTDb3pCxYB5gse6/L8kFAcjyGJ3wPjU=;
        b=ardE/e/OFV1WVFlgbsyEk9GhQwbAaJNkEvpDjOTNdlItw7+NYESIYN3Vn17Cloj2k4
         cPmFj8wN9jveXutC5MFUtmUyJSFm8JvoEfoCaD+6pDN7YT8GWsysXFvlKzDCCGdPhCSl
         tfrTiODYbaSi3Ro6R9AX/xmmRshyH8PZJl2NrDkDzEP44YLkvaE2yt1JBeX+ogX4Wk/Y
         rjYSCJdLKrcPJHSNEEw/PUi7QxiLqkHaS++nSbkeojENcXzdOoXduw3Jtq8AAcqtEBfe
         fwNV0eNdpbvklD7pEojClnt5DsB6plw3VdsAGNB8m7ikCiQkYVT8ujczEqD0yZvPmK6v
         LTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698968415; x=1699573215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwx33ziTZV4oUTDb3pCxYB5gse6/L8kFAcjyGJ3wPjU=;
        b=OPEl1va01NKi7Lj1xTYUeU0BH4r7G9eXiuH9/gWioXvceab81gA8FNYjSK4hi4+h97
         bGEtozcf3YibqW/3EK0Oh+sKWq9eCHN7IVgbTzEGBwZyv6iCyQT7Bsg434o/snUrZaIM
         zre31VgRmXa3mC6L6g3gs7qgHAyOu8gJs+jW15650cKrVRiOIjNADjPpmmfzLNLCxKwA
         GByUQDs3axuNhLUJ+eXQxMGzIAqvfYEGsPinuR5XsGXnKbGZQhTgez5QPb6POVJDEn5v
         wxZDL4bOG0PfQ/nICzTAXDUA3VZCFhcydLg5T34C2MtSwHsxjEjyirxOi6DhA2hGRMFo
         FR0A==
X-Gm-Message-State: AOJu0YznBYFQBZ0cfM0AfvZq7wVZvEu12jAOTj4kpbe/UYc5t4E76K0s
        Av9uKz+gX4hSTz4stdKNLAg=
X-Google-Smtp-Source: AGHT+IFRS21vfiNTeBTx4JqrE7f8vfAvs3pKAEuVgNnJ8sC6kaivycMOu4gEyZ/kviWnLj7RWvebeg==
X-Received: by 2002:a05:6a21:35c2:b0:181:219f:4a76 with SMTP id ba2-20020a056a2135c200b00181219f4a76mr8749304pzc.38.1698968414935;
        Thu, 02 Nov 2023 16:40:14 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:ea22:bed1:d67b:af04])
        by smtp.gmail.com with ESMTPSA id 184-20020a6308c1000000b005bd2b3a03eesm266410pgi.6.2023.11.02.16.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 16:40:14 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Simplify object code reading test
Date:   Thu,  2 Nov 2023 16:40:13 -0700
Message-ID: <20231102234013.4188687-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It tries cycles (or cpu-clock on s390) event with exclude_kernel bit to
open.  But other arch on a VM can fail with the hardware event and need
to fallback to the software event in the same way.

So let's get rid of the cpuid check and use generic fallback mechanism
using an array of event candidates.  Now event in the odd index excludes
the kernel so use that for the return value.

Cc: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/code-reading.c | 76 ++++++++++-----------------------
 1 file changed, 23 insertions(+), 53 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 3af81012014e..047ba297c6fa 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -511,38 +511,6 @@ static void fs_something(void)
 	}
 }
 
-#ifdef __s390x__
-#include "header.h" // for get_cpuid()
-#endif
-
-static const char *do_determine_event(bool excl_kernel)
-{
-	const char *event = excl_kernel ? "cycles:u" : "cycles";
-
-#ifdef __s390x__
-	char cpuid[128], model[16], model_c[16], cpum_cf_v[16];
-	unsigned int family;
-	int ret, cpum_cf_a;
-
-	if (get_cpuid(cpuid, sizeof(cpuid)))
-		goto out_clocks;
-	ret = sscanf(cpuid, "%*[^,],%u,%[^,],%[^,],%[^,],%x", &family, model_c,
-		     model, cpum_cf_v, &cpum_cf_a);
-	if (ret != 5)		 /* Not available */
-		goto out_clocks;
-	if (excl_kernel && (cpum_cf_a & 4))
-		return event;
-	if (!excl_kernel && (cpum_cf_a & 2))
-		return event;
-
-	/* Fall through: missing authorization */
-out_clocks:
-	event = excl_kernel ? "cpu-clock:u" : "cpu-clock";
-
-#endif
-	return event;
-}
-
 static void do_something(void)
 {
 	fs_something();
@@ -583,8 +551,10 @@ static int do_test_code_reading(bool try_kcore)
 	int err = -1, ret;
 	pid_t pid;
 	struct map *map;
-	bool have_vmlinux, have_kcore, excl_kernel = false;
+	bool have_vmlinux, have_kcore;
 	struct dso *dso;
+	const char *events[] = { "cycles", "cycles:u", "cpu-clock", "cpu-clock:u", NULL };
+	int evidx = 0;
 
 	pid = getpid();
 
@@ -618,7 +588,7 @@ static int do_test_code_reading(bool try_kcore)
 
 	/* No point getting kernel events if there is no kernel object */
 	if (!have_vmlinux && !have_kcore)
-		excl_kernel = true;
+		evidx++;
 
 	threads = thread_map__new_by_tid(pid);
 	if (!threads) {
@@ -646,7 +616,7 @@ static int do_test_code_reading(bool try_kcore)
 		goto out_put;
 	}
 
-	while (1) {
+	while (events[evidx]) {
 		const char *str;
 
 		evlist = evlist__new();
@@ -657,7 +627,7 @@ static int do_test_code_reading(bool try_kcore)
 
 		perf_evlist__set_maps(&evlist->core, cpus, threads);
 
-		str = do_determine_event(excl_kernel);
+		str = events[evidx];
 		pr_debug("Parsing event '%s'\n", str);
 		ret = parse_event(evlist, str);
 		if (ret < 0) {
@@ -675,32 +645,32 @@ static int do_test_code_reading(bool try_kcore)
 
 		ret = evlist__open(evlist);
 		if (ret < 0) {
-			if (!excl_kernel) {
-				excl_kernel = true;
-				/*
-				 * Both cpus and threads are now owned by evlist
-				 * and will be freed by following perf_evlist__set_maps
-				 * call. Getting reference to keep them alive.
-				 */
-				perf_cpu_map__get(cpus);
-				perf_thread_map__get(threads);
-				perf_evlist__set_maps(&evlist->core, NULL, NULL);
-				evlist__delete(evlist);
-				evlist = NULL;
-				continue;
-			}
+			evidx++;
 
-			if (verbose > 0) {
+			if (events[evidx] == NULL && verbose > 0) {
 				char errbuf[512];
 				evlist__strerror_open(evlist, errno, errbuf, sizeof(errbuf));
 				pr_debug("perf_evlist__open() failed!\n%s\n", errbuf);
 			}
 
-			goto out_put;
+			/*
+			 * Both cpus and threads are now owned by evlist
+			 * and will be freed by following perf_evlist__set_maps
+			 * call. Getting reference to keep them alive.
+			 */
+			perf_cpu_map__get(cpus);
+			perf_thread_map__get(threads);
+			perf_evlist__set_maps(&evlist->core, NULL, NULL);
+			evlist__delete(evlist);
+			evlist = NULL;
+			continue;
 		}
 		break;
 	}
 
+	if (events[evidx] == NULL)
+		goto out_put;
+
 	ret = evlist__mmap(evlist, UINT_MAX);
 	if (ret < 0) {
 		pr_debug("evlist__mmap failed\n");
@@ -721,7 +691,7 @@ static int do_test_code_reading(bool try_kcore)
 		err = TEST_CODE_READING_NO_KERNEL_OBJ;
 	else if (!have_vmlinux && !try_kcore)
 		err = TEST_CODE_READING_NO_VMLINUX;
-	else if (excl_kernel)
+	else if (evidx % 2)
 		err = TEST_CODE_READING_NO_ACCESS;
 	else
 		err = TEST_CODE_READING_OK;
-- 
2.42.0.869.gea05f2083d-goog

