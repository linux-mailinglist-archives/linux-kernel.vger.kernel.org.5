Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD6776B70B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjHAOQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbjHAOQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:16:51 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892571FD6;
        Tue,  1 Aug 2023 07:16:47 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9F32C3D4;
        Tue,  1 Aug 2023 16:15:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690899342;
        bh=7hUsf95gjIxSgtRLwzBmFiKLVXrp6wnnd+YHBgxwLsU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tWj9MkqJYDgVZYzuwBuai/Kyo+OStWB4NkNQrfAMvVQf6WdOvXogXmS3BadFebzZ+
         Gg+CmBUANpHIHphxjLKFJjn0zoyYnMBTHxSU7B11jug//Zc6wUltq0NtlXYMBy+W3w
         9Bx+O75sE/yUEpBzvzMorVJImidszIyo7p2UuC4M=
Message-ID: <d84852d8-1ade-94fc-bbc2-c3a4d30fdbe1@ideasonboard.com>
Date:   Tue, 1 Aug 2023 17:16:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 09/16] media: cadence: csi2rx: Soft reset the streams
 before starting capture
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
 <20230731-upstream_csi-v8-9-fb7d3661c2c9@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230731-upstream_csi-v8-9-fb7d3661c2c9@ti.com>
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
> This resets the stream state machines and FIFOs, giving them a clean
> slate. On J721E if the streams are not reset before starting the
> capture, the captured frame gets wrapped around vertically on every run
> after the first.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> v7->v8: No change
> 
>   drivers/media/platform/cadence/cdns-csi2rx.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index 2a80c66fb547..30cdc260b46a 100644
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
> @@ -138,12 +139,22 @@ struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
>   
>   static void csi2rx_reset(struct csi2rx_priv *csi2rx)
>   {
> +	unsigned int i;
> +
>   	writel(CSI2RX_SOFT_RESET_PROTOCOL | CSI2RX_SOFT_RESET_FRONT,
>   	       csi2rx->base + CSI2RX_SOFT_RESET_REG);
>   
>   	udelay(10);
>   
>   	writel(0, csi2rx->base + CSI2RX_SOFT_RESET_REG);
> +
> +	/* Reset individual streams. */
> +	for (i = 0; i < csi2rx->max_streams; i++) {
> +		writel(CSI2RX_STREAM_CTRL_SOFT_RST,
> +		       csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
> +		usleep_range(10, 20);
> +		writel(0, csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
> +	}

Do you have to do it like this? Or would it be fine to set the reset bit 
for all stream regs, then sleep, then clear the reset bit from all 
stream regs? Or going even further, can you set the 
CSI2RX_SOFT_RESET_REG and all CSI2RX_STREAM_CTRL_REG regs, then sleep, 
and then clear them all?

  Tomi

