Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4356A79FFCA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbjINJNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbjINJNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:13:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C7DCEB;
        Thu, 14 Sep 2023 02:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L+ZvunpRm/z7cLGwWtc8p4pqmaQZLwzk2ltMH7TsBcE=; b=MvZnjsC0cuO4NL7t43EdAEwAev
        ibMEroKhi7xfh5lE6WqVj0OJmYeHXQ4sAGx46jXSsbICeukb1UMRIF6zUuoF0HxR1yWg8MnxL3IQ5
        0pqZWCCPCvY3ITDz+AV4ZgP8UPiVXYZOduI775IH8SN5jkVfCZpvfa0w+6S1LmmizxgYvmcH10HqV
        6vnpf8llmtMF1+fzYjVfJgeet/MvBSnsmsL/2i4jkLEkgOyhODFEIV6Z6s8QMg6EMzLpnBuqEcHFQ
        hSsQv78+jPi/I+mTTYB0Syeamr9Tt8rE/XUW5KMchEjMd3Oe29S0zSY3EHpxSc+jtzSQJp8ZO77Cf
        VWWVrVeA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgiOn-007l6s-0A;
        Thu, 14 Sep 2023 09:12:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2BE8230036C; Thu, 14 Sep 2023 11:12:34 +0200 (CEST)
Date:   Thu, 14 Sep 2023 11:12:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     Jirka Hladky <jhladky@redhat.com>,
        Breno Leitao <leitao@debian.org>,
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
Message-ID: <20230914091234.GE16631@noisy.programming.kicks-ass.net>
References: <20230616115316.3652155-1-leitao@debian.org>
 <20230616132954.GG4253@hirez.programming.kicks-ass.net>
 <ZQHiJxHSSGNk+ul5@gmail.com>
 <CAE4VaGBXO5Joynan_o13XpT=mNrwt4D84NTZF6H62GXJjpMbBA@mail.gmail.com>
 <f06ef3dd-dd71-4ba4-a4fa-18a08788c035@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f06ef3dd-dd71-4ba4-a4fa-18a08788c035@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 02:25:40PM +0530, Sandipan Das wrote:
> Hi Breno, Jirka,
> 
> On 9/14/2023 2:15 PM, Jirka Hladky wrote:
> > Hi Breno,
> > 
> > I'm definitively voting for using WARN_ON_ONCE - in the current
> > implementation, we are getting thousands of the same warnings and Call
> > Traces, causing the system to become unusable.
> > 
> >> Anyway, please let me know whatever is your preferred way and I will submit a v2.
> > @Peter Zijlstra and @Sandipan - could you please comment on the
> > preferred implementation of the patch?
> > 
> 
> I agree with using WARN_ON_ONCE() to make this less intrusive.

Could you send a patch that AMD is happy with? I think you wrote this
was a firmware bug and is sorted with a new firmware, so perhaps make it
WARN_ONCE() and tell the users to upgrade their firmware to $ver ?
