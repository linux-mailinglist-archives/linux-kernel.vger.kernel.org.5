Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D936D7B7FC8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbjJDMvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjJDMvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:51:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D7398
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:51:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7BCC433C7;
        Wed,  4 Oct 2023 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696423902;
        bh=DWJ81lm9HCoDsSMA7UMPwROL0++RNp9iG5oEiXDUaxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Vyq+iiVtwiO5k4OStEx80RScBzFIqSrSt32GEE9UdSRcwsGRVX/Q6QCjBBJKY/63
         UomezbFgm/d4u4ALKwBsZyl46EPxDPuRRzs4FL9EjH+Q3C/8452MZVY6+wiXm3aqnw
         z/J+w41VyVP4kgB6bUi2Vh5iFSFgezBaI2lcgVC4=
Date:   Wed, 4 Oct 2023 14:51:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Buddhabhatti, Jay" <jay.buddhabhatti@amd.com>
Cc:     "Simek, Michal" <michal.simek@amd.com>,
        "Shah, Tanmay" <tanmay.shah@amd.com>,
        "Manne, Nava kishore" <nava.kishore.manne@amd.com>,
        "Levinsky, Ben" <ben.levinsky@amd.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "Shaikh, Izhar Ameer" <izhar.ameer.shaikh@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ruanjinjie@huawei.com" <ruanjinjie@huawei.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 4/6] drivers: soc: xilinx: Fix error message on SGI
 registration failure
Message-ID: <2023100441-blouse-quickness-9389@gregkh>
References: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
 <20231004094116.27128-5-jay.buddhabhatti@amd.com>
 <2023100425-chivalry-pound-78d0@gregkh>
 <DM6PR12MB4465A8A84D28A1AC444AB53C9DCBA@DM6PR12MB4465.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB4465A8A84D28A1AC444AB53C9DCBA@DM6PR12MB4465.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 12:48:25PM +0000, Buddhabhatti, Jay wrote:
> Hi Greg,
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Wednesday, October 4, 2023 5:45 PM
> > To: Buddhabhatti, Jay <jay.buddhabhatti@amd.com>
> > Cc: Simek, Michal <michal.simek@amd.com>; Shah, Tanmay
> > <tanmay.shah@amd.com>; Manne, Nava kishore
> > <nava.kishore.manne@amd.com>; Levinsky, Ben <ben.levinsky@amd.com>;
> > robh@kernel.org; dhaval.r.shah@amd.com; marex@denx.de; Shaikh, Izhar
> > Ameer <izhar.ameer.shaikh@amd.com>; arnd@arndb.de;
> > ruanjinjie@huawei.com; mathieu.poirier@linaro.org; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH v2 4/6] drivers: soc: xilinx: Fix error message on SGI
> > registration failure
> > 
> > On Wed, Oct 04, 2023 at 02:41:14AM -0700, Jay Buddhabhatti wrote:
> > > Failure to register SGI for firmware event notification is non-fatal
> > > error when feature is not supported by other modules such as Xen and
> > > TF-A. Add _info level log message for such special case.
> > >
> > > Also add XST_PM_INVALID_VERSION error code and map it to -EOPNOSUPP
> > > Linux kernel error code. If feature is not supported or EEMI API
> > > version is mismatch, firmware can return XST_PM_INVALID_VERSION = 4 or
> > > XST_PM_NO_FEATURE = 19 error code.
> > >
> > > Co-developed-by: Tanmay Shah <tanmay.shah@amd.com>
> > > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > > Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> > > ---
> > >  drivers/firmware/xilinx/zynqmp.c        | 4 +++-
> > >  drivers/soc/xilinx/xlnx_event_manager.c | 7 ++++++-
> > >  include/linux/firmware/xlnx-zynqmp.h    | 1 +
> > >  3 files changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/firmware/xilinx/zynqmp.c
> > > b/drivers/firmware/xilinx/zynqmp.c
> > > index 00ea2508f692..de09d77cf1e4 100644
> > > --- a/drivers/firmware/xilinx/zynqmp.c
> > > +++ b/drivers/firmware/xilinx/zynqmp.c
> > > @@ -92,6 +92,8 @@ static int zynqmp_pm_ret_code(u32 ret_status)
> > >  		return 0;
> > >  	case XST_PM_NO_FEATURE:
> > >  		return -ENOTSUPP;
> > > +	case XST_PM_INVALID_VERSION:
> > > +		return -EOPNOTSUPP;
> > >  	case XST_PM_NO_ACCESS:
> > >  		return -EACCES;
> > >  	case XST_PM_ABORT_SUSPEND:
> > > @@ -379,7 +381,7 @@ int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
> > >
> > >  	ret = zynqmp_pm_invoke_fn(TF_A_PM_REGISTER_SGI, sgi_num, reset,
> > 0, 0,
> > >  				  0, NULL);
> > > -	if (!ret)
> > > +	if (ret != -EOPNOTSUPP && !ret)
> > >  		return ret;
> > >
> > >  	/* try old implementation as fallback strategy if above fails */
> > > diff --git a/drivers/soc/xilinx/xlnx_event_manager.c
> > > b/drivers/soc/xilinx/xlnx_event_manager.c
> > > index 38cfc161a713..bfa5cf4a0cab 100644
> > > --- a/drivers/soc/xilinx/xlnx_event_manager.c
> > > +++ b/drivers/soc/xilinx/xlnx_event_manager.c
> > > @@ -653,7 +653,12 @@ static int xlnx_event_manager_probe(struct
> > > platform_device *pdev)
> > >
> > >  	ret = zynqmp_pm_register_sgi(sgi_num, 0);
> > >  	if (ret) {
> > > -		dev_err(&pdev->dev, "SGI %d Registration over TF-A failed with
> > %d\n", sgi_num, ret);
> > > +		if (ret == -EOPNOTSUPP)
> > > +			dev_info(&pdev->dev, "PM firmware event notification
> > not
> > > +supported\n");
> > 
> > Why is this "info"?  Why not error?
> [Jay] Because it is non-fatal error which will not cause kernel crash.

Neither do dev_err() messages :)

And something failed, this isn't just "here's some nice information", it
is "something went wrong" which should be a warning or error in my
opinion.

> > And what is userspace supposed to do with this information if it sees it?
> [Jay] This message indicates that SGI registration is not supported by other modules like TF-A or Xen. So user need to use TF-A with this support if they want to use event management driver.

So perhaps say that here too?  Otherwise how are they supposed to know
that?

thanks,

greg k-h
