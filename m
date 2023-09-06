Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5728D793A8A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjIFLBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbjIFLB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:01:28 -0400
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D9FAF9;
        Wed,  6 Sep 2023 04:01:23 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,231,1688400000"; 
   d="scan'208";a="64525730"
Date:   Wed, 6 Sep 2023 19:01:06 +0800
From:   Fang Xiang <fangxiang3@xiaomi.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
CC:     Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, "Rob Herring" <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] irqchip/gic-v3: Enable non-coherent
 redistributors/ITSes probing
Message-ID: <ZPhb8vw+/7mNd1gA@oa-fangxiang3.localdomain>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20230905104721.52199-3-lpieralisi@kernel.org>
 <86msy0etul.wl-maz@kernel.org>
 <ZPc6M6Of/dGl4kIT@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPc6M6Of/dGl4kIT@lpieralisi>
X-Originating-IP: [10.237.8.18]
X-ClientProxiedBy: BJ-MBX13.mioffice.cn (10.237.8.133) To BJ-MBX15.mioffice.cn
 (10.237.8.135)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_SOFTFAIL,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 04:24:51PM +0200, Lorenzo Pieralisi wrote:
> On Tue, Sep 05, 2023 at 12:34:58PM +0100, Marc Zyngier wrote:
> > 
> > I came up with the following alternative approach, which is as usual
> > completely untested. It is entirely based on the quirk infrastructure,
> > and doesn't touch the ACPI path at all.
> > 
> > Thanks,
> > 
> > 	M.
> > 
> > diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
> > index 3db4592cda1c..00641e88aa38 100644
> > --- a/drivers/irqchip/irq-gic-common.h
> > +++ b/drivers/irqchip/irq-gic-common.h
> > @@ -29,4 +29,8 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
> >  void gic_enable_of_quirks(const struct device_node *np,
> >  			  const struct gic_quirk *quirks, void *data);
> >  
> > +#define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
> > +#define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
> > +#define RDIST_FLAGS_FORCE_NON_SHAREABLE		(1 << 2)
> > +
> >  #endif /* _IRQ_GIC_COMMON_H */
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> > index e0c2b10d154d..6edf59af757b 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -44,10 +44,6 @@
> >  #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
> >  #define ITS_FLAGS_FORCE_NON_SHAREABLE		(1ULL << 3)
> >  
> > -#define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
> > -#define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
> > -#define RDIST_FLAGS_FORCE_NON_SHAREABLE		(1 << 2)
> > -
> >  #define RD_LOCAL_LPI_ENABLED                    BIT(0)
> >  #define RD_LOCAL_PENDTABLE_PREALLOCATED         BIT(1)
> >  #define RD_LOCAL_MEMRESERVE_DONE                BIT(2)
> > @@ -4754,6 +4750,14 @@ static bool __maybe_unused its_enable_rk3588001(void *data)
> >  	return true;
> >  }
> >  
> > +static bool its_set_non_coherent(void *data)
> > +{
> > +	struct its_node *its = data;
> > +
> > +	its->flags |= ITS_FLAGS_FORCE_NON_SHAREABLE;
> > +	return true;
> > +}
> > +
> >  static const struct gic_quirk its_quirks[] = {
> >  #ifdef CONFIG_CAVIUM_ERRATUM_22375
> >  	{
> > @@ -4808,6 +4812,11 @@ static const struct gic_quirk its_quirks[] = {
> >  		.init   = its_enable_rk3588001,
> >  	},
> >  #endif
> > +	{
> > +		.desc	= "ITS: non-coherent attribute",
> > +		.property = "dma-noncoherent",
> > +		.init	= its_set_non_coherent,
> > +	},
> 
> For the records, that requires adding a gic_enable_of_quirks() call for the
> ITS DT node that at the moment is not needed, something like this:
> 
> -- >8 --
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 25a12b46ce35..3ae3cb9aadd9 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -4826,6 +4826,10 @@ static void its_enable_quirks(struct its_node *its)
>  	u32 iidr = readl_relaxed(its->base + GITS_IIDR);
>  
>  	gic_enable_quirks(iidr, its_quirks, its);
> +
> +	if (is_of_node(its->fwnode_handle))
> +		gic_enable_of_quirks(to_of_node(its->fwnode_handle),
> +				     its_quirks, its);
>  }
>  
>  static int its_save_disable(void)
> 
> >  	{
> >  	}
> >  };
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index eedfa8e9f077..7f518c0ae723 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -1857,6 +1857,14 @@ static bool gic_enable_quirk_arm64_2941627(void *data)
> >  	return true;
> >  }
> >  
> > +static bool rd_set_non_coherent(void *data)
> > +{
> > +	struct gic_chip_data *d = data;
> > +
> > +	d->rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
> > +	return true;
> > +}
> > +
> >  static const struct gic_quirk gic_quirks[] = {
> >  	{
> >  		.desc	= "GICv3: Qualcomm MSM8996 broken firmware",
> > @@ -1923,6 +1931,11 @@ static const struct gic_quirk gic_quirks[] = {
> >  		.mask	= 0xff0f0fff,
> >  		.init	= gic_enable_quirk_arm64_2941627,
> >  	},
> > +	{
> > +		.desc	= "GICv3: non-coherent attribute",
> > +		.property = "dma-noncoherent",
> > +		.init	= rd_set_non_coherent,
> > +	},
> >  	{
> >  	}
> >  };

I have tested this patch above on my deivce and it works well. Looking forward the official release.
