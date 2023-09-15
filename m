Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BCC7A15D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjIOGBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjIOGBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:01:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0C41BD0;
        Thu, 14 Sep 2023 23:01:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A575C433C7;
        Fri, 15 Sep 2023 06:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694757665;
        bh=9MYU2c3p+u08BaUZwHdx5A80Jm0GHT65ymH8UGQeY2o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t98NC91cmHcY2SIHVVWfBpFXff3XcWNRQW00nQC8kmgcs4HPMKoaaqmsM/803h9lC
         ZY/z/TUXMzAIj9YY5CADvBElL7X4wq/HQVs2ha3mtHcTf7BXj5dY/4AT8Ptn/E4MG9
         KC4BlOh0zegW3Vsk4ljI4HIshSYvbLwuLeRNe/ZZ5rpPLZzdBhablGaYahVZGvaMsq
         7wVAjueW1tum0REjgugpz10dKYl57+QySnUYfC5NlbCABkWMzo+vwBLn0JI71HGVkT
         bnyXWj8BBNICyVOjs8Wn+Yb5yqaL6x2OAvD5bo8Yd6XEhasx9pIno5suVvuOSumsSc
         sSnyg/tL0W6Jg==
Date:   Fri, 15 Sep 2023 15:01:01 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     rostedt@goodmis.org, artem.bityutskiy@linux.intel.com,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] tracing/synthetic: Print out u64 values properly
Message-Id: <20230915150101.ef50c4774ab85aa2ff7431ec@kernel.org>
In-Reply-To: <20230911141704.3585965-1-tero.kristo@linux.intel.com>
References: <20230911141704.3585965-1-tero.kristo@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tero,

On Mon, 11 Sep 2023 17:17:04 +0300
Tero Kristo <tero.kristo@linux.intel.com> wrote:

> The synth traces incorrectly print pointer to the synthetic event values
> instead of the actual value when using u64 type. Fix by addressing the
> contents of the union properly.

Thanks for pointing it out.
But I would like to see a new "case 8:" print code instead of changing
"default". Can you keep the default as it is and add "case 8:" case there?

Thanks,

> 
> Fixes: ddeea494a16f ("tracing/synthetic: Use union instead of casts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> ---
>  kernel/trace/trace_events_synth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index 7fff8235075f..070365959c0a 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -337,7 +337,7 @@ static void print_synth_event_num_val(struct trace_seq *s,
>  		break;
>  
>  	default:
> -		trace_seq_printf(s, print_fmt, name, val, space);
> +		trace_seq_printf(s, print_fmt, name, val->as_u64, space);
>  		break;
>  	}
>  }
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
