Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9424780E86
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377948AbjHRPCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377981AbjHRPCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:02:15 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B0D3E3C3D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:02:12 -0700 (PDT)
Received: (qmail 32375 invoked by uid 1000); 18 Aug 2023 11:02:11 -0400
Date:   Fri, 18 Aug 2023 11:02:11 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     mathias.nyman@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci: Disable connect, disconnect and over-current
 wakeup on system suspend
Message-ID: <7de57a37-7a23-42ab-adb7-fce2e879c080@rowland.harvard.edu>
References: <20230817093305.212821-1-kai.heng.feng@canonical.com>
 <cab8a29b-816c-41c7-8d2a-418f787e406e@rowland.harvard.edu>
 <59898e32-f2ea-4df7-947b-3d74835ff9b7@rowland.harvard.edu>
 <CAAd53p5pxGfS0y260NsMF+m_Ota+d1ZKbtdq4dfM5s+T1z14bw@mail.gmail.com>
 <b08553d7-017e-477c-b18e-8564fe88646b@rowland.harvard.edu>
 <CAAd53p5EJG=gUOt48mk=o2QdMjoR-FgQqkt80BQX8f8uph4MVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p5EJG=gUOt48mk=o2QdMjoR-FgQqkt80BQX8f8uph4MVg@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 10:12:25PM +0800, Kai-Heng Feng wrote:
> On Fri, Aug 18, 2023 at 11:08 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, Aug 18, 2023 at 08:01:54AM +0800, Kai-Heng Feng wrote:
> > > On Thu, Aug 17, 2023 at 10:22 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > > On Thu, Aug 17, 2023 at 10:07:37AM -0400, Alan Stern wrote:
> > > > > On Thu, Aug 17, 2023 at 05:33:05PM +0800, Kai-Heng Feng wrote:
> > > > > > HP ProOne 440 G10 AIO sometimes cannot suspend as xHCI wakes up the
> > > > > > system:
> > > > > > [  445.814574] hub 2-0:1.0: hub_suspend
> > > > > > [  445.814652] usb usb2: bus suspend, wakeup 0
> > > > > > [  445.824629] xhci_hcd 0000:00:14.0: Port change event, 1-11, id 11, portsc: 0x202a0
> > > > >
> > > > > What is the meaning of the 0x202a0 bits?  What caused this wakeup?
> > > >
> > > > And more to the point, given that the previous line says "wakeup 0", why
> > > > should any port change event cause a wakeup?
> > >
> > > I think the controller and roothub have to deal with the interrupt
> > > about disconnecting regardless of the remote wakeup setting.
> >
> > This seems to contradict what you wrote in an earlier email:
> 
> Nothing is contradicting, what I mentioned is the wakeup of USB
> touchpanel, not the controller or root hub.

Now I'm getting even more confused.  How can the touchpanel generate a 
wakeup request while it is powered off?


> > > > If remote wakeup isn't enabled then the do_wakeup variable will be 0,
> > > > so your patch wouldn't make any difference.  The question is what
> > > > happens when remote wakeup _is_ enabled.
> > >
> > > Nothing happens either per my testing.
> > >
> > > For USB keyboard, the remote wakeup is enabled, unplugging it when
> > > suspend is suspended doesn't wake the system up, despite of PORT_WKDISC_E being set.
> > > Plugging it back doesn't wake the system up either, despite of PORT_WKCONN_E.
> >
> > You appear to be saying that when wakeup is disabled, unplugging a
> > device will wake up the system -- but when wakeup is enabled, unplugging
> > a device will not wake up the system!
> 
> No, what I was saying is that when PORT_WKCONN_E and PORT_WKDISC_E are
> set, plugging/unplugging USB doesn't wake up the system from suspended
> state.

Setting those bits tells the controller hardware what to do when a 
connect or disconnect event occurs.  Whether the controller's actions 
will end up waking up the system depends on other settings, such as the 
PCI/ACPI PME# settings.

However, if those bits are not set then the controller should not 
generate a wakeup request in response to a connect or disconnect event.

> What it really does for this case is to hinder the suspending process.

Do you mean that if bits are set then the host controller generates a 
wakeup signal when a connect or disconnect occurs while the system is 
suspending?  And this wakeup signal causes the system suspend to be 
aborted?

Or do you mean that if the bits are clear then somehow the system 
suspend gets aborted?

> > The point I'm trying to get at is that if wakeups are disabled for both
> > the host controller and the root hub then _nothing_ should generate an
> > interrupt or wakeup request.  Not pressing a key, not unplugging a
> > device... nothing.  But if wakeup _is_ enabled for both the controller
> > and the root hub, then any of those actions should generate an interrupt
> > and wake up the system.
> 
> Like above, the wakeup I mentioned is on the USB touchpanel itself,
> not on the controller and roothub.

Do you mean that the touchpanel sends a wakeup signal through some other 
route, not over the USB bus?  Or do you mean that the touchpanel 
generates a wakeup signal and sends it over the USB bus to the root 
hub?

> There's no IRQ generated when controller's wakeup is disabled.

That's what you would expect.


> > If wakeup is enabled for the host controller but not for the root hub,
> > then unplugging a device from the root hub should not generate a wakeup
> > request or an interrupt.  But things like pressing a key on a
> > wakeup-enabled keyboard should.  (In other words, the root hub shouldn't
> > generate any wakeup requests on its own but it should relay wakeup
> > requests that it receives from downstream devices.)  However, it's
> > understandable if the system doesn't behave properly in this case since
> > it's kind of an odd situation.
> 
> Do you mean when the system is suspended, or system is still suspending?

Both.  The above applies any time the root hub is suspended.

> The issue only happens when the system is suspending.

What you need is something you can test manually, so that you can really 
tell what's going on.  For example, you could add a 10-second delay at 
some point in the xhci suspend routine and try plugging or unplugging a 
device during that delay.  What happens if the delay is at the start of 
the suspend routine?  What happens if the delay is at the end?  At what 
point in the routine does the behavior change?  What do the port status 
bits show?  You get the idea.

Alan Stern
