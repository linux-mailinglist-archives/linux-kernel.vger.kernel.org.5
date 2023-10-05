Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBAC7BA334
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbjJEPwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbjJEPvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:51:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC10160799
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:07:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C7BC193E8;
        Thu,  5 Oct 2023 13:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696514396;
        bh=QezRFtV2Aw1Hfuxh5YdjvxwdGdfkr+IUCZmhAtxooIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCXcwZuysxGmmq5zAuIlNqo45wuNOE3VZyUOY4gsOrnlIhotNy0zuryypMA/YkXH6
         dQHf2pyfcYPbZpn/jf6++W1wTUAzTcFtKn/qBE6SqQQgiM+q/E1FwzdR5QJKVZJU34
         DcXeYjc/aUka2JZbpA7kU3JxJIC2LV3zlBPGbbQYQszBi5Cd8tx2lbNdwI4hHH6vSn
         kSXLbi0olvILWM3NKKcwQ4u3uwDzxztFXZptPTQHn3E9CUsWVTkJQ+g35R2W+9pKnf
         rarPiNnvAKqLrr0DwMTE7hXCbiS4Q6xXJSmEh1eAZRVLIw8OVSKJEAMAO9y1fCMbqY
         srm6k7x24MAGw==
Date:   Thu, 5 Oct 2023 15:59:51 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>
Subject: Re: [PATCH 2/2] irqchip/gic-v3: Enable non-coherent
 redistributors/ITSes probing
Message-ID: <ZR7BV1gmWlEae+gq@lpieralisi>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20230905104721.52199-3-lpieralisi@kernel.org>
 <86msy0etul.wl-maz@kernel.org>
 <ZRwonK+01HKJkKXa@lpieralisi>
 <86r0mboduc.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86r0mboduc.wl-maz@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 05:44:27PM +0100, Marc Zyngier wrote:
> On Tue, 03 Oct 2023 15:43:40 +0100,
> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> > 
> > On Tue, Sep 05, 2023 at 12:34:58PM +0100, Marc Zyngier wrote:
> > 
> > [...]
> > 
> > > >  	 * Make sure *all* the ITS are reset before we probe any, as
> > > >  	 * they may be sharing memory. If any of the ITS fails to
> > > > @@ -5396,7 +5405,8 @@ static int __init its_of_probe(struct device_node *node)
> > > >  			continue;
> > > >  		}
> > > >  
> > > > -		its_probe_one(&res, &np->fwnode, of_node_to_nid(np));
> > > > +		its_probe_one(&res, &np->fwnode, of_node_to_nid(np),
> > > > +			      of_property_read_bool(np, "dma-noncoherent"));
> > > >  	}
> > > >  	return 0;
> > > >  }
> > > > @@ -5533,7 +5543,8 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
> > > >  	}
> > > >  
> > > >  	err = its_probe_one(&res, dom_handle,
> > > > -			acpi_get_its_numa_node(its_entry->translation_id));
> > > > +			acpi_get_its_numa_node(its_entry->translation_id),
> > > > +			false);
> > > 
> > > I came up with the following alternative approach, which is as usual
> > > completely untested. It is entirely based on the quirk infrastructure,
> > > and doesn't touch the ACPI path at all.
> > 
> > Writing the ACPI bits. We can't use the quirks framework for ACPI (we
> > don't have "properties" and I don't think we want to attach any to the
> > fwnode_handle) that's why I generalized its_probe_one() above with an
> > extra param, that would have simplified ACPI parsing:
> > 
> > - we alloc struct its_node in its_probe_one() but at that stage
> >   ACPI parsing was already done. If we have to parse the MADT(ITS) again
> >   just to scan for non-coherent we then have to match the MADT entries
> >   to the *current* struct its_node* we are handling (MADT parsing
> >   callbacks don't even take a param - we have to resort to global
> >   variables - definitely doable but it is a bit ugly).
> 
> Well, a more acceptable approach would be for its_probe_one() to take
> an allocated and possibly pre-populated its_node structure (crucially,
> with the quirk flags set), which itself results in a bunch of low
> hanging cleanups, see the patch below.
> 
> I have boot tested it in a DT guest, so it is obviously perfect.

If you don't mind I will post it together with the resulting series.

I have just removed:

/* Stick ACPI quirk handling here */

point taken :)

Thanks,
Lorenzo

> 	M.
> 
> From 978f654d4459adf0b8f3f8e896ca37035b3b114c Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <maz@kernel.org>
> Date: Tue, 3 Oct 2023 17:35:27 +0100
> Subject: [PATCH] irqchip/gic-v3-its: Split allocation from initialisation of
>  its_node
> 
> In order to pave the way for more fancy quirk handling without making
> more of a mess of this terrible driver, split the allocation of the
> ITS descriptor (its_node) from the actual probing.
> 
> This will allow firmware-specific hooks to be added between these
> two points.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 151 +++++++++++++++++++------------
>  1 file changed, 91 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index e0c2b10d154d..bf21383b714e 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -4952,7 +4952,7 @@ static void __init __iomem *its_map_one(struct resource *res, int *err)
>  	return NULL;
>  }
>  
> -static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
> +static int its_init_domain(struct its_node *its)
>  {
>  	struct irq_domain *inner_domain;
>  	struct msi_domain_info *info;
> @@ -4966,7 +4966,7 @@ static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
>  
>  	inner_domain = irq_domain_create_hierarchy(its_parent,
>  						   its->msi_domain_flags, 0,
> -						   handle, &its_domain_ops,
> +						   its->fwnode_handle, &its_domain_ops,
>  						   info);
>  	if (!inner_domain) {
>  		kfree(info);
> @@ -5017,8 +5017,7 @@ static int its_init_vpe_domain(void)
>  	return 0;
>  }
>  
> -static int __init its_compute_its_list_map(struct resource *res,
> -					   void __iomem *its_base)
> +static int __init its_compute_its_list_map(struct its_node *its)
>  {
>  	int its_number;
>  	u32 ctlr;
> @@ -5032,15 +5031,15 @@ static int __init its_compute_its_list_map(struct resource *res,
>  	its_number = find_first_zero_bit(&its_list_map, GICv4_ITS_LIST_MAX);
>  	if (its_number >= GICv4_ITS_LIST_MAX) {
>  		pr_err("ITS@%pa: No ITSList entry available!\n",
> -		       &res->start);
> +		       &its->phys_base);
>  		return -EINVAL;
>  	}
>  
> -	ctlr = readl_relaxed(its_base + GITS_CTLR);
> +	ctlr = readl_relaxed(its->base + GITS_CTLR);
>  	ctlr &= ~GITS_CTLR_ITS_NUMBER;
>  	ctlr |= its_number << GITS_CTLR_ITS_NUMBER_SHIFT;
> -	writel_relaxed(ctlr, its_base + GITS_CTLR);
> -	ctlr = readl_relaxed(its_base + GITS_CTLR);
> +	writel_relaxed(ctlr, its->base + GITS_CTLR);
> +	ctlr = readl_relaxed(its->base + GITS_CTLR);
>  	if ((ctlr & GITS_CTLR_ITS_NUMBER) != (its_number << GITS_CTLR_ITS_NUMBER_SHIFT)) {
>  		its_number = ctlr & GITS_CTLR_ITS_NUMBER;
>  		its_number >>= GITS_CTLR_ITS_NUMBER_SHIFT;
> @@ -5048,75 +5047,50 @@ static int __init its_compute_its_list_map(struct resource *res,
>  
>  	if (test_and_set_bit(its_number, &its_list_map)) {
>  		pr_err("ITS@%pa: Duplicate ITSList entry %d\n",
> -		       &res->start, its_number);
> +		       &its->phys_base, its_number);
>  		return -EINVAL;
>  	}
>  
>  	return its_number;
>  }
>  
> -static int __init its_probe_one(struct resource *res,
> -				struct fwnode_handle *handle, int numa_node)
> +static int __init its_probe_one(struct its_node *its)
>  {
> -	struct its_node *its;
> -	void __iomem *its_base;
> -	u64 baser, tmp, typer;
> +	u64 baser, tmp;
>  	struct page *page;
>  	u32 ctlr;
>  	int err;
>  
> -	its_base = its_map_one(res, &err);
> -	if (!its_base)
> -		return err;
> -
> -	pr_info("ITS %pR\n", res);
> -
> -	its = kzalloc(sizeof(*its), GFP_KERNEL);
> -	if (!its) {
> -		err = -ENOMEM;
> -		goto out_unmap;
> -	}
> -
> -	raw_spin_lock_init(&its->lock);
> -	mutex_init(&its->dev_alloc_lock);
> -	INIT_LIST_HEAD(&its->entry);
> -	INIT_LIST_HEAD(&its->its_device_list);
> -	typer = gic_read_typer(its_base + GITS_TYPER);
> -	its->typer = typer;
> -	its->base = its_base;
> -	its->phys_base = res->start;
>  	if (is_v4(its)) {
> -		if (!(typer & GITS_TYPER_VMOVP)) {
> -			err = its_compute_its_list_map(res, its_base);
> +		if (!(its->typer & GITS_TYPER_VMOVP)) {
> +			err = its_compute_its_list_map(its);
>  			if (err < 0)
> -				goto out_free_its;
> +				goto out;
>  
>  			its->list_nr = err;
>  
>  			pr_info("ITS@%pa: Using ITS number %d\n",
> -				&res->start, err);
> +				&its->phys_base, err);
>  		} else {
> -			pr_info("ITS@%pa: Single VMOVP capable\n", &res->start);
> +			pr_info("ITS@%pa: Single VMOVP capable\n", &its->phys_base);
>  		}
>  
>  		if (is_v4_1(its)) {
> -			u32 svpet = FIELD_GET(GITS_TYPER_SVPET, typer);
> +			u32 svpet = FIELD_GET(GITS_TYPER_SVPET, its->typer);
>  
> -			its->sgir_base = ioremap(res->start + SZ_128K, SZ_64K);
> +			its->sgir_base = ioremap(its->phys_base + SZ_128K, SZ_64K);
>  			if (!its->sgir_base) {
>  				err = -ENOMEM;
> -				goto out_free_its;
> +				goto out;
>  			}
>  
> -			its->mpidr = readl_relaxed(its_base + GITS_MPIDR);
> +			its->mpidr = readl_relaxed(its->base + GITS_MPIDR);
>  
>  			pr_info("ITS@%pa: Using GICv4.1 mode %08x %08x\n",
> -				&res->start, its->mpidr, svpet);
> +				&its->phys_base, its->mpidr, svpet);
>  		}
>  	}
>  
> -	its->numa_node = numa_node;
> -
>  	page = alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO,
>  				get_order(ITS_CMD_QUEUE_SZ));
>  	if (!page) {
> @@ -5125,12 +5099,9 @@ static int __init its_probe_one(struct resource *res,
>  	}
>  	its->cmd_base = (void *)page_address(page);
>  	its->cmd_write = its->cmd_base;
> -	its->fwnode_handle = handle;
>  	its->get_msi_base = its_irq_get_msi_base;
>  	its->msi_domain_flags = IRQ_DOMAIN_FLAG_ISOLATED_MSI;
>  
> -	its_enable_quirks(its);
> -
>  	err = its_alloc_tables(its);
>  	if (err)
>  		goto out_free_cmd;
> @@ -5174,7 +5145,7 @@ static int __init its_probe_one(struct resource *res,
>  		ctlr |= GITS_CTLR_ImDe;
>  	writel_relaxed(ctlr, its->base + GITS_CTLR);
>  
> -	err = its_init_domain(handle, its);
> +	err = its_init_domain(its);
>  	if (err)
>  		goto out_free_tables;
>  
> @@ -5191,11 +5162,8 @@ static int __init its_probe_one(struct resource *res,
>  out_unmap_sgir:
>  	if (its->sgir_base)
>  		iounmap(its->sgir_base);
> -out_free_its:
> -	kfree(its);
> -out_unmap:
> -	iounmap(its_base);
> -	pr_err("ITS@%pa: failed probing (%d)\n", &res->start, err);
> +out:
> +	pr_err("ITS@%pa: failed probing (%d)\n", &its->phys_base, err);
>  	return err;
>  }
>  
> @@ -5356,10 +5324,53 @@ static const struct of_device_id its_device_id[] = {
>  	{},
>  };
>  
> +static struct its_node __init *its_node_init(struct resource *res,
> +					     struct fwnode_handle *handle, int numa_node)
> +{
> +	void __iomem *its_base;
> +	struct its_node *its;
> +	int err;
> +
> +	its_base = its_map_one(res, &err);
> +	if (!its_base)
> +		return NULL;
> +
> +	pr_info("ITS %pR\n", res);
> +
> +	its = kzalloc(sizeof(*its), GFP_KERNEL);
> +	if (!its)
> +		goto out_unmap;
> +
> +	raw_spin_lock_init(&its->lock);
> +	mutex_init(&its->dev_alloc_lock);
> +	INIT_LIST_HEAD(&its->entry);
> +	INIT_LIST_HEAD(&its->its_device_list);
> +
> +	its->typer = gic_read_typer(its_base + GITS_TYPER);
> +	its->base = its_base;
> +	its->phys_base = res->start;
> +
> +	its->numa_node = numa_node;
> +	its->fwnode_handle = handle;
> +
> +	return its;
> +
> +out_unmap:
> +	iounmap(its_base);
> +	return NULL;
> +}
> +
> +static void its_node_destroy(struct its_node *its)
> +{
> +	iounmap(its->base);
> +	kfree(its);
> +}
> +
>  static int __init its_of_probe(struct device_node *node)
>  {
>  	struct device_node *np;
>  	struct resource res;
> +	int err;
>  
>  	/*
>  	 * Make sure *all* the ITS are reset before we probe any, as
> @@ -5369,8 +5380,6 @@ static int __init its_of_probe(struct device_node *node)
>  	 */
>  	for (np = of_find_matching_node(node, its_device_id); np;
>  	     np = of_find_matching_node(np, its_device_id)) {
> -		int err;
> -
>  		if (!of_device_is_available(np) ||
>  		    !of_property_read_bool(np, "msi-controller") ||
>  		    of_address_to_resource(np, 0, &res))
> @@ -5383,6 +5392,8 @@ static int __init its_of_probe(struct device_node *node)
>  
>  	for (np = of_find_matching_node(node, its_device_id); np;
>  	     np = of_find_matching_node(np, its_device_id)) {
> +		struct its_node *its;
> +
>  		if (!of_device_is_available(np))
>  			continue;
>  		if (!of_property_read_bool(np, "msi-controller")) {
> @@ -5396,7 +5407,17 @@ static int __init its_of_probe(struct device_node *node)
>  			continue;
>  		}
>  
> -		its_probe_one(&res, &np->fwnode, of_node_to_nid(np));
> +
> +		its = its_node_init(&res, &np->fwnode, of_node_to_nid(np));
> +		if (!its)
> +			return -ENOMEM;
> +
> +		its_enable_quirks(its);
> +		err = its_probe_one(its);
> +		if (err)  {
> +			its_node_destroy(its);
> +			return err;
> +		}
>  	}
>  	return 0;
>  }
> @@ -5508,6 +5529,7 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
>  {
>  	struct acpi_madt_generic_translator *its_entry;
>  	struct fwnode_handle *dom_handle;
> +	struct its_node *its;
>  	struct resource res;
>  	int err;
>  
> @@ -5532,11 +5554,20 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
>  		goto dom_err;
>  	}
>  
> -	err = its_probe_one(&res, dom_handle,
> -			acpi_get_its_numa_node(its_entry->translation_id));
> +	its = its_node_init(&res, dom_handle,
> +			    acpi_get_its_numa_node(its_entry->translation_id));
> +	if (!its) {
> +		err = -ENOMEM;
> +		goto node_err;
> +	}
> +
> +	/* Stick ACPI quirk handling here */
> +
> +	err = its_probe_one(its);
>  	if (!err)
>  		return 0;
>  
> +node_err:
>  	iort_deregister_domain_token(its_entry->translation_id);
>  dom_err:
>  	irq_domain_free_fwnode(dom_handle);
> -- 
> 2.34.1
> 
> -- 
> Without deviation from the norm, progress is not possible.
