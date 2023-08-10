Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77879777E03
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbjHJQVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjHJQVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:21:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73365213B;
        Thu, 10 Aug 2023 09:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A193661AD;
        Thu, 10 Aug 2023 16:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88910C43395;
        Thu, 10 Aug 2023 16:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691684475;
        bh=wg+muEbAujbbh2zXEVrmvAEGXX2IY9xlbeZCgjf7UGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SSGYTStsitdriIpN4kdKLnkJcGo4quBuINyYRroCoy6YF+BVm5FbF9U/kci+GVKmC
         V8zxoYzJ/0fj0/0JR7+gP4wZFD4iSGmBUs0U3sl3HIc+7Yz3s7vORWSkpq32OeoAd0
         Ro4IfgNTLwCKZh1MvZ9fpti7RLw3jntgo8i5DSH8mWOqG/G0u+lfpoX9OGu+QPP6xA
         zE0K+dPsbWvS/gAWN76XebdzQD2dvJwy6fjEcJ3KFytEh0ypL1WkDBia9ZYfHM49Tl
         QiCyz0l2LgqHbXH56K91KPhblXV0zEDH9uK1DjMEt1pJvzsFw81eeCEkPlFfzHav0x
         LcxHnaVgL7LHA==
Date:   Fri, 11 Aug 2023 00:09:32 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 10/10] net: stmmac: platform: support parsing
 per channel irq from DT
Message-ID: <ZNULvNhWbRyOUDci@xhacker>
References: <20230809165007.1439-1-jszhang@kernel.org>
 <20230809165007.1439-11-jszhang@kernel.org>
 <43ea0060-ed69-4efe-4a39-224aa67ae9b8@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43ea0060-ed69-4efe-4a39-224aa67ae9b8@foss.st.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 04:57:00PM +0200, Alexandre TORGUE wrote:
> On 8/9/23 18:50, Jisheng Zhang wrote:
> > The snps dwmac IP may support per channel interrupt. Add support to
> > parse the per channel irq from DT.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++++----
> >   .../ethernet/stmicro/stmmac/stmmac_platform.c | 23 +++++++++++++++++++
> >   2 files changed, 29 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 4ed5c976c7a3..245eeb7d3e83 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -3612,7 +3612,7 @@ static int stmmac_request_irq_multi(struct net_device *dev)
> >   	for (i = 0; i < priv->plat->rx_queues_to_use; i++) {
> >   		if (i >= MTL_MAX_RX_QUEUES)
> >   			break;
> > -		if (priv->rx_irq[i] == 0)
> > +		if (priv->rx_irq[i] <= 0)
> 
> What do you fix here ?

No bug to fix, but adjust for parsing optional channel irqs from DT:
rx_irq[i] and tx_irq[i] may come from platform_get_irq_byname_optional()
so for !STMMAC_FLAG_PERCH_IRQ_EN platforms, they can be < 0. Before

Thanks
> 
> >   			continue;
> >   		int_name = priv->int_name_rx_irq[i];
> > @@ -3637,7 +3637,7 @@ static int stmmac_request_irq_multi(struct net_device *dev)
> >   	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
> >   		if (i >= MTL_MAX_TX_QUEUES)
> >   			break;
> > -		if (priv->tx_irq[i] == 0)
> > +		if (priv->tx_irq[i] <= 0)
> 
> same here
> >   			continue;
> >   		int_name = priv->int_name_tx_irq[i];
> > @@ -7278,8 +7278,10 @@ int stmmac_dvr_probe(struct device *device,
> >   	priv->plat = plat_dat;
> >   	priv->ioaddr = res->addr;
> >   	priv->dev->base_addr = (unsigned long)res->addr;
> > -	priv->plat->dma_cfg->perch_irq_en =
> > -		(priv->plat->flags & STMMAC_FLAG_PERCH_IRQ_EN);
> > +	if (res->rx_irq[0] > 0 && res->tx_irq[0] > 0) {
> > +		priv->plat->flags |= STMMAC_FLAG_PERCH_IRQ_EN;
> > +		priv->plat->dma_cfg->perch_irq_en = true;
> > +	}
> >   	priv->dev->irq = res->irq;
> >   	priv->wol_irq = res->wol_irq;
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > index 29145682b57b..9b46775b41ab 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > @@ -705,6 +705,9 @@ EXPORT_SYMBOL_GPL(stmmac_remove_config_dt);
> >   int stmmac_get_platform_resources(struct platform_device *pdev,
> >   				  struct stmmac_resources *stmmac_res)
> >   {
> > +	char irq_name[8];
> > +	int i;
> > +
> >   	memset(stmmac_res, 0, sizeof(*stmmac_res));
> >   	/* Get IRQ information early to have an ability to ask for deferred
> > @@ -738,6 +741,26 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
> >   		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
> >   	}
> > +	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
> > +		snprintf(irq_name, sizeof(irq_name), "rx%i", i);
> > +		stmmac_res->rx_irq[i] = platform_get_irq_byname_optional(pdev, irq_name);
> > +		if (stmmac_res->rx_irq[i] < 0) {
> > +			if (stmmac_res->rx_irq[i] == -EPROBE_DEFER)
> > +				return -EPROBE_DEFER;
> > +			break;
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
> > +		snprintf(irq_name, sizeof(irq_name), "tx%i", i);
> > +		stmmac_res->tx_irq[i] = platform_get_irq_byname_optional(pdev, irq_name);
> > +		if (stmmac_res->tx_irq[i] < 0) {
> > +			if (stmmac_res->tx_irq[i] == -EPROBE_DEFER)
> > +				return -EPROBE_DEFER;
> > +			break;
> > +		}
> > +	}
> > +
> >   	stmmac_res->sfty_ce_irq = platform_get_irq_byname_optional(pdev, "sfty_ce");
> >   	if (stmmac_res->sfty_ce_irq < 0) {
> >   		if (stmmac_res->sfty_ce_irq == -EPROBE_DEFER)
> 
