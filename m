Return-Path: <linux-kernel+bounces-151516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82EF8AB001
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64511284504
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C95212D748;
	Fri, 19 Apr 2024 14:01:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CFD12D210
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535276; cv=none; b=LbPH0DYzD4qSPBl1kIi+bKBGrCr4P+Y84DI9hCxMYQKH7n1RDsIEZ/uOGJ/C9K+jRQrzgdJLzjOmnHyT9ww+VreTsX6uELWf+6+F+YP2G3eyqRscbzUn6dXY4Chu9Lw1rp9UAYMjjGpUlANpcCiv6NQOyR1COngOU1L1koaQ6vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535276; c=relaxed/simple;
	bh=wLOKTZFH7Cs8IOd5t8VB+zBBfgEW3A93EXYRDBrMktw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2RALDkfAgmDuWW45GgWadiqzehqe0fOURQ7EsxnKXsc4Vwt9m8ZQh2bKsu/C+sM3GO5sOkh2LbJ87+g79BPoHZ1MlZIXnyyZBEmrcuk8C8IaPo11iBAwzzo5ZYkuu5uikISBEef6GKCFsO2GX+mj6znyqNPuvIV3WvOaILICjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 767EA339;
	Fri, 19 Apr 2024 07:01:38 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E35893F64C;
	Fri, 19 Apr 2024 07:01:08 -0700 (PDT)
Date: Fri, 19 Apr 2024 15:01:06 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr, javier.carrasco.cruz@gmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] drivers: use __free attribute instead of of_node_put()
Message-ID: <20240419140106.3mkayxriqjt2cz5i@bogus>
References: <20240419131956.665769-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419131956.665769-1-vincenzo.mezzela@gmail.com>

On Fri, Apr 19, 2024 at 03:19:56PM +0200, Vincenzo Mezzela wrote:
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
>  drivers/base/arch_topology.c | 41 ++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 024b78a0cfc1..58eeb8183747 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -513,10 +513,10 @@ core_initcall(free_raw_capacity);
>   */
>  static int __init get_cpu_for_node(struct device_node *node)
>  {
> -	struct device_node *cpu_node;
>  	int cpu;
>
> -	cpu_node = of_parse_phandle(node, "cpu", 0);
> +	struct device_node *cpu_node __free(device_node) =

Missing include <linux/cleanup.h> for this ?

> +		of_parse_phandle(node, "cpu", 0);
>  	if (!cpu_node)
>  		return -1;
>
> @@ -527,7 +527,6 @@ static int __init get_cpu_for_node(struct device_node *node)
>  		pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
>  			cpu_node, cpumask_pr_args(cpu_possible_mask));
>
> -	of_node_put(cpu_node);
>  	return cpu;
>  }
>
> @@ -538,11 +537,11 @@ static int __init parse_core(struct device_node *core, int package_id,
>  	bool leaf = true;
>  	int i = 0;
>  	int cpu;
> -	struct device_node *t;
>
>  	do {
>  		snprintf(name, sizeof(name), "thread%d", i);
> -		t = of_get_child_by_name(core, name);
> +		struct device_node *t __free(device_node) =
> +			of_get_child_by_name(core, name);
>  		if (t) {
>  			leaf = false;
>  			cpu = get_cpu_for_node(t);
> @@ -553,10 +552,8 @@ static int __init parse_core(struct device_node *core, int package_id,
>  				cpu_topology[cpu].thread_id = i;
>  			} else if (cpu != -ENODEV) {
>  				pr_err("%pOF: Can't get CPU for thread\n", t);
> -				of_node_put(t);
>  				return -EINVAL;
>  			}
> -			of_node_put(t);

OK you moved 't' inside the loop and this must be taken care, but...

>  		}
>  		i++;
>  	} while (t);

...now, will it even compile if 't' is not in scope ? I think you might get
compilation here. If not, I still don't understand what is the value of
't' being checked there.

> @@ -586,7 +583,6 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
>  	char name[20];
>  	bool leaf = true;
>  	bool has_cores = false;
> -	struct device_node *c;
>  	int core_id = 0;
>  	int i, ret;
>
> @@ -598,13 +594,13 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
>  	i = 0;
>  	do {
>  		snprintf(name, sizeof(name), "cluster%d", i);
> -		c = of_get_child_by_name(cluster, name);
> +		struct device_node *c __free(device_node) =
> +			of_get_child_by_name(cluster, name);
>  		if (c) {
>  			leaf = false;
>  			ret = parse_cluster(c, package_id, i, depth + 1);
>  			if (depth > 0)
>  				pr_warn("Topology for clusters of clusters not yet supported\n");
> -			of_node_put(c);
>  			if (ret != 0)
>  				return ret;
>  		}
> @@ -615,14 +611,14 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
>  	i = 0;
>  	do {
>  		snprintf(name, sizeof(name), "core%d", i);
> -		c = of_get_child_by_name(cluster, name);
> +		struct device_node *c __free(device_node) =
> +			of_get_child_by_name(cluster, name);
>  		if (c) {
>  			has_cores = true;
>
>  			if (depth == 0) {
>  				pr_err("%pOF: cpu-map children should be clusters\n",
>  				       c);
> -				of_node_put(c);
>  				return -EINVAL;
>  			}
>
> @@ -635,7 +631,6 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
>  				ret = -EINVAL;
>  			}
>
> -			of_node_put(c);
>  			if (ret != 0)
>  				return ret;
>  		}
> @@ -651,17 +646,16 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
>  static int __init parse_socket(struct device_node *socket)
>  {
>  	char name[20];
> -	struct device_node *c;
>  	bool has_socket = false;
>  	int package_id = 0, ret;
>
>  	do {
>  		snprintf(name, sizeof(name), "socket%d", package_id);
> -		c = of_get_child_by_name(socket, name);
> +		struct device_node *c __free(device_node) =
> +			of_get_child_by_name(socket, name);
>  		if (c) {
>  			has_socket = true;
>  			ret = parse_cluster(c, package_id, -1, 0);
> -			of_node_put(c);
>  			if (ret != 0)
>  				return ret;
>  		}

Same thing applies to these while(c) loop. I don't understand how this
could work even if it is compiling fine which I doubt.

> @@ -676,11 +670,11 @@ static int __init parse_socket(struct device_node *socket)
>
>  static int __init parse_dt_topology(void)
>  {
> -	struct device_node *cn, *map;
>  	int ret = 0;
>  	int cpu;
>
> -	cn = of_find_node_by_path("/cpus");
> +	struct device_node *cn __free(device_node) =
> +		of_find_node_by_path("/cpus");
>  	if (!cn) {
>  		pr_err("No CPU information found in DT\n");
>  		return 0;
> @@ -690,13 +684,14 @@ static int __init parse_dt_topology(void)
>  	 * When topology is provided cpu-map is essentially a root
>  	 * cluster with restricted subnodes.
>  	 */
> -	map = of_get_child_by_name(cn, "cpu-map");
> +	struct device_node *map __free(devide_node) =

If not above ones, this must fail to compile. Perhaps s/devide_node/device_node/ ?
I now doubt if this patch is compile tested ?

--
Regards,
Sudeep

