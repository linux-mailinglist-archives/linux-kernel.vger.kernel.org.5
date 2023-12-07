Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E1C807DD4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443156AbjLGBWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443128AbjLGBWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:22:08 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E921FE2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:18:18 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5c5daf2baccso1781227b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911896; x=1702516696; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k20rx+ZSolEwd6uRLeEItUH88wwnYG7dQShCzZDbuAA=;
        b=ekr3+Tv0E04Xt/8hj2w+UkByYojQhPS4C3CYi2zjQsNuOBQk8+Ro0k7Hq+JZjW7Pi9
         CbxEPyU3Dfw5G31k1FXKCM7Ni89ZLwo/cqfF+Q/62k35mQ/jVqXBtQtXgfjjGXWFVg2k
         r1j183utltt05Jj41Ed5lFaInAlI+7UhCjmWJ0GDonZaAFd5+y4aBd/szwKhz3YeXT/k
         ft9xVyKXzazbyT4d6xT35z8oMFig9C1BkXAgc61wH9kcXi0EyMtFBTRP2Jt4Ba3u6feB
         tidvCZhGM40SkNckXXhEte8xnlSkXIsNPkxZN1ZCFjF1qq1g1nlBzQpeUvXlN6ZvS/W9
         ROBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911896; x=1702516696;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k20rx+ZSolEwd6uRLeEItUH88wwnYG7dQShCzZDbuAA=;
        b=NVT95gfnQRekaozlIaPQCrI+2cMP+AaNGwdcQlOMpCkRG1aUqrG2mgNWHePaAKIs4F
         85Frk8AygM83DEL0Jj3KzPfruiz1tQCsPEBPUzVeH+5TY0mjk9csVQPw+K2K7VBQHEM+
         eTw1dcGtjBHBkDI/Hq05fJIgCIRx70EDcIjfPQrKpqRd/w96uQCd5iLOPxnzFnkySubn
         QJk51jVPRz1PyywaPPjTpXi/LuerrqdWuPI4alXbGfRxAmAyi7tUmTWV1xZs6gZ0SJ9L
         PG45AJwFKQnD3Y9ba1dpuMC46VYy51uCSoxyZg4bk/kzslUeSyX7hB86HJA8stIGuDAc
         NTgQ==
X-Gm-Message-State: AOJu0YwOh4LycXoGPXkQfin7AZR3zVWrvT4HMVvKf2cbfpEG3Ciz76t4
        xwuipB+9we5e8QRvfCPp0ygZT5esPQXL
X-Google-Smtp-Source: AGHT+IFLmjVl2JTSrbF+AcloIm9xGK1+nQ7UM9Q2USjrkXsrjEjnLsMAuzFAeAyNMPyL+RQtNph6K8uMrHx3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:ac62:0:b0:5da:efd:10c9 with SMTP id
 z34-20020a81ac62000000b005da0efd10c9mr25388ywj.9.1701911896241; Wed, 06 Dec
 2023 17:18:16 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:16:55 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-22-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 21/47] perf maps: Reduce scope of map_rb_node and maps internals
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
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid exposing the implementation of maps so that the internals can be
refactored.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 90 ++++++++++++++++++++++++++----------------
 tools/perf/util/maps.h | 23 -----------
 2 files changed, 55 insertions(+), 58 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 5b898a0e97b2..dcd67384d877 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -10,6 +10,11 @@
 #include "ui/ui.h"
 #include "unwind.h"
 
+struct map_rb_node {
+	struct rb_node rb_node;
+	struct map *map;
+};
+
 #define maps__for_each_entry(maps, map) \
 	for (map = maps__first(maps); map; map = map_rb_node__next(map))
 
@@ -17,6 +22,56 @@
 	for (map = maps__first(maps), next = map_rb_node__next(map); map; \
 	     map = next, next = map_rb_node__next(map))
 
+static struct rb_root *maps__entries(struct maps *maps)
+{
+	return &RC_CHK_ACCESS(maps)->entries;
+}
+
+static struct rw_semaphore *maps__lock(struct maps *maps)
+{
+	return &RC_CHK_ACCESS(maps)->lock;
+}
+
+static struct map **maps__maps_by_name(struct maps *maps)
+{
+	return RC_CHK_ACCESS(maps)->maps_by_name;
+}
+
+static struct map_rb_node *maps__first(struct maps *maps)
+{
+	struct rb_node *first = rb_first(maps__entries(maps));
+
+	if (first)
+		return rb_entry(first, struct map_rb_node, rb_node);
+	return NULL;
+}
+
+static struct map_rb_node *map_rb_node__next(struct map_rb_node *node)
+{
+	struct rb_node *next;
+
+	if (!node)
+		return NULL;
+
+	next = rb_next(&node->rb_node);
+
+	if (!next)
+		return NULL;
+
+	return rb_entry(next, struct map_rb_node, rb_node);
+}
+
+static struct map_rb_node *maps__find_node(struct maps *maps, struct map *map)
+{
+	struct map_rb_node *rb_node;
+
+	maps__for_each_entry(maps, rb_node) {
+		if (rb_node->RC_CHK_ACCESS(map) == RC_CHK_ACCESS(map))
+			return rb_node;
+	}
+	return NULL;
+}
+
 static void maps__init(struct maps *maps, struct machine *machine)
 {
 	refcount_set(maps__refcnt(maps), 1);
@@ -485,17 +540,6 @@ int maps__copy_from(struct maps *maps, struct maps *parent)
 	return err;
 }
 
-struct map_rb_node *maps__find_node(struct maps *maps, struct map *map)
-{
-	struct map_rb_node *rb_node;
-
-	maps__for_each_entry(maps, rb_node) {
-		if (rb_node->RC_CHK_ACCESS(map) == RC_CHK_ACCESS(map))
-			return rb_node;
-	}
-	return NULL;
-}
-
 struct map *maps__find(struct maps *maps, u64 ip)
 {
 	struct rb_node *p;
@@ -521,30 +565,6 @@ struct map *maps__find(struct maps *maps, u64 ip)
 	return m ? m->map : NULL;
 }
 
-struct map_rb_node *maps__first(struct maps *maps)
-{
-	struct rb_node *first = rb_first(maps__entries(maps));
-
-	if (first)
-		return rb_entry(first, struct map_rb_node, rb_node);
-	return NULL;
-}
-
-struct map_rb_node *map_rb_node__next(struct map_rb_node *node)
-{
-	struct rb_node *next;
-
-	if (!node)
-		return NULL;
-
-	next = rb_next(&node->rb_node);
-
-	if (!next)
-		return NULL;
-
-	return rb_entry(next, struct map_rb_node, rb_node);
-}
-
 static int map__strcmp(const void *a, const void *b)
 {
 	const struct map *map_a = *(const struct map **)a;
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 84b42c8456e8..d836d04c9402 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -15,11 +15,6 @@ struct machine;
 struct map;
 struct maps;
 
-struct map_rb_node {
-	struct rb_node rb_node;
-	struct map *map;
-};
-
 struct map_list_node {
 	struct list_head node;
 	struct map *map;
@@ -30,9 +25,6 @@ static inline struct map_list_node *map_list_node__new(void)
 	return malloc(sizeof(struct map_list_node));
 }
 
-struct map_rb_node *maps__first(struct maps *maps);
-struct map_rb_node *map_rb_node__next(struct map_rb_node *node);
-struct map_rb_node *maps__find_node(struct maps *maps, struct map *map);
 struct map *maps__find(struct maps *maps, u64 addr);
 
 DECLARE_RC_STRUCT(maps) {
@@ -78,26 +70,11 @@ int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data)
 /* Iterate over map removing an entry if cb returns true. */
 void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data);
 
-static inline struct rb_root *maps__entries(struct maps *maps)
-{
-	return &RC_CHK_ACCESS(maps)->entries;
-}
-
 static inline struct machine *maps__machine(struct maps *maps)
 {
 	return RC_CHK_ACCESS(maps)->machine;
 }
 
-static inline struct rw_semaphore *maps__lock(struct maps *maps)
-{
-	return &RC_CHK_ACCESS(maps)->lock;
-}
-
-static inline struct map **maps__maps_by_name(struct maps *maps)
-{
-	return RC_CHK_ACCESS(maps)->maps_by_name;
-}
-
 static inline unsigned int maps__nr_maps(const struct maps *maps)
 {
 	return RC_CHK_ACCESS(maps)->nr_maps;
-- 
2.43.0.rc2.451.g8631bc7472-goog

