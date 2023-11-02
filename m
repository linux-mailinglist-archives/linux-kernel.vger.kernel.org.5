Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732D57DF96A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345761AbjKBSAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345059AbjKBR7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:59:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC53D77
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:58:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7af69a4baso17193977b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947938; x=1699552738; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZBuX81183QRrNaiqbrsOc3T/YgY2oF4/Db+YNFRBBQ=;
        b=CnWi1pUOApOSGz7yPQQN2/n66MaHAO7Hjl2ZVWURDfA5rrkBZPFC1ahMouJimPDjaU
         AxO37SZ/AXfly5TXSnzvXhQJgcbmM0mqVIY+Rvt37lWITKM0bJp4di7KWDcSB1xnnKYr
         xvJBjsiHNJGS+/KlnxG7SsQVZcZTUHtXi5bjm4Pw/NB4BtZMUrq+ypP1jrumyV9modXO
         3sQgVJq1ji87YThnejgrDysCajgLCD3J8ObCbu2rPXOuBxGUjBN6Rmxt5YTwOhkBW/DQ
         j8XjmsqRn/2r7Nktof5dpjCoSv97OP7WvcWloP/Ik4VL+i9e9dOt1oDi1Yohm72JiGUs
         ihBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947938; x=1699552738;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZBuX81183QRrNaiqbrsOc3T/YgY2oF4/Db+YNFRBBQ=;
        b=crYhmgTtaxzoW+AbN/LN6NMh/ByMxQeVaT+6s+3Z87bZXjZZn++Y5hjRY/WkDJYqlA
         4GZFc1LFXCMPTKb2PpP49gTnUdNQnpYMDQ2QLWhjhWMJQ5OIUbd05hJIAVlKSDkFQ9sy
         A/Opywz4jo+UzXpyUjgjsZb+mJQoPDSyHZzugMEWrbtZZqyPPKE9R76GdJu/jCZca4I/
         omnxU678+IO2DSM32c0u4hq2y2K5qmi3qYwxLe83AhioGfktPBquOVFqrMmPy0OJ2LDB
         NrxWo0oJLsLK8jJSPJW2Z8BwTB5OlhGrlx1lVT4BESisqbviCxAdz6/F8wlI0MdhmBD3
         15RQ==
X-Gm-Message-State: AOJu0YyeRSe7f7sU5IsAidNbKNwYYf5ELnTxs+OrMqtSpL8Rk8NPKiro
        XYXfADzGGyCsG1AEquhc+87t3FsP3RHF
X-Google-Smtp-Source: AGHT+IEl3qANM6gjbu74OwwL0Dqv2kvdXq7ayyS5FKZI30Es8f2oT9DzQiwouXtKFDxkyMl9cz0lzSCZTaJt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c3b8:4274 with SMTP
 id v3-20020a056902108300b00d9ac3b84274mr460470ybu.7.1698947937955; Thu, 02
 Nov 2023 10:58:57 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:57:09 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-28-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 27/53] perf maps: Fix up overlaps during fixup_end
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maps are sometimes made overlapping, in particular kernel maps. If the
end of a map overlaps the start of the next, shorten the overlapping
map. This should remove potential non-determinism in maps__find, ie
finding maps by address.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 01c15d0b300a..fba95a00ecdf 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -700,7 +700,7 @@ void maps__fixup_end(struct maps *maps)
 	down_write(maps__lock(maps));
 
 	maps__for_each_entry(maps, curr) {
-		if (prev != NULL && !map__end(prev->map))
+		if (prev && (!map__end(prev->map) || map__end(prev->map) > map__start(curr->map)))
 			map__set_end(prev->map, map__start(curr->map));
 
 		prev = curr;
-- 
2.42.0.869.gea05f2083d-goog

