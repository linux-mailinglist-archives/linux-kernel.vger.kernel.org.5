Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753F37705F0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjHDQ1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjHDQ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:26:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE5AB2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:26:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D0BB620A2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 16:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F89C433C8;
        Fri,  4 Aug 2023 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691166417;
        bh=ACk8geC5Ad3yUxnQnqnzZgaw1hz6IEnl1r8+DhsC49k=;
        h=Date:From:To:Cc:Subject:From;
        b=KDPtu2qHrScYkuf/q/8F0xIH+JhIxTbZ/746X8MoAYSOJxRp6CPdUJ/gQJkl4XyzO
         X1cfsorhrs/qAwo9ixxRa8LgcWkQxaPSyey4NvaRiTQK8OvBVXV71opX6JisuCsypl
         XSUvT62CI47edGvHCS9f8hT3bv7heSK1NYrdCd8Uxc0FV49yiUGCwFAWxT+hQXYP9i
         CipNk3E7ToUhLiEOn4Hk9PAqeIx5aa3cbYiiPMbtZ/biV2YDEYfSRH9s/DmEsLaubt
         hFTatrZKbZ/kWYwTi5wKiWhZl8tAE8bcoTvEPFQvNhlQDGU3U0xrL/PwyVoqvJGHvT
         I2zEZV6S1URwQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 569EC404DF; Fri,  4 Aug 2023 13:26:54 -0300 (-03)
Date:   Fri, 4 Aug 2023 13:26:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf probe: Free string returned by
 synthesize_perf_probe_point() on failure in synthesize_perf_probe_command()
Message-ID: <ZM0mzpQktHnhXJXr@kernel.org>
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

Building perf with EXTRA_CFLAGS="-fsanitize=address" a leak was detected
elsewhere and lead to an audit, where we found that
synthesize_perf_probe_command() may leak synthesize_perf_probe_point()
return on failure, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-event.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index c7bfeab610a3679a..2835d87cb97771f9 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2063,14 +2063,18 @@ char *synthesize_perf_probe_command(struct perf_probe_event *pev)
 			goto out;
 
 	tmp = synthesize_perf_probe_point(&pev->point);
-	if (!tmp || strbuf_addstr(&buf, tmp) < 0)
+	if (!tmp || strbuf_addstr(&buf, tmp) < 0) {
+		free(tmp);
 		goto out;
+	}
 	free(tmp);
 
 	for (i = 0; i < pev->nargs; i++) {
 		tmp = synthesize_perf_probe_arg(pev->args + i);
-		if (!tmp || strbuf_addf(&buf, " %s", tmp) < 0)
+		if (!tmp || strbuf_addf(&buf, " %s", tmp) < 0) {
+			free(tmp);
 			goto out;
+		}
 		free(tmp);
 	}
 
-- 
2.37.1

