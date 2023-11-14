Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6727EB369
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjKNPWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbjKNPWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:22:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7688612C;
        Tue, 14 Nov 2023 07:22:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CF1C433CA;
        Tue, 14 Nov 2023 15:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699975323;
        bh=VY5OZPEAJstMBZ4T645HLqNFNRu7Inw7FgVCtPje9XU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fh7kS5mimr+a9bQhEFADHCOqNJ3aC/zMaz9fwHMzbeom1tCdo2hpnwtxotd9OoE7C
         WRsBRKAt73AT/gJ/zGlMcN2hU5l+nVoDIMGystmQRwxlDkAlwi43BB61FZ/+U/8ZeF
         h5yw5vBBS7+b3Eu+wFpgV7frhlSYrsulFMskegedLWrA+IYRPveC5V1U6dmX1AjS37
         Awou27MDbuYZ9JW85Iip7pnbliiEjdshcEHl+nmJ3qBPyydPV1pqN+sHJHF+t7f/s0
         MW74Wi8t7wXIqqH3JhKDp1DxWT0ZsX2paxWlew4B3VWAaH/iyN6Wta1e52JaHBLY/+
         vpkyyoLRvBxmQ==
Date:   Tue, 14 Nov 2023 09:22:00 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ben Levinsky <ben.levinsky@xilinx.com>,
        Ben Levinsky <ben.levinsky@amd.com>
Subject: Re: [RESEND PATCH v3 1/2] remoteproc: Make rproc_get_by_phandle()
 work for clusters
Message-ID: <dznmvir337tb455usswkrvovf34urgyejkrt7rduscbepd2wg3@7atos56utizw>
References: <20231014231548.637303-1-tanmay.shah@amd.com>
 <20231014231548.637303-2-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014231548.637303-2-tanmay.shah@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 04:15:47PM -0700, Tanmay Shah wrote:
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
> Tested-by: Ben Levinsky <ben.levinsky@amd.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 695cce218e8c..3a8191803885 100644
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
> @@ -2111,7 +2112,9 @@ EXPORT_SYMBOL(rproc_detach);
>  #ifdef CONFIG_OF
>  struct rproc *rproc_get_by_phandle(phandle phandle)
>  {
> +	struct platform_device *cluster_pdev;
>  	struct rproc *rproc = NULL, *r;
> +	struct device_driver *driver;
>  	struct device_node *np;
>  
>  	np = of_find_node_by_phandle(phandle);
> @@ -2122,7 +2125,30 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
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
> +				cluster_pdev = of_find_device_by_node(np->parent);

Both the Ti and Xilinx drivers are using of_platform_populate(), so
their r->dev.parent should have a parent reference to the cluster
device.

Unless I'm reading the code wrong, I think we should follow that
pointer, rather than taking the detour in the DeviceTree data.

Regards,
Bjorn

> +				if (!cluster_pdev) {
> +					dev_err(&r->dev, "can't get parent\n");
> +					break;
> +				}
> +
> +				driver = cluster_pdev->dev.driver;
> +				put_device(&cluster_pdev->dev);
> +			}
> +
> +			if (!try_module_get(driver->owner)) {
>  				dev_err(&r->dev, "can't get owner\n");
>  				break;
>  			}
> -- 
> 2.25.1
> 
