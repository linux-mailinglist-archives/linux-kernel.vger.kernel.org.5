Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4E07BC638
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 10:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbjJGIvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 04:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjJGIvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 04:51:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31AE9C
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 01:51:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA71C433C8;
        Sat,  7 Oct 2023 08:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696668671;
        bh=yf8uddZIn59prZZ8ljN9HxZsSPPXvgdX2rdNST+wWnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvRr67iR3iUh3JejhODVuD3lBMC3zlcQLNEfPhzYtWO2lK2A0zYDWl1pALjRIAVO7
         zCDmTV8orED5DJ8tjb9dOmIkdcKDJJoB2lo5rdidtHl+R8bzdKztCd7LhIoNMIuzoS
         6usG2HOma+5/Gtx/QVt8WhcsOCAgbi9Tuu7IDNl8=
Date:   Sat, 7 Oct 2023 10:51:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Gupta, Nipun" <nipun.gupta@amd.com>
Cc:     maz@kernel.org, tglx@linutronix.de, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com,
        srivatsa@csail.mit.edu
Subject: Re: [PATCH v4] cdx: add MSI support for CDX bus
Message-ID: <2023100705-tummy-salami-477e@gregkh>
References: <20230911135259.14046-1-nipun.gupta@amd.com>
 <2023100531-matron-oversold-4a73@gregkh>
 <5388fa5c-a4e7-6a51-c363-1a0da75b163a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5388fa5c-a4e7-6a51-c363-1a0da75b163a@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 02:13:15PM +0530, Gupta, Nipun wrote:
> 
> 
> On 10/5/2023 3:54 PM, Greg KH wrote:
> > On Mon, Sep 11, 2023 at 07:22:59PM +0530, Nipun Gupta wrote:
> > > Add CDX-MSI domain per CDX controller with gic-its domain as
> > > a parent, to support MSI for CDX devices. CDX devices allocate
> > > MSIs from the CDX domain. Also, introduce APIs to alloc and free
> > > IRQs for CDX domain.
> > > 
> > > In CDX subsystem firmware is a controller for all devices and
> > > their configuration. CDX bus controller sends all the write_msi_msg
> > > commands to firmware running on RPU and the firmware interfaces with
> > > actual devices to pass this information to devices
> > > 
> > > Since, CDX controller is the only way to communicate with the Firmware
> > > for MSI write info, CDX domain per controller required in contrast to
> > > having a CDX domain per device.
> > > 
> > > Co-developed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> > > Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> > > Co-developed-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > > Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> > > Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> > > ---
> > > 
> > > Changes v3->v4:
> > > - Rebased on Linux 6.6-rc1
> > > 
> > > Changes v2->v3:
> > > - Rebased on Linux 6.5-rc1
> > > - Used FW provided 'msi_dev_id' as device ID for GIC instead of 'req_id'.
> > > 
> > > Changes v1->v2:
> > > - fixed scenario where msi write was called asyncronously in
> > >    an atomic context, by using irq_chip_(un)lock, and using sync
> > >    MCDI API for write MSI message.
> > > - fixed broken Signed-off-by chain.
> > > 
> > >   drivers/cdx/Kconfig                     |   1 +
> > >   drivers/cdx/Makefile                    |   2 +-
> > >   drivers/cdx/cdx.c                       |   9 ++
> > >   drivers/cdx/cdx.h                       |  12 ++
> > >   drivers/cdx/cdx_msi.c                   | 183 ++++++++++++++++++++++++
> > >   drivers/cdx/controller/cdx_controller.c |  23 +++
> > >   drivers/cdx/controller/mc_cdx_pcol.h    |  64 +++++++++
> > >   drivers/cdx/controller/mcdi_functions.c |  26 +++-
> > >   drivers/cdx/controller/mcdi_functions.h |  20 +++
> > >   include/linux/cdx/cdx_bus.h             |  32 +++++
> > >   kernel/irq/msi.c                        |   1 +
> > >   11 files changed, 370 insertions(+), 3 deletions(-)
> > >   create mode 100644 drivers/cdx/cdx_msi.c
> > > 
> > > diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
> > > index a08958485e31..86df7ccb76bb 100644
> > > --- a/drivers/cdx/Kconfig
> > > +++ b/drivers/cdx/Kconfig
> > > @@ -8,6 +8,7 @@
> > >   config CDX_BUS
> > >   	bool "CDX Bus driver"
> > >   	depends on OF && ARM64
> > > +	select GENERIC_MSI_IRQ_DOMAIN
> > 
> > This config option isn't in my tree anywhere, where did it come from?
> > What is it supposed to do?
> > 
> > >   	help
> > >   	  Driver to enable Composable DMA Transfer(CDX) Bus. CDX bus
> > >   	  exposes Fabric devices which uses composable DMA IP to the
> > > diff --git a/drivers/cdx/Makefile b/drivers/cdx/Makefile
> > > index 0324e4914f6e..4bad79d1d188 100644
> > > --- a/drivers/cdx/Makefile
> > > +++ b/drivers/cdx/Makefile
> > > @@ -5,4 +5,4 @@
> > >   # Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
> > >   #
> > > -obj-$(CONFIG_CDX_BUS) += cdx.o controller/
> > > +obj-$(CONFIG_CDX_BUS) += cdx.o cdx_msi.o controller/
> > 
> > So you are always building this in even if the build doesn't support
> > MSI?  Why will that not break the build?
> 
> CDX bus will select GENERIC_MSI_IRQ, so I think we can have this only with
> CONFIG_CDX_BUS?

As CDX works today without MSI, why are you adding this requirement to
the codebase forcing everyone to have it?

> > > +struct cdx_msi_config {
> > > +	u16 msi_index;
> > > +	u32 data;
> > > +	u64 addr;
> > > +};
> > 
> > Are you ok with the "hole" in this structure?
> 
> This is only a software placeholder for information to be passed to hardware
> in a different message format (using MCDI).

Great, then how about reording things so there isn't a hole?

thanks,

greg k-h
