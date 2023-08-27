Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A3978A118
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 20:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjH0S4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 14:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjH0Szx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 14:55:53 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CEAD6EB
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 11:55:50 -0700 (PDT)
Received: (qmail 325084 invoked by uid 1000); 27 Aug 2023 14:55:50 -0400
Date:   Sun, 27 Aug 2023 14:55:50 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usb-storage: how to extend quirks flags to 64bit?
Message-ID: <2d580337-eaf3-47fb-afa7-1006d9a257ea@rowland.harvard.edu>
References: <f9e8acb5-32d5-4a30-859f-d4336a86b31a@gmail.com>
 <6f8b825b-bc41-4080-8128-4a6f0a43f779@rowland.harvard.edu>
 <34aa2eea-5417-4e46-91a0-aac1a46a84cf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34aa2eea-5417-4e46-91a0-aac1a46a84cf@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 06:45:55PM +0200, Milan Broz wrote:
> On 8/27/23 17:50, Alan Stern wrote:
> > On Sun, Aug 27, 2023 at 11:32:05AM +0200, Milan Broz wrote:
> > > Hello,
> > > 
> > > I tried to extend USB storage for the passthrough of Opal
> > > security commands,
> > 
> > What sort of changes are needed?  Where is this passthrough mechanism
> > documented?
> 
> We are currently adding support for optional OPAL hw encryption to
> cryptsetup/LUKS2 (that uses kernel OPAL ioctl interface) and I tried
> to make USB adapters to work with it too.
> 
> I'll send RFC patchset (it is quite simple) where I explain it in detail.
> The patch for USB storage is actually one liner, the rest is in SCSI driver :)
> 
> Basically, USB adapters (not supporting UAS) cannot work as
> required SCSI SECURITY IN/OUT SCSI commands do not work here.
> 
> But we can use ATA12 pass-thru (as used with original sedutils
> and some other tools we used in research; it is a documented feature).
> It works once ATA12 wrapper is added to block layer and USB storage enables
> the "security_supported" bit.
> 
> > 
> > >   and some adapters are clearly "not perfect".
> > 
> > Which ones?
> 
> Namely Realtek 9210 family (NVME to USB bridge). Everything OPAL related
> works, but the adapter always set write-protected bit for the whole
> drive (even if OPAL locking range is just covering part of the disk).
> 
> I spent quite a lot time trying new firmware versions - this issue is
> still there.

It sounds like the sort of thing that should be reported as a bug to 
Realtek.  I can't imagine their customers would be very happy about this 
behavior.

> On the other side, many other USB to SATA bridges works nicely.
> I think this is the exact situation where we should set a new quirks flag
> to disable it. (The nasty thing is that for unbricking it you need PSID reset
> - PSID is a number written on the label of the drive - followed by physical
> disconnect for recovery.)
> 
> 
> Anyway, I intentionally sent this 32bit flags question separately as it
> is actually a generic issue - we are just out of flag space now...
> 
> Even if the patches mentioned above are rejected, someone will need
> a new flag for something else later.

Certainly.  We knew this was bound to come up eventually.

> > > I would need to introduce a new quirks flag to turn it off.
> > > 
> > > Seems that we are already out of quirks flags on 32bit
> > > for usb storage - in usb_usual.h the last entry in mainline is
> > >    US_FLAG(SENSE_AFTER_SYNC, 0x80000000)
> > > 
> > > Adding a new flag will work for 64-bit systems but not
> > > for platforms with 32-bit unsigned long like i686.
> > > 
> > > How do we allow new flag definitions?
> > > 
> > > Struct us_data fflags can be made 64bit (defined in
> > > drivers/usb/storage/usb.h), but the major problem is that these
> > > are transferred through the generic driver_info field
> > > defined in linux/mod_devicetable.h as unsigned long).
> > > Making this 64bit is IMO an extensive API change (if even possible).
> > > I guess this is not the way to go.
> > > 
> > > Could USB maintainers please help to advise what is the correct
> > > solution? I am not familiar with the USB driver model here
> > > and I see no easy way how it can be solved by a trivial static
> > > allocation inside the USB storage driver.
> > > 
> > > Someone will need a new quirks flag in the future anyway... :)
> > 
> > I can think of only one way to accomplish this on 32-bit systems: Change
> > the driver_info field from a bit array to an index into a static table
> > of 64-bit flags values.  Each unusual_devs structure would have its own
> > entry in this table.  As far as I can tell, the other unusual_*.h tables
> > could retain their current driver_info interpretations, since no new
> > quirk bits are likely to be relevant to them.
> > 
> > Making this change would be an awkward nuisance, but it should be
> > doable.
> 
> Hm, yes, thanks for the idea,that is a possible solution.
> It will need to modify all unusual macros, though. Just I am not sure I want
> to spent time patching all the drivers as I have not way how to test it.

I don't think it will be necessary to change all those macros, just the 
ones in usual_tables.c.  And to create the new table containing the 
actual flag values, of course.

There will also have to be a new argument to usb_stor_probe1() 
specifying whether the id->driver_info field is standard (i.e., it 
contains the flags directly) or is one of the new indirect index values.  

And you'll have to figure out a comparable change to the dynamic device 
ID table mechanism.

(If you want to be really fancy about it, you could design things in 
such a way that the indirect flags approach is used only on 32-bit 
systems.  64-bit systems can put the new flag bits directly into the 
driver_info field.  However, it's probably best not to worry about this 
initially.)
 
Alan Stern
