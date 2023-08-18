Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705E9780433
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357436AbjHRDJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357461AbjHRDI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:08:56 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 267AB3A96
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 20:08:54 -0700 (PDT)
Received: (qmail 17988 invoked by uid 1000); 17 Aug 2023 23:08:53 -0400
Date:   Thu, 17 Aug 2023 23:08:53 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     mathias.nyman@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci: Disable connect, disconnect and over-current
 wakeup on system suspend
Message-ID: <b08553d7-017e-477c-b18e-8564fe88646b@rowland.harvard.edu>
References: <20230817093305.212821-1-kai.heng.feng@canonical.com>
 <cab8a29b-816c-41c7-8d2a-418f787e406e@rowland.harvard.edu>
 <59898e32-f2ea-4df7-947b-3d74835ff9b7@rowland.harvard.edu>
 <CAAd53p5pxGfS0y260NsMF+m_Ota+d1ZKbtdq4dfM5s+T1z14bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p5pxGfS0y260NsMF+m_Ota+d1ZKbtdq4dfM5s+T1z14bw@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 08:01:54AM +0800, Kai-Heng Feng wrote:
> On Thu, Aug 17, 2023 at 10:22 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Thu, Aug 17, 2023 at 10:07:37AM -0400, Alan Stern wrote:
> > > On Thu, Aug 17, 2023 at 05:33:05PM +0800, Kai-Heng Feng wrote:
> > > > HP ProOne 440 G10 AIO sometimes cannot suspend as xHCI wakes up the
> > > > system:
> > > > [  445.814574] hub 2-0:1.0: hub_suspend
> > > > [  445.814652] usb usb2: bus suspend, wakeup 0
> > > > [  445.824629] xhci_hcd 0000:00:14.0: Port change event, 1-11, id 11, portsc: 0x202a0
> > >
> > > What is the meaning of the 0x202a0 bits?  What caused this wakeup?
> >
> > And more to the point, given that the previous line says "wakeup 0", why
> > should any port change event cause a wakeup?
> 
> I think the controller and roothub have to deal with the interrupt
> about disconnecting regardless of the remote wakeup setting.

This seems to contradict what you wrote in an earlier email:

> > If remote wakeup isn't enabled then the do_wakeup variable will be 0,
> > so your patch wouldn't make any difference.  The question is what
> > happens when remote wakeup _is_ enabled.
> 
> Nothing happens either per my testing.
> 
> For USB keyboard, the remote wakeup is enabled, unplugging it when
> suspend is suspended doesn't wake the system up, despite of PORT_WKDISC_E being set.
> Plugging it back doesn't wake the system up either, despite of PORT_WKCONN_E.

You appear to be saying that when wakeup is disabled, unplugging a 
device will wake up the system -- but when wakeup is enabled, unplugging 
a device will not wake up the system!

Is that really what you meant?  It doesn't make sense.  Probably means 
there's a bug in the HCD.

The point I'm trying to get at is that if wakeups are disabled for both 
the host controller and the root hub then _nothing_ should generate an 
interrupt or wakeup request.  Not pressing a key, not unplugging a 
device... nothing.  But if wakeup _is_ enabled for both the controller 
and the root hub, then any of those actions should generate an interrupt 
and wake up the system.

If wakeup is enabled for the host controller but not for the root hub, 
then unplugging a device from the root hub should not generate a wakeup 
request or an interrupt.  But things like pressing a key on a 
wakeup-enabled keyboard should.  (In other words, the root hub shouldn't 
generate any wakeup requests on its own but it should relay wakeup 
requests that it receives from downstream devices.)  However, it's 
understandable if the system doesn't behave properly in this case since 
it's kind of an odd situation.

Alan Stern
