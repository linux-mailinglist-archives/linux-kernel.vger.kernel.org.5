Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5927E04D4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377818AbjKCOkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377768AbjKCOkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:40:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C91A2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 07:40:30 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SMNg80Rvpz67y8R;
        Fri,  3 Nov 2023 22:39:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 3 Nov
 2023 14:40:27 +0000
Date:   Fri, 3 Nov 2023 14:40:26 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andrew Jeffery <andrew@codeconstruct.com.au>
CC:     <minyard@acm.org>, <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <aladyshev22@gmail.com>,
        <jk@codeconstruct.com.au>
Subject: Re: [PATCH 03/10] ipmi: kcs_bmc: Make kcs_bmc_update_event_mask()
 static
Message-ID: <20231103144026.00001fbc@Huawei.com>
In-Reply-To: <20231103061522.1268637-4-andrew@codeconstruct.com.au>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
        <20231103061522.1268637-4-andrew@codeconstruct.com.au>
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

On Fri,  3 Nov 2023 16:45:15 +1030
Andrew Jeffery <andrew@codeconstruct.com.au> wrote:

> There were no users outside the subsystem core, so let's not expose it.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Is it worth having the wrapper?

I guess all the other cases do have wrappers (even if that's because
they continue to be exported) so fair enough.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/char/ipmi/kcs_bmc.c        | 11 +++++------
>  drivers/char/ipmi/kcs_bmc_client.h |  2 --
>  2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
> index a429d9f8a7bf..1a827db8a465 100644
> --- a/drivers/char/ipmi/kcs_bmc.c
> +++ b/drivers/char/ipmi/kcs_bmc.c
> @@ -68,6 +68,11 @@ irqreturn_t kcs_bmc_handle_event(struct kcs_bmc_device *kcs_bmc)
>  }
>  EXPORT_SYMBOL(kcs_bmc_handle_event);
>  
> +static void kcs_bmc_update_event_mask(struct kcs_bmc_device *kcs_bmc, u8 mask, u8 events)
> +{
> +	kcs_bmc->ops->irq_mask_update(kcs_bmc, mask, events);
> +}
> +
>  int kcs_bmc_enable_device(struct kcs_bmc_device *kcs_bmc, struct kcs_bmc_client *client)
>  {
>  	int rc;
> @@ -178,12 +183,6 @@ void kcs_bmc_unregister_driver(struct kcs_bmc_driver *drv)
>  }
>  EXPORT_SYMBOL(kcs_bmc_unregister_driver);
>  
> -void kcs_bmc_update_event_mask(struct kcs_bmc_device *kcs_bmc, u8 mask, u8 events)
> -{
> -	kcs_bmc->ops->irq_mask_update(kcs_bmc, mask, events);
> -}
> -EXPORT_SYMBOL(kcs_bmc_update_event_mask);
> -
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Haiyue Wang <haiyue.wang@linux.intel.com>");
>  MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
> diff --git a/drivers/char/ipmi/kcs_bmc_client.h b/drivers/char/ipmi/kcs_bmc_client.h
> index 6fdcde0a7169..814ad8e052ef 100644
> --- a/drivers/char/ipmi/kcs_bmc_client.h
> +++ b/drivers/char/ipmi/kcs_bmc_client.h
> @@ -35,8 +35,6 @@ void kcs_bmc_unregister_driver(struct kcs_bmc_driver *drv);
>  int kcs_bmc_enable_device(struct kcs_bmc_device *kcs_bmc, struct kcs_bmc_client *client);
>  void kcs_bmc_disable_device(struct kcs_bmc_device *kcs_bmc, struct kcs_bmc_client *client);
>  
> -void kcs_bmc_update_event_mask(struct kcs_bmc_device *kcs_bmc, u8 mask, u8 events);
> -
>  u8 kcs_bmc_read_data(struct kcs_bmc_device *kcs_bmc);
>  void kcs_bmc_write_data(struct kcs_bmc_device *kcs_bmc, u8 data);
>  u8 kcs_bmc_read_status(struct kcs_bmc_device *kcs_bmc);

