Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729E57DFEE6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 06:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjKCFln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 01:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKCFll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 01:41:41 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897A818B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 22:41:37 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ymvyqyGqr2IvKymvyq7BJd; Fri, 03 Nov 2023 06:41:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698990094;
        bh=/HR6R2/dBCV5KtAoNDtBGcIdggMj4KflzvoVgbVGe3Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=HrKlVHjxRPVmpNH5/JYmdS7ezpXE5VbSGMHB9kFVsrtdIczKexOlVpcjbntVXskkn
         yH/VptbmPQ7pkeTwiEJ0Z0Y/c4if7NC4lXmSn5zLiXZB5XoyovKjaa7BIrL9BOXGj0
         D8VuWrku7V3IS2lI2ZU4eBaOuNc0FNcFPyktfY9KrVMv7VSE5ZHgUcLXHyf+70lLZ3
         rGvnAFe0p5j7N7stVCohDqe3EOPS9+S1Cx9B7gFRoBQYRucAtQzqMDAL3sn0z18Hii
         u53db/Eyo0FlHiqhXKXn4i8J8TjNqfSyUwQsQGuzFihhAPsYuiaw7SQykwbiaHcPIe
         gqh0soOGbQ8Bg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 03 Nov 2023 06:41:34 +0100
X-ME-IP: 86.243.2.178
Message-ID: <133a66fe-a7e7-42e2-822b-1f3caea7862a@wanadoo.fr>
Date:   Fri, 3 Nov 2023 06:41:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] perf annotate: Move some fields to annotated_source
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20231102222653.4165959-1-namhyung@kernel.org>
 <20231102222653.4165959-5-namhyung@kernel.org>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231102222653.4165959-5-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/11/2023 à 23:26, Namhyung Kim a écrit :
> Some fields in the struct annotation are only used with annotated_source
> so better to be moved there in order to reduce memory consumption for
> other symbols.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   tools/perf/ui/browsers/annotate.c | 12 ++++++------
>   tools/perf/util/annotate.c        | 17 +++++++++--------
>   tools/perf/util/annotate.h        | 14 +++++++-------
>   3 files changed, 22 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index d2470f87344d..1b42db70c998 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -384,7 +384,7 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
>   		if (al->idx_asm < offset)
>   			offset = al->idx;
>   
> -		browser->b.nr_entries = notes->nr_entries;
> +		browser->b.nr_entries = notes->src->nr_entries;
>   		notes->options->hide_src_code = false;
>   		browser->b.seek(&browser->b, -offset, SEEK_CUR);
>   		browser->b.top_idx = al->idx - offset;
> @@ -402,7 +402,7 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
>   		if (al->idx_asm < offset)
>   			offset = al->idx_asm;
>   
> -		browser->b.nr_entries = notes->nr_asm_entries;
> +		browser->b.nr_entries = notes->src->nr_asm_entries;
>   		notes->options->hide_src_code = true;
>   		browser->b.seek(&browser->b, -offset, SEEK_CUR);
>   		browser->b.top_idx = al->idx_asm - offset;
> @@ -435,7 +435,7 @@ static void ui_browser__init_asm_mode(struct ui_browser *browser)
>   {
>   	struct annotation *notes = browser__annotation(browser);
>   	ui_browser__reset_index(browser);
> -	browser->nr_entries = notes->nr_asm_entries;
> +	browser->nr_entries = notes->src->nr_asm_entries;
>   }
>   
>   static int sym_title(struct symbol *sym, struct map *map, char *title,
> @@ -860,7 +860,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
>   					   browser->b.height,
>   					   browser->b.index,
>   					   browser->b.top_idx,
> -					   notes->nr_asm_entries);
> +					   notes->src->nr_asm_entries);
>   		}
>   			continue;
>   		case K_ENTER:
> @@ -991,8 +991,8 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
>   
>   	ui_helpline__push("Press ESC to exit");
>   
> -	browser.b.width = notes->max_line_len;
> -	browser.b.nr_entries = notes->nr_entries;
> +	browser.b.width = notes->src->max_line_len;
> +	browser.b.nr_entries = notes->src->nr_entries;
>   	browser.b.entries = &notes->src->source,
>   	browser.b.width += 18; /* Percentage */
>   
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 92a9adf9d5eb..ee7b8e1848a8 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2808,19 +2808,20 @@ void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
>   void annotation__set_offsets(struct annotation *notes, s64 size)
>   {
>   	struct annotation_line *al;
> +	struct annotated_source *src = notes->src;
>   
> -	notes->max_line_len = 0;
> -	notes->nr_entries = 0;
> -	notes->nr_asm_entries = 0;
> +	src->max_line_len = 0;
> +	src->nr_entries = 0;
> +	src->nr_asm_entries = 0;
>   
> -	list_for_each_entry(al, &notes->src->source, node) {
> +	list_for_each_entry(al, &src->source, node) {
>   		size_t line_len = strlen(al->line);
>   
> -		if (notes->max_line_len < line_len)
> -			notes->max_line_len = line_len;
> -		al->idx = notes->nr_entries++;
> +		if (src->max_line_len < line_len)
> +			src->max_line_len = line_len;
> +		al->idx = src->nr_entries++;
>   		if (al->offset != -1) {
> -			al->idx_asm = notes->nr_asm_entries++;
> +			al->idx_asm = src->nr_asm_entries++;
>   			/*
>   			 * FIXME: short term bandaid to cope with assembly
>   			 * routines that comes with labels in the same column
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index d8a221591926..c51ceb857bd6 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -268,10 +268,13 @@ struct cyc_hist {
>    * returns.
>    */
>   struct annotated_source {
> -	struct list_head   source;
> -	int    		   nr_histograms;
> -	size_t		   sizeof_sym_hist;
> -	struct sym_hist	   *histograms;
> +	struct list_head	source;
> +	int    			nr_histograms;

If this int...

> +	size_t			sizeof_sym_hist;
> +	struct sym_hist		*histograms;
> +	int			nr_entries;
> +	int			nr_asm_entries;
> +	u16			max_line_len;

... and these int and u16 were grouped, you would also save a hole in 
the struct and reduce padding.


On x86_64, after patch 4/5:
struct annotated_source {
	struct list_head           source;               /*     0    16 */
	int                        nr_histograms;        /*    16     4 */

	/* XXX 4 bytes hole, try to pack */			<====

	size_t                     sizeof_sym_hist;      /*    24     8 */
	struct sym_hist *          histograms;           /*    32     8 */
	int                        nr_entries;           /*    40     4 */
	int                        nr_asm_entries;       /*    44     4 */
	u16                        max_line_len;         /*    48     2 */

	/* size: 56, cachelines: 1, members: 7 */
	/* sum members: 46, holes: 1, sum holes: 4 */
	/* padding: 6 */					<====
	/* last cacheline: 56 bytes */
};

After patch 5/5, the struct would be just 64 bytes. If fields are 
re-ordered, it would be 56 bytes.

Because of rounding in memory allocations, 56 or 64 shouldn't change 
anything. But it would be more future proof, should something else be 
added here in the future.

CJ

>   };
>   
>   struct annotated_branch {
> @@ -289,9 +292,6 @@ struct LOCKABLE annotation {
>   	struct annotation_line	**offsets;
>   	int			nr_events;
>   	int			max_jump_sources;
> -	int			nr_entries;
> -	int			nr_asm_entries;
> -	u16			max_line_len;
>   	struct {
>   		u8		addr;
>   		u8		jumps;

