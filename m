Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039167FE214
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbjK2Vew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjK2Vet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:34:49 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C6C10C2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:34:56 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5c87663a873so3332657b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701293695; x=1701898495; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cizzxjAOXVtNMhutvuRuFXeQ97rL+0eSPOInOH69jLw=;
        b=Jyc6mdJlqSGh9xCX+wfM42GM0qBnGD5xq2Oe1Q/ZhFBJ+UfF4AblVf9RHARky/hIig
         ztPcoXUdNalW/qrsjAUmWjj1hjgba/6ZexwnXmIYH+dFR0uhLx89qne/fQk9fvhSBlQl
         voc+aAcSqUsOkDhw4WABVcUCD23kmi5lwkHOLQXwsOYvpbdM2nt1eNRvQ7HlQyyHaYFb
         t1XhYlb4lm/y/dDlECVeDawqQ5QIygMVx9YGt6Bo9Xx+cVXmdWB8fLawvyVMbgAkScPv
         BlkF5ECe/9AnWYT0K3sPU5qPYrzwoDTmhPidNhiA6zLGvMI1c2oqP7BLJDOP9siqINMJ
         Ji0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293695; x=1701898495;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cizzxjAOXVtNMhutvuRuFXeQ97rL+0eSPOInOH69jLw=;
        b=b9lI1vUn29bWeVZv/Rcei9KRWZOvA+kQ+gLmqbYM0GxYZmr8sAvy7QEg+d0IVUjDwc
         4Xuuvic12q510gp05MiXDQQAAyZTm1Dn4MXEjo0T/mGu7ARrR09I43bvG0MJvESxiSRd
         jap+ZUg/YhdG1aMVEdKK6hxaI2fSXj8r22/7jO1e1al3AyhGKVi5qOik0QpFeiXG4OvK
         RZ4y0Uq2qwXB6kraIaEdfei/ZdNHmSilDoBuNisjZInKpR+9jlhVyReN0mINjRuD60rK
         /k9OGXvEoHNjpwAFQAVgvz9+ohdMesxl/YqB0E90bFBdcc/5woswOLZDF5sSCsILAI17
         3GCQ==
X-Gm-Message-State: AOJu0YysMZIqr4fZSfy4cPx1ygAqcWJAUBSARYOQq/U5XxDb79UXkyKU
        W8P9ZZ8qE1oSdoNG97vqQQ4nIios5UsU
X-Google-Smtp-Source: AGHT+IEICmGJwWEx/cFWveuWMKJXW7UeHt41M3PhcSdHqEKs3Yz7xCSJsn+fdDN20Xs9JTdY29NEsvHj+K2n
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a05:690c:2e05:b0:5ce:dff:f7a3 with SMTP id
 et5-20020a05690c2e0500b005ce0dfff7a3mr547030ywb.10.1701293695222; Wed, 29 Nov
 2023 13:34:55 -0800 (PST)
Date:   Wed, 29 Nov 2023 13:34:26 -0800
In-Reply-To: <20231129213428.2227448-1-irogers@google.com>
Message-Id: <20231129213428.2227448-2-irogers@google.com>
Mime-Version: 1.0
References: <20231129213428.2227448-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v2 2/4] perf list: Fix json segfault
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
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Json output didn't set the skip_duplicate_pmus callback yielding a
segfault.

Fixes: cd4e1efbbc40 ("perf pmus: Skip duplicate PMUs and don't print list suffix by default")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index a343823c8ddf..61c2c96cc070 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -434,6 +434,11 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
 	strbuf_release(&buf);
 }
 
+static bool json_skip_duplicate_pmus(void *ps __maybe_unused)
+{
+	return false;
+}
+
 static bool default_skip_duplicate_pmus(void *ps)
 {
 	struct print_state *print_state = ps;
@@ -503,6 +508,7 @@ int cmd_list(int argc, const char **argv)
 			.print_end = json_print_end,
 			.print_event = json_print_event,
 			.print_metric = json_print_metric,
+			.skip_duplicate_pmus = json_skip_duplicate_pmus,
 		};
 		ps = &json_ps;
 	} else {
-- 
2.43.0.rc1.413.gea7ed67945-goog

