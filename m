Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB877D13EA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjJTQX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377864AbjJTQX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:23:57 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B4C051A4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:23:54 -0700 (PDT)
Received: (qmail 302116 invoked by uid 1000); 20 Oct 2023 12:23:53 -0400
Date:   Fri, 20 Oct 2023 12:23:53 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Grant Grundler <grundler@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ray Chi <raychi@google.com>,
        Ricardo =?iso-8859-1?Q?Ca=F1uelo?= 
        <ricardo.canuelo@collabora.com>, Rob Herring <robh@kernel.org>,
        Roy Luo <royluo@google.com>,
        Stanley Chang <stanley_chang@realtek.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: Prevent infinite loops when
 usb_reset_device() unbinds/binds
Message-ID: <2b6352b1-e192-47d6-bdce-b63216ab674b@rowland.harvard.edu>
References: <20231020083125.1.I3e5f7abcbf6f08d392e31a5826b7f234df662276@changeid>
 <60a358c9-b44b-4d25-9a20-aa9e00c65ab6@rowland.harvard.edu>
 <CAD=FV=VQ22p7iDdzK-CXOBEqpu0b3J=LKRZuPcajQWFUmr=1cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VQ22p7iDdzK-CXOBEqpu0b3J=LKRZuPcajQWFUmr=1cA@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 08:59:42AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Fri, Oct 20, 2023 at 8:46 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, Oct 20, 2023 at 08:31:38AM -0700, Douglas Anderson wrote:
> > > When we call usb_reset_device() and a driver doesn't implement
> > > pre_reset() and post_reset() methods then the USB core will attempt to
> > > unbind and rebind the driver in order to make reset work. This is a
> > > great general solution, but it has the potential to loop forever.
> > > Specifically, if the USB device is in a state that the USB device
> > > driver issues another usb_reset_device() after each rebind then we'll
> > > just continually unbind and rebind with no end.
> > >
> > > It's difficult to address this condition in a USB device driver
> > > because it's hard for the driver to keep state across each
> > > unbind/bind.
> >
> > How about just adding appropriate pre_reset() and post_reset() methods?
> > This is precisely what they are meant for.  Then the the unbind/rebind
> > loop wouldn't ever get started.
> 
> Right, and we have pre_reset() and post_reset() in the r1852 driver.
> The issue is that we are seeing occasional control transfer errors
> while the r8152 driver is still running its probe() routine and we
> want to reset in response to those. It is relatively difficult to have
> the pre_reset() and post_reset() methods work properly if failures
> happen and probe() hasn't finished yet.

Why is that?

>  The current proposal I have
> for the r8152 driver is to have the pre_reset() routine return -EIO if
> we saw errors during probe, which tells the USB core to unbind/rebind
> us. This gets us to a known good state.

Don't you also get to a known good state if pre_reset() and post_reset() 
both return 0?  Then there's no unbinding, so the driver can just jump 
back to the start of its probe() routine.  Or fail the probe, if there 
have been too many errors.

>  If we need to do a reset later
> on (after probe finished successfully) then pre_reset() and
> post_reset() can avoid the unbind/bind.
> 
> The worry was that this could cause an infinite loop. Hence this patch. ;-)

With no unbinding/rebinding, any loops that occur will be entirely under 
the driver's control.  Then it should easily be able to avoid looping 
forever.

Alan Stern
