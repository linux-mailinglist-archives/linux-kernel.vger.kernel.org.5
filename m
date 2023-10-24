Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF787D5E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344576AbjJXWZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344558AbjJXWZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:25:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CB510D1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a839b31a0dso94314447b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186280; x=1698791080; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3RrFaAylSJfbHKcTDzvj4sdZE51LV5H16MsLijA4K8=;
        b=UEQxx/EE0WtiG9dMIp4bJpg1YKY88bG+AufaRZWd9HFwxpHH5JY2Fl1U16waQAeGEO
         uRa+PYvkIDGXPxN6K6ecLrp2PIQem4YVBdIEinc0kRyfAHOMkclMGXkJsCKfq+8wz9no
         of0a/G3PxbIgUTFZ1Zgy2ERPtV83GcjlyIHcDmnccPogIiVL//y7hufQC85+tfkZyX++
         8yt+S72qyrnHrWRwu23IlpgX2Rtjo4bq4H4vi5gjVvJWTJItoe4xo9T3DGF+vkJ1Qyei
         lw020vG7K2N3so94j/txWSbAWkF/3fHzhCxH9grblZsqpZiw/bjb0KIsai0xuxHOUs4E
         MG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186280; x=1698791080;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3RrFaAylSJfbHKcTDzvj4sdZE51LV5H16MsLijA4K8=;
        b=pwmEFzHCY1hvr9iWWDGOeU4MrgWt2ucqv6jwBE/1xHmgyZTwYrTFuW+hznB0k/TYuh
         Fq9RxEwky2/pGbTUNP5BiHYc7BtOzJ9qAai2aGf6vudP4Tn3gNuryhnTr4RmTFVH7+2q
         r4SDT9pjE+OtRv5tFkZkxJOEJigrgnPgnmFIYwhuivVIZU2yRjRJQnmBQp1zJu/RKk9T
         VwN66A3pUQvDbmJBhByJ9H82RBNBH/0QewTwLLhtoQpkW5dhUWUAWmXwyIkSQBaHDW9+
         MtyQNOaDh0qr3aomodF9oTSYAMsX2igV5Cnqfx6g2zuBYXL7Mc8elyeZSviYgyRQBDwx
         vLNw==
X-Gm-Message-State: AOJu0YzwIJIU5DmWdu3m6SgrE1gUIOlyw/2KnT1CtouB5jO3HiV/uE1j
        xBco5SuELiURBF/7tO2c+vVb6hDhuDml
X-Google-Smtp-Source: AGHT+IG7PiEiZBvMWRGIx6ray9LXHq/rj6CT4JZEt1Y0UxVGlAZHKrDrvwGEiXycViuLesPoNC5gYWcPDgX+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a81:5206:0:b0:5a7:b672:4d88 with SMTP id
 g6-20020a815206000000b005a7b6724d88mr288070ywb.0.1698186279736; Tue, 24 Oct
 2023 15:24:39 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:15 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-13-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 12/50] perf record: Lazy load kernel symbols
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
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
2.42.0.758.gaed0368e0e-goog

