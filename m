Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F61979270D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241129AbjIEQJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354546AbjIEMa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:30:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AC01A8;
        Tue,  5 Sep 2023 05:30:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6222A60686;
        Tue,  5 Sep 2023 12:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F76C433C7;
        Tue,  5 Sep 2023 12:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693917052;
        bh=XVjB2VFyI9nR4TZH4dDE27+cJRmpMDgQ1jHk4eP2D58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YNZOfWLyKphVS6lTrn0+3H4kWLlg0Usn081qto/TJxUPOqVLANp3k9EpHvQcx+War
         7VfCB0WLb655Txb1NeWhxCSHqYFdy4ihGeeOQ3E74NX8whQAzlOp6HvQl2zLgZHa7l
         izCgA1te1uLBCpbFZ8LNKlQ+Nou1PfpRG6nfZhflNHQomf1dqL/I1tFsjc1INgB0lV
         r2Kg6ozybXDsEK9g5U39cLhMVQHVtxp1Le2MLJSZIYcT+hTwcllBDYhmRPOXyduIP4
         oMxnYcxiLnnkQrdnKinCdpXLvjMnS32iT2moeYz5/pTWVGpt0zGgNfKuQSH6owngyb
         YtfzhfBVFjNLg==
Date:   Tue, 5 Sep 2023 14:30:47 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>
Subject: Re: [PATCH 2/2] irqchip/gic-v3: Enable non-coherent
 redistributors/ITSes probing
Message-ID: <ZPcfd9I4NvXceJTb@lpieralisi>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20230905104721.52199-3-lpieralisi@kernel.org>
 <86msy0etul.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86msy0etul.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 12:34:58PM +0100, Marc Zyngier wrote:
> On Tue, 05 Sep 2023 11:47:21 +0100,
> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> > 
> > The GIC architecture specification defines a set of registers
> > for redistributors and ITSes that control the sharebility and
> > cacheability attributes of redistributors/ITSes initiator ports
> > on the interconnect (GICR_[V]PROPBASER, GICR_[V]PENDBASER,
> > GITS_BASER<n>).
> > 
> > Architecturally the GIC provides a means to drive shareability
> > and cacheability attributes signals and related IWB/OWB/ISH barriers
> > but it is not mandatory for designs to wire up the corresponding
> > interconnect signals that control the cacheability/shareability
> > of transactions.
> > 
> > Redistributors and ITSes interconnect ports can be connected to
> > non-coherent interconnects that are not able to manage the
> > shareability/cacheability attributes; this implicitly makes
> > the redistributors and ITSes non-coherent observers.
> > 
> > So far, the GIC driver on probe executes a write to "probe" for
> > the redistributors and ITSes registers shareability bitfields
> > by writing a value (ie InnerShareable - the shareability domain the
> > CPUs are in) and check it back to detect whether the value sticks or
> > not; this hinges on a GIC programming model behaviour that predates the
> > current specifications, that just define shareability bits as writeable
> > but do not guarantee that writing certain shareability values
> > enable the expected behaviour for the redistributors/ITSes
> > memory interconnect ports.
> > 
> > To enable non-coherent GIC designs, introduce the "dma-noncoherent"
> > device tree property to allow firmware to describe redistributors and
> > ITSes as non-coherent observers on the memory interconnect and use the
> > property to force the shareability attributes to be programmed into the
> > redistributors and ITSes registers.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/irqchip/irq-gic-v3-its.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> > index e0c2b10d154d..758ea3092305 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -5056,7 +5056,8 @@ static int __init its_compute_its_list_map(struct resource *res,
> >  }
> >  
> >  static int __init its_probe_one(struct resource *res,
> > -				struct fwnode_handle *handle, int numa_node)
> > +				struct fwnode_handle *handle, int numa_node,
> > +				bool non_coherent)
> >  {
> >  	struct its_node *its;
> >  	void __iomem *its_base;
> > @@ -5148,7 +5149,7 @@ static int __init its_probe_one(struct resource *res,
> >  	gits_write_cbaser(baser, its->base + GITS_CBASER);
> >  	tmp = gits_read_cbaser(its->base + GITS_CBASER);
> >  
> > -	if (its->flags & ITS_FLAGS_FORCE_NON_SHAREABLE)
> > +	if (its->flags & ITS_FLAGS_FORCE_NON_SHAREABLE || non_coherent)
> >  		tmp &= ~GITS_CBASER_SHAREABILITY_MASK;
> 
> Please use the non_coherent attribute to set the flag, instead of
> using it as some sideband signalling. Not having this information
> stored in the its_node structure makes it harder to debug.
> 
> We have an over-engineered quirk framework, and it should be put to a
> good use.

That makes sense, I will do - I was wondering though whether this
is a quirk or a binding that describes the architecture because
the architecture can't provide that information.

That's the reason why I have not implemented it as a quirk but
obviously that's exactly the feedback I need.

> 
> >  
> >  	if ((tmp ^ baser) & GITS_CBASER_SHAREABILITY_MASK) {
> > @@ -5356,11 +5357,19 @@ static const struct of_device_id its_device_id[] = {
> >  	{},
> >  };
> >  
> > +static void of_check_rdists_coherent(struct device_node *node)
> > +{
> > +	if (of_property_read_bool(node, "dma-noncoherent"))
> > +		gic_rdists->flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
> > +}
> > +
> >  static int __init its_of_probe(struct device_node *node)
> >  {
> >  	struct device_node *np;
> >  	struct resource res;
> >  
> > +	of_check_rdists_coherent(node);
> 
> It really feels that the flag should instead be communicated by the
> base GIC driver, as it readily communicates the whole rdists structure
> already.

Yes I had the same feeling while writing the code but the patch
below (if we treat this as quirk) is already much cleaner.

> > +
> >  	/*
> >  	 * Make sure *all* the ITS are reset before we probe any, as
> >  	 * they may be sharing memory. If any of the ITS fails to
> > @@ -5396,7 +5405,8 @@ static int __init its_of_probe(struct device_node *node)
> >  			continue;
> >  		}
> >  
> > -		its_probe_one(&res, &np->fwnode, of_node_to_nid(np));
> > +		its_probe_one(&res, &np->fwnode, of_node_to_nid(np),
> > +			      of_property_read_bool(np, "dma-noncoherent"));
> >  	}
> >  	return 0;
> >  }
> > @@ -5533,7 +5543,8 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
> >  	}
> >  
> >  	err = its_probe_one(&res, dom_handle,
> > -			acpi_get_its_numa_node(its_entry->translation_id));
> > +			acpi_get_its_numa_node(its_entry->translation_id),
> > +			false);
> 
> I came up with the following alternative approach, which is as usual
> completely untested. It is entirely based on the quirk infrastructure,
> and doesn't touch the ACPI path at all.

The patch below makes sense and it is much cleaner - provided we
consider this a quirk, which I am not sure it is, that's the only
question I have.

Thanks,
Lorenzo

> Thanks,
> 
> 	M.
> 
> diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
> index 3db4592cda1c..00641e88aa38 100644
> --- a/drivers/irqchip/irq-gic-common.h
> +++ b/drivers/irqchip/irq-gic-common.h
> @@ -29,4 +29,8 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
>  void gic_enable_of_quirks(const struct device_node *np,
>  			  const struct gic_quirk *quirks, void *data);
>  
> +#define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
> +#define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
> +#define RDIST_FLAGS_FORCE_NON_SHAREABLE		(1 << 2)
> +
>  #endif /* _IRQ_GIC_COMMON_H */
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index e0c2b10d154d..6edf59af757b 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -44,10 +44,6 @@
>  #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
>  #define ITS_FLAGS_FORCE_NON_SHAREABLE		(1ULL << 3)
>  
> -#define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
> -#define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
> -#define RDIST_FLAGS_FORCE_NON_SHAREABLE		(1 << 2)
> -
>  #define RD_LOCAL_LPI_ENABLED                    BIT(0)
>  #define RD_LOCAL_PENDTABLE_PREALLOCATED         BIT(1)
>  #define RD_LOCAL_MEMRESERVE_DONE                BIT(2)
> @@ -4754,6 +4750,14 @@ static bool __maybe_unused its_enable_rk3588001(void *data)
>  	return true;
>  }
>  
> +static bool its_set_non_coherent(void *data)
> +{
> +	struct its_node *its = data;
> +
> +	its->flags |= ITS_FLAGS_FORCE_NON_SHAREABLE;
> +	return true;
> +}
> +
>  static const struct gic_quirk its_quirks[] = {
>  #ifdef CONFIG_CAVIUM_ERRATUM_22375
>  	{
> @@ -4808,6 +4812,11 @@ static const struct gic_quirk its_quirks[] = {
>  		.init   = its_enable_rk3588001,
>  	},
>  #endif
> +	{
> +		.desc	= "ITS: non-coherent attribute",
> +		.property = "dma-noncoherent",
> +		.init	= its_set_non_coherent,
> +	},
>  	{
>  	}
>  };
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index eedfa8e9f077..7f518c0ae723 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1857,6 +1857,14 @@ static bool gic_enable_quirk_arm64_2941627(void *data)
>  	return true;
>  }
>  
> +static bool rd_set_non_coherent(void *data)
> +{
> +	struct gic_chip_data *d = data;
> +
> +	d->rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
> +	return true;
> +}
> +
>  static const struct gic_quirk gic_quirks[] = {
>  	{
>  		.desc	= "GICv3: Qualcomm MSM8996 broken firmware",
> @@ -1923,6 +1931,11 @@ static const struct gic_quirk gic_quirks[] = {
>  		.mask	= 0xff0f0fff,
>  		.init	= gic_enable_quirk_arm64_2941627,
>  	},
> +	{
> +		.desc	= "GICv3: non-coherent attribute",
> +		.property = "dma-noncoherent",
> +		.init	= rd_set_non_coherent,
> +	},
>  	{
>  	}
>  };
> 
> -- 
> Without deviation from the norm, progress is not possible.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
