Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A95C777F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjHJRen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbjHJRel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:34:41 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4B41D26A0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 10:34:40 -0700 (PDT)
Received: (qmail 243746 invoked by uid 1000); 10 Aug 2023 13:34:39 -0400
Date:   Thu, 10 Aug 2023 13:34:39 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Cc:     bjorn@mork.no, davem@davemloft.net, edumazet@google.com,
        eniac-xw.zhang@hp.com, hayeswang@realtek.com, jflf_kernel@gmx.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, stable@vger.kernel.org, svenva@chromium.org
Subject: Re: [PATCH v2] r8152: Suspend USB device before shutdown when WoL is
 enabled
Message-ID: <78e3aade-2a88-42f4-9991-8e245f3eb9b9@rowland.harvard.edu>
References: <3c4fd3d8-2b0b-492e-aacc-afafcea98417@rowland.harvard.edu>
 <20230810162216.13455-1-alexandru.gagniuc@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810162216.13455-1-alexandru.gagniuc@hp.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 04:22:16PM +0000, Alexandru Gagniuc wrote:
> From: Alan Stern <stern@rowland.harvard.edu>
> 
> On Wed, Aug 02, 2023 at 11:23:46AM -0400, Alan Stern wrote:
> > On Wed, Aug 02, 2023 at 02:56:43PM +0000, Gagniuc, Alexandru wrote:
> > > On Wed, Jul 19, 2023 at 02:36:25PM -0400, Alan Stern wrote:
> > > > How do you know that the link will _remain_ in the correct state?
> > > 
> > > The objective is to get to xhci_set_link_state() with the USB_SS_PORT_LS_U3
> > > argument. This is achieved through usb_port_suspend() in drivers/usb/host/hub.c,
> > > and the function is implemented in drivers/usb/host/xhci-hub.c.
> > > 
> > > This is the only path in the kernel that I am aware of for setting the U3 link
> > > state. Given that it is part of the USB subsystem, I am fairly confident it will
> > > show consistent behavior across platforms.
> > 
> > That does not answer my question.  I agree that making this change will 
> > put the link into the U3 state.  But I don't have any reason to think 
> > that some other software won't later put the link into some other state.
> 
> I don't have a rigurous proof that the link will remain in the correct state.
> The only conjecture that I can make is that no other software besides the kernel
> will be running at this time. Thus, if the kernel manages to not break the link
> state, things should work as intended.
> 
> > > > That is, how do you know that the shutdown processing for the USB host 
> > > > controller won't disable the link entirely, thereby preventing WoL from 
> > > > working?
> > > 
> > > We are talking to the USB hub in order to set the link state. I don't see how
> > > specifics of the host controller would influence behavior.
> > 
> > Specifics of the host controller probably won't influence behavior.  
> > However, specifics of the _software_ can make a big difference.
> > 
> > >  I do expect a
> > > controller which advertises S4/S5 in /proc/acpi/wakeup to not do anything that
> > > would sabotage this capability. Disabling the link entirely would probalby
> > > violate that promise.
> > 
> > Not if the kernel _tells_ the controller to disable the link.
> > 
> > > Think of USB-C docks with a power button showing up as a HID class. The scenario
> > > herein would disable the power button. I would take that to be a bug in the host
> > > controller driver if the S4/S5 capability is advertised.
> > 
> > Indeed.  And I am asking how you can be sure the host controller driver 
> > (or some other part of the software stack) doesn't have this bug.
> 
> The only way that I have to show that is empirical. I observe that WoL from S5
> does not work on a device with an r8153 chip. I apply the change, and verify
> that WoL from S5 now works in this scenario. What are you thinking of in terms
> of being sure no current or future bug exists?

I was thinking that the host controller driver's shutdown method might 
turn off power to all of the ports.

For example, in the ehci-hcd driver, ehci_shutdown() calls 
ehci_silence_controller(), which calls ehci_turn_off_all_ports().  I 
don't know if xhci-hcd does anything similar.

Alan Stern
