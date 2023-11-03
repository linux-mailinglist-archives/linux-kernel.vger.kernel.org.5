Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE3A7E053E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjKCPFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKCPFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:05:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76348D47
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 08:05:25 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SMP8D2v51z6J9ZY;
        Fri,  3 Nov 2023 23:01:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 3 Nov
 2023 15:05:23 +0000
Date:   Fri, 3 Nov 2023 15:05:22 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andrew Jeffery <andrew@codeconstruct.com.au>
CC:     <minyard@acm.org>, <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <aladyshev22@gmail.com>,
        <jk@codeconstruct.com.au>
Subject: Re: [PATCH 08/10] ipmi: kcs_bmc: Track clients in core
Message-ID: <20231103150522.00004539@Huawei.com>
In-Reply-To: <20231103061522.1268637-9-andrew@codeconstruct.com.au>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
        <20231103061522.1268637-9-andrew@codeconstruct.com.au>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Nov 2023 16:45:20 +1030
Andrew Jeffery <andrew@codeconstruct.com.au> wrote:

> I ran out of spoons before I could come up with a better client tracking
> scheme back in the original refactoring series:
> 
> https://lore.kernel.org/all/20210608104757.582199-1-andrew@aj.id.au/
> 
> Jonathan prodded Konstantin about the issue in a review of Konstantin's
> MCTP patches[1], prompting an attempt to clean it up.
> 
> [1]: https://lore.kernel.org/all/20230929120835.0000108e@Huawei.com/
> 
> Prevent client modules from having to track their own instances by
> requiring they return a pointer to a client object from their
> add_device() implementation. We can then track this in the core, and
> provide it as the argument to the remove_device() implementation to save
> the client module from further work. The usual container_of() pattern
> gets the client module access to its private data.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Hi Andrew,

A few comments inline.
More generally, whilst this is definitely an improvement I'd have been tempted
to make more use of the linux device model for this with the clients added
as devices with a parent of the kcs_bmc_device.  That would then allow for
simple dependency tracking, binding of individual drivers and all that.

What you have here feels fine though and is a much less invasive change.

Jonathan


> diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> index 98f231f24c26..9fca31f8c7c2 100644
> --- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> +++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> @@ -71,8 +71,6 @@ enum kcs_ipmi_errors {



> +static struct kcs_bmc_client *
> +kcs_bmc_ipmi_add_device(struct kcs_bmc_driver *drv, struct kcs_bmc_device *dev)
>  {
>  	struct kcs_bmc_ipmi *priv;
>  	int rc;
>  
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> -		return -ENOMEM;
> +		return ERR_PTR(ENOMEM);
As below. I thought it took negatives..
>  
>  	spin_lock_init(&priv->lock);
>  	mutex_init(&priv->mutex);
>  	init_waitqueue_head(&priv->queue);
>  
> -	priv->client.dev = kcs_bmc;
> -	priv->client.ops = &kcs_bmc_ipmi_client_ops;
> +	kcs_bmc_client_init(&priv->client, &kcs_bmc_ipmi_client_ops, drv, dev);
>  
>  	priv->miscdev.minor = MISC_DYNAMIC_MINOR;
> -	priv->miscdev.name = kasprintf(GFP_KERNEL, "%s%u", DEVICE_NAME, kcs_bmc->channel);
> +	priv->miscdev.name = kasprintf(GFP_KERNEL, "%s%u", DEVICE_NAME, dev->channel);
>  	if (!priv->miscdev.name) {
>  		rc = -ENOMEM;
ERR_PTR
>  		goto cleanup_priv;



...

> diff --git a/drivers/char/ipmi/kcs_bmc_serio.c b/drivers/char/ipmi/kcs_bmc_serio.c
> index 0a68c76da955..3cfda39506f6 100644
> --- a/drivers/char/ipmi/kcs_bmc_serio.c
> +++ b/drivers/char/ipmi/kcs_bmc_serio.c

...


> +static struct kcs_bmc_client *
> +kcs_bmc_serio_add_device(struct kcs_bmc_driver *drv, struct kcs_bmc_device *dev)
>  {
>  	struct kcs_bmc_serio *priv;
>  	struct serio *port;
> @@ -75,12 +71,12 @@ static int kcs_bmc_serio_add_device(struct kcs_bmc_device *kcs_bmc)
>  
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> -		return -ENOMEM;
> +		return ERR_PTR(ENOMEM);
>  
>  	/* Use kzalloc() as the allocation is cleaned up with kfree() via serio_unregister_port() */
>  	port = kzalloc(sizeof(*port), GFP_KERNEL);
>  	if (!port) {
> -		rc = -ENOMEM;
> +		rc = ENOMEM;
Why positive?
Doesn't ERR_PTR() typically get passed negatives? 

>  		goto cleanup_priv;
>  	}
>  
> @@ -88,45 +84,28 @@ static int kcs_bmc_serio_add_device(struct kcs_bmc_device *kcs_bmc)
>  	port->open = kcs_bmc_serio_open;
>  	port->close = kcs_bmc_serio_close;
>  	port->port_data = priv;
> -	port->dev.parent = kcs_bmc->dev;
> +	port->dev.parent = dev->dev;
>  
>  	spin_lock_init(&priv->lock);
>  	priv->port = port;
> -	priv->client.dev = kcs_bmc;
> -	priv->client.ops = &kcs_bmc_serio_client_ops;
>  
> -	spin_lock_irq(&kcs_bmc_serio_instances_lock);
> -	list_add(&priv->entry, &kcs_bmc_serio_instances);
> -	spin_unlock_irq(&kcs_bmc_serio_instances_lock);
> +	kcs_bmc_client_init(&priv->client, &kcs_bmc_serio_client_ops, drv, dev);
>  
>  	serio_register_port(port);
>  
> -	pr_info("Initialised serio client for channel %d\n", kcs_bmc->channel);
> +	pr_info("Initialised serio client for channel %d\n", dev->channel);
>  
> -	return 0;
> +	return &priv->client;
>  
>  cleanup_priv:
>  	kfree(priv);
>  
> -	return rc;
> +	return ERR_PTR(rc);
>  }

