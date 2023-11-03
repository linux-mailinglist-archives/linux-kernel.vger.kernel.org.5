Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DCD7E04DF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjKCOnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbjKCOnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:43:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCB911B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 07:43:15 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SMNkK4VRnz6K7KY;
        Fri,  3 Nov 2023 22:42:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 3 Nov
 2023 14:43:12 +0000
Date:   Fri, 3 Nov 2023 14:43:11 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andrew Jeffery <andrew@codeconstruct.com.au>
CC:     <minyard@acm.org>, <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <aladyshev22@gmail.com>,
        <jk@codeconstruct.com.au>
Subject: Re: [PATCH 04/10] ipmi: kcs_bmc: Make remove_device() callback
 return void
Message-ID: <20231103144311.000008f1@Huawei.com>
In-Reply-To: <20231103061522.1268637-5-andrew@codeconstruct.com.au>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
        <20231103061522.1268637-5-andrew@codeconstruct.com.au>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Nov 2023 16:45:16 +1030
Andrew Jeffery <andrew@codeconstruct.com.au> wrote:

> Don't pretend there's a valid failure path when there's not.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Whilst I agree returning an error code is pointless, it is perhaps
useful to make sure there is a dev_err() or similar in the paths
now that you've remove the one at the call site.

Minor point and up to you if you want to or not.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/char/ipmi/kcs_bmc.c           | 12 ++----------
>  drivers/char/ipmi/kcs_bmc_cdev_ipmi.c |  6 ++----
>  drivers/char/ipmi/kcs_bmc_client.h    |  2 +-
>  drivers/char/ipmi/kcs_bmc_serio.c     |  6 ++----
>  4 files changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
> index 1a827db8a465..5a3f199241d2 100644
> --- a/drivers/char/ipmi/kcs_bmc.c
> +++ b/drivers/char/ipmi/kcs_bmc.c
> @@ -135,15 +135,11 @@ EXPORT_SYMBOL(kcs_bmc_add_device);
>  void kcs_bmc_remove_device(struct kcs_bmc_device *kcs_bmc)
>  {
>  	struct kcs_bmc_driver *drv;
> -	int rc;
>  
>  	mutex_lock(&kcs_bmc_lock);
>  	list_del(&kcs_bmc->entry);
>  	list_for_each_entry(drv, &kcs_bmc_drivers, entry) {
> -		rc = drv->ops->remove_device(kcs_bmc);
> -		if (rc)
> -			dev_err(kcs_bmc->dev, "Failed to remove chardev for KCS channel %d: %d",
> -				kcs_bmc->channel, rc);
> +		drv->ops->remove_device(kcs_bmc);
>  	}
>  	mutex_unlock(&kcs_bmc_lock);
>  }
> @@ -169,15 +165,11 @@ EXPORT_SYMBOL(kcs_bmc_register_driver);
>  void kcs_bmc_unregister_driver(struct kcs_bmc_driver *drv)
>  {
>  	struct kcs_bmc_device *kcs_bmc;
> -	int rc;
>  
>  	mutex_lock(&kcs_bmc_lock);
>  	list_del(&drv->entry);
>  	list_for_each_entry(kcs_bmc, &kcs_bmc_devices, entry) {
> -		rc = drv->ops->remove_device(kcs_bmc);
> -		if (rc)
> -			dev_err(kcs_bmc->dev, "Failed to remove driver for KCS channel %d: %d",
> -				kcs_bmc->channel, rc);
> +		drv->ops->remove_device(kcs_bmc);
>  	}
>  	mutex_unlock(&kcs_bmc_lock);
>  }
> diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> index cf670e891966..0552a07d6775 100644
> --- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> +++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> @@ -512,7 +512,7 @@ static int kcs_bmc_ipmi_add_device(struct kcs_bmc_device *kcs_bmc)
>  	return 0;
>  }
>  
> -static int kcs_bmc_ipmi_remove_device(struct kcs_bmc_device *kcs_bmc)
> +static void kcs_bmc_ipmi_remove_device(struct kcs_bmc_device *kcs_bmc)
>  {
>  	struct kcs_bmc_ipmi *priv = NULL, *pos;
>  
> @@ -527,7 +527,7 @@ static int kcs_bmc_ipmi_remove_device(struct kcs_bmc_device *kcs_bmc)
>  	spin_unlock_irq(&kcs_bmc_ipmi_instances_lock);
>  
>  	if (!priv)
> -		return -ENODEV;
> +		return;
>  
>  	misc_deregister(&priv->miscdev);
>  	kcs_bmc_disable_device(priv->client.dev, &priv->client);
> @@ -535,8 +535,6 @@ static int kcs_bmc_ipmi_remove_device(struct kcs_bmc_device *kcs_bmc)
>  	devm_kfree(kcs_bmc->dev, priv->data_out);
>  	devm_kfree(kcs_bmc->dev, priv->data_in);
>  	devm_kfree(kcs_bmc->dev, priv);
> -
> -	return 0;
>  }
>  
>  static const struct kcs_bmc_driver_ops kcs_bmc_ipmi_driver_ops = {
> diff --git a/drivers/char/ipmi/kcs_bmc_client.h b/drivers/char/ipmi/kcs_bmc_client.h
> index 814ad8e052ef..1c0df184860d 100644
> --- a/drivers/char/ipmi/kcs_bmc_client.h
> +++ b/drivers/char/ipmi/kcs_bmc_client.h
> @@ -10,7 +10,7 @@
>  
>  struct kcs_bmc_driver_ops {
>  	int (*add_device)(struct kcs_bmc_device *kcs_bmc);
> -	int (*remove_device)(struct kcs_bmc_device *kcs_bmc);
> +	void (*remove_device)(struct kcs_bmc_device *kcs_bmc);
>  };
>  
>  struct kcs_bmc_driver {
> diff --git a/drivers/char/ipmi/kcs_bmc_serio.c b/drivers/char/ipmi/kcs_bmc_serio.c
> index 1793358be782..0320ea974e03 100644
> --- a/drivers/char/ipmi/kcs_bmc_serio.c
> +++ b/drivers/char/ipmi/kcs_bmc_serio.c
> @@ -103,7 +103,7 @@ static int kcs_bmc_serio_add_device(struct kcs_bmc_device *kcs_bmc)
>  	return 0;
>  }
>  
> -static int kcs_bmc_serio_remove_device(struct kcs_bmc_device *kcs_bmc)
> +static void kcs_bmc_serio_remove_device(struct kcs_bmc_device *kcs_bmc)
>  {
>  	struct kcs_bmc_serio *priv = NULL, *pos;
>  
> @@ -118,7 +118,7 @@ static int kcs_bmc_serio_remove_device(struct kcs_bmc_device *kcs_bmc)
>  	spin_unlock_irq(&kcs_bmc_serio_instances_lock);
>  
>  	if (!priv)
> -		return -ENODEV;
> +		return;
>  
>  	/* kfree()s priv->port via put_device() */
>  	serio_unregister_port(priv->port);
> @@ -127,8 +127,6 @@ static int kcs_bmc_serio_remove_device(struct kcs_bmc_device *kcs_bmc)
>  	kcs_bmc_disable_device(kcs_bmc, &priv->client);
>  
>  	devm_kfree(priv->client.dev->dev, priv);
> -
> -	return 0;
>  }
>  
>  static const struct kcs_bmc_driver_ops kcs_bmc_serio_driver_ops = {

