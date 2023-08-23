Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53515785658
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbjHWK6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjHWK6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:58:54 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BC4FB;
        Wed, 23 Aug 2023 03:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QpqzTXlkvfTZwb/qvLffSgOkdmA3MgzLw1gYn4Tft4k=; b=s/9kx6+CR/fuCvSdzEXiuQjEfZ
        EdboCKEcmE68sjpbz32RSMAnopH5pDf5FWnykSJznpjzbcLne2CEzF/ettMHvNxEZRwVE84hajdMi
        NK88pFfypItbIjF3cChnkLE6vL2H8WQit9euN7sWPjMxwQjzOiSPZy+En65nCYIFEk6TejmTV9yxc
        3BSESc8hQZqVZH1d4SKqulITtnWdmHws66OttGpvKlGtRUzwVgj0iPKwY9vYa3HaysPc7b6n/z0i8
        NGnex4U5VnAjp6bSr3FR0EK+NP/LM8+C51OLtz2klZ/imZyb1e7HMGAHvV3sPD3iiYaiy3BRUCxJY
        ikXoj3uA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42594)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qYlZJ-0002eW-1e;
        Wed, 23 Aug 2023 11:58:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qYlZI-0006lA-Js; Wed, 23 Aug 2023 11:58:32 +0100
Date:   Wed, 23 Aug 2023 11:58:32 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Rohan G Thomas <rohan.g.thomas@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Synopsys XGMII MAC and USXGMII interfaces
Message-ID: <ZOXmWLB4TKGKvkiE@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Part 2 of the discussion...

A similar issue applies to PHY_INTERFACE_MODE_USXGMII, but is reversed.
USXGMII supports 10M, 100M, 1G, 2.5G, 5G and 10G. Phylink allows all of
these because that's what the appropriate standard says. dwxgmac2
initialises config register settings for speeds from 10M up to 10G.
However, the PHY_INTERFACE_MODE_USXGMII switch() block in
stmmac_mac_link_up() only handles 2.5G, 5G and 10G. Shouldn't it handle
the other speed cases - it looks like the MAC does support them.

The initialisation done by dwxgmac2_setup() does setup control register
masks for everything from 10M to 10G, so on the face of it, it looks
like a mistake in stmmac_mac_link_up().

If it's something outside of the MAC that doesn't support these speeds
when operating as USXGMII, then that needs to be handled.

The other weird thing is that when using PHY_INTERFACE_MODE_USXGMII
with XPCS, XPCS supports 1G, 2.5G and 10G ethtool link modes, but not
5G. So combining the implementation in stmmac_mac_link_up(), that
means only 2.5G and 10G can actually be functional. Is that a fair
assessment of the USXGMII situation with stmmac?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
