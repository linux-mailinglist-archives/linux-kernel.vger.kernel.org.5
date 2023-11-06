Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A967A7E2CF0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjKFTfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjKFTe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:34:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6FF1BC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:34:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87623C433CA;
        Mon,  6 Nov 2023 19:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699299294;
        bh=muQm112T23le5C+Uxd9oMAYYs0iqRDU3+iNJkbAH0Xc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MFFiIGrnIRu/mrJa2bbMu5CYQ9MgJ6xt7+laLHpJ4f6F5TUNtTNPITvd+ffNqF0cs
         AGJTeRWL5iFK2SMj0PyZ3UEwtBC38lcAqcRGgPgO7KwSEboY5cxd3eS4R8yU8W6RN6
         j9u0hQHsGDnc94OGZDcGs8TRVxJ2wAeFxr7DtPImbmB7GpQbxyKw0xuUig/OOgxhvJ
         dmZnaVK7oEvZ+MMx7Uh+Qkng53VTxLGXl9bbC5lK1SmTBnSONYK4Iw/cARMhicXTEf
         XR4+ZNVEc+dMJ510oa7muZhoHqUSqewCoa2xR1ySTBUKzJkuJ1NH1Z5gw3L5Go2xeI
         N9iRmK95jDj4A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B40E74035D; Mon,  6 Nov 2023 16:34:51 -0300 (-03)
Date:   Mon, 6 Nov 2023 16:34:51 -0300
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
Message-ID: <ZUk/27WMwtnQPggF@kernel.org>
References: <20231103191907.54531-1-namhyung@kernel.org>
 <20231103191907.54531-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103191907.54531-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 03, 2023 at 12:19:03PM -0700, Namhyung Kim escreveu:
> The cycles info is used only when branch stack is provided.  Split them
> into a separate struct and lazy allocate them to save some memory.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/browsers/annotate.c |  2 +-
>  tools/perf/util/annotate.c        | 34 ++++++++++++++++++-------------
>  tools/perf/util/annotate.h        | 14 ++++++++-----
>  3 files changed, 30 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index ccdb2cd11fbf..d2470f87344d 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -337,7 +337,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
>  				max_percent = percent;
>  		}
>  
> -		if (max_percent < 0.01 && pos->al.ipc == 0) {
> +		if (max_percent < 0.01 && (!pos->al.cycles || pos->al.cycles->ipc == 0)) {
>  			RB_CLEAR_NODE(&pos->al.rb_node);
>  			continue;
>  		}
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 82956adf9963..3e7f75827270 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1100,8 +1100,8 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
>  		for (offset = start; offset <= end; offset++) {
>  			struct annotation_line *al = notes->offsets[offset];
>  
> -			if (al && al->ipc == 0.0) {
> -				al->ipc = ipc;
> +			if (al && al->cycles && al->cycles->ipc == 0.0) {
> +				al->cycles->ipc = ipc;
>  				cover_insn++;
>  			}
>  		}
> @@ -1134,13 +1134,18 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
>  		if (ch && ch->cycles) {
>  			struct annotation_line *al;
>  
> +			al = notes->offsets[offset];
> +			if (al && al->cycles == NULL) {
> +				al->cycles = zalloc(sizeof(*al->cycles));
> +				if (al->cycles == NULL)

Shouldn't we stop here and tell the user that his system is really tight
on memory instead of just ignoring it?

	if (al->cycles == NULL) {
		ui__error("Not enough memory for allocating branch stack cycles info!\n");
		return ... its a void function :-\
	}

Since its a void function, can't we detect that we need al->cycles
allocated at the tool start and allocate it there, then propagate back
the error?

Its per line, so doing it lazily is indeed easier, so make that function
return an error and bail out when not being able to calculate the ipc
for the remaining lines?

- Arnaldo

> +					continue;
> +			}
>  			if (ch->have_start)
>  				annotation__count_and_fill(notes, ch->start, offset, ch);
> -			al = notes->offsets[offset];
>  			if (al && ch->num_aggr) {
> -				al->cycles = ch->cycles_aggr / ch->num_aggr;
> -				al->cycles_max = ch->cycles_max;
> -				al->cycles_min = ch->cycles_min;
> +				al->cycles->avg = ch->cycles_aggr / ch->num_aggr;
> +				al->cycles->max = ch->cycles_max;
> +				al->cycles->min = ch->cycles_min;
>  			}
>  			notes->have_cycles = true;
>  		}
> @@ -1225,6 +1230,7 @@ static void annotation_line__exit(struct annotation_line *al)
>  {
>  	zfree_srcline(&al->path);
>  	zfree(&al->line);
> +	zfree(&al->cycles);
>  }
>  
>  static size_t disasm_line_size(int nr)
> @@ -3083,8 +3089,8 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
>  	int printed;
>  
>  	if (first_line && (al->offset == -1 || percent_max == 0.0)) {
> -		if (notes->have_cycles) {
> -			if (al->ipc == 0.0 && al->cycles == 0)
> +		if (notes->have_cycles && al->cycles) {
> +			if (al->cycles->ipc == 0.0 && al->cycles->avg == 0)
>  				show_title = true;
>  		} else
>  			show_title = true;
> @@ -3121,17 +3127,17 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
>  	}
>  
>  	if (notes->have_cycles) {
> -		if (al->ipc)
> -			obj__printf(obj, "%*.2f ", ANNOTATION__IPC_WIDTH - 1, al->ipc);
> +		if (al->cycles && al->cycles->ipc)
> +			obj__printf(obj, "%*.2f ", ANNOTATION__IPC_WIDTH - 1, al->cycles->ipc);
>  		else if (!show_title)
>  			obj__printf(obj, "%*s", ANNOTATION__IPC_WIDTH, " ");
>  		else
>  			obj__printf(obj, "%*s ", ANNOTATION__IPC_WIDTH - 1, "IPC");
>  
>  		if (!notes->options->show_minmax_cycle) {
> -			if (al->cycles)
> +			if (al->cycles && al->cycles->avg)
>  				obj__printf(obj, "%*" PRIu64 " ",
> -					   ANNOTATION__CYCLES_WIDTH - 1, al->cycles);
> +					   ANNOTATION__CYCLES_WIDTH - 1, al->cycles->avg);
>  			else if (!show_title)
>  				obj__printf(obj, "%*s",
>  					    ANNOTATION__CYCLES_WIDTH, " ");
> @@ -3145,8 +3151,8 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
>  
>  				scnprintf(str, sizeof(str),
>  					"%" PRIu64 "(%" PRIu64 "/%" PRIu64 ")",
> -					al->cycles, al->cycles_min,
> -					al->cycles_max);
> +					al->cycles->avg, al->cycles->min,
> +					al->cycles->max);
>  
>  				obj__printf(obj, "%*s ",
>  					    ANNOTATION__MINMAX_CYCLES_WIDTH - 1,
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 962780559176..16d27952fd5c 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -130,6 +130,13 @@ struct annotation_data {
>  	struct sym_hist_entry	 he;
>  };
>  
> +struct cycles_info {
> +	float			 ipc;
> +	u64			 avg;
> +	u64			 max;
> +	u64			 min;
> +};
> +
>  struct annotation_line {
>  	struct list_head	 node;
>  	struct rb_node		 rb_node;
> @@ -137,12 +144,9 @@ struct annotation_line {
>  	char			*line;
>  	int			 line_nr;
>  	char			*fileloc;
> -	int			 jump_sources;
> -	float			 ipc;
> -	u64			 cycles;
> -	u64			 cycles_max;
> -	u64			 cycles_min;
>  	char			*path;
> +	struct cycles_info	*cycles;
> +	int			 jump_sources;
>  	u32			 idx;
>  	int			 idx_asm;
>  	int			 data_nr;
> -- 
> 2.42.0.869.gea05f2083d-goog
> 

-- 

- Arnaldo
