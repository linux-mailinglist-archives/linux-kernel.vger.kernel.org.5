Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AA67D5E21
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344446AbjJXW1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344534AbjJXW1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:27:22 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8260010C6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a88f9a1cf7so64618377b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186325; x=1698791125; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxgK5fVHKp+mV0fGm6A00soSn6WBUBJ/2ysR29mR0ns=;
        b=zBCpTlFl9akgkYZ47XY/LVVGF6Q8NqFwRlue7vNIvrQ3LKbNv2boVxYD2zUyndF4Gj
         NFrd1QOZwSUDjKu+LDP51pHt4h33mqD06GvKUl6PO77a5PkbFxYtxwuw1dz+LAMWR6E/
         XhDR/cRLWootOK8KkU2yuKl2hor9858+hWjX6eg2dpliu0J1YftRt/YW2JjXqLu6Kdb7
         i7Its/RxFcnh7XWJMxniVMf17Kaf0FxL22fTNvWt9TjRvGs2Ia7aWO8cnn2arX4WDO91
         KnRjsVYKK95MFNbgQa6kicYf9K8wIRi7P989G+R5HurEZ0aAWJNqnJrilU/menxwqNPY
         Snpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186325; x=1698791125;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxgK5fVHKp+mV0fGm6A00soSn6WBUBJ/2ysR29mR0ns=;
        b=q0Oh4Zng/da5v/4zFj6OIvZUEfFYvSIPtKVLP1eD+KqkgiIOGKWFYJk950ulIIR+QY
         Fego3U48UrkhMBOkatk9TwRamZ6jpExie595AaD/aYMe91+5ly+C+M62Silzz11gOqgn
         lHyJ+WHl78S/l1XCJs0R+/wX6vNkcnOOKjDxkrMTp/hpFQuPaPyNEF/x9fVjxEHPZBjX
         mL5UTDPcdTqSejWAW5qLlfZzPlbkuyGzTwmugnBUeA/ue4RTcA85Lwpp7JkOENMHNpZ4
         LClKeDJ5YCxR3EspdqSQYEt+Ty3J69TH9T/MwHwfl5sQO5h+mg3rmmSoNaiM8IKoE/ZO
         pBrw==
X-Gm-Message-State: AOJu0Ywtq17Gm/NeOUqqnq5wTerXNBvsPXfRXDkcB9W0VvFATHKTICAw
        VXFGeG0uX88QKgkPutMj9NpQVQQwgBhX
X-Google-Smtp-Source: AGHT+IGPYhopVp4NwknT60DLHn+cg2ZkfPgvlB2ztGqyTTywxRVA0AhNRyMeJWGl0Lazqkj9RV8TWcoRdfRo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a0d:d644:0:b0:5a7:f73d:e69 with SMTP id
 y65-20020a0dd644000000b005a7f73d0e69mr271133ywd.4.1698186325326; Tue, 24 Oct
 2023 15:25:25 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:35 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-33-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 32/50] perf maps: Do simple merge if given map doesn't overlap
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

Simplify merge in for the simple case of a non-overlapping map.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 40df08dd9bf3..14e1a169433d 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -696,9 +696,20 @@ void maps__fixup_end(struct maps *maps)
 int maps__merge_in(struct maps *kmaps, struct map *new_map)
 {
 	struct map_rb_node *rb_node;
+	struct rb_node *first;
+	bool overlaps;
 	LIST_HEAD(merged);
 	int err = 0;
 
+	down_read(maps__lock(kmaps));
+	first = first_ending_after(kmaps, new_map);
+	overlaps = first &&
+		map__start(rb_entry(first, struct map_rb_node, rb_node)->map) < map__end(new_map);
+	up_read(maps__lock(kmaps));
+
+	if (!overlaps)
+		return maps__insert(kmaps, new_map);
+
 	maps__for_each_entry(kmaps, rb_node) {
 		struct map *old_map = rb_node->map;
 
-- 
2.42.0.758.gaed0368e0e-goog

