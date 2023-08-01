Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FB476B710
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbjHAOR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjHAORX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:17:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C10BF;
        Tue,  1 Aug 2023 07:17:22 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 370C63D4;
        Tue,  1 Aug 2023 16:16:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690899378;
        bh=PW3ghibNBXTd6EXpRXCpq11Kf2aUAXCBKDNCa3a/LVQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bfAKJQwzWwcBdjtMl3e/kzF8yk3E+Dok316L5RTBHt7p4wohHcvU5xyNsNrlRfEy6
         Qy5wshJQ6vq8vlpURlDF8OIunTFFfcQDi5xlso/sxpq/bzvAncm9aFwk3uJQlIbclL
         9G4vKOsxkprz+wPHhm9Rm/zqQoXDKetZLAyJFCH4=
Message-ID: <68c3c37c-f324-0879-9d70-4df93a445614@ideasonboard.com>
Date:   Tue, 1 Aug 2023 17:17:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 11/16] media: cadence: csi2rx: Fix stream data
 configuration
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
 <20230731-upstream_csi-v8-11-fb7d3661c2c9@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230731-upstream_csi-v8-11-fb7d3661c2c9@ti.com>
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
> Firstly, there is no VC_EN bit present in the STREAM_DATA_CFG register.
> Bit 31 is part of the VL_SELECT field. Remove it completely.
> 
> Secondly, it makes little sense to enable ith virtual channel for ith
> stream. Sure, there might be a use-case that demands it. But there might
> also be a use case that demands all streams to use the 0th virtual
> channel. Prefer this case over the former because it is less arbitrary
> and also makes it very clear what the limitations of the current driver
> is instead of giving a false impression that multiple virtual channels
> are supported.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> v7->v8: No change
> 
>   drivers/media/platform/cadence/cdns-csi2rx.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index a17ef88dff82..cde7fd6463e1 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -49,7 +49,6 @@
>   #define CSI2RX_STREAM_STATUS_RDY			BIT(31)
>   
>   #define CSI2RX_STREAM_DATA_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x008)
> -#define CSI2RX_STREAM_DATA_CFG_EN_VC_SELECT		BIT(31)
>   #define CSI2RX_STREAM_DATA_CFG_VC_SELECT(n)		BIT((n) + 16)
>   
>   #define CSI2RX_STREAM_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x00c)
> @@ -275,8 +274,11 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
>   		writel(CSI2RX_STREAM_CFG_FIFO_MODE_LARGE_BUF,
>   		       csi2rx->base + CSI2RX_STREAM_CFG_REG(i));
>   
> -		writel(CSI2RX_STREAM_DATA_CFG_EN_VC_SELECT |
> -		       CSI2RX_STREAM_DATA_CFG_VC_SELECT(i),
> +		/*
> +		 * Enable one virtual channel. When multiple virtual channels
> +		 * are supported this will have to be changed.
> +		 */
> +		writel(CSI2RX_STREAM_DATA_CFG_VC_SELECT(0),
>   		       csi2rx->base + CSI2RX_STREAM_DATA_CFG_REG(i));
>   
>   		writel(CSI2RX_STREAM_CTRL_START,
> 

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

