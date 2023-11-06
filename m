Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09647E2899
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjKFPZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjKFPZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:25:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD065191;
        Mon,  6 Nov 2023 07:25:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534D7C433C8;
        Mon,  6 Nov 2023 15:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699284329;
        bh=CWi4UGxo6LMtp/WDUTP1T/BaJpEl//Tm79Jn7g3fz5A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MT511RiMnKSjIHWrpg5nxDgBg4YMK3zHlDbzkVONkqY0vLEv+Y0NW+9zHxbFXdFJE
         o3T2hz0vVXnxawD3egxbEXyDnkXQHk47zvTNcnhyn2nLyNbxg19WfqYthwoGVrbt2E
         8CiFB4vy8Yg3WO5hFqfRGhD4Je5zfASPEARWEqYargzbhVjpHR+5HJZdEc/Hror0zA
         cHaM3oeIEkQrfUYBCeApKZTzoylas/m9zV9u7QTBOLzTY6EwZUKi4zDM6RK2nAjwoz
         SKXrPp2lHiYeO/cJPocmbjoxn6KkltxSLE0S4htyyK2IxZMjODLpe465O+TcjZUw16
         /ssDU1TEE1VmA==
Date:   Tue, 7 Nov 2023 00:25:23 +0900
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
Subject: Re: [PATCH 28/48] perf dwarf-aux: Add die_find_variable_by_addr()
Message-Id: <20231107002523.f0643720eac144841dedb8a4@kernel.org>
In-Reply-To: <20231012035111.676789-29-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
        <20231012035111.676789-29-namhyung@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 20:50:51 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> The die_find_variable_by_addr() is to find a variables in the given DIE
> using given (PC-relative) address.  Global variables will have a
> location expression with DW_OP_addr which has an address so can simply
> compare it with the address.
> 
>   <1><143a7>: Abbrev Number: 2 (DW_TAG_variable)
>       <143a8>   DW_AT_name        : loops_per_jiffy
>       <143ac>   DW_AT_type        : <0x1cca>
>       <143b0>   DW_AT_external    : 1
>       <143b0>   DW_AT_decl_file   : 193
>       <143b1>   DW_AT_decl_line   : 213
>       <143b2>   DW_AT_location    : 9 byte block: 3 b0 46 41 82 ff ff ff ff
>                                      (DW_OP_addr: ffffffff824146b0)
> 
> Note that the type-offset should be calculated from the base address of
> the global variable.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

BTW, for the global variable, you can also find it via maps. Can't you?

Thanks,

> ---
>  tools/perf/util/dwarf-aux.c | 80 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/dwarf-aux.h | 14 +++++++
>  2 files changed, 94 insertions(+)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 5bb05c84d249..97d9ae56350e 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1266,8 +1266,12 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf)
>  struct find_var_data {
>  	/* Target instruction address */
>  	Dwarf_Addr pc;
> +	/* Target memory address (for global data) */
> +	Dwarf_Addr addr;
>  	/* Target register */
>  	unsigned reg;
> +	/* Access offset, set for global data */
> +	int offset;
>  };
>  
>  /* Max number of registers DW_OP_regN supports */
> @@ -1328,6 +1332,82 @@ Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
>  	};
>  	return die_find_child(sc_die, __die_find_var_reg_cb, &data, die_mem);
>  }
> +
> +/* Only checks direct child DIEs in the given scope */
> +static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
> +{
> +	struct find_var_data *data = arg;
> +	int tag = dwarf_tag(die_mem);
> +	ptrdiff_t off = 0;
> +	Dwarf_Attribute attr;
> +	Dwarf_Addr base, start, end;
> +	Dwarf_Word size;
> +	Dwarf_Die type_die;
> +	Dwarf_Op *ops;
> +	size_t nops;
> +
> +	if (tag != DW_TAG_variable)
> +		return DIE_FIND_CB_SIBLING;
> +
> +	if (dwarf_attr(die_mem, DW_AT_location, &attr) == NULL)
> +		return DIE_FIND_CB_SIBLING;
> +
> +	while ((off = dwarf_getlocations(&attr, off, &base, &start, &end, &ops, &nops)) > 0) {
> +		if (ops->atom != DW_OP_addr)
> +			continue;
> +
> +		if (data->addr < ops->number)
> +			continue;
> +
> +		if (data->addr == ops->number) {
> +			/* Update offset relative to the start of the variable */
> +			data->offset = 0;
> +			return DIE_FIND_CB_END;
> +		}
> +
> +		if (die_get_real_type(die_mem, &type_die) == NULL)
> +			continue;
> +
> +		if (dwarf_aggregate_size(&type_die, &size) < 0)
> +			continue;
> +
> +		if (data->addr >= ops->number + size)
> +			continue;
> +
> +		/* Update offset relative to the start of the variable */
> +		data->offset = data->addr - ops->number;
> +		return DIE_FIND_CB_END;
> +	}
> +	return DIE_FIND_CB_SIBLING;
> +}
> +
> +/**
> + * die_find_variable_by_addr - Find variable located at given address
> + * @sc_die: a scope DIE
> + * @pc: the program address to find
> + * @addr: the data address to find
> + * @die_mem: a buffer to save the resulting DIE
> + * @offset: the offset in the resulting type
> + *
> + * Find the variable DIE located at the given address (in PC-relative mode).
> + * This is usually for global variables.
> + */
> +Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
> +				     Dwarf_Addr addr, Dwarf_Die *die_mem,
> +				     int *offset)
> +{
> +	struct find_var_data data = {
> +		.pc = pc,
> +		.addr = addr,
> +	};
> +	Dwarf_Die *result;
> +
> +	result = die_find_child(sc_die, __die_find_var_addr_cb, &data, die_mem);
> +	if (result)
> +		*offset = data.offset;
> +	return result;
> +}
> +
>  #endif
>  
>  /*
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index 574405c57d3b..742098e3ee7e 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -144,6 +144,11 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
>  Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
>  				    Dwarf_Die *die_mem);
>  
> +/* Find a (global) variable located in the 'addr' */
> +Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
> +				     Dwarf_Addr addr, Dwarf_Die *die_mem,
> +				     int *offset);
> +
>  #else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
>  
>  static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
> @@ -161,6 +166,15 @@ static inline Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die __maybe_unus
>  	return NULL;
>  }
>  
> +static inline Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die __maybe_unused,
> +						   Dwarf_Addr pc __maybe_unused,
> +						   Dwarf_Addr addr __maybe_unused,
> +						   Dwarf_Die *die_mem __maybe_unused,
> +						   int *offset __maybe_unused)
> +{
> +	return NULL;
> +}
> +
>  #endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
>  
>  #endif /* _DWARF_AUX_H */
> -- 
> 2.42.0.655.g421f12c284-goog
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
