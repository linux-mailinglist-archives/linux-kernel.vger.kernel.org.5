Return-Path: <linux-kernel+bounces-144303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450BC8A445B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F1B1C2081F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2351613540C;
	Sun, 14 Apr 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b084hZLB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A72E135A44;
	Sun, 14 Apr 2024 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713114692; cv=none; b=JxK0Yat7ca899Ta7sInm3ze8G1xflrTdpdh83Nsm4ELv7GE6yisdEtLOvdCHrfPXQ3iFVmonKMOdsnA7//PhQxM5NZCneHh4oKeFsnxWYsYoYv7lAJmF06miHOekvOVfHPMd4NR1ZsK2vc+jg8vC4WeNtx4FgZqKaumLF4eY4H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713114692; c=relaxed/simple;
	bh=582ZR/1WmW33NW2c7ENoKf9isC8AbHLnNxVhSWEVwHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlUTGTVP5hb2AkhQs7+GTkYHHCZsM8N8u/CggYB0mRQnMZkIJvfr1jFax6oKfIki6DAHliPJDUvS42z6vPS5AWe4eAA6L+Qg2SGwzaFASP1KDZkWXnYwua3TFc8CK1VJstFgP006k5HkMjO1xM1kuuS9xrgFAq/WvgsUXNEoliM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b084hZLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485CEC072AA;
	Sun, 14 Apr 2024 17:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713114691;
	bh=582ZR/1WmW33NW2c7ENoKf9isC8AbHLnNxVhSWEVwHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b084hZLB5g/NFPHT6/JUfx/EQhWeq8IFSHyrUvCJiGipCVKrkmmFpwxPr2M7C026w
	 D1eGXyFkbtboXwhHWPqjQ4so41yTW6SN36FxCmbudJSCZGsNVWA9AS2HVH0v0j3+th
	 A6mIJ57qui4xQTwGY8T4U+HZlMb9+aGW540ROS1nt3Gk2hOAUvSrk5D2R2fj72udo1
	 /AIPFCAPHh+YaTws2iQwhf3Sea8rol/hAg16+f6IO2QEc16F+fA8TdRvOxgzlID9NM
	 Hn4brPqxNFGwXFI8631t5QuFubLIiZl3+Xrx5w3//5hgBF1V/OkkBr2U6LCuFerx4W
	 swpw4ofb9mfOQ==
Date: Sun, 14 Apr 2024 18:11:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] of: Use scope based of_node_put() cleanups
Message-ID: <20240414181119.32246670@jic23-huawei>
In-Reply-To: <20240409-dt-cleanup-free-v2-3-5b419a4af38d@kernel.org>
References: <20240409-dt-cleanup-free-v2-0-5b419a4af38d@kernel.org>
	<20240409-dt-cleanup-free-v2-3-5b419a4af38d@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Apr 2024 13:59:41 -0500
Rob Herring <robh@kernel.org> wrote:

> Use the relatively new scope based of_node_put() cleanup to simplify
> function exit handling. Doing so reduces the chances of forgetting an
> of_node_put() and simplifies error paths by avoiding the need for goto
> statements.
> 
> Reviewed-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
Hi Rob,

A few follow up comments, but they are all in the 'you could' category.
Either way.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v2:
>  - Also use cleanup for 'dev' in __of_translate_address()
>  - Further simplify of_dma_is_coherent() and of_mmio_is_nonposted()
> ---
>  drivers/of/address.c  | 113 +++++++++++++++++---------------------------------
>  drivers/of/property.c |  22 ++++------
>  2 files changed, 46 insertions(+), 89 deletions(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index ae46a3605904..c350185ceaeb 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -486,34 +486,30 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
>   * device that had registered logical PIO mapping, and the return code is
>   * relative to that node.
>   */
> -static u64 __of_translate_address(struct device_node *dev,
> +static u64 __of_translate_address(struct device_node *node,
>  				  struct device_node *(*get_parent)(const struct device_node *),
>  				  const __be32 *in_addr, const char *rprop,
>  				  struct device_node **host)
>  {
> -	struct device_node *parent = NULL;
> +	struct device_node *dev __free(device_node) = of_node_get(node);
> +	struct device_node *parent __free(device_node) = get_parent(dev);
..

> @@ -572,11 +567,8 @@ static u64 __of_translate_address(struct device_node *dev,
>  
>  		of_dump_addr("one level translation:", addr, na);
>  	}
> - bail:
> -	of_node_put(parent);
> -	of_node_put(dev);
>  
> -	return result;
> +	return OF_BAD_ADDR;

I think this is unreachable as there is no way to exist the loop without returning.
If so (and the compiler complains if you remove this) you could mark it as such
with unreachable();


>  }




>  static int __of_address_to_resource(struct device_node *dev, int index, int bar_no,
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index a6358ee99b74..b73daf81c99d 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c



> @@ -610,9 +607,9 @@ EXPORT_SYMBOL(of_graph_parse_endpoint);
>   */
>  struct device_node *of_graph_get_port_by_id(struct device_node *parent, u32 id)
>  {
> -	struct device_node *node, *port;
> +	struct device_node *port;
> +	struct device_node *node __free(device_node) = of_get_child_by_name(parent, "ports");
>  
> -	node = of_get_child_by_name(parent, "ports");
>  	if (node)
>  		parent = node;
>  
> @@ -626,8 +623,6 @@ struct device_node *of_graph_get_port_by_id(struct device_node *parent, u32 id)
>  			break;
>  	}
>  
> -	of_node_put(node);
> -

You 'could' (feel free to ignore) make this perhaps more obvious wiht.

	for_each_child_of_node_scoped(parent, port) {
		u32 port_id = 0;

		if (!of_node_name_eq(port, "port"))
			continue;
		of_property_read_u32(port, "reg", &port_id);
		if (id == port_id)
			return_ptr(port);
	}
	
	return NULL;

Makes it explicit you are holding a reference on exit if you go vial
the return_ptr() route and that if you don't then in all cases the return value
will be NULL.

>  	return port;
>  }
>  EXPORT_SYMBOL(of_graph_get_port_by_id);
> @@ -655,14 +650,13 @@ struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
>  	 * parent port node.
>  	 */
>  	if (!prev) {
> -		struct device_node *node;
> +		struct device_node *node __free(device_node) =
> +			of_get_child_by_name(parent, "ports");
>  
> -		node = of_get_child_by_name(parent, "ports");
>  		if (node)
>  			parent = node;
>  
>  		port = of_get_child_by_name(parent, "port");
> -		of_node_put(node);
Very trivial but I'd drop the blank line here to more closely associate the check
with retrieval of the port.
>  
>  		if (!port) {
>  			pr_debug("graph: no port node found in %pOF\n", parent);

> 


