Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544D17DF981
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346658AbjKBSEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbjKBSER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:04:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4C21BE1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:59:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da3a891bf3aso1525995276.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947961; x=1699552761; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jyqaewET4n3xW99qLn64pqtlx1KxaY6rTSlGiEWPc/8=;
        b=JylFuvJVKZTu05aAc+DFdRzttQe/w+toVo46ht2/XVqiAY1PUrNCUZjB003Q3IO2zW
         EtSTVD6jYbVK97iiT7HU2XMBq+Ximd5eBaPnW1s9d2frRjVoQ4H16r2LY2qxn5mNfTIb
         1Xj0d2RDk5NtW+T6MiuwbcUOkWCb+SoQW6ol881oudyhUrS9cXm3sMnXZVulMUAOAN3C
         Wj50r+G4lMeQWBwao76qbOi7Xg2ZgWEXVI5Gkk+HMDidEml6FprtkxiF37ePLdM9Cy2m
         0D7SCegK8EsuQq48JXChb3cG3UrJXtfExdpqqTcsaUkRd8ofsU3n3NkpDoKTj4ylw+d7
         QpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947961; x=1699552761;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jyqaewET4n3xW99qLn64pqtlx1KxaY6rTSlGiEWPc/8=;
        b=IGJDpalgAvGZ/5RaovYs0vGJrr+gNBdZldFxZMIcy1xFky5zaqDJl7VM0uNs3FwbP6
         Vne6823NNqzbhWayLWJ+mga2jREOVI5mTr417NuDjCMIkqyEjDvMrF0Pa//Na36HGw8G
         0gkEEk+grrruojhVG5GnDncWkY4w0HLzfTjQExOBUIWal0S3/gyeosQpAO0mR2hVb9Hq
         S34nxGQyIhz5Pmw33TvJo3n8A2tkO5CdCG7pTOaYVhq+dtdl/+UBl5g4GJZj+MBokE4I
         NoemE20h4uSgpxsEQHasVDsOhlXwBqWPbzMIK0z+SLZI42s1/3orDbSEwkh1FGeJ7b65
         UkJw==
X-Gm-Message-State: AOJu0YxVg+RtOcyYFLE4TEYodoeT2MatCQRlqSfDnFpn0gxupSxaRzyW
        NVf0TteMVJgQziwemWGg3Yd6mV4McaCC
X-Google-Smtp-Source: AGHT+IGi9V5RhaUbRTaj34OzyTHfuhbU/S0KuomTfes45q3kI0AGLTaa7kICQjkVhrNJj3xQH5AzXxkJihRf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a25:e082:0:b0:d9a:ec95:9687 with SMTP id
 x124-20020a25e082000000b00d9aec959687mr389437ybg.11.1698947961035; Thu, 02
 Nov 2023 10:59:21 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:57:19 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-38-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 37/53] perf machine: Move fprintf to for_each loop and a callback
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid exposing the threads data structure by switching to the callback
machine__for_each_thread approach. machine__fprintf is only used in
tests and verbose >3 output so don't turn to list and sort. Add
machine__threads_nr to be refactored later.

Note, all existing *_fprintf routines ignore fprintf errors.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 43 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 6d7a505850c8..7e19303d1aa6 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1114,29 +1114,40 @@ size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp)
 	return printed;
 }
 
-size_t machine__fprintf(struct machine *machine, FILE *fp)
+struct machine_fprintf_cb_args {
+	FILE *fp;
+	size_t printed;
+};
+
+static int machine_fprintf_cb(struct thread *thread, void *data)
 {
-	struct rb_node *nd;
-	size_t ret;
-	int i;
+	struct machine_fprintf_cb_args *args = data;
 
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads *threads = &machine->threads[i];
+	/* TODO: handle fprintf errors. */
+	args->printed += thread__fprintf(thread, args->fp);
+	return 0;
+}
 
-		down_read(&threads->lock);
+static size_t machine__threads_nr(const struct machine *machine)
+{
+	size_t nr = 0;
 
-		ret = fprintf(fp, "Threads: %u\n", threads->nr);
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++)
+		nr += machine->threads[i].nr;
 
-		for (nd = rb_first_cached(&threads->entries); nd;
-		     nd = rb_next(nd)) {
-			struct thread *pos = rb_entry(nd, struct thread_rb_node, rb_node)->thread;
+	return nr;
+}
 
-			ret += thread__fprintf(pos, fp);
-		}
+size_t machine__fprintf(struct machine *machine, FILE *fp)
+{
+	struct machine_fprintf_cb_args args = {
+		.fp = fp,
+		.printed = 0,
+	};
+	size_t ret = fprintf(fp, "Threads: %zu\n", machine__threads_nr(machine));
 
-		up_read(&threads->lock);
-	}
-	return ret;
+	machine__for_each_thread(machine, machine_fprintf_cb, &args);
+	return ret + args.printed;
 }
 
 static struct dso *machine__get_kernel(struct machine *machine)
-- 
2.42.0.869.gea05f2083d-goog

