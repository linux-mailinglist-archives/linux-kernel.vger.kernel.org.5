Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ED27C52D6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjJKMFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjJKMFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:05:45 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F26D93;
        Wed, 11 Oct 2023 05:05:42 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 7669F5202C8;
        Wed, 11 Oct 2023 14:05:40 +0200 (CEST)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.32; Wed, 11 Oct
 2023 14:05:40 +0200
Date:   Wed, 11 Oct 2023 14:05:35 +0200
From:   Hardik Gajjar <hgajjar@de.adit-jv.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Hardik Gajjar <hgajjar@de.adit-jv.com>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <yangyingliang@huawei.com>,
        <jinpu.wang@ionos.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <erosca@de.adit-jv.com>
Subject: Re: [PATCH v3] usb: core: hub: Add quirks for reducing device
 address timeout
Message-ID: <20231011120535.GA89684@vmlxhi-118.adit-jv.com>
References: <6b26db15-89a0-d455-5740-9abb1befa3a8@intel.com>
 <20231011085011.89198-1-hgajjar@de.adit-jv.com>
 <2023101117-colonize-jovial-893f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2023101117-colonize-jovial-893f@gregkh>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.72.93.77]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 11:02:27AM +0200, Greg KH wrote:
> On Wed, Oct 11, 2023 at 10:50:11AM +0200, Hardik Gajjar wrote:
> > Currently, the timeout for the set address command is fixed at
> > 5 seconds in the xhci driver. This means the host waits up to 5
> > seconds to receive a response for the set_address command from
> > the device.
> > 
> > In the automotive context, most smartphone enumerations, including
> > screen projection, should ideally complete within 3 seconds.
> > Achieving this is impossible in scenarios where the set_address is
> > not successful and waits for a timeout.
> > 
> > The shortened address device timeout quirks provide the flexibility
> > to align with a 3-second time limit in the event of errors.
> > By swiftly triggering a failure response and swiftly initiating
> > retry procedures, these quirks ensure efficient and rapid recovery,
> > particularly in automotive contexts where rapid smartphone enumeration
> > and screen projection are vital.
> > 
> > The quirk will set the timeout to 500 ms from 5 seconds.
> > 
> > To use the quirk, please write "vendor_id:product_id:p" to
> > /sys/bus/usb/drivers/hub/module/parameter/quirks
> > 
> > For example,
> > echo "0x2c48:0x0132:p" > /sys/bus/usb/drivers/hub/module/parameter/quirks"
> > 
> > Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> > ---
> > changes since version 1:
> > 	- implement quirk instead of new API in xhci driver
> > 
> > changes since version 2:
> > 	- Add documentation for the new quirk.
> > 	- Define the timeout unit in milliseconds in variable names and function arguments.
> > 	- Change the xHCI command timeout from HZ (jiffies) to milliseconds.
> > 	- Add APTIV usb hub vendor and product ID in device quirk list
> > 	- Adding some other comments for clarity
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  3 +++
> >  drivers/usb/core/hub.c                        | 13 ++++++++--
> >  drivers/usb/core/quirks.c                     |  6 +++++
> >  drivers/usb/host/xhci-mem.c                   |  2 ++
> >  drivers/usb/host/xhci-ring.c                  | 11 ++++----
> >  drivers/usb/host/xhci.c                       | 25 +++++++++++++------
> >  drivers/usb/host/xhci.h                       |  6 +++--
> >  include/linux/usb/hcd.h                       |  5 ++--
> >  include/linux/usb/quirks.h                    |  3 +++
> >  9 files changed, 56 insertions(+), 18 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 0a1731a0f0ef..44732d179bce 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6817,6 +6817,9 @@
> >  					pause after every control message);
> >  				o = USB_QUIRK_HUB_SLOW_RESET (Hub needs extra
> >  					delay after resetting its port);
> > +				p = USB_QUIRK_SHORT_DEVICE_ADDR_TIMEOUT ( Timeout
> > +					of set_address command reduce from 5000 ms
> > +					to 500 ms
> 
> No trailing ")" character?  And no need for the extra space after the
> new "(" one, right?
>

Okay, update it. Interestingly, the 'scripts/checkpatch.pl' is not reporting such warnings

> also, this should say it is "reducing", not "reduce"?
> 
> >  			Example: quirks=0781:5580:bk,0a5c:5834:gij
> >  
> >  	usbhid.mousepoll=
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 3c54b218301c..c0d727398cd1 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -54,6 +54,9 @@
> >  #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
> >  #define USB_PING_RESPONSE_TIME		400	/* ns */
> >  
> > +#define USB_DEFAULT_ADDR_DEVICE_TIMEOUT_MS	5000 /* 5000ms */
> 
> This comes from the USB specification, right?  If so, can you add the
> USB spec location for it in the comment?
> 
> > +#define USB_SHORT_ADDR_DEVICE_TIMEOUT_MS	500  /* 500ms */
> 
> This is for "broken" devices, right?
> 
> > +
> >  /* Protect struct usb_device->state and ->children members
> >   * Note: Both are also protected by ->dev.sem, except that ->state can
> >   * change to USB_STATE_NOTATTACHED even when the semaphore isn't held. */
> > @@ -4626,8 +4629,14 @@ EXPORT_SYMBOL_GPL(usb_ep0_reinit);
> >  static int hub_set_address(struct usb_device *udev, int devnum)
> >  {
> >  	int retval;
> > +	unsigned int timeout_ms = USB_DEFAULT_ADDR_DEVICE_TIMEOUT_MS;
> >  	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
> >  
> > +	struct usb_hub *hub = usb_hub_to_struct_hub(udev->parent);
> 
> Did you run https://urldefense.proofpoint.com/v2/url?u=http-3A__checkpatch.pl&d=DwICAg&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=SAhjP5GOmrADp1v_EE5jWoSuMlYCIt9gKduw-DCBPLs&m=6Am_63OPDGq3Jc3NvsSZFUkSZLQk4gIIiJUx4nh1LoSZtxv-gUlOsoQY-Ooe2uuX&s=gQ_CCUZ1pM8CXK5oamzWh365rtZOP3DiS3ne4Rcj__A&e= on your change?  It should say the extra blank
> line you added here isn't needed (if not, it shouldn't be added anyway,
> that's not good kernel coding style.)

Yes, I have executed 'scripts/checkpatch.pl' with the --strict option, but there
is no such warning. Am I missing something? The following is the output of
checkpatch.pl on my build machine:
------------------------------------------------------
scripts/checkpatch.pl --strict v3-0001-usb-core-hub-Add-quirks-for-reducing-device-addre.patch 
WARNING: function definition argument 'struct usb_hcd *' should also have an identifier name
#285: FILE: include/linux/usb/hcd.h:376:
+	int	(*address_device)(struct usb_hcd *, struct usb_device *udev,

total: 0 errors, 1 warnings, 0 checks, 193 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

v3-0001-usb-core-hub-Add-quirks-for-reducing-device-addre.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
-------------------------------------------------------

> 
> > +
> > +	if (hub->hdev->quirks & USB_QUIRK_SHORT_DEVICE_ADDR_TIMEOUT)
> > +		timeout_ms = USB_SHORT_ADDR_DEVICE_TIMEOUT_MS;
> > +
> >  	/*
> >  	 * The host controller will choose the device address,
> >  	 * instead of the core having chosen it earlier
> > @@ -4639,11 +4648,11 @@ static int hub_set_address(struct usb_device *udev, int devnum)
> >  	if (udev->state != USB_STATE_DEFAULT)
> >  		return -EINVAL;
> >  	if (hcd->driver->address_device)
> > -		retval = hcd->driver->address_device(hcd, udev);
> > +		retval = hcd->driver->address_device(hcd, udev, timeout_ms);
> >  	else
> >  		retval = usb_control_msg(udev, usb_sndaddr0pipe(),
> >  				USB_REQ_SET_ADDRESS, 0, devnum, 0,
> > -				NULL, 0, USB_CTRL_SET_TIMEOUT);
> > +				NULL, 0, timeout_ms);
> >  	if (retval == 0) {
> >  		update_devnum(udev, devnum);
> >  		/* Device now using proper address. */
> > diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> > index 15e9bd180a1d..a1137740b496 100644
> > --- a/drivers/usb/core/quirks.c
> > +++ b/drivers/usb/core/quirks.c
> > @@ -138,6 +138,9 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
> >  			case 'o':
> >  				flags |= USB_QUIRK_HUB_SLOW_RESET;
> >  				break;
> > +			case 'p':
> > +				flags |= USB_QUIRK_SHORT_DEVICE_ADDR_TIMEOUT;
> > +				break;
> >  			/* Ignore unrecognized flag characters */
> >  			}
> >  		}
> > @@ -542,6 +545,9 @@ static const struct usb_device_id usb_quirk_list[] = {
> >  	/* INTEL VALUE SSD */
> >  	{ USB_DEVICE(0x8086, 0xf1a5), .driver_info = USB_QUIRK_RESET_RESUME },
> >  
> > +	/* APTIV AUTOMOTIVE HUB */
> > +	{ USB_DEVICE(0x2c48, 0x0132), .driver_info = USB_QUIRK_SHORT_DEVICE_ADDR_TIMEOUT },
> > +
> >  	{ }  /* terminating entry must be last */
> >  };
> >  
> 
> I miss where you add the timeout delay in the other host controller
> drivers.  Why only xhci?  What about uhci/ohci/dwc3/etc.?
>

It is in hub.c file. Following is the code snippet of the patch.
    if (hcd->driver->address_device)
-           retval = hcd->driver->address_device(hcd, udev);
+           retval = hcd->driver->address_device(hcd, udev, timeout_ms);
    else
            retval = usb_control_msg(udev, usb_sndaddr0pipe(),
                            USB_REQ_SET_ADDRESS, 0, devnum, 0,
-                           NULL, 0, USB_CTRL_SET_TIMEOUT);
+                           NULL, 0, timeout_ms);

In other host drivers, the set address request is issued using the
usb_control_msg() API within the 'else' condition.

Other host drivers, except for xHCI, do not populate the 'address_device'
function in the hc_driver structure when defining the structure in the host
driver. 

For example, you can see the hc_driver structure of the Linux OHCI driver
at the following link, and you'll notice that there is no 'address_device' function.

https://github.com/torvalds/linux/blob/1c8b86a3799f7e5be903c3f49fcdaee29fd385b5/drivers/usb/host/ohci-hcd.c#L1183

> thanks,
> 
> greg k-h

Thanks,
Hardik
