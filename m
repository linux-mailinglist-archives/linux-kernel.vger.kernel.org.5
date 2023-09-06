Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A349794199
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbjIFQl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjIFQl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:41:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC451724;
        Wed,  6 Sep 2023 09:41:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DA5C433C9;
        Wed,  6 Sep 2023 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694018483;
        bh=NuL6shSLCdNL6dKxOIie4Ul+UUR6aTvMrRV22jZr+YI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rUyss/CiLvU2lC8qd0dBq6/hANwNZAvFqTENK2F1ilTAtNBuos3dFEE+haGaRblXE
         jJnDeKrJsBQPDf/8WQ76tHQJor8D5KtBtrXDEVRNpsUTBHvVm2OMpZNo96Nokirii7
         DpJ8dLr7vTrPgT1IdsJzxzx7QumGpJIucvY4AVESsrD9jRoEldlVxlhUQHX4eB2mcr
         rCv70OUTseIAR1GkvYe/44ncWfvOEdMMqUQhv8PK7Y2Llu3WAIFMUIZrcCOWaHuSDo
         ihYe4kQ9DuPUH19o1X4Vuz9TB/Lglrnp3DW3wnxPAoSdibZsuUfZrPAWfq+DjTqbv8
         1U+22gs13WgGg==
Date:   Thu, 7 Sep 2023 00:29:29 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Kenta Sato <tosainu.maple@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux Stable <stable@vger.kernel.org>
Subject: Re: usb: dwc3: some USB devices not working after 6.4.8
Message-ID: <ZPio6QD64cjJza29@xhacker>
References: <CAF1eZtsBzGb_UxOqZpNiEsk8Uk7DkqPh5AnYRRNc_kkr-tFasQ@mail.gmail.com>
 <ZPUciRLUcjDywMVS@debian.me>
 <20230906013209.jlcxluxemyg3va6l@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230906013209.jlcxluxemyg3va6l@synopsys.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 01:32:22AM +0000, Thinh Nguyen wrote:
> On Mon, Sep 04, 2023, Bagas Sanjaya wrote:
> > On Sun, Sep 03, 2023 at 09:19:13PM +0900, Kenta Sato wrote:
> > > Hi,
> > > 
> > > I am using the FriendlyElec NanoPi R4S board.
> > > When I update the kernel from 6.4.7 to 6.4.11, 6.4.13, and 6.5.1, it
> > > doesn't recognize some USB devices.
> > > 
> > > The board has two USB 3.0 ports. I connected 1) BUFFALO USB Flash Disk
> > > (high-speed) and 2) NETGEAR A6210 (SuperSpeed) to each port.
> > > 1) is often not recognized. On the other hand, 2) was working while I
> > > was testing.
> > > Regardless of whether a USB device is connected, I could see the below
> > > message on dmesg:

Hi Kenta,


Besides the comments and patch from Thinh, may I know some details of 
your HW and SW env? Such as

From HW support points of view, is the usb3.0 ports dual mode or host only?

From SW side, how do you configure the host controller? I.E set dual
mode or host only?

Lastly, did you have modifications or local patches to dwc3 driver?

Thanks in advance

> > > 
> > > [    0.740993] phy phy-ff7c0000.phy.8: phy poweron failed --> -110
> > > [    0.741585] dwc3 fe800000.usb: error -ETIMEDOUT: failed to initialize core
> > > [    0.742334] dwc3: probe of fe800000.usb failed with error -110
> > > [    0.751635] rockchip-usb2phy ff770000.syscon:usb2phy@e460:
> > > Requested PHY is disabled
> > > 
> > > Is there any idea on this?
> > > 
> > > The cause seems to be related to this commit. I tried reverting this
> > > change and the issue seemed to be solved.
> > > 
> > > >From 317d6e4c12b46bde61248ea4ab5e19f68cbd1c57 Mon Sep 17 00:00:00 2001
> > > From: Jisheng Zhang <jszhang@kernel.org>
> > > Date: Wed, 28 Jun 2023 00:20:18 +0800
> > > Subject: usb: dwc3: don't reset device side if dwc3 was configured as
> > >  host-only
> > > 
> > > commit e835c0a4e23c38531dcee5ef77e8d1cf462658c7 upstream.
> > > 
> > > Commit c4a5153e87fd ("usb: dwc3: core: Power-off core/PHYs on
> > > system_suspend in host mode") replaces check for HOST only dr_mode with
> > > current_dr_role. But during booting, the current_dr_role isn't
> > > initialized, thus the device side reset is always issued even if dwc3
> > > was configured as host-only. What's more, on some platforms with host
> > > only dwc3, aways issuing device side reset by accessing device register
> > > block can cause kernel panic.
> > > 
> > > Fixes: c4a5153e87fd ("usb: dwc3: core: Power-off core/PHYs on
> > > system_suspend in host mode")
> > > Cc: stable <stable@kernel.org>
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> > > Link: https://lore.kernel.org/r/20230627162018.739-1-jszhang@kernel.org
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/usb/dwc3/core.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.4.8&id=317d6e4c12b46bde61248ea4ab5e19f68cbd1c57
> > > 
> > 
> > Thanks for the regression report. I'm adding it to regzbot:
> > 
> > #regzbot ^introduced: e835c0a4e23c38
> > #regzbot title: some USB devices unrecognized caused by not resetting dwc3 device if it is host-only
> > 
> 
> When there's phy reconfiguration, we need follow through a soft reset
> sequence. It may be done when we pass to xHCI driver through its
> initialization of USBCMD.HCRST. However, looks like we need to do a
> soft reset before setting more core parameters in dwc3.
> 
> Can we try to just reset the phy instead to see if it helps? If not, we
> may have to teach dwc3 about xHCI's USBCMD.HCRST.
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 9c6bf054f15d..66186ef34c6d 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1104,9 +1104,42 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  	if (ret)
>  		goto err_exit_ulpi;
>  
> -	ret = dwc3_core_soft_reset(dwc);
> -	if (ret)
> -		goto err_exit_phy;
> +	/*
> +	 * Note: GUSB3PIPECTL[n] and GUSB2PHYCFG[n] are port settings where n
> +	 * is port index. If this is a multiport host, then we need to reset
> +	 * all active ports.
> +	 */
> +	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
> +	reg |= DWC3_GUSB3PIPECTL_PHYSOFTRST;
> +	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
> +
> +	/*
> +	 * Must meet usb3 phy reset assertion timing,
> +	 * should be much less than 20ms.
> +	 */
> +	msleep(20);
> +
> +	reg &= ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
> +	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
> +
> +	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> +	reg |= DWC3_GUSB2PHYCFG_PHYSOFTRST;
> +	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> +
> +	/*
> +	 * Must meet usb2 phy reset assertion timing,
> +	 * should be much less than 20ms.
> +	 */
> +	msleep(20);
> +
> +	reg &= ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
> +	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> +
> +	/*
> +	 * Some platforms may need more time to synchronize the clocks,
> +	 * 100ms should be enough for all.
> +	 */
> +	msleep(100);
>  
>  	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD &&
>  	    !DWC3_VER_IS_WITHIN(DWC3, ANY, 194A)) {
> 
> 
> --
> 
> Thanks,
> Thinh
