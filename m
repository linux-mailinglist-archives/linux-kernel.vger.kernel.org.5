Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D127B55EE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbjJBOcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbjJBOcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:32:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D436FB0;
        Mon,  2 Oct 2023 07:32:42 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rzk1r2dtDz6K6gB;
        Mon,  2 Oct 2023 22:32:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 15:32:39 +0100
Date:   Mon, 2 Oct 2023 15:32:38 +0100
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
Subject: Re: [PATCH v11 03/20] cxl/port: Fix @host confusion in
 cxl_dport_setup_regs()
Message-ID: <20231002153238.000048cc@Huawei.com>
In-Reply-To: <20230927154339.1600738-4-rrichter@amd.com>
References: <20230927154339.1600738-1-rrichter@amd.com>
        <20230927154339.1600738-4-rrichter@amd.com>
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

On Wed, 27 Sep 2023 17:43:22 +0200
Robert Richter <rrichter@amd.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> commit 5d2ffbe4b81a ("cxl/port: Store the downstream port's Component Register mappings in struct cxl_dport")
> 
> ...moved the dport component registers from a raw component_reg_phys
> passed in at dport instantiation time to a 'struct cxl_register_map'
> populated with both the component register data *and* the "host" device
> for mapping operations.
> 
> While typical CXL switch dports are mapped by their associated 'struct
> cxl_port', an RCH host bridge dport registered by cxl_acpi needs to wait
> until the cxl_mem driver makes the attachment to map the registers. This
> is because there are no intervening 'struct cxl_port' instances between
> the root cxl_port and the endpoint port in an RCH topology.
> 
> For now just mark the host as NULL in the RCH dport case until code that
> needs to map the dport registers arrives. Name the field @reg_map,
> because @reg_map->host will be used for mapping operations beyond
> component registers (i.e. AER registers).

I'm not keen on a rename buried in here.  Its fine in general but as
far as I can see little to do with the rest of what is going on here.

> 
> This patch is not flagged for -stable since nothing in the current
> driver uses the dport->reg_map.
> 
> Now, I am slightly uneasy that cxl_setup_comp_regs() sets map->host to a
> wrong value and then cxl_dport_setup_regs() fixes it up, but the
> alternatives I came up with are more messy. For example, adding an
> @logdev to 'struct cxl_register_map' that the dev_printk()s can fall
> back to when @host is NULL. I settled on "post-fixup+comment" since it
> is only RCH dports that have this special case where register probing is
> split between a host-bridge RCRB lookup and when cxl_mem_probe() does
> the association of the cxl_memdev and endpoint port.
> 
> Fixes: 5d2ffbe4b81a ("cxl/port: Store the downstream port's Component Register mappings in struct cxl_dport")
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> [kept dev_dbg() message]
> Signed-off-by: Robert Richter <rrichter@amd.com>

Seems right to me otherwise, though I've lost track a little of what was
going on with this...   Hence a tentative
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/port.c | 43 +++++++++++++++++++++++++++++------------
>  drivers/cxl/cxl.h       |  4 ++--
>  2 files changed, 33 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 033651a5da30..99df86d72dbc 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -716,13 +716,23 @@ static int cxl_port_setup_regs(struct cxl_port *port,
>  				   component_reg_phys);
>  }
>  
> -static int cxl_dport_setup_regs(struct cxl_dport *dport,
> +static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>  				resource_size_t component_reg_phys)
>  {
> +	int rc;
> +
>  	if (dev_is_platform(dport->dport_dev))
>  		return 0;
> -	return cxl_setup_comp_regs(dport->dport_dev, &dport->comp_map,
> -				   component_reg_phys);
> +
> +	/*
> +	 * use @dport->dport_dev for the context for error messages during
> +	 * register probing, and fixup @host after the fact, since @host may be
> +	 * NULL.
> +	 */
> +	rc = cxl_setup_comp_regs(dport->dport_dev, &dport->reg_map,
> +				 component_reg_phys);
> +	dport->reg_map.host = host;
> +	return rc;
>  }
>  
>  static struct cxl_port *__devm_cxl_add_port(struct device *host,
> @@ -983,7 +993,16 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	if (!dport)
>  		return ERR_PTR(-ENOMEM);
>  
> -	if (rcrb != CXL_RESOURCE_NONE) {
> +	dport->dport_dev = dport_dev;
> +	dport->port_id = port_id;
> +	dport->port = port;
> +
> +	if (rcrb == CXL_RESOURCE_NONE) {
> +		rc = cxl_dport_setup_regs(&port->dev, dport,
> +					  component_reg_phys);
> +		if (rc)
> +			return ERR_PTR(rc);
> +	} else {
>  		dport->rcrb.base = rcrb;
>  		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
>  							 CXL_RCRB_DOWNSTREAM);
> @@ -992,6 +1011,14 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  			return ERR_PTR(-ENXIO);
>  		}
>  
> +		/*
> +		 * RCH @dport is not ready to map until associated with its
> +		 * memdev
> +		 */
> +		rc = cxl_dport_setup_regs(NULL, dport, component_reg_phys);
> +		if (rc)
> +			return ERR_PTR(rc);
> +
>  		dport->rch = true;
>  	}
>  
> @@ -999,14 +1026,6 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  		dev_dbg(dport_dev, "Component Registers found for dport: %pa\n",
>  			&component_reg_phys);
>  
> -	dport->dport_dev = dport_dev;
> -	dport->port_id = port_id;
> -	dport->port = port;
> -
> -	rc = cxl_dport_setup_regs(dport, component_reg_phys);
> -	if (rc)
> -		return ERR_PTR(rc);
> -
>  	cond_cxl_root_lock(port);
>  	rc = add_dport(port, dport);
>  	cond_cxl_root_unlock(port);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b5b015b661ea..68abf9944383 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -620,7 +620,7 @@ struct cxl_rcrb_info {
>  /**
>   * struct cxl_dport - CXL downstream port
>   * @dport_dev: PCI bridge or firmware device representing the downstream link
> - * @comp_map: component register capability mappings
> + * @reg_map: component and ras register mapping parameters
>   * @port_id: unique hardware identifier for dport in decoder target list
>   * @rcrb: Data about the Root Complex Register Block layout
>   * @rch: Indicate whether this dport was enumerated in RCH or VH mode
> @@ -628,7 +628,7 @@ struct cxl_rcrb_info {
>   */
>  struct cxl_dport {
>  	struct device *dport_dev;
> -	struct cxl_register_map comp_map;
> +	struct cxl_register_map reg_map;
>  	int port_id;
>  	struct cxl_rcrb_info rcrb;
>  	bool rch;

