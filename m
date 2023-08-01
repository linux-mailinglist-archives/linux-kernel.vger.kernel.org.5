Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EA176BF6D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjHAVnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjHAVnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:43:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67EE1FDA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:43:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7442E6162C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 21:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3E8C433C8;
        Tue,  1 Aug 2023 21:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690926228;
        bh=usnEviioqoCVwGAiv0lnOrnKLUhwR79yOmsKkexjDRA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tLYQ1R+pmQrIUdQF6GQH/IE5f5FfTkkHu5OjhS6irYTgXtcK0Iva3tfsnZmdDUY63
         kuKFqF+gpJZd55k3V3n3xMSiJSnI9sa0y6o81qt7J0d8piyOhAq5Layeclr1clUaPV
         E2xUfDTQ/PgsI6s3yfF8fosGllXXvcRLNwrqdnWbSVuwZilfr9C1loDgIYtL633Yca
         UsdbDOWau8Bs0xLh/VTF2Z6GKC9iZJIRZCmw9G8Hm0/yF1m1ODHm/nlBX52j9PNX/N
         dF+0iQsfLTLeu0Kw6Zu3MX40bWTC2Yz0ORKhQ1jnoNevHFBemlHhh2r+wIKL1/7dA+
         uyMMu5QtSYYKw==
Date:   Tue, 1 Aug 2023 14:43:47 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Ruan Jinjie <ruanjinjie@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] net: hisilicon: fix the return value handle and
 remove redundant netdev_err() for platform_get_irq()
Message-ID: <20230801144347.140cc06f@kernel.org>
In-Reply-To: <20230731073858.3633193-1-ruanjinjie@huawei.com>
References: <20230731073858.3633193-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 15:38:58 +0800 Ruan Jinjie wrote:
> There is no possible for platform_get_irq() to return 0
> and the return value of platform_get_irq() is more sensible
> to show the error reason.
> 
> And there is no need to call the netdev_err() function directly to print
> a custom message when handling an error from platform_get_irq() function as
> it is going to display an appropriate error message in case of a failure.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Dan, with the sample of one patch from you I just applied I induce 
that treating 0 as error and returning a -EINVAL in that case may 
be preferable here?

> diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
> index 50c3f5d6611f..ecf92a5d56bb 100644
> --- a/drivers/net/ethernet/hisilicon/hip04_eth.c
> +++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
> @@ -960,8 +960,8 @@ static int hip04_mac_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		ret = -EINVAL;
> +	if (irq < 0) {
> +		ret = irq;
>  		goto init_fail;
>  	}
>  
> diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
> index ce2571c16e43..cb7b0293fe85 100644
> --- a/drivers/net/ethernet/hisilicon/hisi_femac.c
> +++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
> @@ -862,8 +862,8 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
>  		goto out_disconnect_phy;
>  
>  	ndev->irq = platform_get_irq(pdev, 0);
> -	if (ndev->irq <= 0) {
> -		ret = -ENODEV;
> +	if (ndev->irq < 0) {
> +		ret = ndev->irq;
>  		goto out_disconnect_phy;
>  	}
>  
> diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
> index f867e9531117..26d22bb04b87 100644
> --- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
> +++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
> @@ -1206,9 +1206,8 @@ static int hix5hd2_dev_probe(struct platform_device *pdev)
>  	}
>  
>  	ndev->irq = platform_get_irq(pdev, 0);
> -	if (ndev->irq <= 0) {
> -		netdev_err(ndev, "No irq resource\n");
> -		ret = -EINVAL;
> +	if (ndev->irq < 0) {
> +		ret = ndev->irq;
>  		goto out_phy_node;
>  	}
>  

