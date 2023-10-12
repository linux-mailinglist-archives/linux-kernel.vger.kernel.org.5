Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283547C6583
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377455AbjJLGZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377453AbjJLGYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:24:48 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF781A3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:24:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7a6fd18abso9897927b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091870; x=1697696670; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fc/6/O/gRte1zMhmeMtD4ohISB3aWdPXWc8V2/IjDG4=;
        b=MfjQ5C7JEOErhS+sVyt+9BIu5x/F+EcfbqxY16YvfH+Baa1uydnkaaaYfeNb++GAhe
         w1jyj9CRpk9NtQvcuVy0u8EgsYvvICa06QNJGL60h6i1fNgf6a6eec6bbWSHgn9MylgN
         ctHoEn3sNsfj17CE9duwG0Bt25OAZbgB5aOLWOMaeZIxRP1wm1cyCvbm4lnSbrqK6J7T
         FjjHz3WCelmLYsstXYwiICf40c9lSzvWP+JzzaATTDQuiHLMs8ZhSdTHGTz5Fk3VVVEV
         labXbkeucDueh9576aAAymNQDILXk4SL3yfSOXvYg7Wk8wqWmtjhHPUjLgpuc1NODLkv
         KcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091870; x=1697696670;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fc/6/O/gRte1zMhmeMtD4ohISB3aWdPXWc8V2/IjDG4=;
        b=JeQ8y4sZW8FhFE2q/ErWDBeUHvDF6MnMviuK7oLWPxqo6e5aYq7wjPI2DeuZhldHrS
         0UBlk/ziFCByar0zZ6lSXJQk8hG84qpAbhHLpCZtqIsjRNWS2lJB1e3rK05CkqD15XAm
         nRNVc+2E2ijV+mMOUzaV9w8i33QWBco4F0SROJpNhcZdv07/NWRb/b01c51bqF/YIiBj
         dviotIwI/9WBDfLFENNewQH6HM8bU3C+MCkJu5zbRU7tZ18ReI2bIK/y5PBc3PbhXmp2
         JSwDeuu3atZ9JmRsdT4Myz3TfSwpG7busHsat96iwmqngpQ+chwyqX8BzvotCf81RHG4
         UT9Q==
X-Gm-Message-State: AOJu0YwBALAdaDRGAzeps3Wzy0iwVjucWAk15wiVVWBNfxl/zW2rai20
        rBHzX4ioN3eOygg/JNwQQvw6w/KLiBvx
X-Google-Smtp-Source: AGHT+IHw9CWAC8FY76ZB7h38HkJJCF9yox3JXqj1NldAlfSd6AeHsF169JHHn8w35OGyvCUjrw3Xt+ij0Xpl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a81:4005:0:b0:5a7:be34:345 with SMTP id
 l5-20020a814005000000b005a7be340345mr175704ywn.6.1697091870082; Wed, 11 Oct
 2023 23:24:30 -0700 (PDT)
Date:   Wed, 11 Oct 2023 23:23:56 -0700
In-Reply-To: <20231012062359.1616786-1-irogers@google.com>
Message-Id: <20231012062359.1616786-11-irogers@google.com>
Mime-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 10/13] perf record: Lazy load kernel symbols
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Artem Savkov <asavkov@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5b7ba82a7591 ("perf symbols: Load kernel maps before using")
changed it so that loading a kernel dso would cause the symbols for
the dso to be eagerly loaded. For perf record this is overhead as the
symbols won't be used. Add a symbol_conf to control the behavior and
disable it for perf record and perf inject.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c   | 4 ++++
 tools/perf/builtin-record.c   | 2 ++
 tools/perf/util/event.c       | 4 ++--
 tools/perf/util/symbol_conf.h | 3 ++-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index c8cf2fdd9cff..1539fb18c749 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2265,6 +2265,10 @@ int cmd_inject(int argc, const char **argv)
 		"perf inject [<options>]",
 		NULL
 	};
+
+	/* Disable eager loading of kernel symbols that adds overhead to perf inject. */
+	symbol_conf.lazy_load_kernel_maps = true;
+
 #ifndef HAVE_JITDUMP
 	set_option_nobuild(options, 'j', "jit", "NO_LIBELF=1", true);
 #endif
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index dcf288a4fb9a..8ec818568662 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3989,6 +3989,8 @@ int cmd_record(int argc, const char **argv)
 # undef set_nobuild
 #endif
 
+	/* Disable eager loading of kernel symbols that adds overhead to perf record. */
+	symbol_conf.lazy_load_kernel_maps = true;
 	rec->opts.affinity = PERF_AFFINITY_SYS;
 
 	rec->evlist = evlist__new();
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 923c0fb15122..68f45e9e63b6 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -617,13 +617,13 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 	if (cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
 		al->level = 'k';
 		maps = machine__kernel_maps(machine);
-		load_map = true;
+		load_map = !symbol_conf.lazy_load_kernel_maps;
 	} else if (cpumode == PERF_RECORD_MISC_USER && perf_host) {
 		al->level = '.';
 	} else if (cpumode == PERF_RECORD_MISC_GUEST_KERNEL && perf_guest) {
 		al->level = 'g';
 		maps = machine__kernel_maps(machine);
-		load_map = true;
+		load_map = !symbol_conf.lazy_load_kernel_maps;
 	} else if (cpumode == PERF_RECORD_MISC_GUEST_USER && perf_guest) {
 		al->level = 'u';
 	} else {
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 0b589570d1d0..2b2fb9e224b0 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -42,7 +42,8 @@ struct symbol_conf {
 			inline_name,
 			disable_add2line_warn,
 			buildid_mmap2,
-			guest_code;
+			guest_code,
+			lazy_load_kernel_maps;
 	const char	*vmlinux_name,
 			*kallsyms_name,
 			*source_prefix,
-- 
2.42.0.609.gbb76f46606-goog

