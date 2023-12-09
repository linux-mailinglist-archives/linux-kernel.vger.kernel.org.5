Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F71380B668
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 21:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjLIU5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 15:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLIU5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 15:57:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFEBF2
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 12:57:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629D2C433C8;
        Sat,  9 Dec 2023 20:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702155474;
        bh=1ANiy4o/4nNuzVxHGjqWFyAyf+pmY1TAke9fR4OAnbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o1ETswpV9364kjAIy+7PkKaYPhnGJc/K8Im8N9JzOErhiWoyC9RMzC8sbv//Ijm0i
         vpYf23g/mmpAjc2uoZzO1TC+CT8TEviz3UIO1uLgi97nF2nPw0WwtWmEwz/v1C9qzz
         XS8Es5d2FxPneHhElU6Ldq6mtmn6Dy/rfyoeNRCm8ilKnwQnKSe1SI2Q2r6AZTDlg0
         7Akm+i+LnAUSxwir0NW6MS36Gf25fLUi79Z7TvAUcNkb1LPgyPNSNrWSHCTxeI6NfL
         jc/bWjw1jOdZ3rAd1bMON2N32Q19Mx8FjovrdTpZ9d2rxBR4fhAvJty3xLcLNONOqQ
         szl34ynhQz9kA==
Date:   Sat, 9 Dec 2023 21:57:44 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Cc:     Michal Simek <michal.simek@amd.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: cadence: Add system suspend and resume PM support
Message-ID: <20231209205744.ehmthjvn7nuslvhd@zenone.zhora.eu>
References: <20231209131516.1916550-1-jisheng.teoh@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209131516.1916550-1-jisheng.teoh@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ji Sheng,

On Sat, Dec 09, 2023 at 09:15:16PM +0800, Ji Sheng Teoh wrote:
> Enable device system suspend and resume PM support, and mark the device
> state as suspended during system suspend to reject any data transfer.
> 
> Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> ---
> Changes since v1:
> - Add missing err assignment in cdns_i2c_resume().

thanks for the quick version update. However, while it's nice to
see such prompt proactivity, we also need to allow more time for
others to review your change.

Next time, please give it a bit more time before sending out
version 2. :-)

> ---
>  drivers/i2c/busses/i2c-cadence.c | 33 ++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
> index de3f58b60dce..4bb7d6756947 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -1176,6 +1176,18 @@ static int __maybe_unused cdns_i2c_runtime_suspend(struct device *dev)
>  	return 0;
>  }
>  
> +static int __maybe_unused cdns_i2c_suspend(struct device *dev)
> +{
> +	struct cdns_i2c *xi2c = dev_get_drvdata(dev);
> +
> +	i2c_mark_adapter_suspended(&xi2c->adap);
> +
> +	if (!pm_runtime_status_suspended(dev))
> +		return cdns_i2c_runtime_suspend(dev);
> +
> +	return 0;
> +}
> +
>  /**
>   * cdns_i2c_init -  Controller initialisation
>   * @id:		Device private data structure
> @@ -1219,7 +1231,28 @@ static int __maybe_unused cdns_i2c_runtime_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static int __maybe_unused cdns_i2c_resume(struct device *dev)
> +{

I am not really understanding what you are trying to do here:

> +	struct cdns_i2c *xi2c = dev_get_drvdata(dev);
> +	int err;
> +
> +	err = cdns_i2c_runtime_resume(dev);

First you try to resume...

> +	if (err)
> +		return err;
> +
> +	if (pm_runtime_status_suspended(dev)) {

... then you check if you are suspended ...

> +		err = cdns_i2c_runtime_suspend(dev);

... and suspend again? Shouldn't this be _resume()?

Thanks,
Andi

> +		if (err)
> +			return err;
> +	}
> +
> +	i2c_mark_adapter_resumed(&xi2c->adap);
> +
> +	return 0;
> +}
> +
>  static const struct dev_pm_ops cdns_i2c_dev_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_i2c_suspend, cdns_i2c_resume)
>  	SET_RUNTIME_PM_OPS(cdns_i2c_runtime_suspend,
>  			   cdns_i2c_runtime_resume, NULL)
>  };
> -- 
> 2.25.1
> 
