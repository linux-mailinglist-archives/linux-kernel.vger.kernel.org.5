Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4978076D0F3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbjHBPDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbjHBPC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:02:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551AF2D71
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AIDW4KrvrypBYNBzVeTDHm+/ythWuyMApwP/eRhnVqo=; b=Iice7kyz/GNPSpl+GesPnnB8/9
        Xlt0hZiVKPPVCfKrytqH/inr40pLQelAptKgP+FSipUTGmFgMDxaFkN3g7DzCrA9zKtkkXLHUgtu3
        Jsf6PH4Bt4GtLJNfZFrqFWt8gprNkJJxuLxUWcwjGE9U/nwnZWp++5vYtIUO3Tg8mihDJN7gSg88Q
        6AxSNvZCAQOTEXb5xFerBOjewa0twKzb2H+uMNl5sQof/Mad2ZTsdlGpb2DED2ptfao8OD0ywgMXh
        qaY9XdxumMV6FToXzNII5uBPF+6zDUfHLYeN00vm8HjBvvOUrR7djoaJSk9ovXaT6Ua/QyuyGHKWM
        QnepmY1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRDMH-00FcSX-0s; Wed, 02 Aug 2023 15:01:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 954F7300301;
        Wed,  2 Aug 2023 17:01:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77DF4203E5134; Wed,  2 Aug 2023 17:01:52 +0200 (CEST)
Date:   Wed, 2 Aug 2023 17:01:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "alexey.v.bayduraev@linux.intel.com" 
        <alexey.v.bayduraev@linux.intel.com>,
        "Zhang, Tinghao" <tinghao.zhang@intel.com>
Subject: Re: [PATCH V2 1/6] perf/x86/intel: Add Grand Ridge and Sierra Forest
Message-ID: <20230802150152.GC212435@hirez.programming.kicks-ass.net>
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
 <20230522202659.GC3334667@hirez.programming.kicks-ass.net>
 <SJ1PR11MB608367DC5D25856073C86FCFFC53A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230608072420.GB998233@hirez.programming.kicks-ass.net>
 <SJ1PR11MB608366EC800DBE389EE75E0CFC50A@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608366EC800DBE389EE75E0CFC50A@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 04:20:22PM +0000, Luck, Tony wrote:
> > Then I'm hoping their take-away is that random gibberish names don't
> > help anybody. The whole Intel naming scheme is impenetrable crap.
> 
> > > +#define INTEL_FAM6_ATOM_CRESTMONT_X  0xAF /* Sierra Forest */
> > > +#define INTEL_FAM6_ATOM_CRESTMONT    0xB6 /* Grand Ridge */
> 
> This just adds another layer of confusion. Sure, these two models are based
> on the same core. But giving the illusion that they are somehow the same will
> lead to tears before bedtime:
> 
> 1) They each took a snapshot of that core design on different dates, so there
>    are logic differences.
> 2) Feature fuses will be different
> 3) Microcode will be different
> 4) BIOS will be different
> 5) "uncore" is different, so anything implemented outside of the core
>     will be different.

All those things are true for INTEL_FAM6_SKYLAKE vs INTEL_FAM6_SKYLAKE_X
and all the other pre-hybrid desktop/server parts.

And we used to do the same with the previous ATOM things, see GOLDMONT /
GOLDMONT_D, TREMONT / TREMONT_D etc..

So why should this atom be treated differently? We get a server atom and
a client atom, yes they different in all the usual way, but they still
more similar to one another than to any other random chip we have.

In short, we used to have this for core parts, we used to have this for
atom parts, but now we magically need to break from it?

Anyway, let me do the rename and squish everything into a git tree.

