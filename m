Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B97B77760E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbjHJKkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbjHJKjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:39:54 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D04268D;
        Thu, 10 Aug 2023 03:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fcdKfiSbV9Bw4yfr4yNiYOjw2xqNqL4+khp/9M2GE58=; b=X4ZuWlhKv4RIilso4lrR1RFv+/
        tiQXDOAwGKIX1mlS18D5PkgWMOwXCzxm9W+hehSKPsLpG0TI5uRfvOBUCidvAN1KcMQ6dZLugd7Z8
        QNrW5F4/TxG+NkmyNNIpCMYtyMCEOUTvD5WLkCQK/l4BZpHaYm2DS1AY673XWv0UE6z8vmIaBOSdD
        85EkTT/udQ0ZhlX/RZFScIzwf9duK0KuyPuixHJThH5FWtlLmeH3sLi1VpVS75j27iDXp/CYSlGwC
        F1H+ydP1GSBYbMb4Sz9O0vc95yV/bMZfnE/IsXuc6RPuBIu7q6yxzubrSOosbiGMEPfiWZmsCb9O1
        o/mbJbCQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35390)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qU34t-0003ph-1T;
        Thu, 10 Aug 2023 11:39:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qU34s-0001iY-ID; Thu, 10 Aug 2023 11:39:38 +0100
Date:   Thu, 10 Aug 2023 11:39:38 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Josua Mayer <josua@solid-run.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: sfp: handle 100G/25G active optical cables in
 sfp_parse_support
Message-ID: <ZNS+aqPiaNRJ+SK1@shell.armlinux.org.uk>
References: <20230810094817.29262-1-josua@solid-run.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810094817.29262-1-josua@solid-run.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:48:17AM +0200, Josua Mayer wrote:
> Handle extended compliance code 0x1 (SFF8024_ECC_100G_25GAUI_C2M_AOC)
> for active optical cables supporting 25G and 100G speeds.
> 
> Since the specification makes no statement about transmitter range, and
> as the specific sfp module that had been tested features only 2m fiber -
> short-range (SR) modes are selected.
> 
> sfp_parse_support already handles SFF8024_ECC_100GBASE_SR4_25GBASE_SR
> with compatible properties: 100000baseSR4; 25000baseSR; protocol 25gbase-r.
> Add SFF8024_ECC_100G_25GAUI_C2M_AOC to the same case.
> 
> Tested with fs.com S28-AO02 AOC SFP28 module.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Thanks. I think I would like one extra change:

> +	case SFF8024_ECC_100G_25GAUI_C2M_AOC:
>  	case SFF8024_ECC_100GBASE_SR4_25GBASE_SR:
>  		phylink_set(modes, 100000baseSR4_Full);

Since SFPs are single lane, SR4 doesn't make sense (which requires
four lanes), and I shouldn't have added it when adding these modes.
It would be a good idea to drop that, or at least for the
addition of the SFF8024_ECC_100G_25GAUI_C2M_AOC case.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
