Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8A077F7C5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351492AbjHQNbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351477AbjHQNbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:31:09 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EDD114;
        Thu, 17 Aug 2023 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ld5JKggMZ2IqtoJqdfMp2BiZOzizYR/A4WFUfHZvxKY=; b=BA8Vk27onV+uMI6G33n5GEZWVV
        keaHLaYffbBy2LalShGYKkDKpjLsrociI5Wv3mQ4tD2f1dsRtifqtfJ4HaByhf9XJJxmugKnETiLL
        KklDHD13XSZ3XBzmvadBEx39PA0BoOJBVzBpgFMwbGQ+fLt10WnDIua5INTGNn2O9kJk5NJfzBMzi
        LibiSgsKF1pN69Hr1JLAY1YG9lszOhRpIrNUg7o2MCLejqkPEYKvf9NLZe+ueDEHqwjhecbEWapTn
        o5gPvHGOFeuDfH9Ja6c6C7gmLm9UaaXoWXrYeqfpAMAH4iUzXNnZojSYGtrYLiBGAftCeSIcCNTTb
        GPEptzHA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54512)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qWd5Q-0004En-2r;
        Thu, 17 Aug 2023 14:30:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qWd5P-0000dZ-56; Thu, 17 Aug 2023 14:30:51 +0100
Date:   Thu, 17 Aug 2023 14:30:51 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Denis Kirjanov <dkirjanov@suse.de>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Alexander Couzens <lynxis@fe80.eu>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: pcs: lynxi: fully reconfigure if link is
 down
Message-ID: <ZN4hCzTJ0DN6iBDU@shell.armlinux.org.uk>
References: <e9831ec99acd5a8ab03c76fce87fa750c7041e60.1692273723.git.daniel@makrotopia.org>
 <565a8248-c4d1-f135-2499-6bbfe76def53@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <565a8248-c4d1-f135-2499-6bbfe76def53@suse.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 04:13:44PM +0300, Denis Kirjanov wrote:
> btw is it a thread-safe to check the mpcs->interface member?
> I've quick checked and phylink_pcs_config can be invoked from different places
> and the code below does the following assignment:
> mpcs->interface = interface;

pcs_config is called from:
- phylink_change_inband_advert() while holding pl->state_mutex
- phylink_major_config()

phylink_major_config() is called from:
- phylink_resolve() while holding pl->state_mutex
- phylink_ethtool_ksettings_set() while holding pl->state_mutex
- phylink_mac_initial_config()

phylink_mac_initial_config() is called from:
- phylink_resume()
- phylink_start()

In both cases, these are called without holding pl->state_mutex, so
one may think that they could be unsafe. In both cases, however,
pl->phylink_disable_state is non-zero.

phylink_change_inband_advert() will check whether
PHYLINK_DISABLE_STOPPED is set, and not proceed to call pcs_config()
in that case. In the phylink_resume() case, userspace isn't running,
so there can't be a call to phylink_change_inband_advert().

So, one can assume (as must be the case of course, we're fiddling
with hardware) that pcs_config() will always be run without another
thread also running it for the same hardware. Two over-lapping
pcs_config() calls would lead to an indeterminant hardware state.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
