Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E6980F4FB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377026AbjLLRxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjLLRxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:53:15 -0500
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26260AB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:53:17 -0800 (PST)
Received: from [192.168.1.18] ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id D6wUrQiNALMHAD6wUrlYvP; Tue, 12 Dec 2023 18:53:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1702403595;
        bh=L/MbAWs2OZrOLC1rYEO04nGayLDbwyeb69eSCqKczhU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CaefnQSg6liXBIn+KC3ED6T/XyzXpAePPtyDK6t5uD2Qc3r89YqDv4DkKRbvCl3MQ
         bEQhMKeLxr0vQoFwbaVJ9Pqe1iH4kjC8VJViLG1iI50rs8O3+XqPG5p/szOtLmSVTg
         jANYxiamUO3YKTLDD/3rlm01zE/hTmHg8FKXByaiqDWFy5nDLjbaO/mHh4qvrUdqrb
         ZfRqXJVKzxUfBCelUHiQ5C9IPotseImhXuzte/RmfHW/IcnWg0lJK7omwCRquKQ6aF
         yLQcv7C+25Hfq/ft7LnPiyjthbIFsI8+3Z4D7XoAvZqgNYW1EntCN6U+Tc8qqvEAJY
         R6+YK17E5J+9Q==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 12 Dec 2023 18:53:15 +0100
X-ME-IP: 92.140.202.140
Message-ID: <94c5f197-9459-40fe-9c34-06359779a51a@wanadoo.fr>
Date:   Tue, 12 Dec 2023 18:53:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cdx: Unlock on error path in rescan_store()
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc:     Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <8c79956b-bf8c-4511-97cc-a16833a0630f@moroto.mountain>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <8c79956b-bf8c-4511-97cc-a16833a0630f@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/12/2023 à 10:20, Dan Carpenter a écrit :
> We added locking to this function but these two error paths were
> accidentally overlooked.
> 
> Fixes: f0af81683466 ("cdx: Introduce lock to protect controller ops")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/cdx/cdx.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index d84d153078d7..f4f9f0c88c09 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -572,12 +572,16 @@ static ssize_t rescan_store(const struct bus_type *bus,
>   
>   	/* Rescan all the devices */
>   	for_each_compatible_node(np, NULL, compat_node_name) {
> -		if (!np)
> -			return -EINVAL;
> +		if (!np) {
> +			count = -EINVAL;
> +			goto unlock;
> +		}
>   
>   		pd = of_find_device_by_node(np);
> -		if (!pd)
> -			return -EINVAL;
> +		if (!pd) {
> +			count = -EINVAL;
> +			goto unlock;

Unrelated to your patch, but should we have a of_node_put(np); here, on 
early exit?

CJ

> +		}
>   
>   		cdx = platform_get_drvdata(pd);
>   		if (cdx && cdx->controller_registered && cdx->ops->scan)
> @@ -585,7 +589,7 @@ static ssize_t rescan_store(const struct bus_type *bus,
>   
>   		put_device(&pd->dev);
>   	}
> -
> +unlock:
>   	mutex_unlock(&cdx_controller_lock);
>   
>   	return count;

