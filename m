Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83CA779C3A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 03:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbjHLBUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 21:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjHLBU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 21:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621241BF9;
        Fri, 11 Aug 2023 18:20:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 008E4601D9;
        Sat, 12 Aug 2023 01:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63D9C433C8;
        Sat, 12 Aug 2023 01:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691803227;
        bh=wYICEGflWGmxjyn1cvUXEfdlZXS0waAspNgq3SytX3U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jNiQiiyBJKG60pEXmy5eLsG8d8CxaJlPGZZHd/kxOoN7Ir0Sja8pS5dGeC14u3eTj
         /qt2L2FNYRz1wFOT7WqgJQsB5flVsTL6WktoESM+TJPnzYg2wuOnDMP2SfJYAMguTP
         3s/t1sTKrb/wwoCwrn+6PvM3I3L67kvRjS36YD2r1wk23L7PvZDJpcZpEcCo+zv4cm
         F3OX6cciYRRPQTiy88O3TBIjDjFEH75fZtpyKiniRRAZRc7oS9Ey6/pBZKXFV733A0
         PWvZsfEbKVjzJVc9dje4+LOrS0Dt4dcEJRCo5Xf9U1HMNfQQ7d4JFYVWxNSoKUgtqz
         JBExRKTlsWgmQ==
Date:   Fri, 11 Aug 2023 18:20:25 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: remove disable_irq() from
 ->ndo_poll_controller()
Message-ID: <20230811182025.7473bf63@kernel.org>
In-Reply-To: <20230810083716.29653-1-repk@triplefau.lt>
References: <20230810083716.29653-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 10:37:16 +0200 Remi Pommarel wrote:
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 4727f7be4f86..bbe509abc5dc 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5958,8 +5958,8 @@ static void stmmac_poll_controller(struct net_device *dev)
>  		for (i = 0; i < priv->plat->tx_queues_to_use; i++)
>  			stmmac_msi_intr_tx(0, &priv->dma_conf.tx_queue[i]);
>  	} else {
> -		disable_irq(dev->irq);
> -		stmmac_interrupt(dev->irq, dev);
> +		if (disable_hardirq(dev->irq))
> +			stmmac_interrupt(dev->irq, dev);
>  		enable_irq(dev->irq);

Implementing .ndo_poll_controller is only needed if driver doesn't use
NAPI. This driver seems to use NAPI on all paths, AFAICT you can simply
delete this function completely.
-- 
pw-bot: cr
