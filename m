Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFC680E23D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345740AbjLLCqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjLLCqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:46:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CE1C6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:46:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6220DC433C7;
        Tue, 12 Dec 2023 02:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702349201;
        bh=cQ4wUl6++qO8BEW8ZwZKfxPjaTGwJHwd8l+J+2TIHwE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j4Z6XbCiTApJbcrug5/72aaZw9xMl+uy3S74BMKXClSIf0NIOD16lf0RJZF/3hCvS
         9pT1eea7xi7SRqSfjdNsB64zbzUw7EmRmee0vWu6KngORkdHUFGcKYvEyvp6CJTpGm
         rmNy9LJT0stHN7K13meSd/udc+luC/rHhqjuTZKAIi2Yb13hmf1a79GeEcmd8c7ENL
         Zbc4o1Qhf0MCrHUyfxFLRBwa2WCbiMfAVITbLtUtzmmLhhR41uFgEyzSPHyBuq3cB8
         ewR4yuv5XPgEzhIezdrO/Tep3hWshb2DBave1DXSwTUiJhji9ZDJl+FTxX+Dn+BGRy
         u0gNlVWHqln7w==
Date:   Mon, 11 Dec 2023 18:46:40 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Harini Katakam <harini.katakam@amd.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v4 3/3] net: phy: add support for PHY package
 MMD read/write
Message-ID: <20231211184640.5faa296c@kernel.org>
In-Reply-To: <20231206232547.2501-3-ansuelsmth@gmail.com>
References: <20231206232547.2501-1-ansuelsmth@gmail.com>
        <20231206232547.2501-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some nit picks since nobody has acked :(

On Thu,  7 Dec 2023 00:25:47 +0100 Christian Marangi wrote:
> +/**
> + * __phy_package_read_mmd - Convenience function for reading a register
> + * on an MMD on a given PHY using the PHY package base addr, added of

s/on an MMD/of an MMD/ ?
s/added of/added to/ ?

> + * the addr_offset value.
> + * @phydev: The phy_device struct
> + * @addr_offset: The offset to be added to PHY package base_addr
> + * @devad: The MMD to read from
> + * @regnum: The register on the MMD to read
> + *
> + * Same rules as for __phy_read();
> + *
> + * NOTE: It's assumed that the entire PHY package is either C22 or C45.

I'd try to make the headline shorter:

/**
 * __phy_package_read_mmd - read MMD reg relative to PHY package base addr
 * @phydev: The phy_device struct
 * @addr_offset: The offset to be added to PHY package base_addr
 * @devad: The MMD to read from
 * @regnum: The register on the MMD to read
 *
 * Convenience helper for reading a register of an MMD on a given PHY
 * using the PHY package base address. The base address is added to
 * the addr_offset value.
 *
 * Same calling rules as for __phy_read();
 *
 * NOTE: It's assumed that the entire PHY package is either C22 or C45.
 */
