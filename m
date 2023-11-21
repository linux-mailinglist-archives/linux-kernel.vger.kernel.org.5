Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8961F7F39AF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjKUW7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbjKUW70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:59:26 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FE2D72
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:59:14 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b709048d8eso5500807b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700607554; x=1701212354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bEHk2cOMKx9+evztUOD1qvJ0fw8cgg/nhY4zSI6PvLU=;
        b=Dd3zwPY1Fpm5vID0VQkyKTeR+1ssJU6fP3kOQU3WUMhDwdA+gaBJotkz/DDroF9h+s
         z+JEbCP6gk8TOtE2gGIRY+It3cxPrnnikstVwnA4C6UAB7tNT6O9KfXCSN4lgoimmBWy
         Ew7RY0cm+wdgZ6b4ElEi2Y+hzXCWWf6XNz/UE7RnytpxkWDDFHdE8VrkyjH/uqj85+Ah
         fF0w3gCg5mZdnI4WyZuZ7yvzDJWTg83Tkw9Mqqnz1Li6qdW2QmsEYdO1J9pK9QMkQeSc
         JuFqr83KtC9Fz05ZeSIcEotEP/tUuwezDhatYEpeJPqnnHA57ksEhfwQCGHVpUIROzPT
         cJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700607554; x=1701212354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEHk2cOMKx9+evztUOD1qvJ0fw8cgg/nhY4zSI6PvLU=;
        b=IinpnU8CknyZqaVJsFOrA4uPhWV5HwaAENHunJDcuI9ElPrZJyF9fyFZmb86Jsrjg9
         tlmqKagVjjPkT65D6yEY32t25lHJqhakI/BY/Oog7+5sCZPOGcuXW5riEhqpJe4vrP8Q
         PN5u9V1ntVJV/bUWDOrvkRt3gkjUOi9PrJwmvntov9ll+V3TkDmHwhNnjBwVMXCVFt1X
         mahUC3u6qqkII5iRQsCtYwDIQNU1EFKweY37ajbLPCUxxkYnt4D49ZaKteFdYkId+RBW
         k5Jzucjw6UaEBRCp9geRvcjzQ7u1OrhJGxibwu8qepSnObU62L9wmO6+vMhXCKHd4dpm
         REXw==
X-Gm-Message-State: AOJu0YweXCm5cP8+XthrSmoyOcRQIxp1D5nKSSC+2PFApHtWm3lJN6tH
        WDRUkRT4i4N8hrL7uDWaSOVkZA==
X-Google-Smtp-Source: AGHT+IGPBxYJBQXjFKfjEBs6oz5erv1g/GgywcQAuMM69rkzjZmlgx7NhmIqgbAtI4EWBbcKTkGcxw==
X-Received: by 2002:a05:6a21:328a:b0:187:f7d3:fdd with SMTP id yt10-20020a056a21328a00b00187f7d30fddmr497990pzb.56.1700607554084;
        Tue, 21 Nov 2023 14:59:14 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:e181:8f:af54:8e11])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b001bbd1562e75sm8458471plg.55.2023.11.21.14.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 14:59:13 -0800 (PST)
Date:   Tue, 21 Nov 2023 15:59:11 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, ben.levinsky@amd.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/4] remoteproc: zynqmp: add pm domains support
Message-ID: <ZV02P3bHEhPLQHBo@p14s>
References: <20231117174238.1876655-1-tanmay.shah@amd.com>
 <20231117174238.1876655-4-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117174238.1876655-4-tanmay.shah@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 17, 2023 at 09:42:37AM -0800, Tanmay Shah wrote:
> Use TCM pm domains extracted from device-tree
> to power on/off TCM using general pm domain framework.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v7:
>   - %s/pm_dev1/pm_dev_core0/r
>   - %s/pm_dev_link1/pm_dev_core0_link/r
>   - %s/pm_dev2/pm_dev_core1/r
>   - %s/pm_dev_link2/pm_dev_core1_link/r
>   - remove pm_domain_id check to move next patch
>   - add comment about how 1st entry in pm domain list is used
>   - fix loop when jump to fail_add_pm_domains loop
> 
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 215 +++++++++++++++++++++++-
>  1 file changed, 212 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index 4395edea9a64..22bccc5075a0 100644
> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> @@ -16,6 +16,7 @@
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/remoteproc.h>
> +#include <linux/pm_domain.h>
>  
>  #include "remoteproc_internal.h"
>  
> @@ -102,6 +103,12 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
>   * @rproc: rproc handle
>   * @pm_domain_id: RPU CPU power domain id
>   * @ipi: pointer to mailbox information
> + * @num_pm_dev: number of tcm pm domain devices for this core
> + * @pm_dev_core0: pm domain virtual devices for power domain framework
> + * @pm_dev_core0_link: pm domain device links after registration
> + * @pm_dev_core1: used only in lockstep mode. second core's pm domain virtual devices
> + * @pm_dev_core1_link: used only in lockstep mode. second core's pm device links after
> + * registration
>   */
>  struct zynqmp_r5_core {
>  	struct device *dev;
> @@ -111,6 +118,11 @@ struct zynqmp_r5_core {
>  	struct rproc *rproc;
>  	u32 pm_domain_id;
>  	struct mbox_info *ipi;
> +	int num_pm_dev;
> +	struct device **pm_dev_core0;
> +	struct device_link **pm_dev_core0_link;
> +	struct device **pm_dev_core1;
> +	struct device_link **pm_dev_core1_link;
>  };
>  
>  /**
> @@ -651,7 +663,8 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
>  					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
>  					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
>  		if (ret < 0) {
> -			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> +			dev_err(dev, "failed to turn on TCM 0x%x",
> +				pm_domain_id);

Spurious change, you should have caught that.

>  			goto release_tcm_lockstep;
>  		}
>  
> @@ -758,6 +771,189 @@ static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
>  	return ret;
>  }
>  
> +static void zynqmp_r5_remove_pm_domains(struct rproc *rproc)
> +{
> +	struct zynqmp_r5_core *r5_core = rproc->priv;
> +	struct device *dev = r5_core->dev;
> +	struct zynqmp_r5_cluster *cluster;
> +	int i;
> +
> +	cluster = platform_get_drvdata(to_platform_device(dev->parent));
> +
> +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> +		device_link_del(r5_core->pm_dev_core0_link[i]);
> +		dev_pm_domain_detach(r5_core->pm_dev_core0[i], false);
> +	}
> +
> +	kfree(r5_core->pm_dev_core0);
> +	r5_core->pm_dev_core0 = NULL;
> +	kfree(r5_core->pm_dev_core0_link);
> +	r5_core->pm_dev_core0_link = NULL;
> +
> +	if (cluster->mode == SPLIT_MODE) {
> +		r5_core->num_pm_dev = 0;
> +		return;
> +	}
> +
> +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> +		device_link_del(r5_core->pm_dev_core1_link[i]);
> +		dev_pm_domain_detach(r5_core->pm_dev_core1[i], false);
> +	}
> +
> +	kfree(r5_core->pm_dev_core1);
> +	r5_core->pm_dev_core1 = NULL;
> +	kfree(r5_core->pm_dev_core1_link);
> +	r5_core->pm_dev_core1_link = NULL;
> +	r5_core->num_pm_dev = 0;
> +}
> +
> +static int zynqmp_r5_add_pm_domains(struct rproc *rproc)
> +{
> +	struct zynqmp_r5_core *r5_core = rproc->priv;
> +	struct device *dev = r5_core->dev, *dev2;
> +	struct zynqmp_r5_cluster *cluster;
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +	int i, j, num_pm_dev, ret;
> +
> +	cluster = dev_get_drvdata(dev->parent);
> +
> +	/* get number of power-domains */
> +	num_pm_dev = of_count_phandle_with_args(r5_core->np, "power-domains",
> +						"#power-domain-cells");
> +
> +	if (num_pm_dev <= 0)
> +		return -EINVAL;
> +
> +	r5_core->pm_dev_core0 = kcalloc(num_pm_dev,
> +					sizeof(struct device *),
> +					GFP_KERNEL);
> +	if (!r5_core->pm_dev_core0)
> +		ret = -ENOMEM;
> +
> +	r5_core->pm_dev_core0_link = kcalloc(num_pm_dev,
> +					     sizeof(struct device_link *),
> +					     GFP_KERNEL);
> +	if (!r5_core->pm_dev_core0_link) {
> +		kfree(r5_core->pm_dev_core0);
> +		r5_core->pm_dev_core0 = NULL;
> +		return -ENOMEM;
> +	}
> +
> +	r5_core->num_pm_dev = num_pm_dev;
> +
> +	/*
> +	 * start from 2nd entry in power-domains property list as
> +	 * for zynqmp we only add TCM power domains and not core's power domain.
> +	 * 1st entry is used to configure r5 operation mode.

You are still not saying _where_ ->pm_dev_core0[0] gets added.

> +	 */
> +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> +		r5_core->pm_dev_core0[i] = dev_pm_domain_attach_by_id(dev, i);
> +		if (IS_ERR_OR_NULL(r5_core->pm_dev_core0[i])) {

Here IS_ERR_OR_NULL() is used while two if conditions for NULL and an error
code are used in the loop for the lockstep mode.  Please pick one heuristic and
stick with it.  I have no preference on which one.

> +			dev_dbg(dev, "failed to attach pm domain %d, ret=%ld\n", i,
> +				PTR_ERR(r5_core->pm_dev_core0[i]));
> +			ret = -EINVAL;
> +			goto fail_add_pm_domains;
> +		}
> +		r5_core->pm_dev_core0_link[i] = device_link_add(dev,
> +								r5_core->pm_dev_core0[i],
> +								DL_FLAG_STATELESS |
> +								DL_FLAG_RPM_ACTIVE |
> +								DL_FLAG_PM_RUNTIME);
> +		if (!r5_core->pm_dev_core0_link[i]) {
> +			dev_pm_domain_detach(r5_core->pm_dev_core0[i], true);
> +			r5_core->pm_dev_core0[i] = NULL;
> +			ret = -EINVAL;
> +			goto fail_add_pm_domains;
> +		}
> +	}
> +
> +	if (cluster->mode == SPLIT_MODE)
> +		return 0;
> +
> +	r5_core->pm_dev_core1 = kcalloc(num_pm_dev,
> +					sizeof(struct device *),
> +					GFP_KERNEL);
> +	if (!r5_core->pm_dev_core1) {
> +		ret = -ENOMEM;
> +		goto fail_add_pm_domains;
> +	}
> +
> +	r5_core->pm_dev_core1_link = kcalloc(num_pm_dev,
> +					     sizeof(struct device_link *),
> +					     GFP_KERNEL);
> +	if (!r5_core->pm_dev_core1_link) {
> +		kfree(r5_core->pm_dev_core1);
> +		r5_core->pm_dev_core1 = NULL;
> +		ret = -ENOMEM;
> +		goto fail_add_pm_domains;
> +	}
> +
> +	/* get second core's device to detach its power-domains */
> +	np = of_get_next_child(cluster->dev->of_node, of_node_get(dev->of_node));
> +
> +	pdev = of_find_device_by_node(np);
> +	if (!pdev) {
> +		dev_err(cluster->dev, "core1 platform device not available\n");
> +		kfree(r5_core->pm_dev_core1);
> +		kfree(r5_core->pm_dev_core1_link);
> +		r5_core->pm_dev_core1 = NULL;
> +		r5_core->pm_dev_core1_link = NULL;
> +		ret = -EINVAL;
> +		goto fail_add_pm_domains;
> +	}
> +
> +	dev2 = &pdev->dev;
> +
> +	/* for zynqmp we only add TCM power domains and not core's power domain */
> +	for (j = 1; j < r5_core->num_pm_dev; j++) {
> +		r5_core->pm_dev_core1[j] = dev_pm_domain_attach_by_id(dev2, j);
> +		if (!r5_core->pm_dev_core1[j]) {
> +			dev_dbg(dev, "can't attach to pm domain %d\n", j);
> +			ret = -EINVAL;
> +			goto fail_add_pm_domains_lockstep;
> +		} else if (IS_ERR(r5_core->pm_dev_core1[j])) {
> +			dev_dbg(dev, "can't attach to pm domain %d\n", j);
> +			ret = PTR_ERR(r5_core->pm_dev_core1[j]);
> +			goto fail_add_pm_domains_lockstep;
> +		}
> +
> +		r5_core->pm_dev_core1_link[j] = device_link_add(dev,
> +								r5_core->pm_dev_core1[j],
> +								DL_FLAG_STATELESS |
> +								DL_FLAG_RPM_ACTIVE |
> +								DL_FLAG_PM_RUNTIME);
> +		if (!r5_core->pm_dev_core1_link[j]) {
> +			dev_pm_domain_detach(r5_core->pm_dev_core1[j], true);
> +			r5_core->pm_dev_core1[j] = NULL;
> +			ret = -ENODEV;
> +			goto fail_add_pm_domains_lockstep;
> +		}
> +	}
> +
> +fail_add_pm_domains_lockstep:
> +	while (--j >= 0) {
> +		device_link_del(r5_core->pm_dev_core1_link[j]);
> +		dev_pm_domain_detach(r5_core->pm_dev_core1[j], true);
> +	}
> +	kfree(r5_core->pm_dev_core1);
> +	r5_core->pm_dev_core1 = NULL;
> +	kfree(r5_core->pm_dev_core1_link);
> +	r5_core->pm_dev_core1_link = NULL;
> +
> +fail_add_pm_domains:
> +	while (--i >= 0) {
> +		device_link_del(r5_core->pm_dev_core0_link[i]);
> +		dev_pm_domain_detach(r5_core->pm_dev_core0[i], true);
> +	}
> +	kfree(r5_core->pm_dev_core0);
> +	r5_core->pm_dev_core0 = NULL;
> +	kfree(r5_core->pm_dev_core0_link);
> +	r5_core->pm_dev_core0_link = NULL;
> +

The error path is much cleaner and readable now.

I will continue tomorrow.

Mathieu

> +	return ret;
> +}
> +
>  /**
>   * zynqmp_r5_rproc_prepare()
>   * adds carveouts for TCM bank and reserved memory regions
> @@ -770,19 +966,30 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
>  {
>  	int ret;
>  
> +	ret = zynqmp_r5_add_pm_domains(rproc);
> +	if (ret) {
> +		dev_err(&rproc->dev, "failed to add pm domains\n");
> +		return ret;
> +	}
> +
>  	ret = add_tcm_banks(rproc);
>  	if (ret) {
>  		dev_err(&rproc->dev, "failed to get TCM banks, err %d\n", ret);
> -		return ret;
> +		goto fail_prepare;
>  	}
>  
>  	ret = add_mem_regions_carveout(rproc);
>  	if (ret) {
>  		dev_err(&rproc->dev, "failed to get reserve mem regions %d\n", ret);
> -		return ret;
> +		goto fail_prepare;
>  	}
>  
>  	return 0;
> +
> +fail_prepare:
> +	zynqmp_r5_remove_pm_domains(rproc);
> +
> +	return ret;
>  }
>  
>  /**
> @@ -801,6 +1008,8 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
>  
>  	r5_core = rproc->priv;
>  
> +	zynqmp_r5_remove_pm_domains(rproc);
> +
>  	for (i = 0; i < r5_core->tcm_bank_count; i++) {
>  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
>  		if (zynqmp_pm_release_node(pm_domain_id))
> -- 
> 2.25.1
> 
