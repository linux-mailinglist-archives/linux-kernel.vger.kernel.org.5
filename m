Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77380767D19
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 10:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjG2IOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 04:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjG2IOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 04:14:19 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBA53C35;
        Sat, 29 Jul 2023 01:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=hnM3KPTgwUyw7re4llKJUXi4wpOURF3zaN76tKm3DBI=; b=wTmRvJISRGyt1eGFPTM2/jYd7l
        olEqp61vf4azmDbhysOU2kTXTcMmUQXPWjcIBXJPyzmEaWYvuB4mToL9I2g055iKcrC70J1ZEpAnw
        ASJdJSjb6BZQ2Q/Erq79WXtlOmGANNnG8pKzf698rxJdTNgrnj/rKELxjU870iBX8YE4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qPf5S-002a40-JR; Sat, 29 Jul 2023 10:14:06 +0200
Date:   Sat, 29 Jul 2023 10:14:06 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        David Bauer <mail@david-bauer.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Viorel Suman <viorel.suman@nxp.com>,
        Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH v3 1/2] net: phy: at803x: fix the wol setting functions
Message-ID: <8071d8c5-1da3-47a0-9da2-a64ee80db6e5@lunn.ch>
References: <20230728215320.31801-1-leoyang.li@nxp.com>
 <20230728215320.31801-2-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728215320.31801-2-leoyang.li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 04:53:19PM -0500, Li Yang wrote:
> In commit 7beecaf7d507 ("net: phy: at803x: improve the WOL feature"), it
> seems not correct to use a wol_en bit in a 1588 Control Register which is
> only available on AR8031/AR8033(share the same phy_id) to determine if WoL
> is enabled.  Change it back to use AT803X_INTR_ENABLE_WOL for determining
> the WoL status which is applicable on all chips supporting wol. Also update
> the at803x_set_wol() function to only update the 1588 register on chips
> having it.

Do chips which do not have the 1588 register not have WoL? Or WoL
hardware is always enabled, but you still need to enable the
interrupt.

Have you tested on a range of PHY? It might be better to split this
patch up a bit. If it causes regressions, having smaller patches can
make it easier to find which change broken it.

     Andrew
