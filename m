Return-Path: <linux-kernel+bounces-71864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5713B85ABFB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850521C216B8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A11B50A6D;
	Mon, 19 Feb 2024 19:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YRX8uO3u"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B95026E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708370925; cv=none; b=Tj/nTbm2CFyzuTfjYgEyAUiGmLSKiI1DN5bI8yV0BLkAiSoAliLwD4fWIFt7I+UkjcwF4lW29uNNi6VEAyq1KjJlU5narlpFfaUd3IWVBMZCrpBgwiOjtqEYZ7D+d8gShRXsDyJeDjX2zKPGVp4umaFSJb8/1j1uoFCtxcAF9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708370925; c=relaxed/simple;
	bh=IAjwCyxBMPci0g0gw4ihhUopvixuhN4VOL+h9fiPS0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMReNpwLC7JrskLTytrOuIitOH3vyayhUvEHXRo1NzqSVbSKoZM+RtbZf+zRA1D0SYR43OL4ym9VI09suyh558eSPvTUAI6lXqLEqRVdLZc/52ckVYADbhT9qMoGx5lHVJsEQRGvVQ8lAJrCzrrUBHAJlgN+ZaMPeMC0+WLKsZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YRX8uO3u; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6083dc087b3so11341547b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708370923; x=1708975723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O7THUmDYQgW5sUdB+plRPPCtHli507znRGIREXrMsPk=;
        b=YRX8uO3uVo0EQEimLgOPbG83q0HzlEqY+ox17yl2sH6CLVRkjy7wU3vhrKWWmRhUqz
         VklTr+ZmqKnaSHP74SzrWZraWVIHYGMzKUixx9SQtNmKUdeV7LRMdIBBxCUWcakYWJUY
         q+nPpVD1N0DuZYAdEBy/bmAkdnX0dP58NwiQYqRAkLSF/+OYTYd0+mHT7bkiAWSUhEWc
         exomWF84/tWSmITTs5aMxUOSh8V25QEpS/OsQ4N3knlQp6t+2GF2JQHHyDi2e2hf1BRa
         K/j9g6O/E4VJInnFREtFvuQDKRTJ/P9J/gNM+sNLeTemNVL6Wu1M7RhVQdgpEOQsnUiW
         lh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708370923; x=1708975723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7THUmDYQgW5sUdB+plRPPCtHli507znRGIREXrMsPk=;
        b=wviQL1o7LDByUTMQTlxdUT+w0Bsl+bOxruKq8YH225FCqZu/xWVy4lGql0dySQm3/n
         DPAbUBv4mZo4lzbHgK5gZsAlEFHeaI8qCurFGHjf73NAW3oduqqWWGVDQtsg7lBz+Xe6
         jNmM2QczAnjPBTgxt+Ow1NpvTu8KDbPPLwMuChBUl14pVneYRnvS37631BHeP+Uhbk4z
         7FSFGkI1P1A58Xn7wZfJdNS34n4UzZUwvg8fLLgv2NDOSq6zEp6rmPtGDFG0FlZQEpVB
         bmPoqD3PD99WrwwJjM4wbfTkxtANsOFzRGdMvqZx2fah4o6c68q+etOW2tBQhJPPd4lx
         k9LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXl8CtQevcYWBwOCzg37fC3jmGxzBbUvpfOnA2KqbY3IYFFPOfQoVNuZXnTt9kl4LZbxS207mk8b+CKoXzh74m9kpxASzSg1f6SPHo
X-Gm-Message-State: AOJu0Yw6HfYvFao11MCGB9YJuK9Md8Cf2cnJhwcw4B3GfpXKmJCmexaE
	1o5DDe8z7gxQJeYh5YQnfhDCVyPtlbUlwHLMlEeJtE/d0AbmxnIa/zuATkBL7dyG3fc1Ujz4/2V
	Q+4wAmIW5P9TfJwkqYGnWdBH9K/WxzLQm81fy+A==
X-Google-Smtp-Source: AGHT+IHfLbLICp5d9jnJFTqYd/KOWxiKrNflnQySStAix6bImUWy6E0guv21H9PIGvCN+JnXSuWWIxjTpW+i5htjDgY=
X-Received: by 2002:a81:ac1c:0:b0:607:f09d:b2af with SMTP id
 k28-20020a81ac1c000000b00607f09db2afmr9775145ywh.1.1708370922949; Mon, 19 Feb
 2024 11:28:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219-gic-fix-child-domain-v1-1-09f8fd2d9a8f@linaro.org>
 <868r3g4fhv.wl-maz@kernel.org> <CAA8EJpqiN6oRMWhAMMP6EsAeki5KSMbO+XzEtT9YRdJKc9_Gbg@mail.gmail.com>
 <865xyk4dgf.wl-maz@kernel.org> <CAA8EJprKUOMwrwawiQ51WKiLCipm72ZcpY6q520kSOg--9oKZg@mail.gmail.com>
 <864je44a1a.wl-maz@kernel.org>
In-Reply-To: <864je44a1a.wl-maz@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 19 Feb 2024 21:28:32 +0200
Message-ID: <CAA8EJppBemsbVsjPvzBK6wp8qDdB-mK_j6HG=sq=USs-zRUNHg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3: handle DOMAIN_BUS_ANY in gic_irq_domain_select
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Feb 2024 at 19:51, Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 19 Feb 2024 17:41:37 +0000,
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Mon, 19 Feb 2024 at 18:37, Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Mon, 19 Feb 2024 16:21:06 +0000,
> > > Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > On Mon, 19 Feb 2024 at 17:53, Marc Zyngier <maz@kernel.org> wrote:
> > > > >
> > > > > On Mon, 19 Feb 2024 14:47:37 +0000,
> > > > > Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> > > > > >
> > > > > > Before the commit de1ff306dcf4 ("genirq/irqdomain: Remove the param
> > > > > > count restriction from select()") the irq_find_matching_fwspec() was
> > > > > > handling the DOMAIN_BUS_ANY on its own. After this commit it is a job of
> > > > > > the select() callback. However the callback of GICv3 (even though it got
> > > > > > modified to handle zero param_count) wasn't prepared to return true for
> > > > > > DOMAIN_BUS_ANY bus_token.
> > > > > >
> > > > > > This breaks probing of any of the child IRQ domains, since
> > > > > > platform_irqchip_probe() uses irq_find_matching_host(par_np,
> > > > > > DOMAIN_BUS_ANY) to check for the presence of the parent IRQ domain.
> > > > > >
> > > > > > Fixes: 151378251004 ("irqchip/gic-v3: Make gic_irq_domain_select() robust for zero parameter count")
> > > > > > Fixes: de1ff306dcf4 ("genirq/irqdomain: Remove the param count restriction from select()")
> > > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > ---
> > > > > >  drivers/irqchip/irq-gic-v3.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > > > > > index 6fb276504bcc..e9e9643c653f 100644
> > > > > > --- a/drivers/irqchip/irq-gic-v3.c
> > > > > > +++ b/drivers/irqchip/irq-gic-v3.c
> > > > > > @@ -1696,7 +1696,8 @@ static int gic_irq_domain_select(struct irq_domain *d,
> > > > > >
> > > > > >       /* Handle pure domain searches */
> > > > > >       if (!fwspec->param_count)
> > > > > > -             return d->bus_token == bus_token;
> > > > > > +             return d->bus_token == bus_token ||
> > > > > > +                     bus_token == DOMAIN_BUS_ANY;
> > > > > >
> > > > > >       /* If this is not DT, then we have a single domain */
> > > > > >       if (!is_of_node(fwspec->fwnode))
> > > > > >
> > > > >
> > > > > I really dislike the look of this. If that's the case, any irqchip
> > > > > that has a 'select' method (such as imx-intmux) should be similarly
> > > > > hacked. And at this point, this should be handled by the core code.
> > > > >
> > > > > Can you try this instead? I don't have any HW that relies on
> > > > > behaviour, but I'd expect this to work.
> > > > >
> > > > > Thanks,
> > > > >
> > > > >         M.
> > > > >
> > > > > diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> > > > > index aeb41655d6de..3dd1c871e091 100644
> > > > > --- a/kernel/irq/irqdomain.c
> > > > > +++ b/kernel/irq/irqdomain.c
> > > > > @@ -449,7 +449,7 @@ struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
> > > > >          */
> > > > >         mutex_lock(&irq_domain_mutex);
> > > > >         list_for_each_entry(h, &irq_domain_list, link) {
> > > > > -               if (h->ops->select)
> > > > > +               if (h->ops->select && bus_token != DOMAIN_BUS_ANY)
> > > > >                         rc = h->ops->select(h, fwspec, bus_token);
> > > > >                 else if (h->ops->match)
> > > > >                         rc = h->ops->match(h, to_of_node(fwnode), bus_token);
> > > >
> > > > This works. But I wonder if the following change is even better. WDYT?
> > > >
> > > > diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> > > > index aeb41655d6de..2f0d2700709e 100644
> > > > --- a/kernel/irq/irqdomain.c
> > > > +++ b/kernel/irq/irqdomain.c
> > > > @@ -449,14 +449,17 @@ struct irq_domain
> > > > *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
> > > >          */
> > > >         mutex_lock(&irq_domain_mutex);
> > > >         list_for_each_entry(h, &irq_domain_list, link) {
> > > > -               if (h->ops->select)
> > > > +               if (fwnode != NULL &&
> > > > +                   h->fwnode == fwnode &&
> > > > +                   bus_token == DOMAIN_BUS_ANY)
> > > > +                       rc = true;
> > > > +               else if (h->ops->select)
> > > >                         rc = h->ops->select(h, fwspec, bus_token);
> > > >                 else if (h->ops->match)
> > > >                         rc = h->ops->match(h, to_of_node(fwnode), bus_token);
> > > >                 else
> > > >                         rc = ((fwnode != NULL) && (h->fwnode == fwnode) &&
> > > > -                             ((bus_token == DOMAIN_BUS_ANY) ||
> > > > -                              (h->bus_token == bus_token)));
> > > > +                             (h->bus_token == bus_token));
> > > >
> > > >                 if (rc) {
> > > >                         found = h;
> > > >
> > >
> > > Can't say I like it either. It duplicates the existing check without
> > > any obvious benefit. Honestly, this code is shit enough that we should
> > > try to make it simpler, not more complex...
> >
> > Only the fwnode conditions are duplicated. And it makes sense: we
> > should check for the DOMAIN_BUS_ANY first, before going to select. I'm
> > not sure whether at some point we'd have to add (&& bus_token !=
> > DOMAIN_BUS_ANY) to the ops->match check.
>
> ops->match should just *die*, and it is not going to see any sort of
> semantic upgrade. Ever. No new code should be added using match.
>
> And look at what my change does. It checks for DOMAIN_BUS_ANY before
> doing anything else, ensuring that the default clause does the job. So
> no, your suggestion doesn't make much sense to me.

Yeah, I was worried about the DOMAIN_BUS_ANY vs match call. If that's
not an issue, your patch looks fine to me.

Please use 'Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>'
with your patch.

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.



-- 
With best wishes
Dmitry

