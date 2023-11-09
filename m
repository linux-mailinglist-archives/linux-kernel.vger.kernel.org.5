Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ED77E6E9A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343842AbjKIQXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjKIQXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:23:19 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD12735A9;
        Thu,  9 Nov 2023 08:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=IgIWkKpvGMvUKj92YCRYLOy8UePNcQyB18TDcSyhxoE=; b=esslbwfVGfDyH5J4Z1pPOHI+8G
        XKEVlcHOinNAydE2xp/gTDlnHfg/SVLmso1tcIvdsnCftiD4FIzZW10F5SOvIOKATlTMOHU8D/iH/
        vZQk62wqQFHPlS8fpv6jnU1Vj9reEIH7hXnGYKl922iB5KK5mORtBUMCvOC0h8cnQJQM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r17o2-001DYh-UI; Thu, 09 Nov 2023 17:22:58 +0100
Date:   Thu, 9 Nov 2023 17:22:58 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Gan Yi Fang <yi.fang.gan@intel.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Halaney <ahalaney@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Johannes Zink <j.zink@pengutronix.de>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Looi Hong Aun <hong.aun.looi@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Song Yoong Siang <yoong.siang.song@intel.com>
Subject: Re: [PATCH net-next 1/1] net: stmmac: Add support for HW-accelerated
 VLAN stripping
Message-ID: <b197865d-8905-497c-8fe0-d6e122b0d9f7@lunn.ch>
References: <20231109053831.2572699-1-yi.fang.gan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109053831.2572699-1-yi.fang.gan@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void dwmac4_rx_hw_vlan(struct mac_device_info *hw,
> +			      struct dma_desc *rx_desc, struct sk_buff *skb)
> +{
> +	if (hw->desc->get_rx_vlan_valid(rx_desc)) {
> +		u16 vid = (u16)hw->desc->get_rx_vlan_tci(rx_desc);
> +
> +		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
> +	}
> +}

> +static inline int dwmac4_wrback_get_rx_vlan_tci(struct dma_desc *p)
> +{
> +	return (le32_to_cpu(p->des0) & RDES0_VLAN_TAG_MASK);
> +}

A tci is a u16. If you make this function return a u16, you can avoid
the cast.

  Andrew
