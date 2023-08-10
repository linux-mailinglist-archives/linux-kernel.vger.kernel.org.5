Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DCB77715C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjHJH1o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Aug 2023 03:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjHJH1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:27:38 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDDE211C;
        Thu, 10 Aug 2023 00:27:38 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1a2dd615ddcso151710fac.0;
        Thu, 10 Aug 2023 00:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691652457; x=1692257257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UF3+Rv4v3m/glAdW5N2ipCZFkStwyAxw0qUvah2jehU=;
        b=a1b3HwZVb+9k9c20zOBYWnDkuM6TpWfdzteN+VVxKEz3pnO4OmMDDtNORWD0gQckDO
         ZUQBh1YtAtLMQhnxDajSrtVSS9QPx5sknHcWigOdjM++KmRUQlHn0PrLRHyXwpBCzQMJ
         BubKnDpsMmfF6TVv/uFwN29p//WRc3DL5fS6EWNt1kkF5p96Mh8hYWB68yQsQ3yU5xLe
         VtQmLtNp1tjhfZGkpA0EV1b7L+1+SuR3r6JgSlP5gU7/zpUA8a5pMvy3lFfWE1mXPRxL
         wd5/nxTjezcFGEADT2Qm8Bmphb4sj5oO3VUSV2cY12bmkoqiu/vWb0jjyhS62neYO3cs
         c2HQ==
X-Gm-Message-State: AOJu0Ywkl8L1mDLwATSO3xuIOpSintkI5Op4oWYKzr33/VZiV3w4t4YA
        AmCb3DmicfXdcwewOJ+i8qVvq+4+D3OGgwUue5hJLW2t
X-Google-Smtp-Source: AGHT+IEoEfRUBPO0nmLbMedEszSQXyCldieWh4a5dDIgPsgxyj79E1w2/6cFPzdpYMIObRou9MynWMVz1Os2GwvqXlU=
X-Received: by 2002:a4a:d999:0:b0:563:3b56:5dc1 with SMTP id
 k25-20020a4ad999000000b005633b565dc1mr1348378oou.0.1691652457313; Thu, 10 Aug
 2023 00:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <5712331.DvuYhMxLoT@kreacher> <CAJZ5v0jTG-oqV+misnP-=W5aq0S9X631kW9EhKNEn1VJQqwL2g@mail.gmail.com>
 <002201d9ca0c$27606f70$76214e50$@telus.net> <CAJZ5v0gYsH9EKgCO_LESuvd0dcOJLgPrWeN=6V-bY4gq-w1oyA@mail.gmail.com>
 <CAAYoRsWfMTX_ifNG5w9LS50OcPx87yJHg_PSvROoQJJ605eJEA@mail.gmail.com> <CAAYoRsUSu-1-maYVTDh1oLWtaGa2cBTjKbEZvm08DSMhK+Nc8Q@mail.gmail.com>
In-Reply-To: <CAAYoRsUSu-1-maYVTDh1oLWtaGa2cBTjKbEZvm08DSMhK+Nc8Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Aug 2023 09:27:25 +0200
Message-ID: <CAJZ5v0jTqX3K10XtquzEfS8TxV4y0tLEnhbUF4Ti3Y7fQ6tW2w@mail.gmail.com>
Subject: Re: [RFT][PATCH v2 0/3] cpuidle: teo: Do not check timers
 unconditionally every time
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Thu, Aug 10, 2023 at 3:08 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Rafael,
>
> Please bear with me. As you know I have many tests
> that search over a wide range of operating conditions
> looking for areas to focus on in more detail.
>
> On Tue, Aug 8, 2023 at 3:40 PM Doug Smythies <dsmythies@telus.net> wrote:
> > On Tue, Aug 8, 2023 at 9:43 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Tue, Aug 8, 2023 at 5:22 PM Doug Smythies <dsmythies@telus.net> wrote:
> > > > On 2023.08.03 14:33 Rafael wrote:
> > > > > On Thu, Aug 3, 2023 at 11:12 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > >>
> > > > >> Hi Folks,
> > > > >>
> > > > >> This is the second iteration of:
> > > > >>
> > > > >> https://lore.kernel.org/linux-pm/4511619.LvFx2qVVIh@kreacher/
> > > > >>
> > > > >> with an additional patch.
> > > > >>
> > > > >> There are some small modifications of patch [1/3] and the new
> > > > >> patch causes governor statistics to play a role in deciding whether
> > > > >> or not to stop the scheduler tick.
> > > > >>
> > > > >> Testing would be much appreciated!
> > > > >
> > > > > For convenience, this series is now available in the following git branch:
> > > > >
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > > > > pm-cpuidle-teo
> > > >
> > > > Hi Rafael,
> > > >
> > > > Thank you for the git branch link.
> > > >
> > > > I did some testing:
> >
> >
> > ... deleted ...
> >
> > > > Test 2: 6 core ping pong sweep:
> > > >
> > > > Pass a token between 6 CPUs on 6 different cores.
> > > > Do a variable amount of work at each stop.
> > > >
> > > > Purpose: To utilize the midrange idle states
> > > > and observe the transitions from between use of
> > > > idle states.
> > > >
> > > > Results: There is some instability in the results
> > > > in the early stages.
> > > > For unknown reasons, the rjw governor sometimes works
> > > > slower and at lower power. The condition is not 100%
> > > > repeatable.
> > > >
> > > > Overall teo completed the test fastest (54.9 minutes)
> > > > Followed by menu (56.2 minutes), then rjw (56.7 minutes),
> > > > then ladder (58.4 minutes). teo is faster throughout the
> > > > latter stages of the test, but at the cost of more power.
> > > > The differences seem to be in the transition from idle
> > > > state 1 to idle state 2 usage.
> >
> > the magnitude of the later stages differences are significant.
> >
> > ... deleted ...
> >
> > > Thanks a lot for doing this work, much appreciated!
> > >
> > > > Conclusions: Overall, I am not seeing a compelling reason to
> > > > proceed with this patch set.
> > >
> > > On the other hand, if there is a separate compelling reason to do
> > > that, it doesn't appear to lead to a major regression.
> >
> > Agreed.
> >
> > Just for additional information, a 6 core dwell test was run.
> > The test conditions were cherry picked for dramatic effect:
> >
> > teo: average: 1162.13 uSec/loop ; Std dev: 0.38
> > ryw: average: 1266.45 uSec/loop ; Std dev: 6.53 ; +9%
> >
> > teo: average: 29.98 watts
> > rjw: average: 30.30 watts
> > (the same within thermal experimental error)
> >
> > Details (power and idle stats over the 45 minute test period):
> > http://smythies.com/~doug/linux/idle/teo-util2/6-13568-147097/perf/
>
> Okay, so while differences in the sometimes selection of a deeper
> idle state might be detrimental to latency sensitive workflow such as
> above, it is an overwhelming benefit to periodic workflows:
>
> Test 8: low load periodic workflow.
>
> There is an enormous range of work/sleep frequencies and loads
> to pick from. There was no cherry picking for this test.
>
> The only criteria is that the periodic fixed packet of work is
> completed before the start of the next period.
>
> Test 8 A: 1 load at about 3% and 347 Hz work/sleep frequency:
> teo average processor package power: 16.38 watts
> rjw average processor package power: 4.29 watts
> or 73.8% improvement!!!!!
>
> Test 8 B: 2 loads at about 3% and 347 Hz work/sleep frequency:
> teo average processor package power: 18.35 watts
> rjw average processor package power: 6.67 watts
> or 63.7% improvement!!!!!

This is very interesting, thank you!
