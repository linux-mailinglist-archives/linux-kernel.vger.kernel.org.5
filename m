Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8967718D5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 05:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjHGDrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 23:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjHGDro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 23:47:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F24410F9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 20:47:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9E5261365
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 03:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49FAC433C8;
        Mon,  7 Aug 2023 03:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691380062;
        bh=bj5F7ecFqurRkS5eVFeyvZbl/Z7NesxetDXDsHYsUXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HhqG/fGF24G0B2utg+CXG7JDcCiZR9BISnGY2sNKpI0wuhk3b6Ax1Y7cYln7mA3DA
         PcyCbbiWpr5pNpYVZWgP7SRR5aHXzdm6lE4/GA7BX8N1KRa/OPdrOTFFEqENyVBDAV
         Jyc1Io/g0OJ/dexb+G++DqC0zz85dyLTvK1f53YDHZbGIQp+bmc42ptKK9yQJmuLOk
         Fgxz/FA8RG8X6r5j7qVU04G6lfm31qXcDziErzqnT42uwvzLaaC6A61ekgUBsy8ONb
         Fj05bMowViKZlgKYFpqpSzitHZcGraweMlhg+8SoSJGLpQixV3c4IdFEGe0ztsa4Hn
         FCD7X8OjhMG8w==
Date:   Mon, 7 Aug 2023 11:47:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V5 9/9] firmware: imx: scu-irq: support identifying SCU
 wakeup source from sysfs
Message-ID: <20230807034729.GR151430@dragon>
References: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
 <20230731090449.2845997-10-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731090449.2845997-10-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 05:04:49PM +0800, Peng Fan (OSS) wrote:
> From: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
> 
> Record SCU wakeup interrupt in /sys/power/pm_wakeup_irq
> The user can further identify the exact wakeup source by using the
> following interface:
> cat /sys/firmware/scu_wakeup_source/wakeup_src
> 
> The above will print the wake groups and the irqs that could have
> contributed to waking up the kernel. For example if ON/OFF button was the
> wakeup source:
> cat /sys/firmware/scu_wakeup_source/wakeup_src
> Wakeup source group = 3, irq = 0x1
> 
> The user can refer to the SCFW API documentation to identify all the
> wake groups and irqs.
> 
> Signed-off-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/imx/imx-scu-irq.c | 66 +++++++++++++++++++++++++++---
>  1 file changed, 61 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
> index 8d902db1daf2..fcbaa393897c 100644
> --- a/drivers/firmware/imx/imx-scu-irq.c
> +++ b/drivers/firmware/imx/imx-scu-irq.c
> @@ -11,6 +11,8 @@
>  #include <linux/firmware/imx/sci.h>
>  #include <linux/mailbox_client.h>
>  #include <linux/suspend.h>
> +#include <linux/sysfs.h>
> +#include <linux/kobject.h>

Can we keep the list alphabetically sorted?

>  
>  #define IMX_SC_IRQ_FUNC_ENABLE	1
>  #define IMX_SC_IRQ_FUNC_STATUS	2
> @@ -40,6 +42,20 @@ struct imx_sc_msg_irq_enable {
>  	u8 enable;
>  } __packed;
>  
> +struct scu_wakeup {
> +	u32 mask;
> +	u32 wakeup_src;
> +	bool valid;
> +};
> +
> +/* Sysfs functions */
> +static struct kobject *wakeup_obj;
> +static ssize_t wakeup_source_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf);
> +static struct kobj_attribute wakeup_source_attr =
> +		__ATTR(wakeup_src, 0660, wakeup_source_show, NULL);
> +
> +static struct scu_wakeup scu_irq_wakeup[IMX_SC_IRQ_NUM_GROUP];
> +
>  static struct imx_sc_ipc *imx_sc_irq_ipc_handle;
>  static struct work_struct imx_sc_irq_work;
>  static BLOCKING_NOTIFIER_HEAD(imx_scu_irq_notifier_chain);
> @@ -71,16 +87,24 @@ static void imx_scu_irq_work_handler(struct work_struct *work)
>  	u8 i;
>  
>  	for (i = 0; i < IMX_SC_IRQ_NUM_GROUP; i++) {
> +		if (scu_irq_wakeup[i].mask) {
> +			scu_irq_wakeup[i].valid = false;
> +			scu_irq_wakeup[i].wakeup_src = 0;
> +		}

Can we have a newline here?

>  		ret = imx_scu_irq_get_status(i, &irq_status);
>  		if (ret) {
> -			pr_err("get irq group %d status failed, ret %d\n",
> -			       i, ret);
> +			pr_err("get irq group %d status failed, ret %d\n", i, ret);

Unrelated change?

>  			return;
>  		}
>  
>  		if (!irq_status)
>  			continue;
> -
> +		if (scu_irq_wakeup[i].mask & irq_status) {
> +			scu_irq_wakeup[i].valid = true;
> +			scu_irq_wakeup[i].wakeup_src = irq_status & scu_irq_wakeup[i].mask;
> +		} else {
> +			scu_irq_wakeup[i].wakeup_src = irq_status;
> +		}

Can we have a newline here?

>  		pm_system_wakeup();
>  		imx_scu_irq_notifier_call_chain(irq_status, &i);
>  	}
> @@ -135,6 +159,11 @@ int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
>  		pr_err("enable irq failed, group %d, mask %d, ret %d\n",
>  			group, mask, ret);
>  
> +	if (enable)
> +		scu_irq_wakeup[group].mask |= mask;
> +	else
> +		scu_irq_wakeup[group].mask &= ~mask;
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(imx_scu_irq_group_enable);
> @@ -144,6 +173,25 @@ static void imx_scu_irq_callback(struct mbox_client *c, void *msg)
>  	schedule_work(&imx_sc_irq_work);
>  }
>  
> +static ssize_t wakeup_source_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +{
> +	int i;
> +
> +	for (i = 0; i < IMX_SC_IRQ_NUM_GROUP; i++) {
> +		if (!scu_irq_wakeup[i].wakeup_src)
> +			continue;
> +
> +		if (scu_irq_wakeup[i].valid)
> +			sprintf(buf, "Wakeup source group = %d, irq = 0x%x\n",
> +				i, scu_irq_wakeup[i].wakeup_src);
> +		else
> +			sprintf(buf, "Spurious SCU wakeup, group = %d, irq = 0x%x\n",
> +				i, scu_irq_wakeup[i].wakeup_src);
> +	}
> +
> +	return strlen(buf);
> +}
> +
>  int imx_scu_enable_general_irq_channel(struct device *dev)
>  {
>  	struct of_phandle_args spec;
> @@ -173,8 +221,7 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
>  
>  	INIT_WORK(&imx_sc_irq_work, imx_scu_irq_work_handler);
>  
> -	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
> -				       "#mbox-cells", 0, &spec))
> +	if (!of_parse_phandle_with_args(dev->of_node, "mboxes", "#mbox-cells", 0, &spec))

Unrelated change?

>  		i = of_alias_get_id(spec.np, "mu");
>  
>  	/* use mu1 as general mu irq channel if failed */
> @@ -183,6 +230,15 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
>  
>  	mu_resource_id = IMX_SC_R_MU_0A + i;
>  
> +	/* Create directory under /sysfs/firmware */
> +	wakeup_obj = kobject_create_and_add("scu_wakeup_source", firmware_kobj);

Should we check error condition here?

> +
> +	if (sysfs_create_file(wakeup_obj, &wakeup_source_attr.attr)) {

Should we populate 'ret' here, or is the sysfs optional?

> +		pr_err("Cannot create sysfs file......\n");

Can we use dev_err() here?

> +		kobject_put(wakeup_obj);
> +		sysfs_remove_file(firmware_kobj, &wakeup_source_attr.attr);

The sysfs_remove_file() is the undo of sysfs_create_file() which hasn't
been successful, right?

Shawn

> +	}
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(imx_scu_enable_general_irq_channel);
> -- 
> 2.37.1
> 
