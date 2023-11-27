Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182C87FAD0F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjK0WLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjK0WKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:10:32 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C922103
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:10:08 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cef61289fdso38427937b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123008; x=1701727808; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAs9xJJ0NlEB/osgBnOQ+CItqjWbP34nP1iWUwmaFSk=;
        b=Ou5kncoOrxfYfVuvym4yMip8yo+PgBMeoms+79MdyYq6I6GUngQSVDEBECX97ZHBMQ
         wwRakzunprC5rB914GbqG7eDAK9q4rHR9iWScZEVoOzbI2FoGEA96OuJd3NGb7aIbixI
         lsBoN/H17MSLdJ7SHnivj5uNn8I8r7ecDRslQKoh2P56d1zrCDw3WQ26usbn+ng3P3U8
         hhI3+V/c9hT+a2pTgq+8TGvoN+4lDJQ5bVLTP82Fq+PTLpFPbyV2JDfyjJL/KFpcSXVt
         LwIlOnXP/oKWiZzp2G0Dc3mShtZQiUOoSP4eiAIZiLGYfQ7CoNkcj6kORIws6vy1lZ9R
         qG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123008; x=1701727808;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAs9xJJ0NlEB/osgBnOQ+CItqjWbP34nP1iWUwmaFSk=;
        b=NcZUi0wghBwKGy3wE7FizNWioBB4cg3/7O5y7JUdQdKAydrvF3/bx+md7jtJXTQSi4
         U5mN1ITW8prlSyT1WBKQCYHSUZeE1VFFEJXFvUTiwYj1pk7CuPpUW+T8qmNogHkA1uu+
         ozchSw42ZgUe+FMb8JHu1D0P8KyTHddNzvGSK3Rj6WufeoJN6H833nSpJjdAxbNU40TO
         vANtKtubdDlLAUKnO/2nGVKy7Tknv4ZDabD1p1mtwbHjJduto21iz1jYGQ/zvO5zRQus
         b4z8sn8rjHZI3ajDe66SK00ZQiTCwL2BJB9TlwohXbYYZAhQXY1DuB73F3TGjXw38KkE
         /hLA==
X-Gm-Message-State: AOJu0YyOXWV8ZOEU+V7AQK9I4v5LbkfoAdAmSccTegywG/eyFPV4mrsH
        4Jm1nwDP1lDmhZ/bP07QnxcTuc8fuvfu
X-Google-Smtp-Source: AGHT+IGZwOFBSYgDDTtvjfQ20Rcd6wK+D7RNERey9zwI5OgP3A1VgudHB+xv/VeG3IN4hmQ164LHJiqXguWX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a05:690c:811:b0:5ca:f8cb:181d with SMTP id
 bx17-20020a05690c081100b005caf8cb181dmr425161ywb.3.1701123007777; Mon, 27 Nov
 2023 14:10:07 -0800 (PST)
Date:   Mon, 27 Nov 2023 14:08:31 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-20-irogers@google.com>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 19/50] perf maps: Do simple merge if given map doesn't overlap
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
2.43.0.rc1.413.gea7ed67945-goog

