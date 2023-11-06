Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31CC7E1EA6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjKFKlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFKlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:41:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EA394;
        Mon,  6 Nov 2023 02:41:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3C9C433CA;
        Mon,  6 Nov 2023 10:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699267299;
        bh=lk8OemT9/Tgr+wb+H9H8Ru9jGjmNq1ECVgVrgWwjRKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHr3gpay05l0pR9JDb6GN4xWET2ibO4tePjLzVjoy7VBgkofIN/GYBk20sRJO8v4H
         4kqwBlYtW6N9IyJtDRhdts7ZpvEhQBlEgVih8kdUfZLcpeYuYxj/fFIWGa6cHB/Kow
         jl7Z9jzMn9oqsegxvKXAt0XQh8oKm83Bl6j+6zkJ2LKpGbsyMvUlq0UkNiEwB+0KGL
         djZ9E/vIfSTuBHBEnst0GlNmJoeTb1Bd+cVNY3hPTa9YYzeXSphsyI8bKOHAhB2oAZ
         f5LdWATM81YEfJurRJ41cRpmdK/5U90hJ+4IeL0H6luEQzqJZljHEZpsdWm7ausbci
         WHXihgwy9zK7w==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qzx3o-0007op-1L;
        Mon, 06 Nov 2023 11:42:25 +0100
Date:   Mon, 6 Nov 2023 11:42:24 +0100
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
Message-ID: <ZUjDEC9M7zTsXIRp@hovoldconsulting.com>
References: <20231103164323.14294-1-johan+linaro@kernel.org>
 <ZUY8cGrofUtPOMV8@eichest-laptop>
 <5a493e6fedb449bc93f83f31a682e5b9@realtek.com>
 <ZUi3hrDbseJbIsWZ@hovoldconsulting.com>
 <b2f3db01ad7d43dbbb8ee11cfd1346ea@realtek.com>
 <ZUi9dgnvBT5f6wzo@hovoldconsulting.com>
 <bafbd60ac8134a0782a7ee27c01971ea@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bafbd60ac8134a0782a7ee27c01971ea@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 10:37:06AM +0000, Stanley Chang[昌育德] wrote:

> > > I use drivers/usb/dwc3/core.c and drivers/usb/dwc3/dwc3-rtk.c I
> > > describe the PHY as generic and legacy PHY in device tree.
> > 
> > That's not right. You should just use the generic PHY binding for new platforms.
> > 
> > > Our driver needs the API base on a08799cf17c2 ("usb: phy: add usb phy
> > notify port status API").
> > > But generic PHY driver is not support this.
> > 
> > Yes, but you added that interface yourself, and that I think merging that was a
> > mistake.
> > 
> > We should not be building functionality on top of the legacy USB PHY
> > implementation which is stuck in some transitional limbo.
> > 
> > Apparently, your PHY drivers which were merged for 6.6 are the only users of
> > this interface, and there are no upstream devicetrees that use these PHYs.
> > 
> > I think we should revert this mess before we dig ourselves into an even deeper
> > hole.
> 
> This is an interim method, as the current generic PHY framework does
> not support special operations on USB PHY.

Then you need to add that.

You can't add a new interface which is broken by design and can't be
used unless you abuse the devicetree and describe your PHYs using *both*
the generic 'phy' property and the *deprecated* 'usb-phy' property.

That's just broken.

> Now the generic PHY can't instead USB PHY in this stage.
> For example,
> drivers/phy/ti/phy-twl4030-usb.c
> drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
> drivers/phy/ti/phy-omap-usb2.c

These should be fixed as well eventually.

Johan
