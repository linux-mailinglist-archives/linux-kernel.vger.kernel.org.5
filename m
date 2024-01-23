Return-Path: <linux-kernel+bounces-35391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F03839047
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181AD1C21FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE2A5EE9E;
	Tue, 23 Jan 2024 13:36:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7AE33CC;
	Tue, 23 Jan 2024 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016994; cv=none; b=N/1F6C8HAkDvUtkea5CG7hBHphfrtOs54mD22Pmsrodb0kV6lMzLgWSt5Ujvt0Dq8P8hZi9b0iD/HkWzAbs9axdQK54xKtL2T+45n7O6jwabQwoz1Hx6dt5fLdaot5qF1wFbQRpkYyeea4krJS73ZkC7k0KjkZuHqmCGBewiNcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016994; c=relaxed/simple;
	bh=6iQ0DISi3QxwIKFZR+AE3nFxCcqYjepQqrZX7GECL4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Thhc3BQ+Hx+iQFtbvJDI1AEmQ6MhosdhJiH3u7Gwc1RccdTO+brcULuqa20f7Z930S3cmyS48SAlOe4K5GZDBZdXP8W8NwIKnaDPD/TE/Z7f6BwiAmLRdOqpFPlFL7eHlFro3IfQ4X8cKiIIMb3fpkEMJjqSUSjLCV1ZNzPjqFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 908CF1FB;
	Tue, 23 Jan 2024 05:37:16 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E5083F762;
	Tue, 23 Jan 2024 05:36:29 -0800 (PST)
Message-ID: <9722b637-68d7-4cba-928c-9782dd5413fa@arm.com>
Date: Tue, 23 Jan 2024 13:36:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] irqchip/gic-v3: Enable non-coherent
 redistributors/ITSes ACPI probing
Content-Language: en-GB
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Marc Zyngier <maz@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, Fang Xiang <fangxiang3@xiaomi.com>,
 Robert Moore <robert.moore@intel.com>
References: <20240123110332.112797-1-lpieralisi@kernel.org>
 <20240123110332.112797-2-lpieralisi@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240123110332.112797-2-lpieralisi@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/01/2024 11:03 am, Lorenzo Pieralisi wrote:
> The GIC architecture specification defines a set of registers for
> redistributors and ITSes that control the sharebility and cacheability
> attributes of redistributors/ITSes initiator ports on the interconnect
> (GICR_[V]PROPBASER, GICR_[V]PENDBASER, GITS_BASER<n>).
> 
> Architecturally the GIC provides a means to drive shareability and
> cacheability attributes signals but it is not mandatory for designs to
> wire up the corresponding interconnect signals that control the
> cacheability/shareability of transactions.
> 
> Redistributors and ITSes interconnect ports can be connected to
> non-coherent interconnects that are not able to manage the
> shareability/cacheability attributes; this implicitly makes the
> redistributors and ITSes non-coherent observers.
> 
> To enable non-coherent GIC designs on ACPI based systems, parse the MADT
> GICC/GICR/ITS subtables non-coherent flags to determine whether the
> respective components are non-coherent observers and force the
> shareability attributes to be programmed into the redistributors and
> ITSes registers.
> 
> An ACPI global function (acpi_get_madt_revision()) is added to retrieve
> the MADT revision, in that it is essential to check the MADT revision
> before checking for flags that were added with MADT revision 7 so that
> if the kernel is booted with an ACPI MADT table with revision < 7 it
> skips parsing the newly added flags (that should be zeroed reserved
> values for MADT versions < 7 but they could turn out to be buggy and
> should be ignored).

FWIW,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

I guess the most contentious parts disappeared in Marc's refactoring, so 
what's left seems entirely straightforward and innocuous to me.

I'd also agree that there seems no real value in going out of our way to 
police the firmware for consistency - if at least one entry says to 
apply the quirk, then applying the quirk is the right and safest thing 
to do, so all we could really do on top of that is add extra complexity 
to be able to say "hey, firmware did a silly thing!", but if we're 
starting from the premise that hardware did an inadvisable thing to 
begin with, maybe we should have similarly realistic expectations of the 
corresponding firmware anyway :)

Cheers,
Robin.

> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/acpi/processor_core.c    | 15 +++++++++++++++
>   drivers/irqchip/irq-gic-v3-its.c |  4 ++++
>   drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
>   include/linux/acpi.h             |  3 +++
>   4 files changed, 31 insertions(+)
> 
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> index b203cfe28550..915713c0e9b7 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -215,6 +215,21 @@ phys_cpuid_t __init acpi_map_madt_entry(u32 acpi_id)
>   	return rv;
>   }
>   
> +int __init acpi_get_madt_revision(void)
> +{
> +	struct acpi_table_header *madt = NULL;
> +	int revision;
> +
> +	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_MADT, 0, &madt)))
> +		return -EINVAL;
> +
> +	revision = madt->revision;
> +
> +	acpi_put_table(madt);
> +
> +	return revision;
> +}
> +
>   static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
>   {
>   	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index fec1b58470df..a60c560ce891 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -5591,6 +5591,10 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
>   		goto node_err;
>   	}
>   
> +	if (acpi_get_madt_revision() >= 7 &&
> +	    (its_entry->flags & ACPI_MADT_ITS_NON_COHERENT))
> +		its->flags |= ITS_FLAGS_FORCE_NON_SHAREABLE;
> +
>   	err = its_probe_one(its);
>   	if (!err)
>   		return 0;
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 98b0329b7154..8cb8dff86c12 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -2356,6 +2356,11 @@ gic_acpi_parse_madt_redist(union acpi_subtable_headers *header,
>   		pr_err("Couldn't map GICR region @%llx\n", redist->base_address);
>   		return -ENOMEM;
>   	}
> +
> +	if (acpi_get_madt_revision() >= 7 &&
> +	    (redist->flags & ACPI_MADT_GICR_NON_COHERENT))
> +		gic_data.rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
> +
>   	gic_request_region(redist->base_address, redist->length, "GICR");
>   
>   	gic_acpi_register_redist(redist->base_address, redist_base);
> @@ -2380,6 +2385,10 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
>   		return -ENOMEM;
>   	gic_request_region(gicc->gicr_base_address, size, "GICR");
>   
> +	if (acpi_get_madt_revision() >= 7 &&
> +	    (gicc->flags & ACPI_MADT_GICC_NON_COHERENT))
> +		gic_data.rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
> +
>   	gic_acpi_register_redist(gicc->gicr_base_address, redist_base);
>   	return 0;
>   }
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index b7165e52b3c6..4eedab0e51c3 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -284,6 +284,9 @@ static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
>   	return phys_id == PHYS_CPUID_INVALID;
>   }
>   
> +
> +int __init acpi_get_madt_revision(void);
> +
>   /* Validate the processor object's proc_id */
>   bool acpi_duplicate_processor_id(int proc_id);
>   /* Processor _CTS control */

