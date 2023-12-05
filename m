Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB0580448C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343882AbjLECRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjLECRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:17:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D19A0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:17:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAF2C433C8;
        Tue,  5 Dec 2023 02:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701742674;
        bh=CFuIQBFb4jQLP5hJXSZ1DamnTQmlulyUK6o3iWa+amA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QPhJIaURVkaehK07DiA9eU7x4cF/P10zqZmv6Gx6GiTtbUDmQj0fxdb3uMce1NdRd
         Owsw6ukeGy96FxYtXL22lMsoYsmwV/mAD+NnJJAVP8VdZ8jPdk4EzbSrFQXjT8FJSe
         lhRshCmKH/h7Sl5BVk3rEILYGeDJ7sYgmaTdwDai9aoSfefuSLBrDlZLZQJmqVuAsV
         xYQsCXgbVQEm908rvw/PNhrpFfPiMv3vClnnexPXg6hG1UdLiKdEsS+PFesBI+hIcH
         7j0YdVgbRmhefip2PIRQ2fIZTkS2brQi+sl6Ly+WF6TjpJBvwHh5DSPTpDS9C9yQp9
         f1GbEGR3xDw4A==
Date:   Mon, 4 Dec 2023 18:17:52 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Harini Katakam <harini.katakam@amd.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v3 3/3] net: phy: add support for PHY package
 MMD read/write
Message-ID: <20231204181752.2be3fd68@kernel.org>
In-Reply-To: <20231128133630.7829-3-ansuelsmth@gmail.com>
References: <20231128133630.7829-1-ansuelsmth@gmail.com>
        <20231128133630.7829-3-ansuelsmth@gmail.com>
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

On Tue, 28 Nov 2023 14:36:30 +0100 Christian Marangi wrote:
> +/**
> + * phy_package_write_mmd - Convenience function for writing a register
> + * on an MMD on a given PHY using the PHY package base addr, added of
> + * the addr_offset value.
> + * @phydev: The phy_device struct
> + * @addr_offset: The offset to be added to PHY package base_addr
> + * @devad: The MMD to read from
> + * @regnum: The register on the MMD to read
> + * @val: value to write to @regnum
> + *
> + * Same rules as for phy_write();
> + *
> + * NOTE: It's assumed that the entire PHY package is either C22 or C45.
> + */

> +/*
> + * phy_package_write_mmd - Convenience function for writing a register
> + * on an MMD on a given PHY using the PHY package base addr, added of
> + * the addr_offset value.
> + */
> +int phy_package_write_mmd(struct phy_device *phydev,
> +			  unsigned int addr_offset, int devad,
> +			  u32 regnum, u16 val);

Hm, I see there's some precedent here already for this duplicated
semi-kdoc. It seems a bit unusual. If I was looking for kdoc and 
found the header one I'd probably not look at the source file at all.

Andrew, WDYT?
