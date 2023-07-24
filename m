Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B72B75FC5F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjGXQlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjGXQls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:41:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3096C10D3;
        Mon, 24 Jul 2023 09:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 783336127C;
        Mon, 24 Jul 2023 16:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0FAC433C9;
        Mon, 24 Jul 2023 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690216904;
        bh=slY2K6qUOwPVZDMW1XxpN8Wk8aylahbaAaTLXnyOJ6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s6eYP1XzTniWCT9wWlRFkQ/ubGlokLLoGu1+cHpeAzSMZPl8+SKFaI+FiqCxP8hEs
         O1ZuNLGqlqTTPoREWhELqmcTt9JH4couhmX2cXVPOhgwzSiOZPxM2kPMnR4nEHYo2c
         YIrsu1oehctcBzhBfrhdFDtjv7yfr8fZjY4y97TSRJRnBN0ZgkOgSdIYzL6LA0vG+m
         4lRylbMPK1GnwVGTEFsjFyDhvOZ8e3zuPnr2+f3AmPwcNp4vUa/W0e1HSa4cNOKsf1
         GIgFXIqqT50ipBGJSUktQgLfXD2r169xCOYQaIbWWS1GPgB28ZbmFMWmbyu3E3EHwq
         kSfH3MB5Vcfdg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C73F240516; Mon, 24 Jul 2023 13:41:41 -0300 (-03)
Date:   Mon, 24 Jul 2023 13:41:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf arm64: Fix read PMU cpu slots
Message-ID: <ZL6pxZ4RmMC2W7S+@kernel.org>
References: <ZL4G7rWXkfv-Ectq@B-Q60VQ05P-2326.local>
 <2e392aa9-859a-75ef-eb3e-1870b1e78061@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e392aa9-859a-75ef-eb3e-1870b1e78061@linux.alibaba.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 24, 2023 at 03:40:12PM +0800, Jing Zhang escreveu:
> 
> 
> 在 2023/7/24 下午1:06, Haixin Yu 写道:
> > Commit f8ad6018ce3c ("perf pmu: Remove duplication around
> >  EVENT_SOURCE_DEVICE_PATH") uses sysfs__read_ull to read a full
> > sysfs path, which will never success. Fix it by read file directly.
> > 
> > Signed-off-by: Haixin Yu <yuhaixin.yhx@linux.alibaba.com>
> > ---
> >  tools/perf/arch/arm64/util/pmu.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
> > index 561de0cb6b95..512a8f13c4de 100644
> > --- a/tools/perf/arch/arm64/util/pmu.c
> > +++ b/tools/perf/arch/arm64/util/pmu.c
> > @@ -54,10 +54,11 @@ double perf_pmu__cpu_slots_per_cycle(void)
> >  		perf_pmu__pathname_scnprintf(path, sizeof(path),
> >  					     pmu->name, "caps/slots");
> >  		/*
> > -		 * The value of slots is not greater than 32 bits, but sysfs__read_int
> > -		 * can't read value with 0x prefix, so use sysfs__read_ull instead.
> > +		 * The value of slots is not greater than 32 bits, but
> > +		 * filename__read_int can't read value with 0x prefix,
> > +		 * so use filename__read_ull instead.
> >  		 */
> > -		sysfs__read_ull(path, &slots);
> > +		filename__read_ull(path, &slots);
> >  	}
> >  
> >  	return slots ? (double)slots : NAN;
> 
> Yes, the function perf_pmu__pathname_scnprintf returns the complete slots file path "/sys/bus/xxxxx/caps/slots",
> and sysfs__read_ull will add the prefix "/sys" to the path, so the final file path becomes "/sys/sys/bus/xxxx/caps/slots"
> which does not exist, and the slots file cannot be successfully read, so sysfs__read_ull needs to be changed to the
> filename__read_ull.
> 
> I tested it and it works well.
> 
> Tested-by: Jing Zhang <renyu.zj@linux.alibaba.com>

I've applied this to my local branch, thanks.

I also added the missing:

Fixes: f8ad6018ce3c065a ("perf pmu: Remove duplication around EVENT_SOURCE_DEVICE_PATH")

This is another case where a 'perf test' entry would come in handy.

James, please check and ack,

- Arnaldo
