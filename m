Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9ED7E1BD0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjKFIUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjKFIUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:20:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC49B0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:20:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19772C433C7;
        Mon,  6 Nov 2023 08:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699258804;
        bh=nPH/BnrNNKYu+SnYLgUUWF6lghiewNMl8ubSLajK9IM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lZIQMuJv3NM7DJO00UHZQll5WzsWNG2Gg4AjU1lM3QElF+mcuSYkt4W6dOkvN8AN9
         r0x1iiDHpbuF26CFVKL6sq3G41WlTzyCgOWF9g2hp2l0k+sbbzd7sYgyBNDhXltvOv
         EFPVGOlKSc8I05cEM6kAGZoX4hh6D6+92WkGUcOdwOnX9oXh6autCiM55zflO/6Yvi
         6wjvOIHtVV609AD+hO3KrD+Gx6SdB1m5bx4CeOOUrmzkUt+dW1lKNWlsCrJxYAV/2p
         ffPhrv1udeFM425zU0tG5gcJ05EgzST4v29c1WhdL2/3edgP6/dKEj5YWdGi6N6onB
         DfDMNVBG56DLQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qzuqm-0006gp-2p;
        Mon, 06 Nov 2023 09:20:48 +0100
Date:   Mon, 6 Nov 2023 09:20:48 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1] USB: dwc3: only call usb_phy_set_suspend in
 suspend/resume
Message-ID: <ZUih4BJLkslLIMx5@hovoldconsulting.com>
References: <20231103102236.13656-1-francesco@dolcini.it>
 <ZUUkqeKFZmsubxu5@hovoldconsulting.com>
 <GV0P278MB0589921FFF5487D2F94D3FF2E8A4A@GV0P278MB0589.CHEP278.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV0P278MB0589921FFF5487D2F94D3FF2E8A4A@GV0P278MB0589.CHEP278.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 11:51:22AM +0000, Stefan Eichenberger wrote:
> > From: Johan Hovold <johan@kernel.org>

> > When reviewing the driver I did find a bug in the xhci-plat driver which
> > is likely the cause for the imbalance you're seeing. I just sent a fix
> > here in case you want to give it a try:
> > 
> >         https://lore.kernel.org/lkml/20231103164323.14294-1-johan+linaro@kernel.org/
> 
> I tested it and it solves the issue we have. Thanks a lot for the fix!
> Before the use count for our regulator always went up to 2 and now it is
> 1 as expected.
> root@verdin-imx8mp-14773241:~# cat /sys/kernel/debug/regulator/CTRL_SLEEP_MOCI#/use_count
> 1
> 
> Also when going to suspend the regulator is turned off now. With the
> suspend patch applied from us the use count will be one more but
> everything still works as expected.

Thanks for testing.

> > But, also, why are you using legacy PHYs? Which platform is this for?
> 
> We have an external hub that we want to turn off when the system goes
> into suspend. For the i.MX8MM we use the phy-generic driver to achieve
> this. When I saw that the dwc3 driver would support the phy-generic via
> usb-phy, I thought we could use the same approach for the i.MX8MP and,
> in the future, the AM62. Maybe I misunderstood, would the right solution
> be to add a suspend function to the fsl,imx8mp-usb-phy driver and use
> vbus instead? But what would we do for the AM62, as it doesn't have a
> phy driver if I'm not mistaken.

That's not how the phy driver is supposed be used, and for on-board hubs
we now have:

	drivers/usb/misc/onboard_usb_hub.c

Have you tried using that one instead?

Johan
