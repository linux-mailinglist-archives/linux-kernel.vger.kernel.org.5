Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062247E666B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjKIJQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbjKIJQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:16:01 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157792592;
        Thu,  9 Nov 2023 01:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QrvJkzyPb5eXMLbw/U/qM6wbTs8u3y089/0QYgihCZc=; b=e1cnhHhbRfJJONN+GNW4kdjpqt
        MEOj/OKISubVwkr4/XNFHD0LiTKr/DCcuIUu6DAjQmFIrjsy8VM0M1myuxsuU4OLbczvHSlTN1bZf
        vUldxONBLp1fpzsyeMeziawnQL6EZQnpRZ/49W2NhQkE0OWZUvTvSIr6OfOngPu6IUazc9J4Wt2eZ
        U/0B6VqdrF7nxM7gwc/rL6SB/+Rx8CjDgUnlEfpC+Dk4q0OOu0eMEtSOKll8rRtr9HPYaQSWvIcx7
        owQgd0W1doctv4yyEu/yIG7anYV8vFVj/qkYFkWf+oC5BTHHcc86was5sLFu+4vmT+bkFAmabYeJt
        GXESwD8Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45130)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r118V-0002B9-2p;
        Thu, 09 Nov 2023 09:15:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r118S-0000Qi-UQ; Thu, 09 Nov 2023 09:15:36 +0000
Date:   Thu, 9 Nov 2023 09:15:36 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Gan Yi Fang <yi.fang.gan@intel.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Looi Hong Aun <hong.aun.looi@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Song Yoong Siang <yoong.siang.song@intel.com>
Subject: Re: [PATCH net 1/1] net: stmmac: fix MAC and phylink mismatch issue
 after resume with STMMAC_FLAG_USE_PHY_WOL enabled
Message-ID: <ZUyjOEQHHnnbzwrV@shell.armlinux.org.uk>
References: <20231109050027.2545000-1-yi.fang.gan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109050027.2545000-1-yi.fang.gan@intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 01:00:27PM +0800, Gan Yi Fang wrote:
> From: "Gan, Yi Fang" <yi.fang.gan@intel.com>
> 
> The issue happened when flag STMMAC_FLAG_USE_PHY_WOL is enabled.
> It can be reproduced with steps below:
> 1. Advertise only one speed on the host
> 2. Enable the WoL on the host
> 3. Suspend the host
> 4. Wake up the host
> 
> When the WoL is disabled, both the PHY and MAC will suspend and wake up
> with everything configured well. When WoL is enabled, the PHY needs to be
> stay awake to receive the signal from remote client but MAC will enter
> suspend mode.
> 
> When the MAC resumes from suspend, phylink_resume() will call
> phylink_start() to start the phylink instance which will trigger the
> phylink machine to invoke the mac_link_up callback function. The
> stmmac_mac_link_up() will configure the MAC_CTRL_REG based on the current
> link state. Then the stmmac_hw_setup() will be called to configure the MAC.
> 
> This sequence might cause mismatch of the link state between MAC and
> phylink. This patch moves the phylink_resume() after stmamc_hw_setup() to
> ensure the MAC is initialized before phylink is being configured.

Isn't this going to cause problems?

stmamc_hw_setup() calls stmmac_init_dma_engine(), which then calls
stmmac_reset() - and stmmac_reset() can fail if the PHY clock isn't
running, which is why phylink_resume() gets called before this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
