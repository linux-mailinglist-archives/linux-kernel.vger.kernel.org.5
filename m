Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E70D7FD6A9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbjK2MXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjK2MXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:23:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DFBD48;
        Wed, 29 Nov 2023 04:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pNYBN4X8Pb/Yx1Vd4NeSsqJHNsCvDKBkPdpgHN9QiTY=; b=c03Ofld+THOSR45IGAoDp8+pt+
        UkfL9dRdtWJkl7qb6AU+5c+x7KX6JkdgemiwCTtdFLtC8j3nqM8IVqnrXMofOelxpK29X8uF5ZtqK
        2psuTW1FBHw7w+hCAukfMR+AbdMf4DY/XhmeCl29l+MfJN1SJ1PJx8jAD2H7bBe/pj7nl2oALLxTQ
        /Wq9rmsH7ut3/zJvmxsteA+NWfhM0iTJv5+2fIYirsXNN2z3k3oqWVXNW+EmUuRGCbVR2gZ+vinsR
        mMtyscTw9AeKHR2Ata9aGOkAtE7CW4vS+gUvFOQgZD958IO8eheGXfLqbaFjb9TAuhe82KOK/eFx7
        PW7yzbiQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r8Jb8-00DNTe-4M; Wed, 29 Nov 2023 12:23:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id DAA0B30017D; Wed, 29 Nov 2023 13:23:20 +0100 (CET)
Date:   Wed, 29 Nov 2023 13:23:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     James Clark <james.clark@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] perf/x86/intel/pt: Add support for pause_resume()
Message-ID: <20231129122320.GH30650@noisy.programming.kicks-ass.net>
References: <20231123121851.10826-1-adrian.hunter@intel.com>
 <20231123121851.10826-3-adrian.hunter@intel.com>
 <c63808b2-2049-da18-f0af-5dff2bc87cd2@arm.com>
 <20231129105836.GF30650@noisy.programming.kicks-ass.net>
 <842ce784-fbd2-4667-a5f7-aaa10a1108dc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <842ce784-fbd2-4667-a5f7-aaa10a1108dc@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 01:15:43PM +0200, Adrian Hunter wrote:
> On 29/11/23 12:58, Peter Zijlstra wrote:
> > On Wed, Nov 29, 2023 at 09:53:39AM +0000, James Clark wrote:
> >> On 23/11/2023 12:18, Adrian Hunter wrote:
> > 
> >>> +static void pt_event_pause_resume(struct perf_event *event)
> >>> +{
> >>> +	if (event->aux_paused)
> >>> +		pt_config_stop(event);
> >>> +	else if (!event->hw.state)
> >>> +		pt_config_start(event);
> >>> +}
> >>
> >> It seems like having a single pause/resume callback rather than separate
> >> pause and resume ones pushes some of the event state management into the
> >> individual drivers and would be prone to code duplication and divergent
> >> behavior.
> >>
> >> Would it be possible to move the conditions from here into the core code
> >> and call separate functions instead?
> >>
> >>> +
> >>>  static void pt_event_start(struct perf_event *event, int mode)
> >>>  {
> >>>  	struct hw_perf_event *hwc = &event->hw;
> >>> @@ -1798,6 +1809,7 @@ static __init int pt_init(void)
> >>>  	pt_pmu.pmu.del			 = pt_event_del;
> >>>  	pt_pmu.pmu.start		 = pt_event_start;
> >>>  	pt_pmu.pmu.stop			 = pt_event_stop;
> >>> +	pt_pmu.pmu.pause_resume		 = pt_event_pause_resume;
> >>
> >> The general idea seems ok to me. Is there a reason to not use the
> >> existing start() stop() callbacks, rather than adding a new one?
> >>
> >> I assume it's intended to be something like an optimisation where you
> >> can turn it on and off without having to do the full setup, teardown and
> >> emit an AUX record because you know the process being traced never gets
> >> switched out?
> > 
> > So the actual scheduling uses ->add() / ->del(), the ->start() /
> > ->stop() methods are something that can be used after ->add() and before
> > ->del() to 'temporarily' pause things.
> > 
> > Pretty much exactly what is required here I think. We currently use this
> > for PMI throttling and adaptive frequency stuff, but there is no reason
> > it could not also be used for this.
> > 
> > As is, we don't track the paused state across ->del() / ->add(), but
> > perhaps that can be fixed. We can easily add more PERF_EF_ / PERF_HES_
> > bits to manage things.
> > 
> > 
> 
> I am not sure stop / start play nice with NMI's from other events e.g.
> 
> PMC NMI wants to pause or resume AUX but what if AUX event is currently
> being processed in ->stop() or ->start()?  Or maybe that can't happen?

I think that can happen, and pt_event_stop() can actually handle some of
that, while your pause_resume() thing, which uses pt_config_stop() does
not.

But yes, I think that if you add pt_event_{stop,start}() calls from
*other* events their PMI, then you get to deal with more 'fun'.

Something like:

  perf_addr_filters_adjust()
    __perf_addr_filters_adjust()
      perf_event_stop()
        __perf_event_stop()
	  event->pmu->stop()
	  <NMI>
	    ...
	    perf_event_overflow()
	      pt_event->pmu->stop()
	  </NMI>
	  event->pmu->start() // whoopsie!

Should now be possible.

I think what you want to do is rename pt->handle_nmi into pt->stop_count
and make it a counter, then ->stop() increments it, and ->start()
decrements it and everybody ensures the thing doesn't get restart while
!0 etc..

I suspect you need to guard the generic part of this feature with a new
PERF_PMU_CAP_ flag and then have the coresight/etc. people opt-in once
they've audited things.

James, does that work for you?

