Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61D3807DB5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443008AbjLGBSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443021AbjLGBSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:18:25 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2133919B7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:18:02 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d3911218b3so1880597b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911875; x=1702516675; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/sHbkqXu1fUVSCDOGBtyBTb/TcjN5e6RYI3KdCcTGvc=;
        b=lPWCAere9A/tqQJb4Z5l4LaSTTwqTXgknJXo8BgtDlT7+pjrDMQuOtG9EKofMJkg1t
         CtpCTbGz+ViPywB2P82f9qcxD0LG+NQD7/OT2Dkbxqv3+GaoRZ59zUuIIWmiC9kRyLjO
         TJHlWjqI9UhaCg4VbqqPVqc29zm2Fffa7c1+UjKWqm4er5Xm2WioYzMNKph/AA4BfhoW
         3vEyzvguY9SWNLsRJxK+3ApHLIvJ09yWKxX0rrpi8MlGj5Lcvx6GkcxDiO27doaJiN39
         yCAj3yQgXayfT5jwXN5dlKJLTSYJOELXp2yZlS7nKzsMgivrB2dpfrvI0YXG5fQrMUcY
         wtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911875; x=1702516675;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/sHbkqXu1fUVSCDOGBtyBTb/TcjN5e6RYI3KdCcTGvc=;
        b=xSA3QZAworlAr3qNWkebCCCF6BV+Ur/zFP33hBELg+XAxZ1paL9aqzIv7XXPzckwcq
         gecZJvUKp1jzYxNRQm9vpioYrgcp/2no2EoeDVgonIf68NeD5UFLvp3vKS823VlbrWfh
         Sc+8nsgwydxG4VPs6k4xm90f5qGStULkE0pp9eX67w+N5gaBqqYfaeHqCG+ZB8qhViF5
         sVraaZ3XFVwmjUcoqzNuY26ZLYwpSR15hgNuJgKTmFz1EAWWSbXRYYRZN+kxaN/mbHvp
         U4Tfs/HviPG3nQtflRQ/GmPaV7QBxCz2q1z7OMmn08TtHD4I3eb+Sbg+9WBC7PxoGity
         zKhg==
X-Gm-Message-State: AOJu0Ywk+rxKwf2Yd95WuSGlSBPR/64QvchAaXjhYlSPl/y00ChGZmrz
        5FvFneWNRkLR7MHeBY83TDrSTi3rhIBA
X-Google-Smtp-Source: AGHT+IEumQPe3/vz/fQO4LUDE4GZ7qAE8fCJL7nIDamWMCjWVHBn0oHchNObH1MJsGJSoyiQUyF0/NKazFtE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a05:690c:2f89:b0:5d4:263e:c819 with SMTP
 id ew9-20020a05690c2f8900b005d4263ec819mr25058ywb.8.1701911875437; Wed, 06
 Dec 2023 17:17:55 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:16:46 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-13-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 12/47] perf vdso: Use function to add missing maps lock
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

Switch machine__thread_dso_type from loop macro maps__for_each_entry
to maps__for_each_map function that takes a callback. The function
holds the maps lock, which should be held during iteration.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/vdso.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index ae3eee69b659..df8963796187 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -140,23 +140,34 @@ static struct dso *__machine__addnew_vdso(struct machine *machine, const char *s
 	return dso;
 }
 
+struct machine__thread_dso_type_maps_cb_args {
+	struct machine *machine;
+	enum dso_type dso_type;
+};
+
+static int machine__thread_dso_type_maps_cb(struct map *map, void *data)
+{
+	struct machine__thread_dso_type_maps_cb_args *args = data;
+	struct dso *dso = map__dso(map);
+
+	if (!dso || dso->long_name[0] != '/')
+		return 0;
+
+	args->dso_type = dso__type(dso, args->machine);
+	return (args->dso_type != DSO__TYPE_UNKNOWN) ? 1 : 0;
+}
+
 static enum dso_type machine__thread_dso_type(struct machine *machine,
 					      struct thread *thread)
 {
-	enum dso_type dso_type = DSO__TYPE_UNKNOWN;
-	struct map_rb_node *rb_node;
-
-	maps__for_each_entry(thread__maps(thread), rb_node) {
-		struct dso *dso = map__dso(rb_node->map);
+	struct machine__thread_dso_type_maps_cb_args args = {
+		.machine = machine,
+		.dso_type = DSO__TYPE_UNKNOWN,
+	};
 
-		if (!dso || dso->long_name[0] != '/')
-			continue;
-		dso_type = dso__type(dso, machine);
-		if (dso_type != DSO__TYPE_UNKNOWN)
-			break;
-	}
+	maps__for_each_map(thread__maps(thread), machine__thread_dso_type_maps_cb, &args);
 
-	return dso_type;
+	return args.dso_type;
 }
 
 #if BITS_PER_LONG == 64
-- 
2.43.0.rc2.451.g8631bc7472-goog

