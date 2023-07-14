Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3991752FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjGNDBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjGNDBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:01:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1675198A;
        Thu, 13 Jul 2023 20:01:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C91C61BCE;
        Fri, 14 Jul 2023 03:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19B6C433C9;
        Fri, 14 Jul 2023 03:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689303709;
        bh=n6Ru2YG8bQemRizH6Ky5wTkmeR6qJJB/0NqAULIakvk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XINIChuMdJuvALQ7YAu3gJYqBXCiCHMZer+WGmfpNQ9mSWNYGERqfdBQ1o0w7/x+y
         Vb6B2+FS/xn4avf6JG+Bh2s/PfF1PSWA4FQFlXztLY5N2o+wU6OjeMZPzFQPJ0cHVj
         eY6tfNaSNc+yCMS7ef7F91+e/SliZpMU0EEcr0wgIytHyPw5kP/5UxQp8UPs5gwlZp
         Tr4H3MkfTkjfYk+wYGJKpnp7M2BHghzDJLFez5LaRZBwiZAe52pZAsS4ounGrqr/yh
         tXCosdZd5S/J0qycuddS4s5FrytHD1TbvTjtZczp8xjlBPA8tQ724vDs2NRNXLVbGV
         qPbnESPo5/VMw==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51e57870becso1588695a12.2;
        Thu, 13 Jul 2023 20:01:49 -0700 (PDT)
X-Gm-Message-State: ABy/qLbpOuevhqiYz70wC9gYCizr7snR5pNp+AYc1XAXnCSBjNjnF5Rd
        u8cB5da2ioX3EYt080s5cv7kfmJYw37u7NQ3+Zs=
X-Google-Smtp-Source: APBJJlESxE8oxSiU1M+UMSiJRqteeTuy/bBF/en9jhwHrllh1f+wegUn1Vzjsh0/Aoz9PmTEXvah1umANmGo+xLks/k=
X-Received: by 2002:aa7:d511:0:b0:51d:91d2:335b with SMTP id
 y17-20020aa7d511000000b0051d91d2335bmr3668047edq.1.1689303707924; Thu, 13 Jul
 2023 20:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230713032243.2046205-1-maobibo@loongson.cn> <20230713032243.2046205-3-maobibo@loongson.cn>
In-Reply-To: <20230713032243.2046205-3-maobibo@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 14 Jul 2023 11:01:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5wGkRNcwL52pGzAd7S3GnqqkAGxS0BFC-Ezg4F6ycJ-Q@mail.gmail.com>
Message-ID: <CAAhV-H5wGkRNcwL52pGzAd7S3GnqqkAGxS0BFC-Ezg4F6ycJ-Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] irqchip/loongson-eiointc: Simplify irq routing on
 some platforms
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibo,

On Thu, Jul 13, 2023 at 11:23=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> Some LoongArch systems have only one eiointc node such as 3A5000/2K2000
> and qemu virt-machine. If there is only one eiointc node, all cpus can
> access eiointc registers directly; if there is multiple eiointc nodes, ea=
ch
> cpu can only access eiointc belonging to specified node group, so anysend
> or ipi needs to be used to configure irq routing. IRQ routing is simple o=
n
> such systems with one node, hacking method like anysend is not necessary.
>
> This patch provides simpile IRQ routing method for systems with one eioin=
tc
> node, and is tested on 3A5000 board and qemu virt-machine.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  drivers/irqchip/irq-loongson-eiointc.c | 80 ++++++++++++++++++++++++--
>  1 file changed, 74 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq=
-loongson-eiointc.c
> index 603d323b8f8b..e6be9d6a18c8 100644
> --- a/drivers/irqchip/irq-loongson-eiointc.c
> +++ b/drivers/irqchip/irq-loongson-eiointc.c
> @@ -127,6 +127,48 @@ static int eiointc_set_irq_affinity(struct irq_data =
*d, const struct cpumask *af
>         return IRQ_SET_MASK_OK;
>  }
>
> +static int eiointc_single_set_irq_affinity(struct irq_data *d,
> +                               const struct cpumask *affinity, bool forc=
e)
> +{
> +       unsigned int cpu;
> +       unsigned long flags;
> +       uint32_t vector, regaddr, data, coremap;
> +       struct cpumask mask;
> +       struct eiointc_priv *priv =3D d->domain->host_data;
> +
> +       cpumask_and(&mask, affinity, cpu_online_mask);
> +       cpumask_and(&mask, &mask, &priv->cpuspan_map);
> +       if (cpumask_empty(&mask))
> +               return -EINVAL;
> +
> +       cpu =3D cpumask_first(&mask);
> +       vector =3D d->hwirq;
> +       regaddr =3D EIOINTC_REG_ENABLE + ((vector >> 5) << 2);
> +       data =3D ~BIT(vector & 0x1F);
> +       coremap =3D BIT(cpu_logical_map(cpu) % CORES_PER_EIO_NODE);
> +
> +       /*
> +        * simplify for platform with only one eiointc node
> +        * access eiointc registers directly rather than
> +        * use any_send method here
> +        */
> +       raw_spin_lock_irqsave(&affinity_lock, flags);
> +       iocsr_write32(EIOINTC_ALL_ENABLE & data, regaddr);
> +       /*
> +        * get irq route info for continuous 4 vectors
> +        * and set affinity for specified vector
> +        */
> +       data =3D iocsr_read32(EIOINTC_REG_ROUTE + (vector & ~3));
> +       data &=3D  ~(0xff << ((vector & 3) * 8));
> +       data |=3D coremap << ((vector & 3) * 8);
> +       iocsr_write32(data, EIOINTC_REG_ROUTE + (vector & ~3));
> +       iocsr_write32(EIOINTC_ALL_ENABLE, regaddr);
> +       raw_spin_unlock_irqrestore(&affinity_lock, flags);
> +
> +       irq_data_update_effective_affinity(d, cpumask_of(cpu));
> +       return IRQ_SET_MASK_OK;
> +}
> +
>  static int eiointc_index(int node)
>  {
>         int i;
> @@ -238,22 +280,39 @@ static struct irq_chip eiointc_irq_chip =3D {
>         .irq_set_affinity       =3D eiointc_set_irq_affinity,
>  };
>
> +static struct irq_chip eiointc_irq_chipi_single =3D {
What does "chipi" mean? Maybe "chip"?

And from my point of view, the main goal of this patch is to add
"virtual eiointc" support which is different from "real eiointc". So I
think it is better to not touch the "real eiointc" logic, but add a
variant for "virtual eiointc", and then, the name should be
"EIOINTC-V", not "EIOINTC-S".

Huacai

> +       .name                   =3D "EIOINTC-S",
> +       .irq_ack                =3D eiointc_ack_irq,
> +       .irq_mask               =3D eiointc_mask_irq,
> +       .irq_unmask             =3D eiointc_unmask_irq,
> +#ifdef CONFIG_SMP
> +       .irq_set_affinity       =3D eiointc_single_set_irq_affinity,
> +#endif
> +};
> +
>  static int eiointc_domain_alloc(struct irq_domain *domain, unsigned int =
virq,
>                                 unsigned int nr_irqs, void *arg)
>  {
>         int ret;
>         unsigned int i, type;
>         unsigned long hwirq =3D 0;
> -       struct eiointc *priv =3D domain->host_data;
> +       struct eiointc_priv *priv =3D domain->host_data;
> +       struct irq_chip *chip;
>
>         ret =3D irq_domain_translate_onecell(domain, arg, &hwirq, &type);
>         if (ret)
>                 return ret;
>
> -       for (i =3D 0; i < nr_irqs; i++) {
> -               irq_domain_set_info(domain, virq + i, hwirq + i, &eiointc=
_irq_chip,
> +       /*
> +        * use simple irq routing method on single eiointc node
> +        */
> +       if ((nr_pics =3D=3D 1) && (nodes_weight(priv->node_map) =3D=3D 1)=
)
> +               chip =3D &eiointc_irq_chipi_single;
> +       else
> +               chip =3D &eiointc_irq_chip;
> +       for (i =3D 0; i < nr_irqs; i++)
> +               irq_domain_set_info(domain, virq + i, hwirq + i, chip,
>                                         priv, handle_edge_irq, NULL, NULL=
);
> -       }
>
>         return 0;
>  }
> @@ -310,6 +369,7 @@ static void eiointc_resume(void)
>         int i, j;
>         struct irq_desc *desc;
>         struct irq_data *irq_data;
> +       struct irq_chip *chip;
>
>         eiointc_router_init(0);
>
> @@ -319,7 +379,8 @@ static void eiointc_resume(void)
>                         if (desc && desc->handle_irq && desc->handle_irq =
!=3D handle_bad_irq) {
>                                 raw_spin_lock(&desc->lock);
>                                 irq_data =3D irq_domain_get_irq_data(eioi=
ntc_priv[i]->eiointc_domain, irq_desc_get_irq(desc));
> -                               eiointc_set_irq_affinity(irq_data, irq_da=
ta->common->affinity, 0);
> +                               chip =3D irq_data_get_irq_chip(irq_data);
> +                               chip->irq_set_affinity(irq_data, irq_data=
->common->affinity, 0);
>                                 raw_spin_unlock(&desc->lock);
>                         }
>                 }
> @@ -497,7 +558,14 @@ static int __init eiointc_of_init(struct device_node=
 *of_node,
>         priv->node =3D 0;
>         priv->domain_handle =3D of_node_to_fwnode(of_node);
>
> -       ret =3D eiointc_init(priv, parent_irq, 0);
> +       /*
> +        * 2k0500 and 2k2000 has only one eiointc node
> +        * set nodemap as 1 for simple irq routing
> +        *
> +        * Fixme: what about future embedded boards with more than 4 cpus=
?
> +        * nodemap and node need be added in dts like acpi table
> +        */
> +       ret =3D eiointc_init(priv, parent_irq, 1);
>         if (ret < 0)
>                 goto out_free_priv;
>
> --
> 2.27.0
>
