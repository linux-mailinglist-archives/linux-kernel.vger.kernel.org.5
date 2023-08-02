Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECDC76C9C4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjHBJqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbjHBJqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:46:06 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEE83588;
        Wed,  2 Aug 2023 02:45:49 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DA37E2AC;
        Wed,  2 Aug 2023 11:44:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690969484;
        bh=hpdQwDntMS3ZczEDj3Ds4dIPnk6jPs7zRr0cSqpxQpc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rq3uYKT5DkF+t6nHyiZDE71V0Bw4C84ADxoHzf33uG/dCbjNQNk6OfLouhn8o9HEC
         RmLOWfOFaEX7aPjtt5MxeFtFkA9i/sUg2U1PoAg0k7HbbhIXPgXrA6yXIN/2cAj15E
         w38drn5bGyZiiPhX4tqTS3z08/qlP2Gv83RW3vS8=
Message-ID: <f782d747-f0c8-ed95-ed61-26f1557ca046@ideasonboard.com>
Date:   Wed, 2 Aug 2023 12:45:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 10/16] media: cadence: csi2rx: Set the STOP bit when
 stopping a stream
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
 <20230731-upstream_csi-v8-10-fb7d3661c2c9@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230731-upstream_csi-v8-10-fb7d3661c2c9@ti.com>
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
> The stream stop procedure says that the STOP bit should be set when the
> stream is to be stopped, and then the ready bit in stream status
> register polled to make sure the STOP operation is finished.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> v7->v8:
> - Fix bug where intention was to wait till stream status is idle, i.e.
>    STREAM_STATUS[31] -> 0 - but we were instead checking the opposite
> 
>   drivers/media/platform/cadence/cdns-csi2rx.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index 30cdc260b46a..a17ef88dff82 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -8,6 +8,7 @@
>   #include <linux/clk.h>
>   #include <linux/delay.h>
>   #include <linux/io.h>
> +#include <linux/iopoll.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_graph.h>
> @@ -41,8 +42,12 @@
>   
>   #define CSI2RX_STREAM_CTRL_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x000)
>   #define CSI2RX_STREAM_CTRL_SOFT_RST			BIT(4)
> +#define CSI2RX_STREAM_CTRL_STOP				BIT(1)
>   #define CSI2RX_STREAM_CTRL_START			BIT(0)
>   
> +#define CSI2RX_STREAM_STATUS_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x004)
> +#define CSI2RX_STREAM_STATUS_RDY			BIT(31)
> +
>   #define CSI2RX_STREAM_DATA_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x008)
>   #define CSI2RX_STREAM_DATA_CFG_EN_VC_SELECT		BIT(31)
>   #define CSI2RX_STREAM_DATA_CFG_VC_SELECT(n)		BIT((n) + 16)
> @@ -314,13 +319,24 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
>   static void csi2rx_stop(struct csi2rx_priv *csi2rx)
>   {
>   	unsigned int i;
> +	u32 val;
> +	int ret;
>   
>   	clk_prepare_enable(csi2rx->p_clk);
>   	reset_control_assert(csi2rx->sys_rst);
>   	clk_disable_unprepare(csi2rx->sys_clk);
>   
>   	for (i = 0; i < csi2rx->max_streams; i++) {
> -		writel(0, csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
> +		writel(CSI2RX_STREAM_CTRL_STOP,
> +		       csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
> +
> +		ret = readl_relaxed_poll_timeout(csi2rx->base +
> +						 CSI2RX_STREAM_STATUS_REG(i),
> +						 val,
> +						 !(val & CSI2RX_STREAM_STATUS_RDY),
> +						 10, 10000);
> +		if (ret)
> +			dev_warn(csi2rx->dev, "Failed to stop stream%u\n", i);

When adding streams support, I think the driver might need some 
adjustments. E.g. above says that e.g. stopping stream2 failed, which 
will be quite confusing as the reader probably thinks it refers to the 
"logical" streams. It would be helpful if it was always clear which of 
the streams the driver refers to (in prints, but also in code).

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

