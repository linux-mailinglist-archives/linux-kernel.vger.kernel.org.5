Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1508C7B4B5E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbjJBGUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjJBGUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:20:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A7D9B
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 23:20:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94388C433C8;
        Mon,  2 Oct 2023 06:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696227605;
        bh=ElcpeFJ4rQlE/UqOnsiI3Q6ToiIE7LPVEWkn8Ad4mt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qDyzZZgLha+p/d15wqstnjR/o7FwtLnd5ypq8ozgUJ6E+EMoXB6L6l45zXDCRKwdP
         sXDoPqv05E8NwgH0Brp5BuyyIASbQ2mCJyQKrcZVAdSSOYIUuseQrNCpvCj1C9inh2
         EBvwCgF8csZC9z+b+1asYi7LLnlOgheZzK6iHBEc=
Date:   Mon, 2 Oct 2023 08:20:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Jay Buddhabhatti <jay.buddhabhatti@amd.com>, tanmay.shah@amd.com,
        sai.krishna.potthuri@amd.com, nava.kishore.manne@amd.com,
        ben.levinsky@amd.com, dhaval.r.shah@amd.com, marex@denx.de,
        robh@kernel.org, arnd@arndb.de, izhar.ameer.shaikh@amd.com,
        ruanjinjie@huawei.com, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/7] drivers: soc: xilinx: add check for platform
Message-ID: <2023100223-trouble-conjoined-fb51@gregkh>
References: <20230929105558.11893-1-jay.buddhabhatti@amd.com>
 <20230929105558.11893-4-jay.buddhabhatti@amd.com>
 <2023093034-spiny-diagnoses-3da7@gregkh>
 <1a38b6bf-00ef-4ada-a9a7-8dff5c3a1934@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a38b6bf-00ef-4ada-a9a7-8dff5c3a1934@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 08:09:50AM +0200, Michal Simek wrote:
> 
> 
> On 9/30/23 09:17, Greg KH wrote:
> > On Fri, Sep 29, 2023 at 03:55:54AM -0700, Jay Buddhabhatti wrote:
> > > Some error event IDs for Versal and Versal NET are different.
> > > Both the platforms should access their respective error event
> > > IDs so use sub_family_code to check for platform and check
> > > error IDs for respective platforms. The family code is passed
> > > via platform data to avoid platform detection again.
> > > Platform data is setup when even driver is registered.
> > > 
> > > Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> > > ---
> > >   drivers/firmware/xilinx/zynqmp.c        |  2 +-
> > >   drivers/soc/xilinx/xlnx_event_manager.c | 25 ++++++++++++++++++++-----
> > >   include/linux/firmware/xlnx-zynqmp.h    | 16 ++++++++++++----
> > >   3 files changed, 33 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> > > index 5f40288f69a9..6583efa9ac48 100644
> > > --- a/drivers/firmware/xilinx/zynqmp.c
> > > +++ b/drivers/firmware/xilinx/zynqmp.c
> > > @@ -2019,7 +2019,7 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
> > >   	np = of_find_compatible_node(NULL, NULL, "xlnx,versal");
> > >   	if (np) {
> > >   		em_dev = platform_device_register_data(&pdev->dev, "xlnx_event_manager",
> > > -						       -1, NULL, 0);
> > > +						       -1, &pm_sub_family_code, 4);
> > >   		if (IS_ERR(em_dev))
> > >   			dev_err_probe(&pdev->dev, PTR_ERR(em_dev), "EM register fail with error\n");
> > >   	}
> > > diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
> > > index 38cfc161a713..8074ded7b39c 100644
> > > --- a/drivers/soc/xilinx/xlnx_event_manager.c
> > > +++ b/drivers/soc/xilinx/xlnx_event_manager.c
> > > @@ -23,6 +23,7 @@ static DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number1);
> > >   static int virq_sgi;
> > >   static int event_manager_availability = -EACCES;
> > > +static u32 pm_sub_family_code;
> > 
> > Why is this not a per-device variable?  Global variables like this for
> > drivers are almost always wrong.
> 
> Not sure I get what you mean by per-device. Can you please elaborate on it?

It should not be a global variable (i.e. the same for all devices in the
system.)

> This is the part of firmware infrastructure and there is only one instance
> of the driver in the system registered from firmware driver itself.

Then that should be fixed.

> If this should be done in a generic way then there are much more variables
> which should be moved to driver data not just this one.

Agreed, they should all be moved there.

thanks,

greg k-h
