Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF47D7F68C9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 23:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjKWVts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 16:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWVtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 16:49:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52090D62
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 13:49:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844DCC433C7;
        Thu, 23 Nov 2023 21:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700776192;
        bh=ChruaeO872rftytl509GOtmQz0j11PGUCH8A/6iytsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPvW/UXmQAkbjpaCxOG4Pi2qMzTjyn9qSa5VYZ1sNPcssByNblU9o9LLcvT1yIt8g
         xqAdKGHTdo40MqRWSj0y2cOrU3Sk80EkPVIZMXOSBezR7cKDb6bIqK8giI+E3VFnQo
         Ju+DyMGeSXYEN2KMQMXQyH7cgyduWHsv83UHTv19RsChb8iQVkFFZzGKSS1eIiV/kg
         c3aYogpMsqqcHg/+Fj6yZ08wCKdgp/fExbpAIVp4yrPZT0K3j5BnSPt1sZnIXD1Oa4
         C3xBPcov+lyzaM2uHhr4TInpO8dFmkPwi/icoWZw9/G3YbGqb0uLxMnuDyHOMjdeEU
         jvp28jEodMVsA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AED2840094; Thu, 23 Nov 2023 18:49:49 -0300 (-03)
Date:   Thu, 23 Nov 2023 18:49:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v1] perf parse-events: Make legacy events lower
 priority than sysfs/json
Message-ID: <ZV/I/Trfz7StsLsf@kernel.org>
References: <20231123042922.834425-1-irogers@google.com>
 <ZV9jq1C0TUh8MbeU@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fV3_UamHcGusUVyo23OW6tRnmSc_tohuDf1KTf4F_os1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV3_UamHcGusUVyo23OW6tRnmSc_tohuDf1KTf4F_os1g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 23, 2023 at 07:18:57AM -0800, Ian Rogers escreveu:
> On Thu, Nov 23, 2023 at 6:37 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Nov 22, 2023 at 08:29:22PM -0800, Ian Rogers wrote:
> > > This is a large behavioral change:
> > > 1) the scope of the change means it should bake on linux-next and I
> > > don't believe should be a 6.7-rc fix.

> > I'm happy for this to bake, but I do think it needs to be backported for the
> > sake of users, especially given that it *restores* the old behaviour.

> It is going to change the behavior for a far larger set of users. I'm
> also concerned that:

> ```
> $ perf list
> ...
>   cpu-cycles OR cpu/cpu-cycles/                      [Kernel PMU event]
> ...
> ```

> implies that cpu/cpu-cycles/ is a synonym for cpu-cycles, which is no
> longer true (or pick another event from sysfs whose name is the same
> as a legacy event). I'm not sure what a fix in perf list for this
> would look like.

It is a mess, indeed, cpu-cycles should be equivalent to
cpu/cpu-cycles/, map to the same HW PMU counter.

But by now I think we need to just reword the output of perf list to not
equate those events, and instead provide a more informative output, if
that is at all possible.

Something like:

Legacy events:

cpu-cycles: some nice explanation about the intent for this one (Ingo's
probably).

And then:

PMU events: (and this is even less clear :-()

cpu/cpu-cycles/: other nice explanation about the intent for this one,
if different, on this arch, for the "legacy" cpu-cycles one.

The original intent, that I called "Ingo's" was to try to somehow
generalize some concepts (CPU cycles, for instante) so that we could get
a rough idea that would allow us to somehow compare results using the
tools over different architectures (and micro-arches, etc).

I think that with these generic names we're now in damage control mode:
what matters is to keep what people got used to to continue to hold. And
that is what I think is the main argument here.

And I really think we should just head people like Hector (perf power
users) and provide a way to aggregate "cycles" over all cores, probably
not in the default output, but in a really simple way, as he seems to
want that and I would'n t be surprised that that may be something useful
after all 8-).

So back to checking why this patch isn't working in some of the
container arches I test this whole shebang, sigh.

- Arnaldo
