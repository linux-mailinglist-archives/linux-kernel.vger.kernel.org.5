Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31017E04E6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjKCOqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjKCOqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:46:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20F2D58
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 07:46:01 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SMNnX3Tk0z6K8hg;
        Fri,  3 Nov 2023 22:45:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 3 Nov
 2023 14:45:59 +0000
Date:   Fri, 3 Nov 2023 14:45:59 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andrew Jeffery <andrew@codeconstruct.com.au>
CC:     <minyard@acm.org>, <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <aladyshev22@gmail.com>,
        <jk@codeconstruct.com.au>
Subject: Re: [PATCH 06/10] ipmi: kcs_bmc: Integrate buffers into driver
 struct
Message-ID: <20231103144559.00003faf@Huawei.com>
In-Reply-To: <20231103061522.1268637-7-andrew@codeconstruct.com.au>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
        <20231103061522.1268637-7-andrew@codeconstruct.com.au>
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

On Fri,  3 Nov 2023 16:45:18 +1030
Andrew Jeffery <andrew@codeconstruct.com.au> wrote:

> Consolidate several necessary allocations into one to reduce the number
> of possible error paths.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Gets rid of some of the devm_kfree() fun, so I'm in favor of the change :)

One trivial comment inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> index 712a80c27060..45ac930172ec 100644
> --- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> +++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> @@ -66,6 +66,10 @@ enum kcs_ipmi_errors {
>  	KCS_UNSPECIFIED_ERROR       = 0xFF
>  };
>  
> +#define DEVICE_NAME "ipmi-kcs"
> +#define KCS_MSG_BUFSIZ    1000
> +#define KCS_ZERO_DATA     0
> +
>  struct kcs_bmc_ipmi {
>  	struct list_head entry;
>  
> @@ -79,24 +83,18 @@ struct kcs_bmc_ipmi {
>  	wait_queue_head_t queue;
>  	bool data_in_avail;
>  	int  data_in_idx;
> -	u8  *data_in;
> +	u8   data_in[KCS_MSG_BUFSIZ];
>  
>  	int  data_out_idx;
>  	int  data_out_len;
> -	u8  *data_out;
> +	u8   data_out[KCS_MSG_BUFSIZ];
>  
>  	struct mutex mutex;
> -	u8 *kbuffer;
> +	u8 kbuffer[KCS_MSG_BUFSIZ];
>  
>  	struct miscdevice miscdev;
>  };
>  
> -#define DEVICE_NAME "ipmi-kcs"
> -
> -#define KCS_MSG_BUFSIZ    1000
> -
> -#define KCS_ZERO_DATA     0
> -
>  /* IPMI 2.0 - Table 9-1, KCS Interface Status Register Bits */
>  #define KCS_STATUS_STATE(state) (state << 6)
>  #define KCS_STATUS_STATE_MASK   GENMASK(7, 6)
> @@ -478,19 +476,15 @@ static int kcs_bmc_ipmi_add_device(struct kcs_bmc_device *kcs_bmc)
>  
>  	spin_lock_init(&priv->lock);
>  	mutex_init(&priv->mutex);
> -
Unrelated change...

>  	init_waitqueue_head(&priv->queue);
>  
>  	priv->client.dev = kcs_bmc;
>  	priv->client.ops = &kcs_bmc_ipmi_client_ops;
> -	priv->data_in = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
> -	priv->data_out = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
> -	priv->kbuffer = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
>  
>  	priv->miscdev.minor = MISC_DYNAMIC_MINOR;
>  	priv->miscdev.name = devm_kasprintf(kcs_bmc->dev, GFP_KERNEL, "%s%u", DEVICE_NAME,
>  					   kcs_bmc->channel);
> -	if (!priv->data_in || !priv->data_out || !priv->kbuffer || !priv->miscdev.name)
> +	if (!priv->miscdev.name)
>  		return -EINVAL;
>  
>  	priv->miscdev.fops = &kcs_bmc_ipmi_fops;
> @@ -529,9 +523,6 @@ static void kcs_bmc_ipmi_remove_device(struct kcs_bmc_device *kcs_bmc)
>  
>  	misc_deregister(&priv->miscdev);
>  	kcs_bmc_disable_device(&priv->client);
> -	devm_kfree(kcs_bmc->dev, priv->kbuffer);
> -	devm_kfree(kcs_bmc->dev, priv->data_out);
> -	devm_kfree(kcs_bmc->dev, priv->data_in);
>  	devm_kfree(kcs_bmc->dev, priv);
>  }
>  

