Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE347FAD19
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbjK0WMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbjK0WLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:11:40 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7CF12C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:10:29 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5c994880223so71192747b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123028; x=1701727828; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CbcVF6J0KDbkpD4NFjsmD9Sp0o+LDZsZhXDUnXGxxY8=;
        b=qfn0pr6k8F1baAihRSRQbB96jNImBoDJ0lGgMPqiRsWQKUFUkD/ZLlrxleou5txL4x
         nwllzS6Yu7Rx5E2mDiDYHvv3UuxAei5JG3iCaXGLZDb4IGratMRif99wP3sKgu2cZjZN
         aOTHdaiuTEAVezBZI8gVi/S7KEHnNZT+CR/3yKqJa0CHZDFDYKYD6odlat8UfvSEGdN7
         FfM0jmdcjwDWedfbcjxUeHyfq07JR3rMqhSBbSVXBjP1s5MFuqyqUuaL4z5sbefgzdNk
         NL4yKtJfvcm560CsR4G9DXDPFrS5hVZel7FpCWiUc6W4JMnj2TwJ2I5DkUY5U/PkhGol
         BLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123028; x=1701727828;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbcVF6J0KDbkpD4NFjsmD9Sp0o+LDZsZhXDUnXGxxY8=;
        b=e/Q6FrewnrNLW1e9zFJXt4qcE7d677fF508AHHs/qR4RBBa1HLjrJQP+FgUPBjekre
         Mqr+pPXrOYOMx4rpXgggP3mZ4cW9pWXuF3o8GHP2SyTAxhzWGmspSrxEbIBRM80UPKxJ
         e2q5jIY3hUeFDPd6VjmAp+xDFkg6rnp4teyFUaidhqdJSraf29t7Cb4mk+jLrl4JToPg
         A5ftTXRkiimZqqCMWdwvwd9raBMpsdTjOLlA1NQs9oWwWLzlhRsT18rnddTtJDC9GdRc
         EEWUL/u3jLZ8jzIzgHcziioIMUYaL3QULlOQEnQz0aSIoiGnUHVSEAyDvIBsVw5PN0jh
         88Kg==
X-Gm-Message-State: AOJu0Yx9bGHj62WKW2czAxyBHNxKrkXfS2/yENLrmY4BUiYw0m3qdspi
        d+K8h6lEk1oYFCzTPjfIfKrPoVOkRGMj
X-Google-Smtp-Source: AGHT+IGTGYqhEQe3GwIWy0LYkYLR6Szw+7ZpfEuawJN+o+/eJV1rmU9Hyau6TX3amswfEQM9gzA5t4t7zQSc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a05:690c:2e10:b0:5ca:400:f1c with SMTP id
 et16-20020a05690c2e1000b005ca04000f1cmr376976ywb.8.1701123028227; Mon, 27 Nov
 2023 14:10:28 -0800 (PST)
Date:   Mon, 27 Nov 2023 14:08:40 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-29-irogers@google.com>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 28/50] perf maps: Get map before returning in maps__find_next_entry
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
index d6b3f84cb935..42d73f00f9c1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1758,8 +1758,10 @@ int machine__create_kernel_maps(struct machine *machine)
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
index 8a8c1f216b86..b3937e734cbf 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -942,7 +942,7 @@ struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 	down_read(maps__lock(maps));
 	i = maps__by_address_index(maps, map);
 	if (i < maps__nr_maps(maps))
-		result = maps__maps_by_address(maps)[i]; // TODO: map__get
+		result = map__get(maps__maps_by_address(maps)[i]);
 
 	up_read(maps__lock(maps));
 	return result;
-- 
2.43.0.rc1.413.gea7ed67945-goog

