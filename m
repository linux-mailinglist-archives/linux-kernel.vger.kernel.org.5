Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278F57E2D3D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjKFTxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjKFTxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:53:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA15DB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:53:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9640AC433C8;
        Mon,  6 Nov 2023 19:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699300418;
        bh=zRnp3/+P5SOqdbJs98+fKP7mcvAOuH+BcWqDVT5w1I0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VWMuyGbhWb+99XI6CaXOnN+In4t9/oJivSghk3iyYk1O8OggZtdP60+/JWbepNzRs
         ERCCM4JWIL85/4U/Cvn9oCd6M0FlwwwN99HJDNMQOBRVVdf4sNmoSnyqADugQ1lBYm
         FF29ulVbZmiRYweStkCekKaDhMNI9sU1VA0trarFphCHgbaDXt07ihr3iFMwabsiLm
         dRc5Sc1kCBRVXWhjVa+X6U511HGDopFQNDynO7ezCMtejycRRgAC6+YsOjs2MtHrzJ
         3K9P5ZyUkGe6QoOLffbHyYkNcPQz7v+t0zzxzhnRNr1195isktbLgTqeW0h0kNm5RX
         9GE24ob/uqc6g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 175F34035D; Mon,  6 Nov 2023 16:53:35 -0300 (-03)
Date:   Mon, 6 Nov 2023 16:53:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 1/5] perf annotate: Split struct cycles_info
Message-ID: <ZUlEP9pP3JiSxDVc@kernel.org>
References: <20231103191907.54531-1-namhyung@kernel.org>
 <20231103191907.54531-2-namhyung@kernel.org>
 <ZUk/27WMwtnQPggF@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUk/27WMwtnQPggF@kernel.org>
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

Em Mon, Nov 06, 2023 at 04:34:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Nov 03, 2023 at 12:19:03PM -0700, Namhyung Kim escreveu:
> > The cycles info is used only when branch stack is provided.  Split them
> > into a separate struct and lazy allocate them to save some memory.
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/ui/browsers/annotate.c |  2 +-
> >  tools/perf/util/annotate.c        | 34 ++++++++++++++++++-------------
> >  tools/perf/util/annotate.h        | 14 ++++++++-----
> >  3 files changed, 30 insertions(+), 20 deletions(-)
> > 
> > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> > index ccdb2cd11fbf..d2470f87344d 100644
> > --- a/tools/perf/ui/browsers/annotate.c
> > +++ b/tools/perf/ui/browsers/annotate.c
> > @@ -337,7 +337,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
> >  				max_percent = percent;
> >  		}
> >  
> > -		if (max_percent < 0.01 && pos->al.ipc == 0) {
> > +		if (max_percent < 0.01 && (!pos->al.cycles || pos->al.cycles->ipc == 0)) {
> >  			RB_CLEAR_NODE(&pos->al.rb_node);
> >  			continue;
> >  		}
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 82956adf9963..3e7f75827270 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -1100,8 +1100,8 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
> >  		for (offset = start; offset <= end; offset++) {
> >  			struct annotation_line *al = notes->offsets[offset];
> >  
> > -			if (al && al->ipc == 0.0) {
> > -				al->ipc = ipc;
> > +			if (al && al->cycles && al->cycles->ipc == 0.0) {
> > +				al->cycles->ipc = ipc;
> >  				cover_insn++;
> >  			}
> >  		}
> > @@ -1134,13 +1134,18 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
> >  		if (ch && ch->cycles) {
> >  			struct annotation_line *al;
> >  
> > +			al = notes->offsets[offset];
> > +			if (al && al->cycles == NULL) {
> > +				al->cycles = zalloc(sizeof(*al->cycles));
> > +				if (al->cycles == NULL)
> 
> Shouldn't we stop here and tell the user that his system is really tight
> on memory instead of just ignoring it?
> 
> 	if (al->cycles == NULL) {
> 		ui__error("Not enough memory for allocating branch stack cycles info!\n");
> 		return ... its a void function :-\
> 	}
> 
> Since its a void function, can't we detect that we need al->cycles
> allocated at the tool start and allocate it there, then propagate back
> the error?
> 
> Its per line, so doing it lazily is indeed easier, so make that function
> return an error and bail out when not being able to calculate the ipc
> for the remaining lines?

I.e. with this folded into this patch, all but one of the callers of
symbol__annotate2() already call a ui error messagem for instance:

                err = symbol__annotate2(ms, evsel, opts, &browser.arch);
                if (err) {
                        char msg[BUFSIZ];
                        dso->annotate_warned = true;
                        symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
                        ui__error("Couldn't annotate %s:\n%s", sym->name, msg);

- Arnaldo

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3e7f758272703554..99ff3bb9cad8daa6 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1114,12 +1114,13 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
 	}
 }
 
-void annotation__compute_ipc(struct annotation *notes, size_t size)
+static int annotation__compute_ipc(struct annotation *notes, size_t size)
 {
+	int err = 0;
 	s64 offset;
 
 	if (!notes->src || !notes->src->cycles_hist)
-		return;
+		return 0;
 
 	notes->total_insn = annotation__count_insn(notes, 0, size - 1);
 	notes->hit_cycles = 0;
@@ -1137,8 +1138,10 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
 			al = notes->offsets[offset];
 			if (al && al->cycles == NULL) {
 				al->cycles = zalloc(sizeof(*al->cycles));
-				if (al->cycles == NULL)
-					continue;
+				if (al->cycles == NULL) {
+					err = ENOMEM;
+					break;
+				}
 			}
 			if (ch->have_start)
 				annotation__count_and_fill(notes, ch->start, offset, ch);
@@ -1150,7 +1153,21 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
 			notes->have_cycles = true;
 		}
 	}
+
+	if (err) {
+		while (++offset < (s64)size) {
+			struct cyc_hist *ch = &notes->src->cycles_hist[offset];
+
+			if (ch && ch->cycles) {
+				struct annotation_line *al = notes->offsets[offset];
+				if (al)
+					zfree(&al->cycles);
+			}
+		}
+	}
+
 	annotation__unlock(notes);
+	return 0;
 }
 
 int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
@@ -3270,7 +3287,11 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 
 	annotation__set_offsets(notes, size);
 	annotation__mark_jump_targets(notes, sym);
-	annotation__compute_ipc(notes, size);
+
+	err = annotation__compute_ipc(notes, size);
+	if (err)
+		goto out_free_offsets;
+
 	annotation__init_column_widths(notes, sym);
 	notes->nr_events = nr_pcnt;
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 16d27952fd5c1b47..19bc2f03917575a8 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -329,7 +329,6 @@ static inline bool annotation_line__filter(struct annotation_line *al, struct an
 }
 
 void annotation__set_offsets(struct annotation *notes, s64 size);
-void annotation__compute_ipc(struct annotation *notes, size_t size);
 void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym);
 void annotation__update_column_widths(struct annotation *notes);
 void annotation__init_column_widths(struct annotation *notes, struct symbol *sym);
