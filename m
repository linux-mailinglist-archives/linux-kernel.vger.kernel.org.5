Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766867A9745
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjIURM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjIURM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:12:56 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F8B1737
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 09:57:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5042bfb4fe9so1588624e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695315468; x=1695920268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7aGXpKSZd0nkaqg7goI4xd52TS77NJzRSHYqFQggM8=;
        b=H/Icern+xz7wYmsgOMLuE4DtB7esQ2kWVg5oW6lH0p4VTFBQGT5Z1yO2lH40Osahx/
         EfXc3XZMaHNz5hcMe5yV7+GhxNACCgZAoXkQNplf7FLDSJqzbyXsvEpPF5v8e4Nsd/Qp
         kKI1no9Oom1kXA5vhn5SRYmIwVoaWbCARKjpYFVb7ynK54QM6Lo4ji62MsGuR6v/lDgg
         jG1th5Bm4WXn2ub07W4D9L7HB8mW1vmFcsXxzTD5eZzXkdvKdoFbjGMirEmlwKjX1+YN
         i/aI/0/e7Hov5L7Z7tF5F19+hvwSHiOKEmm0+PnbwSXeRU8S5u8LsL2xeyxNAwG2OXz3
         58Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315468; x=1695920268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7aGXpKSZd0nkaqg7goI4xd52TS77NJzRSHYqFQggM8=;
        b=srASUR8YMHkRYcSs1IUibknV2tVtDN6MLszL29CpKR5tEuTGlvjVVd8x58w4ivgtUz
         AHgHzuRMEaLyHNnT6d/cRcY3xvIc8DmROK6oOPVN1p6+3p6uW1LblJjlcks7IwC5Mgts
         AgG3H0ghVfm0WV6w1OUDTH5Quk2HbERr+XtyH2vzijO4tqKTRuLNvrnqsiaNRnnCPfy/
         4hrOt/LftPU2j+NCY71bo46PM9/oHbr3U8SkmNpPcODCBtMaYCS80njAPyX2iWxOzuBl
         D9EsBDzZyl+qia5S3dgK2DmWcHe+OgthVtzbHgURRn5g3BOGBWTt251xTlSN9eT9DGdZ
         ZiAQ==
X-Gm-Message-State: AOJu0YxVrcF0On7+48m+0uu2uvTEtruFrMPRpkUCYCO8H2p27Rk69PWE
        0ONXKnB/e6LoeoZqPC2y/xbRWMgeEcM6oXgWOVamgQ==
X-Google-Smtp-Source: AGHT+IEUZqEOYV4M6SlzSpxNp5dBDgvjEldvmzJ6hEHHcdY4tYiha+4k/ZKwAc0oUEQlmz9ki3DsiQ==
X-Received: by 2002:a17:906:29a:b0:9ae:522e:8f71 with SMTP id 26-20020a170906029a00b009ae522e8f71mr3578502ejf.7.1695300691322;
        Thu, 21 Sep 2023 05:51:31 -0700 (PDT)
Received: from p14s (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id lz1-20020a170906fb0100b0099b5a71b0bfsm1002039ejb.94.2023.09.21.05.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 05:51:30 -0700 (PDT)
Date:   Thu, 21 Sep 2023 06:51:29 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     andersson@kernel.org, matthias.bgg@gmail.com,
        tinghan.shen@mediatek.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com
Subject: Re: [PATCH] remoteproc: mediatek: Refactor single core check and fix
 retrocompatibility
Message-ID: <ZQw8UdZ9vhsrggky@p14s>
References: <20230919092336.51007-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919092336.51007-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 11:23:36AM +0200, AngeloGioacchino Del Regno wrote:
> In older devicetrees we had the ChromeOS EC in a node called "cros-ec"
> instead of the newer "cros-ec-rpmsg", but this driver is now checking
> only for the latter, breaking compatibility with those.
> 
> Besides, we can check if the SCP is single or dual core by simply
> walking through the children of the main SCP node and checking if
> if there's more than one "mediatek,scp-core" compatible node.
> 
> Fixes: 1fdbf0cdde98 ("remoteproc: mediatek: Probe SCP cluster on multi-core SCP")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/remoteproc/mtk_scp.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>

Applied.

Thanks,
Mathieu

> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index ea227b566c54..a35409eda0cf 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -1144,29 +1144,25 @@ static int scp_add_multi_core(struct platform_device *pdev,
>  	return ret;
>  }
>  
> -static int scp_is_single_core(struct platform_device *pdev)
> +static bool scp_is_single_core(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev_of_node(dev);
>  	struct device_node *child;
> +	int num_cores = 0;
>  
> -	child = of_get_next_available_child(np, NULL);
> -	if (!child)
> -		return dev_err_probe(dev, -ENODEV, "No child node\n");
> +	for_each_child_of_node(np, child)
> +		if (of_device_is_compatible(child, "mediatek,scp-core"))
> +			num_cores++;
>  
> -	of_node_put(child);
> -	return of_node_name_eq(child, "cros-ec-rpmsg");
> +	return num_cores < 2;
>  }
>  
>  static int scp_cluster_init(struct platform_device *pdev, struct mtk_scp_of_cluster *scp_cluster)
>  {
>  	int ret;
>  
> -	ret = scp_is_single_core(pdev);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (ret)
> +	if (scp_is_single_core(pdev))
>  		ret = scp_add_single_core(pdev, scp_cluster);
>  	else
>  		ret = scp_add_multi_core(pdev, scp_cluster);
> -- 
> 2.42.0
> 
