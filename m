Return-Path: <linux-kernel+bounces-143083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 797718A33DB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F391F22D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE44D149E1D;
	Fri, 12 Apr 2024 16:27:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F01953811;
	Fri, 12 Apr 2024 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712939248; cv=none; b=boep+kbp5rcIHAQkTWR5IFivsp5osYBWINSud3ZsrJWIoNgsp2IYv4AXvcarYl99erExxutz361WGux3J/c9PhwdcjWdFDUvm0s5VODD4BpN5RzssB8O60Vu5SULskRnK+5SVhhiE3cFTE2eJpYLuVHcX0s/fnSVqZwSXE2DtPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712939248; c=relaxed/simple;
	bh=x1mJqb5IdHWSDUYkH+KJm31NSUYWB60CrRprSbXv6A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivqgMuS32wqXxCqHd+JV02p308Dtm1rPIHTRJQsujIba3UX1b25mtqoMf+QVghQiaNtxlKZuca2jkPfxKnGWU1cUyLUGB8/mTI9SQDeeC2LfVjXWFbtgnR9PJD6m+4aVrbnTOYVOt8hGGh9/abmdZMY+ewEVmchTWwUcPMQgvhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9A92339;
	Fri, 12 Apr 2024 09:27:55 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 746CC3F64C;
	Fri, 12 Apr 2024 09:27:25 -0700 (PDT)
Date: Fri, 12 Apr 2024 17:27:23 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>, rafael@kernel.org,
	lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org
Subject: Re: [External] Re: [PATCH 1/2] ACPI: PPTT: Populate cacheinfo
 entirely with PPTT
Message-ID: <Zhlg67dbl_S1GD0u@bogus>
References: <20240407123829.36474-1-cuiyunhui@bytedance.com>
 <abd135fa-c432-4e37-9792-07a0e17e93d5@arm.com>
 <CAEEQ3w=+C2J0ZS227-1P-B+pe_NRp_3i4c4CxGssiKqbpXx_qw@mail.gmail.com>
 <2cde00c8-7878-45c0-8621-fca4e70c75e7@arm.com>
 <ZhlcYRolZwm7UwJu@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhlcYRolZwm7UwJu@bogus>

On Fri, Apr 12, 2024 at 05:08:01PM +0100, Sudeep Holla wrote:
> diff --git i/arch/riscv/kernel/cacheinfo.c w/arch/riscv/kernel/cacheinfo.c
> index 09e9b88110d1..92ab73ed5234 100644
> --- i/arch/riscv/kernel/cacheinfo.c
> +++ w/arch/riscv/kernel/cacheinfo.c
> @@ -79,6 +79,27 @@ int populate_cache_leaves(unsigned int cpu)
>         struct device_node *prev = NULL;
>         int levels = 1, level = 1;
> 
> +       if (!acpi_disabled) {
> +               int ret, fw_levels, split_levels;
> +
> +               ret = acpi_get_cache_info(cpu, &fw_levels, &split_levels);
> +               if (ret)
> +                       return ret;
> +
> +               /* must be set, so we can drop num_leaves assignment below */
> +               this_cpu_ci->num_leaves = fw_levels + split_levels;
> +
> +               for (idx = 0; level <= this_cpu_ci->num_levels &&
> +                    idx < this_cpu_ci->num_leaves; idx++, level++) {
> +                       if (level <= split_levels) {
> +                               ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
> +                               ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
> +                       } else {
> +                               ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> +                       }
> +               }

Ofcourse we need to add here,
		return 0;

> +       }
> +
>         if (of_property_read_bool(np, "cache-size"))
>                 ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
>         if (of_property_read_bool(np, "i-cache-size"))
> 

-- 
Regards,
Sudeep

