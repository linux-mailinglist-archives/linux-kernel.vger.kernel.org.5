Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC117E5F1F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjKHU1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjKHU1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:27:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026A42126
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 12:27:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E26C433C7;
        Wed,  8 Nov 2023 20:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699475227;
        bh=3eK41umP+PNvQkPkGSnSp+1Cb2llqRdlWxwUqKq+Jyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZQFWjvYlSgub9vGdYvD+XEywVHu23QcYHdiAbVpzCMcdTTFDdPALR5tfWr4ljYqw
         qY0xeWP9btMbHVzmTgXYZtn8koYpJqPrwsUQcas6woSfC+FqGDgxhv85JL4AdPU6fE
         JlMQ7d57dyENefLO/05aRGas0J+cahpSRb/ZShpWlM+l9IJsrv2PkA1/U/ND+jCJBg
         wQcCN6hW6VVpVONuODL0THzbGUddWlO41tVK5CzMHJJeNzxGaypTnaX1AK22ZhyczR
         ja+OKUqmR4WVVvpzfgEA02Q0CbnrBC9/aP599u9BBBKcEv8IQ0InOlwGIM/THPpFw2
         hxWfusHNeLpcQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5C6864035D; Wed,  8 Nov 2023 17:27:05 -0300 (-03)
Date:   Wed, 8 Nov 2023 17:27:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCHSET 0/5] perf annotate: Reduce memory footprint (v2)
Message-ID: <ZUvvGSsOesdbQUXY@kernel.org>
References: <20231103191907.54531-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103191907.54531-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 03, 2023 at 12:19:02PM -0700, Namhyung Kim escreveu:
> Hello,
> 
> This is a part of my work to improve perf annotate.  At first, I'd
> like reduce the size of struct annotation which will be allocated
> together with struct symbol in some cases.  In fact, it doesn't use
> most of them so it needs to slim down and lazy-allocate used part.
> 
> * v2 changes)
>  - fix typo
>  - reorder struct annotated_source
>  - add Ian's Reviewed-by tags
>  
> With this applied, size of the struct goes down from 96 to 48.
> 
> The code is available at perf/annotate-diet-v2 branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 

Applied to perf-tools-next, thanks,

- Arnaldo
 
> Namhyung Kim (5):
>   perf annotate: Split struct cycles_info
>   perf annotate: Split struct annotated_branch
>   perf annotate: Move max_coverage to annotated_branch
>   perf annotate: Move some fields to annotated_source
>   perf annotate: Move offsets to annotated_source
> 
>  tools/perf/builtin-annotate.c     |   7 +-
>  tools/perf/ui/browsers/annotate.c |  18 ++--
>  tools/perf/util/annotate.c        | 162 ++++++++++++++++--------------
>  tools/perf/util/annotate.h        |  49 +++++----
>  tools/perf/util/block-info.c      |   4 +-
>  tools/perf/util/block-range.c     |   7 +-
>  tools/perf/util/sort.c            |  14 +--
>  7 files changed, 147 insertions(+), 114 deletions(-)
> 
> -- 
> 2.42.0.869.gea05f2083d-goog
> 
> 

-- 

- Arnaldo
