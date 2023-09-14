Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9207A02A0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbjINL2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237779AbjINL2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:28:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D45269F;
        Thu, 14 Sep 2023 04:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qKsiGLcP8XdXXDc7ibwaXIyN8m4wv6e0IIyRIdjUx9c=; b=qrc7yR62CX+hvbwgE/klJkbFiW
        sCh78HYtrk1q9rJ3Hva3lz6hvI0Bghsm5SJ458RXfW5Wu6AffvK+MfSu03otsrWtvlYsLJ5VOEkiy
        kABF6cmuGBeWgzRAaUxoxsgJBR1qrI9pOf3RRevgH8NsRB4umWBlxXtr2PAjrwVNSDf9QHhlcTBfl
        rJhep8JwnX7WALMJXbZPR+u+iK9uxex+xH+nhgu1WMrZ60lL/PzHdlTdiBq9JqmXqLroQ94KiDhc1
        1a9G94f5nXNVOxJuczsnatpGNBIGcUuyUpzO7ZpRqjOzURYEfdxQzr/xNAz/terAAn8+zmf+huAiX
        4BRWt9cQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgkVC-007pLm-1p;
        Thu, 14 Sep 2023 11:27:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id A6CB4300422; Thu, 14 Sep 2023 13:27:19 +0200 (CEST)
Date:   Thu, 14 Sep 2023 13:27:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     Breno Leitao <leitao@debian.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, leit@fb.com,
        dcostantino@meta.com,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf/x86/amd: Do not WARN on every IRQ
Message-ID: <20230914112719.GB18948@noisy.programming.kicks-ass.net>
References: <20230616115316.3652155-1-leitao@debian.org>
 <20230616132954.GG4253@hirez.programming.kicks-ass.net>
 <ZQHiJxHSSGNk+ul5@gmail.com>
 <CAE4VaGBXO5Joynan_o13XpT=mNrwt4D84NTZF6H62GXJjpMbBA@mail.gmail.com>
 <f06ef3dd-dd71-4ba4-a4fa-18a08788c035@amd.com>
 <20230914091234.GE16631@noisy.programming.kicks-ass.net>
 <ZQLSw6PeUbV+p2gH@gmail.com>
 <20230914111845.GF16631@noisy.programming.kicks-ass.net>
 <b1cf5990-1019-49ea-a1e8-e22410922801@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1cf5990-1019-49ea-a1e8-e22410922801@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 04:52:13PM +0530, Sandipan Das wrote:
> On 9/14/2023 4:48 PM, Peter Zijlstra wrote:
> > On Thu, Sep 14, 2023 at 02:30:43AM -0700, Breno Leitao wrote:
> >> On Thu, Sep 14, 2023 at 11:12:34AM +0200, Peter Zijlstra wrote:
> >>> On Thu, Sep 14, 2023 at 02:25:40PM +0530, Sandipan Das wrote:
> >>
> >>>> I agree with using WARN_ON_ONCE() to make this less intrusive.
> >>>
> >>> Could you send a patch that AMD is happy with?
> >>
> >> Why the current patch is not good enough?
> > 
> > Sandipan, can you answer this? I don't tihnk I'm qualified to speak for
> > the AMD pmu and certainly I don't have insight into their design future.
> 
> Hi Breno,
> 
> Functionally, the patch looks good to me and I will be reusing it
> without any change to the authorship. However, as Peter suggested, I
> wanted to add a message to prompt users to update the microcode and
> also call out the required patch levels in the commit message since
> different Zen 4 variants and steppings use different microcode.
> 
> Here's what I plan to send.
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index abadd5f23425..186a124bb3c0 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -909,6 +909,13 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
>                 status &= ~GLOBAL_STATUS_LBRS_FROZEN;
>         }
> 
> +       if (status & ~amd_pmu_global_cntr_mask)
> +               pr_warn_once("Unknown status bits are set (0x%llx), please consider updating microcode\n",
> +                            status);
> +
> +       /* Clear any reserved bits set by buggy microcode */
> +       status &= amd_pmu_global_cntr_mask;
> +
>         for (idx = 0; idx < x86_pmu.num_counters; idx++) {
>                 if (!test_bit(idx, cpuc->active_mask))
>                         continue;
> 
> --
> 
> Hi Peter,
> 
> There is another case where users will see warnings but the patch
> to fix it (link below) is yet to be reviewed. May I rebase and
> resend it along with the above?
> 
> https://lore.kernel.org/all/20230613105809.524535-1-sandipan.das@amd.com/
> 

Sure, sorry I seem to have missed that :-(
