Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76FB7DEEBF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345476AbjKBJWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjKBJWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:22:11 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BFA12E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 02:22:06 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-778a20df8c3so41700085a.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 02:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698916925; x=1699521725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwkMZjlqi/ySQgpiQTFMX2kM/+8KoGXXMWDaNv9YbZc=;
        b=MFIuB0ezDHO+KU2QW4UcdxMijuvuD1q9GKFuM+2w7B4WMaY+bdSMixM0CKEx51aw04
         TIoRbqNbOwH9GGMcbIeo2rRJjsxBkib5QMwtg0Iez3sYvJxbThKoNtHnKkUFyAMZRzOJ
         cmlBrfoQhLgf5bqqBG+Y5g6OAq8Wn0nJeNdJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698916925; x=1699521725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwkMZjlqi/ySQgpiQTFMX2kM/+8KoGXXMWDaNv9YbZc=;
        b=i1ymwy7soBtWhwZdhPKaOpqKcuoiWos5bfJ8G1vaoBr8tUxZBKfKD5EueTSkJmRLde
         5Eny1umJe6/dctSN4xHZhpUxd/eSfWQf848Mq9++MC8AUP9Jz+v54Va2whmoIZBstx/7
         45jnbIVsCKchbeb1KKHf3L8MR2BtRNia7XUjtT9y175MvdoheNuXhZe9wHoFgFrHT13Y
         1EyfxyaWBidVIl1bCz2VYPTNj/uwJZQfaEt45SmIO3XPUs6SaQTYB/bi1seuB7Q5laKo
         +IE/qn7Sn9f3ZD9AKz+/uXsyyRn4IK0Hda6rZ2uSzb9aFhJ9AnXfVgvfhMXjBstI7BU6
         JH8A==
X-Gm-Message-State: AOJu0Yy1kqM0qHehSlth8gIm1SH7H+ieKhAdCm/29aOZR1Ez7A64Ur3o
        HFPDadMuZKuKkl/qmRPse1e8akV7l+FQ1rXsl5t1dA==
X-Google-Smtp-Source: AGHT+IHf7xc04fU251ojm8cT61SiTJmMh145aunUgvAEhAQNIg66HzzltaY1gDenjs3eQzwfHezjkUqgJEk5ZKJalJI=
X-Received: by 2002:a05:6214:268d:b0:65b:216f:2d65 with SMTP id
 gm13-20020a056214268d00b0065b216f2d65mr19351907qvb.5.1698916924854; Thu, 02
 Nov 2023 02:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231027145623.2258723-1-korneld@chromium.org>
 <20231027145623.2258723-2-korneld@chromium.org> <e7c12e07-7540-47ea-8891-2cec73d58df1@intel.com>
In-Reply-To: <e7c12e07-7540-47ea-8891-2cec73d58df1@intel.com>
From:   =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
Date:   Thu, 2 Nov 2023 10:21:53 +0100
Message-ID: <CAD=Nsqzg2zRNFx7E800vnpNH6bZeHv9zdAnZksJjiRcXOQ4t=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: cqhci: Add a quirk to clear stale TC
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 8:31=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 27/10/23 17:56, Kornel Dul=C4=99ba wrote:
> > This fix addresses a stale task completion event issued right after the
> > CQE recovery. As it's a hardware issue the fix is done in form of a
> > quirk.
> >
> > When error interrupt is received the driver runs recovery logic is run.
> > It halts the controller, clears all pending tasks, and then re-enables
> > it. On some platforms a stale task completion event is observed,
> > regardless of the CQHCI_CLEAR_ALL_TASKS bit being set.
> >
> > This results in either:
> > a) Spurious TC completion event for an empty slot.
> > b) Corrupted data being passed up the stack, as a result of premature
> >    completion for a newly added task.
> >
> > To fix that re-enable the controller, clear task completion bits,
> > interrupt status register and halt it again.
> > This is done at the end of the recovery process, right before interrupt=
s
> > are re-enabled.
> >
> > Signed-off-by: Kornel Dul=C4=99ba <korneld@chromium.org>
> > ---
> >  drivers/mmc/host/cqhci-core.c | 42 +++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/cqhci.h      |  1 +
> >  2 files changed, 43 insertions(+)
> >
> > diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-cor=
e.c
> > index b3d7d6d8d654..e534222df90c 100644
> > --- a/drivers/mmc/host/cqhci-core.c
> > +++ b/drivers/mmc/host/cqhci-core.c
> > @@ -1062,6 +1062,45 @@ static void cqhci_recover_mrqs(struct cqhci_host=
 *cq_host)
> >  /* CQHCI could be expected to clear it's internal state pretty quickly=
 */
> >  #define CQHCI_CLEAR_TIMEOUT          20
> >
> > +/*
> > + * During CQE recovery all pending tasks are cleared from the
> > + * controller and its state is being reset.
> > + * On some platforms the controller sets a task completion bit for
> > + * a stale(previously cleared) task right after being re-enabled.
> > + * This results in a spurious interrupt at best and corrupted data
> > + * being passed up the stack at worst. The latter happens when
> > + * the driver enqueues a new request on the problematic task slot
> > + * before the "spurious" task completion interrupt is handled.
> > + * To fix it:
> > + * 1. Re-enable controller by clearing the halt flag.
> > + * 2. Clear interrupt status and the task completion register.
> > + * 3. Halt the controller again to be consistent with quirkless logic.
> > + *
> > + * This assumes that there are no pending requests on the queue.
> > + */
> > +static void cqhci_quirk_clear_stale_tc(struct cqhci_host *cq_host)
> > +{
> > +     u32 reg;
> > +
> > +     WARN_ON(cq_host->qcnt);
> > +     cqhci_writel(cq_host, 0, CQHCI_CTL);
> > +     if ((cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)) {
> > +             pr_err("%s: cqhci: CQE failed to exit halt state\n",
> > +                     mmc_hostname(cq_host->mmc));
> > +     }
> > +     reg =3D cqhci_readl(cq_host, CQHCI_TCN);
> > +     cqhci_writel(cq_host, reg, CQHCI_TCN);
> > +     reg =3D cqhci_readl(cq_host, CQHCI_IS);
> > +     cqhci_writel(cq_host, reg, CQHCI_IS);
> > +
> > +     /*
> > +      * Halt the controller again.
> > +      * This is only needed so that we're consistent across quirk
> > +      * and quirkless logic.
> > +      */
> > +     cqhci_halt(cq_host->mmc, CQHCI_FINISH_HALT_TIMEOUT);
> > +}
>
> Thanks a lot for tracking this down!
>
> It could be that the "un-halt" starts a task, so it would be
> better to force the "clear" to work if possible, which
> should be the case if CQE is disabled.
>
> Would you mind trying the code below?  Note the increased
> CQHCI_START_HALT_TIMEOUT helps avoid trying to clear tasks
> when CQE has not halted.

I've run a quick test and it works just fine.
Your approach looks better than what I proposed, since as you
mentioned, doing it like this avoids some weird side effects, e.g. DMA
to freed memory.
Do you plan to include it in the other series that you posted yesterday?

>
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.=
c
> index b3d7d6d8d654..534c13069833 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -987,7 +987,7 @@ static bool cqhci_halt(struct mmc_host *mmc, unsigned=
 int timeout)
>   * layers will need to send a STOP command), so we set the timeout based=
 on a
>   * generous command timeout.
>   */
> -#define CQHCI_START_HALT_TIMEOUT       5
> +#define CQHCI_START_HALT_TIMEOUT       500
>
>  static void cqhci_recovery_start(struct mmc_host *mmc)
>  {
> @@ -1075,28 +1075,27 @@ static void cqhci_recovery_finish(struct mmc_host=
 *mmc)
>
>         ok =3D cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
>
> -       if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
> -               ok =3D false;
> -
>         /*
>          * The specification contradicts itself, by saying that tasks can=
not be
>          * cleared if CQHCI does not halt, but if CQHCI does not halt, it=
 should
>          * be disabled/re-enabled, but not to disable before clearing tas=
ks.
>          * Have a go anyway.
>          */
> -       if (!ok) {
> -               pr_debug("%s: cqhci: disable / re-enable\n", mmc_hostname=
(mmc));
> -               cqcfg =3D cqhci_readl(cq_host, CQHCI_CFG);
> -               cqcfg &=3D ~CQHCI_ENABLE;
> -               cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
> -               cqcfg |=3D CQHCI_ENABLE;
> -               cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
> -               /* Be sure that there are no tasks */
> -               ok =3D cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
> -               if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
> -                       ok =3D false;
> -               WARN_ON(!ok);
> -       }
> +       if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
> +               ok =3D false;
> +
> +       cqcfg =3D cqhci_readl(cq_host, CQHCI_CFG);
> +       cqcfg &=3D ~CQHCI_ENABLE;
> +       cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
> +
> +       cqcfg =3D cqhci_readl(cq_host, CQHCI_CFG);
> +       cqcfg |=3D CQHCI_ENABLE;
> +       cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
> +
> +       cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
> +
> +       if (!ok)
> +               cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT);
>
>         cqhci_recover_mrqs(cq_host);
>
>
