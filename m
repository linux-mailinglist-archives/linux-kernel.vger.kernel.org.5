Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A17075CAA7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjGUOvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjGUOvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:51:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DAE30DD;
        Fri, 21 Jul 2023 07:51:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D763A61CBC;
        Fri, 21 Jul 2023 14:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7258C433C8;
        Fri, 21 Jul 2023 14:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689951095;
        bh=JyLcr+hjjbOtJozv2nCAZS5KuLenLLEMRv93SGfMz0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lx3f1KiLZQ6aMFKpJddnpZcfv2cZAUxd0rHUGPpu6dHJXgGys0vJUzVc6BDb/ToIz
         BDY55EEfyr4U4HmAyisYd+xC7w0KqmXNj9+59w4BN3AeSUdAxZHeatNDdWCFLxe5PP
         3p31py3eSUZhE5dxG7QgMhLkBvDgm3toODzpTQAg=
Date:   Fri, 21 Jul 2023 16:51:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dingyan Li <18500469033@163.com>
Cc:     stern@rowland.harvard.edu, sebastian.reichel@collabora.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] USB: add usbfs ioctl to get specific superspeedplus
 rates
Message-ID: <2023072159-carol-underfeed-43eb@gregkh>
References: <20230721084039.9728-1-18500469033@163.com>
 <2023072105-lethargic-saddling-ad97@gregkh>
 <130b453c.5c8f.1897872ce54.Coremail.18500469033@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <130b453c.5c8f.1897872ce54.Coremail.18500469033@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 08:35:37PM +0800, Dingyan Li wrote:
> 
> At 2023-07-21 19:04:29, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >On Fri, Jul 21, 2023 at 04:40:39PM +0800, Dingyan Li wrote:
> >> The usbfs interface does not provide any way to get specific
> >> superspeedplus rate, like Gen2x1, Gen1x2 or Gen2x2. Current
> >> API include an USBDEVFS_GET_SPEED ioctl, but it can only return
> >> general superspeedplus speed instead of any specific rates.
> >> Therefore we can't tell whether it's a Gen2x2(20Gbps) device.
> >> 
> >> This patch introduce a new ioctl USBDEVFS_GET_SSP_RATE to fix
> >> it. Similar information is already available via sysfs, it's
> >> good to add it for usbfs too.
> >> 
> >> Signed-off-by: Dingyan Li <18500469033@163.com>
> >> ---
> >>  drivers/usb/core/devio.c          | 3 +++
> >>  include/uapi/linux/usbdevice_fs.h | 1 +
> >>  2 files changed, 4 insertions(+)
> >> 
> >> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> >> index 1a16a8bdea60..2f57eb163360 100644
> >> --- a/drivers/usb/core/devio.c
> >> +++ b/drivers/usb/core/devio.c
> >> @@ -2783,6 +2783,9 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
> >>  	case USBDEVFS_GET_SPEED:
> >>  		ret = ps->dev->speed;
> >>  		break;
> >> +	case USBDEVFS_GET_SSP_RATE:
> >> +		ret = ps->dev->ssp_rate;
> >> +		break;
> >
> >Shouldn't this new ioctl be documented somewhere?  What are the valid
> >values it can return?  What if it in't a superspeed device?  Who is
> >going to use this?
> >
> >And we have traditionally only been adding new information like this to
> >sysfs, which was not around when usbfs was created.  Why not just use
> >that instead?  Are you wanting to see all of the sysfs-provided
> >information in usbfs also?
> >
> >thanks,
> >
> 
> >greg k-h
> 
> 1. By saying "be documented somewhere", do you mean there is extra
>     documentation work which needs to be done? Sorry that I missed this
>     part since it's the first time for me to work on a kernel patch.

It needs to be documented somewhere, otherwise no one knows how to use
it.

> 2. If no error, returned values are "enum usb_ssp_rate" defined in include/linux/usb/ch9.h
> 3. ssp rate is only valid for superspeedplus. For other speeds, it should be
>     USB_SSP_GEN_UNKNOWN.

Ok, that should be documented.

> 4. I found in libusb, there are two ways to get speed value for a device.
>     One way is via sysfs, which has supported 20Gbps now. Another way is
>     to use ioctl USBDEVFS_GET_SPEED. This is when I found this ioctl can only
>     return USB_SPEED_SUPER_PLUS at most, it cannot determine current ssp rate
>     further, no matter Gen1x2(10Gbps), Gen2x1(10Gbps) or Gen2x2(20Gbps). So I
>     thought maybe it's good to provide a similar way like ioctl USBDEVFS_GET_SPEED
>     in order to get ssp rates.

If libusb doesn't need this ioctl, who would use it?  We only add apis
that are actually going to be used.

So if libusb doesn't use it, we need a real-world user for us to be able
to add this.

thanks,

greg k-h
