Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F6D7B5597
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbjJBOoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237823AbjJBOn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:43:59 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E46EB7;
        Mon,  2 Oct 2023 07:43:55 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RzkGn2yJ5z67Zjl;
        Mon,  2 Oct 2023 22:43:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 15:43:52 +0100
Date:   Mon, 2 Oct 2023 15:43:51 +0100
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
Subject: Re: [PATCH v11 07/20] cxl/hdm: Use stored Component Register
 mappings to map HDM decoder capability
Message-ID: <20231002154351.0000136a@Huawei.com>
In-Reply-To: <20230927154339.1600738-8-rrichter@amd.com>
References: <20230927154339.1600738-1-rrichter@amd.com>
        <20230927154339.1600738-8-rrichter@amd.com>
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

On Wed, 27 Sep 2023 17:43:26 +0200
Robert Richter <rrichter@amd.com> wrote:

> Now, that the Component Register mappings are stored, use them to
> enable and map the HDM decoder capabilities. The Component Registers
> do not need to be probed again for this, remove probing code.
> 
> The HDM capability applies to Endpoints, USPs and VH Host Bridges. The
> Endpoint's component register mappings are located in the cxlds and
> else in the port's structure. Duplicate the cxlds->reg_map in
> port->reg_map for endpoint ports.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> [rework to drop cxl_port_get_comp_map()]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
A few comments inline.

Also, Dan's SoB doesn't make sense if you are the Author and he's not
the one sending the email.  The fun of patches bounced back and forwards
is sometimes you have to tweak this stuff on each posting... :(

> ---
>  drivers/cxl/core/hdm.c  | 48 ++++++++++++++++-------------------------
>  drivers/cxl/core/port.c | 29 +++++++++++++++++++------
>  drivers/cxl/mem.c       |  5 ++---
>  3 files changed, 43 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 11d9971f3e8c..14a0d0017df3 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -81,26 +81,6 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->interleave_mask |= GENMASK(14, 12);
>  }
>  
> -static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
> -				struct cxl_component_regs *regs)
> -{
> -	struct cxl_register_map map = {
> -		.host = &port->dev,
> -		.resource = port->component_reg_phys,
> -		.base = crb,
> -		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> -	};
> -
> -	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
> -	if (!map.component_map.hdm_decoder.valid) {
> -		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
> -		/* unique error code to indicate no HDM decoder capability */
> -		return -ENODEV;
> -	}
> -
> -	return cxl_map_component_regs(&map, regs, BIT(CXL_CM_CAP_CAP_ID_HDM));
> -}
> -
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  {
>  	struct cxl_hdm *cxlhdm;
> @@ -155,7 +135,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  {
>  	struct device *dev = &port->dev;
>  	struct cxl_hdm *cxlhdm;
> -	void __iomem *crb;
> +	struct cxl_register_map *reg_map;
>  	int rc;
>  
>  	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
> @@ -164,19 +144,29 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  	cxlhdm->port = port;
>  	dev_set_drvdata(dev, cxlhdm);
>  
> -	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
> -	if (!crb && info && info->mem_enabled) {
> -		cxlhdm->decoder_count = info->ranges;
> -		return cxlhdm;
> -	} else if (!crb) {
> +	reg_map = &port->reg_map;

Could you set this where it's defined above?

> +	if (reg_map->resource == CXL_RESOURCE_NONE) {

A reminder comment on why/when this happens might be a good addition.

> +		if (info && info->mem_enabled) {
> +			cxlhdm->decoder_count = info->ranges;
> +			return cxlhdm;
> +		}

Trivial (and true before this patch) but I'd rather see the error path out of line


		if (!info || !info->mem_enabled) {
			WARN_ON(1);
			dev_err(dev, "No ...
			...
		}

		cxlhdm->decoder_count = info->ranges;
		return cxlhdm;
	}


> +		WARN_ON(1);
>  		dev_err(dev, "No component registers mapped\n");
>  		return ERR_PTR(-ENXIO);
>  	}
>  
> -	rc = map_hdm_decoder_regs(port, crb, &cxlhdm->regs);
> -	iounmap(crb);
> -	if (rc)
> +	if (!reg_map->component_map.hdm_decoder.valid) {
> +		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
> +		/* unique error code to indicate no HDM decoder capability */
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	rc = cxl_map_component_regs(reg_map, &cxlhdm->regs,
> +				    BIT(CXL_CM_CAP_CAP_ID_HDM));
> +	if (rc) {
> +		dev_dbg(dev, "Failed to map HDM capability.\n");
dev_err() seems appropriate here.

>  		return ERR_PTR(rc);
> +	}
>  
>  	parse_hdm_decoder_caps(cxlhdm);
>  	if (cxlhdm->decoder_count == 0) {

