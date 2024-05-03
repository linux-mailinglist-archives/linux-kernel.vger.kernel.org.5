Return-Path: <linux-kernel+bounces-167720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0F68BADFC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52C01C21860
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7B9153BEE;
	Fri,  3 May 2024 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPfpqp39"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFF9153BDF
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714743979; cv=none; b=OnE38gNJ95zkY1fmUTb6UeuQi6iwMUVVMqrBrqKUH8ghoN9KoSI1YzZioLlMlmrnCmkA42R+8lLqgK17lmGtYA7kbeSuDAVe9qIqzCJzgE4Rzzka3v3rFQVpzy9gTT/RzhVHrZpJeCRLdNHDavE3Q32/wAo6ouABziojyeMdMuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714743979; c=relaxed/simple;
	bh=niQWlxJn5XH2Swl9BN4qcIlg9vZWKA0A2TStH6e2UPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzgWicDa7QRIURPDf4Oh+4WG/tiarQVzE/uH5jwDuHWQqB/THbd+iSeQWi2LVuJMEti5l6huZwpjlgLB6Ygl8vNiRpKzMbf7+IZ2wO2XvnaYtCbO1pP+XavTJj4XffyARwTGY09M8Jd2zlRKYzfz6nPdX6tMw4163++1Ml+QlFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bPfpqp39; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de54b28c41eso10202389276.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714743975; x=1715348775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VkO+KdbtUN9IqeShpgEcMEOobBVHfZYBUo6hb6ifhXo=;
        b=bPfpqp39tcYsWlqnH+99DQhVeIRoCYTSdB3e9J8LjZjs22tlB4NpMhX2w5RaLg/Iow
         HG4hbdU+NnONVw9yHxHWW8cfeu3YW3ua9XtjrloQm6ZiftdQ/oRDt6y7XOrtND/SQXsp
         vig7laLYLUgA060wJ3RWLlQo1FJUJYasi2mmpX8qTM3bmXt1q/eTBzealY0KckmmBRvg
         fFyDc5ZiKnOWuvKDua7D9PYbpHYkK3fEQS9KO+aTwOy23ob8mAI7M8INbXf+9YAAnXEH
         erRCMFSwOL0/HBTz05ik0P53TIU1GQ2LsyLegu7PiZQHxxPxoSyI/EWYDFqUD3VZQtvd
         1/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714743975; x=1715348775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VkO+KdbtUN9IqeShpgEcMEOobBVHfZYBUo6hb6ifhXo=;
        b=Y4dOJegK7zKH4eysxd+U5NefuVi6dQAtFyrISZaRtWYCWMMYEfFjRvj+2QcBIcJb9r
         tu2O2pRw0w8aeKC8zI4LM+5nZfNb70P+jCWYR+a5BlWvi4tvpPE8AD9E2OgmEs7J/GkP
         E8hSDNOGVvl6fMx3asvMCcInlp77R9EaBQ2onaCOPyEXNbFOZCx/AXm4PKZoNnmAf1lI
         WmlD1Venf/Yi9pIpdRaAqm079RD20/r3Lup86m+JC6cePBTU1TPWv5KCMf1Hc1fyW5pp
         jROmYJh0X1VizK6SUCpkyatflHpfMkplIdMIASvj3HvAELtvMd6tcMQi06BUkVdetG/H
         Yspw==
X-Forwarded-Encrypted: i=1; AJvYcCW9aSu2S+PbQTp1RIaZCCFdR/iXrBDte6ZVrRmrlct2DXyZZUzZaIb1CRCB5PCPgDu4nh1gijis6SMJ9D+hcehzp8T8KHYwOjyHrjbT
X-Gm-Message-State: AOJu0Yx1O4zFatu8P6ZYI/4YqBtg7TbrPiQu/SHhyt7kQ8m41m8nygN8
	PoB48YD8k7GpKL1RgUHqPmZp5K6rYbQyVB6zuJzU0kzTsnUCdNVZLbU7S1Sadw8HS65jre3Iku3
	WcJx3zzLhNKPiMfsTqz97dGRIdrEusS+TSsfwtA==
X-Google-Smtp-Source: AGHT+IH/Xb1XcZDOaCvizhYyHNNZjGRIDjGUlZ+m+l5KoU1hpsPb+0dWkoH6eUByYXw6Znq4ecrpXd3LLQEK4dA3cKc=
X-Received: by 2002:a25:b04a:0:b0:de8:8cd9:c43d with SMTP id
 e10-20020a25b04a000000b00de88cd9c43dmr2564219ybj.12.1714743975056; Fri, 03
 May 2024 06:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415-ti-sci-pd-v1-0-a0e56b8ad897@ideasonboard.com>
 <20240415-ti-sci-pd-v1-2-a0e56b8ad897@ideasonboard.com> <d4cd0323-4792-49b0-a4e2-0bc92068e7f0@ideasonboard.com>
In-Reply-To: <d4cd0323-4792-49b0-a4e2-0bc92068e7f0@ideasonboard.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 3 May 2024 15:45:38 +0200
Message-ID: <CAPDyKFqShuq98qV5nSPzSqwLLUZ7LxLvp1eihGRBkU4qUKdWwQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] pmdomain: ti-sci: Support retaining PD boot time state
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Abel Vesa <abel.vesa@linaro.org>, 
	Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Dave Gerlach <d-gerlach@ti.com>, J Keerthy <j-keerthy@ti.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Santosh Shilimkar <santosh.shilimkar@oracle.com>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Devarsh Thakkar <devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"

+ Abel, Saravanna, Stephen

On Mon, 15 Apr 2024 at 19:17, Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> On 15/04/2024 19:00, Tomi Valkeinen wrote:
> > Add a new flag, TI_SCI_PD_KEEP_BOOT_STATE, which can be set in the dts
> > when referring to power domains. When this flag is set, the ti-sci
> > driver will check if the PD is currently enabled in the HW, and if so,
> > set the GENPD_FLAG_ALWAYS_ON flag so that the PD will stay enabled.
> >
> > The main issue I'm trying to solve here is this:
> >
> > If the Display Subsystem (DSS) has been enabled by the bootloader, the
> > related PD has also been enabled in the HW. When the tidss driver
> > probes, the driver framework will automatically enable the PD. While
> > executing the probe function it is very common for the probe to return
> > EPROBE_DEFER, and, in rarer cases, an actual error. When this happens
> > (probe() returns an error), the driver framework will automatically
> > disable the related PD.
> >
> > Powering off the PD while the DSS is enabled and displaying a picture
> > will cause the DSS HW to enter a bad state, from which (afaik) it can't
> > be woken up except with full power-cycle. Trying to access the DSS in
> > this state (e.g. when retrying the probe) will usually cause the board
> > to hang sooner or later.
> >
> > Even if we wouldn't have this board-hangs issue, it's nice to be able to
> > keep the DSS PD enabled: we want to keep the DSS enabled when the
> > bootloader has enabled the screen. If, instead, we disable the PD at the
> > first EPROBE_DEFER, the screen will (probably) go black.
>
> A few things occurred to me. The driver is supposed to clear the
> GENPD_FLAG_ALWAYS_ON when the driver has probed successfully. There are
> two possible issues with that:
>
> - Afaics, there's no API to do that, and currently I just clear the bit
> in genpd->flags. There's a clear race there, so some locking would be
> required.
>
> - This uses the GENPD_FLAG_ALWAYS_ON flag to say "PD is always on, until
> the driver has started". If the PD would have GENPD_FLAG_ALWAYS_ON set
> for other reasons, the driver would still go and clear the flag, which
> might break things.
>
> Also, unrelated to the above and not a problem in practice at the very
> moment, but I think clocks should also be dealt with somehow. Something,
> at early-ish boot stage, should mark the relevant clocks as in use, so
> that there's no chance they would be turned off when the main kernel has
> started (the main display driver is often a module).
>
> It would be nice to deal with all the above in a single place. I wonder
> if the tidss driver itself could somehow be split into two parts, an
> early part that would probe with minimal dependencies, mainly to reserve
> the core resources without doing any kind of DRM init. And a main part
> which would (somehow) finish the initialization at a later point, when
> we have the filesystem (for firmware) and the other bridge/panel drivers
> have probed.
>
> That can be somewhat achieved with simplefb or simpledrm, though, but we
> can't do any TI DSS specific things there, and it also creates a
> requirement to have either of those drivers built-in, and the related DT
> nodes to be added.

Without going into too much detail, this and similar problems have
been discussed in the past. With the fw_devlink and the ->sync_state()
callback we are getting closer to a solution, but for genpd a solution
is still pending.

If you want to read up on earlier discussions and join us moving
forward, that would be great. The last attempt for genpd to move this
forward was posted by Abel Vesa:
https://lore.kernel.org/linux-pm/20230621144019.3219858-1-abel.vesa@linaro.org/

Beyond that, we have also discussed various solutions at the last LPC
in Richmond. I think the consensus at that point was that Saravana
targeted to post something for clocks - and when that was done, we
should do the similar thing for genpd. Anyway, I have looped them into
this thread, so they can share any updates on their side of the
matter.

>
>   Tomi

Kind regards
Uffe

>
> > Another option here would perhaps be to change the driver framework
> > (drivers/base/platform.c) which attaches and detaches the PD, and make
> > it somehow optional, allowing the driver the manage the PD. That option
> > has two downsides: 1) the driver _has_ to manage the PD, which would
> > rule out the use of simplefb and simpledrm, and 2) it would leave the PD
> > in off state from Linux's perspective until a driver enables the PD, and
> > that might mean that the PD gets actually disabled as part of normal
> > system wide power management (disabling unused resources).
> >
> > Yet another option would be to do this outside the ti_sci_pm_domains
> > driver: a piece of code that would somehow be ran after the
> > ti_sci_pm_domains driver has probed (so that we have the PDs), but
> > before tidss/simplefb/simpledrm probes. The problem here is the
> > "somehow" part. Also, this would partly have the same issue 2) as
> > mentioned above.
> >
> > TODO: If this approach is ok, sci-pm-domain.yaml needs to be extended.
> > Also, it sounds a bit like the cell value is not a bit-mask, so maybe
> > adding TI_SCI_PD_KEEP_BOOT_STATE flag this way is not fine.
> >
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > ---
> >   drivers/pmdomain/ti/ti_sci_pm_domains.c    | 27 +++++++++++++++++++++++++--
> >   include/dt-bindings/soc/ti,sci_pm_domain.h |  1 +
> >   2 files changed, 26 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> > index 1510d5ddae3d..b71b390aaa39 100644
> > --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> > +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> > @@ -103,7 +103,7 @@ static struct generic_pm_domain *ti_sci_pd_xlate(
> >               return ERR_PTR(-ENOENT);
> >
> >       genpd_to_ti_sci_pd(genpd_data->domains[idx])->exclusive =
> > -             genpdspec->args[1];
> > +             genpdspec->args[1] & TI_SCI_PD_EXCLUSIVE;
> >
> >       return genpd_data->domains[idx];
> >   }
> > @@ -161,6 +161,8 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
> >                               break;
> >
> >                       if (args.args_count >= 1 && args.np == dev->of_node) {
> > +                             bool is_on = false;
> > +
> >                               if (args.args[0] > max_id) {
> >                                       max_id = args.args[0];
> >                               } else {
> > @@ -189,7 +191,28 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
> >                               pd->idx = args.args[0];
> >                               pd->parent = pd_provider;
> >
> > -                             pm_genpd_init(&pd->pd, NULL, true);
> > +                             /*
> > +                              * If TI_SCI_PD_KEEP_BOOT_STATE is set and the
> > +                              * PD has been enabled by the bootloader, set
> > +                              * the PD to GENPD_FLAG_ALWAYS_ON. This will
> > +                              * make sure the PD stays enabled until a driver
> > +                              * takes over and clears the GENPD_FLAG_ALWAYS_ON
> > +                              * flag.
> > +                              */
> > +                             if (args.args_count > 1 &&
> > +                                 args.args[1] & TI_SCI_PD_KEEP_BOOT_STATE) {
> > +                                     /*
> > +                                      * We ignore any error here, and in case
> > +                                      * of error just assume the PD is off.
> > +                                      */
> > +                                     pd_provider->ti_sci->ops.dev_ops.is_on(pd_provider->ti_sci,
> > +                                             pd->idx, NULL, &is_on);
> > +
> > +                                     if (is_on)
> > +                                             pd->pd.flags |= GENPD_FLAG_ALWAYS_ON;
> > +                             }
> > +
> > +                             pm_genpd_init(&pd->pd, NULL, !is_on);
> >
> >                               list_add(&pd->node, &pd_provider->pd_list);
> >                       }
> > diff --git a/include/dt-bindings/soc/ti,sci_pm_domain.h b/include/dt-bindings/soc/ti,sci_pm_domain.h
> > index 8f2a7360b65e..af610208e3a3 100644
> > --- a/include/dt-bindings/soc/ti,sci_pm_domain.h
> > +++ b/include/dt-bindings/soc/ti,sci_pm_domain.h
> > @@ -3,6 +3,7 @@
> >   #ifndef __DT_BINDINGS_TI_SCI_PM_DOMAIN_H
> >   #define __DT_BINDINGS_TI_SCI_PM_DOMAIN_H
> >
> > +#define TI_SCI_PD_KEEP_BOOT_STATE 2
> >   #define TI_SCI_PD_EXCLUSIVE 1
> >   #define TI_SCI_PD_SHARED    0
> >
> >
>

