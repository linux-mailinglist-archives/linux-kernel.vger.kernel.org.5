Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919B97583A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGRRlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGRRlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:41:11 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F0CB3;
        Tue, 18 Jul 2023 10:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=3918YmLdUBB4GYWEtCfYavXvLujdLfhM5ZbLxQDFZQM=; b=6PthlviAF6BZw3Gc3+bpp1LHuo
        ovOJnWYb7m6KQLesheBYu7lSQkXk/GtNR+iuzAqmUSsPQWewzk9eQvgW37grCvSmlR63xW0n0DPlO
        RryE0v45L6mGEiQBdv8vMLNEXGlP7MwUmrt0Wj1YsNz26eb1kcM67Al7owsahHfoKRsI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qLogr-001drs-MB; Tue, 18 Jul 2023 19:40:49 +0200
Date:   Tue, 18 Jul 2023 19:40:49 +0200
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
Subject: Re: [PATCH net-next v3 03/11] net: phy: replace is_c45 with
 phy_accces_mode
Message-ID: <509889a3-f633-40b0-8349-9ef378818cc7@lunn.ch>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-3-9eb37edf7be0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-feature-c45-over-c22-v3-3-9eb37edf7be0@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  static inline bool phy_has_c45_registers(struct phy_device *phydev)
>  {
> -	return phydev->is_c45;
> +	return phydev->access_mode != PHY_ACCESS_C22;
>  }

So this is making me wounder if we have a clean separation between
register spaces and access methods.

Should there be a phy_has_c22_registers() ?

A PHY can have both C22 registers and C45 registers. It is up to the
driver to decide which it wants to access when.

Should phydev->access_mode really be phydev->access_mode_c45_registers
to indicate how to access the C45 registers if phy_has_c45_registers()
is true?

Has there been a review of all uses of phydev->is_c45 to determine if
the user wants to know if C45 registers exist,
a.k.a. phy_has_c45_registers(), or if C45 bus transactions can be
performed, and then later in this series, additionally if C45 over C22
can be performed. These are different things.

I need to keep reading the patches...

  Andrew
