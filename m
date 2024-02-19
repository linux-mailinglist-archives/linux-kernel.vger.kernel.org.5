Return-Path: <linux-kernel+bounces-71668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAC685A8C0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA981C2095C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF253CF7B;
	Mon, 19 Feb 2024 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUed3Kdu"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0FC3CF48
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359680; cv=none; b=lGLTVIb1zXicelAndpI/rgcm9LqwEzv8fOaLr8qqvO7SsUjR3ZDsSOSfi8pJwYHt3zTXX8dsEQ6oCn4RK6iyVaPRfUZJHEogsOyIegjipJEVPQuZNoOQTK5v1P7a605RCdP9FKG7blrBJxPhit+5gf0KF3O3zJ5sMsxL/uXPt90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359680; c=relaxed/simple;
	bh=gEqc7+mZIizrBsHgqf3iXtCjJRR1NKFgsluQ7BMfYkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3mYI4B/VIWl1H3NTRNmFeFyMV4mdx+oRtaDEYcnwwn9nc9URV/OVVs8hGjIfPjFJZXBz0Blg5UXo9Ryb8ebIOtefw2rl5gHsPpWaSptxgmoItJw3k1eWNCfXl1REJr6SmLHLgxBZq0e/GAVn9ZvNNeOjnsdlqyVkB+ePOL3afw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hUed3Kdu; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60495209415so42408387b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708359677; x=1708964477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R2wt3HoshVyMSpGbBwuw8bsOeM4QsAyrGiOVNmA65O8=;
        b=hUed3KduHb81mmXzxHPrN1ZMNnt42OSPyvlxqh/elgvkNyaXgjvMJEq3UKmG2dK+F4
         ym9e7hh2OakiIB/MTJWc+815GQpENfeWEiYacOqls8HqA5qVlRpSbVuiFTD7Brn+qirY
         XKb47LivrcvmXdMlL4A80R2VLQyi1y9YkDMr0sEA3YgNLyHw13sCfOw6MnWniAk6Aj5s
         Bh1UnqY5TsSE03hyMVCTAMRcGd4Uoniv2/L7g2R3MWwS0Oyuhfk/twh/XG7HgrhCrnwH
         qFTWYhlxu3RNl8uXNBKPaORgEzDpr6I1s1nxERE00dhO03Myh7Pbded5P6VoMcX5DaH5
         ivEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708359677; x=1708964477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R2wt3HoshVyMSpGbBwuw8bsOeM4QsAyrGiOVNmA65O8=;
        b=a9wTdaDRH3enzjYhRpFJCu5zTzZQkZ5EYfpIl/6vgOLoiHlp7c6O0DHByB7MoaM8lW
         Z+v4vOZpAG5VJ9DUm+UekvyZGgYH74cUuUjpgosX5hXrEH4TOnKKYZEWkKea0CSgTwyL
         gQObhwLZ+IEXwE7S5vwG5l6NhRdzb8QZWWrmyCP+xGBa7g9tE5H5HSVIT0Qo9No2PJVW
         gCDGKyBB5H0++ImgUpj0HLQjC0U0UttdBGfzrlXiiKxsQMkqsM5Gwc7GykhKMoaEYqRa
         JfL6bbOCPcOqI45KadWn35myZQDvEiINKmc0G3vdhoGbV/zMKoMnHNyPrZ7XTztQS44b
         2ing==
X-Forwarded-Encrypted: i=1; AJvYcCUrD2YDDLqTKcRj385ykRUpw1HAiw2j9p17TXAVHJ2Rpfo6W4TwWP+cbQANBX33uuEgT+GCVCI9Fun7GxggRGuokshU/ycxEnXBXF4I
X-Gm-Message-State: AOJu0YyzzK5DFgaVXZDNx0rHiI5lAR0uRX2ApSWZZ05TC8estctwf2Db
	ItgFKlebSALz7B7qjynlwwYuxOiH7jwS+yoCiHAmv7xDhXZuGViOLPBsoDEwK7/Lin8NgnTjk62
	tx8DVbhcRfE2WZzBE9WHGSOVKTTpqhRMLGdQWmg==
X-Google-Smtp-Source: AGHT+IEQn0c4ED0ZVL1Lxu49TiXak7RXw5M8hdgJfXaLEATpd6+9NC0IG4FzU8TZixBPFIIGr32Qva5v2j6a+srqihE=
X-Received: by 2002:a81:431e:0:b0:607:f785:c5b5 with SMTP id
 q30-20020a81431e000000b00607f785c5b5mr8604211ywa.22.1708359677335; Mon, 19
 Feb 2024 08:21:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219-gic-fix-child-domain-v1-1-09f8fd2d9a8f@linaro.org> <868r3g4fhv.wl-maz@kernel.org>
In-Reply-To: <868r3g4fhv.wl-maz@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 19 Feb 2024 18:21:06 +0200
Message-ID: <CAA8EJpqiN6oRMWhAMMP6EsAeki5KSMbO+XzEtT9YRdJKc9_Gbg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3: handle DOMAIN_BUS_ANY in gic_irq_domain_select
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Feb 2024 at 17:53, Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 19 Feb 2024 14:47:37 +0000,
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> >
> > Before the commit de1ff306dcf4 ("genirq/irqdomain: Remove the param
> > count restriction from select()") the irq_find_matching_fwspec() was
> > handling the DOMAIN_BUS_ANY on its own. After this commit it is a job of
> > the select() callback. However the callback of GICv3 (even though it got
> > modified to handle zero param_count) wasn't prepared to return true for
> > DOMAIN_BUS_ANY bus_token.
> >
> > This breaks probing of any of the child IRQ domains, since
> > platform_irqchip_probe() uses irq_find_matching_host(par_np,
> > DOMAIN_BUS_ANY) to check for the presence of the parent IRQ domain.
> >
> > Fixes: 151378251004 ("irqchip/gic-v3: Make gic_irq_domain_select() robust for zero parameter count")
> > Fixes: de1ff306dcf4 ("genirq/irqdomain: Remove the param count restriction from select()")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/irqchip/irq-gic-v3.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index 6fb276504bcc..e9e9643c653f 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -1696,7 +1696,8 @@ static int gic_irq_domain_select(struct irq_domain *d,
> >
> >       /* Handle pure domain searches */
> >       if (!fwspec->param_count)
> > -             return d->bus_token == bus_token;
> > +             return d->bus_token == bus_token ||
> > +                     bus_token == DOMAIN_BUS_ANY;
> >
> >       /* If this is not DT, then we have a single domain */
> >       if (!is_of_node(fwspec->fwnode))
> >
>
> I really dislike the look of this. If that's the case, any irqchip
> that has a 'select' method (such as imx-intmux) should be similarly
> hacked. And at this point, this should be handled by the core code.
>
> Can you try this instead? I don't have any HW that relies on
> behaviour, but I'd expect this to work.
>
> Thanks,
>
>         M.
>
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index aeb41655d6de..3dd1c871e091 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -449,7 +449,7 @@ struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
>          */
>         mutex_lock(&irq_domain_mutex);
>         list_for_each_entry(h, &irq_domain_list, link) {
> -               if (h->ops->select)
> +               if (h->ops->select && bus_token != DOMAIN_BUS_ANY)
>                         rc = h->ops->select(h, fwspec, bus_token);
>                 else if (h->ops->match)
>                         rc = h->ops->match(h, to_of_node(fwnode), bus_token);

This works. But I wonder if the following change is even better. WDYT?

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index aeb41655d6de..2f0d2700709e 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -449,14 +449,17 @@ struct irq_domain
*irq_find_matching_fwspec(struct irq_fwspec *fwspec,
         */
        mutex_lock(&irq_domain_mutex);
        list_for_each_entry(h, &irq_domain_list, link) {
-               if (h->ops->select)
+               if (fwnode != NULL &&
+                   h->fwnode == fwnode &&
+                   bus_token == DOMAIN_BUS_ANY)
+                       rc = true;
+               else if (h->ops->select)
                        rc = h->ops->select(h, fwspec, bus_token);
                else if (h->ops->match)
                        rc = h->ops->match(h, to_of_node(fwnode), bus_token);
                else
                        rc = ((fwnode != NULL) && (h->fwnode == fwnode) &&
-                             ((bus_token == DOMAIN_BUS_ANY) ||
-                              (h->bus_token == bus_token)));
+                             (h->bus_token == bus_token));

                if (rc) {
                        found = h;


-- 
With best wishes
Dmitry

