Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2507F7E1D84
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjKFJwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFJw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:52:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D601DB;
        Mon,  6 Nov 2023 01:52:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9165C433C8;
        Mon,  6 Nov 2023 09:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699264345;
        bh=E4/L+LlFjPb2WwOsFdRog7Iics6lqBe9DHzObFZjQaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T1m8kRbWZJn7jsk5RLHokR9jTw6xjTC7WAG3HzgnbzkI4rIjkbPbBe1xbsxTjC9ZG
         bQD/OVdd2XWQfDScwPip752ciLnUAU9sTG4Nag+Il9hHmCU9wx92SirzX93CcAldqe
         Q19vK4kZHziaINx+dpu1dRcaB6bAsL0Wdf4KQjiwM5zUMYDkShQatGQ5LnsMqpHI7E
         666nsBMFCYw/naCOjZzJQbS2kPc6WDZs+la98bV6LFiUl6gf63uKDyxU8LB7HPsm8C
         sG78jW0v8g6Kqw8NETlTVsiq0OCadkK47lKKpiQX3RgqkfhO4TpWxYkYUsiKenry3/
         M0sR8hlOWTbGA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qzwIA-0007JB-2C;
        Mon, 06 Nov 2023 10:53:10 +0100
Date:   Mon, 6 Nov 2023 10:53:10 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Stanley =?utf-8?B?Q2hhbmdb5piM6IKy5b63XQ==?= 
        <stanley_chang@realtek.com>
Cc:     Stefan Eichenberger <eichest@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH] USB: xhci-plat: fix legacy PHY double inity
Message-ID: <ZUi3hrDbseJbIsWZ@hovoldconsulting.com>
References: <20231103164323.14294-1-johan+linaro@kernel.org>
 <ZUY8cGrofUtPOMV8@eichest-laptop>
 <5a493e6fedb449bc93f83f31a682e5b9@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a493e6fedb449bc93f83f31a682e5b9@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 06:53:23AM +0000, Stanley Chang[昌育德] wrote:
> > > On Fri, Nov 03, 2023 at 05:43:23PM +0100, Johan Hovold wrote:
> > > > Commits 7b8ef22ea547 ("usb: xhci: plat: Add USB phy support") and
> > > > 9134c1fd0503 ("usb: xhci: plat: Add USB 3.0 phy support") added
> > > > support for looking up legacy PHYs from the sysdev devicetree node
> > > > and initialising them.
> > > >
> > > > This broke drivers such as dwc3 which manages PHYs themself as the
> > > > PHYs would now be initialised twice, something which specifically
> > > > can lead to resources being left enabled during suspend (e.g. with
> > > > the usb_phy_generic PHY driver).
> > > >
> > > > As the dwc3 driver uses driver-name matching for the xhci platform
> > > > device, fix this by only looking up and initialising PHYs for
> > > > devices that have been matched using OF.

> > Tested-by: Stanley Chang <stanley_chang@realtek.com>

> I am sorry to notify you this patch is tested fail.

Hmm. Thanks for testing.

> I test the Realtek phy driver at drivers/phy/Realtek/phy-rtk-usb2.c again.
> But I can't get the phy in xhci.

> It is a dwc3 generic phy driver, and it is also a usb phy driver. 

That sounds broken (i.e. to be relying on both frameworks), but indeed
that seems to be the current state of the generic and legacy USB PHY
implementations.

What a mess.

> Base on you modified, I can't run on callback 
> rtk_phy->phy.notify_port_status = rtk_phy_notify_port_status;

Which dwc3 driver are you using? Unless I'm missing something this would
not be an issue unless you are doing something crazy like describing the
same PHY twice in the devicetree (i.e. both as a generic and legacy
PHY).

Apparently, there are no in-tree users of this particular realtek PHY so
I can't check the devicetree, but we do have other instances of such
abuse since at least a decade:

	6747caa76cab ("usb: phy: twl4030: use the new generic PHY framework")

And, yes, then this is sort of expected. The dwc3 driver has always
managed its own PHYs, but functionality has now been bolted on top so
that people may have started relying on it being managed *also* by xhci,
well at least for notifications like the one you just added:

	a08799cf17c2 ("usb: phy: add usb phy notify port status API")

Johan
