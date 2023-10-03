Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55957B64D5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjJCI6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjJCI6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:58:54 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A20AB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:58:51 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-45281e0b1cbso361776137.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 01:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696323530; x=1696928330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9grnBhGYN4tR3F3kBytOzLLS9fG/VwUgoWRG+MN0q8=;
        b=mlfE1G9UP/AxOktBZJT5eErItR/jDkslCgpZfJpEmVJrtfmR+FU+n+RxCk4eG3o1ZI
         FSkygiLsdmTQ0JAs3iPnKtMLoGQEK4Q9+a0JHdyNbpHF5IAvkSXC/Q9X9Cr2o5SXAihi
         4HSNOqCK16uogqmp1SnJ1cFlQRfunOXSVY43eMrvVpuE9HnulxaPd2YMO6WKtINU9EYV
         EXTl/yaWUR81UDeFqsWN0MbGCb//3lFiuco9dyYBCF87nY36lgtsMJ49HqYqWjZFcxr2
         3PKlvq5TzyoJS6H+iVW6EPKl+KOh/UmCIXUzL9W7/G2CXghptvtlSvR/JVpf9Hn2Yk+l
         dFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696323530; x=1696928330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9grnBhGYN4tR3F3kBytOzLLS9fG/VwUgoWRG+MN0q8=;
        b=KhOJan8dSnCgyhjshbN+owz5RX7wAcyz/gkhenul8nyzAy3DvZ3K9SD5PNePc612gg
         5fOTtW5RmpHU3avbzLvPXh+ZARekvCE+g/kxdZMRZU6mKfmPEFG3GAVoVD9C/gzFj64m
         fklX0kiZWGewGuyAsMcRpul+icMpTgAIr5du882uvxnvFXvwOwVUaSsCcqcsII+Af2M2
         aT0VzdpcxH0nvk4S4Nqb1dG8sOXc7t9bdZ1FcicFaJ/E3gxeut5coJxi1B15quq7iIvs
         7bF60++H/H8ApkhCKhdKpKlr950+pIXhHMZSV+7i/iIwy6Jg8rGh8JiOcx7CkuGW6h9R
         mwNA==
X-Gm-Message-State: AOJu0Yw2aaMnJjgBDF7hJwb4e5C9J/7W8pWsclcu5yjVjLDh4yakVAGH
        RkaN3xEZ6ydsdGAQdx5vfIgXSitK70XZYFWbxQ/Jkw==
X-Google-Smtp-Source: AGHT+IEYqBcuujG8F8yRDX0mMz4fUo5Zqz+FnZMiLO+cfJoEKOTmOKZqVO6LlvB9IX90o4lBKbnpAWh2fFaPLAbLtl0=
X-Received: by 2002:a05:6102:34c8:b0:44e:d6c3:51d6 with SMTP id
 a8-20020a05610234c800b0044ed6c351d6mr12516312vst.14.1696323530367; Tue, 03
 Oct 2023 01:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230911094443.14040-1-brgl@bgdev.pl> <cd4df23c-cc02-6723-e36d-34ca03409e6e@nvidia.com>
 <CAMRc=MeWXapho1bsX9Si5uSx7MWVhpT2cqrv5S+qPo51Ko=Vtg@mail.gmail.com> <7766de61-a046-3e17-1322-28bd7f1e61da@nvidia.com>
In-Reply-To: <7766de61-a046-3e17-1322-28bd7f1e61da@nvidia.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 3 Oct 2023 10:58:39 +0200
Message-ID: <CAMRc=Mfbt0iUbM42zR0ZrBWgbQkctQm3LxwiFFP5dXNuQC-EqA@mail.gmail.com>
Subject: Re: [PATCH] hte: tegra194: improve the GPIO-related comment
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        timestamp@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 6:27=E2=80=AFPM Dipen Patel <dipenp@nvidia.com> wrot=
e:
>
> On 10/2/23 1:33 AM, Bartosz Golaszewski wrote:
> > On Fri, Sep 29, 2023 at 11:38=E2=80=AFPM Dipen Patel <dipenp@nvidia.com=
> wrote:
> >>
> >> On 9/11/23 2:44 AM, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>
> >>> Using any of the GPIO interfaces using the global numberspace is
> >>> deprecated. Make it clear in the comment.
> >>>
> >>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >>> ---
> >>> This was part of a wider series but since this is independent, I'm se=
nding
> >>> it separately.
> >>>
> >>>  drivers/hte/hte-tegra194.c | 13 ++++++++-----
> >>>  1 file changed, 8 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
> >>> index 6fe6897047ac..9fd3c00ff695 100644
> >>> --- a/drivers/hte/hte-tegra194.c
> >>> +++ b/drivers/hte/hte-tegra194.c
> >>> @@ -407,12 +407,15 @@ static int tegra_hte_line_xlate(struct hte_chip=
 *gc,
> >>>               return -EINVAL;
> >>>
> >>>       /*
> >>> +      * GPIO consumers can access GPIOs in two ways:
> >>>        *
> >>> -      * There are two paths GPIO consumers can take as follows:
> >>> -      * 1) The consumer (gpiolib-cdev for example) which uses GPIO g=
lobal
> >>> -      * number which gets assigned run time.
> >>> -      * 2) The consumer passing GPIO from the DT which is assigned
> >>> -      * statically for example by using TEGRA194_AON_GPIO gpio DT bi=
nding.
> >>> +      * 1) Using the global GPIO numberspace.
> >>> +      *
> >>> +      * This is the old, now DEPRECATED method and should not be use=
d in
> >>> +      * new code. TODO: Check if tegra is even concerned by this.
> >> This use case is to do namespace mapping from gpio subsystem to hte. F=
ew doubts:
> >> 1. What does deprecate mean here? Does gpio subsys not use global spac=
e anymore?
> >
> > It does but we don't want to expose this to external users in any way
> > anymore (and haven't to for years). This is what deprecated means.
> > Users should deal with opaque GPIO descriptors not global GPIO
> > numberspace.
> >
> >> 2. If yes, what GPIO number is set when it comes from gpiolib-cdev, as=
 based on that I may have to
> >> reflect in the mapping, tegra194_aon_gpio_map for example.
> >
> > Why DO you have to use a GPIO number though? If HTE needs just a
> > number from some HTE numberspace (which in itself may be unnecessary)
> > then why not just keep a local IDA for it? Do you have to know the
> > GPIOs internal numbering scheme to make it work?
>

Dipen,

Please set your mailer to wrap lines around at 80 characters as is
customary on the mailing list.

> humm, overall, I just need to know which GPIO it is, for example, GPIO co=
ntroller X Port A GPIO number 3
> to do proper mapping.
> Continuing from above example, the hte driver gets:
> - GPIO Controller X from DT node
> - the rest details in current code gets it from [1] and [2]
>
> If there is alternate method exists, I would like to explore. I think IDA=
 will not help in this case as ID assigned
> does not hold meaning in this context.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/gpio/gpiolib-cdev.c?h=3Dv6.6-rc3#n760

Here: any reason why we have to translate the desc to the global GPIO
numberspace? Can we just pass the descriptor pointer directly to the
HTE subsystem?

> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/hte/hte-tegra194.c?h=3Dv6.6-rc3#n421

I still don't understand why you need to know the GPIO base? I'm not
quite sure what the role of line_id is in this driver. Is it only to
index the array?

Please bear with me, I don't know this subsystem very well.

Bart

>
> >
> > Bart
> >
> >>> +      *
> >>> +      * 2) Using GPIO descriptors that can be assigned to consumer d=
evices
> >>> +      * using device-tree, ACPI or lookup tables.
> >>>        *
> >>>        * The code below addresses both the consumer use cases and map=
s into
> >>>        * HTE/GTE namespace.
> >>
>
