Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60B47CFCC2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346247AbjJSOb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346274AbjJSObf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:31:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E37B1BF3;
        Thu, 19 Oct 2023 07:30:52 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SB99L5W1kz6K7G9;
        Thu, 19 Oct 2023 22:30:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 19 Oct
 2023 15:30:47 +0100
Date:   Thu, 19 Oct 2023 15:30:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v12 10/20] cxl/pci: Introduce config option PCIEAER_CXL
Message-ID: <20231019153045.000038cc@Huawei.com>
In-Reply-To: <20231018171713.1883517-11-rrichter@amd.com>
References: <20231018171713.1883517-1-rrichter@amd.com>
        <20231018171713.1883517-11-rrichter@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 19:17:03 +0200
Robert Richter <rrichter@amd.com> wrote:

> CXL error handling depends on AER.
> 
> Introduce config option PCIEAER_CXL in preparation of the AER dport
> error handling. Also, introduce the stub function
> devm_cxl_setup_parent_dport() to setup dports.
> 
> This is in preparation of follow on patches.
> 
> Note the Kconfg part of the option is added in a later patch to enable
> it once coding of the feature is complete.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/pci.c | 9 +++++++++
>  drivers/cxl/cxl.h      | 7 +++++++
>  drivers/cxl/mem.c      | 2 ++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c7a7887ebdcf..7c3fbf9815e9 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -718,6 +718,15 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>  	return true;
>  }
>  
> +#ifdef CONFIG_PCIEAER_CXL
> +
> +void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
> +{
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_dport, CXL);
> +
> +#endif
> +
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c07064e0c136..cdb2ade6ba29 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -704,6 +704,13 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  					 struct device *dport_dev, int port_id,
>  					 resource_size_t rcrb);
>  
> +#ifdef CONFIG_PCIEAER_CXL
> +void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
> +#else
> +static inline void cxl_setup_parent_dport(struct device *host,
> +					  struct cxl_dport *dport) { }
> +#endif
> +
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 04107058739b..e087febf9af0 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -157,6 +157,8 @@ static int cxl_mem_probe(struct device *dev)
>  	else
>  		endpoint_parent = &parent_port->dev;
>  
> +	cxl_setup_parent_dport(dev, dport);
> +
>  	device_lock(endpoint_parent);
>  	if (!endpoint_parent->driver) {
>  		dev_err(dev, "CXL port topology %s not enabled\n",

