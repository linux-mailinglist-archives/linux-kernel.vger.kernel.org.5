Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10717C9F07
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjJPFlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjJPFlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:41:23 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72968E0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:41:20 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id sGLqqw1YgzhI0sGLqqd1yf; Mon, 16 Oct 2023 07:41:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1697434878;
        bh=/n+tFNXdPwOJ6d19BaRcNoyu9yN3bdZ6yXB4UOXT29Q=;
        h=Date:Subject:To:References:Cc:From:In-Reply-To;
        b=CaZftvMttbHKDGt5Yl2YMSKbF/ZzixKDZiFrOxsHxV2ANUW00S51EAUOEcW93AbCZ
         KVTBMtSUz1Gx2PgRpLGqOGdmCVPyipWvxjWgCzrT1g2k8YbLgpGFDK5ywTMagJ9PR1
         AAV9DtGh68UxB38MFQLDRW87EeU+RZ/hzVH5yC0IBhT2IuEtwR4AUa9rDaMuDAgBnG
         BVBwkk2WyQ0Wz2Jt0aTtx3J2zLTW8zvg3e7vyPqC91RWbqnB6rzm0wP3wiEX3mK9RF
         G3Rj+11E/4Wb4k3rxmm0hoZ6l2qGsgx/uA4DQPVSwVRiVZRmkwyWL41xd25P4/vbMz
         gggGxd7pWJhwg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 16 Oct 2023 07:41:18 +0200
X-ME-IP: 86.243.2.178
Message-ID: <998767cb-1c70-45c2-91cc-858315be1a52@wanadoo.fr>
Date:   Mon, 16 Oct 2023 07:41:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
To:     kkartik@nvidia.com
References: <20231016053411.3380-1-kkartik@nvidia.com>
 <20231016053411.3380-5-kkartik@nvidia.com>
Content-Language: fr
Cc:     akpm@linux-foundation.org, andy@kernel.org, arnd@arndb.de,
        frank.li@vivo.com, jonathanh@nvidia.com, keescook@chromium.org,
        linus.walleij@linaro.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-tegra@vger.kernel.org, pdeschrijver@nvidia.com,
        petlozup@nvidia.com, pshete@nvidia.com, robh@kernel.org,
        stefank@nvidia.com, thierry.reding@gmail.com,
        ulf.hansson@linaro.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231016053411.3380-5-kkartik@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16/10/2023 à 07:34, Kartik a écrit :
> In preparation to ACPI support in Tegra fuse driver add function
> tegra_acpi_init_apbmisc() to initialize tegra-apbmisc driver.
> Also, document the reason of calling tegra_init_apbmisc() at early init.
> 
> Note that function tegra_acpi_init_apbmisc() is not placed in the __init
> section, because it will be called during probe.
> 
> Signed-off-by: Kartik <kkartik-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> v2 -> v3:
> 	* Fix build warnings seen when CONFIG_ACPI is disabled by moving
> 	  tegra_init_apbmisc table inside #ifdef CONFIG_ACPI block.
> 
> v1 -> v2:
> 	* Update ACPI ID table 'tegra_init_apbmisc'.
> 	* Add comment to document the reason to call tegra_init_apbmisc
> 	  at early init.
> 	* Fix an issue where acpi_dev_free_resource_list() and
> 	* acpi_dev_put() were not called if
> 	  acpi_dev_get_memory_resources() returned 1.
> 	* Update logic to fetch memory resources in
> 	  tegra_acpi_init_apbmisc().
> 	* Fix build errors seen when CONFIG_ACPI is disabled.
> ---
>   drivers/soc/tegra/fuse/fuse.h          |  1 +
>   drivers/soc/tegra/fuse/tegra-apbmisc.c | 72 ++++++++++++++++++++++++++
>   2 files changed, 73 insertions(+)
> 
> diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
> index 90f23be73894..a41e9f85281a 100644
> --- a/drivers/soc/tegra/fuse/fuse.h
> +++ b/drivers/soc/tegra/fuse/fuse.h
> @@ -69,6 +69,7 @@ struct tegra_fuse {
>   
>   void tegra_init_revision(void);
>   void tegra_init_apbmisc(void);
> +void tegra_acpi_init_apbmisc(void);
>   
>   u32 __init tegra_fuse_read_spare(unsigned int spare);
>   u32 __init tegra_fuse_read_early(unsigned int offset);
> diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
> index 06c1b3a2c7ec..e2ca93de6c1f 100644
> --- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
> +++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
> @@ -3,9 +3,11 @@
>    * Copyright (c) 2014-2023, NVIDIA CORPORATION.  All rights reserved.
>    */
>   
> +#include <linux/acpi.h>
>   #include <linux/export.h>
>   #include <linux/io.h>
>   #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>   #include <linux/of.h>
>   #include <linux/of_address.h>
>   
> @@ -180,6 +182,12 @@ static void tegra_init_apbmisc_resources(struct resource *apbmisc,
>   	}
>   }
>   
> +/**
> + * tegra_init_apbmisc - Initializes Tegra APBMISC and Strapping registers.
> + *
> + * This is called during early init as some of the old 32-bit ARM code needs
> + * information from the APBMISC registers very early during boot.
> + */
>   void __init tegra_init_apbmisc(void)
>   {
>   	struct resource apbmisc, straps;
> @@ -244,3 +252,67 @@ void __init tegra_init_apbmisc(void)
>   put:
>   	of_node_put(np);
>   }
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id apbmisc_acpi_match[] = {
> +	{ "NVDA2010" },
> +	{ /* sentinel */ }
> +};
> +
> +void tegra_acpi_init_apbmisc(void)
> +{
> +	struct resource *resources[2] = { NULL };
> +	struct resource_entry *rentry, *tmp;
> +	struct acpi_device *adev = NULL;
> +	struct list_head resource_list;
> +	int rcount = 0;
> +	int ret;
> +
> +	adev = acpi_dev_get_first_match_dev(apbmisc_acpi_match[0].id, NULL, -1);
> +	if (!adev)
> +		return;
> +
> +	INIT_LIST_HEAD(&resource_list);
> +
> +	ret = acpi_dev_get_memory_resources(adev, &resource_list);
> +	if (ret < 0) {
> +		pr_err("failed to get APBMISC memory resources");
> +		goto out_put_acpi_dev;
> +	}
> +
> +	/*
> +	 * Get required memory resources.
> +	 *
> +	 * resources[0]: apbmisc.
> +	 * resources[1]: straps.
> +	 */
> +	resource_list_for_each_entry_safe(rentry, tmp, &resource_list) {

Nit: Is the 'safe' version really needed here?

CJ

> +		if (rcount >= ARRAY_SIZE(resources))
> +			break;
> +
> +		resources[rcount++] = rentry->res;
> +	}
> +
> +	if (!resources[0]) {
> +		pr_err("failed to get APBMISC registers\n");
> +		goto out_free_resource_list;
> +	}
> +
> +	if (!resources[1]) {
> +		pr_err("failed to get strapping options registers\n");
> +		goto out_free_resource_list;
> +	}
> +
> +	tegra_init_apbmisc_resources(resources[0], resources[1]);
> +
> +out_free_resource_list:
> +	acpi_dev_free_resource_list(&resource_list);
> +
> +out_put_acpi_dev:
> +	acpi_dev_put(adev);
> +}
> +#else
> +void tegra_acpi_init_apbmisc(void)
> +{
> +}
> +#endif

