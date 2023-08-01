Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013DF76B6F0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjHAOL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjHAOLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:11:49 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFA61FC6;
        Tue,  1 Aug 2023 07:11:36 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 736573D4;
        Tue,  1 Aug 2023 16:10:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690899032;
        bh=rBE60NhSIBvoTv5ng/HCMVJEVsEqIi4yiM5H2RFTGik=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CjBW4xhM4fLBxbi92WKxrnRrognf0Q0sJa4cFNLODTsVgppzxK92ksOx32HTO2yp6
         MDdq2KcBk/iVwxlkziIPVGwGONVJbr2JqHTqcyE/ykMLv/pOxUlYd4pKU+l/CPmCCz
         gIN9fksoSRMYOuBOFTgQ0ljUmrsPcvsznBSOnxUI=
Message-ID: <75af74a6-0b89-8a8b-d1d4-3ff2090aa530@ideasonboard.com>
Date:   Tue, 1 Aug 2023 17:11:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 06/16] media: cadence: csi2rx: Cleanup media entity
 properly
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
 <20230731-upstream_csi-v8-6-fb7d3661c2c9@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230731-upstream_csi-v8-6-fb7d3661c2c9@ti.com>
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
> Call media_entity_cleanup() in probe error path and remove to make sure
> the media entity is cleaned up properly.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> v7->v8: No change
> 
>   drivers/media/platform/cadence/cdns-csi2rx.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index fd6f2e04e77f..83d1fadd592b 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -547,6 +547,7 @@ static int csi2rx_probe(struct platform_device *pdev)
>   err_cleanup:
>   	v4l2_async_nf_unregister(&csi2rx->notifier);
>   	v4l2_async_nf_cleanup(&csi2rx->notifier);
> +	media_entity_cleanup(&csi2rx->subdev.entity);
>   err_free_priv:
>   	kfree(csi2rx);
>   	return ret;
> @@ -559,6 +560,7 @@ static void csi2rx_remove(struct platform_device *pdev)
>   	v4l2_async_nf_unregister(&csi2rx->notifier);
>   	v4l2_async_nf_cleanup(&csi2rx->notifier);
>   	v4l2_async_unregister_subdev(&csi2rx->subdev);
> +	media_entity_cleanup(&csi2rx->subdev.entity);
>   	kfree(csi2rx);
>   }
>   
> 

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

