Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8386781F8A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 21:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjHTTcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 15:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjHTTcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 15:32:36 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4195172C;
        Sun, 20 Aug 2023 12:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Wh8avz/7K6bn0D0zVtQFXw0sAZfG126ls7Hida4UZLI=; b=nlQquKpF3yIWBRgr1Z4AnG5zP4
        aArpXuS4cb7j7EH33gEQrChMNyoAPleexNbPyLzwE7FrFiLaHsxo3dzK/PnRPIulLJ+RswsOHAdAv
        DnJGu1IN3a8rGNy3AMDwn+YVHHqsD4XMWNokVjQ/NntyHeYy7zIF8jCV7y94qirz8joQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qXo5n-004dXe-2V; Sun, 20 Aug 2023 21:28:07 +0200
Date:   Sun, 20 Aug 2023 21:28:07 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v4 7/9] net: stmmac: platform: support parsing
 safety irqs from DT
Message-ID: <aba9a96a-a761-4849-b13d-50fb61973e8d@lunn.ch>
References: <20230816152926.4093-1-jszhang@kernel.org>
 <20230816152926.4093-8-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816152926.4093-8-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 11:29:24PM +0800, Jisheng Zhang wrote:
> The snps dwmac IP may support safety features, and those Safety
> Feature Correctible Error and Uncorrectible Error irqs may be
> separate irqs. Add support to parse the safety irqs from DT.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Acked-by: Alexandre TORGUE <alexandre.torgue@foss.st.com>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_platform.c    | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index be8e79c7aa34..4a2002eea870 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -737,6 +737,18 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
>  		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
>  	}
>  
> +	stmmac_res->sfty_ce_irq = platform_get_irq_byname_optional(pdev, "sfty_ce");
> +	if (stmmac_res->sfty_ce_irq < 0) {
> +		if (stmmac_res->sfty_ce_irq == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +	}

I think the error checking should be better than this. If i'm reading
the code correctly, it should return -ENXIO if it does not exist, and
since it is supposed to be optional, you can continue. Other values <
0 are real errors, and it should be returned.

	Andrew
