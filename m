Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFD1807DB9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443093AbjLGBTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442968AbjLGBSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:18:36 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD75D10F0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:18:07 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d8f69da4c8so1799267b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911886; x=1702516686; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CK1SDxoKrbTxUwYVJxj/UubKl5I4LgaZQKa+Urxbs0A=;
        b=oRoCCzJT1o28+nq2r2Lqht6Oe9EQs5zUvGBF54W55qj1R4xZgBd1OsOCNXgghVoL8O
         5egOT4k3+iCnNnMmyzBkg/ds1c8f4ORRjcIR29zX2YbGdQFdC+461v74CW4O1/5lzKaT
         8TjNnzd+plrdW9XciHFTN8yLRVVwatbdXDaWPr3thYp3u7t5kBKcrVwytxo/1oN3DHTO
         j/HOdRlxsPoq/P0MBvYN1G2fsga0PbkuPi0TG9pPf5ogI5u0wXUj++OtBDpndqC2ktnS
         zadG/ESXzsB4mUr/lzRMOTFEF3i1IWZN6Dc9Z64Kf/WtdePDTurzEjeheJjiELSjBLqs
         cRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911886; x=1702516686;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CK1SDxoKrbTxUwYVJxj/UubKl5I4LgaZQKa+Urxbs0A=;
        b=rImI+u92HaetVdwZlC+Ib/cTna7mBaoYqrd1T6+Fr+0RJClR7Gex722DCqvPonM5X1
         rUXVUDYq0Et5B3lzCs+K/00Ic2ZsA8+Ma8jq8TXYWjMX6UkP8QSJd7RjlqpcuDWc0nEb
         DBJL5CvbshM6Gj5hPETeRVnMy6HPhO/um5wS9m8qVfyU6Auqq6J/L4kYQVrBKDkArYX+
         gvB1LsCXlss2pQE1Xp5nCWTnN+JpvyfGlvJaxq8UvvCXBR4ekDHWaAq0gqHUhyfm/hPE
         W+uYXILEA2iGLM1uhJTGXN38xkw+DA7u0d5gB9T+w3HTnJoWgPrZ9gpezZwXMAOFYMyX
         714w==
X-Gm-Message-State: AOJu0Yy6bSqgjM5W7+G3OaBdHzfZI/X+3xNDa9OFTswVxNpLAmqgPoRO
        Kxwxf26zcbI8IimZJGTIMAOeZotRaYa4
X-Google-Smtp-Source: AGHT+IFgzpQ1gB8I8khYxr6Kt+tInLkkwU9dvLt12QEux1qrJxpmkS8x1GmtcpxRwqM8e8f7fyX75YtbWqwn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a05:690c:250b:b0:5d3:9222:a83e with SMTP
 id dt11-20020a05690c250b00b005d39222a83emr31356ywb.10.1701911886660; Wed, 06
 Dec 2023 17:18:06 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:16:51 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-18-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 17/47] perf maps: Do simple merge if given map doesn't overlap
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

Simplify merge in for the simple case of a non-overlapping map.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 94a97923527d..f305a4834cf0 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -697,9 +697,20 @@ void maps__fixup_end(struct maps *maps)
 int maps__merge_in(struct maps *kmaps, struct map *new_map)
 {
 	struct map_rb_node *rb_node;
+	struct rb_node *first;
+	bool overlaps;
 	LIST_HEAD(merged);
 	int err = 0;
 
+	down_read(maps__lock(kmaps));
+	first = first_ending_after(kmaps, new_map);
+	rb_node = first ? rb_entry(first, struct map_rb_node, rb_node) : NULL;
+	overlaps = rb_node && map__start(rb_node->map) < map__end(new_map);
+	up_read(maps__lock(kmaps));
+
+	if (!overlaps)
+		return maps__insert(kmaps, new_map);
+
 	maps__for_each_entry(kmaps, rb_node) {
 		struct map *old_map = rb_node->map;
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

