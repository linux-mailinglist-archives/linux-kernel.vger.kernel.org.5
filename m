Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02377B5501
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237698AbjJBOTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237691AbjJBOTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:19:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9C4AD;
        Mon,  2 Oct 2023 07:19:34 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rzjkh06XWz689W8;
        Mon,  2 Oct 2023 22:19:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 15:19:31 +0100
Date:   Mon, 2 Oct 2023 15:19:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Terry Bowman <terry.bowman@amd.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v11 02/20] cxl/core/regs: Rename @dev to @host in struct
 cxl_register_map
Message-ID: <20231002151930.0000297f@Huawei.com>
In-Reply-To: <20230927154339.1600738-3-rrichter@amd.com>
References: <20230927154339.1600738-1-rrichter@amd.com>
        <20230927154339.1600738-3-rrichter@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2023 17:43:21 +0200
Robert Richter <rrichter@amd.com> wrote:

> The primary role of @dev is to host the mappings for devm operations.
> @dev is too ambiguous as a name. I.e. when does @dev refer to the
> 'struct device *' instance that the registers belong, and when does
> @dev refer to the 'struct device *' instance hosting the mapping for
> devm operations?
> 
> Clarify the role of @dev in cxl_register_map by renaming it to @host.
> Also, rename local variables to 'host' where map->host is used.
> 
> Add Fixes: tag as the fix in the next patch depends on this change.
> 
> Fixes: 5d2ffbe4b81a ("cxl/port: Store the downstream port's Component Register mappings in struct cxl_dport")
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
Good cleanup.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/hdm.c  |  2 +-
>  drivers/cxl/core/port.c |  4 ++--
>  drivers/cxl/core/regs.c | 28 ++++++++++++++--------------
>  drivers/cxl/cxl.h       |  4 ++--
>  drivers/cxl/pci.c       |  2 +-
>  5 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 4449b34a80cc..11d9971f3e8c 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -85,7 +85,7 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
>  				struct cxl_component_regs *regs)
>  {
>  	struct cxl_register_map map = {
> -		.dev = &port->dev,
> +		.host = &port->dev,
>  		.resource = port->component_reg_phys,
>  		.base = crb,
>  		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index d4572a02989a..033651a5da30 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -691,14 +691,14 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>  	return ERR_PTR(rc);
>  }
>  
> -static int cxl_setup_comp_regs(struct device *dev, struct cxl_register_map *map,
> +static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
>  			       resource_size_t component_reg_phys)
>  {
>  	if (component_reg_phys == CXL_RESOURCE_NONE)
>  		return 0;
>  
>  	*map = (struct cxl_register_map) {
> -		.dev = dev,
> +		.host = host,
>  		.reg_type = CXL_REGLOC_RBI_COMPONENT,
>  		.resource = component_reg_phys,
>  		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 6281127b3e9d..e0fbe964f6f0 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -204,7 +204,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
>  			   unsigned long map_mask)
>  {
> -	struct device *dev = map->dev;
> +	struct device *host = map->host;
>  	struct mapinfo {
>  		const struct cxl_reg_map *rmap;
>  		void __iomem **addr;
> @@ -225,7 +225,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>  			continue;
>  		phys_addr = map->resource + mi->rmap->offset;
>  		length = mi->rmap->size;
> -		*(mi->addr) = devm_cxl_iomap_block(dev, phys_addr, length);
> +		*(mi->addr) = devm_cxl_iomap_block(host, phys_addr, length);
>  		if (!*(mi->addr))
>  			return -ENOMEM;
>  	}
> @@ -237,7 +237,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, CXL);
>  int cxl_map_device_regs(const struct cxl_register_map *map,
>  			struct cxl_device_regs *regs)
>  {
> -	struct device *dev = map->dev;
> +	struct device *host = map->host;
>  	resource_size_t phys_addr = map->resource;
>  	struct mapinfo {
>  		const struct cxl_reg_map *rmap;
> @@ -259,7 +259,7 @@ int cxl_map_device_regs(const struct cxl_register_map *map,
>  
>  		addr = phys_addr + mi->rmap->offset;
>  		length = mi->rmap->size;
> -		*(mi->addr) = devm_cxl_iomap_block(dev, addr, length);
> +		*(mi->addr) = devm_cxl_iomap_block(host, addr, length);
>  		if (!*(mi->addr))
>  			return -ENOMEM;
>  	}
> @@ -309,7 +309,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	int regloc, i;
>  
>  	*map = (struct cxl_register_map) {
> -		.dev = &pdev->dev,
> +		.host = &pdev->dev,
>  		.resource = CXL_RESOURCE_NONE,
>  	};
>  
> @@ -403,15 +403,15 @@ EXPORT_SYMBOL_NS_GPL(cxl_map_pmu_regs, CXL);
>  
>  static int cxl_map_regblock(struct cxl_register_map *map)
>  {
> -	struct device *dev = map->dev;
> +	struct device *host = map->host;
>  
>  	map->base = ioremap(map->resource, map->max_size);
>  	if (!map->base) {
> -		dev_err(dev, "failed to map registers\n");
> +		dev_err(host, "failed to map registers\n");
>  		return -ENOMEM;
>  	}
>  
> -	dev_dbg(dev, "Mapped CXL Memory Device resource %pa\n", &map->resource);
> +	dev_dbg(host, "Mapped CXL Memory Device resource %pa\n", &map->resource);
>  	return 0;
>  }
>  
> @@ -425,28 +425,28 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>  {
>  	struct cxl_component_reg_map *comp_map;
>  	struct cxl_device_reg_map *dev_map;
> -	struct device *dev = map->dev;
> +	struct device *host = map->host;
>  	void __iomem *base = map->base;
>  
>  	switch (map->reg_type) {
>  	case CXL_REGLOC_RBI_COMPONENT:
>  		comp_map = &map->component_map;
> -		cxl_probe_component_regs(dev, base, comp_map);
> -		dev_dbg(dev, "Set up component registers\n");
> +		cxl_probe_component_regs(host, base, comp_map);
> +		dev_dbg(host, "Set up component registers\n");
>  		break;
>  	case CXL_REGLOC_RBI_MEMDEV:
>  		dev_map = &map->device_map;
> -		cxl_probe_device_regs(dev, base, dev_map);
> +		cxl_probe_device_regs(host, base, dev_map);
>  		if (!dev_map->status.valid || !dev_map->mbox.valid ||
>  		    !dev_map->memdev.valid) {
> -			dev_err(dev, "registers not found: %s%s%s\n",
> +			dev_err(host, "registers not found: %s%s%s\n",
>  				!dev_map->status.valid ? "status " : "",
>  				!dev_map->mbox.valid ? "mbox " : "",
>  				!dev_map->memdev.valid ? "memdev " : "");
>  			return -ENXIO;
>  		}
>  
> -		dev_dbg(dev, "Probing device registers...\n");
> +		dev_dbg(host, "Probing device registers...\n");
>  		break;
>  	default:
>  		break;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 76d92561af29..b5b015b661ea 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -247,7 +247,7 @@ struct cxl_pmu_reg_map {
>  
>  /**
>   * struct cxl_register_map - DVSEC harvested register block mapping parameters
> - * @dev: device for devm operations and logging
> + * @host: device for devm operations and logging
>   * @base: virtual base of the register-block-BAR + @block_offset
>   * @resource: physical resource base of the register block
>   * @max_size: maximum mapping size to perform register search
> @@ -257,7 +257,7 @@ struct cxl_pmu_reg_map {
>   * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
>   */
>  struct cxl_register_map {
> -	struct device *dev;
> +	struct device *host;
>  	void __iomem *base;
>  	resource_size_t resource;
>  	resource_size_t max_size;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 44a21ab7add5..f9d852957809 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -484,7 +484,7 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>  	resource_size_t component_reg_phys;
>  
>  	*map = (struct cxl_register_map) {
> -		.dev = &pdev->dev,
> +		.host = &pdev->dev,
>  		.resource = CXL_RESOURCE_NONE,
>  	};
>  

