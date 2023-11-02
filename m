Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712047DF94C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345282AbjKBR6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344655AbjKBR6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:58:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545E7186
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:58:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da0cb98f66cso1414532276.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947880; x=1699552680; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6YkPiUH9uglH2B5aguvlMewabUbKr7KGsfTMSN6Qd6M=;
        b=OlWQzUDstSqpKPyqmQbBQtmdgsv4UDJlzF96FlJD/RyCEC/dOfM595IuSkOYctRti7
         i0iQCV98JKydCBjT6a8eWgtgPuqoF7lOu399u142TJUCykP7bScqpNPch7VcP6bB/90x
         kh8kZfZKjMahhFKTTfXQICbP2z10BkzK/Srq/Z25NI5dAbzSMXzMDy75SSweuugWk5MZ
         LYwEj6FBujqcutRa/Ny2/Q1IIErRjMFI1fS6DbFPoKyHAhDddStl58SssgXwjxJ5zVH2
         PfD/0GAXXuW8I7UQOULH8PssVPF4m6cCQazyqy5pCEUilNr0YMq3q3R22Ys6YLvzl0JT
         tPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947880; x=1699552680;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6YkPiUH9uglH2B5aguvlMewabUbKr7KGsfTMSN6Qd6M=;
        b=IZnaBZYUO3Prp1wcTpDpoDuE6S6JG/mo11knQFuiQ7G4ToTRWAuSRWpUbjVFctoGO7
         7REe3/ECQOoXJHHTQyQNPQCYB4GBDt+J7BwP7FVvi1Cx5pKTu7IqOTnd8AtYdKVxdZnZ
         Uj4h5VTFEBL9UUSdyiDg/1pXPN5uZu+2fp1Pn16p2wdTwEQ8JaEQ+Du9z7EYl+x18FLT
         e971dmC3BqnyHQ4HsUIyPCyCtMCUxuaZ+f3PL9x71K5hwJUsRmxMsyYaeOKgd+KwzZd5
         Qe86hTinkMm2crU5Y/Vn/8N1Ye6wHtvJ67wDnQGlo4bvSjstfTpWWDqrFdgIcEm4/Tht
         W0JA==
X-Gm-Message-State: AOJu0YxeBnzt4vEyvEHsp9zHVEJfKhj3UEVdj5899HnPMCy8jkyolOjN
        GHSpP8ZIsY3HXS9997fIj0eqHiO4BsDe
X-Google-Smtp-Source: AGHT+IFAYbM1/j+8aRo54ZHb+eR4podUcUkBtWOjip+Fy4WIlGGxkvrc8Lq8EkTVS9PnfCE/4VDkVHWOQD1B
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a05:6902:168c:b0:da0:3e46:8ba5 with SMTP
 id bx12-20020a056902168c00b00da03e468ba5mr359878ybb.8.1698947880465; Thu, 02
 Nov 2023 10:58:00 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:56:44 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-3-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 02/53] perf record: Lazy load kernel symbols
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
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
 tools/perf/builtin-inject.c   | 6 ++++++
 tools/perf/builtin-record.c   | 2 ++
 tools/perf/util/event.c       | 4 ++--
 tools/perf/util/symbol_conf.h | 3 ++-
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index c8cf2fdd9cff..eb3ef5c24b66 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2265,6 +2265,12 @@ int cmd_inject(int argc, const char **argv)
 		"perf inject [<options>]",
 		NULL
 	};
+
+	if (!inject.itrace_synth_opts.set) {
+		/* Disable eager loading of kernel symbols that adds overhead to perf inject. */
+		symbol_conf.lazy_load_kernel_maps = true;
+	}
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
2.42.0.869.gea05f2083d-goog

