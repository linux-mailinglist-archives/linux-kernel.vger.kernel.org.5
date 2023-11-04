Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378587E10D3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 20:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjKDTst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 15:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjKDTss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 15:48:48 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EFFDE;
        Sat,  4 Nov 2023 12:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=JJB1Gd2vfDD5Cb0VKZWY3JFIRz31OGoMkEKYYUSPXAo=; b=LjQqLjBDMsRd5KqJSgkxkcx5eh
        IDOzT30HhmqGtN0RKblfPEw2rPBwQWIbZzbSW3mLkPRUzmOq6Fdz2n2lZ0Lls7DGfJ/P/Y3GC7tVM
        KHldAxORqtqe7gYFX2nsfzC9GMh3mZOMb9aFug/L4R9/tEZD0PQiPd3eOE74TChLXNo0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qzMdI-000u5e-8b; Sat, 04 Nov 2023 20:48:36 +0100
Date:   Sat, 4 Nov 2023 20:48:36 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v10 10/13] net:ethernet:realtek:rtase: Implement
 ethtool function
Message-ID: <726ce350-b2df-4dfb-8401-dc9c70dd8cd6@lunn.ch>
References: <20231102154505.940783-1-justinlai0215@realtek.com>
 <20231102154505.940783-11-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102154505.940783-11-justinlai0215@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int rtase_get_settings(struct net_device *dev,
> +			      struct ethtool_link_ksettings *cmd)
> +{
> +	u32 supported = SUPPORTED_MII | SUPPORTED_Pause;
> +
> +	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
> +						supported);
> +	cmd->base.speed = SPEED_5000;
> +	cmd->base.duplex = DUPLEX_FULL;
> +	cmd->base.port = PORT_MII;
> +	cmd->base.autoneg = AUTONEG_DISABLE;
> +
> +	return 0;
> +}
> +

> +static int rtase_set_pauseparam(struct net_device *dev,
> +				struct ethtool_pauseparam *pause)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	u16 value = rtase_r16(tp, RTASE_CPLUS_CMD);
> +
> +	if (pause->autoneg)
> +		return -EOPNOTSUPP;
> +
> +	value &= ~(FORCE_TXFLOW_EN | FORCE_RXFLOW_EN);
> +
> +	if (pause->tx_pause)
> +		value |= FORCE_TXFLOW_EN;
> +
> +	if (pause->rx_pause)
> +		value |= FORCE_RXFLOW_EN;

It appears the hardware supports asymmetric pause? So i think your
rtase_get_settings() is wrong.

	Andrew
