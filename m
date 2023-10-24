Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C2C7D5981
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343769AbjJXRLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjJXRLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:11:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0752D186
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:11:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400C6C433C9;
        Tue, 24 Oct 2023 17:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698167494;
        bh=3daQE+NKeT2HgtEmf8nv00ubawI1EkzNRd4aZ5XC2fE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/C1GcAHsAqVHg9ylfxZ1lKouys91bX4NLLWD+AIgIn8aJ9SDVb6DWH1F0X3hGrHk
         dwxOjapptyaddgVg5onSzACP+m4XCbN9ozTP1K9Ee1oLeH4uZ138wzh0cSWqEFazh0
         Y5t9kq5GW5KP8R4ShzIJQX7MCz/S11EmvoZDgpt0=
Date:   Tue, 24 Oct 2023 19:11:31 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Li, Meng" <Meng.Li@windriver.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "usb-storage@lists.one-eyed-alien.net" 
        <usb-storage@lists.one-eyed-alien.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: storage: add shutdown function for usb storage
 driver
Message-ID: <2023102459-protector-frequency-1033@gregkh>
References: <20231023054111.2744872-1-Meng.Li@windriver.com>
 <33bd0779-bfe7-4c87-8fe6-ea8455df3b6b@rowland.harvard.edu>
 <PH0PR11MB51918DD50651DB6BE937BEA3F1DFA@PH0PR11MB5191.namprd11.prod.outlook.com>
 <3fe5b43c-a5aa-4c6a-8614-03a4d9dd53e2@rowland.harvard.edu>
 <2023102428-zit-quickness-9b73@gregkh>
 <5107f6ca-e972-4af1-a21d-6c95778969f3@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5107f6ca-e972-4af1-a21d-6c95778969f3@rowland.harvard.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 11:58:37AM -0400, Alan Stern wrote:
> On Tue, Oct 24, 2023 at 05:45:40PM +0200, gregkh@linuxfoundation.org wrote:
> > On Tue, Oct 24, 2023 at 11:35:19AM -0400, Alan Stern wrote:
> > > Okay, that's a different matter.  In fact, I don't know what is supposed 
> > > to happen during a clean reboot.
> > 
> > Define "clean" :)
> 
> In this case, I mean what happens when you give the "reboot" command.

That's a userspace binary/script/whatever that can do loads of different
things not involving the kernel, so it all depends on the user's system
as to what will happen here.

Many "good" userspace implementation of reboot will go and sync and
unmount all mounted disks in the correct order, before the kernel is
told to reboot.

All we can do in the kernel is act on the reboot system call.

So perhaps the original poster here can see why his userspace isn't
correctly shutting down their storage devices?

> > reboot is a system thing that happens before the reboot syscall happens.
> > So which are we talking nabout here?
> > 
> > > Greg, do you know?  Should we take the time to disconnect all the USB 
> > > devices during a system shutdown?
> > 
> > In the past we have not.  And if we switch to do so, we might get some
> > complaints as we would now delaying the shutdown process to be longer
> > than before.
> 
> Yes, that's what I'm afraid of.
> 
> > > What happens with non-USB disk drives?  Or other removable devices?
> > 
> > It would have to come from "above" in the device tree, so does the PCI
> > or platform bus say that they should be shut down and their child
> > devices?
> 
> Well, the PCI layer invokes the HCD's ->shutdown callback.  But the 
> usb-storage driver and usbcore don't know this has happened, so they 
> start logging errors because they are suddenly unable to communicate 
> with a USB drive.  Meng Li is unhappy about these error messages.
> 
> Adding a shutdown callback of sorts to usb-storage allows the driver to 
> know that it shouldn't communicate with the drive any more, which 
> prevents the error message from appearing.  That's what this patch does.  
> 
> But that's all it does.  Basically it creates a layering violation just 
> to prevent some error messages from showing up in the system log during 
> a shutdown or reboot.  The question is whether we want to do this at 
> all, and if we do, shouldn't it be handled at the usbcore level rather 
> than just within usb-storage?

We should do this within the usb core if we care about it, but why did
the USB device suddenly go away before the USB storage driver was told
about it?  That feels like something else is pulling the power on the
device that is out-of-band here.

thanks,

greg k-h
