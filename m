Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733EA76EDFC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbjHCPYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjHCPYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:24:01 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E40F180;
        Thu,  3 Aug 2023 08:23:59 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 373FNmuH072909;
        Thu, 3 Aug 2023 10:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691076228;
        bh=kQEkqXmPngb2k51xcZMXyyrrnsQOSxoYZCPy53sg6x0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=d05StiuyHhTbb6Lj9dmrBwGnoZra/R1zCuCpGo/V5f1Vv1pX3RbAm9OoiQPipkuav
         GP7FVmZVg3gTPGiEtRSKhZQQRZ5QWUXCN9MoFpySpbEIUsnitqIwLqQapibnWSvt0U
         iKED4z6EBWQdOi6BqyhuPDI25udke0vE1nO96KuM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 373FNm3C093199
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 10:23:48 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 10:23:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 10:23:48 -0500
Received: from [10.250.36.243] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 373FNlpQ111966;
        Thu, 3 Aug 2023 10:23:47 -0500
Message-ID: <7c12b109-d6b9-f0d4-cada-28140a33da21@ti.com>
Date:   Thu, 3 Aug 2023 10:23:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V6 3/4] firmware: ti_sci: Allocate memory for Low Power
 Modes
Content-Language: en-US
To:     Dhruva Gole <d-gole@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Praneeth Bajjuri" <praneeth@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>,
        Georgi Vlaev <g-vlaev@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20230803064247.503036-1-d-gole@ti.com>
 <20230803064247.503036-4-d-gole@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230803064247.503036-4-d-gole@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 1:42 AM, Dhruva Gole wrote:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> A region of memory in DDR must be used during Deep Sleep for saving
> of some system context when using the ti_sci firmware. From DM's point
> of view, this can be any contiguous region in the DDR, so can allocate
> 512KB of DMA reserved memory in probe(), instead of another carveout.
> 
> Also send a TISCI_MSG_QUERY_FW_CAPS message to the firmware during
> probe to determine if any low power modes are supported and if
> ti_sci_init_suspend should be called based on the response received.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
> Tested-by: Roger Quadros <rogerq@kernel.org>
> [d-gole@ti.com: Use dma_alloc_attrs instead of dma_alloc_coherent]
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>   drivers/firmware/ti_sci.c | 42 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 3b40f9336b3f..0334ade19868 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -10,6 +10,7 @@
>   
>   #include <linux/bitmap.h>
>   #include <linux/debugfs.h>
> +#include <linux/dma-mapping.h>
>   #include <linux/export.h>
>   #include <linux/io.h>
>   #include <linux/iopoll.h>
> @@ -25,6 +26,9 @@
>   
>   #include "ti_sci.h"
>   
> +/* Low power mode memory context size */
> +#define LPM_CTX_MEM_SIZE 0x80000
> +
>   /* List of all TI SCI devices active in system */
>   static LIST_HEAD(ti_sci_list);
>   /* Protection for the entire list */
> @@ -96,6 +100,9 @@ struct ti_sci_desc {
>    * @minfo:	Message info
>    * @node:	list head
>    * @host_id:	Host ID
> + * @ctx_mem_addr: Low power context memory phys address
> + * @ctx_mem_buf: Low power context memory buffer
> + * @fw_caps:	FW/SoC low power capabilities
>    * @users:	Number of users of this instance
>    */
>   struct ti_sci_info {
> @@ -113,6 +120,9 @@ struct ti_sci_info {
>   	struct ti_sci_xfers_info minfo;
>   	struct list_head node;
>   	u8 host_id;
> +	dma_addr_t ctx_mem_addr;
> +	void *ctx_mem_buf;
> +	u64 fw_caps;
>   	/* protected by ti_sci_list_mutex */
>   	int users;
>   };
> @@ -3511,6 +3521,25 @@ static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
>   	return NOTIFY_BAD;
>   }
>   
> +static int ti_sci_init_suspend(struct platform_device *pdev,
> +			       struct ti_sci_info *info)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	info->ctx_mem_buf = dma_alloc_attrs(info->dev, LPM_CTX_MEM_SIZE,
> +					    &info->ctx_mem_addr,
> +					    GFP_KERNEL,
> +					    DMA_ATTR_NO_KERNEL_MAPPING |
> +					    DMA_ATTR_FORCE_CONTIGUOUS);
> +	if (!info->ctx_mem_buf) {
> +		dev_err(info->dev, "Failed to allocate LPM context memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
>   /* Description for K2G */
>   static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
>   	.default_host_id = 2,
> @@ -3661,6 +3690,15 @@ static int ti_sci_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> +	/*
> +	 * Check if the firmware supports any optional low power modes
> +	 * and initialize them if present. Old revisions of TIFS (< 08.04)
> +	 * will NACK the request.
> +	 */
> +	ret = ti_sci_msg_cmd_query_fw_caps(&info->handle, &info->fw_caps);
> +	if (!ret && (info->fw_caps & MSG_MASK_CAPS_LPM))
> +		ti_sci_init_suspend(pdev, info);
> +
>   	dev_info(dev, "ABI: %d.%d (firmware rev 0x%04x '%s')\n",
>   		 info->handle.version.abi_major, info->handle.version.abi_minor,
>   		 info->handle.version.firmware_revision,
> @@ -3708,6 +3746,10 @@ static int ti_sci_remove(struct platform_device *pdev)
>   		mbox_free_channel(info->chan_rx);
>   	}
>   
> +	if (info->ctx_mem_buf)
> +		dma_free_coherent(info->dev, LPM_CTX_MEM_SIZE,

You allocated with dma_alloc_attrs() you should free with dma_free_attrs().

Andrew

> +				  info->ctx_mem_buf,
> +				  info->ctx_mem_addr);
>   	return ret;
>   }
>   
