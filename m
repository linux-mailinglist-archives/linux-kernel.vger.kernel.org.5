Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7967E8294
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346426AbjKJT3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjKJT2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:28:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A006F28B1E;
        Fri, 10 Nov 2023 02:25:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3786C433C7;
        Fri, 10 Nov 2023 10:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699611956;
        bh=JZISxcimReBhko2Zl99MgOPt2Pg9GAOJkrwz5NhlZNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c0sq7VbUWBmKRB5EsVyaE60FSCiM4Y+h51KYdbHUcT/SlWL52uM24p1jdq89o25IH
         0UbAJQv6fAeJim+u2HAPESj+eKM+lhNQfLh6MbgCd9mrCq4iI8SMe6JnRLYhjrvYXw
         4TWG/Riaqs/UhJphFOAM7uoFKwvDwrPks7ZYbg/J85K3SR/DSS543rtxHgImO23Ssv
         X4ArKRqbG/NxIh4Kx9yrNF64Lwe0Ih8/2KpKrb54+fIaiFMPYh1bu+/QJcRBOU6fIs
         /U0vGU61pM4aFUar+12jbV7XVp1hxR1+Um22dzp3Gv3kJl7thkDLysfIiHIQzvQszP
         XWBGrV1A9AmRg==
Date:   Fri, 10 Nov 2023 19:25:50 +0900
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
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH 09/52] perf probe: Convert to check dwarf_getcfi feature
Message-Id: <20231110192550.53b4daa1325c83da7f88417f@kernel.org>
In-Reply-To: <20231110000012.3538610-10-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
        <20231110000012.3538610-10-namhyung@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Nov 2023 15:59:28 -0800
Namhyung Kim <namhyung@kernel.org> wrote:

> Now it has a feature check for the dwarf_getcfi(), use it and convert
> the code to check HAVE_DWARF_CFI_SUPPORT definition.
> 

Looks good to me!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Makefile.config     | 5 +++++
>  tools/perf/util/probe-finder.c | 8 ++++----
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 8b6cffbc4858..aa55850fbc21 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -476,6 +476,11 @@ else
>        else
>          CFLAGS += -DHAVE_DWARF_GETLOCATIONS_SUPPORT
>        endif # dwarf_getlocations
> +      ifneq ($(feature-dwarf_getcfi), 1)
> +        msg := $(warning Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.142);
> +      else
> +        CFLAGS += -DHAVE_DWARF_CFI_SUPPORT
> +      endif # dwarf_getcfi
>      endif # Dwarf support
>    endif # libelf support
>  endif # NO_LIBELF
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 8d3dd85f9ff4..c8923375e30d 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -604,7 +604,7 @@ static int call_probe_finder(Dwarf_Die *sc_die, struct probe_finder *pf)
>  	ret = dwarf_getlocation_addr(&fb_attr, pf->addr, &pf->fb_ops, &nops, 1);
>  	if (ret <= 0 || nops == 0) {
>  		pf->fb_ops = NULL;
> -#if _ELFUTILS_PREREQ(0, 142)
> +#ifdef HAVE_DWARF_CFI_SUPPORT
>  	} else if (nops == 1 && pf->fb_ops[0].atom == DW_OP_call_frame_cfa &&
>  		   (pf->cfi_eh != NULL || pf->cfi_dbg != NULL)) {
>  		if ((dwarf_cfi_addrframe(pf->cfi_eh, pf->addr, &frame) != 0 &&
> @@ -615,7 +615,7 @@ static int call_probe_finder(Dwarf_Die *sc_die, struct probe_finder *pf)
>  			free(frame);
>  			return -ENOENT;
>  		}
> -#endif
> +#endif /* HAVE_DWARF_CFI_SUPPORT */
>  	}
>  
>  	/* Call finder's callback handler */
> @@ -1140,7 +1140,7 @@ static int debuginfo__find_probes(struct debuginfo *dbg,
>  
>  	pf->machine = ehdr.e_machine;
>  
> -#if _ELFUTILS_PREREQ(0, 142)
> +#ifdef HAVE_DWARF_CFI_SUPPORT
>  	do {
>  		GElf_Shdr shdr;
>  
> @@ -1150,7 +1150,7 @@ static int debuginfo__find_probes(struct debuginfo *dbg,
>  
>  		pf->cfi_dbg = dwarf_getcfi(dbg->dbg);
>  	} while (0);
> -#endif
> +#endif /* HAVE_DWARF_CFI_SUPPORT */
>  
>  	ret = debuginfo__find_probe_location(dbg, pf);
>  	return ret;
> -- 
> 2.42.0.869.gea05f2083d-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
