Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD6E7B6BEB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjJCOnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjJCOns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:43:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB6FA7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:43:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BF4C433C8;
        Tue,  3 Oct 2023 14:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696344225;
        bh=G8G658/z/MnezbJ0I9MA3FAr63xUz259YJh7oLwtTvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u21jXh1cClToH8RCBry07LM7fnKToJCLLH11olif/vhX23zeHSjsdPbqKIn7v6tGz
         OKhhAvwtavfGdvWErzPnvhVzVHHPE5si4VH6gbhO9FOWzFhS2alGC1ne12sRoosJb3
         Jbq3erPJ7OO0Q4WoxnfObcYMJ4rYlLOWIe60ahW6UCwDwGXFsyObznp+sAM1oEMSBy
         Ks6osFAuVNDfLr9oqzzfCVdVnnTlPRPArpoTCNlhIushWOhCbA0UYB8kLrskJJ6Lkj
         VxyAMlHSw8bAnjH7eI7KzX9j6lmvDU+yl+SzyjFBs4OVoJfU78Yt8T2GXN4GOUqsP8
         kj61SLIHmvhZw==
Date:   Tue, 3 Oct 2023 16:43:40 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>
Subject: Re: [PATCH 2/2] irqchip/gic-v3: Enable non-coherent
 redistributors/ITSes probing
Message-ID: <ZRwonK+01HKJkKXa@lpieralisi>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20230905104721.52199-3-lpieralisi@kernel.org>
 <86msy0etul.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86msy0etul.wl-maz@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 12:34:58PM +0100, Marc Zyngier wrote:

[...]

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

Writing the ACPI bits. We can't use the quirks framework for ACPI (we
don't have "properties" and I don't think we want to attach any to the
fwnode_handle) that's why I generalized its_probe_one() above with an
extra param, that would have simplified ACPI parsing:

- we alloc struct its_node in its_probe_one() but at that stage
  ACPI parsing was already done. If we have to parse the MADT(ITS) again
  just to scan for non-coherent we then have to match the MADT entries
  to the *current* struct its_node* we are handling (MADT parsing
  callbacks don't even take a param - we have to resort to global
  variables - definitely doable but it is a bit ugly).

I will post the resulting code (or something else if I find anything
nicer) but I thought I would mention the reasoning behind the additional
bool flag above.

Lorenzo

> 
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
