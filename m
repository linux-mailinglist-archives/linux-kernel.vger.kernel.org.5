Return-Path: <linux-kernel+bounces-33666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 274AF836CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34A7285282
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0B44F60C;
	Mon, 22 Jan 2024 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RS+FCjUH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5937B3F8D1;
	Mon, 22 Jan 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940291; cv=none; b=V8wxdetAMijvwr78meH/LcWhnOwPqbyonzC0XjZaUljzaKEa9Mrb0n3hnaaQYlFbLllnepp3z3a7UL41VrcKVd9KF4Pr7OR0Fgew06m2ZaQx0rZLr7+R6OB3soFpw7Jgv0Zj2fZnGq1rZkv2dNXl3lIU66lRp1LQWJezBtMOSTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940291; c=relaxed/simple;
	bh=WDAnCV9Ra1LfdfiCu5KUZtV9r+eTg+bc/y0G1AdYs68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHRiNyndcFiZRYmhySFoSYiVjyTHRgXg7uGC9JmDvtXa7b3RvSxFGfLJ3VylLB8/eJfP5c16qB7bZkJ6lv4ZZbtMKrKdi4uOIyNp1pG8TBeqCNDnQpaqspLyYDYjmQWoFMLuAyiTQKl/ioDdulv9Z/DxghHOTPW1VyJgFUmtbGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RS+FCjUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF1EC433A6;
	Mon, 22 Jan 2024 16:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705940290;
	bh=WDAnCV9Ra1LfdfiCu5KUZtV9r+eTg+bc/y0G1AdYs68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RS+FCjUHhg+ZtvA25siHP9vJuHFDG9pNT0ZYWi9BoJg1/RjWftZzKK/17uqQ/Tpx8
	 WJVGnWUQXYyZ7pssaMJpxDdg0oAPCp3l/gD/yf9XD1Vj8ZTfm4Q7PTMBpDY3/5Ec9E
	 UVMYUWswJfsZoai7e4TYHXtXrADib5wJRE0vcOGubW6v6HSQhey3/kX6+5SYFAmAv0
	 qwT+07n2gsqHjAZJCO6LfjPqdiD0cX7rbF/QU7IwILpFkEGhfvpkbhwCm/UnCRi1lQ
	 H3qSb5vGJy4zachG7xZN2IIxxiJm5UIA6a5DNVRInn7d0Gaxv4JBIVMZbPbF8K1yU+
	 Gw05OJGYleqhQ==
Date: Mon, 22 Jan 2024 17:18:04 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, Fang Xiang <fangxiang3@xiaomi.com>,
	Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH v4 3/3] irqchip/gic-v3: Enable non-coherent
 redistributors/ITSes ACPI probing
Message-ID: <Za6VPE76yiR+lb91@lpieralisi>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20231227110038.55453-1-lpieralisi@kernel.org>
 <20231227110038.55453-4-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227110038.55453-4-lpieralisi@kernel.org>

On Wed, Dec 27, 2023 at 12:00:38PM +0100, Lorenzo Pieralisi wrote:

[...]

> @@ -2380,6 +2385,10 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
>  		return -ENOMEM;
>  	gic_request_region(gicc->gicr_base_address, size, "GICR");
>  
> +	if (gic_acpi_non_coherent_flag(gicc->flags,
> +				       ACPI_MADT_GICC_NON_COHERENT))
> +		gic_data.rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
> +

Quick question before reposting it. We run this function for
every GICC entry, I didn't add a check to make sure all GICC
entries have the same flag value, please let me know if that's
OK.

I don't think there is a point in keeping a live variable across
calls to set the flag once for all either.

Thanks,
Lorenzo

>  	gic_acpi_register_redist(gicc->gicr_base_address, redist_base);
>  	return 0;
>  }
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 54189e0e5f41..a292f2bdb693 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -283,6 +283,9 @@ static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
>  	return phys_id == PHYS_CPUID_INVALID;
>  }
>  
> +
> +u8 __init acpi_get_madt_revision(void);
> +
>  /* Validate the processor object's proc_id */
>  bool acpi_duplicate_processor_id(int proc_id);
>  /* Processor _CTS control */
> -- 
> 2.34.1
> 

