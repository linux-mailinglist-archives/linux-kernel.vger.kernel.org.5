Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374737C0134
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjJJQI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjJJQIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:08:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA50F110;
        Tue, 10 Oct 2023 09:08:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA565C433C7;
        Tue, 10 Oct 2023 16:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696954086;
        bh=KeboIcJegdKGvMa6Bdc3IgQt8LK861hniGvhLYLpqeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mZMHZz41VdyjdmFJpKcLz2EEZvHlx4Z9LA2pJehim9MLOLhg6kkrINVF9J6vzSmOk
         HbXqrRPwaypoxLnBVShLaD0toSlbeQXrF/mE76gYBGhZSXyr0xHI8nmruzeruhYdCO
         56KXqPQ1BW9934Bs6hP2iRH6tsmd/aFPZPZfA1Wg=
Date:   Tue, 10 Oct 2023 18:08:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Jakub Kicinski <kuba@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        "David S. Miller" <davem@davemloft.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
Message-ID: <2023101051-unmasked-cleaver-79b3@gregkh>
References: <20231010155444.858483-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010155444.858483-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 05:27:29PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> While looking at the old drivers using the obsolete .ndo_do_ioctl()
> callback, I found a number of network drivers that are especially
> obsolete, in particular for 802.11b (11Mbit/s) or even older wireless
> networks, using non-busmaster ISA/PCMCIA style bus interfaces, and using
> the legacy wireless extension ioctls rather than the netlink interfaces
> that were meant to replace them in 2007. All of these drivers are
> obsolete or orphaned.
> 
> We had previously discussed this topic, but nobody ever moved the
> files, so I now went through the list to my best knowledge. These
> are the drivers that I would classify as "probably unused" by now:
> 
>  - Atmel at76c502/at76c504/at76c506 is a PIO-only (PCMCIA, mini-PCI
>    and Cardbus) 802.11b driver with incomplete CFG80211 support.
>    The related at76c50x USB driver uses MAC80211 and remains.
> 
>  - Cisco Aironet is an 802.11b PCMCIA and mini-PCI with limited support
>    for Cardbus DMA and for CFG80211.
> 
>  - HostAP is an ISA/PCMCIA style 802.11b driver supporting only
>    wireless extensions, and some custom ioctls (already removed).
>    Some devices include a legacy PCI bridge but no DMA.
> 
>  - Aviator/Raytheon is an early PCMCIA driver, apparently predating
>    802.11b and only supporting wireless extensions.
> 
>  - Planet WL3501 is another PCMCIA driver for pre-802.11b interfaces
>    (2Mbit/s) with incomplete CFG80211 support
> 
>  - Zydas zd1201 is a USB 802.11b driver with limited support for
>    CFG80211.
> 
>  - Orinoco is a PIO-only ISA/PCMCIA 802.11b device with extra bus
>    interface connections for PCI/Cardbus/mini-PCI and a few
>    pre-2002 Apple PowerMac variants. It supports both
>    wireless extensions and CFG80211, but I could not tell if
>    it requires using both.
> 
>  - Wireless RNDIS USB is a new-style CFG80211 driver for 802.11b
>    and 802.11g USB hardware from around 2004 to 2006. This makes it
>    more modern than any of the others, but Kalle already classified
>    it as "legacy" in commit 298e50ad8eb8f ("wifi: move raycs, wl3501
>    and rndis_wlan to legacy directory"), so it stays with ray_cs and
>    wl3501_cs.
> 
> There are a few other drivers that are similar to these but that are
> more likely to still be needed, and are not moved here:
> 
>  - Intel ipw2x00 is a PCI bus-master device for 802.11a/b/g that was
>    popular in "Centrino" branded laptops from 2003 to 2005, but it
>    still requires wireless extensions.
> 
>  - Marvell Libertas is an 802.11a/b/g device with a number of bus
>    interfaces (USB, SDIO, SPI, PCMCIA) and incomplete CFG80211
>    support. This one was used in the OLPC XO laptop and some other
>    embedded devices that are still supported.
> 
>  - Some broadcom b43xx devices use the SSB bus that can be abstracted
>    through PCMCIA. All of them use CFG80211.
> 
>  - The Sony Playstation 3 "gelic" ethernet driver contains a bridge
>    and an 802.11b/g client chip that is controlled through a hypervisor
>    interface from the OS, and it uses wireless extensions in the kernel
>    driver.
> 
> Link: https://lore.kernel.org/all/87imaeg4ar.fsf@codeaurora.org/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Stuff in drivers/staging/ is to get code _into_ the main portion of the
kernel tree, not out.  If these aren't being used, let's just drop them
entirely.

What is the need to have them move to staging, only to have me delete
them in the next release after that (or after that?)  Why delay and why
not just remove them now?

thanks,

greg k-h
