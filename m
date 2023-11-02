Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D727DF966
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377163AbjKBSAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347307AbjKBSAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:00:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B9110E7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:59:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da1aa98ec19so1505562276.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947947; x=1699552747; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6PNDEm4kXFYBRRJS/3kBphkCUT3Aht0BTpc1/MnMORo=;
        b=EdRsqPT9Z6IitF7UNmJ1MqJbQ1LRcbnwMchwXw+Osz9EnJtvp3Sf7wPq4ojGblPMbJ
         xR6hh3WA1tZFno29T93wu0OVRP9KCFjiMwCXDgYRIGA0oZlL+r4yxmbIaavTwmrnNQHX
         xVta6TMgfxgYCBa/27InAo+1njsxZNtjMJ83C98y5nTg7WKX66d9N4RmDLWkikbpz/LY
         VK35XKHVKs1vnxaPpG7BULGRoEBc0ln8n1UNVKV3+zmCvQXM4u57DpYv53gy5QtDd1ic
         hsjtWMzIr5wUKW6g+ozC4/09rzcAH6vdFr5wIWzFfee7tXKbqQlWw8A6NTSkBlVqIrvp
         gySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947947; x=1699552747;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6PNDEm4kXFYBRRJS/3kBphkCUT3Aht0BTpc1/MnMORo=;
        b=PPXqREMfP0dRFDj3AC6J8RWs0qJhjD1J1rGrd39yfb6Ueiw1cIDXi7U9pwYrxmBH81
         hZ+vS4rl7H2JB6ziB3XZMD1qTxlHCBv8y17tF6J3YrQi6qyL6rZTnnQuL+yV0x40m0mQ
         iAons2ji0928Tcb6XiaFm6QzKRNRdoroXEOogjk5px4IzVLE114RqPEPbsTY0CGqHvXs
         j0mm6jSxeIOSflGv5PHuK4TB7+Lk31xSpp/TG+439rHvFZRXTX7WdwF4ZjhbaLYiTifh
         Ttl7CRxoL9IoBbQ6hOeLAxRdT6eU73TMCgar44NrALsmeh+Y1wwxk5p3OvndvsefR4eI
         mvDA==
X-Gm-Message-State: AOJu0YxCKj5lpci7Sdr6qj30hV74E2cavzzAbiqFCIGA2xfncGJsJ14x
        7CdFbzI4zLeM+VAiA3o1v+5bEX4bTCFl
X-Google-Smtp-Source: AGHT+IF+cWgSSfhxpeeuOHFqoRGRmXJ3mqF1i0jjCiOcex7QRcRMY027wZdOr2vJoPhUhUc9sWQJtFYqtadx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a25:9392:0:b0:da0:cbe9:6bac with SMTP id
 a18-20020a259392000000b00da0cbe96bacmr390511ybm.11.1698947947552; Thu, 02 Nov
 2023 10:59:07 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:57:13 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-32-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 31/53] perf maps: Get map before returning in maps__find_next_entry
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
2.42.0.869.gea05f2083d-goog

