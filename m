Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A877E3266
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 01:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjKGAuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 19:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGAuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 19:50:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C7A9C;
        Mon,  6 Nov 2023 16:50:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67C1C433C7;
        Tue,  7 Nov 2023 00:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699318217;
        bh=+vq4d6CCWDzMfZDEDlYqaTwwQMt8QPiakU/bxCSgh5M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FJP5CGJbzzPFKSxm5emzr1yg3F6JIQiXqily3skMibkMoTLWrwsfsgxUiqxb76zX6
         D7dPtBLeKnMAuPTs71KoBRVkDkdSTSLkK6aGcxE7n+M9+pCP6D7sGCS5/cdt/laN8d
         o3EzBxnSk0/wEe1nEDmz/ZqfrHOx/qoOaZB2GIGV2BG1uVqnRgLEz3F8fmQWfMctCz
         sSTBmqm+NpSDVjAsGtFSJ7lrHMw8Ri4+kByhvSUmzvvAQYl0TIDRJQPXBMAMDuGTro
         ohYYBx6NlzPcFPxVTudhfOikdGoQbGrn71btej6LK1jfx8WsBdGdCTU3nZJHQSYAH6
         l5dQi54xrIa9Q==
Date:   Tue, 7 Nov 2023 09:50:11 +0900
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
Subject: Re: [PATCH 31/48] perf dwarf-aux: Add die_get_cfa()
Message-Id: <20231107095011.7538657bbe34f0d7171add09@kernel.org>
In-Reply-To: <20231012035111.676789-32-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
        <20231012035111.676789-32-namhyung@kernel.org>
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

On Wed, 11 Oct 2023 20:50:54 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> The die_get_cfa() is to get frame base register and offset at the given
> instruction address (pc).  This info will be used to locate stack
> variables which have location expression using DW_OP_fbreg.
> 

In the util/probe-finder.c, I added the elfutils version checker

#if _ELFUTILS_PREREQ(0, 142)

for CFI related code, in commit 7752f1b096e1 ("perf probe: Don't
 compile CFI related code if elfutils is old"). Maybe we'd better to have
a config of HAVE_DWARF_CFI_SUPPORT for this.

Thank you,


> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/dwarf-aux.c | 64 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/dwarf-aux.h |  9 ++++++
>  2 files changed, 73 insertions(+)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 97d9ae56350e..796413eb4e8f 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1408,6 +1408,70 @@ Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
>  	return result;
>  }
>  
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
> +
> +/**
> + * die_get_cfa - Get frame base information
> + * @dwarf: a Dwarf info
> + * @pc: program address
> + * @preg: pointer for saved register
> + * @poffset: pointer for saved offset
> + *
> + * This function gets register and offset for CFA (Canonical Frame Address)
> + * by searching the CIE/FDE info.  The CFA usually points to the start address
> + * of the current stack frame and local variables can be located using an offset
> + * from the CFA.  The @preg and @poffset will be updated if it returns 0.
> + */
> +int die_get_cfa(Dwarf *dwarf, u64 pc, int *preg, int *poffset)
> +{
> +	Dwarf_CFI *cfi;
> +	Dwarf_Frame *frame = NULL;
> +	Dwarf_Op *ops = NULL;
> +	size_t nops;
> +
> +	cfi = dwarf_getcfi(dwarf);
> +	if (cfi == NULL)
> +		return -1;
> +
> +	if (!dwarf_cfi_addrframe(cfi, pc, &frame) &&
> +	    !dwarf_frame_cfa(frame, &ops, &nops) && nops == 1) {
> +		*preg = reg_from_dwarf_op(ops);
> +		*poffset = offset_from_dwarf_op(ops);
> +		return 0;
> +	}
> +	return -1;
> +}
> +
>  #endif
>  
>  /*
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index 742098e3ee7e..29a7243b1a45 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -149,6 +149,9 @@ Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
>  				     Dwarf_Addr addr, Dwarf_Die *die_mem,
>  				     int *offset);
>  
> +/* Get the frame base information from CFA */
> +int die_get_cfa(Dwarf *dwarf, u64 pc, int *preg, int *poffset);
> +
>  #else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
>  
>  static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
> @@ -175,6 +178,12 @@ static inline Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die __maybe_unu
>  	return NULL;
>  }
>  
> +static inline int die_get_cfa(Dwarf *dwarf __maybe_unused, u64 pc __maybe_unused,
> +			      int *preg __maybe_unused, int *poffset __maybe_unused)
> +{
> +	return -1;
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
