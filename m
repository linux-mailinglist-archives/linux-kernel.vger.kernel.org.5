Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB437E548A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344307AbjKHKxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344565AbjKHKwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:52:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7912126;
        Wed,  8 Nov 2023 02:52:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76F0C433C7;
        Wed,  8 Nov 2023 10:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699440730;
        bh=t69XfdiHhJahtVbVhsn1LHGQM/HRauoe8VYClKKVkqI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F/R7fBAZhpriEEiaQnueNxy3EqSxEY6to0uIwAImHY5kP8o8dWaAiZaqq1zsOwMsq
         Gg6JYYGK79+ZCTDiFChbbgYlQMIGAhnZFip2wFOPNuf0CrhIAmAt6NPX3GRz0mjOtL
         EktXEtAkYvF5S/qunlrvb07PUiYcYtr6Jm1S8AqRxBSZNByN1zjp9YIZBN/brk4oAw
         s+HVokS5Gl215Ydg6yGrgFAi37RmpFzrCFutfYXi2d7mb6Aajgd6gJ5WgqQmsRU4v3
         V2Rx5GAJA1QZjqxPX+F/5fsI3wCa2o08nWH1mhdm7CzHXvpdmIW/uCUUG/7CDsL7gX
         P9LAp5kYGeOOg==
Date:   Wed, 8 Nov 2023 19:52:04 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH 34/48] perf dwarf-aux: Add die_collect_vars()
Message-Id: <20231108195204.a3ddfe5965e9c33661460ff4@kernel.org>
In-Reply-To: <20231012035111.676789-35-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
        <20231012035111.676789-35-namhyung@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 20:50:57 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> The die_collect_vars() is to find all variable information in the scope
> including function parameters.  The struct die_var_type is to save the
> type of the variable with the location (reg and offset) as well as where
> it's defined in the code (addr).
> 

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

BTW, I did similar thing in collect_variables_cb()@probe-finder.c, maybe
this can simplify that too.

Thank you,

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/dwarf-aux.c | 60 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/dwarf-aux.h | 17 +++++++++++
>  2 files changed, 77 insertions(+)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 093d7e82b333..16e63d8caf83 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1545,6 +1545,66 @@ int die_get_cfa(Dwarf *dwarf, u64 pc, int *preg, int *poffset)
>  	return -1;
>  }
>  
> +static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
> +{
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
> +}
> +
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
> +{
> +	Dwarf_Die die_mem;
> +
> +	die_find_child(sc_die, __die_collect_vars_cb, (void *)var_types, &die_mem);
> +}
> +
>  #endif
>  
>  /*
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index dc7e98678216..d0ef41738abd 100644
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
> @@ -153,6 +162,9 @@ Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
>  /* Get the frame base information from CFA */
>  int die_get_cfa(Dwarf *dwarf, u64 pc, int *preg, int *poffset);
>  
> +/* Save all variables and parameters in this scope */
> +void die_collect_vars(Dwarf_Die *sc_die, struct die_var_type **var_types);
> +
>  #else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
>  
>  static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
> @@ -187,6 +199,11 @@ static inline int die_get_cfa(Dwarf *dwarf __maybe_unused, u64 pc __maybe_unused
>  	return -1;
>  }
>  
> +static inline void die_collect_vars(Dwarf_Die *sc_die __maybe_unused,
> +				    struct die_var_type **var_types __maybe_unused)
> +{
> +}
> +
>  #endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
>  
>  #endif /* _DWARF_AUX_H */
> -- 
> 2.42.0.655.g421f12c284-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
