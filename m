Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13EA807DB3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442993AbjLGBSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442994AbjLGBR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:17:59 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712E910C0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:17:52 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d67fc68a82so1628127b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911871; x=1702516671; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLs18EUwcJ7v2oX/7NfyA6HjR14FLN4dfhaM88TGxMk=;
        b=kRAoV4bY/0iOfctTnaq+ytVR7KqTy05l2D/bibubFYQkj8uH7P3Deo2TPEbXHXKy2a
         Ludsm3nNLohmk6f+4232F4mRVjnwX4YGh3LuKVDT1+HZJi4zC3Nn/WINZpyyw21lgI/D
         Sy+M6UV3Hu7GyaL5HfkQrmKOruf8M+SYATjax+JEkUQE91sMd0oFjF7mQTlOzFbYueU5
         TUyXCFOAFK4L89RiXOy7RFO99pqB24DI3Lzmj59qklAYLucsHDPUOXifbjlwfFs0jYdr
         b3q6oUzkdZYqjSAaBLIe1D45nwwmPde5h/n9E2enM1duFaYCgnerZ+9B9oRnl5qQ3TIp
         Ocjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911871; x=1702516671;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLs18EUwcJ7v2oX/7NfyA6HjR14FLN4dfhaM88TGxMk=;
        b=aM3ZSFOoiDodyVHcGrgPKN8n0AibjKJg5fHBvLLGyY4KP0LxtHuqd5mPI12LXOQ2Ub
         S/PdkxAjBvE0BOhjk8yXi1K1Fcg762fc3Mas54R8OBByVF4RLD4uXzHs6bXo9rbFDFUU
         z753jLHqiVcGfyvK0NxaqDbGw4W1pLcAF3kK6eaB7P3sBAtMpwveZ2c/ZiYob3ghv7SU
         VgLDzWfRW3NmuYkRIb5fWEo1lI/pmDXnuoc7H1WOpXTZts0V4JNSgLAWtSJ8OPjfFzTA
         UHC5cbxwj6srE6c0q7vFwvZnHl9uOvdr3/tPApzjd6RfNy1W6vdtuMREc15X7XQyVzSj
         Fn2Q==
X-Gm-Message-State: AOJu0YzK6YEo/Som/6QjVO2H4p4L+deriz1c2UTyNUnE1JoIeUWibh1v
        QPt4EBkb3Pc6YFecNg3xhxIxudFh6zow
X-Google-Smtp-Source: AGHT+IFPtjgGW+/HVbXi/s6styOGACrpE+wgUPXjW2RbA5UaZ5b03h7MXJLv7jWvZreh5E1/ayyPbBclxVlu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a05:690c:300e:b0:5d6:e473:bf60 with SMTP
 id ey14-20020a05690c300e00b005d6e473bf60mr24337ywb.8.1701911871171; Wed, 06
 Dec 2023 17:17:51 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:16:44 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-11-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 10/47] perf thread: Use function to add missing maps lock
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

Switch thread__prepare_access from loop macro maps__for_each_entry
to maps__for_each_map function that takes a callback. The function
holds the maps lock, which should be held during iteration.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/thread.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index b9c2039c4230..b6986a81aa6d 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -349,34 +349,33 @@ int thread__insert_map(struct thread *thread, struct map *map)
 	return maps__insert(thread__maps(thread), map);
 }
 
-static int __thread__prepare_access(struct thread *thread)
+struct thread__prepare_access_maps_cb_args {
+	int err;
+	struct maps *maps;
+};
+
+static int thread__prepare_access_maps_cb(struct map *map, void *data)
 {
 	bool initialized = false;
-	int err = 0;
-	struct maps *maps = thread__maps(thread);
-	struct map_rb_node *rb_node;
-
-	down_read(maps__lock(maps));
-
-	maps__for_each_entry(maps, rb_node) {
-		err = unwind__prepare_access(thread__maps(thread), rb_node->map, &initialized);
-		if (err || initialized)
-			break;
-	}
+	struct thread__prepare_access_maps_cb_args *args = data;
 
-	up_read(maps__lock(maps));
+	args->err = unwind__prepare_access(args->maps, map, &initialized);
 
-	return err;
+	return (args->err || initialized) ? 1 : 0;
 }
 
 static int thread__prepare_access(struct thread *thread)
 {
-	int err = 0;
+	struct thread__prepare_access_maps_cb_args args = {
+		.err = 0,
+	};
 
-	if (dwarf_callchain_users)
-		err = __thread__prepare_access(thread);
+	if (dwarf_callchain_users) {
+		args.maps = thread__maps(thread);
+		maps__for_each_map(thread__maps(thread), thread__prepare_access_maps_cb, &args);
+	}
 
-	return err;
+	return args.err;
 }
 
 static int thread__clone_maps(struct thread *thread, struct thread *parent, bool do_maps_clone)
-- 
2.43.0.rc2.451.g8631bc7472-goog

