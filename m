Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F5577F748
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351186AbjHQNFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351400AbjHQNFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:05:22 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097A335A5;
        Thu, 17 Aug 2023 06:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2O+oMCc4tCMfBiIfp7tXuumeCBqFXKjABtwXyZskEPw=; b=xGhRgbFnSSNHr2vcTGi9qICnPQ
        wnFJyD4mcsojgjl7m4A6TH6Vbd2KqJRj9YCbHhk1+a7ohdxeMUyW8J9EpgS8n/y+AOlxbHy//a3fq
        RzchlP+XTJE+uRAtv2yoyRwUu78eUUuoJ72uw3Qkd5/0DgZz8BVWZFtOs4+cpNSb8cNvwTrNoBYCX
        C/2YY8tb70oZjsIIoWwE1KUdu78y4obXNDEMxzsUvDr7ho1kzBUvfobuL3x4BwLR90wgq5GD+LYNp
        2+smJFaErreGkcpezH0dGQJqyVnw3ADQIa1R3mZWW6YTQHZSI/RyvhVd5ZaWiFMJruaqfIkfZ1oFD
        P+z76Ftw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46006)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qWcf7-0004CA-2Y;
        Thu, 17 Aug 2023 14:03:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qWcf6-0000cG-FX; Thu, 17 Aug 2023 14:03:40 +0100
Date:   Thu, 17 Aug 2023 14:03:40 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Alexander Couzens <lynxis@fe80.eu>, Andrew Lunn <andrew@lunn.ch>,
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
Message-ID: <ZN4arCVzdszcIBX0@shell.armlinux.org.uk>
References: <e9831ec99acd5a8ab03c76fce87fa750c7041e60.1692273723.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9831ec99acd5a8ab03c76fce87fa750c7041e60.1692273723.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 01:04:06PM +0100, Daniel Golle wrote:
> On MT7988 When switching from 10GBase-R/5GBase-R/USXGMII to one of the
> interface modes provided by mtk-pcs-lynxi we need to make sure to
> always perform a full configuration of the PHYA.
> As the idea behind not doing that was mostly to prevent an existing link
> going down without any need for it to do so. Hence we can just always
> perform a full confinguration in case the link is down.

And this is racy - because in the case with inband signalling, the link
can come up between reading the status and acting on it. It could even
be already up, but the link status indicates it is not. Lastly, reading
the BMSR has side effects: the link status bit latches low until a read.

Basically, do not read the BMSR here, it's buggy to read it any place
other than pcs_get_state.

I think what we need to do instead are:

1) mtk_mac_select_pcs() returns the SGMII PCS or NULL. Presumably this
   is the driver which supports 10GBase-R/5GBase-R/USXGMII, and thus
   this returns NULL for 10GBase-R/5GBase-R/USXGMII.

   Phylink doesn't cater for mac_select_pcs() returning non-NULL for
   some modes and NULL for others, mainly because the presence of a PCS
   _used_ to cause phylink to change its behaviour (see
   https://lore.kernel.org/netdev/YZRLQqLblRurUd4V@shell.armlinux.org.uk/).
   That has now changed (we've got rid of the legacy stuff at last!) so
   there is no technical reason not to now allow that.

   Vladimir did have some arguments for not allowing it when we had the
   phylink_set_pcs() interface:
   https://lore.kernel.org/netdev/20211123181515.qqo7e4xbuu2ntwgt@skbuf/
   I'm assuming that your requirement now provides sufficient
   justification for allowing this.

   There is one bug that does need fixing first:
   phylink_change_inband_advert() checks pl->pcs->neg_mode without
   first checking whether pl->pcs is non-NULL.

   To allow this, phylink_major_config() needs:

   	pcs_changed = pcs && pl->pcs != pcs;

   to become:

   	pcs_changed = pl->pcs != pcs;

2) with (1) solved, there are a couple of callbacks that can be used to
   solve this - I think pcs_disable() is the one you want, which will
   be called when we switch to a mode where _this_ PCS will no longer
   be used (thus you can reset mpcs->interface to _NA, ready for when
   it is next brought into use.)

Would that work for you?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
