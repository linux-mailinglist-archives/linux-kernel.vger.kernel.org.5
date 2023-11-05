Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0AF7E12DD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 10:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjKEJuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 04:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEJuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 04:50:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44170CC;
        Sun,  5 Nov 2023 01:50:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B231C433C7;
        Sun,  5 Nov 2023 09:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699177832;
        bh=yVDAG+Wg7NzlCWgHtRHjaf+Zk9FIY44KvEALOUGTSg4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ET/GOvTwRaR0OvMf3Y9dtX2mYgIzoiXTWFznB7vyz0caFbk1ANPjNbKuylWhsSoBP
         3MfJhS3D5m1CAx8rSIp4uqnrHnDv9owcYCE14fiHlG3LPVHcgRL7YF9o3zzDIRImWk
         dVxcyHSgn3dc9NNXic348e2kzBmtK1ILv6p9Waph9aa++9rYGu4pfd6g5MUgZDMq1k
         xAv4yjT+vo7zZdHjiXU749SrC7SaQLsRRejBIr9mH3rAZ5JEefM6wb4oZgAB6wnrKF
         fER0q/rMMJWm2x6U7PWBjg+nG87iFKBqVNM5vRaq2Nr8oHmrhRz6+ypVyOYzcQXIRw
         EzlIWBlEfGVVw==
Date:   Sun, 5 Nov 2023 18:50:27 +0900
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
Subject: Re: [PATCH 06/48] perf dwarf-aux: Add die_get_scopes() helper
Message-Id: <20231105185027.c99fe50fb182a44ee6d259ed@kernel.org>
In-Reply-To: <20231012035111.676789-7-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
        <20231012035111.676789-7-namhyung@kernel.org>
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

On Wed, 11 Oct 2023 20:50:29 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> The die_get_scopes() would return the number of enclosing DIEs for the
> given address and it fills an array of DIEs like dwarf_getscopes().
> But it doesn't follow the abstract origin of inlined functions as we
> want information of the concrete instance.  This is needed to check the
> location of parameters and local variables properly.  Users can check
> the origin separately if needed.

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks

> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/dwarf-aux.c | 53 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/dwarf-aux.h |  3 +++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index adef2635587d..10aa32334d6f 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1425,3 +1425,56 @@ void die_skip_prologue(Dwarf_Die *sp_die, Dwarf_Die *cu_die,
>  
>  	*entrypc = postprologue_addr;
>  }
> +
> +/* Internal parameters for __die_find_scope_cb() */
> +struct find_scope_data {
> +	/* Target instruction address */
> +	Dwarf_Addr pc;
> +	/* Number of scopes found [output] */
> +	int nr;
> +	/* Array of scopes found, 0 for the outermost one. [output] */
> +	Dwarf_Die *scopes;
> +};
> +
> +static int __die_find_scope_cb(Dwarf_Die *die_mem, void *arg)
> +{
> +	struct find_scope_data *data = arg;
> +
> +	if (dwarf_haspc(die_mem, data->pc)) {
> +		Dwarf_Die *tmp;
> +
> +		tmp = realloc(data->scopes, (data->nr + 1) * sizeof(*tmp));
> +		if (tmp == NULL)
> +			return DIE_FIND_CB_END;
> +
> +		memcpy(tmp + data->nr, die_mem, sizeof(*die_mem));
> +		data->scopes = tmp;
> +		data->nr++;
> +		return DIE_FIND_CB_CHILD;
> +	}
> +	return DIE_FIND_CB_SIBLING;
> +}
> +
> +/**
> + * die_get_scopes - Return a list of scopes including the address
> + * @cu_die: a compile unit DIE
> + * @pc: the address to find
> + * @scopes: the array of DIEs for scopes (result)
> + *
> + * This function does the same as the dwarf_getscopes() but doesn't follow
> + * the origins of inlined functions.  It returns the number of scopes saved
> + * in the @scopes argument.  The outer scope will be saved first (index 0) and
> + * the last one is the innermost scope at the @pc.
> + */
> +int die_get_scopes(Dwarf_Die *cu_die, Dwarf_Addr pc, Dwarf_Die **scopes)
> +{
> +	struct find_scope_data data = {
> +		.pc = pc,
> +	};
> +	Dwarf_Die die_mem;
> +
> +	die_find_child(cu_die, __die_find_scope_cb, &data, &die_mem);
> +
> +	*scopes = data.scopes;
> +	return data.nr;
> +}
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index 4f5d0211ee4f..f9d765f80fb0 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -129,6 +129,9 @@ bool die_is_optimized_target(Dwarf_Die *cu_die);
>  void die_skip_prologue(Dwarf_Die *sp_die, Dwarf_Die *cu_die,
>  		       Dwarf_Addr *entrypc);
>  
> +/* Get the list of including scopes */
> +int die_get_scopes(Dwarf_Die *cu_die, Dwarf_Addr pc, Dwarf_Die **scopes);
> +
>  #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
>  
>  /* Get byte offset range of given variable DIE */
> -- 
> 2.42.0.655.g421f12c284-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
