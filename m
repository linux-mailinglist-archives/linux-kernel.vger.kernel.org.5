Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D344807DAF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442089AbjLGBRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442062AbjLGBRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:17:37 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA6D10C3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:17:42 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db401df7735so607515276.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911861; x=1702516661; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mSrsTywnbYrFchJ+yMVhWdSh5buiDH8I3k5F7heJabU=;
        b=kkzL+2ct4VH1JQJ3DacN/FKcSPpcPcn1++tRvQiYU8R8krRl29GiqL13O9GXpbdcC4
         ibj91prRHGqli/oRAka6r7lTR2RnWzduPFQU/IpPVbEShhZhPbj/94iqUszEhNlvId9b
         Xrs0djYGTKUaM6jSshtW9ol0jwBcfDeYfcGT4KP8GDugHVOacA+TrKiOrN2MbQv4QI9H
         3n2dJYSJgzav6mmj0QUdDd6fuLdSNt4y+ShsjcZQBSp1h2eBpk8KlsrxtimUabEkaimC
         y0D2RfpTdCO8MqwfHYGlhimuyQUxV7GFvBcJAi3YUyIk7gSdY+DHHX2jZEyW7GieX59/
         s5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911861; x=1702516661;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSrsTywnbYrFchJ+yMVhWdSh5buiDH8I3k5F7heJabU=;
        b=XNirClHhj9V8ok4VueZ9UKv2eqN3/LiOfWaatbAAblBC4/zxvlh4PJnlPccpjXASch
         vp66MBeh1wSLNTm8X3kGKQAlM1s/ea0giBWb4uQgQFAQFBb0R2lZnIEcgW+bMVj5qCYY
         lfx0/Zb7acMzDGqugcsP3+Wu8HVzK1WpMRUCPQrdJTByEExeP2yVZRDikTkpmbwxjmhC
         ttGop/Ac4NfxN3SjcZeHCwv/GseS6eWRyHwjBmadBCxGtnc/cCWId3pCdvtIkCEE2WOi
         DUlrL6FX9HfY5QWNzxq8l5cdelrWy+SHq/uIxk7bqW+DRlS/ki0yKrG5VquU50cDNI02
         q0uw==
X-Gm-Message-State: AOJu0YytuIxX+ElsH2R1LvF1y6DSsPO9SmTNJNzZ2CudYLHxZC8sEOGj
        Fi6xQssXxtstSlRxk6uDFRTVlCifnWsc
X-Google-Smtp-Source: AGHT+IHJ+dewYOVcDf5D7S2ABtqc+xzqbhja7XKsrrZQE5+dtftdJR1mheKJT/7q+tTsBXUNWhyzpc2EuElR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a25:dac8:0:b0:db4:5f59:b71f with SMTP id
 n191-20020a25dac8000000b00db45f59b71fmr28419ybf.13.1701911861691; Wed, 06 Dec
 2023 17:17:41 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:16:40 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-7-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 06/47] perf machine: Use function to add missing maps lock
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

Switch machine__map_x86_64_entry_trampolines and
machine__for_each_kernel_map from loop macro maps__for_each_entry to
maps__for_each_map function that takes a callback. The function holds
the maps lock, which should be held during iteration.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 53 +++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c5de5363b5e7..ca855fc435ac 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1285,33 +1285,46 @@ static u64 find_entry_trampoline(struct dso *dso)
 #define X86_64_CPU_ENTRY_AREA_SIZE	0x2c000
 #define X86_64_ENTRY_TRAMPOLINE		0x6000
 
+struct machine__map_x86_64_entry_trampolines_args {
+	struct maps *kmaps;
+	bool found;
+};
+
+static int machine__map_x86_64_entry_trampolines_cb(struct map *map, void *data)
+{
+	struct machine__map_x86_64_entry_trampolines_args *args = data;
+	struct map *dest_map;
+	struct kmap *kmap = __map__kmap(map);
+
+	if (!kmap || !is_entry_trampoline(kmap->name))
+		return 0;
+
+	dest_map = maps__find(args->kmaps, map__pgoff(map));
+	if (dest_map != map)
+		map__set_pgoff(map, map__map_ip(dest_map, map__pgoff(map)));
+
+	args->found = true;
+	return 0;
+}
+
 /* Map x86_64 PTI entry trampolines */
 int machine__map_x86_64_entry_trampolines(struct machine *machine,
 					  struct dso *kernel)
 {
-	struct maps *kmaps = machine__kernel_maps(machine);
+	struct machine__map_x86_64_entry_trampolines_args args = {
+		.kmaps = machine__kernel_maps(machine),
+		.found = false,
+	};
 	int nr_cpus_avail, cpu;
-	bool found = false;
-	struct map_rb_node *rb_node;
 	u64 pgoff;
 
 	/*
 	 * In the vmlinux case, pgoff is a virtual address which must now be
 	 * mapped to a vmlinux offset.
 	 */
-	maps__for_each_entry(kmaps, rb_node) {
-		struct map *dest_map, *map = rb_node->map;
-		struct kmap *kmap = __map__kmap(map);
-
-		if (!kmap || !is_entry_trampoline(kmap->name))
-			continue;
+	maps__for_each_map(args.kmaps, machine__map_x86_64_entry_trampolines_cb, &args);
 
-		dest_map = maps__find(kmaps, map__pgoff(map));
-		if (dest_map != map)
-			map__set_pgoff(map, map__map_ip(dest_map, map__pgoff(map)));
-		found = true;
-	}
-	if (found || machine->trampolines_mapped)
+	if (args.found || machine->trampolines_mapped)
 		return 0;
 
 	pgoff = find_entry_trampoline(kernel);
@@ -3398,16 +3411,8 @@ int machine__for_each_dso(struct machine *machine, machine__dso_t fn, void *priv
 int machine__for_each_kernel_map(struct machine *machine, machine__map_t fn, void *priv)
 {
 	struct maps *maps = machine__kernel_maps(machine);
-	struct map_rb_node *pos;
-	int err = 0;
 
-	maps__for_each_entry(maps, pos) {
-		err = fn(pos->map, priv);
-		if (err != 0) {
-			break;
-		}
-	}
-	return err;
+	return maps__for_each_map(maps, fn, priv);
 }
 
 bool machine__is_lock_function(struct machine *machine, u64 addr)
-- 
2.43.0.rc2.451.g8631bc7472-goog

