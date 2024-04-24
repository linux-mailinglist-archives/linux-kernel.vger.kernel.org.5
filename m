Return-Path: <linux-kernel+bounces-156735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BDB8B0776
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA03284FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1921B1591E4;
	Wed, 24 Apr 2024 10:38:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0CB11CA9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955083; cv=none; b=fSlkuEY7o+C6k9hL4yI1C5pgfbSFr7LRjDD/GI9C/uvKnAsty9APBP/r2/y2RVqjBZDp928xdF5WT7j3FyfzqpsBncsTo49da78VkMu45CUvfiOvRzm/sfk6UZ/q8dWlYGxJKEYAaraEkpiIVbWM/4+u02GIc0q32BRWZNNbGZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955083; c=relaxed/simple;
	bh=8+a6UPEdwewE9o5mDlNnu2PJ+Sp6aVs4oeQrmbfCIN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuI0N/dkUwmdEK9018vQQrnvnvsv/siWXTc3bMjT8lT6xqyCdAGGga5vUZ+lrnETqpm6755+CgIbYROsla+oi8eRdDl3Mrhfozn+LW5nRLdqiv4W0IfJ0D8EWmIqp8ZHiogU0UuY0u3bh3JB4gMfuRVT0YJoIdDw3qC2+WP3+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7EE0339;
	Wed, 24 Apr 2024 03:38:28 -0700 (PDT)
Received: from bogus (unknown [10.57.84.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 671383F73F;
	Wed, 24 Apr 2024 03:37:59 -0700 (PDT)
Date: Wed, 24 Apr 2024 11:37:56 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: gregkh@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
	Sudeep Holla <sudeep.holla@arm.com>, julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org, rafael@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2] drivers: use __free attribute instead of of_node_put()
Message-ID: <20240424103756.jhloae3fcyinyba4@bogus>
References: <20240419140106.3mkayxriqjt2cz5i@bogus>
 <20240422130931.176635-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422130931.176635-1-vincenzo.mezzela@gmail.com>

On Mon, Apr 22, 2024 at 03:09:31PM +0200, Vincenzo Mezzela wrote:
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
> changes in v2:
>     - check loop exit condition within the loop
>     - add cleanup.h header
>
>  drivers/base/arch_topology.c | 150 +++++++++++++++++------------------
>  1 file changed, 73 insertions(+), 77 deletions(-)
>
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 024b78a0cfc1..c9c4af55953e 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -20,6 +20,7 @@
>  #include <linux/rcupdate.h>
>  #include <linux/sched.h>
>  #include <linux/units.h>
> +#include <linux/cleanup.h>
>

Keep it alphabetical. Also since <linux/of.h> does define kfree for
of_node_get(), may not be needed strictly. Sorry for not noticing those
details earlier. I am fine either way, it is good to keep it IMO.

>  #define CREATE_TRACE_POINTS
>  #include <trace/events/thermal_pressure.h>
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
>  	if (!cpu_node)
>  		return -1;
>
> @@ -527,7 +528,6 @@ static int __init get_cpu_for_node(struct device_node *node)
>  		pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
>  			cpu_node, cpumask_pr_args(cpu_possible_mask));
>
> -	of_node_put(cpu_node);
>  	return cpu;
>  }
>
> @@ -538,28 +538,27 @@ static int __init parse_core(struct device_node *core, int package_id,
>  	bool leaf = true;
>  	int i = 0;
>  	int cpu;
> -	struct device_node *t;
>
> -	do {
> +	for(;;) {

Did you run checkpatch.pl on this ? It should have complained here and 3 other
places below.

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
> -			of_node_put(c);
> -			if (ret != 0)
> -				return ret;
> +		if (depth == 0) {
> +			pr_err("%pOF: cpu-map children should be clusters\n", c);
> +			return -EINVAL;
> +		}
> +
> +		if (leaf) {
> +			ret = parse_core(c, package_id, cluster_id, core_id++);
> +		} else {
> +			pr_err("%pOF: Non-leaf cluster with core %s\n",
> +					cluster, name);

Missing alignment here.

--
Regards,
Sudeep

