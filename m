Return-Path: <linux-kernel+bounces-165163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8766D8B88DB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D771C22F87
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75CD5644B;
	Wed,  1 May 2024 11:04:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3B048CE0
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561456; cv=none; b=SjdUq3O4WRFZNkjeJwhrjozWK+qo7SQ1huJ5mLtlvV274hMP8mN8HLUeaEN5+rqVQMQ1Ve0BLKEVHo36cGyjG1rzKiddVv50HtvZuZ7RKC/hi5Hp+NMfDZOqfcibamW/h5ArV5Pe6JYcpxaEi73Zku8FAy64dUL/yY9RokiHkIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561456; c=relaxed/simple;
	bh=BMvyK2ejIFFU2gxEqBo7gg/tUhjpicT6PIvc8ob7Ttg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rf8+syI0VJf0SKrgq8K6TjeCTnSJCQiotFEVMqZeKRWAFRQ/fUtEEpsQ+KVst+FubxqRYKWXcEKl4up52SHYRQkGq8uJ039YmwNo391hsIR14IqVXokQBCIASNyYF5HHy3PRIYJ7tfAVTztLNn4e/sjX1pAHtuhdhVCwizdtBOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0BF32F4;
	Wed,  1 May 2024 04:04:33 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD70B3F793;
	Wed,  1 May 2024 04:04:06 -0700 (PDT)
Date: Wed, 1 May 2024 12:04:04 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: gregkh@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
	Sudeep Holla <sudeep.holla@arm.com>, julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org, rafael@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH 1/2 v3] drivers: reorganize do-while loops
Message-ID: <ZjIhpHKtEs-SughS@bogus>
References: <20240424125401.oxvt5n64d7a57ge3@bogus>
 <20240501094313.407820-1-vincenzo.mezzela@gmail.com>
 <20240501094313.407820-2-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501094313.407820-2-vincenzo.mezzela@gmail.com>

Hi,

$subject seems to be too generic. Please change it to something like
drivers: arch_topology: Refactor do-while loops

On Wed, May 01, 2024 at 11:43:12AM +0200, Vincenzo Mezzela wrote:
> Test c = of_get_child_by_name() failures using "if(!c) break;" instead of
> having the body of the loop all within the "if(c){ }" body.
>

Drop the above description which is clear from the code.

Just mention it as refactor do-while look to move the break condition
inside the loop.

> This modification is required

s/required/in preparation/

> to move the declaration of the device_node
> directly within the loop and take advantage of the automatic cleanup
> feature provided by the __free(device_node) attribute.
> 
> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
> ---
>  drivers/base/arch_topology.c | 107 ++++++++++++++++++-----------------
>  1 file changed, 55 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 024b78a0cfc1..ea8836f0bb4b 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c

[...]

> @@ -599,48 +600,48 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
>  	do {
>  		snprintf(name, sizeof(name), "cluster%d", i);
>  		c = of_get_child_by_name(cluster, name);
> -		if (c) {
> -			leaf = false;
> -			ret = parse_cluster(c, package_id, i, depth + 1);
> -			if (depth > 0)
> -				pr_warn("Topology for clusters of clusters not yet supported\n");
> -			of_node_put(c);
> -			if (ret != 0)
> -				return ret;
> -		}
> +		if (!c)
> +			break;
> +
> +		leaf = false;
> +		ret = parse_cluster(c, package_id, i, depth + 1);
> +		if (depth > 0)
> +			pr_warn("Topology for clusters of clusters not yet supported\n");
> +		of_node_put(c);
> +		if (ret != 0)
> +			return ret;
>  		i++;
> -	} while (c);
> +	} while (1);
>  
>  	/* Now check for cores */
>  	i = 0;
>  	do {
>  		snprintf(name, sizeof(name), "core%d", i);
>  		c = of_get_child_by_name(cluster, name);
> -		if (c) {
> -			has_cores = true;
> -
> -			if (depth == 0) {
> -				pr_err("%pOF: cpu-map children should be clusters\n",
> -				       c);
> -				of_node_put(c);
> -				return -EINVAL;
> -			}
> +		if (!c)
> +			break;
>  
> -			if (leaf) {
> -				ret = parse_core(c, package_id, cluster_id,
> -						 core_id++);
> -			} else {
> -				pr_err("%pOF: Non-leaf cluster with core %s\n",
> -				       cluster, name);
> -				ret = -EINVAL;
> -			}
> +		has_cores = true;
>  
> +		if (depth == 0) {
> +			pr_err("%pOF: cpu-map children should be clusters\n", c);
>  			of_node_put(c);
> -			if (ret != 0)
> -				return ret;
> +			return -EINVAL;
>  		}
> +
> +		if (leaf) {
> +			ret = parse_core(c, package_id, cluster_id, core_id++);
> +		} else {
> +			pr_err("%pOF: Non-leaf cluster with core %s\n",
> +				cluster, name);

Extra space before 'cluster' ? checkpatch must have complain if I am not
reading this correctly.

--
Regards,
Sudeep

