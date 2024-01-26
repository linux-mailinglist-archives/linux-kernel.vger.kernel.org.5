Return-Path: <linux-kernel+bounces-40430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0145D83E007
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F001C22446
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0464E20312;
	Fri, 26 Jan 2024 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkjUO1wI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435B61EB5C;
	Fri, 26 Jan 2024 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290121; cv=none; b=hdH3OsG7eYdEiocAAOcO2yRBmCQz3uutr1hVo9J7hJ7jzVGvy9ik9vS3ROBzNy+4buEMK/mI4eHVgAwlCk85D+2ju6XENzycCuzGek+pAUs/jwzUAzWlLajEDJYyqkrJo7tywChWvzEQZf/DWYyezgqt/8flMaNUQgTyewdDFaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290121; c=relaxed/simple;
	bh=yvFNWEbhdJcYieMLRciY5V8W+w9c/qsqKUENofx8bB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyzZhcTBmGt9GlFMWS4F8Gelfw3ChMah8WF8T+FY+odSIqUMbw8jUZC5LDyCNr1fPPFlqcZGaj70XSbGaErcYQWLs+gBx6cjpgf7FpNI9Fidij9J6IrNu9xVSFWoZvQ6jlcevpH5mFyVE+jiRzLuIKipd3Djcq2hzjw3+Z0SLZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkjUO1wI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DEBC43390;
	Fri, 26 Jan 2024 17:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706290120;
	bh=yvFNWEbhdJcYieMLRciY5V8W+w9c/qsqKUENofx8bB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PkjUO1wIgXb7IyEIcrXnYoa7pMzPaRB7gDKLWuLUO9CyNj93ZsqmLwpg9su2kJRYX
	 xd3QoEAsTRT3ANfcYY/4WW1sK9P2SAQFUBIEd21uS/ysswm3NnS+ob63co2mwKtcVM
	 xLi698RbtWMMtHM1ZSd3TpQnQwEvQE40rhasPZBJA5IR4+g6qb6dGB7WSN5Qwj6aD7
	 6TGu20o5yRJmqsDL902uqw1xQsouwe2Sgx5hkjJkO0dwb5jM8tXBtG0i7tVR9XQhlo
	 oFe8MHFPPAkrPFNqKy2gtU7Nxw7GLP0+J5JSg/dR9EcVKAh2g2kyXPOvFRan/6rQw4
	 Bhz2mWnBZtsfA==
Date: Fri, 26 Jan 2024 09:33:27 -0800
From: Bjorn Andersson <andersson@kernel.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ben Levinsky <ben.levinsky@xilinx.com>
Subject: Re: [PATCH v4 1/2] remoteproc: Make rproc_get_by_phandle() work for
 clusters
Message-ID: <4zq5hvxmvwzk6opqggennih5zq7rsznm2omdrrow3zsy2n6rzi@yqxtogh6jz3u>
References: <20240103221124.3063683-1-tanmay.shah@amd.com>
 <20240103221124.3063683-2-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103221124.3063683-2-tanmay.shah@amd.com>

On Wed, Jan 03, 2024 at 02:11:24PM -0800, Tanmay Shah wrote:
> From: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Multi-cluster remoteproc designs typically have the following DT
> declaration:
> 
> 	remoteproc_cluster {
> 		compatible = "soc,remoteproc-cluster";
> 
>                 core0: core0 {
> 			compatible = "soc,remoteproc-core"
>                         memory-region;
>                         sram;
>                 };
> 
>                 core1: core1 {
> 			compatible = "soc,remoteproc-core"
>                         memory-region;
>                         sram;
>                 }
>         };

The indention of this snippet looks weird in my client, because it
contains a mixture of tabs and spaces. Please clean that up, and while
at it, '_' is not a valid character in DT node names...

> 
> A driver exists for the cluster rather than the individual cores
> themselves so that operation mode and HW specific configurations
> applicable to the cluster can be made.
> 
> Because the driver exists at the cluster level and not the individual
> core level, function rproc_get_by_phandle() fails to return the
> remoteproc associated with the phandled it is called for.
> 
> This patch enhances rproc_get_by_phandle() by looking for the cluster's
> driver when the driver for the immediate remoteproc's parent is not
> found.
> 
> Reported-by: Ben Levinsky <ben.levinsky@xilinx.com>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

The s-o-b is used to certify the origin of the patch, Mathieu provided
his signature here, then as you handle the patch you need to append your
s-o-b to provide the same certification.

The for appropriate tracking of reality, Mathieu should append his s-o-b
when/if he applies the patch.

TL;DR please add your S-o-b after Mathieu's.


Change itself looks good to me.

Regards,
Bjorn

> ---
>  drivers/remoteproc/remoteproc_core.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 695cce218e8c..0b3b34085e2f 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -33,6 +33,7 @@
>  #include <linux/idr.h>
>  #include <linux/elf.h>
>  #include <linux/crc32.h>
> +#include <linux/of_platform.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/virtio_ids.h>
>  #include <linux/virtio_ring.h>
> @@ -2112,6 +2113,7 @@ EXPORT_SYMBOL(rproc_detach);
>  struct rproc *rproc_get_by_phandle(phandle phandle)
>  {
>  	struct rproc *rproc = NULL, *r;
> +	struct device_driver *driver;
>  	struct device_node *np;
>  
>  	np = of_find_node_by_phandle(phandle);
> @@ -2122,7 +2124,26 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
>  	list_for_each_entry_rcu(r, &rproc_list, node) {
>  		if (r->dev.parent && device_match_of_node(r->dev.parent, np)) {
>  			/* prevent underlying implementation from being removed */
> -			if (!try_module_get(r->dev.parent->driver->owner)) {
> +
> +			/*
> +			 * If the remoteproc's parent has a driver, the
> +			 * remoteproc is not part of a cluster and we can use
> +			 * that driver.
> +			 */
> +			driver = r->dev.parent->driver;
> +
> +			/*
> +			 * If the remoteproc's parent does not have a driver,
> +			 * look for the driver associated with the cluster.
> +			 */
> +			if (!driver) {
> +				if (r->dev.parent->parent)
> +					driver = r->dev.parent->parent->driver;
> +				if (!driver)
> +					break;
> +			}
> +
> +			if (!try_module_get(driver->owner)) {
>  				dev_err(&r->dev, "can't get owner\n");
>  				break;
>  			}
> -- 
> 2.25.1
> 

