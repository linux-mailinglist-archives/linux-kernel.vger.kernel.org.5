Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C71D7FD564
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjK2LUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjK2LUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:20:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5107C19A6;
        Wed, 29 Nov 2023 03:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nfefCCnsqpDIQXnjyw2pclwrJzrSnNB6gX+SxRbmJt8=; b=Xzsit8hdjIXnV/LLaOje1WqND2
        qpXp5/+AZR2doILvXM7Y6gsiEurZzcX610rYa2dylpxmp5/IOA2YwKHiOn17kVEfw3lgZWUJGem/p
        H1yXJR6RyNGr3qGFTmVnvGEVXXdIF5z+/xEFzIzFIpf4Q8Vc/vUwpLNExrQStEi5gzQrF8GeAMi9p
        Uwew1WUyvUsBwsHB3T3ESOWHyDPY8HK/7xn1ou+fNPqu/hcg72QglukPXPF+Ki5PEnL6T1hn1Hl8m
        Zc3+5b9UTZlHG1sgtfbsq+PDExcsN7V/0pY+8CdSng4gBPfWlFTaeZl3RzIV8D7nPznmujELrTXUh
        +i+odGAg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r8Ic9-00DKbP-2s; Wed, 29 Nov 2023 11:20:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4324F300293; Wed, 29 Nov 2023 12:20:19 +0100 (CET)
Date:   Wed, 29 Nov 2023 12:20:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <likexu@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH] perf/x86: Don't enforce minimum period for KVM
 guest-only events
Message-ID: <20231129112019.GG30650@noisy.programming.kicks-ass.net>
References: <20231107183605.409588-1-seanjc@google.com>
 <20231117103236.GI3818@noisy.programming.kicks-ass.net>
 <ZWaU3HZURCjms5DM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWaU3HZURCjms5DM@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 05:33:16PM -0800, Sean Christopherson wrote:

> If programming a "period" of 1 puts the host at risk in some way, then I agree
> that this is unsafe and we need a different solution. 

IIRC if you put in -1 on a Nehalem, you end up with an NMI-storm which
wasn't trivial to recover from if at all (it's too long ago and I don't
have ancient hardware like that anymore :/)

> But if the worst case
> scenario is non-determinstic or odd behavior from the guest's perspective, then
> that's the guest's problem (with the caveat that the guest might not have accurate
> Family/Model/Stepping data to make informed decisions).

Things like bdm_limit_period() will cause odd behaviour IIRC, it does
daft things like generate extra PEBS records on overflow and gives
otherwise daft results for PDIR.

glc_limit_period() lacks a useful comment :/
