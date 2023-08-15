Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B98177C94D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbjHOIXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbjHOIWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:22:44 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B45E72;
        Tue, 15 Aug 2023 01:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1692087750; bh=xFG0LuSuyyBd/txT437fSz8YcSut8rzd7XuMZ0HxkUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RNf/57WXamtc2hmXn7qAmcM6m35dKfeIJOrEKFHx/Mtwj52EsWCGkzk7yOZIVt5tR
         7QT0WHO81QY9uT9R2De8hfwV4MIfWrfZlDj7pT0s9lObl1VVQFxMDj7q85cETOWpS2
         Pbr84xbZBt/thORyXGedc0VWATrTkVBQO9aOmYEk=
Date:   Tue, 15 Aug 2023 10:22:29 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jiansheng Wu <jiansheng.wu@unisoc.com>
Cc:     Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yongzhi.chen@unisoc.com, xiaoqing.wu@unisoc.com,
        jianshengwu16@gmail.com
Subject: Re: [PATCH 1/8] Spi: sprd-adi: Getting panic reason before reboot
Message-ID: <1a4d84de-af16-4f83-8a7d-4bde2b1ca766@t-8ch.de>
References: <20230815023426.15076-1-jiansheng.wu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815023426.15076-1-jiansheng.wu@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-15 10:34:19+0800, Jiansheng Wu wrote:
> Registered adi_panic_event to panic_notifier_list, that is used to
> get panic reason and judge restart causes before system reboot.
> It's can improve reboot reasons from panic.
> 
> Signed-off-by: Jiansheng Wu <jiansheng.wu@unisoc.com>
> ---
>  drivers/spi/spi-sprd-adi.c | 46 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
> index 22e39c4c12c4..dd00d63a3cd0 100644
> --- a/drivers/spi/spi-sprd-adi.c
> +++ b/drivers/spi/spi-sprd-adi.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/panic_notifier.h>
>  #include <linux/platform_device.h>
>  #include <linux/reboot.h>
>  #include <linux/spi/spi.h>
> @@ -128,6 +129,8 @@
>  #define WDG_LOAD_MASK			GENMASK(15, 0)
>  #define WDG_UNLOCK_KEY			0xe551
>  
> +#define PANIC_REASON_LEN_MAX		20
> +
>  struct sprd_adi_wdg {
>  	u32 base;
>  	u32 rst_sts;
> @@ -155,6 +158,31 @@ struct sprd_adi {
>  	const struct sprd_adi_data *data;
>  };
>  
> +static char *panic_reason;
> +static int adi_panic_event(struct notifier_block *self, unsigned long val, void *reason)
> +{
> +	if (reason == NULL)
> +		return 0;
> +
> +	if (strlen(reason) < PANIC_REASON_LEN_MAX)
> +		memcpy(panic_reason, reason, strlen(reason));
> +	else
> +		memcpy(panic_reason, reason, PANIC_REASON_LEN_MAX);

This will truncate the trailing '\0'.
The string logic below will be invalid on a non-null-terminated byte
array.
strscpy() would avoid the issue.

> +
> +	return 0;
> +}
> +
> +static struct notifier_block adi_panic_event_nb = {
> +	.notifier_call  = adi_panic_event,
> +	.priority       = INT_MAX,
> +};
> +
> +static int adi_get_panic_reason_init(void)
> +{
> +	atomic_notifier_chain_register(&panic_notifier_list, &adi_panic_event_nb);
> +	return 0;
> +}
> +
>  static int sprd_adi_check_addr(struct sprd_adi *sadi, u32 reg)
>  {
>  	if (reg >= sadi->data->slave_addr_size) {
> @@ -378,9 +406,15 @@ static int sprd_adi_restart(struct notifier_block *this, unsigned long mode,
>  					     restart_handler);
>  	u32 val, reboot_mode = 0;
>  
> -	if (!cmd)
> -		reboot_mode = HWRST_STATUS_NORMAL;
> -	else if (!strncmp(cmd, "recovery", 8))
> +	if (!cmd) {
> +		if (strlen(panic_reason)) {
> +			reboot_mode = HWRST_STATUS_PANIC;
> +			if (strstr(panic_reason, "tospanic"))
> +				reboot_mode = HWRST_STATUS_SECURITY;
> +		} else {
> +			reboot_mode = HWRST_STATUS_NORMAL;
> +		}
> +	} else if (!strncmp(cmd, "recovery", 8))
>  		reboot_mode = HWRST_STATUS_RECOVERY;
>  	else if (!strncmp(cmd, "alarm", 5))
>  		reboot_mode = HWRST_STATUS_ALARM;
> @@ -520,6 +554,10 @@ static int sprd_adi_probe(struct platform_device *pdev)
>  	u16 num_chipselect;
>  	int ret;
>  
> +	panic_reason = devm_kzalloc(&pdev->dev, (sizeof(char))*PANIC_REASON_LEN_MAX, GFP_KERNEL);

sizeof(char) is guaranteed to be 1 by the C standard.

It seems weird to devm_alloc() something that will be stored in a static
buffer. If multiple devices are bound to the driver the results will be
weird.
Also if the device is unbound the notifier won't be unregistered and
panic_mode will point to freed memory.

> +	if (!panic_reason)
> +		return -ENOMEM;
> +
>  	if (!np) {
>  		dev_err(&pdev->dev, "can not find the adi bus node\n");
>  		return -ENODEV;
> @@ -573,7 +611,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
>  	}
>  
>  	sprd_adi_hw_init(sadi);
> -
> +	adi_get_panic_reason_init();

Why drop the empty line?

>  	if (sadi->data->wdg_rst)
>  		sadi->data->wdg_rst(sadi);
>  
> -- 
> 2.17.1
> 
