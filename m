Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AB67D645A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbjJYICB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjJYICA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:02:00 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39A599
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:01:56 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66d87554434so37012546d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698220916; x=1698825716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+aCPbYQpsJ2vXxRn0LtCcVnfgBZqdcqBZqMdP2WSpA=;
        b=YfERVL37YFHigrESyOyCP+wtIlSwZSX8LiksG1y18vPSviwY/dppJkq7R9sRCf8Kej
         u9IFqSD8aOnZG97yAPMJkknQtcvOO1Vnsg0ZXv6LuA94/biDk8ualXC05Cu3n8qePOoE
         RmLuHUy3PSeTPTitoImCE56yZaiPN5jQqpcxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698220916; x=1698825716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+aCPbYQpsJ2vXxRn0LtCcVnfgBZqdcqBZqMdP2WSpA=;
        b=ooY1XsVKMFkEecjYUCP8cPNh0TzpYqqXH0ndeh9D9KXRtbsbIFzd8Z04Scn0Z1rXgp
         C1AOIwWUkiifeoacZ38bXruyqOd+UtyG7h07Qe2EacGzjPBRnP1cpF4IMcuLaI2fNH7a
         +OfZ8Ai71EMBP29+te8dmRQnYky2L9NHjxAUDU11A+24y8PDFMobXsSw1qKNz7zeQGRO
         dwPfOK6Qz/NkbmIs7vJ6OrJ5uDgw1NVwIku8VjEktHfJ82U6Xi6f3mpuDMXbGvQ+l+5W
         fPD/6WkBqf8kX2ORpJaVHVYKLzCPGztnfn3McUjw6HpZswe2Lo9pSGDlAcRjPaxerm5M
         hLWw==
X-Gm-Message-State: AOJu0YyPUFfXupnzB/4wQqWytLElXgst80zpd+yJHEVkfyXsL3asXHzn
        iA45yF/sHQOpc3jcnIRpQyJPxugJDgPiu6PoWsYN+w==
X-Google-Smtp-Source: AGHT+IEup/UJN80bbqR3UUc1G437duavyaltRA4CvsTWHDr6cCIAHtxUKTr/K49qoyM2cXjCU4INdOMaUo5MlGUBVLs=
X-Received: by 2002:a05:6214:20ad:b0:66d:2852:6f17 with SMTP id
 13-20020a05621420ad00b0066d28526f17mr15178466qvd.14.1698220915877; Wed, 25
 Oct 2023 01:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231016095610.1095084-1-korneld@chromium.org>
 <613c51f0-c32e-4de5-9627-525d92fb06ed@intel.com> <CAD=NsqybNrf-=9=5wvoj+9MT3xK3SbX7nDk3N3VLBMyA_u3KTQ@mail.gmail.com>
 <78bb4ad2-853a-4ed4-9998-c4e1122545b6@intel.com>
In-Reply-To: <78bb4ad2-853a-4ed4-9998-c4e1122545b6@intel.com>
From:   =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
Date:   Wed, 25 Oct 2023 10:01:44 +0200
Message-ID: <CAD=NsqxDA=usDRa-KV48RkeEROARsw8JqBF5vyJcEEV5r_Fg1w@mail.gmail.com>
Subject: Re: [PATCH] mmc: cqhci: Be more verbose in error irq handler
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 1:38=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 20/10/23 11:53, Kornel Dul=C4=99ba wrote:
> > On Fri, Oct 20, 2023 at 9:41=E2=80=AFAM Adrian Hunter <adrian.hunter@in=
tel.com> wrote:
> >>
> >> On 16/10/23 12:56, Kornel Dul=C4=99ba wrote:
> >>> There are several reasons for controller to generate an error interru=
pt.
> >>> They include controller<->card timeout, and CRC mismatch error.
> >>> Right now we only get one line in the logs stating that CQE recovery =
was
> >>> triggered, but with no information about what caused it.
> >>> To figure out what happened be more verbose and dump the registers fr=
om
> >>> irq error handler logic.
> >>> This matches the behaviour of the software timeout logic, see
> >>> cqhci_timeout.
> >>>
> >>> Signed-off-by: Kornel Dul=C4=99ba <korneld@chromium.org>
> >>> ---
> >>>  drivers/mmc/host/cqhci-core.c | 5 +++--
> >>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-c=
ore.c
> >>> index b3d7d6d8d654..33abb4bd53b5 100644
> >>> --- a/drivers/mmc/host/cqhci-core.c
> >>> +++ b/drivers/mmc/host/cqhci-core.c
> >>> @@ -700,8 +700,9 @@ static void cqhci_error_irq(struct mmc_host *mmc,=
 u32 status, int cmd_error,
> >>>
> >>>       terri =3D cqhci_readl(cq_host, CQHCI_TERRI);
> >>>
> >>> -     pr_debug("%s: cqhci: error IRQ status: 0x%08x cmd error %d data=
 error %d TERRI: 0x%08x\n",
> >>> -              mmc_hostname(mmc), status, cmd_error, data_error, terr=
i);
> >>> +     pr_warn("%s: cqhci: error IRQ status: 0x%08x cmd error %d data =
error %d\n",
> >>> +              mmc_hostname(mmc), status, cmd_error, data_error);
> >>> +     cqhci_dumpregs(cq_host);
> >>
> >> For debugging, isn't dynamic debug seems more appropriate?
> >
> > Dynamic debug is an option, but my personal preference would be to
> > just log more info in the error handler.
>
> Interrupt handlers can get called very rapidly, so some kind of rate
> limiting should be used if the message is unconditional.  Also you need
> to provide actual reasons for your preference.
>
> For dynamic debug of the register dump, something like below is
> possible.
>
> #define cqhci_dynamic_dumpregs(cqhost) \
>         _dynamic_func_call_no_desc("cqhci_dynamic_dumpregs", cqhci_dumpre=
gs, cqhost)
>
Fair point.
The reason I'm not a fan of using dynamic debug for this is that my
goal here is to improve the warning/error logging information that we
get from systems running in production.
I.e. if we get a lot of "running CQE recovery" messages, at the very
least I'd like to know what is causing them.
> > To give you some background.
> > We're seeing some "running CQE recovery" lines in the logs, followed
> > by a dm_verity mismatch error.
> > The reports come from the field, with no feasible way to reproduce the
> > issue locally.
>
> If it is a software error, some kind of error injection may well
> reproduce it.  Also if it is a hardware error that only happens
> during recovery, error injection could increase the likelihood of
> reproducing it.

We tried software injection and it didn't yield any results.
We're currently looking into "injecting" hw errors by using a small
burst field generator to interfere with transfers on the data line
directly.
>
> >
> > I'd argue that logging only the info that CQE recovery was executed is
> > not particularly helpful for someone looking into those logs.
>
> As the comment says, that message is there because recovery reduces
> performance, it is not to aid debugging per se.
>
> > Ideally we would have more data about the state the controller was in
> > when the error happened, or at least what caused the recovery to be
> > triggered.
> > The question here is how verbose should we be in this error scenario.
> > Looking at other error scenarios, in the case of a software timeout
> > we're dumping the controller registers. (cqhci_timeout)
>
> Timeout means something is broken - either the driver, the cq engine
> or the card.  On the other hand, an error interrupt is most likely a
> CRC error which is not unexpected occasionally, due to thermal drift
> or perhaps interference.

Right, but my point is that we don't know what triggered CQE recovery.

>
> > Hence I thought that I'd be appropriate to match that and do the same
> > in CQE recovery logic.
>
> It needs to be consistent. There are other pr_debugs, such as:
>
>                 pr_debug("%s: cqhci: Failed to clear tasks\n",
>                 pr_debug("%s: cqhci: Failed to halt\n", mmc_hostname(mmc)=
);
>                 pr_debug("%s: cqhci: disable / re-enable\n", mmc_hostname=
(mmc));
>
> which should perhaps be treated the same.
>
> And there are no messages for errors from the commands in
> mmc_cqe_recovery().

How about this.
As a compromise would it be okay to just do a single pr_warn directly
from cqhci_error_irq.
We could simply promote the existing pr_debug to pr_warn at the
beginning of that function.
This would tell us what triggered the recovery. (controller timeout,
CRC mismatch)
We can also consider removing the "running CQE recovery" print for the
sake of brevity.
The only downside of this that I can see is that we'd be running the
logic from the interrupt handler directly, but I can't see an easy way
around that.
What do you think?
>
> >
> >>
> >>>
> >>>       /* Forget about errors when recovery has already been triggered=
 */
> >>>       if (cq_host->recovery_halt)
> >>
>
