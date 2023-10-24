Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BE87D5E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344492AbjJXWZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344491AbjJXWY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:24:58 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C305119B0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a90d6ab944so56797557b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186277; x=1698791077; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qKe0Mkvuri05dA2HE591fwZ1gmZep5T1+9DDRS5n7Yw=;
        b=T0/PNkQUjqZPlKDd/uv6T4jQUdGwQZNjsSd6Dsje8Dga2krp6apPzMYxe/cCDKsT8y
         f0wi8Ygi5VsRo0ysX2wBcMEbX/WxA4Qz0nkYk/sIdtwhyufhaDG/UDjYsCD4Ob5hiyAa
         M9kWbSbZLgETXo4J05hJ51VSnQUtp4ftrMFPnUurlfMXOPuTPQyryl+kBQJ/IS/ag+NH
         /4SpIOCwElSIuGc0QPu2YaEMzPGT04kSXWLQ+P0yLekYwSUWceG0mLJKXrZKiJNI0HKp
         i3LiWtj0fUw1haf1b3Q/Yhlgji9i1OTRaA1RomLTJpVNmh7YOER2n3je5LVacsvbjcvL
         gxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186277; x=1698791077;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qKe0Mkvuri05dA2HE591fwZ1gmZep5T1+9DDRS5n7Yw=;
        b=pZuE6+0NPRAAwIDYB5doIP0XJm+OGwdG0V3T/KWIT0lDoQDefJ9l6VW4kWUe3rSsID
         KoFrP6p31/XB/fg5FuSO4AGMzk9Wqc2VGaQb4ljbddyfBzq9A7+XgDaQaw6lRsvHo8Q4
         HSj7YHxEPJMGHqy3ZW+X6TJPz6XJbY0sA6N4bjNS4ykOe6kqMYeb9Lcdlrf2XTqtjsWe
         QenyoUT7W0Cpdw4GGGCL2er4Rn/CoPel0VQoApg04gyszrdGEvPMvpKx4N0i4Orw6Zxj
         /KOwfwbA3Tll53a7MlAvLXIR/bKakXcnYAXI89vuoPZJSYcxgxq9VsuK/FfTXi/jxvey
         fDBg==
X-Gm-Message-State: AOJu0Yx6oVjygPDwVvqUlsSIzMUuvTNVReEH3eIKTeEB2Qym+201u6Bo
        R4CjihjvOX9oD5tz8Xp2mDQmcG0p9sZL
X-Google-Smtp-Source: AGHT+IFmCQLrr6JJNjdNAm+eK0zd41RrbjkiufO4WaBq8CDA4kb66UEHivE3MUTTgzgMshfI3g0/Mrr6yeBw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a0d:d84a:0:b0:5a8:5653:3323 with SMTP id
 a71-20020a0dd84a000000b005a856533323mr271855ywe.2.1698186277302; Tue, 24 Oct
 2023 15:24:37 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:14 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-12-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 11/50] perf mem_info: Add and use map_symbol__exit and addr_map_symbol__exit
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

Fix leak where mem_info__put wouldn't release the maps/map as used by
perf mem. Add exit functions and use elsewhere that the maps and map
are released.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build        |  1 +
 tools/perf/util/callchain.c  | 27 +++++++++------------------
 tools/perf/util/hist.c       | 28 ++++++++++++----------------
 tools/perf/util/machine.c    |  6 ++----
 tools/perf/util/map_symbol.c | 15 +++++++++++++++
 tools/perf/util/map_symbol.h |  4 ++++
 tools/perf/util/symbol.c     |  5 ++++-
 7 files changed, 47 insertions(+), 39 deletions(-)
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
index 5349c6a21849..99cce43ba152 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -659,8 +659,7 @@ add_child(struct callchain_node *parent,
 
 		list_for_each_entry_safe(call, tmp, &new->val, list) {
 			list_del_init(&call->list);
-			map__zput(call->ms.map);
-			maps__zput(call->ms.maps);
+			map_symbol__exit(&call->ms);
 			zfree(&call->brtype_stat);
 			free(call);
 		}
@@ -1040,10 +1039,8 @@ merge_chain_branch(struct callchain_cursor *cursor,
 		};
 		callchain_cursor_append(cursor, list->ip, &ms, false, NULL, 0, 0, 0, list->srcline);
 		list_del_init(&list->list);
-		map__zput(ms.map);
-		maps__zput(ms.maps);
-		map__zput(list->ms.map);
-		maps__zput(list->ms.maps);
+		map_symbol__exit(&ms);
+		map_symbol__exit(&list->ms);
 		zfree(&list->brtype_stat);
 		free(list);
 	}
@@ -1096,8 +1093,7 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
 	}
 
 	node->ip = ip;
-	maps__zput(node->ms.maps);
-	map__zput(node->ms.map);
+	map_symbol__exit(&node->ms);
 	node->ms = *ms;
 	node->ms.maps = maps__get(ms->maps);
 	node->ms.map = map__get(ms->map);
@@ -1496,16 +1492,14 @@ static void free_callchain_node(struct callchain_node *node)
 
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
@@ -1591,8 +1585,7 @@ int callchain_node__make_parent_list(struct callchain_node *node)
 out:
 	list_for_each_entry_safe(chain, new, &head, list) {
 		list_del_init(&chain->list);
-		map__zput(chain->ms.map);
-		maps__zput(chain->ms.maps);
+		map_symbol__exit(&chain->ms);
 		zfree(&chain->brtype_stat);
 		free(chain);
 	}
@@ -1676,10 +1669,8 @@ void callchain_cursor_reset(struct callchain_cursor *cursor)
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
index 0aa7e231172a..0888b7163b7c 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -515,17 +515,16 @@ static int hist_entry__init(struct hist_entry *he,
 
 err_infos:
 	if (he->branch_info) {
-		map__put(he->branch_info->from.ms.map);
-		map__put(he->branch_info->to.ms.map);
+		map_symbol__exit(&he->branch_info->from.ms);
+		map_symbol__exit(&he->branch_info->to.ms);
 		zfree(&he->branch_info);
 	}
 	if (he->mem_info) {
-		map__put(he->mem_info->iaddr.ms.map);
-		map__put(he->mem_info->daddr.ms.map);
+		map_symbol__exit(&he->mem_info->iaddr.ms);
+		map_symbol__exit(&he->mem_info->daddr.ms);
 	}
 err:
-	maps__zput(he->ms.maps);
-	map__zput(he->ms.map);
+	map_symbol__exit(&he->ms);
 	zfree(&he->stat_acc);
 	return -ENOMEM;
 }
@@ -1317,20 +1316,19 @@ void hist_entry__delete(struct hist_entry *he)
 	struct hist_entry_ops *ops = he->ops;
 
 	thread__zput(he->thread);
-	maps__zput(he->ms.maps);
-	map__zput(he->ms.map);
+	map_symbol__exit(&he->ms);
 
 	if (he->branch_info) {
-		map__zput(he->branch_info->from.ms.map);
-		map__zput(he->branch_info->to.ms.map);
+		map_symbol__exit(&he->branch_info->from.ms);
+		map_symbol__exit(&he->branch_info->to.ms);
 		zfree_srcline(&he->branch_info->srcline_from);
 		zfree_srcline(&he->branch_info->srcline_to);
 		zfree(&he->branch_info);
 	}
 
 	if (he->mem_info) {
-		map__zput(he->mem_info->iaddr.ms.map);
-		map__zput(he->mem_info->daddr.ms.map);
+		map_symbol__exit(&he->mem_info->iaddr.ms);
+		map_symbol__exit(&he->mem_info->daddr.ms);
 		mem_info__zput(he->mem_info);
 	}
 
@@ -2700,10 +2698,8 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 					*total_cycles += bi[i].flags.cycles;
 			}
 			for (unsigned int i = 0; i < bs->nr; i++) {
-				map__put(bi[i].to.ms.map);
-				maps__put(bi[i].to.ms.maps);
-				map__put(bi[i].from.ms.map);
-				maps__put(bi[i].from.ms.maps);
+				map_symbol__exit(&bi[i].to.ms);
+				map_symbol__exit(&bi[i].from.ms);
 			}
 			free(bi);
 		}
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 31fdbb0f27af..90c750150b19 100644
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
index 822f4dcebfe6..82cc74b9358e 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2791,8 +2791,11 @@ struct mem_info *mem_info__get(struct mem_info *mi)
 
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
2.42.0.758.gaed0368e0e-goog

