Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4057848B2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjHVRvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHVRvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:51:43 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14466196;
        Tue, 22 Aug 2023 10:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ntj7K6XXlQwLgtMfVD+ZqplWIe/c7G12xO0Z+/57Prw=; b=kQwYTqnqqO7imz3poYmNGtCO5R
        PNfzxDEQRvqz9SWTu15F4NhOyp6tSUWTJa4tpLs1sT+rw90QrSdxwPaup7YK4fdBYYmEP5n5rSVJO
        USfYqIaiUfD+MuYH0EAcxvmDe9c2488CT4H8Est5jYUC72C9lAmby6euWBM0yhqLTMfY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qYVXN-004o2v-Su; Tue, 22 Aug 2023 19:51:29 +0200
Date:   Tue, 22 Aug 2023 19:51:29 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, jiri@resnulli.us
Subject: Re: [PATCH net-next v6 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Message-ID: <c9bbd802-27da-4775-8176-fa73e6ec4381@lunn.ch>
References: <20230822031805.4752-1-justinlai0215@realtek.com>
 <20230822031805.4752-2-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822031805.4752-2-justinlai0215@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int rtase_set_pauseparam(struct net_device *dev, struct ethtool_pauseparam *pause)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	u16 value = RTL_R16(tp, CPLUS_CMD);
> +
> +	value &= ~(FORCE_TXFLOW_EN | FORCE_RXFLOW_EN);
> +
> +	if (pause->tx_pause)
> +		value |= FORCE_TXFLOW_EN;
> +
> +	if (pause->rx_pause)
> +		value |= FORCE_RXFLOW_EN;
> +
> +	RTL_W16(tp, CPLUS_CMD, value);
> +	return 0;
> +}

I'm pretty sure i said if pause->autoneg is true, you should return
-EOPNOTUSPP.

	Andrew
