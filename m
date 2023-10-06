Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75857BB355
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjJFIhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjJFIhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:37:16 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3F0295;
        Fri,  6 Oct 2023 01:37:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 13D5F80E0;
        Fri,  6 Oct 2023 08:37:14 +0000 (UTC)
Date:   Fri, 6 Oct 2023 11:37:12 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH] serial: core: Fix checks for tx runtime PM state
Message-ID: <20231006083712.GJ34982@atomide.com>
References: <20231005075644.25936-1-tony@atomide.com>
 <ZR6lc/F1Esxt5ChI@smile.fi.intel.com>
 <20231006072738.GI34982@atomide.com>
 <ZR-_TUSwvIs6Vl_v@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR-_TUSwvIs6Vl_v@hovoldconsulting.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Johan Hovold <johan@kernel.org> [231006 08:03]:
> On Fri, Oct 06, 2023 at 10:27:38AM +0300, Tony Lindgren wrote:
> > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [231005 12:01]:
> > > On Thu, Oct 05, 2023 at 10:56:42AM +0300, Tony Lindgren wrote:
> > > > The serdev device and the serial core controller devices are siblings of
> > > > the serial port hardware device. The runtime PM usage count from serdev
> > > 
> > > I'm a bit lost in terminology here.
> > > AFAIU there are:
> > > 1) children of the serial physical device;
> > > 2) siblings (to each other).
> > > 
> > > But may be I mistakenly deciphered the diagram from the previous discussion.
> > 
> > You're right, so how about:
> > 
> > The serdev device and the serial core controller devices are children of
> > the serial port hardware device. The runtime PM usage count from serdev
> > device does not propagate to the serial core device siblings, it only
> > propagates to the parent.
> 
> That's still not accurate:
> 
>  - the serdev device is not a child (but a grandchild) of the serial
>    controller
>  - the new serial port devices are not "siblings" (but descendants) of
>    the serial controller
>  - the serdev controller ignores the power state of its children so that
>    bit is also incorrect
> 
> You just want to describe the fact that the serdev controller runtime PM
> state is currently not propagated to your new "devices" that are
> descendants to the serial controller.

OK so let's just use:

The serdev controller runtime PM state is not currently propagated
to the serial core controller port device. The runtime PM usage count
only propagates to the parent device.

> I'm still not sure why it was implemented this way, or if it is even
> correct, but this seems to be the state of things.

Care to clarify a bit which parts are unclear? The hierarchy of port
devices, making serial core manage runtime PM in a generic way, or
flushing tx?

Regards,

Tony




