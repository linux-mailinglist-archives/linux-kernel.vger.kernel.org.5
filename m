Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9077E12DC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 10:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjKEJsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 04:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEJst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 04:48:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07222CC;
        Sun,  5 Nov 2023 01:48:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5002BC433C8;
        Sun,  5 Nov 2023 09:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699177726;
        bh=TWv1smHYN6QLsyC/JK7cl0Xj5FUDrDU2v7Za9ia3Nxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iVKWreV7jAdLTp75MOaTg5Sm5lTCcXIxP+TmWTbRn+vVMDk+QuzsYm72ktq8+Dz/p
         /PM7XPqTsK1pFeBt3LDFaRInJ+eqit07aLkD6JW0B/BpmRJtVCrhn/RwoCOsGyOWyO
         icqEIbxujTcqjIYZlZbFlqQo4SELPA8AB42HjX/dOwowA+YF9GqN6Gr71mn2wd+FZ2
         zrQpxuVE97liFn6rv3gsHrBwdWXvMig6Hsf2L5amXY6ToEs6Ybj3yiRjjet42lL5L/
         sSb+lO8/aYq3XExX/aTS1G935/bi6wZIkXnzs4Kcs6bHTjtjtRBUS6bd2RSmvqtVCP
         MpSXYOMu7AGfw==
Date:   Sun, 5 Nov 2023 18:48:40 +0900
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
Subject: Re: [PATCH 07/48] perf dwarf-aux: Add die_find_variable_by_reg()
 helper
Message-Id: <20231105184840.947ae57233fbaeb3e66ae5d9@kernel.org>
In-Reply-To: <20231012035111.676789-8-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
        <20231012035111.676789-8-namhyung@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 20:50:30 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> The die_find_variable_by_reg() will search for a variable or a parameter
> sub-DIE in the given scope DIE where the location matches to the given
> register.
> 
> For the simpliest and most common case, memory access usually happens
> with a base register and an offset to the field so the register would
> hold a pointer in a variable or function parameter.  Then we can find
> one if it has a location expression at the (instruction) address.  So
> this function only handles such a simple case for now.
> 
> In this case, the expression would have a DW_OP_regN operation where
> N < 32.  If the register index (N) is greater than or equal to 32,
> DW_OP_regx operation with an operand which saves the value for the N
> would be used.  It would reject expressions with more operations.
> 

Nice! This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/dwarf-aux.c | 67 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/dwarf-aux.h | 12 +++++++
>  2 files changed, 79 insertions(+)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 10aa32334d6f..652e6e7368a2 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1245,6 +1245,73 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf)
>  out:
>  	return ret;
>  }
> +
> +/* Interval parameters for __die_find_var_reg_cb() */
> +struct find_var_data {
> +	/* Target instruction address */
> +	Dwarf_Addr pc;
> +	/* Target register */
> +	unsigned reg;
> +};
> +
> +/* Max number of registers DW_OP_regN supports */
> +#define DWARF_OP_DIRECT_REGS  32
> +
> +/* Only checks direct child DIEs in the given scope. */
> +static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
> +{
> +	struct find_var_data *data = arg;
> +	int tag = dwarf_tag(die_mem);
> +	ptrdiff_t off = 0;
> +	Dwarf_Attribute attr;
> +	Dwarf_Addr base, start, end;
> +	Dwarf_Op *ops;
> +	size_t nops;
> +
> +	if (tag != DW_TAG_variable && tag != DW_TAG_formal_parameter)
> +		return DIE_FIND_CB_SIBLING;
> +
> +	if (dwarf_attr(die_mem, DW_AT_location, &attr) == NULL)
> +		return DIE_FIND_CB_SIBLING;
> +
> +	while ((off = dwarf_getlocations(&attr, off, &base, &start, &end, &ops, &nops)) > 0) {
> +		/* Assuming the location list is sorted by address */
> +		if (end < data->pc)
> +			continue;
> +		if (start > data->pc)
> +			break;
> +
> +		/* Only match with a simple case */
> +		if (data->reg < DWARF_OP_DIRECT_REGS) {
> +			if (ops->atom == (DW_OP_reg0 + data->reg) && nops == 1)
> +				return DIE_FIND_CB_END;
> +		} else {
> +			if (ops->atom == DW_OP_regx && ops->number == data->reg &&
> +			    nops == 1)
> +				return DIE_FIND_CB_END;
> +		}
> +	}
> +	return DIE_FIND_CB_SIBLING;
> +}
> +
> +/**
> + * die_find_variable_by_reg - Find a variable saved in a register
> + * @sc_die: a scope DIE
> + * @pc: the program address to find
> + * @reg: the register number to find
> + * @die_mem: a buffer to save the resulting DIE
> + *
> + * Find the variable DIE accessed by the given register.
> + */
> +Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
> +				    Dwarf_Die *die_mem)
> +{
> +	struct find_var_data data = {
> +		.pc = pc,
> +		.reg = reg,
> +	};
> +	return die_find_child(sc_die, __die_find_var_reg_cb, &data, die_mem);
> +}
>  #endif
>  
>  /*
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index f9d765f80fb0..b6f430730bd1 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -137,6 +137,10 @@ int die_get_scopes(Dwarf_Die *cu_die, Dwarf_Addr pc, Dwarf_Die **scopes);
>  /* Get byte offset range of given variable DIE */
>  int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
>  
> +/* Find a variable saved in the 'reg' at given address */
> +Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
> +				    Dwarf_Die *die_mem);
> +
>  #else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
>  
>  static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
> @@ -146,6 +150,14 @@ static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
>  	return -ENOTSUP;
>  }
>  
> +static inline Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die __maybe_unused,
> +						  Dwarf_Addr pc __maybe_unused,
> +						  int reg __maybe_unused,
> +						  Dwarf_Die *die_mem __maybe_unused)
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


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
