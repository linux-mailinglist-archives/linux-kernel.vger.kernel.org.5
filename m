Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FAB7E2F42
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjKFVw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjKFVw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:52:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B0510C6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:52:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C771FC433C8;
        Mon,  6 Nov 2023 21:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699307574;
        bh=PsotStaK9ZAaZtI+skUP3rL8VxWaOePc9RUMFsnrGS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJylrAxpy0sU4J8JhAemtAOyYhOTnWa2/iAUE2uovc3xI/eZpmi4pD0YZAcjvGiTt
         5ClRpcsbZgJpDzH2RVPWe8ETq70HjvLBBZur/saSsxSiBjHRvBQ6SCUttOnpz1uKD+
         NH2zkmeXusQPH8z+c4nUdNJ/h72XjBUdQZd3vk0StWadNwNnMjEN/yls2WldcDWDsX
         tX7+SEWoqmQS4/jtDBkCKRnbU6mCbmTXsyqf5ezbApx9hHkNwBi8rtEOuEDbNyNeXd
         UXI5LzpNKObwj7/4tyuGIVcgtfKEdxgV/LohsXcl0KRiv9fTa9IaZOVSxqYObkOESC
         iv5DdmuOlkUCw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 269264035D; Mon,  6 Nov 2023 18:52:51 -0300 (-03)
Date:   Mon, 6 Nov 2023 18:52:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf auxtrace: Add 'T' itrace option for
 timestamp trace
Message-ID: <ZUlgM8pgf19UeyM9@kernel.org>
References: <20231014074513.1668000-1-leo.yan@linaro.org>
 <20231014074513.1668000-2-leo.yan@linaro.org>
 <8a2ea58f-f835-4d1a-8bd6-3a63b3b0db94@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a2ea58f-f835-4d1a-8bd6-3a63b3b0db94@intel.com>
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

Em Thu, Oct 19, 2023 at 01:47:15PM +0300, Adrian Hunter escreveu:
> On 14/10/23 10:45, Leo Yan wrote:
> > An AUX trace can contain timestamp, but in some situations, the hardware
> > trace module (e.g. Arm CoreSight) cannot decide the traced timestamp is
> > the same source with CPU's time, thus the decoder can not use the
> > timestamp trace for samples.
> > 
> > This patch introduces 'T' itrace option. If users know the platforms
> 
> "If users know" <- how would users know?  Could the kernel
> or tools also figure it out?

Adrian, I'm trying to go all the outstanding patches, do you still have
any issues with this series?

- Arnaldo
 
> > they are working on have the same time counter with CPUs, users can
> > use this new option to tell a decoder for using timestamp trace as
> > kernel time.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/Documentation/itrace.txt | 1 +
> >  tools/perf/util/auxtrace.c          | 3 +++
> >  tools/perf/util/auxtrace.h          | 3 +++
> >  3 files changed, 7 insertions(+)
> > 
> > diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
> > index a97f95825b14..19cc179be9a7 100644
> > --- a/tools/perf/Documentation/itrace.txt
> > +++ b/tools/perf/Documentation/itrace.txt
> > @@ -25,6 +25,7 @@
> >  		q	quicker (less detailed) decoding
> >  		A	approximate IPC
> >  		Z	prefer to ignore timestamps (so-called "timeless" decoding)
> > +		T	use the timestamp trace as kernel time
> >  
> >  	The default is all events i.e. the same as --itrace=iybxwpe,
> >  	except for perf script where it is --itrace=ce
> > diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> > index a0368202a746..f528c4364d23 100644
> > --- a/tools/perf/util/auxtrace.c
> > +++ b/tools/perf/util/auxtrace.c
> > @@ -1638,6 +1638,9 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
> >  		case 'Z':
> >  			synth_opts->timeless_decoding = true;
> >  			break;
> > +		case 'T':
> > +			synth_opts->use_timestamp = true;
> > +			break;
> >  		case ' ':
> >  		case ',':
> >  			break;
> > diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> > index 29eb82dff574..55702215a82d 100644
> > --- a/tools/perf/util/auxtrace.h
> > +++ b/tools/perf/util/auxtrace.h
> > @@ -99,6 +99,7 @@ enum itrace_period_type {
> >   * @remote_access: whether to synthesize remote access events
> >   * @mem: whether to synthesize memory events
> >   * @timeless_decoding: prefer "timeless" decoding i.e. ignore timestamps
> > + * @use_timestamp: use the timestamp trace as kernel time
> >   * @vm_time_correlation: perform VM Time Correlation
> >   * @vm_tm_corr_dry_run: VM Time Correlation dry-run
> >   * @vm_tm_corr_args:  VM Time Correlation implementation-specific arguments
> > @@ -146,6 +147,7 @@ struct itrace_synth_opts {
> >  	bool			remote_access;
> >  	bool			mem;
> >  	bool			timeless_decoding;
> > +	bool			use_timestamp;
> >  	bool			vm_time_correlation;
> >  	bool			vm_tm_corr_dry_run;
> >  	char			*vm_tm_corr_args;
> > @@ -678,6 +680,7 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
> >  "				q:			quicker (less detailed) decoding\n" \
> >  "				A:			approximate IPC\n" \
> >  "				Z:			prefer to ignore timestamps (so-called \"timeless\" decoding)\n" \
> > +"				T:			use the timestamp trace as kernel time\n" \
> >  "				PERIOD[ns|us|ms|i|t]:   specify period to sample stream\n" \
> >  "				concatenate multiple options. Default is iybxwpe or cewp\n"
> >  
> 

-- 

- Arnaldo
