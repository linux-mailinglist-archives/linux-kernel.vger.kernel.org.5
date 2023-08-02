Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7635376CD5A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbjHBMp4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Aug 2023 08:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjHBMpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:45:53 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0BE2D4C;
        Wed,  2 Aug 2023 05:45:30 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1bb6334fec5so797391fac.1;
        Wed, 02 Aug 2023 05:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690980285; x=1691585085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=at867tJckf1nQORNLj4OAwSlXms8YsyeqcRBXqkAs8A=;
        b=Yvk/lIRGkmSm2qtgbWipMTFeQKe0S5WXsxVjmi7UrfG0AtpWJV//WOa2m1Ss2CuEs1
         iife9vHWcSDeZLdhfBuorf12gmJAKrMZkYE+apn+7p83ZYwc3h52e8YSn2LQyA63eXca
         d4YJaLWSjK0+x1o8LXoXpiTgE2tXP4RfaelKNST5qDGN8HlsoPcMIDQBjeF6fzif6mWF
         xUeMtvfJZuwMgnJSVuLnSatW4TY87XeZ33I32p9J7vL/dXq6ZUBbb7uMZdLU7aLa8OQz
         1YAMMoCG6bNyK+S3qJNi8GlSuVAQ8VCOlyLVaDB43JY/kUhwc1HFFcLFj4JhyCLuyMiD
         RFYg==
X-Gm-Message-State: ABy/qLZOMnp/XnwnQnF5yvxiW8mEMLqxSdti6DVVCB2aQ613wE6zPoAI
        AGncyv7iIwZ5Wm+L1N9SreQ/BLPNeGvzOtF5uPU=
X-Google-Smtp-Source: APBJJlHrX8CZBRaQSwN8AGSMWlTg21y9BjLbat0wsMulksa1y+4QVEwR8wkHsQPwwckRN/BKrCMGaC0wh63srUFWIwQ=
X-Received: by 2002:a05:6870:231d:b0:1a7:f79c:2fbc with SMTP id
 w29-20020a056870231d00b001a7f79c2fbcmr11997663oao.0.1690980285231; Wed, 02
 Aug 2023 05:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230728145515.990749537@infradead.org> <20230728145808.835742568@infradead.org>
 <CAJZ5v0gNqEuqvV0RtrXiDDGtvKB2hronLwAU8jnmuGppKmyDxA@mail.gmail.com>
 <20230729084417.GB3945851@hirez.programming.kicks-ass.net>
 <CAJZ5v0iVKRY5-YvQmMbZ3+eZNHJgXt=CoYedNueAJyT9+Ld5Dg@mail.gmail.com>
 <20230731090935.GB29590@hirez.programming.kicks-ass.net> <CAJZ5v0jh5oozZm7OvN9j1iHtzYQzPMOJ=Nt0HaJKYyJ218Cezw@mail.gmail.com>
 <20230731113850.GE29590@hirez.programming.kicks-ass.net> <CAJZ5v0h+KC+uMiOE4m4Dp4=iHMkekutk+B+cwb0de8Fvswv6jA@mail.gmail.com>
 <20230802103426.GB210177@hirez.programming.kicks-ass.net>
In-Reply-To: <20230802103426.GB210177@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Aug 2023 14:44:33 +0200
Message-ID: <CAJZ5v0gMrUBqtWfuN4DJwXYY5kM+kikWHiep=p-8Jz3yEO0hfQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/3] cpuidle: Inject tick boundary state
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, anna-maria@linutronix.de,
        tglx@linutronix.de, frederic@kernel.org, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 12:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 31, 2023 at 06:55:35PM +0200, Rafael J. Wysocki wrote:
>
> > > In that case you cannot tell the difference between I'm good to use this
> > > state and I'm good to disable the tick and still use this state.
> >
> > No, you don't, but is it really worth the fuss?
>
> My somewhat aged IVB-EP sits around 25 us for restarting the tick.
>
> Depending on the C state, that is a significant chunk of exit latency,
> and depending on how often you do the whole NOHZ dance, this can add up
> to significant lost runtime too.
>
> And these are all machines that have a usable TSC, these numbers all go
> up significantly when you somehow end up on the HPET or similar wreckage.
>
> Stopping the tick is slightly more expensive, but in the same order, I
> get around 30 us on the IVB, vs 25 for restarting it. Reprogramming the
> timer (LAPIC/TSC-DEADLINE) is the main chunk of it I suspect.
>
> So over-all that's 55 us extra latency for the full idle path, which can
> definitely hurt.
>
> So yeah, I would say this is all worth it.

I agree that, in general, it is good to avoid stopping the tick when
it is not necessary to stop it.

> My ADL is somewhat better, but also much higher clocked, and gets around
> 10 us for a big core and 16 us for a little core for restarting the
> tick.

But my overall point is different.

An additional bin would possibly help if the deepest state has been
selected and its target residency is below the tick, and the closest
timer (other than the tick) is beyond the tick.  So how much of a
difference would be made by making this particular case more accurate?
