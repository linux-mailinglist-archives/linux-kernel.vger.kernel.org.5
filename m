Return-Path: <linux-kernel+bounces-10453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6743681D492
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225812837BA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBDCDF49;
	Sat, 23 Dec 2023 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8mgeZ5D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39B1DDB3;
	Sat, 23 Dec 2023 14:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B93C433C7;
	Sat, 23 Dec 2023 14:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703341787;
	bh=DbsDC/W/kofPp9X/IeVozQ/JB6ecrQRtPmYHSZ05PAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C8mgeZ5DTuEot8BxbXcHyxxyk9wfoftyDDd1+PqExMQQaxOrCk7hQKwWsdrIaxVi5
	 Xct76Pk2Fmjq/I8eElZoT95CS//s7eH8/bxwBM/09SUGGNJDeRFM0HaeZiiujgwwCr
	 d8LnIKTzGIKtTZf/otVio+bLbUNt0z0BPVgWCDoQ7u7CvizEr2uzVLcXzPTok5Rzui
	 CZw5S7gee0JZ5dY8ldUxWTxiAUIV6X/CkWRnLknlFtHefHqQsrgKd3KA/ROQ1fWW6U
	 pjNbWjIB8R4O8l4f+OyjtW5yUXpd6NOth1J+M5QrlJ+5XTQuMPFMoDJ82LOEyF8Gw8
	 EusnVRYYDWipw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id C3B3E403EF; Sat, 23 Dec 2023 11:29:43 -0300 (-03)
Date: Sat, 23 Dec 2023 11:29:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andi Kleen <ak@linux.intel.com>, linux-trace-devel@vger.kernel.org,
	linux-toolchains@vger.kernel.org
Subject: Re: [PATCH 23/52] perf report: Add 'symoff' sort key
Message-ID: <ZYbu1xf1G3VTfo8s@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
 <20231110000012.3538610-24-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110000012.3538610-24-namhyung@kernel.org>
X-Url: http://acmel.wordpress.com

Em Thu, Nov 09, 2023 at 03:59:42PM -0800, Namhyung Kim escreveu:
> The symoff sort key is to print symbol and offset of sample.  This is
> useful for data type profiling to show exact instruction in the function
> which refers the data.

Cool, perhaps we can add a "symoffexcerpt" that would print a few lines
of assembly/source before and after that offset so that we save having
to go from there to the annotate view, or even jump to the annotate view
when pressing 'A' (annotate) on top of that line in the TUI.

- Arnaldo
 
>   $ perf report -s type,sym,typeoff,symoff --hierarchy
>   ...
>   #       Overhead  Data Type / Symbol / Data Type Offset / Symbol Offset
>   # ..............  .....................................................
>   #
>       1.23%         struct cfs_rq
>         0.84%         update_blocked_averages
>           0.19%         struct cfs_rq +336 (leaf_cfs_rq_list.next)
>              0.19%         [k] update_blocked_averages+0x96
>           0.19%         struct cfs_rq +0 (load.weight)
>              0.14%         [k] update_blocked_averages+0x104
>              0.04%         [k] update_blocked_averages+0x31c
>           0.17%         struct cfs_rq +404 (throttle_count)
>              0.12%         [k] update_blocked_averages+0x9d
>              0.05%         [k] update_blocked_averages+0x1f9
>           0.08%         struct cfs_rq +272 (propagate)
>              0.07%         [k] update_blocked_averages+0x3d3
>              0.02%         [k] update_blocked_averages+0x45b
>   ...
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-report.txt |  1 +
>  tools/perf/util/hist.h                   |  1 +
>  tools/perf/util/sort.c                   | 47 ++++++++++++++++++++++++
>  tools/perf/util/sort.h                   |  1 +
>  4 files changed, 50 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index b57eb51b47aa..38f59ac064f7 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -120,6 +120,7 @@ OPTIONS
>  	- simd: Flags describing a SIMD operation. "e" for empty Arm SVE predicate. "p" for partial Arm SVE predicate
>  	- type: Data type of sample memory access.
>  	- typeoff: Offset in the data type of sample memory access.
> +	- symoff: Offset in the symbol.
>  
>  	By default, comm, dso and symbol keys are used.
>  	(i.e. --sort comm,dso,symbol)
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 941176afcebc..1ce0ee262abe 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -84,6 +84,7 @@ enum hist_column {
>  	HISTC_SIMD,
>  	HISTC_TYPE,
>  	HISTC_TYPE_OFFSET,
> +	HISTC_SYMBOL_OFFSET,
>  	HISTC_NR_COLS, /* Last entry */
>  };
>  
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index d78e680d3988..0cbbd5ba8175 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -419,6 +419,52 @@ struct sort_entry sort_sym = {
>  	.se_width_idx	= HISTC_SYMBOL,
>  };
>  
> +/* --sort symoff */
> +
> +static int64_t
> +sort__symoff_cmp(struct hist_entry *left, struct hist_entry *right)
> +{
> +	int64_t ret;
> +
> +	ret = sort__sym_cmp(left, right);
> +	if (ret)
> +		return ret;
> +
> +	return left->ip - right->ip;
> +}
> +
> +static int64_t
> +sort__symoff_sort(struct hist_entry *left, struct hist_entry *right)
> +{
> +	int64_t ret;
> +
> +	ret = sort__sym_sort(left, right);
> +	if (ret)
> +		return ret;
> +
> +	return left->ip - right->ip;
> +}
> +
> +static int
> +hist_entry__symoff_snprintf(struct hist_entry *he, char *bf, size_t size, unsigned int width)
> +{
> +	struct symbol *sym = he->ms.sym;
> +
> +	if (sym == NULL)
> +		return repsep_snprintf(bf, size, "[%c] %-#.*llx", he->level, width - 4, he->ip);
> +
> +	return repsep_snprintf(bf, size, "[%c] %s+0x%llx", he->level, sym->name, he->ip - sym->start);
> +}
> +
> +struct sort_entry sort_sym_offset = {
> +	.se_header	= "Symbol Offset",
> +	.se_cmp		= sort__symoff_cmp,
> +	.se_sort	= sort__symoff_sort,
> +	.se_snprintf	= hist_entry__symoff_snprintf,
> +	.se_filter	= hist_entry__sym_filter,
> +	.se_width_idx	= HISTC_SYMBOL_OFFSET,
> +};
> +
>  /* --sort srcline */
>  
>  char *hist_entry__srcline(struct hist_entry *he)
> @@ -2335,6 +2381,7 @@ static struct sort_dimension common_sort_dimensions[] = {
>  	DIM(SORT_SIMD, "simd", sort_simd),
>  	DIM(SORT_ANNOTATE_DATA_TYPE, "type", sort_type),
>  	DIM(SORT_ANNOTATE_DATA_TYPE_OFFSET, "typeoff", sort_type_offset),
> +	DIM(SORT_SYM_OFFSET, "symoff", sort_sym_offset),
>  };
>  
>  #undef DIM
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index d806adcc1e1e..6f6b4189a389 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -249,6 +249,7 @@ enum sort_type {
>  	SORT_SIMD,
>  	SORT_ANNOTATE_DATA_TYPE,
>  	SORT_ANNOTATE_DATA_TYPE_OFFSET,
> +	SORT_SYM_OFFSET,
>  
>  	/* branch stack specific sort keys */
>  	__SORT_BRANCH_STACK,
> -- 
> 2.42.0.869.gea05f2083d-goog
> 

-- 

- Arnaldo

