Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0732F7589CB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 01:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjGRX73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 19:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjGRX5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:57:55 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877B944AF;
        Tue, 18 Jul 2023 16:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=3SRL82U+r5Gafi2794w2G4k0vOB0+Ph0wvmLFGuO9U0=; b=wE9rWC+VBXC8h7OtzZyTs5/zw4
        W6ykdeJXTndbIPXyS3mKFE7T9vzkCjl9WLh98zv+HCL71B56cYXgVwWWkcPaVqlwmhQW4i/MUVVML
        QehDK/m9PSwUyKQFOTe+DEhGaoXkYKpVax6dmcrDFQycPhtAZhgwLz++3RJ8KJT/24+8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qLuWJ-001ftQ-Ly; Wed, 19 Jul 2023 01:54:19 +0200
Date:   Wed, 19 Jul 2023 01:54:19 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 07/11] net: phy: introduce
 phy_mdiobus_read_mmd()
Message-ID: <3cfe5af5-31b6-492c-af55-cd0397b07eb1@lunn.ch>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-7-9eb37edf7be0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-feature-c45-over-c22-v3-7-9eb37edf7be0@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int __phy_mdiobus_read_mmd(struct mii_bus *bus, int phy_addr,
> +				  enum phy_access_mode access_mode,
> +				  int devad, u32 regnum)
> +{
> +	switch (access_mode) {
> +	case PHY_ACCESS_C45:
> +		return __mdiobus_c45_read(bus, phy_addr, devad, regnum);
> +	case PHY_ACCESS_C22:
> +		/* ignore return value for legacy reasons */
> +		mmd_phy_indirect(bus, phy_addr, devad, regnum, false);
> +
> +		/* Read the content of the MMD's selected register */
> +		return __mdiobus_read(bus, phy_addr, MII_MMD_DATA);
> +	default:
> +		return -EOPNOTSUPP;
> +	}

So this is reading a C45 register space register, otherwise it would
not be called _mmd and have a devad. So access_mode should really be
transfer mode. Until now, only transfer mode C45 can be used to access
C45 register space. The point of this patchset is to add a new
C45_OVER_C22 transfer mode.

And C22 would should give -EINVAL, since you cannot use plain C22 bus
transactions to access C45 register space.

	Andrew 
