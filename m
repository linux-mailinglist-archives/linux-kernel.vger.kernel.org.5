Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC457C58DA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjJKQHi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Oct 2023 12:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjJKQHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:07:36 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E3C9D;
        Wed, 11 Oct 2023 09:07:33 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-57c0775d4fcso942eaf.0;
        Wed, 11 Oct 2023 09:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697040452; x=1697645252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpx2iMJcMAx/Jfpz+noMvSlj0roFwY4oLZzvU5pnyxM=;
        b=HX+K8Hjok0VBM/Z1hgwXzh7o73Wl4dBbIt40Az3EzIslezkqn/Hb+96HPAYzTGQrir
         343uCZ7aCJnZD4MFK8y/Ii8dL+tH4m5XZzttrVdj5R0jEEtUwvmaSUx1FXwWz2hSQeB/
         Ih8U+970gKouYA9CX4N5anvbq/NoduMefnLy/EKxxO7ROZPNiqkB5KU0ogzYx1+8hmUj
         VcDbC588761pfNUNQyaiM7hWE7tXDOxgYAlrvEwTrGLJ853U2yju1r11QBB9CkSqp97P
         IyinqKNYZN7zx61vLv8kVUth3bF8j4R11/CnXUOKhv9awHn4BJUNjKgNZP4fMl/pST9R
         Vw2A==
X-Gm-Message-State: AOJu0YxDgreQB2NT7YNxJ4aRzypCUQAEgOPkvjTi5iOQGA7vpHL4bQ4j
        K/kA6ykjOlXM/XP1IGAPCTkCiMuZskH4Muyj+Pi+Hxnk
X-Google-Smtp-Source: AGHT+IEW4IVmIZWZ9yVYnPskAwGoAICrJC9XLLzLZwnDdOUwFUvY50Hj7ivSMdTejxJOWyxo9ghCNv1pdNrdYtV62/c=
X-Received: by 2002:a4a:de08:0:b0:56e:94ed:c098 with SMTP id
 y8-20020a4ade08000000b0056e94edc098mr20226212oot.0.1697040452515; Wed, 11 Oct
 2023 09:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230925081139.1305766-1-lukasz.luba@arm.com> <20230925081139.1305766-11-lukasz.luba@arm.com>
 <CAJZ5v0g6jPr3LqTuRfwUWsK4em7F1pfsZDn9pVziyu3tV56m8A@mail.gmail.com>
 <f7a6da56-93e4-0b7c-1746-bc3357bf8163@arm.com> <CAJZ5v0hBPD8cHJe-Xa8354SE5jdM1bYw94DjG-MVHsRKrUY=gQ@mail.gmail.com>
 <57078a6b-83bc-d558-1071-be23d213a56f@arm.com> <666857b9-729d-7af3-5d9a-9d9e4c0a68e2@arm.com>
 <CAGXk5yqGOC8STC4wUNbUyKWR1m1NPOu6K-qXTz0=_UJEe64B2g@mail.gmail.com>
In-Reply-To: <CAGXk5yqGOC8STC4wUNbUyKWR1m1NPOu6K-qXTz0=_UJEe64B2g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 Oct 2023 18:07:21 +0200
Message-ID: <CAJZ5v0jGWzZx3jdkYTpdJZiWLFKaozTVdTU2h+dnVhvL18UwtQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/18] PM: EM: Add RCU mechanism which safely cleans
 the old data
To:     Wei Wang <wvw@google.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 6:03 PM Wei Wang <wvw@google.com> wrote:
>
> On Fri, Oct 6, 2023 at 1:45 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >
> > Hi Rafael,
> >
> > A change of direction here, regarding your comment below.
> >
> > On 10/2/23 14:44, Lukasz Luba wrote:
> > >
> > >
> > > On 9/29/23 13:59, Rafael J. Wysocki wrote:
> > >> On Fri, Sep 29, 2023 at 11:36 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> > >
> > > [snip]
> > >
> >
> > [snip]
> >
> > >>>> Apparently, some frameworks are only going to use the default table
> > >>>> while the runtime-updatable table will be used somewhere else at the
> > >>>> same time.
> > >>>>
> > >>>> I'm not really sure if this is a good idea.
> > >>>
> > >>> Runtime table is only for driving the task placement in the EAS.
> > >>>
> > >>> The thermal gov IPA won't make better decisions because it already
> > >>> has the mechanism to accumulate the error that it made.
> > >>>
> > >>> The same applies to DTPM, which works in a more 'configurable' way,
> > >>> rather that hard optimization mechanism (like EAS).
> > >>
> > >> My understanding of the above is that the other EM users don't really
> > >> care that much so they can get away with using the default table all
> > >> the time, but EAS needs more accuracy, so the table used by it needs
> > >> to be adjusted in certain situations.
> > >
> > > Yes
> > >
> > >>
> > >> Fair enough, I'm assuming that you've done some research around it.
> > >> Still, this is rather confusing.
> > >
> > > Yes, I have presented those ~2y ago in Android Gerrit world
> > > (got feedback from a few vendors) and in a few Linux conferences.
> > >
> > > For now we don't plan to have this feature for the thermal
> > > governor or something similar.
> > >
> >
> > I have discussed with one of our partners your comment about 2 tables.
> > They would like to have this runtime modified EM in other places
> > as well: DTPM and thermal governor. So you had good gut feeling.
> >
> > In the past in our IPA (thermal gov ~2016 and kernel v4.14) we
> > had two callbacks:
> > - get_static_power() [1]
> > - get_dynamic_power() [2]
> >
> > Later ~2017/2018 v4.16 the static power mechanism was removed
> > completely by this commit 84fe2cab48590e4373978e4e.
> > The way how it was design, implemented and used justified that
> > decision. We later used EM in the cpu cooling which also only
> > had dynamic power information.
> >
> > The PID mechanism in IPA tries to compensate that
> > missing information (about changed static power in time or a chip
> > binning) and adjusts the 'error'. How good and fast that is in all
> > situations - it's a different story (out of this scope).
> > So, IPA should not be worse with the runtime table.
> >
> > The static power was on the chips and probably will be still.
> > You might remember my slide 13 from OSPM2024 showing two power
> > usage plots for the same Big CPU and 1.4GHz fixed (50% of fmax):
> > - w/ GPU working in the background using 1-1.5W
> > - w/o GPU in the background
> >
> > The same workload run on Big, but power bigger is ~15% higher
> > after ~1min.
> >
> > The static power (leakage) is the issue that this patch tries
> > to address for EAS. Although, there is not only the leakage.
> > It's about the whole 'profile', which can be different than what
> > could be built during boot default information.
> >
> > So we would want to go for one single table in EM, which
> > is runtime modifiable.
> >
> > That is something that you might be more confident and we would
> > have less diversity (2 tables) in the kernel.
> >
> > Regards,
> > Lukasz
> >
> >
>
> Indeed, we had a conversation about this with Lukasz recently. The key
> idea is that there is no compelling reason to introduce diversity in
> the mathematics involved. If we have confidence in the superior
> accuracy of our model, it should be universally implemented. While the
> governors are designed with some error tolerance, they can benefit
> from enhanced accuracy in their operation.

I agree, thanks!

> > [1]
> > https://elixir.bootlin.com/linux/v4.14/source/drivers/thermal/cpu_cooling.c#L336
> > [2]
> > https://elixir.bootlin.com/linux/v4.14/source/drivers/thermal/cpu_cooling.c#L383
