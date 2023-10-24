Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4637D5E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344552AbjJXWhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344608AbjJXWgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:36:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA7730C7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f61a639b9so68801927b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186336; x=1698791136; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZGWaGIyb2MLTR6FKf9sQ21nNy6Say3HBAADxZHBZRA=;
        b=pRRwvyFwnHwcygLAejayEt2NNSybuNbRUx0dieNKbFFQqJu7pI8tjFYOrawnhYicxv
         1k0s8yf+6VTLk4WCYSzaql5nS7MVqnV5XCK/g8ICGM/5ONMACRtQHl5LAKKoiJSkVzpN
         ZsZSKpI+3/nviSFk61QM/s2HdbcWWOt3eneMrl1frMOC92ZOB0zCHQxiH+B+NMIeWo6/
         OFeWUFRa8I2PAcYmzsGZW5u14sz2uGvKKMCPjejuiVyNyeB+62N037HQ9wkSImkPutMQ
         n/7rf3FqhGekKlkSqe3kylPdv2yUruR3m8WaAT2A3bPBlQtfL+ujG18gdSUrRdMs0DqJ
         +uLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186336; x=1698791136;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZGWaGIyb2MLTR6FKf9sQ21nNy6Say3HBAADxZHBZRA=;
        b=iF0NhXb42ayiOXxm3QBv9qYib3DX5PhiNTE0UFhLCAmEEgKUvUbnKo6SQHmbj5m9HK
         Vpq2g01QNoMjufQTTyYOSDFKxLdll33NJXOJFQxK82SJbxbj0lYbU8+a3+Im3lt1TRGJ
         ggzucvkpjLzPSQYqvvcnF+KbBe06fwKbut4tfrNeZ+a24QcCStmZ6vSeQzLSuCDQEJ+f
         wnyjUpf6YdsXhrIV823jto0hHmE8I6fUloTa/mZXmCfP7ZfDXaos2k4+8o6fIDc1c6/N
         pu+oha/tNSm8HUQ7VeLwPKX8l3M7pk1jr6VG7qLdi/HFXAhEDNL8rU+gI6PE96ry4f6V
         0w3Q==
X-Gm-Message-State: AOJu0YxZodC4Q2Ridl61+nkslqaHXJCoRbS1+1xCpPc/jKGd5Kuo9gwc
        pjpqwJIAkRjKhJ3LjmhR/SjBw2LmqXN7
X-Google-Smtp-Source: AGHT+IHVz7pXh1CNxQ6qdbvifEOQamlKLSHKq/wbY1rZuBe6FFyXXl//ZLSKV7rNVjPdUV1Iae1P5nBb37CA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a0d:e8c6:0:b0:5a7:b54e:bfc1 with SMTP id
 r189-20020a0de8c6000000b005a7b54ebfc1mr337662ywe.10.1698186335876; Tue, 24
 Oct 2023 15:25:35 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:40 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-38-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 37/50] perf maps: Fix up overlaps during fixup_end
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
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
2.42.0.758.gaed0368e0e-goog

