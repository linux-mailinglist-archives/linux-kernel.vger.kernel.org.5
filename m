Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91A278DF18
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjH3T34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343651AbjH3Qd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:33:28 -0400
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 09:33:25 PDT
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7671E19A;
        Wed, 30 Aug 2023 09:33:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01C3EB81F78;
        Wed, 30 Aug 2023 16:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7082DC433C8;
        Wed, 30 Aug 2023 16:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693412897;
        bh=O6l21QBLZo6KklWlRfMPFmdlrVDoaMQSFkOWmpZpo8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oo+/24DE52J/L4cHBMnGhb6ybfAHAPWWFOEZNWAj2rY4HlQhOdaUIbXi3UemxSgJ3
         l/lNj20ub0XvqvYVAPbiiQKicvQJjWe7PzPrvWzrcfWaJ2nlaufpTIc4NiDl+yZ1/B
         ZcjWjprZO98DX4jNbt0wryGQAR+VdYmKcDJXftv9NO7D1/W66O22JFkGfsu7wlyF+U
         7jCrp1A3s/NK0EOsLoges6Nfhah795QfO891S8XLJSJRrWoRnQ/ONA2mRo7xTxq9pg
         lgCBucVfeN0irYAqZXF97M5CB8947IXDgRHTEfdWj10Us5uPJf0iNo85aVuL38eWjQ
         9DAZBkmPFh3Zg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7EAAB40722; Wed, 30 Aug 2023 13:28:14 -0300 (-03)
Date:   Wed, 30 Aug 2023 13:28:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        John Garry <john.g.garry@oracle.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>
Subject: Re: [PATCH v1] perf metric: Add #num_cpus_online literal
Message-ID: <ZO9uHhTeckwOE8dg@kernel.org>
References: <20230830073026.1829912-1-irogers@google.com>
 <a0b88cfe-3afe-688d-861c-a9a332f66676@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0b88cfe-3afe-688d-861c-a9a332f66676@linux.intel.com>
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

Em Wed, Aug 30, 2023 at 09:14:00AM -0400, Liang, Kan escreveu:
> 
> 
> On 2023-08-30 3:30 a.m., Ian Rogers wrote:
> > Returns the number of CPUs online, unlike #num_cpus that returns the
> > number present. Add a test of the property. This will be used in
> > future Intel metrics.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Kan
> > ---
> >  tools/perf/tests/expr.c | 5 ++++-
> >  tools/perf/util/expr.c  | 7 +++++++
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> > index c1c3fcbc2753..81229fa4f1e9 100644
> > --- a/tools/perf/tests/expr.c
> > +++ b/tools/perf/tests/expr.c
> > @@ -70,7 +70,7 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
> >  {
> >  	struct expr_id_data *val_ptr;
> >  	const char *p;
> > -	double val, num_cpus, num_cores, num_dies, num_packages;
> > +	double val, num_cpus_online, num_cpus, num_cores, num_dies, num_packages;
> >  	int ret;
> >  	struct expr_parse_ctx *ctx;
> >  	bool is_intel = false;
> > @@ -227,7 +227,10 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
> >  
> >  	/* Test toplogy constants appear well ordered. */
> >  	expr__ctx_clear(ctx);
> > +	TEST_ASSERT_VAL("#num_cpus_online",
> > +			expr__parse(&num_cpus_online, ctx, "#num_cpus_online") == 0);
> >  	TEST_ASSERT_VAL("#num_cpus", expr__parse(&num_cpus, ctx, "#num_cpus") == 0);
> > +	TEST_ASSERT_VAL("#num_cpus >= #num_cpus_online", num_cpus >= num_cpus_online);
> >  	TEST_ASSERT_VAL("#num_cores", expr__parse(&num_cores, ctx, "#num_cores") == 0);
> >  	TEST_ASSERT_VAL("#num_cpus >= #num_cores", num_cpus >= num_cores);
> >  	TEST_ASSERT_VAL("#num_dies", expr__parse(&num_dies, ctx, "#num_dies") == 0);
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index 0985a3cbc6f9..4488f306de78 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -427,6 +427,13 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
> >  		result = cpu__max_present_cpu().cpu;
> >  		goto out;
> >  	}
> > +	if (!strcmp("#num_cpus_online", literal)) {
> > +		struct perf_cpu_map *online = cpu_map__online();
> > +
> > +		if (online)
> > +			result = perf_cpu_map__nr(online);
> > +		goto out;
> > +	}
> >  
> >  	if (!strcasecmp("#system_tsc_freq", literal)) {
> >  		result = arch_get_tsc_freq();

-- 

- Arnaldo
