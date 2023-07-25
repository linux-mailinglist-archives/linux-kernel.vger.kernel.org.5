Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E077619D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjGYNYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjGYNYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:24:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DAF1BC5;
        Tue, 25 Jul 2023 06:24:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA17F61721;
        Tue, 25 Jul 2023 13:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5CBC433C7;
        Tue, 25 Jul 2023 13:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690291475;
        bh=yWztKEQIY/r5Vx9HYM0UdYH6YYBudUBnyPeCS6Ki+A4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uARGCbYksRHlSMDfjTfPSv8s33gUt/8JpqlcGAE4Zq7oWYesuWLUkd3A7tCwpalrb
         YjHpqquzvFSetrWbfJYonxHY6jZAxVijHX0vx9unb5XmRhw+rhgyW+3gTNqKTlx+ox
         2QqF+4LYCQltCULaFS8zJiKIkjLoSOhw+usIiXLA=
Date:   Tue, 25 Jul 2023 15:24:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Dingyan Li <18500469033@163.com>, stern@rowland.harvard.edu,
        sebastian.reichel@collabora.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: add usbfs ioctl to get specific superspeedplus rates
Message-ID: <2023072546-denture-half-5ceb@gregkh>
References: <20230721084039.9728-1-18500469033@163.com>
 <2023072105-lethargic-saddling-ad97@gregkh>
 <130b453c.5c8f.1897872ce54.Coremail.18500469033@163.com>
 <2023072159-carol-underfeed-43eb@gregkh>
 <781b3f95-96e7-af83-e089-887ec7f2d255@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <781b3f95-96e7-af83-e089-887ec7f2d255@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 11:47:49AM +0200, Oliver Neukum wrote:
> On 21.07.23 16:51, Greg KH wrote:
> 
> > > 1. By saying "be documented somewhere", do you mean there is extra
> > >      documentation work which needs to be done? Sorry that I missed this
> > >      part since it's the first time for me to work on a kernel patch.
> > 
> > It needs to be documented somewhere, otherwise no one knows how to use
> > it.
> > 
> > > 2. If no error, returned values are "enum usb_ssp_rate" defined in include/linux/usb/ch9.h
> > > 3. ssp rate is only valid for superspeedplus. For other speeds, it should be
> > >      USB_SSP_GEN_UNKNOWN.
> > 
> > Ok, that should be documented.
> 
> Documentation would be good.
> Where should it go, though? These enums are part of the uapi
> hierarchy. Now, documentation for uapi would be good, but we
> should not mix it with documentation for ioctl
> That is if an ioctl uses an enum out of uapi it needs to be
> explicitly mentioned by name, but documenting the semantics
> of the enum _there_ would be wrong.
> 
> > 
> > > 4. I found in libusb, there are two ways to get speed value for a device.
> > >      One way is via sysfs, which has supported 20Gbps now. Another way is
> > >      to use ioctl USBDEVFS_GET_SPEED. This is when I found this ioctl can only
> > >      return USB_SPEED_SUPER_PLUS at most, it cannot determine current ssp rate
> > >      further, no matter Gen1x2(10Gbps), Gen2x1(10Gbps) or Gen2x2(20Gbps). So I
> > >      thought maybe it's good to provide a similar way like ioctl USBDEVFS_GET_SPEED
> > >      in order to get ssp rates.
> > 
> > If libusb doesn't need this ioctl, who would use it?  We only add apis
> > that are actually going to be used.
> > 
> > So if libusb doesn't use it, we need a real-world user for us to be able
> > to add this.
> 
> I am sorry, but that looks pretty much like a question of API design to me.
> To what extent is libusb supposed to be functional without sysfs? There is
> no technical answer to this. It is a question of design goals.
> 
> If we follow the precedent of c01b244ad848a
> ("USB: add usbfs ioctl to retrieve the connection speed")
> then we should apply an updated version of Dingyan Li's patch, preferably
> coupled with a patch for libusb or we go and deprecate some ioctls.

We can never "deprecate" ioctls, sorry.

So unless there is some actual need from userspace tools like libusb (or
anything else?) that requires this new ioctl, let's not add it otherwise
we are signing ourselves up to support it for forever.

thanks,

greg k-h
