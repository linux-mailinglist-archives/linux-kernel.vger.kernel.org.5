Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909927AA075
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjIUUiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjIUUhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:37:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C9085D0A;
        Thu, 21 Sep 2023 10:37:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76E7C4AF7F;
        Thu, 21 Sep 2023 12:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695297950;
        bh=MIAPvm2D9dsEYNFzb9MK6Q/J1mLxxDhkVeMPqNpuQBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ok/dWXRP9v159kkOVgc53JH6vyyUhzV3W+r6S3w/1w8QLcDNkW69KJVswMQB/M9oE
         wh+RcUcW32Sjce2VvVCNyDevZ8UCjUnSGDg8VnAKjh3SiqW+neZyGIO/Z7KKysMG8m
         ecvUHb/QqzURDC0OWJzkM10DSFGcx0Gvn7g6TCb0WuTRpGsq/w8op3H2dmZgyOOsMI
         9Y0l12npuO7ZDU0WjCzWpGnR78dPlE3Bo9CwHA/wi7HyI/eTkFkAO+S/PDWNUvHN4J
         h0uVDnj8m0TxnI6LDE+kTDdvNhNIfRtP1uFtSe8k95zKF6Blh3g0cMVTLOjUfCVbmp
         LnqNneqNG4epA==
Date:   Thu, 21 Sep 2023 13:05:46 +0100
From:   Lee Jones <lee@kernel.org>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] leds: sc27xx: Add a missing mutex_destory()
Message-ID: <20230921120546.GI3449785@google.com>
References: <20230921024314.615370-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230921024314.615370-1-chunyan.zhang@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023, Chunyan Zhang wrote:

> In sc27xx_led_probe() there's one error branch missing mutex_destory()
> after mutex_init(), it seems that we should add it since other branches
> which follow it called mutex_destoy() before return failure.

Wouldn't it be better to move the mutex_init() to the end of .probe()?

> Fixes: e081c49e30ec ("leds: Add Spreadtrum SC27xx breathing light controller driver")
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  drivers/leds/leds-sc27xx-bltc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
> index e199ea15e406..122094bbf444 100644
> --- a/drivers/leds/leds-sc27xx-bltc.c
> +++ b/drivers/leds/leds-sc27xx-bltc.c
> @@ -300,6 +300,7 @@ static int sc27xx_led_probe(struct platform_device *pdev)
>  	priv->base = base;
>  	priv->regmap = dev_get_regmap(dev->parent, NULL);
>  	if (!priv->regmap) {
> +		mutex_destroy(&priv->lock);
>  		err = -ENODEV;
>  		dev_err(dev, "failed to get regmap: %d\n", err);
>  		return err;
> -- 
> 2.41.0
> 

-- 
Lee Jones [李琼斯]
