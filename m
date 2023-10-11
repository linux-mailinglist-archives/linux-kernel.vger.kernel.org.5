Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C267C57FB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjJKPXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjJKPXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:23:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB5698
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:23:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6320FC433C8;
        Wed, 11 Oct 2023 15:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697037809;
        bh=BQxbIoojRe7a+bdZcSee42aOrgRqHMWTJxldHf0gZ+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPAaP+HrInoey5eLi2YaVM/Cx66vS9WlfjCQ3GUcBWE1G0YFCn6U9AHa6eSpoDduf
         wcmkV+Q4HTNuuqvv/ACv3QETWng9l3PdR1MCCIClkiPHEVL8ZMX945mJ2sL48gqyR4
         nu+Bn7YlFOqP1vK2or5gBbKvPuc1+qdPIjOBGZJU=
Date:   Wed, 11 Oct 2023 17:23:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc:     mathias.nyman@intel.com, stern@rowland.harvard.edu,
        yangyingliang@huawei.com, jinpu.wang@ionos.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        erosca@de.adit-jv.com
Subject: Re: [PATCH v3] usb: core: hub: Add quirks for reducing device
 address timeout
Message-ID: <2023101155-unframed-satirical-f7ec@gregkh>
References: <6b26db15-89a0-d455-5740-9abb1befa3a8@intel.com>
 <20231011085011.89198-1-hgajjar@de.adit-jv.com>
 <2023101117-colonize-jovial-893f@gregkh>
 <20231011120535.GA89684@vmlxhi-118.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011120535.GA89684@vmlxhi-118.adit-jv.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 02:05:35PM +0200, Hardik Gajjar wrote:
> On Wed, Oct 11, 2023 at 11:02:27AM +0200, Greg KH wrote:
> > On Wed, Oct 11, 2023 at 10:50:11AM +0200, Hardik Gajjar wrote:
> > > Currently, the timeout for the set address command is fixed at
> > > 5 seconds in the xhci driver. This means the host waits up to 5
> > > seconds to receive a response for the set_address command from
> > > the device.
> > > 
> > > In the automotive context, most smartphone enumerations, including
> > > screen projection, should ideally complete within 3 seconds.
> > > Achieving this is impossible in scenarios where the set_address is
> > > not successful and waits for a timeout.
> > > 
> > > The shortened address device timeout quirks provide the flexibility
> > > to align with a 3-second time limit in the event of errors.
> > > By swiftly triggering a failure response and swiftly initiating
> > > retry procedures, these quirks ensure efficient and rapid recovery,
> > > particularly in automotive contexts where rapid smartphone enumeration
> > > and screen projection are vital.
> > > 
> > > The quirk will set the timeout to 500 ms from 5 seconds.
> > > 
> > > To use the quirk, please write "vendor_id:product_id:p" to
> > > /sys/bus/usb/drivers/hub/module/parameter/quirks
> > > 
> > > For example,
> > > echo "0x2c48:0x0132:p" > /sys/bus/usb/drivers/hub/module/parameter/quirks"
> > > 
> > > Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> > > ---
> > > changes since version 1:
> > > 	- implement quirk instead of new API in xhci driver
> > > 
> > > changes since version 2:
> > > 	- Add documentation for the new quirk.
> > > 	- Define the timeout unit in milliseconds in variable names and function arguments.
> > > 	- Change the xHCI command timeout from HZ (jiffies) to milliseconds.
> > > 	- Add APTIV usb hub vendor and product ID in device quirk list
> > > 	- Adding some other comments for clarity
> > > ---
> > >  .../admin-guide/kernel-parameters.txt         |  3 +++
> > >  drivers/usb/core/hub.c                        | 13 ++++++++--
> > >  drivers/usb/core/quirks.c                     |  6 +++++
> > >  drivers/usb/host/xhci-mem.c                   |  2 ++
> > >  drivers/usb/host/xhci-ring.c                  | 11 ++++----
> > >  drivers/usb/host/xhci.c                       | 25 +++++++++++++------
> > >  drivers/usb/host/xhci.h                       |  6 +++--
> > >  include/linux/usb/hcd.h                       |  5 ++--
> > >  include/linux/usb/quirks.h                    |  3 +++
> > >  9 files changed, 56 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 0a1731a0f0ef..44732d179bce 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -6817,6 +6817,9 @@
> > >  					pause after every control message);
> > >  				o = USB_QUIRK_HUB_SLOW_RESET (Hub needs extra
> > >  					delay after resetting its port);
> > > +				p = USB_QUIRK_SHORT_DEVICE_ADDR_TIMEOUT ( Timeout
> > > +					of set_address command reduce from 5000 ms
> > > +					to 500 ms
> > 
> > No trailing ")" character?  And no need for the extra space after the
> > new "(" one, right?
> >
> 
> Okay, update it. Interestingly, the 'scripts/checkpatch.pl' is not reporting such warnings

checkpatch doesn't parse documentation like this, so don't expect it to
catch stuff here.

thanks,

greg k-h
