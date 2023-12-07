Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F1A807DC2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442982AbjLGBTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443001AbjLGBTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:19:10 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A382689
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:18:33 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d67fc68a82so1634357b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911912; x=1702516712; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4LNOfIhT6VQbu6YMuQ9Daw6AHLC7GC1HLAQGXsSFOs8=;
        b=spC5VPaNjMYyYixRS9qcQXXZoWN9vbtNwnlhpT5POFovwtcF9BkGOs+X6uhrTS42dD
         nx2g1Si0i9s8Vo+aGiuxPvF/K06r9/Cm449seCJRGFAo5W9JUEsp4tw6nMouyLTCNpFN
         Ma58HAgGEgQiGSCCn9j3fTmfvuBWENZdeOpA0lUOqSAkDeLHDI3EzAn70K4H8rKLIkjL
         7h7PBM928LIW90a16orEDSgD21cFSRMxb1OyWWW2DPQnH4ylQ4N4cxWyLmBivOrWFLpj
         A0lkUmfDB0zFIng5KOQK6xZGXu2RUZo/QjaFaLOUHcNoSh1878zX8aNAqEUL+IFztUrZ
         linw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911912; x=1702516712;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LNOfIhT6VQbu6YMuQ9Daw6AHLC7GC1HLAQGXsSFOs8=;
        b=oOb5jkfqD6NXlN3STR4D+/XtBY11SoBh2hmyD5ry6hLo7/ABK5E1Aijc1CqMGestqI
         l6QwgQc3n49KIW6HpUHp5GEwtephNr9JwcSXDyE3XgisA6K/DAuavCPbPGPuHmv+UQ06
         bj5fstjmooOBAa0mMwqxXbddc3MlVNoLfZe4h6/Z3hgOevNLgGIfWVK5b4nIahoBBaLT
         fgqhcspvUQR4GsoxBr3ZzCEc9in6yGUi4zOBv5ijCqQpmppbfnXwvfkr93I7V7woseSX
         9982dns1Bl23bIZb4skTyZr1THRAipGP+K55CSlOK2929b2xIoyDwy3nmio5byeL2dOi
         2FFA==
X-Gm-Message-State: AOJu0YzpAF0Pbw2KzH0T0n8DpI45W9O/N/4E9mFqJARkvTzaaiLZfDV5
        zQhJmKg3tAaOF7awF3gh6jNmR2f67gsS
X-Google-Smtp-Source: AGHT+IFI97iFSQmYgFB4tRS3qVXoRcjvu2Hrx0v/As4OljxClj3ZZta/nbR2nm3SBLgPyQFHJQRGptp33ALc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:be16:0:b0:5ca:20f3:ca21 with SMTP id
 i22-20020a81be16000000b005ca20f3ca21mr31037ywn.1.1701911912594; Wed, 06 Dec
 2023 17:18:32 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:17:02 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-29-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 28/47] perf maps: Locking tidy up of nr_maps
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

After this change maps__nr_maps is only used by tests, existing users
are migrated to maps__empty. Compute maps__empty under the read lock.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c |  2 +-
 tools/perf/util/maps.c    | 10 ++++++++--
 tools/perf/util/maps.h    |  4 ++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 4911734411b5..3da92f18814a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -440,7 +440,7 @@ static struct thread *findnew_guest_code(struct machine *machine,
 		return NULL;
 
 	/* Assume maps are set up if there are any */
-	if (maps__nr_maps(thread__maps(thread)))
+	if (!maps__empty(thread__maps(thread)))
 		return thread;
 
 	host_thread = machine__find_thread(host_machine, -1, pid);
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index c08e412a4313..cb52de9d6c2a 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -528,7 +528,13 @@ void maps__remove(struct maps *maps, struct map *map)
 
 bool maps__empty(struct maps *maps)
 {
-	return maps__nr_maps(maps) == 0;
+	bool res;
+
+	down_read(maps__lock(maps));
+	res = maps__nr_maps(maps) == 0;
+	up_read(maps__lock(maps));
+
+	return res;
 }
 
 bool maps__equal(struct maps *a, struct maps *b)
@@ -852,7 +858,7 @@ int maps__copy_from(struct maps *dest, struct maps *parent)
 
 	parent_maps_by_address = maps__maps_by_address(parent);
 	n = maps__nr_maps(parent);
-	if (maps__empty(dest)) {
+	if (maps__nr_maps(dest) == 0) {
 		/* No existing mappings so just copy from parent to avoid reallocs in insert. */
 		unsigned int nr_maps_allocated = RC_CHK_ACCESS(parent)->nr_maps_allocated;
 		struct map **dest_maps_by_address =
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 4bcba136ffe5..d9aa62ed968a 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -43,8 +43,8 @@ int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data)
 void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data);
 
 struct machine *maps__machine(const struct maps *maps);
-unsigned int maps__nr_maps(const struct maps *maps);
-refcount_t *maps__refcnt(struct maps *maps);
+unsigned int maps__nr_maps(const struct maps *maps); /* Test only. */
+refcount_t *maps__refcnt(struct maps *maps); /* Test only. */
 
 #ifdef HAVE_LIBUNWIND_SUPPORT
 void *maps__addr_space(const struct maps *maps);
-- 
2.43.0.rc2.451.g8631bc7472-goog

