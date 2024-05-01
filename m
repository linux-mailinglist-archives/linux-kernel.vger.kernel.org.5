Return-Path: <linux-kernel+bounces-165169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C05B48B88E4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A3128188C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB51656763;
	Wed,  1 May 2024 11:08:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E522E5644B
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561732; cv=none; b=cxXFkpidzK+f5opra8mUCKuYi9nDDzcock+l5wTvnZlgdLNmlxYznD4rPDNanvZlJNOvxoSJZbMPS66e+jtzVTB75dPAxcAJ7pJzfvFDP2BepTqfGVfz63LC4qu7x5T3nSyiaW8BQNKNcccrfGfYU8+vI5SsuMvWdnC+JKOEN3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561732; c=relaxed/simple;
	bh=DTXkuYlm1URgdAGDGl/LZ8PwWXFanxNREFGd7yquhR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8hnvMiZxvi+jqv6iYJojnfx1QuKrcp+SQ8x4lWUOJhKe0f+on/a/GmOLbU56CSb5BZwZPgsRNT4NqECfbytm48ahHaQyNRfo0QqnPx75/FiTSsbI1EeEBWPPCoV2HknnuSvCfnsd/FirtFE93OuIHhzngG4wvpEyH8d03IZBFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49D4C2F4;
	Wed,  1 May 2024 04:09:15 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FBFB3F793;
	Wed,  1 May 2024 04:08:48 -0700 (PDT)
Date: Wed, 1 May 2024 12:08:45 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: gregkh@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr, linux-kernel@vger.kernel.org,
	rafael@kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH 2/2 v3] drivers: use __free attribute instead of
 of_node_put()
Message-ID: <ZjIivZOzGCNNG5QE@bogus>
References: <20240424125401.oxvt5n64d7a57ge3@bogus>
 <20240501094313.407820-1-vincenzo.mezzela@gmail.com>
 <20240501094313.407820-3-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501094313.407820-3-vincenzo.mezzela@gmail.com>

As mentioned in 1/2, please fix the subject to be more precise.

On Wed, May 01, 2024 at 11:43:13AM +0200, Vincenzo Mezzela wrote:
> Introduce the __free attribute for scope-based resource management.
> Resources allocated with __free are automatically released at the end of
> the scope. This enhancement aims to mitigate memory management issues
> associated with forgetting to release resources by utilizing __free
> instead of of_node_put().
>
> The declaration of the device_node used within the do-while loops is
> moved directly within the loop so that the resource is automatically
> freed at the end of each iteration.
>
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
> ---
>  drivers/base/arch_topology.c | 51 +++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index ea8836f0bb4b..eef26e304018 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/acpi.h>
>  #include <linux/cacheinfo.h>
> +#include <linux/cleanup.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/device.h>
> @@ -513,10 +514,10 @@ core_initcall(free_raw_capacity);
>   */
>  static int __init get_cpu_for_node(struct device_node *node)
>  {
> -	struct device_node *cpu_node;
>  	int cpu;
>
> -	cpu_node = of_parse_phandle(node, "cpu", 0);
> +	struct device_node *cpu_node __free(device_node) =
> +		of_parse_phandle(node, "cpu", 0);

Prefer a blank line after this, applies to all the place where you are
introducing this style.

--
Regards,
Sudeep

