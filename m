Return-Path: <linux-kernel+bounces-53130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4738284A10B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0337D282EDC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCCC45962;
	Mon,  5 Feb 2024 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLpQhohu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9505044C86;
	Mon,  5 Feb 2024 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154590; cv=none; b=nTdF61Ry5P9dasTcpNNOu1phSlNlrF78o1V2nmSlR8asQxpfZcF5or2cLtIiNK0XqecE6rw2vODsHgR5+P/SHM/e8hnJR1m9c5z76vkYnE3VGPehw6V3OTtDHOfJpFnNZsleQssk1iX0u4Zbw0r+KmZGKvL8cx6ZwUl6239xQXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154590; c=relaxed/simple;
	bh=oug84/jAh2q4sTWNbFpcEEy9Xv7ih9u0DpiD3rJtKas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0SWdxuiCxCjjmH09sZj32anNm3wyaxjxEN7vfcpZPf/2p1a/5CaTghQ3Ya+DZBCIQQlAK3I7vypKn+rlUz9AgNsefyfsqtSXiCuER0AH5EwK+IlYWtldCS03Udq6wFl90Fh5fBgGn7oxZ0P+x/0tc5tPeILQk4T2c4lad1WFIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLpQhohu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF56AC433F1;
	Mon,  5 Feb 2024 17:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707154590;
	bh=oug84/jAh2q4sTWNbFpcEEy9Xv7ih9u0DpiD3rJtKas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TLpQhohu2fCSUvObkfP17e/wahSiCKaz20Q+MpYXn5UisvzkvHLmBnA/55waBi11k
	 HWXg1Wvc1S2jBz6Tew0FsL5oiZD8GqzBw48UNkBZITLZSLcsGi0PWfK2iC50VYETfz
	 z0wxHvbb7Zi89mTEys4JmQpcapbP32OOrDw5E6+awYS/76LIiBgm/jJISoi+FpVz62
	 C+lQ1FwsPVoyTsoV7fiJisHfgfSDf2CBr4yCvLiwCanzABP0ctsZjmMbHGCKgjOkrx
	 mWEgJaUpw0uw+0bhsUUYhCA/zAPKk/N0Vqe5kmWXwYiTg5ROXI/vPuuQ/rWv2Gqay7
	 CZGd67xbnEUtQ==
Date: Mon, 5 Feb 2024 17:36:26 +0000
From: Rob Herring <robh@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Frank Rowand <frowand.list@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kernel-team@android.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] of: property: Improve finding the consumer of a
 remote-endpoint property
Message-ID: <20240205173626.GA3657127-robh@kernel.org>
References: <20240202101326.876070-1-saravanak@google.com>
 <20240202101326.876070-2-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202101326.876070-2-saravanak@google.com>

On Fri, Feb 02, 2024 at 02:13:24AM -0800, Saravana Kannan wrote:
> We have a more accurate function to find the right consumer of a
> remote-endpoint property instead of searching for a parent with
> compatible string property. So, use that instead. While at it, make the
> code to find the consumer a bit more flexible and based on the property
> being parsed.
> 
> Fixes: f7514a663016 ("of: property: fw_devlink: Add support for remote-endpoint")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 52 +++++++++++++------------------------------
>  1 file changed, 15 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 641a40cf5cf3..ba374a1f2072 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1063,36 +1063,6 @@ of_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
>  	return of_device_get_match_data(dev);
>  }
>  
> -static struct device_node *of_get_compat_node(struct device_node *np)
> -{
> -	of_node_get(np);
> -
> -	while (np) {
> -		if (!of_device_is_available(np)) {
> -			of_node_put(np);
> -			np = NULL;
> -		}
> -
> -		if (of_property_present(np, "compatible"))
> -			break;
> -
> -		np = of_get_next_parent(np);
> -	}
> -
> -	return np;
> -}
> -
> -static struct device_node *of_get_compat_node_parent(struct device_node *np)
> -{
> -	struct device_node *parent, *node;
> -
> -	parent = of_get_parent(np);
> -	node = of_get_compat_node(parent);
> -	of_node_put(parent);
> -
> -	return node;
> -}
> -
>  static void of_link_to_phandle(struct device_node *con_np,
>  			      struct device_node *sup_np)
>  {
> @@ -1222,10 +1192,10 @@ static struct device_node *parse_##fname(struct device_node *np,	     \
>   *  parse_prop.prop_name: Name of property holding a phandle value
>   *  parse_prop.index: For properties holding a list of phandles, this is the
>   *		      index into the list
> + * @get_con_dev: If the consumer node containing the property is never converted
> + *		 to a struct device, implement this ops so fw_devlink can use it
> + *		 to find the true consumer.
>   * @optional: Describes whether a supplier is mandatory or not
> - * @node_not_dev: The consumer node containing the property is never converted
> - *		  to a struct device. Instead, parse ancestor nodes for the
> - *		  compatible property to find a node corresponding to a device.
>   *
>   * Returns:
>   * parse_prop() return values are
> @@ -1236,8 +1206,8 @@ static struct device_node *parse_##fname(struct device_node *np,	     \
>  struct supplier_bindings {
>  	struct device_node *(*parse_prop)(struct device_node *np,
>  					  const char *prop_name, int index);
> +	struct device_node *(*get_con_dev)(struct device_node *np);
>  	bool optional;
> -	bool node_not_dev;
>  };
>  
>  DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
> @@ -1328,6 +1298,11 @@ static struct device_node *parse_interrupts(struct device_node *np,
>  	return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args.np;
>  }
>  
> +static struct device_node *get_remote_endpoint_dev(struct device_node *np)
> +{
> +	return to_of_node(fwnode_graph_get_port_parent(of_fwnode_handle(np)));

DT APIs shouldn't depend on fwnode APIs.

Otherwise, this series looks good.

