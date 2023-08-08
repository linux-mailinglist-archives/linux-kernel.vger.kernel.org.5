Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D380774A82
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjHHUab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjHHUaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:30:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6374978B;
        Tue,  8 Aug 2023 12:50:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D97A962BE7;
        Tue,  8 Aug 2023 19:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C037C433C8;
        Tue,  8 Aug 2023 19:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691524241;
        bh=23o4ZzEMUStYgSgaOt9oeKCEbCf1O4Z/im99Zy+alUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NHN5/BNe7uk+gjJStPa1r0uJBWX7RQ72BHLN4VAtDxfkwOsBXjBt/oKtm4yH6Grlo
         fhark6YqZgpsQyXit/ieqssAZYv5UYbtSi63rRk+nLLw1iqN34a98ptLUGwCMy8ipJ
         5ZcPylLEvUyEy8Tw/xqb0AtqHhVMAaDyNL9yTn8hQL2GySX1/eiqlCkrxe8EMZAvPx
         iD6EehnsBC3KFKlbtDby1mANdsyjSX5mKWxM1At+f8/jcBnlDBXfSzAXGDPMoaqsvP
         kVT0nGW4C3HzkfYb8julLGXNOzQjs3s8jEs+YDN1tmJ8VlxajuFADh5b9S/i79tBxM
         S6OVl2MSfIUDg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 91963404DF; Tue,  8 Aug 2023 16:50:38 -0300 (-03)
Date:   Tue, 8 Aug 2023 16:50:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Claire Jensen <cjense@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf stat: Don't display zero tool counts
Message-ID: <ZNKcjv0PTvSIn5lb@kernel.org>
References: <20230801205452.3380578-1-irogers@google.com>
 <ZMwUI/YtEHsO3Cc8@kernel.org>
 <ZNEFt3w/wNCvdawF@tassilo>
 <ZNFJatDztFNS90d3@kernel.org>
 <ZNFMqzSAfno/+BcV@kernel.org>
 <ZNJ9qBoBt2spEy4Y@tassilo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNJ9qBoBt2spEy4Y@tassilo>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 08, 2023 at 10:38:48AM -0700, Andi Kleen escreveu:
> On Mon, Aug 07, 2023 at 04:57:31PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Aug 07, 2023 at 04:43:38PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Mon, Aug 07, 2023 at 07:54:47AM -0700, Andi Kleen escreveu:
> > > > On Thu, Aug 03, 2023 at 05:54:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > Em Tue, Aug 01, 2023 at 01:54:52PM -0700, Ian Rogers escreveu:
> > > > > > Skip zero counts for tool events.
> > > > > > 
> > > > > > Reported-by: Andi Kleen <ak@linux.intel.com>
> > > > > 
> > > > > Andi,
> > > > > 
> > > > > 	Have you tested this? Can we please have your Tested-by?
> > > > 
> > > > I thought I had sent it earlier?
> > > > 
> > > > Tested-by: Andi Kleen <ak@linux.intel.com>
> > > 
> > > Yeah, you did it, sorry, somehow I didn't notice.
> > > 
> > > Applying.
> > 
> > Would be good to have the original link with your report and to figure
> > out the cset that introduced the problem, so that we could have a Fixes
> > tag to help justifying getting this into 6.5.
> 
> Just bisected it. The original patch was below. Remarkably it had a "Fixes"
> tag too)
> 
> My report was 
> 
> https://lore.kernel.org/linux-perf-users/ZMlrzcVrVi1lTDmn@tassilo/

Thanks, I did this research and bisection earlier today, some more tests
and the result matches yours and is available at:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git/commit/?h=perf-tools

I used that ZMlrzcVrVi1lTDmn@tassilo in the Link: tag, as Linus stated
he prefers the discussion leading to the patch than the URL for the
patch itself once submitted.

Now I'll wait a bit till it lands in linux-next/pending-fixes to then
send it to Linus.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=pending-fixes

Thanks again!

- Arnaldo

 
> commit b897613510890d6e92b6a276a20f6c3d96fe90e8
> Author: Namhyung Kim <namhyung@kernel.org>
> Date:   Tue Dec 6 09:58:04 2022 -0800
> 
>     perf stat: Update event skip condition for system-wide per-thread mode and merged uncore and hybrid events
> 
>     In print_counter_aggrdata(), it skips some events that has no aggregate
>     count.  It's actually for system-wide per-thread mode and merged uncore
>     and hybrid events.
> 
>     Let's update the condition to check them explicitly.
> 
>     Fixes: 91f85f98da7ab8c3 ("perf stat: Display event stats using aggr counts")
