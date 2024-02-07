Return-Path: <linux-kernel+bounces-56296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1951384C86A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2AF1C23A83
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A1325551;
	Wed,  7 Feb 2024 10:18:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FF2250EC
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301113; cv=none; b=Fz4v5HVs3hLFwL0gkRZKDFmvUn+PzbYFK5bQA7LsCzpJpgk3vgvZ1rAWT386UHorif4ig3oIfbLefz9kkEHZLKUOZV0Q4eG2Hu/oRlH1Mh8ORJmkFdx93FBJGV83k7sMPEleZ+SobC7MMiQ2a9tgGWbwGS30CeMoK4HXk+USYhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301113; c=relaxed/simple;
	bh=tKOaAlqf/y3w03MBRf/BKvge8AF+xbZ8Oq73KQQYy9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcBwNslMyXiE5QgHdXlMbdL63rY7NlNBP8EW2uzbJ9l7m5JCvepk134uxw84NI8L02764AfWw9SGYNcr3MKzRqasFpA3nq9zdWLbUrmxSqQwFMiXcFR2WmmSq0VPvzGMM+yCW03wytlhdkoaW+ItdkRsYjUSNxn3yl5adA0KVNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28B86DA7;
	Wed,  7 Feb 2024 02:19:11 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.26.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94E4B3F7F4;
	Wed,  7 Feb 2024 02:18:26 -0800 (PST)
Date: Wed, 7 Feb 2024 10:18:24 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
	Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com,
	Valentin.Schneider@arm.com, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, Eric Mackay <eric.mackay@oracle.com>,
	dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux@armlinux.org.uk, robin.murphy@arm.com,
	vanshikonda@os.amperecomputing.com, yang@os.amperecomputing.com
Subject: Re: [PATCH REPOST v2] ARM64: Dynamically allocate cpumasks and
 increase supported CPUs to 512
Message-ID: <ZcNY8HuKHMguvdf9@FVFF77S0Q05N.cambridge.arm.com>
References: <e0d41efb-a74e-6bb5-f325-63d42358c802@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0d41efb-a74e-6bb5-f325-63d42358c802@gentwo.org>

Hi CHristoph,

On Tue, Feb 06, 2024 at 10:09:59AM -0800, Christoph Lameter (Ampere) wrote:
> Can we get this merged for 6.9? The patch has been around for awhile now.
>
> Ampere Computing develops high end ARM processor that support an ever
> increasing number of processors. The default 256 processors are
> not enough for our newer products. The default is used by
> distros and therefore our customers cannot use distro kernels because
> the number of processors is not supported.
> 
> One of the objections against earlier patches to increase the limit
> was that the memory use becomes too high. There is a feature called
> CPUMASK_OFFSTACK that configures the cpumasks in the kernel to be
> dynamically allocated. This was used in the X86 architecture in the
> past to enable support for larger CPU configurations up to 8k cpus.
> 
> With that is becomes possible to dynamically size the allocation of
> the cpu bitmaps depending on the quantity of processors detected on
> bootup.
> 
> This patch enables that logic if more than 256 processors
> are configured and increases the default to 512 processors.
> 
> Further increases may be needed if ARM processor vendors start
> supporting more processors. Given the current inflationary trends
> in core counts from multiple processor manufacturers this may occur.

Can we please make this simpler, and clearer e.g.

  Currently defconfig selects NR_CPUS=256, but some vendors (e.g. Ampere
  Computing) are planning to ship systems with 512 CPUs. So that all CPUs on
  these systems can be used with defconfig, we'd like to bump NR_CPUS to 512.
  Therefore this patch increases the default NR_CPUS from 256 to 512.

  As increasing NR_CPUS will increase the size of cpumasks, there's a fear that
  this might have a significant impact on stack usage due to code which places
  cpumasks on the stack. To mitigate that concern, we can select
  CPUMASK_OFFSTACK. As that doesn't seem to be a problem today with
  NR_CPUS=256, we only select this when NR_CPUS > 256.

There's no need for all the other gunk.

However, can you please comment on the impact of this? e.g. 

* Does it make the kernel Image or vmlinux any bigger? 
 
  If you can build the kernel before/after this patch and dump the output of
  'ls -l arch/arm64/boot/Image' and 'size vmlinux', that would be great.

* Does this have any obvious impact on the memory usage of the kernel?

* Does this have any obvious performance impact? e.g. is a kernel build any
  slower/faster before/after this patch on a system with 256-or-fewer CPUs?

> Tested-by: Eric Mackay <eric.mackay@oracle.com>
> Signed-off-by: Christoph Lameter (Ampere) <cl@linux.com>
> 
> ---
> 
> Original post: https://www.spinics.net/lists/linux-mm/msg369701.html
> 
> V1->V2
> 
> - Keep quotation marks
> - Remove whiltespace damage
> - Add tested by
> 
> 
> Index: linux/arch/arm64/Kconfig
> ===================================================================

Can you please use git format-patch? This is more painful than necessary to
apply with usual tools like b4 and git am, and the arm64 maintainers are much
more likely to pick up a patch when they don't have to go outside of their
usual workflow to do so...

> --- linux.orig/arch/arm64/Kconfig
> +++ linux/arch/arm64/Kconfig
> @@ -1407,7 +1407,21 @@ config SCHED_SMT
>   config NR_CPUS
>   	int "Maximum number of CPUs (2-4096)"
>   	range 2 4096
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

This described the semantic of CPUMASK_OFFSTACK, which is not specific to
arm64. If we need a comment, it should explain *why* we select this for more
than 256 CPUs specifically.

I think we can just delete this comment and rely on having that rationale in
the commit message. We can find that with git-log and git-blame.

With this comment gone, the patch itself looks fine to me, but as above the
commit message needs to be cleaned up and it'd be *really* helpful if you could
send this a git formatted patch.

Mark.

> +config CPUMASK_OFFSTACK
> +	def_bool y
> +	depends on NR_CPUS > 256
> 
>   config HOTPLUG_CPU
>   	bool "Support for hot-pluggable CPUs"
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

