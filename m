Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B0A7B324E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjI2MSY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Sep 2023 08:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbjI2MSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:18:22 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EBD1AA;
        Fri, 29 Sep 2023 05:18:21 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-57bc11c197aso1219405eaf.1;
        Fri, 29 Sep 2023 05:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695989900; x=1696594700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkUCEKbP8HqOOiE0WgtqrpGwplsIgZxlbsQ4QxXPJXs=;
        b=wD5IQP1Jskr8BXGu/Kt5xfiBIhbquua0ZVaSLi1wp6eeVcrt4qqV5CHrAKxBa8GJqI
         ZuzYyFn1xrAzJurgHzENUxHoI63cxhbbJvPtvwhrlPSfAUFnRRDrQuVcvNoKp691BbXE
         RSv1YtBc2MnhS6BkGk3WYd2MZKbkeBxXrDZhBHd2Bug/2zJkPduI0NrQszdqI0VqbM/3
         jRzy74vuQUKxWI9MniXXvFLJe5NNHs/xOFFmejrG+MyO5AE6W+aHv2H1PQJnnUh5foCt
         Yfm2y1zd9BP3ypfg8lD+vtsK0kRHDswYo5/j5wVW6wgROaeoMyQkO+WNETCib9GyENi9
         u1vg==
X-Gm-Message-State: AOJu0YyK+HaUHaEKFXSFOb7lLJ0S++/JjPfcjMOdqW6Sq9c/aeo/lJPc
        LLYpNRtOgMoPt5RwJjQ3u5CWExQMOGWQaDB5jfw=
X-Google-Smtp-Source: AGHT+IEx/75T/hzvBFoUXXwhQGu997npYkFXA2nC3oXdZavdBeCKxwxBtvBBpr0N7RpFpdgVnY6iAgSleay6DFyFHGc=
X-Received: by 2002:a05:6820:629:b0:57b:7e31:c12 with SMTP id
 e41-20020a056820062900b0057b7e310c12mr4465454oow.1.1695989900147; Fri, 29 Sep
 2023 05:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230925081139.1305766-1-lukasz.luba@arm.com> <20230925081139.1305766-9-lukasz.luba@arm.com>
 <CAJZ5v0hM3DvEZSyDubd29bkEPDv6JUm8FaKM8+suaWOpKESp+w@mail.gmail.com> <516cb2e8-6b54-b17f-f275-1bebe908bf34@arm.com>
In-Reply-To: <516cb2e8-6b54-b17f-f275-1bebe908bf34@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 Sep 2023 14:18:09 +0200
Message-ID: <CAJZ5v0jSSrAMO9S1g49c6mH3DPYJOqfspV7EscQCDpkPgox+=Q@mail.gmail.com>
Subject: Re: [PATCH v4 08/18] PM: EM: Add update_power() callback for runtime modifications
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
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

On Fri, Sep 29, 2023 at 10:59 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> On 9/26/23 19:59, Rafael J. Wysocki wrote:
> > On Mon, Sep 25, 2023 at 10:11 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >> The Energy Model (EM) is going to support runtime modifications. This
> >> new callback would be used in the upcoming EM changes. The drivers
> >> or frameworks which want to modify the EM have to implement the
> >> update_power() callback.
> >>
> >> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >> ---
> >>   include/linux/energy_model.h | 22 ++++++++++++++++++++++
> >>   1 file changed, 22 insertions(+)
> >>
> >> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> >> index d236e08e80dc..546dee90f716 100644
> >> --- a/include/linux/energy_model.h
> >> +++ b/include/linux/energy_model.h
> >> @@ -168,6 +168,26 @@ struct em_data_callback {
> >>           */
> >>          int (*get_cost)(struct device *dev, unsigned long freq,
> >>                          unsigned long *cost);
> >> +
> >> +       /**
> >> +        * update_power() - Provide new power at the given performance state of
> >> +        *              a device
> >
> > The meaning of the above is unclear to me.
>
> I can try to rephrase this a bit:
> ' Provide a new power value for the device at the given frequency. This
> allows to reflect changed power profile in runtime.'

Maybe "Estimate power for a given device frequency"

> >
> >> +        * @dev         : Device for which we do this operation (can be a CPU)
> >
> > It is unclear what "we" means in this context.  Maybe say "Target
> > device (can be a CPU)"?
>
> That sounds better indeed.
>
> >
> >> +        * @freq        : Frequency at the performance state in kHz
> >
> > What performance state does this refer to?  And the frequency of what?
>
> We just call the entry in EM the 'performance state' (so frequency and
> power). I will rephrase this as well:
> 'Frequency of the @dev expressed in kHz'

Or "Device frequency for which to estimate power"?

> >
> >> +        * @power       : New power value at the performance state
> >> +        *              (modified)
> >
> > Similarly unclear as the above.
>
> OK, it can be re-written as:
> 'Power value of the @dev at the given @freq (modified)'

This is not a power value, but a return pointer AFAICS.  So "location
to store the return power value".

> >
> >> +        * @priv        : Pointer to private data useful for tracking context
> >> +        *              during runtime modifications of EM.
> >
> > Who's going to set this pointer and use this data?
>
> The driver or kernel module, which is aware about thermal events. Those
> events might be coming from FW to kernel, but we need to maintain
> the same 'context' for all OPPs when we start the EM update.
>
> This 'priv' field is used for passing the 'context' back to the
> caller, so the caller can consistently the update. The update might
> be with some math formula which multiplies the power by some factor
> value (based on thermal model and current temperature).

I would say "Additional data for the callback function, provided by
the entity setting the callback pointer".

> >
> >> +        *
> >> +        * The update_power() is used by runtime modifiable EM. It aims to
> >
> > I would drop "The" from the above.
>
> OK
>
> >
> >> +        * provide updated power value for a given frequency, which is stored
> >> +        * in the performance state.
> >
> > A given frequency of what and the performance state of what does this refer to?
>
> I will change that and add the '@dev' word to make this more precised.

That would help.  Overall, I would say "is used by ... to obtain a new
power value for a given frequency of @dev".

>
> 'update_power() is used by runtime modifiable EM. It aims to update the
> @dev EM power values for all registered frequencies.'
