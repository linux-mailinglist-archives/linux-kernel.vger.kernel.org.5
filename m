Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC275792ABF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239459AbjIEQl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354520AbjIEMOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:14:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8806012A;
        Tue,  5 Sep 2023 05:14:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FD1E11FB;
        Tue,  5 Sep 2023 05:14:52 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 327123F67D;
        Tue,  5 Sep 2023 05:14:13 -0700 (PDT)
Message-ID: <c069085b-3686-c36e-615b-0783af71a252@arm.com>
Date:   Tue, 5 Sep 2023 13:14:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] irqchip/gic-v3: Enable non-coherent
 redistributors/ITSes probing
Content-Language: en-GB
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20230905104721.52199-3-lpieralisi@kernel.org> <86msy0etul.wl-maz@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <86msy0etul.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 12:34 pm, Marc Zyngier wrote:
> On Tue, 05 Sep 2023 11:47:21 +0100,
> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
>>
>> The GIC architecture specification defines a set of registers
>> for redistributors and ITSes that control the sharebility and
>> cacheability attributes of redistributors/ITSes initiator ports
>> on the interconnect (GICR_[V]PROPBASER, GICR_[V]PENDBASER,
>> GITS_BASER<n>).
>>
>> Architecturally the GIC provides a means to drive shareability
>> and cacheability attributes signals and related IWB/OWB/ISH barriers
>> but it is not mandatory for designs to wire up the corresponding
>> interconnect signals that control the cacheability/shareability
>> of transactions.
>>
>> Redistributors and ITSes interconnect ports can be connected to
>> non-coherent interconnects that are not able to manage the
>> shareability/cacheability attributes; this implicitly makes
>> the redistributors and ITSes non-coherent observers.
>>
>> So far, the GIC driver on probe executes a write to "probe" for
>> the redistributors and ITSes registers shareability bitfields
>> by writing a value (ie InnerShareable - the shareability domain the
>> CPUs are in) and check it back to detect whether the value sticks or
>> not; this hinges on a GIC programming model behaviour that predates the
>> current specifications, that just define shareability bits as writeable
>> but do not guarantee that writing certain shareability values
>> enable the expected behaviour for the redistributors/ITSes
>> memory interconnect ports.
>>
>> To enable non-coherent GIC designs, introduce the "dma-noncoherent"
>> device tree property to allow firmware to describe redistributors and
>> ITSes as non-coherent observers on the memory interconnect and use the
>> property to force the shareability attributes to be programmed into the
>> redistributors and ITSes registers.
>>
>> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Marc Zyngier <maz@kernel.org>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 19 +++++++++++++++----
>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index e0c2b10d154d..758ea3092305 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -5056,7 +5056,8 @@ static int __init its_compute_its_list_map(struct resource *res,
>>   }
>>   
>>   static int __init its_probe_one(struct resource *res,
>> -				struct fwnode_handle *handle, int numa_node)
>> +				struct fwnode_handle *handle, int numa_node,
>> +				bool non_coherent)
>>   {
>>   	struct its_node *its;
>>   	void __iomem *its_base;
>> @@ -5148,7 +5149,7 @@ static int __init its_probe_one(struct resource *res,
>>   	gits_write_cbaser(baser, its->base + GITS_CBASER);
>>   	tmp = gits_read_cbaser(its->base + GITS_CBASER);
>>   
>> -	if (its->flags & ITS_FLAGS_FORCE_NON_SHAREABLE)
>> +	if (its->flags & ITS_FLAGS_FORCE_NON_SHAREABLE || non_coherent)
>>   		tmp &= ~GITS_CBASER_SHAREABILITY_MASK;
> 
> Please use the non_coherent attribute to set the flag, instead of
> using it as some sideband signalling. Not having this information
> stored in the its_node structure makes it harder to debug.
> 
> We have an over-engineered quirk framework, and it should be put to a
> good use.
> 
>>   
>>   	if ((tmp ^ baser) & GITS_CBASER_SHAREABILITY_MASK) {
>> @@ -5356,11 +5357,19 @@ static const struct of_device_id its_device_id[] = {
>>   	{},
>>   };
>>   
>> +static void of_check_rdists_coherent(struct device_node *node)
>> +{
>> +	if (of_property_read_bool(node, "dma-noncoherent"))
>> +		gic_rdists->flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
>> +}
>> +
>>   static int __init its_of_probe(struct device_node *node)
>>   {
>>   	struct device_node *np;
>>   	struct resource res;
>>   
>> +	of_check_rdists_coherent(node);
> 
> It really feels that the flag should instead be communicated by the
> base GIC driver, as it readily communicates the whole rdists structure
> already.
> 
>> +
>>   	/*
>>   	 * Make sure *all* the ITS are reset before we probe any, as
>>   	 * they may be sharing memory. If any of the ITS fails to
>> @@ -5396,7 +5405,8 @@ static int __init its_of_probe(struct device_node *node)
>>   			continue;
>>   		}
>>   
>> -		its_probe_one(&res, &np->fwnode, of_node_to_nid(np));
>> +		its_probe_one(&res, &np->fwnode, of_node_to_nid(np),
>> +			      of_property_read_bool(np, "dma-noncoherent"));
>>   	}
>>   	return 0;
>>   }
>> @@ -5533,7 +5543,8 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
>>   	}
>>   
>>   	err = its_probe_one(&res, dom_handle,
>> -			acpi_get_its_numa_node(its_entry->translation_id));
>> +			acpi_get_its_numa_node(its_entry->translation_id),
>> +			false);
> 
> I came up with the following alternative approach, which is as usual
> completely untested. It is entirely based on the quirk infrastructure,
> and doesn't touch the ACPI path at all.

FWIW I think I agree that looks a bit easier to follow overall, and 
especially since we already have the SoC-based Rockchip variant of this 
using a quirk, having two different ways of carrying the same underlying 
information through certain paths does seem a bit icky.

Cheers,
Robin.

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
>   void gic_enable_of_quirks(const struct device_node *np,
>   			  const struct gic_quirk *quirks, void *data);
>   
> +#define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
> +#define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
> +#define RDIST_FLAGS_FORCE_NON_SHAREABLE		(1 << 2)
> +
>   #endif /* _IRQ_GIC_COMMON_H */
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index e0c2b10d154d..6edf59af757b 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -44,10 +44,6 @@
>   #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
>   #define ITS_FLAGS_FORCE_NON_SHAREABLE		(1ULL << 3)
>   
> -#define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
> -#define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
> -#define RDIST_FLAGS_FORCE_NON_SHAREABLE		(1 << 2)
> -
>   #define RD_LOCAL_LPI_ENABLED                    BIT(0)
>   #define RD_LOCAL_PENDTABLE_PREALLOCATED         BIT(1)
>   #define RD_LOCAL_MEMRESERVE_DONE                BIT(2)
> @@ -4754,6 +4750,14 @@ static bool __maybe_unused its_enable_rk3588001(void *data)
>   	return true;
>   }
>   
> +static bool its_set_non_coherent(void *data)
> +{
> +	struct its_node *its = data;
> +
> +	its->flags |= ITS_FLAGS_FORCE_NON_SHAREABLE;
> +	return true;
> +}
> +
>   static const struct gic_quirk its_quirks[] = {
>   #ifdef CONFIG_CAVIUM_ERRATUM_22375
>   	{
> @@ -4808,6 +4812,11 @@ static const struct gic_quirk its_quirks[] = {
>   		.init   = its_enable_rk3588001,
>   	},
>   #endif
> +	{
> +		.desc	= "ITS: non-coherent attribute",
> +		.property = "dma-noncoherent",
> +		.init	= its_set_non_coherent,
> +	},
>   	{
>   	}
>   };
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index eedfa8e9f077..7f518c0ae723 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1857,6 +1857,14 @@ static bool gic_enable_quirk_arm64_2941627(void *data)
>   	return true;
>   }
>   
> +static bool rd_set_non_coherent(void *data)
> +{
> +	struct gic_chip_data *d = data;
> +
> +	d->rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
> +	return true;
> +}
> +
>   static const struct gic_quirk gic_quirks[] = {
>   	{
>   		.desc	= "GICv3: Qualcomm MSM8996 broken firmware",
> @@ -1923,6 +1931,11 @@ static const struct gic_quirk gic_quirks[] = {
>   		.mask	= 0xff0f0fff,
>   		.init	= gic_enable_quirk_arm64_2941627,
>   	},
> +	{
> +		.desc	= "GICv3: non-coherent attribute",
> +		.property = "dma-noncoherent",
> +		.init	= rd_set_non_coherent,
> +	},
>   	{
>   	}
>   };
> 
