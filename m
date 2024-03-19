Return-Path: <linux-kernel+bounces-107614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB0C87FF24
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC2C1C222AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAB88175E;
	Tue, 19 Mar 2024 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ch5Zsya+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7783581723;
	Tue, 19 Mar 2024 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710856613; cv=none; b=cjUex/c91y10p92mw1uj6Ln5lf1VeAoRD6dwY9OHKXYIDN3lwltGH3VBHZaOCcVzxaWvRyezQkHMeYJJlFOCfab6CMNCl6fOa+9oAecReSqACS2/wk4LkBzCBuu1dtkvfrY10Vob+21SikDAieWSsuQt5U8z/V+6rUxx9Breszg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710856613; c=relaxed/simple;
	bh=zQhmes04v8tUm/xzjy2k9kNoN/vXxtT9NCn33lWyVYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efEgXmSbbaUDgL2GacrHYPad28rRJJQKcpxtctd8S8lqVZcXnLP5XeIGjqUczGX/sNFt3K4KU6GMRCOtlm0wx4/5ZjtxF2t0UguzOOlmbNPQzLB2pHNoEAahpZ3p6WzpmKPi6luWTho07g6PwHrSq8NCGgnug07UKSPUz2k6DLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ch5Zsya+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F76C433F1;
	Tue, 19 Mar 2024 13:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710856613;
	bh=zQhmes04v8tUm/xzjy2k9kNoN/vXxtT9NCn33lWyVYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ch5Zsya+u7bOY7LV/CR2lCTEtD3jHIGBzI+4G6E2fzBgRLgMka+uTcbHhWT1XTwvo
	 Pulu43JG/akiPWtxY+NbLGfwTvYjQEQ1Q+dr6EBODtRim1jVjoWc/5B6d9YW36S/9f
	 9wrnweSIT77Kr/VFOQomB8pBk9HI3f/z0ZCA9+0er9X790sDjXsnE2jggGjsJ3Dwac
	 VybIcIeBGxbkFS89yQWRYgdDDR9Nm5Afn62xChfhRMmkK4/iBGwpJMmBRitaDC8G51
	 Ndm2ZiAvOftrIxbpn4fMndc3Ez7rGzUfu72Vi4E8mHkpZA/VavWdB6S4FdSpBDuvMP
	 S2zx6+wZoi52A==
Date: Tue, 19 Mar 2024 10:56:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH 04/23] perf dwarf-aux: Add die_find_func_rettype()
Message-ID: <ZfmZobDmVFxEQ6hU@x1>
References: <20240319055115.4063940-1-namhyung@kernel.org>
 <20240319055115.4063940-5-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319055115.4063940-5-namhyung@kernel.org>

On Mon, Mar 18, 2024 at 10:50:56PM -0700, Namhyung Kim wrote:
> The die_find_func_rettype() is to find a debug entry for the given
> function name and sets the type information of the return value.  By
> convention, it'd return the pointer to the type die (should be the
> same as the given mem_die argument) if found, or NULL otherwise.
> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/dwarf-aux.c | 43 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/dwarf-aux.h |  4 ++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index cd9364d296b6..9080119a258c 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -696,6 +696,49 @@ Dwarf_Die *die_find_inlinefunc(Dwarf_Die *sp_die, Dwarf_Addr addr,
>  	return die_mem;
>  }
>  
> +static int __die_find_func_rettype_cb(Dwarf_Die *die_mem, void *data)
> +{
> +	const char *func_name;
> +
> +	if (dwarf_tag(die_mem) != DW_TAG_subprogram)
> +		return DIE_FIND_CB_SIBLING;
> +
> +	func_name = dwarf_diename(die_mem);
> +	if (func_name && !strcmp(func_name, data))
> +		return DIE_FIND_CB_END;
> +
> +	return DIE_FIND_CB_SIBLING;
> +}
> +
> +/**
> + * die_find_func_rettype - Search a return type of function
> + * @cu_die: a CU DIE
> + * @name: target function name
> + * @die_mem: a buffer for result DIE
> + *
> + * Search a non-inlined function which matches to @name and stores the
> + * return type of the function to @die_mem and returns it if found.
> + * Returns NULL if failed.  Note that it doesn't needs to find a
> + * definition of the function, so it doesn't match with address.
> + * Most likely, it can find a declaration at the top level.  Thus the
> + * callback function continues to sibling entries only.
> + */
> +Dwarf_Die *die_find_func_rettype(Dwarf_Die *cu_die, const char *name,
> +				 Dwarf_Die *die_mem)
> +{
> +	Dwarf_Die tmp_die;
> +
> +	cu_die = die_find_child(cu_die, __die_find_func_rettype_cb,
> +				(void *)name, &tmp_die);
> +	if (!cu_die)
> +		return NULL;
> +
> +	if (die_get_real_type(&tmp_die, die_mem) == NULL)
> +		return NULL;


Here you check die_get_real_type() return, may I go and do the same for
the previous patch to address my review comment?

- Arnaldo

> +
> +	return die_mem;
> +}
> +
>  struct __instance_walk_param {
>  	void    *addr;
>  	int	(*callback)(Dwarf_Die *, void *);
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index 16c916311bc0..b0f25fbf9668 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -94,6 +94,10 @@ Dwarf_Die *die_find_top_inlinefunc(Dwarf_Die *sp_die, Dwarf_Addr addr,
>  Dwarf_Die *die_find_inlinefunc(Dwarf_Die *sp_die, Dwarf_Addr addr,
>  			       Dwarf_Die *die_mem);
>  
> +/* Search a non-inlined function by name and returns its return type */
> +Dwarf_Die *die_find_func_rettype(Dwarf_Die *sp_die, const char *name,
> +				 Dwarf_Die *die_mem);
> +
>  /* Walk on the instances of given DIE */
>  int die_walk_instances(Dwarf_Die *in_die,
>  		       int (*callback)(Dwarf_Die *, void *), void *data);
> -- 
> 2.44.0.291.gc1ea87d7ee-goog

