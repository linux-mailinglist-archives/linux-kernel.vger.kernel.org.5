Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E94807DBE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443114AbjLGBTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442083AbjLGBTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:19:01 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375DC2136
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:18:29 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d340a9cf07so1747757b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911908; x=1702516708; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aFxV3Xhm3dKZsR7pRkHrvO8DCjszBbrDjVot/5oMgb4=;
        b=DNsTjXX+m329jmn5Y7tc9qHuqULRYS0ZYQ5qpMeiFukTBmYufv+mUxwJu4mxdS4ddM
         I0ZmG9vXZPajBTqv0RylidZ6FQrxE5y9YI9Y0o+1F/wcqqX6ZFKK3V7ogQapEPP198Dq
         t0BjjB+gfEl+spOo7waFtLbiLrPHfdfL+9xhkmnv+kL3hoTRKvdB4nBroiM5J2zGAdOX
         p4iGDmyMSN4WtfWOFWSRT/k6u6qvamE14fVklZA/6trtvQwAatwu29UTOeQUxoVF5H6y
         5gAHnUA0HimBJ/5/Y+eMbaWfyD4be5PgIFHinLyCD2K5siDi1kN1IUJyRFC94sP0d8MD
         Tljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911908; x=1702516708;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFxV3Xhm3dKZsR7pRkHrvO8DCjszBbrDjVot/5oMgb4=;
        b=H+XlZizNO8o/benp9CDagUok6SNzzdBtg/ZbxJLAxBIe+LYT1xrVGk2qBdtv+nA7Hw
         sSn7m7AFTIoALsFpy0JYIDobYsTDusHnRlWLF5m/HD9QS6LavsdDom5XwGpjsRU6YCA/
         s/x3l89hnJl6NzWavDdl96P60HPH+mgGrdprUvUJbnH3PgOmCN8k8bHQ11uikOvGH0+x
         mRHJgscht9b7WKMtd9na55M+nGofEFxQVwXRGhT1nWvTOeG0RLSF+DBjiH5YbXRtdhNk
         3qUjE8DDuwSjw5rZfzyhsWyvbLWG8rbykTRhfo4aOJxUEg7FlWY7KS8GaUboEiiWbP+t
         lRpA==
X-Gm-Message-State: AOJu0YwLmwF9iM74qYwWJ6GyhN9Q4xw6M3KqSaci/GgDbuuReTBCZRdg
        395iItRI3BG0SVqPMIOyO/0o4/1U5dox
X-Google-Smtp-Source: AGHT+IFxTotJi6DcsawuktLqLgyk9JG4gexkhwSJOlGAicnnz4BBzSheVsiRKJDMTLUk9G4t/auHHuUyUvE8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:99d0:0:b0:5d4:3013:25d4 with SMTP id
 q199-20020a8199d0000000b005d4301325d4mr31873ywg.5.1701911907896; Wed, 06 Dec
 2023 17:18:27 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:17:00 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-27-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 26/47] perf maps: Get map before returning in maps__find_next_entry
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

Finding a map is done under a lock, returning the map without a
reference count means it can be removed without notice and causing
uses after free. Grab a reference count to the map within the lock
region and return this. Fix up locations that need a map__put
following this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 4 +++-
 tools/perf/util/maps.c    | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7031f6fddcae..4911734411b5 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1761,8 +1761,10 @@ int machine__create_kernel_maps(struct machine *machine)
 		struct map *next = maps__find_next_entry(machine__kernel_maps(machine),
 							 machine__kernel_map(machine));
 
-		if (next)
+		if (next) {
 			machine__set_kernel_mmap(machine, start, map__start(next));
+			map__put(next);
+		}
 	}
 
 out_put:
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index b85147cc8723..0438c417ee44 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -943,7 +943,7 @@ struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 	down_read(maps__lock(maps));
 	i = maps__by_address_index(maps, map);
 	if (i < maps__nr_maps(maps))
-		result = maps__maps_by_address(maps)[i]; // TODO: map__get
+		result = map__get(maps__maps_by_address(maps)[i]);
 
 	up_read(maps__lock(maps));
 	return result;
-- 
2.43.0.rc2.451.g8631bc7472-goog

