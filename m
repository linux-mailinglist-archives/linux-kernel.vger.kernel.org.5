Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798427703AC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjHDOzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjHDOzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:55:53 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 76CA549D6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:55:50 -0700 (PDT)
Received: (qmail 34198 invoked by uid 1000); 4 Aug 2023 10:55:49 -0400
Date:   Fri, 4 Aug 2023 10:55:49 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dingyan Li <18500469033@163.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Xiaofan Chen <xiaofanc@gmail.com>,
        Oliver Neukum <oneukum@suse.com>,
        Tormod Volden <lists.tormod@gmail.com>,
        sebastian.reichel@collabora.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] USB: add usbfs ioctl to get specific
 superspeedplus rates
Message-ID: <daa39dd3-4e8b-4d69-8ad3-5ec73fa12f8c@rowland.harvard.edu>
References: <CAGjSPUCQ892adFdYm7zCuMpWujwzwoQtYimvp3xXrnnCCyN47w@mail.gmail.com>
 <da536c80-7398-dae0-a22c-16e521be697a@suse.com>
 <CAGjSPUDtn-YMqmNrmku+hkyXCKys4XRue4wdzQwr+yGxe2cJSQ@mail.gmail.com>
 <2a82ba01-38dd-fad9-98b9-ac8591107921@redhat.com>
 <151a5748.3e99.189ba07b110.Coremail.18500469033@163.com>
 <51926ee6-ee81-4543-a1f7-338e65a26670@rowland.harvard.edu>
 <a31ee75e-6a8e-fe7b-aadc-f118d9ab60f9@redhat.com>
 <67b68375.80b5.189bc2653e9.Coremail.18500469033@163.com>
 <c10dd3c1-efab-47d6-904f-3b211965be44@rowland.harvard.edu>
 <5ccfaa7e.3180.189bec2b80e.Coremail.18500469033@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ccfaa7e.3180.189bec2b80e.Coremail.18500469033@163.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 12:16:19PM +0800, Dingyan Li wrote:
> 
> At 2023-08-04 01:56:03, "Alan Stern" <stern@rowland.harvard.edu> wrote:
> >On Fri, Aug 04, 2023 at 12:06:15AM +0800, Dingyan Li wrote:
> >> So after usb_device_speed is extended with Gen2x1, Gen1x2 and Gen2x2,
> >> it feels that enum usb_ssp_rate becomes useless. Is it okay to just delete it?
> >> I'm asking this since it is also used in several other source files so the fix may
> >> not be as trivial as it looks.
> >
> >As long as the file is being used by other source files, don't delete 
> >it.  If you want to fix up all those other places and then delete the 
> >file, that's fine.  But of course, it would have to be a separate set of 
> >patches.
> >
> >It will also be necessary to audit the places in the kernel that 
> >currently use usb_device_speed.  Some of them may need to be extended to 
> >handle the new entries properly.  (Including, obviously, the parts of 
> >the code that store the device's speed in the first place.)
> >
> 
> >Alan Stern
> 
> Another issue is that USB_SPEED_SUPER_PLUS has been widely used in
> so many files to execute conditional banches. Once we extend and store device's
> speed with new values in the first place, we might need to check all places where
> USB_SPEED_SUPER_PLUS is used in case of any regression.

Certainly.  That's part of auditing all the current users of 
usb_device_speed.

> I think maybe we can try to remove the dependency on enum usb_device_speed
> in usbfs and define a separate set of speed values similar to previous design
> at https://www.spinics.net/lists/linux-usb/msg157709.html
> By this way, in usbfs we get more freedom to determine how to explain
> usb_device_speed and usb_ssp_rate, without the risk of breaking anything
> elsewhere.
> 
> For example, define an USBDEVFS_SPEED_SUPER_PLUS to indicate
> USB_SPEED_SUPER_PLUS with ssp rates GEN_UNKNOWN, GEN_2x1 and
> GEN_1x2. They all stand for 10Gbps and we don't need to tell one from
> another, similar to how it works in sysfs. Then define an
> USBDEVFS_SPEED_SUPER_PLUS_BY2(maybe there is a more proper name)
> to indicate USB_SPEED_SUPER_PLUS with ssp rate GEN_2x2, which stands
> for 20Gbps.

You can't really do that.  The values returned by the USBDEVFS_GET_SPEED 
ioctl are the ones defined in include/uapi/linux/usb/ch9.h.  They are 
USB_SPEED_UNKNOWN, etc., not USBDEVFS_SPEED_UNKNOWN, etc.  The only way 
to extend them is by adding new entries to enum usb_device_speed.

For example, you must not do anything that would break a user program 
which does something like this:

#include <linux/usbdevfs.h>
#include <linux/usb/ch9.h>

...

	enum usb_device_speed s;

	s = ioctl(fd, USBDEVFS_GET_SPEED);
	if (s == USB_SPEED_HIGH) ...

Alan Stern
