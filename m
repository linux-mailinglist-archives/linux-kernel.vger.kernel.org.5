Return-Path: <linux-kernel+bounces-107606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07D287FF07
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F101F22785
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86738061C;
	Tue, 19 Mar 2024 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvA5Y+dQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6048060A;
	Tue, 19 Mar 2024 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710855944; cv=none; b=dD6uv4WmrbIUR/98mKp69jH6Dlb98CDzKkvqOr5E+z6BQrjMflB9TXJq1KESqHSvJmrD/lEcTPYRofj7CR5iLCMJwYfRCw3SHjmYXyC2EqZwEq8Lh0lapyxJ8WR6S0ebLIRli3887kLhToOYiz8xvbosutanys4tMPy8P/BEeY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710855944; c=relaxed/simple;
	bh=zkpPzHkw72QXh0PXml5o0fAbrp7+GSEBgMu/g08LkEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZII0Gx54+Unn7aacE5d2oVklGyuZkmS7NRHt8Utw30+8DZQBvz8hRiumJrR/M54SeKKTWtlIQsNwqadifcNH9ykrHamVKduC5OY4xfGafjizBScizxzD2FiTAdc/nc6lfJAZ32KPfIm5XCwkXK/o4KmLJuDUlRC5TeUOTxyFYRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvA5Y+dQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED34EC433C7;
	Tue, 19 Mar 2024 13:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710855943;
	bh=zkpPzHkw72QXh0PXml5o0fAbrp7+GSEBgMu/g08LkEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvA5Y+dQZv6M6dBJNAN9I+EPj7iONJVKrxd2ODJOx8z1vXg+v9umxAKyczOR9dBgR
	 Q7737GVcT0bppE7yuAxsk015bJ29hUeZJIEiOMV1OkmY5rMp8yWwCsrORqbT/subLZ
	 CmSwIBNNBAuDh24siRwcmIwVUPaDDt1WXvEHXyma49bczRYsJMzalKHb+2KzYN54cn
	 I9uPlzA9pa1XC8sVh1fACYVSZkcAreYAdgnu3yqmmn8EiQsKrnbd5RlM+BSms52m/N
	 DMB6/63kwKWWZ9OgQwpWR0ZIxZjyOjJNnnhYC3/IfND29h3p2q3C/5NttFw1KQLCOQ
	 8lHbgoSSRW6/g==
Date: Tue, 19 Mar 2024 10:45:40 -0300
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
Subject: Re: [PATCH 02/23] perf dwarf-aux: Add die_collect_vars()
Message-ID: <ZfmXBDB-hN4FCA4i@x1>
References: <20240319055115.4063940-1-namhyung@kernel.org>
 <20240319055115.4063940-3-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319055115.4063940-3-namhyung@kernel.org>

On Mon, Mar 18, 2024 at 10:50:54PM -0700, Namhyung Kim wrote:
> The die_collect_vars() is to find all variable information in the scope
> including function parameters.  The struct die_var_type is to save the
> type of the variable with the location (reg and offset) as well as where
> it's defined in the code (addr).
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/dwarf-aux.c | 118 +++++++++++++++++++++++++++---------
>  tools/perf/util/dwarf-aux.h |  17 ++++++
>  2 files changed, 107 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index e84d0d6a7750..785aa7a3d725 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1136,6 +1136,40 @@ int die_get_varname(Dwarf_Die *vr_die, struct strbuf *buf)
>  	return ret < 0 ? ret : strbuf_addf(buf, "\t%s", dwarf_diename(vr_die));
>  }
>  
> +#if defined(HAVE_DWARF_GETLOCATIONS_SUPPORT) || defined(HAVE_DWARF_CFI_SUPPORT)
> +static int reg_from_dwarf_op(Dwarf_Op *op)
> +{
> +	switch (op->atom) {
> +	case DW_OP_reg0 ... DW_OP_reg31:
> +		return op->atom - DW_OP_reg0;
> +	case DW_OP_breg0 ... DW_OP_breg31:
> +		return op->atom - DW_OP_breg0;
> +	case DW_OP_regx:
> +	case DW_OP_bregx:
> +		return op->number;
> +	default:
> +		break;
> +	}
> +	return -1;
> +}
> +
> +static int offset_from_dwarf_op(Dwarf_Op *op)
> +{
> +	switch (op->atom) {
> +	case DW_OP_reg0 ... DW_OP_reg31:
> +	case DW_OP_regx:
> +		return 0;
> +	case DW_OP_breg0 ... DW_OP_breg31:
> +		return op->number;
> +	case DW_OP_bregx:
> +		return op->number2;
> +	default:
> +		break;
> +	}
> +	return -1;
> +}
> +#endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT || HAVE_DWARF_CFI_SUPPORT */
> +
>  #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
>  /**
>   * die_get_var_innermost_scope - Get innermost scope range of given variable DIE
> @@ -1476,41 +1510,69 @@ Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr addr,
>  		*offset = data.offset;
>  	return result;
>  }
> -#endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
>  
> -#ifdef HAVE_DWARF_CFI_SUPPORT
> -static int reg_from_dwarf_op(Dwarf_Op *op)
> +static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
>  {
> -	switch (op->atom) {
> -	case DW_OP_reg0 ... DW_OP_reg31:
> -		return op->atom - DW_OP_reg0;
> -	case DW_OP_breg0 ... DW_OP_breg31:
> -		return op->atom - DW_OP_breg0;
> -	case DW_OP_regx:
> -	case DW_OP_bregx:
> -		return op->number;
> -	default:
> -		break;
> -	}
> -	return -1;
> +	struct die_var_type **var_types = arg;
> +	Dwarf_Die type_die;
> +	int tag = dwarf_tag(die_mem);
> +	Dwarf_Attribute attr;
> +	Dwarf_Addr base, start, end;
> +	Dwarf_Op *ops;
> +	size_t nops;
> +	struct die_var_type *vt;
> +
> +	if (tag != DW_TAG_variable && tag != DW_TAG_formal_parameter)
> +		return DIE_FIND_CB_SIBLING;
> +
> +	if (dwarf_attr(die_mem, DW_AT_location, &attr) == NULL)
> +		return DIE_FIND_CB_SIBLING;
> +
> +	/*
> +	 * Only collect the first location as it can reconstruct the
> +	 * remaining state by following the instructions.
> +	 * start = 0 means it covers the whole range.
> +	 */
> +	if (dwarf_getlocations(&attr, 0, &base, &start, &end, &ops, &nops) <= 0)
> +		return DIE_FIND_CB_SIBLING;
> +
> +	if (die_get_real_type(die_mem, &type_die) == NULL)
> +		return DIE_FIND_CB_SIBLING;
> +
> +	vt = malloc(sizeof(*vt));
> +	if (vt == NULL)
> +		return DIE_FIND_CB_END;
> +
> +	vt->die_off = dwarf_dieoffset(&type_die);
> +	vt->addr = start;
> +	vt->reg = reg_from_dwarf_op(ops);
> +	vt->offset = offset_from_dwarf_op(ops);
> +	vt->next = *var_types;
> +	*var_types = vt;
> +
> +	return DIE_FIND_CB_SIBLING;
>  }
>  
> -static int offset_from_dwarf_op(Dwarf_Op *op)
> +/**
> + * die_collect_vars - Save all variables and parameters
> + * @sc_die: a scope DIE
> + * @var_types: a pointer to save the resulting list
> + *
> + * Save all variables and parameters in the @sc_die and save them to @var_types.
> + * The @var_types is a singly-linked list containing type and location info.
> + * Actual type can be retrieved using dwarf_offdie() with 'die_off' later.
> + *
> + * Callers should free @var_types.
> + */
> +void die_collect_vars(Dwarf_Die *sc_die, struct die_var_type **var_types)
>  {
> -	switch (op->atom) {
> -	case DW_OP_reg0 ... DW_OP_reg31:
> -	case DW_OP_regx:
> -		return 0;
> -	case DW_OP_breg0 ... DW_OP_breg31:
> -		return op->number;
> -	case DW_OP_bregx:
> -		return op->number2;
> -	default:
> -		break;
> -	}
> -	return -1;
> +	Dwarf_Die die_mem;
> +
> +	die_find_child(sc_die, __die_collect_vars_cb, (void *)var_types, &die_mem);
>  }
> +#endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
>  
> +#ifdef HAVE_DWARF_CFI_SUPPORT
>  /**
>   * die_get_cfa - Get frame base information
>   * @dwarf: a Dwarf info
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index 9973801a20c1..cd171b06fd4c 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -135,6 +135,15 @@ void die_skip_prologue(Dwarf_Die *sp_die, Dwarf_Die *cu_die,
>  /* Get the list of including scopes */
>  int die_get_scopes(Dwarf_Die *cu_die, Dwarf_Addr pc, Dwarf_Die **scopes);
>  
> +/* Variable type information */
> +struct die_var_type {
> +	struct die_var_type *next;
> +	u64 die_off;
> +	u64 addr;
> +	int reg;
> +	int offset;
> +};
> +
>  #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
>  
>  /* Get byte offset range of given variable DIE */
> @@ -149,6 +158,9 @@ Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
>  Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr addr,
>  				     Dwarf_Die *die_mem, int *offset);
>  
> +/* Save all variables and parameters in this scope */
> +void die_collect_vars(Dwarf_Die *sc_die, struct die_var_type **var_types);
> +
>  #else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
>  
>  static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
> @@ -176,6 +188,11 @@ static inline Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die __maybe_unu
>  	return NULL;
>  }
>  
> +static inline void die_collect_vars(Dwarf_Die *sc_die __maybe_unused,
> +				    struct die_var_type **var_types __maybe_unused)
> +{
> +}
> +
>  #endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
>  
>  #ifdef HAVE_DWARF_CFI_SUPPORT
> -- 
> 2.44.0.291.gc1ea87d7ee-goog

