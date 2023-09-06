Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26457940B1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241919AbjIFPs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241875AbjIFPsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:48:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4B91981;
        Wed,  6 Sep 2023 08:48:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6142EC433C7;
        Wed,  6 Sep 2023 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694015298;
        bh=Oq6bPmBRfJhsaD10lj3/EquoCsuawRNx+URf+GvTXo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K4Vh9phBlahXj25dD9WYMH/h/vy4q2aY+D5Dewi2Mfqu1MleynLVxMwLpthq8xagg
         JVKeUrlGUKfLSW1+2AzvWpeAtu/ASQcXPg+MoVfWbYd85MkW4CfDE3ryrQcvwb8Vra
         ZX23/MKtD/6ylwdZxwlUlVCInS6VXvkhd8M4E1DOUdJnVzkSI0BXo4T/ZfNc5ZPnS+
         7a6VWygCXkj8PPXG0mukYN5J9Z5F6d4wNU2d9v4oZMSV68H1h+b+4ULiCknR0tOABg
         kMhop76vrmeSJIoFKrRxrtUrJ6Fx7qi14y2uOysG41J0G+DtXA3aket3bjvyQiP1GM
         5d4hl7foBSTjg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 07563403F4; Wed,  6 Sep 2023 12:48:15 -0300 (-03)
Date:   Wed, 6 Sep 2023 12:48:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/6] perf parse-events: Fixes relating to no_value
 terms
Message-ID: <ZPifPw4vinwRd4gO@kernel.org>
References: <20230901233949.2930562-1-irogers@google.com>
 <c4833297-da67-3337-b3d1-b628b1282a8a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4833297-da67-3337-b3d1-b628b1282a8a@arm.com>
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

Em Tue, Sep 05, 2023 at 10:39:38AM +0100, James Clark escreveu:
> 
> 
> On 02/09/2023 00:39, Ian Rogers wrote:
> > A term may have no value in which case it is assumed to have a value
> > of 1. It doesn't just apply to alias/event terms so change the
> > parse_events_term__to_strbuf assert.
> > 
> > Commit 99e7138eb789 ("perf tools: Fail on using multiple bits long
> > terms without value") made it so that no_value terms could only be for
> > a single bit. Prior to commit 64199ae4b8a3 ("perf parse-events: Fix
> > propagation of term's no_value when cloning") this missed a test case
> > where config1 had no_value.
> > 
> > Fixes: 64199ae4b8a3 ("perf parse-events: Fix propagation of term's no_value when cloning")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> For the whole set:
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks for providing it, in the future please consider replying to the
cover letter (0/6) to do that, so that b4 can collect it, doing it for
the 1st patch it will collect just for it, not for the whole set as you
intended.

- Arnaldo
 
> > ---
> >  tools/perf/tests/parse-events.c | 2 +-
> >  tools/perf/util/parse-events.c  | 2 +-
> >  tools/perf/util/parse-events.h  | 4 ++--
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> > index d86076d575ed..d47f1f871164 100644
> > --- a/tools/perf/tests/parse-events.c
> > +++ b/tools/perf/tests/parse-events.c
> > @@ -2170,7 +2170,7 @@ static const struct evlist_test test__events[] = {
> >  
> >  static const struct evlist_test test__events_pmu[] = {
> >  	{
> > -		.name  = "cpu/config=10,config1,config2=3,period=1000/u",
> > +		.name  = "cpu/config=10,config1=1,config2=3,period=1000/u",
> >  		.valid = test__pmu_cpu_valid,
> >  		.check = test__checkevent_pmu,
> >  		/* 0 */
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 68fe2c4ff49f..65608a3cba81 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -2607,7 +2607,7 @@ int parse_events_term__to_strbuf(struct list_head *term_list, struct strbuf *sb)
> >  
> >  		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
> >  			if (term->no_value) {
> > -				assert(term->type_term == PARSE_EVENTS__TERM_TYPE_USER);
> > +				assert(term->val.num == 1);
> >  				ret = strbuf_addf(sb, "%s", term->config);
> >  			} else
> >  				ret = strbuf_addf(sb, "%s=%#"PRIx64, term->config, term->val.num);
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> > index 855b0725c5d4..594e5d2dc67f 100644
> > --- a/tools/perf/util/parse-events.h
> > +++ b/tools/perf/util/parse-events.h
> > @@ -124,8 +124,8 @@ struct parse_events_term {
> >  	 */
> >  	bool weak;
> >  	/**
> > -	 * @no_value: Is there no value. TODO: this should really be part of
> > -	 * type_val.
> > +	 * @no_value: Is there no value. If a numeric term has no value then the
> > +	 * value is assumed to be 1. An event name also has no value.
> >  	 */
> >  	bool no_value;
> >  };

-- 

- Arnaldo
