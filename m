Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863EA76EE0A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbjHCP0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbjHCP0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:26:43 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF443180;
        Thu,  3 Aug 2023 08:26:42 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 373FQXHS073421;
        Thu, 3 Aug 2023 10:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691076393;
        bh=pYvGb+5mC2L6b0KC/gLcvDF1euAonkjtP/8iYo5XIoI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=f0zdC2ZM1Uaw7S8MqahW5b8SweShawN8RM1luo5SVVBlMiq8LtiyV3UVKmx71svED
         qZZqDHQBGK+fXxJRRencSzeDmerduAAPxMv6+RmzpGoARRAoFDuJGyuIdNg6tnkrt4
         Mt7XULLwnEcJ/B1JwbvXsNq1vqvtm5zz8LuBRoqU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 373FQXLX006983
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 10:26:33 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 10:26:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 10:26:32 -0500
Received: from [10.250.36.243] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 373FQWpP012771;
        Thu, 3 Aug 2023 10:26:32 -0500
Message-ID: <3882f0ac-b74c-6eb2-197c-34ca233cd7a3@ti.com>
Date:   Thu, 3 Aug 2023 10:26:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V6 4/4] firmware: ti_sci: Introduce system suspend resume
 support
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
        Vibhore Vardhan <vibhore@ti.com>, Georgi Vlaev <g-vlaev@ti.com>
References: <20230803064247.503036-1-d-gole@ti.com>
 <20230803064247.503036-5-d-gole@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230803064247.503036-5-d-gole@ti.com>
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
> Introduce system suspend resume calls that will allow the ti_sci
> driver to support deep sleep low power mode when the user space issues a
> suspend to mem.
> 
> Also, write a ti_sci_prepare_system_suspend call to be used in the driver
> suspend handler to allow the system to identify the low power mode being
> entered and if necessary, send TISCI_MSG_PREPARE_SLEEP with information
> about the mode is being entered and the address for allocated memory for
> storing the context during Deep Sleep.
> 
> We're using "pm_suspend_target_state" to map the kernel's target suspend
> state to SysFW low power mode. Make sure this is available only when
> CONFIG_SUSPEND is enabled.
> 
> Co-developed-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>   drivers/firmware/ti_sci.c | 63 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 0334ade19868..172b726e00a6 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -22,6 +22,7 @@
>   #include <linux/slab.h>
>   #include <linux/soc/ti/ti-msgmgr.h>
>   #include <linux/soc/ti/ti_sci_protocol.h>
> +#include <linux/suspend.h>
>   #include <linux/reboot.h>
>   
>   #include "ti_sci.h"
> @@ -3521,6 +3522,67 @@ static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
>   	return NOTIFY_BAD;
>   }
>   
> +static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
> +{
> +#if IS_ENABLED(CONFIG_SUSPEND)
> +	u8 mode;
> +
> +	/* Map and validate the target Linux suspend state to TISCI LPM. */
> +	switch (pm_suspend_target_state) {
> +	case PM_SUSPEND_MEM:
> +		/* S2MEM is not supported by the firmware. */
> +		if (!(info->fw_caps & MSG_FLAG_CAPS_LPM_DEEP_SLEEP))
> +			return 0;
> +		mode = TISCI_MSG_VALUE_SLEEP_MODE_DEEP_SLEEP;
> +		break;
> +	default:
> +		/*
> +		 * Do not fail if we don't have action to take for a
> +		 * specific suspend mode.
> +		 */
> +		return 0;
> +	}
> +
> +	return ti_sci_cmd_prepare_sleep(&info->handle, mode,
> +					(u32)(info->ctx_mem_addr & 0xffffffff),
> +					(u32)((u64)info->ctx_mem_addr >> 32), 0);
> +#else
> +	return 0;
> +#endif
> +}
> +
> +static int ti_sci_suspend(struct device *dev)
> +{
> +	struct ti_sci_info *info = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_ENABLE);

After this the will the IOs be in isolation? Or does the firmware wait
until power down begins later?

Andrew

> +	if (ret)
> +		return ret;
> +	dev_dbg(dev, "%s: set I/O isolation: %d\n", __func__, ret);
> +
> +	ret = ti_sci_prepare_system_suspend(info);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int ti_sci_resume(struct device *dev)
> +{
> +	struct ti_sci_info *info = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_DISABLE);
> +	if (ret)
> +		return ret;
> +	dev_dbg(dev, "%s: disable I/O isolation: %d\n", __func__, ret);
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(ti_sci_pm_ops, ti_sci_suspend, ti_sci_resume);
> +
>   static int ti_sci_init_suspend(struct platform_device *pdev,
>   			       struct ti_sci_info *info)
>   {
> @@ -3759,6 +3821,7 @@ static struct platform_driver ti_sci_driver = {
>   	.driver = {
>   		   .name = "ti-sci",
>   		   .of_match_table = of_match_ptr(ti_sci_of_match),
> +		   .pm = &ti_sci_pm_ops,
>   	},
>   };
>   module_platform_driver(ti_sci_driver);
