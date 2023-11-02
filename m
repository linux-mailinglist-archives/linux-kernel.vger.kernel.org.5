Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6847DF971
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbjKBSAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377259AbjKBR72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:59:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4940E10F3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:58:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b3715f3b41so16864837b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947931; x=1699552731; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjGLpULVRUxYABNs8KK8hib6JmANLHcuQm1tIO1QTLc=;
        b=ER89x3QBSjW75W4RiQdRTVKtAxJHVgvda9Wayj8xyj7MRXcx4tLWCOeoLY4QQ/S6oH
         F/+U79jPBKgdjYjmmTi4JZMnc04mDRMvXrIWEo7LW/pfBNqdetmIfEK0zhHEWI8drs9D
         RHi6LGkMDc6JqV0h1MAgeAfscLsnwmQaQ+fEj+/6dIDa2MQEDrIQ//6/mFNQ8Y8jxdoV
         wzVde1G5nZ8o32XkKO41x6CZe/CDlVukhGIsY5m3fSctSrh1xEsSR9YO2l0smLMPNimI
         ZqlHuLtC37bxumhr2GPvKs9YogLsOTGYArBXhmBEkc6500EJSLVv/BGIq3qFFiHwnNCE
         /3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947931; x=1699552731;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjGLpULVRUxYABNs8KK8hib6JmANLHcuQm1tIO1QTLc=;
        b=G7S8AztorjzL8ZHXiNh/qyO2XcT/6mQEUTUNK+Mqlo0Uvt46uAzBR7Pd5Cpf3oDA+c
         Fh8M6E7x5T2ChhYgLI4/6eYDkvceR305DTEvIe3ezj6bAyc3XTbJf5M2JcIdS9uNlJLi
         iY9G6E5Omb+JXakziGA30ObpK/4v/R0hYFAVoqI65Ow8D3bcAAzxCH62Gs8DNSXpQZku
         Yd/Gm55DwlG+f9XqSfR2qI0cHEkHUyd8tW9R5Wi1GQT1Ohjpuv//Fn2dkVzsa4JQ5AA9
         Lt047gTRbMAlKES41lLdG4ZWIjZAlOZsmutSw+JnjxOJpfHL51uJ6zaE1i+AZeheGQOB
         0Lrw==
X-Gm-Message-State: AOJu0Yx8vgIG+DzNRs+VSpKWsydQAmG9Eeu/bakDdzzc1K/PUuG+bEuE
        IaF8YviUiHwVOQ2sCm8gAHrmTYoG5pxy
X-Google-Smtp-Source: AGHT+IEaqoxnS8RYuF+B0Tq+gELTQ54gaKcVVdKaiSS1qLvvW9EX9LtcaPvY9lTdk6v6MN54IVKOKzEE90HZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a81:5249:0:b0:5a1:d329:829c with SMTP id
 g70-20020a815249000000b005a1d329829cmr9123ywb.0.1698947931428; Thu, 02 Nov
 2023 10:58:51 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:57:06 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-25-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 24/53] perf maps: Add maps__load_first
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid bpf_lock_contention_touching the internal maps data structure by
adding a helper function. As access is done directly on the map in
maps, hold the read lock to stop it being removed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_lock_contention.c |  2 +-
 tools/perf/util/maps.c                | 13 +++++++++++++
 tools/perf/util/maps.h                |  2 ++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index e105245eb905..d9720a910330 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -317,7 +317,7 @@ int lock_contention_read(struct lock_contention *con)
 	}
 
 	/* make sure it loads the kernel map */
-	map__load(maps__first(machine->kmaps)->map);
+	maps__load_first(machine->kmaps);
 
 	prev_key = NULL;
 	while (!bpf_map_get_next_key(fd, prev_key, &key)) {
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 85bea2a6dca9..9a84d26328a7 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -792,3 +792,16 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 	}
 	return err;
 }
+
+void maps__load_first(struct maps *maps)
+{
+	struct map_rb_node *first;
+
+	down_read(maps__lock(maps));
+
+	first = maps__first(maps);
+	if (first)
+		map__load(first->map);
+
+	up_read(maps__lock(maps));
+}
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index e4a49d6ff5cf..b7ab3ec61b7c 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -142,4 +142,6 @@ void __maps__sort_by_name(struct maps *maps);
 
 void maps__fixup_end(struct maps *maps);
 
+void maps__load_first(struct maps *maps);
+
 #endif // __PERF_MAPS_H
-- 
2.42.0.869.gea05f2083d-goog

