Return-Path: <linux-kernel+bounces-95972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A563875584
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAA41C2260B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EA2130E55;
	Thu,  7 Mar 2024 17:49:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE65C12FB2B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833762; cv=none; b=OkPQP9GStsw4Rz5Q0767MrQ+W02mPyouHfJMNDYN1JfaCmvTh/dosLyjEGd7CC/yW9/iXIs3dh9xotnF7k2pIjhy4mziQb777fkkmB6gjXSVKesAaaashzNGejiMXkDHVLkE/nCcRTlW5JgzeOsBqC2deuHag+XsNi2YYEeLbeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833762; c=relaxed/simple;
	bh=e8DkOM8yTrydErY5KdZRvraYd3NqQqH7PbG2WVUjR6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9eBFNpa4+HJHPjV0Du6HfjNMAD2njcNcSWfOnIfe439QphNnpmroUWPFzZ6n9aVnIubZo53BwjwqHUKDDj0L/R1j64IAoNRpHVlKn3t00TtuPL/SINB7Zk2QxHDpny0pZPKPUpCXteqVxVAnmMWgEu3xq+4mlCJqzS0ksmCnPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCCF11FB;
	Thu,  7 Mar 2024 09:49:55 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.69.155])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7D073F762;
	Thu,  7 Mar 2024 09:49:15 -0800 (PST)
Date: Thu, 7 Mar 2024 17:49:12 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>, catalin.marinas@arm.com
Cc: Will Deacon <will@kernel.org>, Jonathan.Cameron@huawei.com,
	Matteo.Carlini@arm.com, Valentin.Schneider@arm.com,
	akpm@linux-foundation.org, anshuman.khandual@arm.com,
	Eric Mackay <eric.mackay@oracle.com>, dave.kleikamp@oracle.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux@armlinux.org.uk, robin.murphy@arm.com,
	vanshikonda@os.amperecomputing.com, yang@os.amperecomputing.com
Subject: Re: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
Message-ID: <Zen-GAeTXKTpm4JQ@FVFF77S0Q05N>
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>

Hi Christoph,

On Wed, Mar 06, 2024 at 05:45:04PM -0800, Christoph Lameter (Ampere) wrote:
> Currently defconfig selects NR_CPUS=256, but some vendors (e.g. Ampere
> Computing) are planning to ship systems with 512 CPUs. So that all CPUs on
> these systems can be used with defconfig, we'd like to bump NR_CPUS to 512.
> Therefore this patch increases the default NR_CPUS from 256 to 512.
> 
> As increasing NR_CPUS will increase the size of cpumasks, there's a fear that
> this might have a significant impact on stack usage due to code which places
> cpumasks on the stack. To mitigate that concern, we can select
> CPUMASK_OFFSTACK. As that doesn't seem to be a problem today with
> NR_CPUS=256, we only select this when NR_CPUS > 256.
> 
> CPUMASK_OFFSTACK configures the cpumasks in the kernel to be
> dynamically allocated. This was used in the X86 architecture in the
> past to enable support for larger CPU configurations up to 8k cpus.
> 
> With that is becomes possible to dynamically size the allocation of
> the cpu bitmaps depending on the quantity of processors detected on
> bootup. Memory used for cpumasks will increase if the kernel is
> run on a machine with more cores.
> 
> Further increases may be needed if ARM processor vendors start
> supporting more processors. Given the current inflationary trends
> in core counts from multiple processor manufacturers this may occur.
> 
> There are minor regressions for hackbench. The kernel data size
> for 512 cpus is smaller with offstack than with onstack.
> 
> Benchmark results using hackbench average over 10 runs of
> 
> 	hackbench -s 512 -l 2000 -g 15 -f 25 -P
> 
> on Altra 80 Core
> 
> Support for 256 CPUs on stack. Baseline
> 
> 	7.8564 sec
> 
> Support for 512 CUs on stack.
> 
> 	7.8713 sec + 0.18%
> 
> 512 CPUS offstack
> 
> 	7.8916 sec + 0.44%
> 
> Kernel size comparison:
> 
>    text		   data	    filename				Difference to onstack256 baseline
> 25755648	9589248	    vmlinuz-6.8.0-rc4-onstack256
> 25755648	9607680	    vmlinuz-6.8.0-rc4-onstack512	+0.19%
> 25755648	9603584	    vmlinuz-6.8.0-rc4-offstack512	+0.14%

Thanks for this data; I think that's a strong justification that this isn't
likely to cause a big problem for us, and so I thing it makes sense to go with
this.

I have two minor comments below.

> Tested-by: Eric Mackay <eric.mackay@oracle.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Christoph Lameter (Ampere) <cl@linux.com>
> ---
> 
> 
> Original post: https://www.spinics.net/lists/linux-mm/msg369701.html
> V2: https://lkml.org/lkml/2024/2/7/505
> 
> 
> V1->V2
> 
> - Keep quotation marks
> - Remove whiltespace damage
> - Add tested by
> 
> V2->V3:
> - Add test results
> - Rework descriptions
> 
> 
>  arch/arm64/Kconfig | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index aa7c1d435139..4e767dede47d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1427,7 +1427,21 @@ config SCHED_SMT
>  config NR_CPUS
>  	int "Maximum number of CPUs (2-4096)"
>  	range 2 4096
> -	default "256"
> +	default "512"
> +
> +#
> +# Determines the placement of cpumasks.
> +#
> +# With CPUMASK_OFFSTACK the cpumasks are dynamically allocated.
> +# Useful for machines with lots of core because it avoids increasing
> +# the size of many of the data structures in the kernel.
> +#
> +# If this is off then the cpumasks have a static sizes and are
> +# embedded within data structures.
> +#
> +	config CPUMASK_OFFSTACK
> +	def_bool y
> +	depends on NR_CPUS > 256

As before, can we please delete the comment? That's the general semantic of
CPUMASK_OFFSTACK, not why we're selecting it.

That aside, this config option is defined in lib/Kconfig, so we should select
it rather than redefining it. i.e. this should be:

	select CPUMASK_OFFSTACK if NR_CPUS > 256

Sorry for not spotting that before.

With those changes:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Catalin, are you happy to fix that up when applying?

Mark.

> 
>  config HOTPLUG_CPU
>  	bool "Support for hot-pluggable CPUs"
> -- 
> 2.39.2
> 

