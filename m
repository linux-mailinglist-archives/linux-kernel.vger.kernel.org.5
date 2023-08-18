Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3593780EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378101AbjHRPUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378133AbjHRPU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:20:27 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id EC1F83C31
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:20:23 -0700 (PDT)
Received: (qmail 32953 invoked by uid 1000); 18 Aug 2023 11:20:22 -0400
Date:   Fri, 18 Aug 2023 11:20:22 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     mathias.nyman@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci: Disable connect, disconnect and over-current
 wakeup on system suspend
Message-ID: <812a6f54-ef51-4759-8b45-09eb52acad2f@rowland.harvard.edu>
References: <20230817093305.212821-1-kai.heng.feng@canonical.com>
 <cab8a29b-816c-41c7-8d2a-418f787e406e@rowland.harvard.edu>
 <CAAd53p7HZk5tTvT=dhSk01KSW4W3vCi+hY8aFYRoFzxs8YiiYA@mail.gmail.com>
 <dc4f5de7-43f1-4dc2-9a2f-39846b4b7cc3@rowland.harvard.edu>
 <CAAd53p5BGyZi--GbeRtffv7OhWEtKvME4Q_RjC6p9BYVLc9f_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p5BGyZi--GbeRtffv7OhWEtKvME4Q_RjC6p9BYVLc9f_w@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 10:19:27PM +0800, Kai-Heng Feng wrote:
> On Fri, Aug 18, 2023 at 11:19 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, Aug 18, 2023 at 08:00:39AM +0800, Kai-Heng Feng wrote:
> > > On Thu, Aug 17, 2023 at 10:07 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > > On Thu, Aug 17, 2023 at 05:33:05PM +0800, Kai-Heng Feng wrote:
> > > > > The system is designed to let display and touchpanel share the same
> > > > > power source, so when the display becomes off, the USB touchpanel also
> > > > > lost its power and disconnect itself from USB bus. That doesn't play
> > > > > well when most Desktop Environment lock and turnoff the display right
> > > > > before entering system suspend.
> > > >
> > > > I don't see why that should cause any trouble.  The display gets locked
> > > > and turned off, the touchpanel disconnects from the USB bus, and then
> > > > the system goes into suspend.  Why would there be a wakeup signal at
> > > > this point?
> > >
> > > The disconnecting can happens during the system suspend process, so
> > > the suspend process is aborted.
> >
> > Maybe these systems need to add a little delay when the display is
> > turned off, in order to give the touchpanel time to disconnect before
> > the system suspend begins.
> 
> Unfortunately the hardware can't be changed.

No, but the software can.  Change the kernel routine that controls the 
display's power, so that when it's turning the power off it delays a 
little before returning.


> > > > > So for system-wide suspend, also disable connect, disconnect and
> > > > > over-current wakeup to prevent spurious wakeup.
> > > >
> > > > Whether to disable these things is part of the userspace policy.  The
> > > > kernel should not make the decision; the user does by enabling or
> > > > disabling wakeups.
> > >
> > > The power/wakeup is already disabled.
> >
> > In that case the root hub should not generate a wakeup request in
> > response to the touchpanel disconnecting.
> 
> Here's the wakeup setting when the issue happens:
> controller - wakeup enabled
> root hub: wakeup disabled
> touchpanel: wakeup disabled

Your patch turns off the PORT_WAKE_BITS in xhci_disable_hub_port_wake(), 
right?  (Incidentally, the patch changes the code but doesn't change the 
immediately preceding comment, which will cause the comment to be 
wrong.)  But if the root hub was suspended with wakeup disabled then 
those bits should already be off.  So I don't see why your patch causes 
any change in behavior.


> > > The disconnecting event is from roothub and if roothub wakeup is
> > > disabled, other USB devices lose the ability to wake the system up
> > > from system suspend.
> >
> > That shouldn't happen either.  Disabling wakeup on the root hub should
> > not prevent the root hub from relaying wakeup requests it receives from
> > downstream devices.  It should merely prevent the root hub from
> > generating its own wakeup requests for connects, disconnects, and
> > over-current events.
> 
> Sorry, it was meant to be the xHCI controller. The didn't make the
> difference clear.
> 
> >
> > It sounds like the xhci root-hub code isn't doing the right thing, at
> > least, not on your systems.
> 
> I still don't fully understand why removing PORT_WAKE_BITS is not
> right in this case.

The decision about whether to turn those bits on or off should depend 
on the wakeup settings.  They should be on if wakeup is enabled and off 
if wakeup is disabled.  Your patch doesn't work that way; it turns the 
bits off even when wakeup is enabled.

Alan Stern
