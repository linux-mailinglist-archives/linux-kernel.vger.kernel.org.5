Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE6F7F9CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjK0JiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjK0JiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:38:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F11F111
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:38:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296E3C433C7;
        Mon, 27 Nov 2023 09:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701077886;
        bh=BN2LicB5jxds9fx+ZEYukWJ29CfaB31EBJL8lQdSPpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QUwcmB/lgL3jexVnTCttyrHGUr+uCTFiZEZ8hgmdHk2vw9TJmIuIOfHtXWmJ3kQj2
         UiSprLMu3oYSCNX9cGfhg53z0BYsdAeosAir6hK4zobLLKVrvOhLBueWWY+ji1oZTz
         wrhUZ1tJ4bf8yS/FPSyOp2kLIWgUdWnVbQ3AUiE573G5jCc1y/2qgQbjMg7IIr7jS6
         MiLNKThT9h1shVCbDuR47x5Y8Hc2i0We224TqtH2PxEpOZgprzYonlUePKDrdHdDqg
         UU73HOpbe5swirTJMn4vf1ae6FJJY09RRNNBLsfJnwgJCh38eX9/M3t+hwlwMnYw0D
         qHXYyNHjRPajg==
Date:   Mon, 27 Nov 2023 09:37:59 +0000
From:   Simon Horman <horms@kernel.org>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        robert.marko@sartura.hr, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH 2/9] net: mdio: ipq4019: Enable the clocks for ipq5332
 platform
Message-ID: <20231127093759.GD84723@kernel.org>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-3-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115032515.4249-3-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 11:25:08AM +0800, Luo Jie wrote:
> For the platform ipq5332, the related GCC clocks need to be enabled
> to make the GPIO reset of the MDIO slave devices taking effect.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  drivers/net/mdio/mdio-ipq4019.c | 67 +++++++++++++++++++++++++++++----
>  1 file changed, 60 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
> index 9d444f5f7efb..a77982a1a1e1 100644
> --- a/drivers/net/mdio/mdio-ipq4019.c
> +++ b/drivers/net/mdio/mdio-ipq4019.c

...

> +const char *const mdio_clk_name[] = {
> +	"gcc_mdio_ahb_clk",
> +	"gcc_uniphy0_ahb_clk",
> +	"gcc_uniphy0_sys_clk",
> +	"gcc_uniphy1_ahb_clk",
> +	"gcc_uniphy1_sys_clk"
>  };

Hi Luo Jie,

A minor nit from my side: It appears that mdio_clk_name is only
used in this file. If so it should be declared as static.

...
