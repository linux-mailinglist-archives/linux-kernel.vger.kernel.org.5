Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF307EDE00
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345001AbjKPJwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344956AbjKPJwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:52:44 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D34C5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:52:40 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AG4atev025640;
        Thu, 16 Nov 2023 10:52:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=nBzSy7n1xWIhzkLtYHCV9HlDSadwoH7tBhZuaddKxb4=; b=2A
        h6q44MDZNFe/qGA3k+cLr/pD2ECyNJVX18WWGwYAV5PRgMk6mevmzg/pCPMLtwjk
        jqvfwEd657482YAWtRuz8WHwPzIty2cg7MQtv51XnagRD/WEKnXd2Zd8Kswd2awq
        loamvMHPJdxiWGRpdpi1mql+Mzq79tqgHZHqBv5Fwp3F+0a9eWS4Ms5w1srE4q2t
        uwLjX2ucsAs30IDiql/mJ7EDGYq6uLBoNnTFaaQfrVCjKST9OcfW81eJeILfqZDI
        hFPUQSUFVJ/Lg4HAqoSfXyG6uQgAEUbkrwOgRv/J03SzGQ086KJrEQ7PjTtcoZ+A
        /7IE9fIbqEr8vhltOsNw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u9ywme3jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 10:52:00 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 485D8100056;
        Thu, 16 Nov 2023 10:51:58 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3FA3B217B71;
        Thu, 16 Nov 2023 10:51:58 +0100 (CET)
Received: from [10.201.20.54] (10.201.20.54) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 16 Nov
 2023 10:51:57 +0100
Message-ID: <6ef31fbd-4c90-45f5-83c0-9a41dfd2b59a@foss.st.com>
Date:   Thu, 16 Nov 2023 10:51:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] reset: Use device_get_match_data()
To:     Rob Herring <robh@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <openbmc@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20231115205848.3732609-1-robh@kernel.org>
Content-Language: en-US
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20231115205848.3732609-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.54]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_07,2023-11-15_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/23 21:58, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/reset/reset-npcm.c       |  5 ++---
>  drivers/reset/sti/reset-syscfg.c | 11 ++++++-----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
> index f6c4f854f2be..8935ef95a2d1 100644
> --- a/drivers/reset/reset-npcm.c
> +++ b/drivers/reset/reset-npcm.c
> @@ -6,8 +6,8 @@
>  #include <linux/io.h>
>  #include <linux/init.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/reboot.h>
>  #include <linux/reset-controller.h>
>  #include <linux/spinlock.h>
> @@ -351,8 +351,7 @@ static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
>  		}
>  	}
>  
> -	rc->info = (const struct npcm_reset_info *)
> -			of_match_device(dev->driver->of_match_table, dev)->data;
> +	rc->info = device_get_match_data(dev);
>  	switch (rc->info->bmc_id) {
>  	case BMC_NPCM7XX:
>  		npcm_usb_reset_npcm7xx(rc);
> diff --git a/drivers/reset/sti/reset-syscfg.c b/drivers/reset/sti/reset-syscfg.c
> index c1ba04f6f155..2324060b747c 100644
> --- a/drivers/reset/sti/reset-syscfg.c
> +++ b/drivers/reset/sti/reset-syscfg.c
> @@ -7,10 +7,11 @@
>   */
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/module.h>
>  #include <linux/err.h>
>  #include <linux/types.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/regmap.h>
>  #include <linux/mfd/syscon.h>
>  
> @@ -183,14 +184,14 @@ static int syscfg_reset_controller_register(struct device *dev,
>  int syscfg_reset_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = pdev ? &pdev->dev : NULL;
> -	const struct of_device_id *match;
> +	const void *data;
>  
>  	if (!dev || !dev->driver)
>  		return -ENODEV;
>  
> -	match = of_match_device(dev->driver->of_match_table, dev);
> -	if (!match || !match->data)
> +	data = device_get_match_data(&pdev->dev);
> +	if (!data)
>  		return -EINVAL;
>  
> -	return syscfg_reset_controller_register(dev, match->data);
> +	return syscfg_reset_controller_register(dev, data);
>  }

for drivers/reset/sti/reset-syscfg.c
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
