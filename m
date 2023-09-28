Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C50A7B1F24
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjI1OCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjI1OCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:02:41 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4957136;
        Thu, 28 Sep 2023 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=8p2Tnc7y+3ndPNdZJdsry6jgyGHy8zln6O5PORb/qOc=; b=l7MGeJSur9B4YWluEkYoe3xu2c
        gIBhZBYxMzCpY/4ImKVN/dDlIjkQwmlJnaciNhOUcoY28/IojwaPtRzS9jpoE3iHgZEt8q03C3T4U
        ajyZaf1gKtup40m4V57aPk/jLWUPAjLx578Ld7MCPV/gNOWFmeeJEbSVMmePSF0DSZCY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qlrb3-007kVO-Gu; Thu, 28 Sep 2023 16:02:29 +0200
Date:   Thu, 28 Sep 2023 16:02:29 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v9 08/13] net:ethernet:realtek:rtase: Implement
 net_device_ops
Message-ID: <b28a3ea6-d75e-45e0-8b87-0b062b5c3a64@lunn.ch>
References: <20230928104920.113511-1-justinlai0215@realtek.com>
 <20230928104920.113511-9-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928104920.113511-9-justinlai0215@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int rtase_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	int ret;
> +
> +	dev->mtu = new_mtu;
> +
> +	if (!netif_running(dev))
> +		goto out;
> +
> +	rtase_down(dev);
> +
> +	rtase_set_rxbufsize(tp, dev);
> +
> +	ret = rtase_init_ring(dev);
> +
> +	if (ret)
> +		return ret;

If this fails, what state is the interface in?

What you often see is that the new ring is first allocated. If that is
successful, you free the old rung. If the allocation fails, it does
not matter, you still have the old ring, and you keep using it.

> +
> +	netif_stop_queue(dev);
> +	netif_carrier_off(dev);
> +	rtase_hw_config(dev);
> +
> +	/* always link, so start to transmit & receive */
> +	rtase_hw_start(dev);
> +	netif_carrier_on(dev);
> +	netif_wake_queue(dev);

I don't think you need to down/up the carrier when changing the MTU.

> +static void rtase_sw_reset(struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	int ret;
> +
> +	netif_stop_queue(dev);
> +	netif_carrier_off(dev);
> +	rtase_hw_reset(dev);
> +
> +	/* let's wait a bit while any (async) irq lands on */
> +	rtase_wait_for_quiescence(dev);
> +	rtase_tx_clear(tp);
> +	rtase_rx_clear(tp);
> +
> +	ret = rtase_init_ring(dev);
> +	if (ret)
> +		netdev_alert(dev, "unable to init ring\n");
> +
> +	rtase_hw_config(dev);
> +	/* always link, so start to transmit & receive */
> +	rtase_hw_start(dev);
> +
> +	netif_carrier_on(dev);
> +	netif_wake_queue(dev);
> +}
> +
> +static void rtase_tx_timeout(struct net_device *dev, unsigned int txqueue)
> +{
> +	rtase_sw_reset(dev);

Do you actually see this happening? The timeout is set pretty high, i
think 5 seconds. If it does happen, it probably means you have a
hardware/firmware bug. So you want to be noisy here, so you get to
know about these problems, rather than silently work around them.

> +static int rtase_setup_tc(struct net_device *dev, enum tc_setup_type type,
> +			  void *type_data)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	int ret = 0;
> +
> +	switch (type) {
> +	case TC_SETUP_QDISC_MQPRIO:
> +		break;
> +	case TC_SETUP_BLOCK:
> +		break;

This looks odd. You silently return 0, doing nothing?

> +	case TC_SETUP_QDISC_CBS:
> +		ret = rtase_setup_tc_cbs(tp, type_data);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return ret;
> +}
> +
> +static netdev_features_t rtase_fix_features(struct net_device *dev,
> +					    netdev_features_t features)
> +{
> +	netdev_features_t features_fix = features;
> +
> +	if (dev->mtu > MSS_MAX)
> +		features_fix &= ~NETIF_F_ALL_TSO;
> +
> +	if (dev->mtu > ETH_DATA_LEN) {
> +		features_fix &= ~NETIF_F_ALL_TSO;
> +		features_fix &= ~NETIF_F_CSUM_MASK;
> +	}

So the hardware does not support TSO and checksumming for jumbo frames?

   Andrew
