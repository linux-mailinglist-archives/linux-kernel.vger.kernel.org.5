Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04943773300
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 00:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjHGWgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 18:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHGWgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:36:40 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC74F0;
        Mon,  7 Aug 2023 15:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vCo6mzv/6KzsiJLKEnyKjWfdixrO4ystW67tX4HhrOg=; b=N9kDJ3oHekpUy0kQiCa21v5OEc
        3rv43ZEU5Kn+zXj3KdP5tzzMGyKP1xZyaIUwwhzqBWin3rvlVxaz2o3/QnQn4lixdtV8kREziyc4k
        8BXLeTgCR+0p6W+2IKDtbTx4ee1kr7ly9lTVnFqG/hOXvI0UIPYjfAY5yqx8okjeLGRnn2G4njC+f
        dHZBRoR/IulcJOP8HIG8hZiQPMsM2YnkD27vwoxXVnphaRg9Zogqf6ZfZ75mUXhjjLO1TBg7JtQgx
        ozlJwGCePAMK+14VLf2wl0mF0c+xohBOUyQ+KZrOgMOSMM9Srshqp0XkH7v+im1AooBZTosBoGOsO
        Uw04+fZQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33176)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qT8py-0005qB-0q;
        Mon, 07 Aug 2023 23:36:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qT8pw-0007Q6-Bf; Mon, 07 Aug 2023 23:36:28 +0100
Date:   Mon, 7 Aug 2023 23:36:28 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        andrew@lunn.ch, alex@shruggie.ro
Subject: Re: [PATCH] rtc: armada38x: remove unneeded call to
 platform_set_drvdata()
Message-ID: <ZNFx7FfmmrMMZdmv@shell.armlinux.org.uk>
References: <20230807124811.16763-1-aboutphysycs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807124811.16763-1-aboutphysycs@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 03:48:11PM +0300, Andrei Coardos wrote:
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Also,
> the private data is defined in this driver, so there is no risk of it being
> accessed outside of this driver file.

I hope you're not going about doing this _broken_ thing and thinking
"if there's no platform_get_drvdata(), then there shouldn't be any
platform_set_drvdata()" because that is WRONG. Wrong wrong wrong wrong
wrong.

	platform_set_drvdata(pdev, foo);

sets the driver data on dev, and is basically implemented as:

	dev_set_drvdata(&pdev->dev, foo);

So, to access the driver data, one can either use:

	platform_get_drvdata(pdev)

or:

	dev_get_drvdata(dev)

where one is dealing with a "struct device" pointer. So, the lack of
any platform_get_drvdata() does *NOT* mean that platform_set_drvdata()
can be removed.

If that's what you've been doing, you are *creating* bugs - and you
need to stop until you properly understand what you are doing.

Thanks anyway, but... your change is totally wrong and will wreck the
driver, causing it to oops the kernel.

Strong and definite NAK.

I do *NOT* expect to ever see a patch like this again for this driver.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
