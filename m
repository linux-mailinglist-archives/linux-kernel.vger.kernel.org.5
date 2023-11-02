Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF047DF951
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346083AbjKBR7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377237AbjKBR7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:59:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D01171E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:58:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da03c5ae220so2013499276.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947920; x=1699552720; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yMFgyfVkkS3JK0Z88cfw9As5NjEYDUdVvn9gHlfkLc8=;
        b=iIGtjpzlIApHS7G6bGf+e6NG4BrBoNZLX9cuZU3XC1oATWyCEUBLqrha/FuR1QkO1J
         DtrrMAYRDIRJRiHJtDvV3H/xksOfTACoPvGd6C6Dt1m8lkwmnn5EYV2czEsy0F7uF5Xm
         lJfKgq/7jDYBhh1o5dF5OpfAc2jCoQJbxdgBi5UEiRV0TJZmT6EGWlhrZUWKdxjRMSwc
         W3nuV9AQLqb2kyAiQrG2OIiGg2L+LhiJFg7AJ9YKWdDJbLOfvv2gBowZcERlipuCPYDg
         b08TXkYKE+ZqIiUfvFA2RLCCvlo4cdmT7fNwnNEsEx4VF/JHnAdsKGLFfqbd/JfRDnQp
         Bu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947920; x=1699552720;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMFgyfVkkS3JK0Z88cfw9As5NjEYDUdVvn9gHlfkLc8=;
        b=hm38OCKay78FCGy0uj8gmjY6et3jm5/rGNTVi/o7CSxn1+JMM3FsB46lyzGAyAzePP
         i0rM+xdy/n6owZRItiV7Bp/zQOWcXWeJyTGrcBEm6NYRRatYb69FC9mFq+sd0en5ZNDU
         k9GwVQhcvNEPhuMyOrHTti5+9kLbogC0/oYM/jli/VkT7vPqSHAXjIuu9ivNNVbV8NGV
         u8Dl6/oTxgwVrqxZLngBpZm58UuxHn9Ow/4cdTD6JDOX0RWFLES41EEwKzc67EZpXXX9
         UVoOQP/Mj82PoWC8zfeBnIfEPo/oEPV7n5AX0dcEFkwMKuDhr7GldtfptOgD1b+pqtZA
         kjlw==
X-Gm-Message-State: AOJu0YxXzvLAizJ+Z2p5wtCzIcyGUpQ0wUZB92LZYTplo/5h4Snp88TY
        gjnfUQprGLweZLhjDr8e7Z+uPPb5tYS4
X-Google-Smtp-Source: AGHT+IGdTHaddihqfALfA75kCEb4pGaQ1IUUndRW5K5Aneb+2JXNDz/Cb2z4CXht3utRpCeKbIu+I7pLjgPh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a25:1643:0:b0:d9a:4cc1:b59a with SMTP id
 64-20020a251643000000b00d9a4cc1b59amr12027ybw.1.1698947919908; Thu, 02 Nov
 2023 10:58:39 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:57:01 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-20-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 19/53] perf maps: Add remove maps function to remove a map
 based on callback
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

Removing maps wasn't being done under the write lock. Similar to
maps__for_each_map, iterate the entries but in this case remove the
entry based on the result of the callback. If an entry was removed
then maps_by_name also needs updating, so add missed flush.

In dso__load_kcore, the test of map to save would always be false with
REFCNT_CHECKING because of a missing RC_CHK_ACCESS.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c   | 24 ++++++++++++++++++++++++
 tools/perf/util/maps.h   |  6 ++----
 tools/perf/util/symbol.c | 24 ++++++++++++------------
 3 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 00e6589bba10..f13fd3a9686b 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -13,6 +13,10 @@
 #define maps__for_each_entry(maps, map) \
 	for (map = maps__first(maps); map; map = map_rb_node__next(map))
 
+#define maps__for_each_entry_safe(maps, map, next) \
+	for (map = maps__first(maps), next = map_rb_node__next(map); map; \
+	     map = next, next = map_rb_node__next(map))
+
 static void maps__init(struct maps *maps, struct machine *machine)
 {
 	refcount_set(maps__refcnt(maps), 1);
@@ -214,6 +218,26 @@ int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data)
 	return ret;
 }
 
+void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data)
+{
+	struct map_rb_node *pos, *next;
+	unsigned int start_nr_maps;
+
+	down_write(maps__lock(maps));
+
+	start_nr_maps = maps__nr_maps(maps);
+	maps__for_each_entry_safe(maps, pos, next)	{
+		if (cb(pos->map, data)) {
+			__maps__remove(maps, pos);
+			--RC_CHK_ACCESS(maps)->nr_maps;
+		}
+	}
+	if (maps__maps_by_name(maps) && start_nr_maps != maps__nr_maps(maps))
+		__maps__free_maps_by_name(maps);
+
+	up_write(maps__lock(maps));
+}
+
 struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
 {
 	struct map *map = maps__find(maps, addr);
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 8ac30cdaf5bd..b94ad5c8fea7 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -36,10 +36,6 @@ struct map_rb_node *map_rb_node__next(struct map_rb_node *node);
 struct map_rb_node *maps__find_node(struct maps *maps, struct map *map);
 struct map *maps__find(struct maps *maps, u64 addr);
 
-#define maps__for_each_entry_safe(maps, map, next) \
-	for (map = maps__first(maps), next = map_rb_node__next(map); map; \
-	     map = next, next = map_rb_node__next(map))
-
 DECLARE_RC_STRUCT(maps) {
 	struct rb_root      entries;
 	struct rw_semaphore lock;
@@ -80,6 +76,8 @@ static inline void __maps__zput(struct maps **map)
 
 /* Iterate over map calling cb for each entry. */
 int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data), void *data);
+/* Iterate over map removing an entry if cb returns true. */
+void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data);
 
 static inline struct rb_root *maps__entries(struct maps *maps)
 {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 72f03b875478..30da8a405d11 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1239,13 +1239,23 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 	return 0;
 }
 
+static bool remove_old_maps(struct map *map, void *data)
+{
+	const struct map *map_to_save = data;
+
+	/*
+	 * We need to preserve eBPF maps even if they are covered by kcore,
+	 * because we need to access eBPF dso for source data.
+	 */
+	return RC_CHK_ACCESS(map) != RC_CHK_ACCESS(map_to_save) && !__map__is_bpf_prog(map);
+}
+
 static int dso__load_kcore(struct dso *dso, struct map *map,
 			   const char *kallsyms_filename)
 {
 	struct maps *kmaps = map__kmaps(map);
 	struct kcore_mapfn_data md;
 	struct map *replacement_map = NULL;
-	struct map_rb_node *old_node, *next;
 	struct machine *machine;
 	bool is_64_bit;
 	int err, fd;
@@ -1292,17 +1302,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	}
 
 	/* Remove old maps */
-	maps__for_each_entry_safe(kmaps, old_node, next) {
-		struct map *old_map = old_node->map;
-
-		/*
-		 * We need to preserve eBPF maps even if they are
-		 * covered by kcore, because we need to access
-		 * eBPF dso for source data.
-		 */
-		if (old_map != map && !__map__is_bpf_prog(old_map))
-			maps__remove(kmaps, old_map);
-	}
+	maps__remove_maps(kmaps, remove_old_maps, map);
 	machine->trampolines_mapped = false;
 
 	/* Find the kernel map using the '_stext' symbol */
-- 
2.42.0.869.gea05f2083d-goog

