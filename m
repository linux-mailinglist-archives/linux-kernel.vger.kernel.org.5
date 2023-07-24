Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE3F760346
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 01:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjGXXn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 19:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXXny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:43:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0477E1712
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 16:43:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BE5E61173
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2A5C433C7;
        Mon, 24 Jul 2023 23:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690242232;
        bh=xc3GbyDkN/vtNrG+9K09v2LJoqlN8c2/DWBOyoLqp4M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mc5LmMIwGsi7ckAthGvVCq8IfCeOtZe/MVLUUM/x4ZxBYY45M41+Eaognvx9zoMWu
         fAyEB1AWG45hHG62wciZaGdNmknTUfNc7QJrQw6mOjbVenVhb3kkbnmJaR2Dop3pRI
         MbmJCtOSfAJhXbSZx7nyQUCk8TDSGRdxAAMTXeIDawOG+iUNme17hThUArnFKZnNO9
         GUllftsHYkbaouHXcrMl0FkXGSbkIYoYbP6E6pduJQMfqqJ1yCTj3GFjos6WJnepiY
         V4BdBrH4kNxnXyr//ZpcUkar5zUkWe37d6y7fchv8j9p1Ww39GKehwJ9yUBiHJ5d9X
         a1JC8MYIC26Cw==
Date:   Mon, 24 Jul 2023 16:43:51 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     <Tristram.Ha@microchip.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 net-next] net: phy: smsc: add WoL support to
 LAN8740/LAN8742 PHYs
Message-ID: <20230724164351.2ecf6faf@kernel.org>
In-Reply-To: <1689900053-13118-1-git-send-email-Tristram.Ha@microchip.com>
References: <1689900053-13118-1-git-send-email-Tristram.Ha@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 17:40:53 -0700 Tristram.Ha@microchip.com wrote:
> +#include <linux/inetdevice.h>
> +#include <net/addrconf.h>
> +#include <net/if_inet6.h>
> +#include <net/ipv6.h>

You don't need these includes any more, right?

>  #include <linux/smscphy.h>
>  
>  /* Vendor-specific PHY Definitions */

> +static int lan874x_set_wol(struct phy_device *phydev,
> +			   struct ethtool_wolinfo *wol)
> +{
> +	struct net_device *ndev = phydev->attached_dev;
> +	struct smsc_phy_priv *priv = phydev->priv;
> +	u16 val, val_wucsr;
> +	u8 data[128];
> +	u8 datalen;
> +	int rc;
> +
> +	if (wol->wolopts & WAKE_PHY)
> +		return -EOPNOTSUPP;

You're not advertising the support for WAKE_PHY, so you don't have to
check if it was requested. See recent commit 55b24334c0f2.

Please keep the review tags from Florian and Simon for v6, these are
minor nit picks.
-- 
pw-bot: cr
