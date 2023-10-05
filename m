Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A587BA475
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbjJEQFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbjJEQED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:04:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AE95DFCF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:07:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDC9C36AF0;
        Thu,  5 Oct 2023 13:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696512582;
        bh=eKVQkVdvM1LQ6mdxoEN/45x8ioQAGbo/3OSjYqGT/r0=;
        h=Date:From:To:Cc:Subject:From;
        b=aAWQyKUh4zUic5w8JBKR8q7LW20d07MjI5VXbf1ZNy1lm5Ck3Dat2QYjvA4xwfbh6
         26SCzaTVtVL3YmmU0temuuhTrpvaPygIvxS8CZx5tdXKano1Prdgdf5GEHKLGNS4zv
         rQcRIu68EyVNBFmpPxMI8ARH9pd23Do6Ek+twgfZ0h5FwkQz00ki+B+j6SnzmTiKZ2
         TcH2QiBxBb6hF7djVLFHd4mNemkWrO25oRWaR8LY6WvN7gstiUSrjsIsJnC+tIIzPT
         cTQAKDEhMkiqWJkfzABR9m8Qmlqbe3JkSUyfV5IgNG0Ne1kW9WMdLQL2PPnpGNYrBu
         SZcrbTCr0LXzA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 693B640508; Thu,  5 Oct 2023 10:29:38 -0300 (-03)
Date:   Thu, 5 Oct 2023 10:29:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf symbols: Add 'intel_idle_ibrs' to the list of idle
 symbols
Message-ID: <ZR66Qgbcltt+zG7F@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This is a longstanding to do list entry: we need a way to see that a
sample took place while in idle state, as the current way to do it is
to infer that by the name of the functions that in such state have
more samples, IOW: a hack.

Maybe we can do flip a bit in samples that take place inside the
enter/exit idle section in do_idle()?

But till then, add one more :-\

Cc: Adrian Hunter <adrian.hunter@intel.com>
cc: Frédéric Weisbecker <fweisbec@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>,
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 5b54d2639df4740e..3c7f483bf85bbdaf 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -718,6 +718,7 @@ static bool symbol__is_idle(const char *name)
 		"cpu_startup_entry",
 		"idle_cpu",
 		"intel_idle",
+		"intel_idle_ibrs",
 		"default_idle",
 		"native_safe_halt",
 		"enter_idle",
-- 
2.41.0

