Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2944A770627
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjHDQiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjHDQim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:38:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E44CE7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:38:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0880620A6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 16:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140F2C433C7;
        Fri,  4 Aug 2023 16:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691167120;
        bh=qcJmbyKrYS1D8pZSxSWl2IPsapUnOSqx7XtwpMAymew=;
        h=Date:From:To:Cc:Subject:From;
        b=sdwHziPjIpgFr0QXhr0cMolYytboK7rTwF4y1BjYwfNLHd/bndW6VrIhxURbu5rb5
         bRDTEhq2bgT5hMt1CbYqaaHF0Wi0MfwlUOHOLy6R0q9pBlRHaaEtyytzC8XFGbQpwt
         L84eKKYhavD3pBeSSwi2jBbyYykUTBtGgsjMhnsbFa9h/VoBo++AaRyU8UqaFTW718
         aEVvpeIOS2WuLJFws6PuZXNBLxiUQJZ6A6i5kD0LgTkjW6JFRxdom7qcP+oJ3K2cjD
         SRCPQR6rsc5fEi1c8pVfVuyKLPH5zc6kq4ZFlsTtgZl2DHMA6VQiLl0wQ+fw4UoSlb
         aJVf8mzqia0jg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7A6AC404DF; Fri,  4 Aug 2023 13:38:37 -0300 (-03)
Date:   Fri, 4 Aug 2023 13:38:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf probe: Make synthesize_perf_probe_point() private
 to probe-event.c
Message-ID: <ZM0pjfOe6R4X/cql@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not used in any other place, so just make it static.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-event.c | 4 +++-
 tools/perf/util/probe-event.h | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 2835d87cb97771f9..1a5b7fa459b23204 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -53,6 +53,8 @@
 bool probe_event_dry_run;	/* Dry run flag */
 struct probe_conf probe_conf = { .magic_num = DEFAULT_PROBE_MAGIC_NUM };
 
+static char *synthesize_perf_probe_point(struct perf_probe_point *pp);
+
 #define semantic_error(msg ...) pr_err("Semantic error :" msg)
 
 int e_snprintf(char *str, size_t size, const char *format, ...)
@@ -2010,7 +2012,7 @@ char *synthesize_perf_probe_arg(struct perf_probe_arg *pa)
 }
 
 /* Compose only probe point (not argument) */
-char *synthesize_perf_probe_point(struct perf_probe_point *pp)
+static char *synthesize_perf_probe_point(struct perf_probe_point *pp)
 {
 	struct strbuf buf;
 	char *tmp, *ret = NULL;
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 8ad5b1579f1d37b6..7e3b6c3d1f7447a7 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -137,7 +137,6 @@ int parse_probe_trace_command(const char *cmd, struct probe_trace_event *tev);
 char *synthesize_perf_probe_command(struct perf_probe_event *pev);
 char *synthesize_probe_trace_command(struct probe_trace_event *tev);
 char *synthesize_perf_probe_arg(struct perf_probe_arg *pa);
-char *synthesize_perf_probe_point(struct perf_probe_point *pp);
 
 int perf_probe_event__copy(struct perf_probe_event *dst,
 			   struct perf_probe_event *src);
-- 
2.37.1

