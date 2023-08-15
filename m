Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6E677CC65
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbjHOMKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbjHOMKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:10:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE042E51;
        Tue, 15 Aug 2023 05:10:19 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3924E6BE;
        Tue, 15 Aug 2023 14:09:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692101345;
        bh=KW0vx009AqO7xSRMMkK4x1+GAudFOgostRFnyNMAqJo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uVe4fAAELF9vwDd8TqfvGsAazt+qzmiZcOwEtfckHzAQghbPHNTvUsCbC/x9cw4gT
         v+I0NyycM/SykUDa/PmQlZEcDYJJkSRGngKxAyb+cYb944vfFTOKj4nESUP/GkTgOo
         D6EEbwLf8XOYwgwA90uRjcvXqtPQYD0LNDDjdvgA=
Message-ID: <7ffd3f08-ffb7-7c79-2cdd-ecbf740d204a@ideasonboard.com>
Date:   Tue, 15 Aug 2023 15:10:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 07/13] media: cadence: csi2rx: Soft reset the streams
 before starting capture
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, nm@ti.com,
        devarsht@ti.com, a-bhatia1@ti.com,
        Martyn Welch <martyn.welch@collabora.com>,
        Julien Massot <julien.massot@collabora.com>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
 <20230811-upstream_csi-v9-7-8943f7a68a81@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230811-upstream_csi-v9-7-8943f7a68a81@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023 13:47, Jai Luthra wrote:
> From: Pratyush Yadav <p.yadav@ti.com>
> 
> This resets the stream state machines and FIFOs, giving them a clean
> slate. On J721E if the streams are not reset before starting the
> capture, the captured frame gets wrapped around vertically on every run
> after the first.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
> Changes from v8:
>      - Simplify reset sequence, minimizing delays
> 
>   drivers/media/platform/cadence/cdns-csi2rx.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index 933edec89520..b57e0c3b1944 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -40,6 +40,7 @@
>   #define CSI2RX_STREAM_BASE(n)		(((n) + 1) * 0x100)
>   
>   #define CSI2RX_STREAM_CTRL_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x000)
> +#define CSI2RX_STREAM_CTRL_SOFT_RST			BIT(4)
>   #define CSI2RX_STREAM_CTRL_START			BIT(0)
>   
>   #define CSI2RX_STREAM_DATA_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x008)
> @@ -134,12 +135,23 @@ struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
>   
>   static void csi2rx_reset(struct csi2rx_priv *csi2rx)
>   {
> +	unsigned int i;
> +
> +	/* Reset module */
>   	writel(CSI2RX_SOFT_RESET_PROTOCOL | CSI2RX_SOFT_RESET_FRONT,
>   	       csi2rx->base + CSI2RX_SOFT_RESET_REG);
> +	/* Reset individual streams. */
> +	for (i = 0; i < csi2rx->max_streams; i++) {
> +		writel(CSI2RX_STREAM_CTRL_SOFT_RST,
> +		       csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
> +	}
>   
> -	udelay(10);
> +	usleep_range(10, 20);
>   
> +	/* Clear resets */
>   	writel(0, csi2rx->base + CSI2RX_SOFT_RESET_REG);
> +	for (i = 0; i < csi2rx->max_streams; i++)
> +		writel(0, csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
>   }
>   
>   static int csi2rx_configure_ext_dphy(struct csi2rx_priv *csi2rx)
> 

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

