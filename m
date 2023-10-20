Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366027D0AF0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376539AbjJTIxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376487AbjJTIxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:53:19 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D365A1A8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:53:16 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7ab9f1efecfso224859241.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697791996; x=1698396796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZMWQONtyhFjJunBgu/jOPJGbtthXaYLNhoitCzo7fs=;
        b=Tw9J9ESCN8MSuL0Ne8uMvx/ua8IXwrU5vWsfMKUkb7UYTn1+zZXFSFoARGX11X4hzM
         JqGMSkgxRYUPVHLYuGVKgI1cNYRCBwGLaLXSJZknI5zEkKrTxg6u2JbmOFoTPcPdTfhz
         UuJdMLSyP3oM5MTze1kjaas0q7WWPe5QtICSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697791996; x=1698396796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZMWQONtyhFjJunBgu/jOPJGbtthXaYLNhoitCzo7fs=;
        b=hWYG64YWLzU99YCegqpNC4urgsY8NzUFfJYyaghFBKbsHg7qRbpv3SOXKs2LeusTL5
         a9q3qyEQq4PATNGMDmwtCVY67hiA2k5eeQjd3p6K5yHwRBpxRShy3JfNAp5TFvoiFbk0
         GKlvhjpugKlfl0BR+Q3C/TQFwkuvVh2W7Vnh5RMLlYIqNLDCu/bq7BkIWIu7AuA0Hspb
         93Vrsa6FSBLDf0mv3P+1BshZyvStHQ2azOvNBmSNiXGLQEgM/YErTfnO7izE/iFVBGIg
         jgzKFJS6MeL/KQhOS4gRFt2nd8p+wbEJGr0r1sQ75kUD+0SVwY1/CysQyfJHBaaZnb3o
         frng==
X-Gm-Message-State: AOJu0YywSALIIOjE+Y5dDD4+Un1F/Wi0NDC2t+np29Moav1wpNRslcd3
        YCqlthXW2G/6KWC/KdI9i5phMowJLGWTt/DAAoiTCA==
X-Google-Smtp-Source: AGHT+IF/9v09ejtT7WOJ+R59iHKAUAji60nr+jZO6dVu70l9KhmTZQed9oVHK0LEUnZdn29k5NTRKoNF31AGFjGrE2o=
X-Received: by 2002:a05:6102:1051:b0:44e:d6c3:51d4 with SMTP id
 h17-20020a056102105100b0044ed6c351d4mr1324954vsq.18.1697791995934; Fri, 20
 Oct 2023 01:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231016095610.1095084-1-korneld@chromium.org> <613c51f0-c32e-4de5-9627-525d92fb06ed@intel.com>
In-Reply-To: <613c51f0-c32e-4de5-9627-525d92fb06ed@intel.com>
From:   =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
Date:   Fri, 20 Oct 2023 10:53:05 +0200
Message-ID: <CAD=NsqybNrf-=9=5wvoj+9MT3xK3SbX7nDk3N3VLBMyA_u3KTQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: cqhci: Be more verbose in error irq handler
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@codeaurora.org>,
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

On Fri, Oct 20, 2023 at 9:41=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 16/10/23 12:56, Kornel Dul=C4=99ba wrote:
> > There are several reasons for controller to generate an error interrupt=
.
> > They include controller<->card timeout, and CRC mismatch error.
> > Right now we only get one line in the logs stating that CQE recovery wa=
s
> > triggered, but with no information about what caused it.
> > To figure out what happened be more verbose and dump the registers from
> > irq error handler logic.
> > This matches the behaviour of the software timeout logic, see
> > cqhci_timeout.
> >
> > Signed-off-by: Kornel Dul=C4=99ba <korneld@chromium.org>
> > ---
> >  drivers/mmc/host/cqhci-core.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-cor=
e.c
> > index b3d7d6d8d654..33abb4bd53b5 100644
> > --- a/drivers/mmc/host/cqhci-core.c
> > +++ b/drivers/mmc/host/cqhci-core.c
> > @@ -700,8 +700,9 @@ static void cqhci_error_irq(struct mmc_host *mmc, u=
32 status, int cmd_error,
> >
> >       terri =3D cqhci_readl(cq_host, CQHCI_TERRI);
> >
> > -     pr_debug("%s: cqhci: error IRQ status: 0x%08x cmd error %d data e=
rror %d TERRI: 0x%08x\n",
> > -              mmc_hostname(mmc), status, cmd_error, data_error, terri)=
;
> > +     pr_warn("%s: cqhci: error IRQ status: 0x%08x cmd error %d data er=
ror %d\n",
> > +              mmc_hostname(mmc), status, cmd_error, data_error);
> > +     cqhci_dumpregs(cq_host);
>
> For debugging, isn't dynamic debug seems more appropriate?

Dynamic debug is an option, but my personal preference would be to
just log more info in the error handler.
To give you some background.
We're seeing some "running CQE recovery" lines in the logs, followed
by a dm_verity mismatch error.
The reports come from the field, with no feasible way to reproduce the
issue locally.

I'd argue that logging only the info that CQE recovery was executed is
not particularly helpful for someone looking into those logs.
Ideally we would have more data about the state the controller was in
when the error happened, or at least what caused the recovery to be
triggered.
The question here is how verbose should we be in this error scenario.
Looking at other error scenarios, in the case of a software timeout
we're dumping the controller registers. (cqhci_timeout)
Hence I thought that I'd be appropriate to match that and do the same
in CQE recovery logic.

>
> >
> >       /* Forget about errors when recovery has already been triggered *=
/
> >       if (cq_host->recovery_halt)
>
