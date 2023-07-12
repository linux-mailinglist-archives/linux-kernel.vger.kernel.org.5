Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7C575112F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjGLT1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGLT1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:27:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B4E1FC2;
        Wed, 12 Jul 2023 12:27:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8691C618FE;
        Wed, 12 Jul 2023 19:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71803C433C7;
        Wed, 12 Jul 2023 19:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689190030;
        bh=I4h7Yeuk8cjAvkK7nzWJvSd2OsH0XfgbJKcEyncPcYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGmI1DbSs7GmWFUUS+LWg3ldl4I3D35GrXpbod6F+tH+LYic9zD+X4O316Tv9anGe
         3cpe4BhZahUvd4LmXEcmtxtK25IAphke+1TPdw/vZOFHX0mH12bBcuq1oAqSG7fkVx
         NwV629Qx5HLhm6XApy5o6tXf2U4RQpm3Q+b76rbveixm8Z6mQZg8oEaJi6PMzQKAGH
         x7dv3FxBBP+xKA1iz0xbI6sTHoD1vwAj5Y/ziBu5I0rqziMizK4YxJ+18FHY3PoMhF
         7Omng0cKg0wZ63eql0Rolsb0z5E42llOIP/08ga/1ZUbvF3+IzRLnYkS6LNFaL6rUl
         ++zX3JKmjsY8A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5F0E940516; Wed, 12 Jul 2023 16:27:07 -0300 (-03)
Date:   Wed, 12 Jul 2023 16:27:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf parse-events: Avoid segv if PMU lookup fails for
 legacy cache terms
Message-ID: <ZK7+i63XprkGwjCE@kernel.org>
References: <20230712065250.1450306-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712065250.1450306-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 11, 2023 at 11:52:50PM -0700, Ian Rogers escreveu:
> libfuzzer found the following command could segv:
> ```
> $ perf stat -e cpu/L2,L2/ true
> ```
> This is because the L2 term rewrites the perf_event_attr type to
> PERF_TYPE_HW_CACHE which then fails the PMU lookup for the second
> legacy cache term.
> 
> The new failure is consistent with repeated hardware terms:
> ```
> $ perf stat -e cpu/L2,L2/ true
> event syntax error: 'cpu/L2,L2/'
>                             \___ Failed to find PMU for type 3
> 
> Initial error:
> event syntax error: 'cpu/L2,L2/'
>                             \___ Failed to find PMU for type 3
> Run 'perf list' for a list of valid events
> 
>  Usage: perf stat [<options>] [<command>]
> 
>     -e, --event <event>   event selector. use 'perf list' to list available events
> $ perf stat -e cpu/cycles,cycles/ true
> event syntax error: 'cpu/cycles,cycles/'
>                                 \___ Failed to find PMU for type 0
> 
> Initial error:
> event syntax error: 'cpu/cycles,cycles/'
>                                 \___ Failed to find PMU for type 0
> Run 'perf list' for a list of valid events
> 
>  Usage: perf stat [<options>] [<command>]
> 
>     -e, --event <event>   event selector. use 'perf list' to list available events
> ```

I added the Fixes as requested:

Fixes: 6fd1e5191591f9d5 ("perf parse-events: Support PMUs for legacy cache events")

Please check if the patch below helps a bit giving more info to the
user, but still a bit cryptic:

⬢[acme@toolbox perf-tools]$ perf stat -e cpu/L2,L2/ true
event syntax error: 'cpu/L2,L2/'
                            \___ Failed to find PMU for perf_event_attr.type 3 (PERF_TYPE_HW_CACHE)

Initial error:
event syntax error: 'cpu/L2,L2/'
                            \___ Failed to find PMU for perf_event_attr.type 3 (PERF_TYPE_HW_CACHE)
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
⬢[acme@toolbox perf-tools]$

And the other case is needs more patching, so better leave this for 6.6.


⬢[acme@toolbox perf-tools]$ perf stat -e cpu/cycles,cycles/ true
event syntax error: 'cpu/cycles,cycles/'
                                \___ Failed to find PMU for type 0

Initial error:
event syntax error: 'cpu/cycles,cycles/'
                                \___ Failed to find PMU for type 0
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
⬢[acme@toolbox perf-tools]$

- Arnaldo

diff --git a/tools/perf/util/evsel_fprintf.h b/tools/perf/util/evsel_fprintf.h
index c8a9fac2f2ddc0f2..044612774a962020 100644
--- a/tools/perf/util/evsel_fprintf.h
+++ b/tools/perf/util/evsel_fprintf.h
@@ -4,6 +4,7 @@
 
 #include <stdio.h>
 #include <stdbool.h>
+#include <linux/types.h>
 
 struct evsel;
 
@@ -45,6 +46,8 @@ int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
 
 typedef int (*attr__fprintf_f)(FILE *, const char *, const char *, void *);
 
+const char *stringify_perf_type_id(u64 value);
+
 int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 			     attr__fprintf_f attr__fprintf, void *priv);
 #endif // __PERF_EVSEL_H
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index acde097e327cce8c..8678469cf974070a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -25,6 +25,7 @@
 #include "asm/bug.h"
 #include "util/parse-branch-options.h"
 #include "util/evsel_config.h"
+#include "util/evsel_fprintf.h"
 #include "util/event.h"
 #include "util/bpf-filter.h"
 #include "util/util.h"
@@ -1219,9 +1220,11 @@ static int config_term_pmu(struct perf_event_attr *attr,
 		if (!pmu) {
 			char *err_str;
 
-			if (asprintf(&err_str, "Failed to find PMU for type %d", attr->type) >= 0)
+			if (asprintf(&err_str, "Failed to find PMU for perf_event_attr.type %d (%s)", attr->type,
+				     stringify_perf_type_id(attr->type)) >= 0) {
 				parse_events_error__handle(err, term->err_term,
 							   err_str, /*help=*/NULL);
+			}
 			return -EINVAL;
 		}
 		if (perf_pmu__supports_legacy_cache(pmu)) {
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 2247991451f3aa1b..ce97371eda027271 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -74,7 +74,7 @@ static void __p_read_format(char *buf, size_t size, u64 value)
 }
 
 #define ENUM_ID_TO_STR_CASE(x) case x: return (#x);
-static const char *stringify_perf_type_id(u64 value)
+const char *stringify_perf_type_id(u64 value)
 {
 	switch (value) {
 	ENUM_ID_TO_STR_CASE(PERF_TYPE_HARDWARE)
