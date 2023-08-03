Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EDF76EDA0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbjHCPKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjHCPKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:10:05 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 79C5DE75
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:10:02 -0700 (PDT)
Received: (qmail 246372 invoked by uid 1000); 3 Aug 2023 11:10:01 -0400
Date:   Thu, 3 Aug 2023 11:10:01 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dingyan Li <18500469033@163.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Xiaofan Chen <xiaofanc@gmail.com>,
        Oliver Neukum <oneukum@suse.com>,
        Tormod Volden <lists.tormod@gmail.com>,
        sebastian.reichel@collabora.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] USB: add usbfs ioctl to get specific superspeedplus
 rates
Message-ID: <51926ee6-ee81-4543-a1f7-338e65a26670@rowland.harvard.edu>
References: <2023072105-lethargic-saddling-ad97@gregkh>
 <130b453c.5c8f.1897872ce54.Coremail.18500469033@163.com>
 <2023072159-carol-underfeed-43eb@gregkh>
 <781b3f95-96e7-af83-e089-887ec7f2d255@suse.com>
 <2023072546-denture-half-5ceb@gregkh>
 <CAGjSPUCQ892adFdYm7zCuMpWujwzwoQtYimvp3xXrnnCCyN47w@mail.gmail.com>
 <da536c80-7398-dae0-a22c-16e521be697a@suse.com>
 <CAGjSPUDtn-YMqmNrmku+hkyXCKys4XRue4wdzQwr+yGxe2cJSQ@mail.gmail.com>
 <2a82ba01-38dd-fad9-98b9-ac8591107921@redhat.com>
 <151a5748.3e99.189ba07b110.Coremail.18500469033@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151a5748.3e99.189ba07b110.Coremail.18500469033@163.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 02:13:33PM +0800, Dingyan Li wrote:
> 
> At 2023-07-26 22:39:32, "Hans de Goede" <hdegoede@redhat.com> wrote:

> >Right, so the reason why IOCTL USBDEVFS_GET_SPEED was added is so 
> >that a confined qemu process which gets just a fd for a /dev/bus/usb/ 
> >device passed by a more privileged process can still get the speed 
> >despite it not having sysfs access. This is necessary for correct 
> >pass-through of USB devices.
> >
> >Since USBDEVFS_GET_SPEED now no longer tells the full story I believe 
> >that the proposed USBDEVFS_GET_SSP_RATE ioctl makes sense.
> >
> >The current patch however misses moving the enum usb_ssp_rate 
> >declaration from include/linux/usb/ch9.h to 
> >include/uapi/linux/usb/ch9.h so that needs to be fixed in a version 
> >2. Assuming that with the above explanation of why this is necessary 
> >Greg and Alan are ok with adding the ioctl.
> >
> >Regards,
> >
> >Hans
> >
> 
> Hi Greg and Alan,
> 
> Could you please share your opinions about Hans' justification?

Instead of adding a new ioctl or modifying an existing one, how about 
increasing the set of constants in enum usb_device_speed?  Then the 
existing ioctls could return the newly defined values when appropriate, 
with no other changes necessary.

(This doesn't mean just moving the definition of usb_ssp_rate from one 
header file to the other.  The usb_device_speed enumeration should be 
extended with the new members.  Perhaps omitting USB_SSP_GEN_UNKNOWN 
since we already have USB_SPEED_SUPER_PLUS, or setting the first equal 
to the second.)

I don't think there was ever a requirement in the API that the set of 
values in usb_device_speed could never increase (and in fact it has 
increased in the past).  Such a requirement wouldn't make any sense, 
given how the USB-IF keeps defining newer and faster USB bus 
implementations.

Hans, would that play well with libusb?

Alan Stern
