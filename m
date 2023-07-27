Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7213F765CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjG0UKy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Jul 2023 16:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjG0UKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:10:50 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03AF2D45
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:10:46 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-565e4741723so184160eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690488646; x=1691093446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rFdT04Ed/bMSDlBhYrmojZcF/gffIX2MHa/0nBRqcg=;
        b=XVe7i0hg+hcf2jXvqtThD0YLppUfbR03a2aRXmXE0BPo/uSB2e5J0zOCYdgVTeXr2E
         cKDgghXmID9ry3Ld/LJksphA8uXAZHae+5HALHLM9ardMPLeayCey+Bngaa882EzX2DX
         8OThwoYIrce0EGQujFh6gG51UBFrtpFFB28xVIwDUhgjxVcNvOq7BWi0+KHtg0y2OsOh
         Xp6dj4vtKOfl8z2eZq7kHrWdd+Zge4gFBgkGKYvcIR3r2nQ20Ocr2xwiYN90CgKsY3gv
         Z9PC4eQvVJkGakG/h73KQ/4x0HowHhDyu7+ODbXju2WCecNCmv2o6foB1ePnPCHPe7Bi
         AQxA==
X-Gm-Message-State: ABy/qLbIFOiwVBep756jScRBkC2USbXJFZLldtEbppJ5Obv8tslPI7n5
        ZxJ+rBF3LUT3jyPPnsXasyJMRxjQkRsggcs8Y+pvhd+x
X-Google-Smtp-Source: APBJJlFqCfe/mCKQkv+1VDo6muIRpXen035aEqHpXNyNb+N5taHE1rQlyYUwZiqtxBZsJRHYHeAwFchy8+vyF4P2/qg=
X-Received: by 2002:a4a:d8c2:0:b0:56c:5e21:c72d with SMTP id
 c2-20020a4ad8c2000000b0056c5e21c72dmr404808oov.1.1690488646145; Thu, 27 Jul
 2023 13:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAKfTPtCSsLz+qD-xUnm4N1HyZqtQD+rYVagnSur+hfUHEk0sYg@mail.gmail.com>
 <ad370ab-5694-d6e4-c888-72bdc635824@linutronix.de> <ZL2Z8InSLmI5GU9L@localhost.localdomain>
 <CAJZ5v0ib=j+DHVE1mKCZaoyZ_CHVkA9f90v8b8wSA+3TEG1kHg@mail.gmail.com>
 <8857d035-1c1a-27dd-35cf-7ff68bbf3119@linutronix.de> <CAJZ5v0gJj_xGHcABCDoX2t8aR+9kXr7fvRFF+5KBO5MJz9kFWQ@mail.gmail.com>
 <20230725222851.GC3784071@hirez.programming.kicks-ass.net>
 <CAJZ5v0gyQvPqCN8jPrJqJVNeYXkhmCOnkuNvLgdqQtcS-fgF-g@mail.gmail.com>
 <CAJZ5v0iW=kg4i1Fi_Fny=CaH_YKiGps+6KsBPcgWzS5YOk00VA@mail.gmail.com>
 <20230726161432.GW4253@hirez.programming.kicks-ass.net> <20230727075922.GA3886590@hirez.programming.kicks-ass.net>
In-Reply-To: <20230727075922.GA3886590@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Jul 2023 22:10:34 +0200
Message-ID: <CAJZ5v0jukxXtPXY71=MjZ2SySiXs3MWN1189a2e+NDUj9PBLkA@mail.gmail.com>
Subject: Re: Stopping the tick on a fully loaded system
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        g@hirez.programming.kicks-ass.net,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 9:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jul 26, 2023 at 06:14:32PM +0200, Peter Zijlstra wrote:
> > On Wed, Jul 26, 2023 at 05:53:46PM +0200, Rafael J. Wysocki wrote:
> >
> > > > > That means we don't track nearly enough data to reliably tell anything
> > > > > about disabling the tick or not. We should have at least one bucket
> > > > > beyond TICK_NSEC for this.
> > > >
> > > > Quite likely.
> > >
> > > So the reasoning here was that those additional bins would not be
> > > necessary for idle state selection, but the problem of whether or not
> > > to stop the tick is kind of separate from the idle state selection
> > > problem if the target residency values for all of the idle states are
> > > relatively short.  And so it should be addressed separately which
> > > currently it is not.  Admittedly, this is a mistake.
> >
> > Right, the C state buckets are enough to pick a state, but not to handle
> > the tick thing.
> >
> > The below hack boots on my ivb-ep with extra (disabled) states. Now let
> > me go hack up teo to make use of that.
> >
> > name          residency
> >
> > POLL          0
> > C1              1
> > C1E             80
> > C3              156
> > C6              300
> > TICK            1000
> > POST-TICK       2000
> >
>
> Ah, so last night (or rather, somewhat realy today) I realized I has the
> buckets wrong.
>
> We don't have buckets to the left, but buckets to the right, so the
> above would give:
>
> 0: [0,1)
> 1: [1,80)
> 2: [80,156)
> 3: [156,300)
> 4: [300,1000)
> 5: [1000,2000)
> 6: [2000,...)
>
> Which also means I can ditch the whole POST-TICK bucket. Let me get
> breakfast and try all this again.

Note that this is about the cases between the target residency of the
deepest enabled idle state and the tick period and from the
Anna-Maria's results it looks that's about 0,1% of the total number.
