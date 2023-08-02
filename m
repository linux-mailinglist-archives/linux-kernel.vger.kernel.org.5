Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC88C76CC04
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjHBLto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjHBLtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:49:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3AE213D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:49:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6283C617EB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 11:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D376C433C7;
        Wed,  2 Aug 2023 11:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690976980;
        bh=uOn9RuTDIEoQbhKM1cMTtse7LNSQysB3r5STcL+YrKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fXuPFgTMxBvjOmWi70DAIbMAnIjFglro0kN3ExW/jqXSiOxqUxFVn79dL8AHyICC5
         pzXkqs9IYwjS04yctiN0+1CyZ4n6wpsBfSgS9ltYl0DM+/bl1skWeD3hEssDbMW0Hk
         loHKvw+XYqb44soUIMP60OAmiBKJ+ED0vBieoM68=
Date:   Wed, 2 Aug 2023 13:49:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
Cc:     "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>
Subject: Re: [PATCH v2 1/4] cdx: Introduce lock to protect controller ops and
 controller list
Message-ID: <2023080233-nag-animal-a905@gregkh>
References: <20230731120813.123247-1-abhijit.gangurde@amd.com>
 <20230731120813.123247-2-abhijit.gangurde@amd.com>
 <2023073148-carried-unshaved-77e4@gregkh>
 <DM4PR12MB7765398763E00B565AB1C6DB8F0AA@DM4PR12MB7765.namprd12.prod.outlook.com>
 <2023080105-eggnog-probably-9ff3@gregkh>
 <DM4PR12MB7765B6284FD9BC113C8482FC8F0BA@DM4PR12MB7765.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB7765B6284FD9BC113C8482FC8F0BA@DM4PR12MB7765.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 11:20:17AM +0000, Gangurde, Abhijit wrote:
> > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > Sent: Monday, July 31, 2023 5:55 PM
> > > > To: Gangurde, Abhijit <abhijit.gangurde@amd.com>
> > > > Cc: masahiroy@kernel.org; linux-kernel@vger.kernel.org; Simek, Michal
> > > > <michal.simek@amd.com>; git (AMD-Xilinx) <git@amd.com>; Agarwal,
> > Nikhil
> > > > <nikhil.agarwal@amd.com>; Gupta, Nipun <Nipun.Gupta@amd.com>
> > > > Subject: Re: [PATCH v2 1/4] cdx: Introduce lock to protect controller ops
> > and
> > > > controller list
> > > >
> > > > On Mon, Jul 31, 2023 at 05:38:10PM +0530, Abhijit Gangurde wrote:
> > > > > Add a mutex lock to prevent race between controller ops initiated by
> > > > > the bus subsystem and the controller registration/unregistration.
> > > > >
> > > > > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > > > > ---
> > > > >  drivers/cdx/cdx.c | 14 ++++++++++++++
> > > > >  1 file changed, 14 insertions(+)
> > > > >
> > > > > diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> > > > > index d2cad4c670a0..66797c8fe400 100644
> > > > > --- a/drivers/cdx/cdx.c
> > > > > +++ b/drivers/cdx/cdx.c
> > > > > @@ -72,6 +72,8 @@
> > > > >
> > > > >  /* CDX controllers registered with the CDX bus */
> > > > >  static DEFINE_XARRAY_ALLOC(cdx_controllers);
> > > > > +/* Lock to protect controller ops and controller list */
> > > > > +static DEFINE_MUTEX(cdx_controller_lock);
> > > >
> > > > Wait, why do you have a local list and not just rely on the list the
> > > > driver core has for you already?  Isn't this a duplicate list where you
> > > > have objects on two different lists with a lifespan controlled only by
> > > > one of them?
> > >
> > > cdx_controllers list is holding just the controllers registered on the cdx bus
> > system.
> > 
> > Which are devices on the bus, so why do you need a separate list?
> > 
> > > CDX devices are still maintained by driver core list. Controller list is used by
> > rescan
> > > which triggers rescan on all the controllers.
> > 
> > Again, why a separate list?  The driver core already tracks these,
> > right?
> 
> As of now, cdx controllers are platform devices and maintained on cdx_controllers list.

Oh, that's not ok.  Please do NOT abuse platform devices for things that
are not actually platform devices.  Make them real devices on a real
bus.

> CDX controller devices are not added on cdx bus. IIUC, you mean to use driver core
> list to find out different cdx controllers, in that case cdx bus would need to scan 
> platform bus and access the private data of platform device to get a cdx_controller ops.
> IMHO, that would not be a right approach.

If these are actually real patform devices, then yes, that's the correct
thing to do.

Or you can create a cdx controller device and add that to the device
tree, that's usually the way "controller" devices work (look at USB host
controllers as one example.)

> Or as an alternative cdx controller could be added on cdx bus as well. And we can then
> get these controllers from driver core list.

Yes, that can work too, but don't keep them outside of the driver model,
that will not work well over time, as you can see here already.

thanks,

greg k-h
