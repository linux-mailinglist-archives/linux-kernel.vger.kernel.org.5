Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590A57B55C0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbjJBPBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237950AbjJBPB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:01:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642E49F;
        Mon,  2 Oct 2023 08:01:24 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RzkdK54sXz6K62g;
        Mon,  2 Oct 2023 22:59:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 16:01:21 +0100
Date:   Mon, 2 Oct 2023 16:01:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v11 20/20] cxl/core/regs: Rework cxl_map_pmu_regs() to
 use map->dev for devm
Message-ID: <20231002160120.000002a2@Huawei.com>
In-Reply-To: <20230927154339.1600738-21-rrichter@amd.com>
References: <20230927154339.1600738-1-rrichter@amd.com>
        <20230927154339.1600738-21-rrichter@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Wed, 27 Sep 2023 17:43:39 +0200
Robert Richter <rrichter@amd.com> wrote:

> struct cxl_register_map carries a @dev parameter for devm operations.
> Simplify the function interface to use that instead of a separate @dev
> argument.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
Seems reasonable.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/regs.c | 5 ++---
>  drivers/cxl/cxl.h       | 3 +--
>  drivers/cxl/pci.c       | 2 +-
>  3 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 7b56f6f28ab1..b668be617fd7 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -386,10 +386,9 @@ int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_count_regblock, CXL);
>  
> -int cxl_map_pmu_regs(struct pci_dev *pdev, struct cxl_pmu_regs *regs,
> -		     struct cxl_register_map *map)
> +int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs)
>  {
> -	struct device *dev = &pdev->dev;
> +	struct device *dev = map->host;
>  	resource_size_t phys_addr;
>  
>  	phys_addr = map->resource;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 7c2c195592d6..ed90ca8ed79e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -286,8 +286,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>  			   unsigned long map_mask);
>  int cxl_map_device_regs(const struct cxl_register_map *map,
>  			struct cxl_device_regs *regs);
> -int cxl_map_pmu_regs(struct pci_dev *pdev, struct cxl_pmu_regs *regs,
> -		     struct cxl_register_map *map);
> +int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs);
>  
>  enum cxl_regloc_type;
>  int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 037792e941f2..fa94bc61af25 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -898,7 +898,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  			break;
>  		}
>  
> -		rc = cxl_map_pmu_regs(pdev, &pmu_regs, &map);
> +		rc = cxl_map_pmu_regs(&map, &pmu_regs);
>  		if (rc) {
>  			dev_dbg(&pdev->dev, "Could not map PMU regs\n");
>  			break;

