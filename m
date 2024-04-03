Return-Path: <linux-kernel+bounces-129337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59808968B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C371F2A98F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5C21E515;
	Wed,  3 Apr 2024 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8YEFwZb"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4036FE38;
	Wed,  3 Apr 2024 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133096; cv=none; b=KQs7mrsUakRfIbYrcSTwfrn8hbwSLbNrw2kPg59Z28kUI9OdiAZC3+N8t4vzmILWcV6gNYgLvvR5rpA8WCjcMn41TOFLdt6sFSaf8CZAPzOzelTPIZKwl9QUOMa8b4UJXbXXWgkw7m/5Oax6DR4EFzypMwL0L2PMQ1T1CJzk/WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133096; c=relaxed/simple;
	bh=A1G/EIuOOJ8i0ld+6c8uAOSUiMqgigZKLLDXzVvHmWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ok/rOu44NPWMR7j37nYJXUYtRE2quW+MA8q/B9PT2gmD+g6nOpmVytYxn3tUAbHOYE39SoBoxlVI0k22aiVXbb9k45I0Yuhp0qEiFfID1ZqN1L/gnqqJOWTZVDgXeVUOInrK1PclcBmkFiCXFBQSwrLiiOSL4TxpQrqAZob+wYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8YEFwZb; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4d8804a553dso2265824e0c.1;
        Wed, 03 Apr 2024 01:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712133093; x=1712737893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daDbH/60UyjrEKswcrfKWNqjEeojw6n8trzSoXESKFE=;
        b=A8YEFwZbebD8GurWczbEIv9v4Em8k2Qq9OujPo2bJFAVVZZUQQDzSfP1z+wGNK0Sd2
         /mwzgX49JWoxKXrekNYEpowJlLVg8mAImm/aiG+antQ2wkMd6XYLid4iZFa6N4qLMcmJ
         XzuYLUfBIWOTlirxbDFuMJh1FdJlg/xYWcAEdVCzXvEA1S51ChaXxVtNKVw6qQSbUH85
         p6caoxYrRTQoas88OngQrXY/Rv9w38Gufs0s+1gB03THZkUvoU4WqsU2tVGTGUziUsDQ
         NYhpiaFgeyC+NAN3CDVDineEkq3MnE2yHE4SjaEYhY87Nglde9aougEAFvbAUyBkKLpA
         VGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712133093; x=1712737893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daDbH/60UyjrEKswcrfKWNqjEeojw6n8trzSoXESKFE=;
        b=iRWx7YJcSNBGvp5xyAh64ZgTd/NCJeZ5sMwxMXwcXaUpE1JlPbC3Y8QvbXyRmAPVYo
         4iPD3+pPzY3uEzBfHx5PDyF/1QZn4AbTMX2mgRmG2Sp0R/+/Ekj7PEsZDiBilvPU2hXq
         Tg7Tl7xdKEUbv0qIPDtvlNxkZq4bJSI1RWEHnMyANRiDIrZcKRg4E8ZO9BbOxJPVSlsh
         oKE28ZZjHLNN91KB/OLaD4eZUm0zwkgc9TZWuJKE6yvqTVuIX8qAJYS1v7oR+r8BSvrL
         eOhL3qL6KMh/barHHIM/rUsxLPVYy8Ebcc+T1caJhN0gdAv8e52drXfLb7HIiCyx/1ZY
         UKwA==
X-Forwarded-Encrypted: i=1; AJvYcCWvYYN6QTDVhzDAnaTqnc6XUwz+LJX8Pq56LQqM0Z6FXm6bW3UJzeb2o2VI4RSE+1O9GIFGZkU58V2bUfldmigG4tVqo+yasJo8r5z0qKoUFPkg/UVDR9g7EagD+1eS8Jtt7d6FN9+pGg==
X-Gm-Message-State: AOJu0YyDclwl88NHxIYiP6YqaoXlPaAtnmdLHO3d9AjeNoU84rHPBJVt
	EA8k55Yk6xn/T80wX3foPiOKmHgbpv0wPT7OoPwqtnNsYpGfUeED8Hv6hswsqzH6O2Jdnu4I5AN
	w//bJbWh5SCeV+eSILbCgvhr9bA0=
X-Google-Smtp-Source: AGHT+IHJRryfwFuo5gBjI0T5UhyruMMscThBoq8U+Q3bt7qRjGQ6ABaez5cGEHQNFjsIA/5zjf0xpnQyxRQbwVNJaEY=
X-Received: by 2002:a1f:e4c2:0:b0:4d4:eff:454 with SMTP id b185-20020a1fe4c2000000b004d40eff0454mr10249167vkh.1.1712133092081;
 Wed, 03 Apr 2024 01:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222094006.1030709-1-apatel@ventanamicro.com> <20240222094006.1030709-2-apatel@ventanamicro.com>
In-Reply-To: <20240222094006.1030709-2-apatel@ventanamicro.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 3 Apr 2024 09:29:43 +0100
Message-ID: <CA+V-a8tGucbJ87hsMQDEgcor5BzDmB_WnRsEn6c9F_HzucWLXQ@mail.gmail.com>
Subject: Re: [PATCH v14 01/18] irqchip/sifive-plic: Convert PLIC driver into a
 platform driver
To: Anup Patel <apatel@ventanamicro.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, Marc Zyngier <maz@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, Saravana Kannan <saravanak@google.com>, 
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anup,

On Thu, Feb 22, 2024 at 9:41=E2=80=AFAM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> The PLIC driver does not require very early initialization so convert
> it into a platform driver.
>
> After conversion, the PLIC driver is probed after CPUs are brought-up
> so setup cpuhp state after context handler of all online CPUs are
> initialized otherwise PLIC driver crashes for platforms with multiple
> PLIC instances.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 101 ++++++++++++++++++------------
>  1 file changed, 61 insertions(+), 40 deletions(-)
>
This patch seems to have broken things on RZ/Five SoC, after reverting
this patch I get to boot it back again on v6.9-rc2. Looks like there
is some probe order issue after switching to platform driver?

Cheers,
Prabhakar

> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifi=
ve-plic.c
> index 5b7bc4fd9517..7400a07fc479 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -64,6 +64,7 @@
>  #define PLIC_QUIRK_EDGE_INTERRUPT      0
>
>  struct plic_priv {
> +       struct device *dev;
>         struct cpumask lmask;
>         struct irq_domain *irqdomain;
>         void __iomem *regs;
> @@ -406,30 +407,50 @@ static int plic_starting_cpu(unsigned int cpu)
>         return 0;
>  }
>
> -static int __init __plic_init(struct device_node *node,
> -                             struct device_node *parent,
> -                             unsigned long plic_quirks)
> +static const struct of_device_id plic_match[] =3D {
> +       { .compatible =3D "sifive,plic-1.0.0" },
> +       { .compatible =3D "riscv,plic0" },
> +       { .compatible =3D "andestech,nceplic100",
> +         .data =3D (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> +       { .compatible =3D "thead,c900-plic",
> +         .data =3D (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> +       {}
> +};
> +
> +static int plic_probe(struct platform_device *pdev)
>  {
>         int error =3D 0, nr_contexts, nr_handlers =3D 0, i;
> -       u32 nr_irqs;
> -       struct plic_priv *priv;
> +       struct device *dev =3D &pdev->dev;
> +       unsigned long plic_quirks =3D 0;
>         struct plic_handler *handler;
> +       struct plic_priv *priv;
> +       bool cpuhp_setup;
>         unsigned int cpu;
> +       u32 nr_irqs;
> +
> +       if (is_of_node(dev->fwnode)) {
> +               const struct of_device_id *id;
> +
> +               id =3D of_match_node(plic_match, to_of_node(dev->fwnode))=
;
> +               if (id)
> +                       plic_quirks =3D (unsigned long)id->data;
> +       }
>
>         priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
>         if (!priv)
>                 return -ENOMEM;
>
> +       priv->dev =3D dev;
>         priv->plic_quirks =3D plic_quirks;
>
> -       priv->regs =3D of_iomap(node, 0);
> +       priv->regs =3D of_iomap(to_of_node(dev->fwnode), 0);
>         if (WARN_ON(!priv->regs)) {
>                 error =3D -EIO;
>                 goto out_free_priv;
>         }
>
>         error =3D -EINVAL;
> -       of_property_read_u32(node, "riscv,ndev", &nr_irqs);
> +       of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", &nr_i=
rqs);
>         if (WARN_ON(!nr_irqs))
>                 goto out_iounmap;
>
> @@ -439,13 +460,13 @@ static int __init __plic_init(struct device_node *n=
ode,
>         if (!priv->prio_save)
>                 goto out_free_priority_reg;
>
> -       nr_contexts =3D of_irq_count(node);
> +       nr_contexts =3D of_irq_count(to_of_node(dev->fwnode));
>         if (WARN_ON(!nr_contexts))
>                 goto out_free_priority_reg;
>
>         error =3D -ENOMEM;
> -       priv->irqdomain =3D irq_domain_add_linear(node, nr_irqs + 1,
> -                       &plic_irqdomain_ops, priv);
> +       priv->irqdomain =3D irq_domain_add_linear(to_of_node(dev->fwnode)=
, nr_irqs + 1,
> +                                               &plic_irqdomain_ops, priv=
);
>         if (WARN_ON(!priv->irqdomain))
>                 goto out_free_priority_reg;
>
> @@ -455,7 +476,7 @@ static int __init __plic_init(struct device_node *nod=
e,
>                 int cpu;
>                 unsigned long hartid;
>
> -               if (of_irq_parse_one(node, i, &parent)) {
> +               if (of_irq_parse_one(to_of_node(dev->fwnode), i, &parent)=
) {
>                         pr_err("failed to parse parent for context %d.\n"=
, i);
>                         continue;
>                 }
> @@ -491,7 +512,7 @@ static int __init __plic_init(struct device_node *nod=
e,
>
>                 /* Find parent domain and register chained handler */
>                 if (!plic_parent_irq && irq_find_host(parent.np)) {
> -                       plic_parent_irq =3D irq_of_parse_and_map(node, i)=
;
> +                       plic_parent_irq =3D irq_of_parse_and_map(to_of_no=
de(dev->fwnode), i);
>                         if (plic_parent_irq)
>                                 irq_set_chained_handler(plic_parent_irq,
>                                                         plic_handle_irq);
> @@ -533,20 +554,29 @@ static int __init __plic_init(struct device_node *n=
ode,
>
>         /*
>          * We can have multiple PLIC instances so setup cpuhp state
> -        * and register syscore operations only when context handler
> -        * for current/boot CPU is present.
> +        * and register syscore operations only once after context
> +        * handlers of all online CPUs are initialized.
>          */
> -       handler =3D this_cpu_ptr(&plic_handlers);
> -       if (handler->present && !plic_cpuhp_setup_done) {
> -               cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
> -                                 "irqchip/sifive/plic:starting",
> -                                 plic_starting_cpu, plic_dying_cpu);
> -               register_syscore_ops(&plic_irq_syscore_ops);
> -               plic_cpuhp_setup_done =3D true;
> +       if (!plic_cpuhp_setup_done) {
> +               cpuhp_setup =3D true;
> +               for_each_online_cpu(cpu) {
> +                       handler =3D per_cpu_ptr(&plic_handlers, cpu);
> +                       if (!handler->present) {
> +                               cpuhp_setup =3D false;
> +                               break;
> +                       }
> +               }
> +               if (cpuhp_setup) {
> +                       cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTI=
NG,
> +                                         "irqchip/sifive/plic:starting",
> +                                         plic_starting_cpu, plic_dying_c=
pu);
> +                       register_syscore_ops(&plic_irq_syscore_ops);
> +                       plic_cpuhp_setup_done =3D true;
> +               }
>         }
>
> -       pr_info("%pOFP: mapped %d interrupts with %d handlers for"
> -               " %d contexts.\n", node, nr_irqs, nr_handlers, nr_context=
s);
> +       pr_info("%pOFP: mapped %d interrupts with %d handlers for %d cont=
exts.\n",
> +               to_of_node(dev->fwnode), nr_irqs, nr_handlers, nr_context=
s);
>         return 0;
>
>  out_free_enable_reg:
> @@ -563,20 +593,11 @@ static int __init __plic_init(struct device_node *n=
ode,
>         return error;
>  }
>
> -static int __init plic_init(struct device_node *node,
> -                           struct device_node *parent)
> -{
> -       return __plic_init(node, parent, 0);
> -}
> -
> -IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
> -IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy sy=
stems */
> -
> -static int __init plic_edge_init(struct device_node *node,
> -                                struct device_node *parent)
> -{
> -       return __plic_init(node, parent, BIT(PLIC_QUIRK_EDGE_INTERRUPT));
> -}
> -
> -IRQCHIP_DECLARE(andestech_nceplic100, "andestech,nceplic100", plic_edge_=
init);
> -IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_edge_init);
> +static struct platform_driver plic_driver =3D {
> +       .driver =3D {
> +               .name           =3D "riscv-plic",
> +               .of_match_table =3D plic_match,
> +       },
> +       .probe =3D plic_probe,
> +};
> +builtin_platform_driver(plic_driver);
> --
> 2.34.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

