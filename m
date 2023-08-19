Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D8C781C56
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 06:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjHTEJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 00:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjHTEJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 00:09:21 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 322EB2A449B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 11:46:08 -0700 (PDT)
Received: (qmail 66691 invoked by uid 1000); 19 Aug 2023 14:46:07 -0400
Date:   Sat, 19 Aug 2023 14:46:07 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dingyan Li <18500469033@163.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Xiaofan Chen <xiaofanc@gmail.com>,
        Oliver Neukum <oneukum@suse.com>,
        Tormod Volden <lists.tormod@gmail.com>,
        sebastian.reichel@collabora.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: Re: Re: [PATCH] USB: add usbfs ioctl to get specific
 superspeedplus rates
Message-ID: <dcbc0031-df64-4609-9113-4c12233c5e3a@rowland.harvard.edu>
References: <CAGjSPUDtn-YMqmNrmku+hkyXCKys4XRue4wdzQwr+yGxe2cJSQ@mail.gmail.com>
 <2a82ba01-38dd-fad9-98b9-ac8591107921@redhat.com>
 <151a5748.3e99.189ba07b110.Coremail.18500469033@163.com>
 <51926ee6-ee81-4543-a1f7-338e65a26670@rowland.harvard.edu>
 <a31ee75e-6a8e-fe7b-aadc-f118d9ab60f9@redhat.com>
 <67b68375.80b5.189bc2653e9.Coremail.18500469033@163.com>
 <c10dd3c1-efab-47d6-904f-3b211965be44@rowland.harvard.edu>
 <5ccfaa7e.3180.189bec2b80e.Coremail.18500469033@163.com>
 <daa39dd3-4e8b-4d69-8ad3-5ec73fa12f8c@rowland.harvard.edu>
 <79f3ec25.fa3.18a0c111fa9.Coremail.18500469033@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79f3ec25.fa3.18a0c111fa9.Coremail.18500469033@163.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 12:32:43PM +0800, Dingyan Li wrote:
> 
> At 2023-08-04 22:55:49, "Alan Stern" <stern@rowland.harvard.edu> wrote:
> 
> >> Another issue is that USB_SPEED_SUPER_PLUS has been widely used in
> >> so many files to execute conditional banches. Once we extend and store device's
> >> speed with new values in the first place, we might need to check all places where
> >> USB_SPEED_SUPER_PLUS is used in case of any regression.
> >
> >Certainly.  That's part of auditing all the current users of 
> >usb_device_speed.
> 
> This might not be a good idea and feels kind of drift away from what we originally
> want to do. Besides, suppose later new speed values are added, someone still has
> to revisit all the files to modify those checks. I think we should try to avoid this situation.

That's bad reasoning.  If you're worried that existing code will stop 
working right when a new speed designation is added then you _have_ to 
audit the code sooner or later.

> >> I think maybe we can try to remove the dependency on enum usb_device_speed
> >> in usbfs and define a separate set of speed values similar to previous design
> >> at https://www.spinics.net/lists/linux-usb/msg157709.html
> >> By this way, in usbfs we get more freedom to determine how to explain
> >> usb_device_speed and usb_ssp_rate, without the risk of breaking anything
> >> elsewhere.
> >> 
> >> For example, define an USBDEVFS_SPEED_SUPER_PLUS to indicate
> >> USB_SPEED_SUPER_PLUS with ssp rates GEN_UNKNOWN, GEN_2x1 and
> >> GEN_1x2. They all stand for 10Gbps and we don't need to tell one from
> >> another, similar to how it works in sysfs. Then define an
> >> USBDEVFS_SPEED_SUPER_PLUS_BY2(maybe there is a more proper name)
> >> to indicate USB_SPEED_SUPER_PLUS with ssp rate GEN_2x2, which stands
> >> for 20Gbps.
> >
> >You can't really do that.  The values returned by the USBDEVFS_GET_SPEED 
> >ioctl are the ones defined in include/uapi/linux/usb/ch9.h.  They are 
> >USB_SPEED_UNKNOWN, etc., not USBDEVFS_SPEED_UNKNOWN, etc.  The only way 
> >to extend them is by adding new entries to enum usb_device_speed.
> >
> >For example, you must not do anything that would break a user program 
> >which does something like this:
> >
> >#include <linux/usbdevfs.h>
> >#include <linux/usb/ch9.h>
> >
> >...
> >
> >	enum usb_device_speed s;
> >
> >	s = ioctl(fd, USBDEVFS_GET_SPEED);
> >	if (s == USB_SPEED_HIGH) ...
> >
> >Alan Stern
> 
> Since those speed definitions are just int values, we could manage to maintain the compatibility
> by keeping the same value.

No.  The values would be the same, but someone who tried to compile an 
old program under a new kernel would get an error because USB_SPEED_HIGH 
would be undefined.  The update would be binary-compatible but it 
wouldn't be source-compatible.

>  But anyway, my latest idea is not to extend enum usb_device_speed.
> There are three basic cases:
> 1) When speed is less than USB_SPEED_SUPER_PLUS, just return dev->speed;
> 2) When speed is USB_SPEED_SUPER_PLUS but ssp_rate is less than USB_SSP_GEN_2x2,
> return dev->speed;
> 3) When speed is USB_SPEED_SUPER_PLUS and ssp_rate is USB_SSP_GEN_2x2, a new
> speed for usbdevfs should be #defined and let's call it USBDEVFS_SPEED_SUPER_PLUS_BY2.
> This value won't be overlapped with any value in enum usb_device_speed, for example 7.
> In this case, return USBDEVFS_SPEED_SUPER_PLUS_BY2.
> 
> The code could be like:
> 
>         case USBDEVFS_GET_SPEED:
>                 ret = ps->dev->speed;
> +               if (ret == USB_SPEED_SUPER_PLUS &&
> +                               ps->dev->ssp_rate == USB_SSP_GEN_2x2)
> +                       ret = USBDEVFS_SPEED_SUPER_PLUS_BY2;
>                 break;
> 
> By this way, no need to add a new ioctl. No need to touch so many files.

If you do it my way (add new entries to enum usb_device_speed) then you 
wouldn't need a new ioctl.  And if one way requires touching a bunch of 
files, so does the other way.

>  And when new
> speeds are added later, just #define new values and extend the checks in above code.
> Compatibility is also maintained. Before this change, USBDEVFS_GET_SPEED could
> return 0-6. After this change, we can still return 0-6 for most of the cases, and 7 for
> GEN_2x2 devices.

The same would be true if you take my advice.

Alan Stern
