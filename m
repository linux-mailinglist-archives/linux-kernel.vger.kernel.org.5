Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601FE7DF963
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376619AbjKBSAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346149AbjKBR7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:59:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A711984
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:58:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da31ec03186so1062562276.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947926; x=1699552726; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D/N4ckVg6cjKSIfadSgQO70fx2qt1gK+WL2vtB+jVqs=;
        b=2zxmkJ4jWXDGt9kklD3qp4T+SUeQYNWxrQTUc6IrAfmTuK1p97pdhKXlOBQRXHvLLZ
         S9KsnhwyfxyOznTCcMHEnL9BRUoqqPK6UlyxU1/EBhf3dIqIrD68C25WS1V286+DvYCH
         3yBzVy+jEm22RkrJW4xhi9h4MuNQkAdn/5K4N76H7Sxl1t4hRLOEFsc5Bhg7U7aRxTqK
         qLQW/GNIdGG1ViEPwtgWPOd3s76QSoc+jPJUYDUt8lgkw/9FIh1RYUMHlNZvMxXZu5LX
         pAnHiFF85jiRpf+D1KZLjccaDSTSRbTJNeEw4wwmEEqQbNjO/PiAyz5Yjl3NuXfpKTNx
         1H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947926; x=1699552726;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/N4ckVg6cjKSIfadSgQO70fx2qt1gK+WL2vtB+jVqs=;
        b=ijr3RwaJlmRRY8as/4zOlZPr5n/ol+IFeYI7etqTTRgAVfKpmnmN1Kd1uovYvdo5D6
         cXmKOrYLm3UPR3+LnQHa9FUfSa+6AIKMvwE8IKGPJgzI6j59sOWGQkPK3Fa8tUyCxhFt
         1g3bdKLuvNseJW0SbphUt56NNzeNzd6GTs6c/081sO5OuC5hzxMuL3Gjib7vQTzdRNwR
         ffaQp+af81L55wysEilLexTzH+ZDBCfFoskuIVWspARbjlwWbiQ7QlpgKvCGnDzTL7Q4
         m4m+WF6us6J0XiDlf1fPDYqUm7mrnMjcpL7jqHAcCFsUWM2vHgibcg8f8EQqu11cyUHn
         +SMw==
X-Gm-Message-State: AOJu0Yye1MJ6AJ9ieEwnqZ04NQ8WoLHBWVZrsj1539gEkLd9iBn6GFgn
        JUHyLVIzmWtVveaGqbq+A05IqltKZIfL
X-Google-Smtp-Source: AGHT+IELmnUlik1Iorlfj1hreAP7SM2tVfd1zV588w7U8EnJ1Yl5h37ZV5f34FREAL85Q0y54IkJ7ONHkjDS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a05:6902:45:b0:d9b:59c3:6eef with SMTP id
 m5-20020a056902004500b00d9b59c36eefmr5140ybh.0.1698947926695; Thu, 02 Nov
 2023 10:58:46 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:57:04 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-23-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 22/53] perf maps: Do simple merge if given map doesn't overlap
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
2.42.0.869.gea05f2083d-goog

