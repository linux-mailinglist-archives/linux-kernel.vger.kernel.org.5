Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7873F76BF6A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjHAVmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjHAVmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:42:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553D31FDA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:42:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDB9B6162C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 21:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E137C433C8;
        Tue,  1 Aug 2023 21:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690926170;
        bh=sVMbvlwuoJ5vjWfQinZxmH1t6ndRFcWLp4U0FAFY/IQ=;
        h=Date:From:To:Cc:Subject:From;
        b=rP1HGRkjQ+WQQb1XzDiMaR8nmI6EwrsJTQmDhvUDiiObY/3S6uj4JTBz0qHwMWNIc
         jzQk31jBnJ7bKmDS7tfRTBc9udiTQGCvEEsBOvcuZH9ZEkjkScthmhKxFnOjnumtSn
         DI70RrO1DSF6oJcxx9rB0YUj9tjWtBOm/F7EqBhvI2CtNOiwke0I55FeFlHlle5H1n
         gKlMD52VO+/yDSSYGnLWKEl3mnuiDFcctvWb7gK5GqMxRSxEr5GCzpuxqZDiuN+rcq
         GkPdhwO/pQlwGtnglNInT8sbFIRJWd1zWQfy1w3YtyjRZcOYTt4OVpX1B+xWq7KmBq
         frETTWL2hhV3Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 662344012D; Tue,  1 Aug 2023 18:42:47 -0300 (-03)
Date:   Tue, 1 Aug 2023 18:42:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] Revert "perf report: Append inlines to non-DWARF
 callchains"
Message-ID: <ZMl8VyhdwhClTM5g@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artem,

	Can you please double check this? I reproduced with:

git checkout 46d21ec067490ab9cdcc89b9de5aae28786a8b8e
build it
perf record -a -g sleep 5s
perf report

	Do you get the same slowness and then reverting it, i.e. just
going to HEAD~ and rebuilding getting a fast 'perf report' startup, i.e.
without the inlines in the callchains?

- Arnaldo

----

This reverts commit 46d21ec067490ab9cdcc89b9de5aae28786a8b8e.

The tests were made with a specific workload, further tests on a
recently updated fedora 38 system with a system wide perf.data file
shows 'perf report' taking excessive time, so lets revert this until a
full investigation and improvement on the addr2line support code is
made.

Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Artem Savkov <asavkov@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 4e62843d51b7dbf9..f4cb41ee23cdbcfc 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -45,7 +45,6 @@
 
 static void __machine__remove_thread(struct machine *machine, struct thread_rb_node *nd,
 				     struct thread *th, bool lock);
-static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip);
 
 static struct dso *machine__kernel_dso(struct machine *machine)
 {
@@ -2385,10 +2384,6 @@ static int add_callchain_ip(struct thread *thread,
 	ms.maps = maps__get(al.maps);
 	ms.map = map__get(al.map);
 	ms.sym = al.sym;
-
-	if (!branch && append_inlines(cursor, &ms, ip) == 0)
-		goto out;
-
 	srcline = callchain_srcline(&ms, al.addr);
 	err = callchain_cursor_append(cursor, ip, &ms,
 				      branch, flags, nr_loop_iter,
-- 
2.41.0

