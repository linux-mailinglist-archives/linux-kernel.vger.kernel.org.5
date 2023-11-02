Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D397DF968
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbjKBSAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377155AbjKBR7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:59:17 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF921A7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:58:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a8ee6a1801so17484357b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947929; x=1699552729; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+qB7MKGYwy6W2k++DMikZr9fNmwsId1Vn+RjugNY41g=;
        b=2kwlR0lpTXuTW64udno04EcnsaMVxA4p7AtSyQX0zkP/STVAYorA9lf59BgHckoS+d
         fJh6v7+9w5/1uqRX/8Sm+SJHDNmnKQefaeM0O0On+O+7GnKx6QVe0m/bfhQFihl4sJjE
         u3G72vrs4MMdcd50F8xVhsPnoHB1DCFL/a8jQ7jJT1K8ujZ/ibUMCHA5pm7KN4AvjscN
         Sb/BcZdYhVULgt1+dUnskXJw124acjNEoxJmz0gNlDPLaBTZI8AOYlLiRKGLPjsDoBX+
         CdOHefqaWikHyjuD7fl+KbBk/9q4mgw5ISnfmPEFLbKC3VElagnt4s54nql2E2a76nah
         NBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947929; x=1699552729;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qB7MKGYwy6W2k++DMikZr9fNmwsId1Vn+RjugNY41g=;
        b=LF08+xJ+ac5dY4aXIqBY9WMpFPoqS27gDx2M+zDnDXOItKY18cAIB9n6Otcb4EbdUx
         VonebqQk7qZQzfoIHZ+1yQgs7RqV+jH3j7CPNDYOMQdbnMGOuH1n4J0LruHfXPhHkJn4
         aoG2k5/ee57QfsWgfV6cJPpt0R6R5nWFjiH5Lp6VHh7eAkSBYhyx+rlXaZkD7xuyxLhp
         NBP5CbiDHVFaEd1nzJ/MpO+TT8R583f1AFqByBh5XiQOi0pMkJBps7iRdutF3NruFfqH
         1GPB3MWeBQR9LbldwifNSsfl5GZ+Yrt9PuP41Fl8pGPa6+I3KXUOKIZnx1MRf6kg4fbf
         hVrA==
X-Gm-Message-State: AOJu0YyjACVN3iBj3msvMXpc0Rj9DyykFl0YshPLwgIDYkwjP/+U8FeY
        wqjohCgYyLLCgSiVvfUSNpbFVqdPTQnw
X-Google-Smtp-Source: AGHT+IGnNbr0ATXhvcobY5b1C+xpslu+egv1QsNnD9crxHuCIQZxikYpeND5J0/RExYebRMCygts88rccQXR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a05:6902:1802:b0:da0:94e8:84d4 with SMTP
 id cf2-20020a056902180200b00da094e884d4mr348163ybb.12.1698947929133; Thu, 02
 Nov 2023 10:58:49 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:57:05 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-24-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 23/53] perf maps: Rename clone to copy from
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename maps__clone to maps__copy_from to be more intention revealing
of its behavior. Pass the underlying maps rather than the thread.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 2 +-
 tools/perf/util/maps.c    | 6 +-----
 tools/perf/util/maps.h    | 3 +--
 tools/perf/util/thread.c  | 2 +-
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3c967295c9a3..191e492539e5 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -454,7 +454,7 @@ static struct thread *findnew_guest_code(struct machine *machine,
 	 * Guest code can be found in hypervisor process at the same address
 	 * so copy host maps.
 	 */
-	err = maps__clone(thread, thread__maps(host_thread));
+	err = maps__copy_from(thread__maps(thread), thread__maps(host_thread));
 	thread__put(host_thread);
 	if (err)
 		goto out_err;
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 14e1a169433d..85bea2a6dca9 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -452,12 +452,8 @@ int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 	return err;
 }
 
-/*
- * XXX This should not really _copy_ te maps, but refcount them.
- */
-int maps__clone(struct thread *thread, struct maps *parent)
+int maps__copy_from(struct maps *maps, struct maps *parent)
 {
-	struct maps *maps = thread__maps(thread);
 	int err;
 	struct map_rb_node *rb_node;
 
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 62e94d443c02..e4a49d6ff5cf 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -14,7 +14,6 @@ struct ref_reloc_sym;
 struct machine;
 struct map;
 struct maps;
-struct thread;
 
 struct map_rb_node {
 	struct rb_node rb_node;
@@ -61,7 +60,7 @@ struct kmap {
 
 struct maps *maps__new(struct machine *machine);
 bool maps__empty(struct maps *maps);
-int maps__clone(struct thread *thread, struct maps *parent);
+int maps__copy_from(struct maps *maps, struct maps *parent);
 
 struct maps *maps__get(struct maps *maps);
 void maps__put(struct maps *maps);
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 3d47b5c5528b..89c47a5098e2 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -390,7 +390,7 @@ static int thread__clone_maps(struct thread *thread, struct thread *parent, bool
 		return 0;
 	}
 	/* But this one is new process, copy maps. */
-	return do_maps_clone ? maps__clone(thread, thread__maps(parent)) : 0;
+	return do_maps_clone ? maps__copy_from(thread__maps(thread), thread__maps(parent)) : 0;
 }
 
 int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp, bool do_maps_clone)
-- 
2.42.0.869.gea05f2083d-goog

