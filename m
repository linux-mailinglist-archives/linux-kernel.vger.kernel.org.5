Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2230A76AB39
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjHAIkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjHAIkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:40:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB1F10E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:40:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E768561499
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D055AC433C8;
        Tue,  1 Aug 2023 08:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690879241;
        bh=ZvBLYBeZn76K2qP99PMw2nICTG1lNnfIlsFyKhUr5UM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kx/FFC3qDDaNoUrqn9xHxCVzKxLdSVnJLGuQZUKVeiRUrn2FarZIOv0XcethkOSrR
         OTd2S/rYLXNpV5yJaFerwWZ2VAUckLe5vt9L/rIfNFKsaocXeFuEHcsfk2cKuCjmvw
         tgF0jXzmLBMeHU9dzfGZ05hUXwZ3A21EbL6MA0H4=
Date:   Tue, 1 Aug 2023 10:40:38 +0200
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
Message-ID: <2023080105-eggnog-probably-9ff3@gregkh>
References: <20230731120813.123247-1-abhijit.gangurde@amd.com>
 <20230731120813.123247-2-abhijit.gangurde@amd.com>
 <2023073148-carried-unshaved-77e4@gregkh>
 <DM4PR12MB7765398763E00B565AB1C6DB8F0AA@DM4PR12MB7765.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB7765398763E00B565AB1C6DB8F0AA@DM4PR12MB7765.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 08:34:00AM +0000, Gangurde, Abhijit wrote:
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Monday, July 31, 2023 5:55 PM
> > To: Gangurde, Abhijit <abhijit.gangurde@amd.com>
> > Cc: masahiroy@kernel.org; linux-kernel@vger.kernel.org; Simek, Michal
> > <michal.simek@amd.com>; git (AMD-Xilinx) <git@amd.com>; Agarwal, Nikhil
> > <nikhil.agarwal@amd.com>; Gupta, Nipun <Nipun.Gupta@amd.com>
> > Subject: Re: [PATCH v2 1/4] cdx: Introduce lock to protect controller ops and
> > controller list
> > 
> > On Mon, Jul 31, 2023 at 05:38:10PM +0530, Abhijit Gangurde wrote:
> > > Add a mutex lock to prevent race between controller ops initiated by
> > > the bus subsystem and the controller registration/unregistration.
> > >
> > > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > > ---
> > >  drivers/cdx/cdx.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> > > index d2cad4c670a0..66797c8fe400 100644
> > > --- a/drivers/cdx/cdx.c
> > > +++ b/drivers/cdx/cdx.c
> > > @@ -72,6 +72,8 @@
> > >
> > >  /* CDX controllers registered with the CDX bus */
> > >  static DEFINE_XARRAY_ALLOC(cdx_controllers);
> > > +/* Lock to protect controller ops and controller list */
> > > +static DEFINE_MUTEX(cdx_controller_lock);
> > 
> > Wait, why do you have a local list and not just rely on the list the
> > driver core has for you already?  Isn't this a duplicate list where you
> > have objects on two different lists with a lifespan controlled only by
> > one of them?
> 
> cdx_controllers list is holding just the controllers registered on the cdx bus system.

Which are devices on the bus, so why do you need a separate list?

> CDX devices are still maintained by driver core list. Controller list is used by rescan
> which triggers rescan on all the controllers.

Again, why a separate list?  The driver core already tracks these,
right?

thanks,

greg k-h
