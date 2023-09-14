Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98E77A0266
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbjINLTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbjINLTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:19:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A081A1FD8;
        Thu, 14 Sep 2023 04:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bP7pzfeUpJz9asN9tXvS10GhtxvzQ63pGCX9Yrps4Y0=; b=HIQCOqMk7942AVdN9TC+eaQi7B
        jyuziITi+xzvQ6nVyW0DW900ITossuZf3g6NeKAao3MqfXoOOgEdcafydOWGBjPrM9bz2RfAPL1R0
        Asjp12e5vQZuylFsjbKuirbZLwwCgItbVTOZqtTk765lXWKKIuh2s+NNdAO2dTZvuR/FA37rA5gkM
        za7willjNcjK8oSZeilBvs5q90cWKChW429W+ZHl3gNMJBlbgvD/3918Cx694BOUffuVxYxkN7WS6
        mM7mWIvtXjZYGyFhdV8CNBF1nmEkZvBfjBrPxnk1g2UEAmn9uGRK5h/WFXtmLYZRVvcltOhW++KIA
        mYkqMOEw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgkMw-002aGq-Dk; Thu, 14 Sep 2023 11:18:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C65B30036C; Thu, 14 Sep 2023 13:18:46 +0200 (CEST)
Date:   Thu, 14 Sep 2023 13:18:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     Sandipan Das <sandipan.das@amd.com>,
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
Message-ID: <20230914111845.GF16631@noisy.programming.kicks-ass.net>
References: <20230616115316.3652155-1-leitao@debian.org>
 <20230616132954.GG4253@hirez.programming.kicks-ass.net>
 <ZQHiJxHSSGNk+ul5@gmail.com>
 <CAE4VaGBXO5Joynan_o13XpT=mNrwt4D84NTZF6H62GXJjpMbBA@mail.gmail.com>
 <f06ef3dd-dd71-4ba4-a4fa-18a08788c035@amd.com>
 <20230914091234.GE16631@noisy.programming.kicks-ass.net>
 <ZQLSw6PeUbV+p2gH@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQLSw6PeUbV+p2gH@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 02:30:43AM -0700, Breno Leitao wrote:
> On Thu, Sep 14, 2023 at 11:12:34AM +0200, Peter Zijlstra wrote:
> > On Thu, Sep 14, 2023 at 02:25:40PM +0530, Sandipan Das wrote:
> 
> > > I agree with using WARN_ON_ONCE() to make this less intrusive.
> > 
> > Could you send a patch that AMD is happy with?
> 
> Why the current patch is not good enough?

Sandipan, can you answer this? I don't tihnk I'm qualified to speak for
the AMD pmu and certainly I don't have insight into their design future.
