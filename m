Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805237F6825
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 21:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjKWUJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 15:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWUJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 15:09:27 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B2DD41;
        Thu, 23 Nov 2023 12:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=kJeXbrZOUj5rdzQgMSVZ1x5SEGn76ScEL3QEZ1NKcyQ=; b=LBjjJT7IFEDSq0m8h8vvBvJyD0
        nWRfw7B1eziTxK7FD4qioH+tRKnZ0FbjBSIJcz/T1HkID8VqR6rR4zPZUnzqR/XmcdViq97zNcH64
        atippMG8swE/5F/CnxUiG4S5UWT3D0dot5dRY6OHWOaw4XRkrkeFX9luXSTR1/Fwez1U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r6G0r-0011wP-Ri; Thu, 23 Nov 2023 21:09:25 +0100
Date:   Thu, 23 Nov 2023 21:09:25 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Heiko Schocher <heiko.schocher@gmail.com>
Cc:     netdev@vger.kernel.org, Heiko Schocher <hs@denx.de>,
        Clark Wang <xiaoning.wang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: fec: fix probing of fec1 when fec0 is not probed yet
Message-ID: <132aca53-6570-41a4-b2b2-0907d74f9b31@lunn.ch>
References: <20231123132744.62519-1-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123132744.62519-1-hs@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 02:27:43PM +0100, Heiko Schocher wrote:
> it is possible that fec1 is probed before fec0. On SoCs
> with FEC_QUIRK_SINGLE_MDIO set (which means fec1 uses mii
> from fec0) init of mii fails for fec1 when fec0 is not yet
> probed, as fec0 setups mii bus. In this case fec_enet_mii_init
> for fec1 returns with -ENODEV, and so fec1 never comes up.
> 
> Return here with -EPROBE_DEFER so interface gets later
> probed again.
> 
> Found this on imx8qxp based board, using 2 ethernet interfaces,
> and from time to time, fec1 interface came not up.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> 
>  drivers/net/ethernet/freescale/fec_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index c3b7694a7485..d956f95e7a65 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -2445,7 +2445,7 @@ static int fec_enet_mii_init(struct platform_device *pdev)
>  			mii_cnt++;
>  			return 0;
>  		}
> -		return -ENOENT;
> +		return -EPROBE_DEFER;

I think this has been tried before.

Are there any issues with the mii_cnt++; I thought the previous
attempt as this had problems with the wrong mdio bus being assigned to
fep->mii_bus ? But i could be remembering wrongly.

	Andrew
