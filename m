Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8F27B55C7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbjJBO5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237911AbjJBO5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:57:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52382B3;
        Mon,  2 Oct 2023 07:57:02 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RzkW23kZgz6HJX9;
        Mon,  2 Oct 2023 22:54:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 15:56:59 +0100
Date:   Mon, 2 Oct 2023 15:56:58 +0100
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
Subject: Re: [PATCH v11 14/20] cxl/pci: Map RCH downstream AER registers for
 logging protocol errors
Message-ID: <20231002155658.00004ac0@Huawei.com>
In-Reply-To: <20230927154339.1600738-15-rrichter@amd.com>
References: <20230927154339.1600738-1-rrichter@amd.com>
        <20230927154339.1600738-15-rrichter@amd.com>
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

On Wed, 27 Sep 2023 17:43:33 +0200
Robert Richter <rrichter@amd.com> wrote:

> From: Terry Bowman <terry.bowman@amd.com>
> 
> The restricted CXL host (RCH) error handler will log protocol errors
> using AER and RAS status registers. The AER and RAS registers need to
> be virtually memory mapped before enabling interrupts. Create the
> initializer function devm_cxl_setup_parent_dport() for this when the
> endpoint is connected with the dport. The initialization sets up the
> RCH RAS and AER mappings.
> 
> Add 'struct cxl_regs' to 'struct cxl_dport' for saving a pointer to
> the RCH downstream port's AER and RAS registers.
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
As before. Co-dev just before SoB. 

https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L521
This example looks like what you have here.

> Signed-off-by: Robert Richter <rrichter@amd.com>
Otherwise, LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/pci.c | 36 ++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      | 10 ++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 2b8883288539..2af7ad77b273 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -5,6 +5,7 @@
>  #include <linux/delay.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
> +#include <linux/aer.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -730,6 +731,38 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>  
>  #ifdef CONFIG_PCIEAER_CXL
>  
> +static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
> +{
> +	struct cxl_rcrb_info *ri = &dport->rcrb;
> +	void __iomem *dport_aer = NULL;
> +	resource_size_t aer_phys;
> +	struct device *host;
> +
> +	if (dport->rch && ri->aer_cap) {
> +		host = dport->reg_map.host;
> +		aer_phys = ri->aer_cap + ri->base;
> +		dport_aer = devm_cxl_iomap_block(host, aer_phys,
> +				sizeof(struct aer_capability_regs));
> +	}
> +
> +	dport->regs.dport_aer = dport_aer;
> +}
> +
> +static void cxl_dport_map_regs(struct cxl_dport *dport)
> +{
> +	struct cxl_register_map *map = &dport->reg_map;
> +	struct device *dev = dport->dport_dev;
> +
> +	if (!map->component_map.ras.valid)
> +		dev_dbg(dev, "RAS registers not found\n");
> +	else if (cxl_map_component_regs(map, &dport->regs.component,
> +					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		dev_dbg(dev, "Failed to map RAS capability.\n");
> +
> +	if (dport->rch)
> +		cxl_dport_map_rch_aer(dport);
> +}
> +
>  void devm_cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
>  {
>  	struct device *dport_dev = dport->dport_dev;
> @@ -738,6 +771,9 @@ void devm_cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
>  	host_bridge = to_pci_host_bridge(dport_dev);
>  	if (host_bridge->native_cxl_error)
>  		dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
> +
> +	dport->reg_map.host = host;
> +	cxl_dport_map_regs(dport);
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_parent_dport, CXL);
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index cfa2f6bede41..7c2c195592d6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -221,6 +221,14 @@ struct cxl_regs {
>  	struct_group_tagged(cxl_pmu_regs, pmu_regs,
>  		void __iomem *pmu;
>  	);
> +
> +	/*
> +	 * RCH downstream port specific RAS register
> +	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
> +	 */
> +	struct_group_tagged(cxl_rch_regs, rch_regs,
> +		void __iomem *dport_aer;
> +	);
>  };
>  
>  struct cxl_reg_map {
> @@ -623,6 +631,7 @@ struct cxl_rcrb_info {
>   * @rcrb: Data about the Root Complex Register Block layout
>   * @rch: Indicate whether this dport was enumerated in RCH or VH mode
>   * @port: reference to cxl_port that contains this downstream port
> + * @regs: Dport parsed register blocks
>   */
>  struct cxl_dport {
>  	struct device *dport_dev;
> @@ -631,6 +640,7 @@ struct cxl_dport {
>  	struct cxl_rcrb_info rcrb;
>  	bool rch;
>  	struct cxl_port *port;
> +	struct cxl_regs regs;
>  };
>  
>  /**

