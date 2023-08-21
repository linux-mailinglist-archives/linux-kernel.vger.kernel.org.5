Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3539B782A47
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbjHUNRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjHUNRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:17:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62441102;
        Mon, 21 Aug 2023 06:17:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E64D5616C0;
        Mon, 21 Aug 2023 13:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D6DC433C7;
        Mon, 21 Aug 2023 13:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692623805;
        bh=KPa/AwkosoOhlmZaq4JF40z1lU8eMUi0EpScWLPvrao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oQGcvU4wKYUz0g3IFUpnVo7fmvXH7c9xTWmCvN5nKublD+oTZFbwrvB3/fwz8vUXJ
         9Nl6MsOfLIliTwSVVUKXvzsDRSq8wj1kmRmUkPv+xrfgUbT+uC7GSD1sgeCJk3CThJ
         vpTdTDw3Tcn/dygVBsT2eM5u9/5AjyG5Qt1TXzW76qYiF78o2j7ALb78FbMI7YtxyN
         p0dUhg52o9EIbf4VbRmGelqxpVrit3dcUW4kstNvfH+1ZxYa54rN2HYQKQwoNeeaTJ
         w35WMwpMqKX1LySH82BEguEDeP9cepX6bYCiGi5zAFyLmFmTcoK1+gAoWKMLA7Y+B3
         17Yhm6PEzfOnQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 648F340722; Mon, 21 Aug 2023 10:16:42 -0300 (-03)
Date:   Mon, 21 Aug 2023 10:16:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "liwei (GF)" <liwei391@huawei.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf header: Fix missing PMU caps
Message-ID: <ZONjuqVhDNzWPIQ3@kernel.org>
References: <20230818171952.3719251-1-irogers@google.com>
 <b244a320-5f00-d382-a4ab-0168a80c55fe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b244a320-5f00-d382-a4ab-0168a80c55fe@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 19, 2023 at 12:16:09PM +0800, liwei (GF) escreveu:
> Hi Ian:
> 
> On 2023/8/19 1:19, Ian Rogers wrote:
> > PMU caps are written as HEADER_PMU_CAPS or for the special case of the
> > PMU "cpu" as HEADER_CPU_PMU_CAPS. As the PMU "cpu" is special, and not
> > any "core" PMU, the logic had become broken and core PMUs not called
> > "cpu" were not having their caps written. This affects ARM and s390
> > non-hybrid PMUs.
> > 
> > Simplify the PMU caps writing logic to scan one fewer time and to be
> > more explicit in its behavior.
> > 
> > Reported-by: Wei Li <liwei391@huawei.com>
> > Fixes: 178ddf3bad98 ("perf header: Avoid hybrid PMU list in write_pmu_caps")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/header.c | 31 ++++++++++++++++---------------
> >  1 file changed, 16 insertions(+), 15 deletions(-)
> > 
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index 52fbf526fe74..13c71d28e0eb 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -1605,8 +1605,15 @@ static int write_pmu_caps(struct feat_fd *ff,
> >  	int ret;
> >  
> >  	while ((pmu = perf_pmus__scan(pmu))) {
> > -		if (!pmu->name || !strcmp(pmu->name, "cpu") ||
> > -		    perf_pmu__caps_parse(pmu) <= 0)
> > +		if (!strcmp(pmu->name, "cpu")) {
> 
> So you removed the check of 'pmu->name', does this check really redundant? since
> we can find such checks in many places in the perf code. If not, i think it is
> necessary for strcmp().

Indeed, when sorting in tools/perf/util/pmus.c in cmp_sevent() we have:

        /* Order by PMU name. */
        if (as->pmu != bs->pmu) {
                a_pmu_name = a_pmu_name ?: (as->pmu->name ?: "");
                b_pmu_name = b_pmu_name ?: (bs->pmu->name ?: "");
                ret = strcmp(a_pmu_name, b_pmu_name);
                if (ret)
                        return ret;
        }


And even if in this specific case, for some reason, we could guarantee
that pmu->name isn't NULL, then removing that check should be best left
for a separate patch with an explanation as to why that is safe.

Having it as:

 	while ((pmu = perf_pmus__scan(pmu))) {
-		if (!pmu->name || !strcmp(pmu->name, "cpu") ||
-		    perf_pmu__caps_parse(pmu) <= 0)
+		if (!pmu->name || !strcmp(pmu->name, "cpu")) {

even eases a bit reviewing, as we see we're just removing that
perf_pmu__caps_parse(pmu) line.

Ian?

- Arnaldo

 
> > +			/*
> > +			 * The "cpu" PMU is special and covered by
> > +			 * HEADER_CPU_PMU_CAPS. Note, core PMUs are
> > +			 * counted/written here for ARM, s390 and Intel hybrid.
> > +			 */
> > +			continue;
> > +		}
> > +		if (perf_pmu__caps_parse(pmu) <= 0)
> >  			continue;
> >  		nr_pmu++;
> >  	}
> > @@ -1619,23 +1626,17 @@ static int write_pmu_caps(struct feat_fd *ff,
> >  		return 0;
> >  
> >  	/*
> > -	 * Write hybrid pmu caps first to maintain compatibility with
> > -	 * older perf tool.
> > +	 * Note older perf tools assume core PMUs come first, this is a property
> > +	 * of perf_pmus__scan.
> >  	 */
> > -	if (perf_pmus__num_core_pmus() > 1) {
> > -		pmu = NULL;
> > -		while ((pmu = perf_pmus__scan_core(pmu))) {
> > -			ret = __write_pmu_caps(ff, pmu, true);
> > -			if (ret < 0)
> > -				return ret;
> > -		}
> > -	}
> > -
> >  	pmu = NULL;
> >  	while ((pmu = perf_pmus__scan(pmu))) {
> > -		if (pmu->is_core || !pmu->nr_caps)
> > +		if (!strcmp(pmu->name, "cpu")) {
> 
> same here
> 
> Thanks,
> Wei
> 
> > +			/* Skip as above. */
> > +			continue;
> > +		}
> > +		if (perf_pmu__caps_parse(pmu) <= 0)
> >  			continue;
> > -
> >  		ret = __write_pmu_caps(ff, pmu, true);
> >  		if (ret < 0)
> >  			return ret;

-- 

- Arnaldo
