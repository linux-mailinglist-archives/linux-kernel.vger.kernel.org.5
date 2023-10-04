Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40B37B8DA5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243752AbjJDTs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjJDTsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:48:55 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F369E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Sse1FT8iskMea2prFsvKMKPW0K3EAEwhlTA4eTCtg/A=;
  b=o/oFDitnyNO3/dV+AoPbPBfleKILMXY6CxKh37aFdNFZDv6CWrfyEzUm
   nerLTCFXUUyWI9peELzCxzLvK1/lKuqbU3TYFk9Pp/CztDdRkRSrshb10
   qfHgD8xRDbShIXQr/356r9Irft0kd8Hd4NawDhcRKfWv/l0ch+YzuG/jx
   o=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,201,1694728800"; 
   d="scan'208";a="67793029"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 21:48:50 +0200
Date:   Wed, 4 Oct 2023 21:48:49 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Ingo Molnar <mingo@kernel.org>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: EEVDF and NUMA balancing
In-Reply-To: <ZR2rrixNEjrYiaYi@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2310042144450.3108@hadrien>
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien> <20231003215159.GJ1539@noisy.programming.kicks-ass.net> <alpine.DEB.2.22.394.2310041358420.3108@hadrien> <20231004120544.GA6307@noisy.programming.kicks-ass.net> <alpine.DEB.2.22.394.2310041822170.3108@hadrien>
 <ZR2rrixNEjrYiaYi@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Oct 2023, Ingo Molnar wrote:

>
> * Julia Lawall <julia.lawall@inria.fr> wrote:
>
> >
> >
> > On Wed, 4 Oct 2023, Peter Zijlstra wrote:
> >
> > > On Wed, Oct 04, 2023 at 02:01:26PM +0200, Julia Lawall wrote:
> > > >
> > > >
> > > > On Tue, 3 Oct 2023, Peter Zijlstra wrote:
> > > >
> > > > > On Tue, Oct 03, 2023 at 10:25:08PM +0200, Julia Lawall wrote:
> > > > > > Is it expected that the commit e8f331bcc270 should have an impact on the
> > > > > > frequency of NUMA balancing?
> > > > >
> > > > > Definitely not expected. The only effect of that commit was supposed to
> > > > > be the runqueue order of tasks. I'll go stare at it in the morning --
> > > > > definitely too late for critical thinking atm.
> > > >
> > > > Maybe it's just randomly making a bad situation worse rather than directly
> > > > introduing a problem.  There is a high standard deviatind in the
> > > > performance.  Here are some results with hyperfine.  The general trends
> > > > are reproducible.
> > >
> > > OK,. I'm still busy trying to bring a 4 socket machine up-to-date...
> > > gawd I hate the boot times on those machines :/
> > >
> > > But yeah, I was thinking similar things, I really can't spot an obvious
> > > fail in that commit.
> > >
> > > I'll go have a poke once the darn machine is willing to submit :-)
> >
> > I tried a two-socket machine, but in 50 runs the problem doesn't show up.
> >
> > The commit e8f331bcc270 starts with
> >
> > -       if (sched_feat(PLACE_LAG) && cfs_rq->nr_running > 1) {
> > +       if (sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
> >
> > This seemed like a big change - cfs_rq->nr_running > 1 should be rarely
> > true in ua, while cfs_rq->nr_running should always be true.  Adding back
> > the > 1 and simply replacing the test by 0 both had no effect, though.
>
> BTW., in terms of statistical reliability, one of the biggest ...
> stochastic elements of scheduler balancing is wakeup-preemption - which
> you can turn off via:
>
>    echo NO_WAKEUP_PREEMPTION > /debug/sched/features
>
> or:
>
>    echo NO_WAKEUP_PREEMPTION > /sys/kernel/debug/sched/features
>
> If you can measure a performance regression with WAKEUP_PREEMPTION turned
> off in *both* kernels, there's likely a material change (regression) in the
> quality of NUMA load-balancing.

This is the one that is the case.  In 76cae9dbe185, which is the parent of
e8f331bcc270, there are some runtimes that are a bit slower than with
WAKEUP_PREEMPTION enabled, but e8f331bcc270 now has a lot more larger
numbers.

julia

::::::::::::::
ua.C.x_yeti-4_g76cae9dbe185_performance.json
::::::::::::::
{
  "results": [
    {
      "command": "./ua.C.x",
      "mean": 31.74652352868501,
      "stddev": 7.549670079336034,
      "median": 30.825414389609996,
      "user": 4026.9165747550005,
      "system": 10.66025179,
      "min": 21.93520805911,
      "max": 60.24540388411,
      "times": [
        29.249717538109998,
        25.16879339411,
        27.684410376109998,
        25.03525483911,
        28.33494802611,
        35.398653784109996,
        31.886805430109998,
        33.34682179411,
        35.09637591511,
        28.834901557109998,
        37.71707762411,
        50.09627815011,
        29.848774250109997,
        33.66924291011,
        25.62988106911,
        21.93520805911,
        37.52640704311,
        26.35386307811,
        23.05612102511,
        25.65851957311,
        33.62976770911,
        22.55545402511,
        35.509719604109996,
        47.88084531411,
        27.17976105411,
        34.56864677911,
        34.40073639211,
        35.77985792611,
        31.57792414811,
        60.24540388411,
        35.10386024211,
        32.36256473411,
        31.019663444109998,
        25.05048613411,
        30.631165335109998,
        25.21739748711,
        28.57051109611,
        29.122454695109997,
        31.79110048411,
        26.13556522311
      ]
    }
  ]
}
::::::::::::::
ua.C.x_yeti-4_ge8f331bcc270_performance.json
::::::::::::::
{
  "results": [
    {
      "command": "./ua.C.x",
      "mean": 45.55904025022,
      "stddev": 24.917491037841696,
      "median": 34.83258273512,
      "user": 5760.045859355001,
      "system": 10.244032225000002,
      "min": 21.96719301362,
      "max": 105.35666167362,
      "times": [
        80.22088338362,
        34.76734203462,
        32.01118466362,
        105.35666167362,
        28.23154239862,
        39.79766051762,
        26.89012012362,
        21.96719301362,
        25.05284109962,
        62.19280101062,
        84.22492245362,
        78.83791121262,
        25.67714166762,
        76.34033861162,
        27.57704435562,
        27.83207362162,
        30.93298156162,
        31.29140204262,
        38.02797884462,
        23.80228286862,
        91.19093656262,
        41.32158529962,
        36.27444925062,
        28.47759006162,
        36.42187360462,
        26.13298492862,
        32.64434456262,
        25.03750352662,
        42.02328407262,
        25.30765174962,
        37.82597961162,
        34.89782343562,
        73.64093796562,
        34.05860726262,
        78.25896451662,
        27.36415754262,
        35.27277725262,
        27.48229668562,
        85.76905357362,
        101.92650138361999
      ]
    }
  ]
}









>
> If it goes away or changes dramatically with WAKEUP_PREEMPTION off, then
> I'd pin this effect to EEVDF causing timing changes that are subtly
> shifting NUMA & SMP balancing decisions past some critical threshold that
> is detrimental to this particular workload.
>
> ( Obviously both are regressions we care about - but doing this test would
>   help categorize the nature of the regression. )
>
> Thanks,
>
> 	Ingo
>
