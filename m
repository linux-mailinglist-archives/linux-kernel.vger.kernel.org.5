Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4BC809225
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443879AbjLGURL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjLGURJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:17:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2C6171D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:17:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A60C433C7;
        Thu,  7 Dec 2023 20:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701980231;
        bh=YVfqxd0zx/fv0cFbJkxcuU4zrXFaSan10Z7fzxNA38Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jvc78Xf4QdFvfgvGmqOQP1WBBPmyUDKCGIutfVkfPOpLp9M9xPxNVsOjdcXRYb5s1
         zkehq1fXf6jPly/Gs6Nlc5DeLtxYztycXGAVC0JU7P51GG0TeqIbzGTe0XQ6uD6FYC
         150PWDzb9/aNTXb1ih6q2DpJvsAFXRXmfmwA1AhN8Qo4DsLbz9u94RRdC8vTB8Vpqn
         jOK8zuxTazQTNKTS35X7y9NtkVghUceB2r/dPx8hcKmjAudxvZMcNERudJgN5+SWch
         xu7dY04oygbps/WyAtLcQpcq0pJvpeprKJcAxBM0fL2wHU8tpLql1EUmE13LoFSauH
         H6mQRg3KWVYig==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 43B24403EF; Thu,  7 Dec 2023 17:17:08 -0300 (-03)
Date:   Thu, 7 Dec 2023 17:17:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/8] perf annotate: Use global annotation_options
Message-ID: <ZXIoRDWBPEjUpYuP@kernel.org>
References: <20231128175441.721579-1-namhyung@kernel.org>
 <20231128175441.721579-5-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128175441.721579-5-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 28, 2023 at 09:54:37AM -0800, Namhyung Kim escreveu:
> Now it can directly use the global options and no need to pass it as an
> argument.

At this point the build breaks when using GTK2=1 on the make command
line, as done in 'make -C tools/perf build-test', so I had to add the
following patch on top of this 4/8 patch:


diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index a53a4e711899f20d..9c1e2b2b5bc0b730 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -365,7 +365,6 @@ static void hists__find_annotations(struct hists *hists,
 			int ret;
 			int (*annotate)(struct hist_entry *he,
 					struct evsel *evsel,
-					struct annotation_options *options,
 					struct hist_browser_timer *hbt);
 
 			annotate = dlsym(perf_gtk_handle,
@@ -375,7 +374,7 @@ static void hists__find_annotations(struct hists *hists,
 				return;
 			}
 
-			ret = annotate(he, evsel, &annotate_opts, NULL);
+			ret = annotate(he, evsel, NULL);
 			if (!ret || !ann->skip_missing)
 				return;
 
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 2effac77ca8c6742..394861245fd3e48f 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -162,7 +162,6 @@ static int perf_gtk__annotate_symbol(GtkWidget *window, struct map_symbol *ms,
 }
 
 static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
-				struct annotation_options *options,
 				struct hist_browser_timer *hbt)
 {
 	struct dso *dso = map__dso(ms->map);
@@ -176,7 +175,7 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
 	if (dso->annotate_warned)
 		return -1;
 
-	err = symbol__annotate(ms, evsel, options, NULL);
+	err = symbol__annotate(ms, evsel, NULL);
 	if (err) {
 		char msg[BUFSIZ];
 		dso->annotate_warned = true;
@@ -244,10 +243,9 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
 
 int hist_entry__gtk_annotate(struct hist_entry *he,
 			     struct evsel *evsel,
-			     struct annotation_options *options,
 			     struct hist_browser_timer *hbt)
 {
-	return symbol__gtk_annotate(&he->ms, evsel, options, hbt);
+	return symbol__gtk_annotate(&he->ms, evsel, hbt);
 }
 
 void perf_gtk__show_annotations(void)
diff --git a/tools/perf/ui/gtk/gtk.h b/tools/perf/ui/gtk/gtk.h
index 1e84dceb52671385..a2b497f03fd6e478 100644
--- a/tools/perf/ui/gtk/gtk.h
+++ b/tools/perf/ui/gtk/gtk.h
@@ -56,13 +56,11 @@ struct evsel;
 struct evlist;
 struct hist_entry;
 struct hist_browser_timer;
-struct annotation_options;
 
 int evlist__gtk_browse_hists(struct evlist *evlist, const char *help,
 			     struct hist_browser_timer *hbt, float min_pcnt);
 int hist_entry__gtk_annotate(struct hist_entry *he,
 			     struct evsel *evsel,
-			     struct annotation_options *options,
 			     struct hist_browser_timer *hbt);
 void perf_gtk__show_annotations(void);
 
