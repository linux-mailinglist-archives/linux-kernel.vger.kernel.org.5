Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E149807DBB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443024AbjLGBTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443001AbjLGBSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:18:38 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBB91FC3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:18:12 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d9c036769cso1842547b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911891; x=1702516691; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zhWv5XH2QIvBBYa/R05A/SafwPCuOWvAm4FZ/Ek/rFM=;
        b=aKrqV2LLaveEeNRG0k5c6Fa2OyEtZKKkinL9NWdjtQ7YQLJxH9WnGGvfKZkZR1nKbV
         AXU6HylhZeuOeDI6fTq5bNOSs4XQRk84D8coYKv5jbRo3shOuq8VUvTLW16YP9RKvDft
         OHApy0W9NqJjcthFbVLptVN7dMeRW7sl6vvJ5FYRiMxTb1gIfKYi9nyjWn9sW3eHVBuQ
         8mtZjMM081V9zYHnYbsvKNc6mRoENbV2EB4sxsFEQ9USJrGqW9+tSmaG2v9AOXao1m19
         IJraUtqlPvbJwmIpP7R4yTUvngdG3eN+LdNKqjANPh0akZklpUFxc1L8kjUGd8lR9IOy
         ptfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911891; x=1702516691;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhWv5XH2QIvBBYa/R05A/SafwPCuOWvAm4FZ/Ek/rFM=;
        b=bomDGuEb/MkpCe6NDbzI8n27dDCeMR8viVNDlYvtaOvwSxg2Q3NKTeueKJzgBYybHG
         cES8yaVnifyydi5IGdm0E/Tu/kITcdAI9NSn54hAg5nP1WKBqDG6kJpW5bOVkyBr8K8q
         6A/1cf38m0pMWwnOPD36QEFax1AFPAh+6pNWAradqmRqjw86mvR94H5fHOFQSAw7xD0a
         BmUL3GsYgRBLn/RhsmVB9a3OiLAvT9fsLq/dA8gMKuSNCs1SX22QEwZ/gM8GA9zcVORu
         xSu5P+gPE0RFQVF/Egbye8EbmQO5RzBiM2giIzIi84B6QViUQEp05n5/ZK8ZCVIV9mP4
         aFTQ==
X-Gm-Message-State: AOJu0Yye5ne8/upYslULFMu4wtcfNwHtPK9GVo78GGrlV8epBcTs5clM
        tnZhgHQ5QrlxvMbESz0I8PFvI+iwwfqG
X-Google-Smtp-Source: AGHT+IEWcnmiKEOyMIE+2aNgl2GxOpZtGE8TuU2QEQKPQlYZwpHrrMBjKS7T0LXoVJ/omdKDaVXSGMunSkJj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:be14:0:b0:5d1:7706:b886 with SMTP id
 i20-20020a81be14000000b005d17706b886mr31238ywn.0.1701911891461; Wed, 06 Dec
 2023 17:18:11 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:16:53 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-20-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 19/47] perf maps: Add maps__load_first
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
index f1716c089c99..31ff19afc20c 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -318,7 +318,7 @@ int lock_contention_read(struct lock_contention *con)
 	}
 
 	/* make sure it loads the kernel map */
-	map__load(maps__first(machine->kmaps)->map);
+	maps__load_first(machine->kmaps);
 
 	prev_key = NULL;
 	while (!bpf_map_get_next_key(fd, prev_key, &key)) {
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 986daa1b0497..024a6c9f72c4 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -793,3 +793,16 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
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
2.43.0.rc2.451.g8631bc7472-goog

