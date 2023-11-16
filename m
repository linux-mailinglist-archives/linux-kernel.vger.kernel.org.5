Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633587EE6B7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345425AbjKPS3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKPS3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:29:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980FC195
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:29:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5AAC433C9;
        Thu, 16 Nov 2023 18:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700159369;
        bh=CNm1AYvgH24i5zs7rXuhysROqKGaoDkC4TrTERZzmbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IvrzIWe8wpTFrBo2kBoC3ir+8BuiR3x9ErONqHu5L3iLShOerbPK8QshrBqK5Ukyx
         vlm93+L/ZIV5VqHX/+JyVZ6NgT+Ul9EbjTFFCgfE8BrWZLB1SMpn5ZeBKIpS0PMj65
         rWi02IIdlaW/TmjIVmYD4iGEo3mznyxCPKzqLv3L42Kfl4OgIuDY7pQFcwHLXsjJfo
         MKYDPwYmggEe+xKPCf31d/5+G7y6FnXO3Kz3hKjRYvc5/x4iVlHkwyJK9LOT8iSovv
         busPkZWAl7t/h5t8qbv6eAxw4LJFJ8oI5dobE8RbeZ9+unbs3ONQC9ypaMkESTjXwP
         BOXwyhwWFZUTQ==
Date:   Thu, 16 Nov 2023 18:29:23 +0000
From:   Simon Horman <horms@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Michal Simek <michal.simek@amd.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH] net: can: Use device_get_match_data()
Message-ID: <20231116182923.GH109951@vergenet.net>
References: <20231115210129.3739377-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115210129.3739377-1-robh@kernel.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 03:01:28PM -0600, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

...

> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> index abe58f103043..f17fd43d03c0 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -20,8 +20,8 @@
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/skbuff.h>
>  #include <linux/spinlock.h>
>  #include <linux/string.h>
> @@ -1726,7 +1726,6 @@ static int xcan_probe(struct platform_device *pdev)
>  	struct net_device *ndev;
>  	struct xcan_priv *priv;
>  	struct phy *transceiver;
> -	const struct of_device_id *of_id;
>  	const struct xcan_devtype_data *devtype = &xcan_axi_data;

Hi Rob,

Here devtype is initialised.

>  	void __iomem *addr;
>  	int ret;
> @@ -1741,9 +1740,7 @@ static int xcan_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> -	of_id = of_match_device(xcan_of_match, &pdev->dev);
> -	if (of_id && of_id->data)
> -		devtype = of_id->data;

And in the old code devtype was conditionally re-initialised here,
if a match with data was found.

But in the new code devtype is re-initialised unconditionally.

Possibly I am missing something obvious, but it seems that either this
should somehow be made conditional, or the initialisation to &xcan_axi_data
should be dropped.

> +	devtype = device_get_match_data(&pdev->dev);
>  
>  	hw_tx_max_property = devtype->flags & XCAN_FLAG_TX_MAILBOXES ?
>  			     "tx-mailbox-count" : "tx-fifo-depth";
> -- 
> 2.42.0
> 
