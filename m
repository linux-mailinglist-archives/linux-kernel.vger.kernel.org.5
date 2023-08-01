Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEB976B6E4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjHAOLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjHAOLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:11:15 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35221B7;
        Tue,  1 Aug 2023 07:11:13 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ADEC93D4;
        Tue,  1 Aug 2023 16:10:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690899009;
        bh=N7PpNEg1z3VbAPOM3ThI7rYhCHNOb2LDfb+3MxgePyc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lxBIyPp4JjdrgIfBC02WdMrYg8FUeQ4dIfybGMRkpoSqvqqu9+VMGHPUTJiu/E2kH
         /zWqVKv4+DZSC107wWZyJaR4eubaRhfvGIawV03ktZZB2XN1d2x5DzQjwm3NyQzJdJ
         ZFz2JARtQTzM4gFrBhsARqzzQNMmHjOpu1bsBiM0=
Message-ID: <68ad27c8-859e-bb3f-7879-26cf5f1fcfbc@ideasonboard.com>
Date:   Tue, 1 Aug 2023 17:11:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 05/16] media: cadence: csi2rx: Unregister v4l2 async
 notifier
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, nm@ti.com,
        devarsht@ti.com
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
 <20230731-upstream_csi-v8-5-fb7d3661c2c9@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230731-upstream_csi-v8-5-fb7d3661c2c9@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 11:29, Jai Luthra wrote:
> From: Pratyush Yadav <p.yadav@ti.com>
> 
> The notifier is added to the global notifier list when registered. When
> the module is removed, the struct csi2rx_priv in which the notifier is
> embedded, is destroyed. As a result the notifier list has a reference to
> a notifier that no longer exists. This causes invalid memory accesses
> when the list is iterated over. Similar for when the probe fails.
> Unregister and clean up the notifier to avoid this.
> 
> Fixes: 1fc3b37f34f6 ("media: v4l: cadence: Add Cadence MIPI-CSI2 RX driver")
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> v7->v8: No change
> 
>   drivers/media/platform/cadence/cdns-csi2rx.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index b087583d636f..fd6f2e04e77f 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -479,8 +479,10 @@ static int csi2rx_parse_dt(struct csi2rx_priv *csi2rx)
>   	asd = v4l2_async_nf_add_fwnode_remote(&csi2rx->notifier, fwh,
>   					      struct v4l2_async_connection);
>   	of_node_put(ep);
> -	if (IS_ERR(asd))
> +	if (IS_ERR(asd)) {
> +		v4l2_async_nf_cleanup(&csi2rx->notifier);
>   		return PTR_ERR(asd);
> +	}
>   
>   	csi2rx->notifier.ops = &csi2rx_notifier_ops;
>   
> @@ -543,6 +545,7 @@ static int csi2rx_probe(struct platform_device *pdev)
>   	return 0;
>   
>   err_cleanup:
> +	v4l2_async_nf_unregister(&csi2rx->notifier);
>   	v4l2_async_nf_cleanup(&csi2rx->notifier);
>   err_free_priv:
>   	kfree(csi2rx);
> @@ -553,6 +556,8 @@ static void csi2rx_remove(struct platform_device *pdev)
>   {
>   	struct csi2rx_priv *csi2rx = platform_get_drvdata(pdev);
>   
> +	v4l2_async_nf_unregister(&csi2rx->notifier);
> +	v4l2_async_nf_cleanup(&csi2rx->notifier);
>   	v4l2_async_unregister_subdev(&csi2rx->subdev);
>   	kfree(csi2rx);
>   }
> 

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

