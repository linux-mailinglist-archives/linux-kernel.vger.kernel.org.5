Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CAE77637A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjHIPMP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Aug 2023 11:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjHIPMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:12:13 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B4E210A;
        Wed,  9 Aug 2023 08:12:11 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6874a386ec7so1297019b3a.1;
        Wed, 09 Aug 2023 08:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691593930; x=1692198730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgsj/seu3r4HTFrWkxtLjpgCvQlOKd3EjuoZhWDNEUk=;
        b=iacHD1SCsLZdufm6qvGnJlcNDdfuZTgeQE0u4gTInPdIETUgJM+EYJq+O5yS1TZ7eZ
         bg0krBhzaKkLE9NiZVUdRgUPPgalkEjCo91mutqWdTQXJlFJAG9dKeWUYsoQ7efLyK6O
         WlbPszn8kngpzZ+Ij/G3bDOalrIJuFvAkWcMMwN553Xzo+huXlePJy1sSNQWxbaJivYe
         G94fUKbn/V19YTJa8gCeUtiS68VZqZWeEgqC19w8Jh3FH7/scWK8wGlUCiB3IZ3Uk4I7
         G00By2Kxyq7mc6GyjSlbxh2gy5LY/6F0EIIbnTa7h4+e/i/TpF8UcB9ZXNLczjT99Gzl
         YG0w==
X-Gm-Message-State: AOJu0YxO9fbdX6HebyDNV2R4D6peABXl49cOG54Ii8db6attxV7aID3d
        SXycK3XfAuHonq6uSKNVmLa4O0tUQnJOQUmhj9w=
X-Google-Smtp-Source: AGHT+IERHz78XVdGnNMPp/DyI0+M05NPJEcfYevRhupZqfPKgwSpKl0HQkNJwO1w3oAUubi7iQIlwp5hEP/pG8KwVig=
X-Received: by 2002:a17:90a:764c:b0:25c:1ad3:a4a1 with SMTP id
 s12-20020a17090a764c00b0025c1ad3a4a1mr2624607pjl.1.1691593930332; Wed, 09 Aug
 2023 08:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <5712331.DvuYhMxLoT@kreacher> <CAJZ5v0jTG-oqV+misnP-=W5aq0S9X631kW9EhKNEn1VJQqwL2g@mail.gmail.com>
 <e3dc9417-626d-bae2-c016-36e14914c9b8@linutronix.de> <CAJZ5v0jX1_yTG6CxnPNVEMf8mMEKc33jpoWoHkreMDZLPK8UcA@mail.gmail.com>
 <4c3ac295-41e-8644-4eed-2e5bcdaf302c@linutronix.de>
In-Reply-To: <4c3ac295-41e-8644-4eed-2e5bcdaf302c@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Aug 2023 17:11:58 +0200
Message-ID: <CAJZ5v0iDkUF+hkS-f+9_ZvahOMnEZi3nvGoE4ytfRwHg9vw=cw@mail.gmail.com>
Subject: Re: [RFT][PATCH v2 0/3] cpuidle: teo: Do not check timers
 unconditionally every time
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
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

On Wed, Aug 9, 2023 at 5:10 PM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> On Mon, 7 Aug 2023, Rafael J. Wysocki wrote:
>
> > On Mon, Aug 7, 2023 at 5:38 PM Anna-Maria Behnsen
> > <anna-maria@linutronix.de> wrote:
> > >
> > > On Thu, 3 Aug 2023, Rafael J. Wysocki wrote:
> > >
> > > > On Thu, Aug 3, 2023 at 11:12 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > >
> > > > > Hi Folks,
> > > > >
> > > > > This is the second iteration of:
> > > > >
> > > > > https://lore.kernel.org/linux-pm/4511619.LvFx2qVVIh@kreacher/
> > > > >
> > > > > with an additional patch.
> > > > >
> > > > > There are some small modifications of patch [1/3] and the new
> > > > > patch causes governor statistics to play a role in deciding whether
> > > > > or not to stop the scheduler tick.
> > > > >
> > > > > Testing would be much appreciated!
> > > >
> > > > For convenience, this series is now available in the following git branch:
> > > >
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > > >  pm-cpuidle-teo
> > > >
> > >
> > > Gauthams tests and the distribution of idle time durations looks pretty
> > > good. Also the prevention of calling tick_nohz_get_sleep_length() is very
> > > nice (21477 calls of tick_nohz_next_event() and the tick was stopped 2670
> > > times).
> > >
> > > Here is the deviation of idle time durations (based on your branch):
> > >
> > > Idle Total              2670    100.00%
> > > x >= 4ms                2537    95.02%
> > > 4ms> x >= 2ms           19      0.71%
> > > 2ms > x >= 1ms          10      0.37%
> > > 1ms > x >= 500us        7       0.26%
> > > 500us > x >= 250us      6       0.22%
> > > 250us > x >=100us       13      0.49%
> > > 100us > x >= 50us       17      0.64%
> > > 50us > x >= 25us        25      0.94%
> > > 25us > x >= 10us        22      0.82%
> > > 10us > x > 5us          9       0.34%
> > > 5us > x                 5       0.19%
> >
> > Thanks a lot for the data!
> >
> > Can I add a Tested-by: tag from you to this series?
> >
>
> Sure - sorry for the delay!

No worries, thanks!
