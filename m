Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAAE7C6582
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377551AbjJLGYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377742AbjJLGYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:24:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7C913D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:24:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a3a98b34dso877980276.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091868; x=1697696668; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=la0kth5B8NAHJ/7CJQBnk0UfsTSlln3eEBL7Ofw1InE=;
        b=3KuoHDwI9ZKC4f52zPq/dwdG1hbh/cR5fj1PeoFeKz4+XwN82Fbt/nMwA0gCS/qptp
         XuN1MVxbjX4hjM4mbN/AC9KsqtnRiXqWo6Ac/OsiOWiYYhBVgjzAhPc/YDTzREE0w4oT
         6/0ea9mt0+2UowtLjk23ARu8B5Q44uQYD5rWZ9GzpMaEIJvOnzhzoPJO3q6nqmBnarcK
         0m3VDdDhrQp5AxQrYCnrqkua7foOmHLY0Z8HJyWaKmjdsrz9J+d5d9cAa9ISHlTcCEwK
         K9I14AxHOMJHI5M2kJ5gQUEmRBxW+pJwS3QvDBdrq5noajpPzxffw2fS30qqdpFWberO
         4QDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091868; x=1697696668;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=la0kth5B8NAHJ/7CJQBnk0UfsTSlln3eEBL7Ofw1InE=;
        b=V+oNZc9feNcXbOlWI670sH4f20fI2E1ExpVbMmA85JV8scSLUkabn7NXuYW4PlTMbC
         TLU4NbPsMrFv5sRfphx7KUhJipgdDaK81CBtWwuMPMVmS13OyPUFmmdI9d2sDWj8W/dR
         zfxZ3EW//vlOLNfeAya/hEIv+0I37JwCmXPgmj5Jxg5Tr068MwVUjdFsNnW+1dQo15av
         eEYPM7zV9jTQL87ac6AzVDEGJeJKg+mmxV3EJFD1TEGw3lPeayYPckO34cqNqwQG2U/T
         1SUhZKOpLG72IcEPymMZuncnJgyP3mI25J2PC4i/ICdWErsCn2rP7C4BLtRgbad+TSjh
         pLbQ==
X-Gm-Message-State: AOJu0YwBXujnqi9PCkIw7k9NzXeT4FDfFrEwc5/iYjDzsZ5unuVKBiFq
        O0ygIYfyablj8ftxyEBI9Y69n3KU+9oO
X-Google-Smtp-Source: AGHT+IEb5QCBrWCeAuptIs138Qw6ImZJcMdt+KABfOynkd4duT5ZLjm6TicU9k5h79l3BQQyxZZZa02wvlZ0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a25:cfd0:0:b0:d9a:50d2:a8ba with SMTP id
 f199-20020a25cfd0000000b00d9a50d2a8bamr141489ybg.2.1697091867872; Wed, 11 Oct
 2023 23:24:27 -0700 (PDT)
Date:   Wed, 11 Oct 2023 23:23:55 -0700
In-Reply-To: <20231012062359.1616786-1-irogers@google.com>
Message-Id: <20231012062359.1616786-10-irogers@google.com>
Mime-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 09/13] perf mem_info: Add and use map_symbol__exit and addr_map_symbol__exit
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

Fix leak where mem_info__put wouldn't release the maps/map as used by
perf mem. Add exit functions and use elsewhere that the maps and map
are released.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build        |  1 +
 tools/perf/util/callchain.c  | 15 +++++----------
 tools/perf/util/hist.c       |  6 ++----
 tools/perf/util/machine.c    |  6 ++----
 tools/perf/util/map_symbol.c | 15 +++++++++++++++
 tools/perf/util/map_symbol.h |  4 ++++
 tools/perf/util/symbol.c     |  5 ++++-
 7 files changed, 33 insertions(+), 19 deletions(-)
 create mode 100644 tools/perf/util/map_symbol.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 0ea5a9d368d4..96058f949ec9 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -49,6 +49,7 @@ perf-y += dso.o
 perf-y += dsos.o
 perf-y += symbol.o
 perf-y += symbol_fprintf.o
+perf-y += map_symbol.o
 perf-y += color.o
 perf-y += color_config.o
 perf-y += metricgroup.o
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 0a7919c2af91..02881d5b822c 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1496,16 +1496,14 @@ static void free_callchain_node(struct callchain_node *node)
 
 	list_for_each_entry_safe(list, tmp, &node->parent_val, list) {
 		list_del_init(&list->list);
-		map__zput(list->ms.map);
-		maps__zput(list->ms.maps);
+		map_symbol__exit(&list->ms);
 		zfree(&list->brtype_stat);
 		free(list);
 	}
 
 	list_for_each_entry_safe(list, tmp, &node->val, list) {
 		list_del_init(&list->list);
-		map__zput(list->ms.map);
-		maps__zput(list->ms.maps);
+		map_symbol__exit(&list->ms);
 		zfree(&list->brtype_stat);
 		free(list);
 	}
@@ -1591,8 +1589,7 @@ int callchain_node__make_parent_list(struct callchain_node *node)
 out:
 	list_for_each_entry_safe(chain, new, &head, list) {
 		list_del_init(&chain->list);
-		map__zput(chain->ms.map);
-		maps__zput(chain->ms.maps);
+		map_symbol__exit(&chain->ms);
 		zfree(&chain->brtype_stat);
 		free(chain);
 	}
@@ -1676,10 +1673,8 @@ void callchain_cursor_reset(struct callchain_cursor *cursor)
 	cursor->nr = 0;
 	cursor->last = &cursor->first;
 
-	for (node = cursor->first; node != NULL; node = node->next) {
-		map__zput(node->ms.map);
-		maps__zput(node->ms.maps);
-	}
+	for (node = cursor->first; node != NULL; node = node->next)
+		map_symbol__exit(&node->ms);
 }
 
 void callchain_param_setup(u64 sample_type, const char *arch)
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index ac8c0ef48a7f..d62693b8fad8 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -524,8 +524,7 @@ static int hist_entry__init(struct hist_entry *he,
 		map__put(he->mem_info->daddr.ms.map);
 	}
 err:
-	maps__zput(he->ms.maps);
-	map__zput(he->ms.map);
+	map_symbol__exit(&he->ms);
 	zfree(&he->stat_acc);
 	return -ENOMEM;
 }
@@ -1317,8 +1316,7 @@ void hist_entry__delete(struct hist_entry *he)
 	struct hist_entry_ops *ops = he->ops;
 
 	thread__zput(he->thread);
-	maps__zput(he->ms.maps);
-	map__zput(he->ms.map);
+	map_symbol__exit(&he->ms);
 
 	if (he->branch_info) {
 		map__zput(he->branch_info->from.ms.map);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8e5085b77c7b..6ca7500e2cf4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2389,8 +2389,7 @@ static int add_callchain_ip(struct thread *thread,
 				      iter_cycles, branch_from, srcline);
 out:
 	addr_location__exit(&al);
-	maps__put(ms.maps);
-	map__put(ms.map);
+	map_symbol__exit(&ms);
 	return err;
 }
 
@@ -3116,8 +3115,7 @@ static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms
 		if (ret != 0)
 			return ret;
 	}
-	map__put(ilist_ms.map);
-	maps__put(ilist_ms.maps);
+	map_symbol__exit(&ilist_ms);
 
 	return ret;
 }
diff --git a/tools/perf/util/map_symbol.c b/tools/perf/util/map_symbol.c
new file mode 100644
index 000000000000..bef5079f2403
--- /dev/null
+++ b/tools/perf/util/map_symbol.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "map_symbol.h"
+#include "maps.h"
+#include "map.h"
+
+void map_symbol__exit(struct map_symbol *ms)
+{
+	maps__zput(ms->maps);
+	map__zput(ms->map);
+}
+
+void addr_map_symbol__exit(struct addr_map_symbol *ams)
+{
+	map_symbol__exit(&ams->ms);
+}
diff --git a/tools/perf/util/map_symbol.h b/tools/perf/util/map_symbol.h
index e08817b0c30f..72d5ed938ed6 100644
--- a/tools/perf/util/map_symbol.h
+++ b/tools/perf/util/map_symbol.h
@@ -22,4 +22,8 @@ struct addr_map_symbol {
 	u64	      phys_addr;
 	u64	      data_page_size;
 };
+
+void map_symbol__exit(struct map_symbol *ms);
+void addr_map_symbol__exit(struct addr_map_symbol *ams);
+
 #endif // __PERF_MAP_SYMBOL
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 2740d4457c13..d67a87072eec 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2790,8 +2790,11 @@ struct mem_info *mem_info__get(struct mem_info *mi)
 
 void mem_info__put(struct mem_info *mi)
 {
-	if (mi && refcount_dec_and_test(&mi->refcnt))
+	if (mi && refcount_dec_and_test(&mi->refcnt)) {
+		addr_map_symbol__exit(&mi->iaddr);
+		addr_map_symbol__exit(&mi->daddr);
 		free(mi);
+	}
 }
 
 struct mem_info *mem_info__new(void)
-- 
2.42.0.609.gbb76f46606-goog

