Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350937844AA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbjHVOr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjHVOr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:47:58 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121D110B;
        Tue, 22 Aug 2023 07:47:54 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F1E14E000D;
        Tue, 22 Aug 2023 14:47:51 +0000 (UTC)
Date:   Tue, 22 Aug 2023 16:48:29 +0200
From:   Remi Pommarel <repk@triplefau.lt>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: remove disable_irq() from
 ->ndo_poll_controller()
Message-ID: <ZOTKvRCeocjmPYFt@pilgrim>
References: <20230810083716.29653-1-repk@triplefau.lt>
 <20230811182025.7473bf63@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811182025.7473bf63@kernel.org>
X-GND-Sasl: repk@triplefau.lt
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 06:20:25PM -0700, Jakub Kicinski wrote:
> On Thu, 10 Aug 2023 10:37:16 +0200 Remi Pommarel wrote:
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 4727f7be4f86..bbe509abc5dc 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5958,8 +5958,8 @@ static void stmmac_poll_controller(struct net_device *dev)
> >  		for (i = 0; i < priv->plat->tx_queues_to_use; i++)
> >  			stmmac_msi_intr_tx(0, &priv->dma_conf.tx_queue[i]);
> >  	} else {
> > -		disable_irq(dev->irq);
> > -		stmmac_interrupt(dev->irq, dev);
> > +		if (disable_hardirq(dev->irq))
> > +			stmmac_interrupt(dev->irq, dev);
> >  		enable_irq(dev->irq);
> 
> Implementing .ndo_poll_controller is only needed if driver doesn't use
> NAPI. This driver seems to use NAPI on all paths, AFAICT you can simply
> delete this function completely.

Looks like since [0] you are right. Will send a new PATCH removing
stmmac_poll_controller.

Thanks.

[0]: ac3d9dd034e5 ("netpoll: make ndo_poll_controller() optional")

-- 
Remi
