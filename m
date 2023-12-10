Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCA780BA31
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 11:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjLJKjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 05:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJKjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 05:39:04 -0500
Received: from smtp.gentoo.org (mail.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BBE99
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 02:39:10 -0800 (PST)
Date:   Sun, 10 Dec 2023 11:39:05 +0100
From:   Guilherme Amadio <amadio@gentoo.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] x86/nmi: Rate limit unknown NMI messages
Message-ID: <ZXWVSXqAkOGRs3UG@gentoo.org>
References: <20231209015211.357983-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231209015211.357983-1-namhyung@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 05:52:11PM -0800, Namhyung Kim wrote:
> On some AMD machines, unknown NMI messages were printed on the console
> continuously when using perf command with IBS.  It was reported that it
> can slow down the kernel.  Let's ratelimit the unknown NMI messages.
> 
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Cc: Guilherme Amadio <amadio@gentoo.org>

The rate of messages on the console were proportional to the sampling frequency
when I noticed this happening, so this is a welcome change. Thank you!

Acked-by: Guilherme Amadio <amadio@gentoo.org>

Best regards,
-Guilherme

> Cc: Stephane Eranian <eranian@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  arch/x86/kernel/nmi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> index 17e955ab69fe..d23867901186 100644
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c
> @@ -303,13 +303,13 @@ unknown_nmi_error(unsigned char reason, struct pt_regs *regs)
>  
>  	__this_cpu_add(nmi_stats.unknown, 1);
>  
> -	pr_emerg("Uhhuh. NMI received for unknown reason %02x on CPU %d.\n",
> -		 reason, smp_processor_id());
> +	pr_emerg_ratelimited("Uhhuh. NMI received for unknown reason %02x on CPU %d.\n",
> +			     reason, smp_processor_id());
>  
>  	if (unknown_nmi_panic || panic_on_unrecovered_nmi)
>  		nmi_panic(regs, "NMI: Not continuing");
>  
> -	pr_emerg("Dazed and confused, but trying to continue\n");
> +	pr_emerg_ratelimited("Dazed and confused, but trying to continue\n");
>  }
>  NOKPROBE_SYMBOL(unknown_nmi_error);
>  
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
