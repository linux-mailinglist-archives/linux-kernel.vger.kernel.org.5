Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFD07F950E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 20:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjKZTbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 14:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjKZTba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 14:31:30 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3931AF5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 11:31:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r7Kql-00018N-Rj; Sun, 26 Nov 2023 20:31:27 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1r7Kqj-00BmLa-Jv; Sun, 26 Nov 2023 20:31:25 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r7Kqj-003xyJ-HE; Sun, 26 Nov 2023 20:31:25 +0100
Date:   Sun, 26 Nov 2023 20:31:25 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        =?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <20231126193125.GB877872@pengutronix.de>
References: <2023112453-flagstick-bullring-8511@gregkh>
 <20231124185725.GA872366@pengutronix.de>
 <2023112520-paper-image-ef5d@gregkh>
 <20231125085038.GA877872@pengutronix.de>
 <2023112506-unselfish-unkind-adcb@gregkh>
 <ZWHM0lRPOp/efyD5@finisterre.sirena.org.uk>
 <2023112541-uptown-tripping-05f3@gregkh>
 <ZWIWBhBN8AmK7tAJ@finisterre.sirena.org.uk>
 <2023112504-cathedral-pulmonary-83ce@gregkh>
 <ZWMaMIGUo9DeyEH+@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWMaMIGUo9DeyEH+@finisterre.sirena.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 10:14:45AM +0000, Mark Brown wrote:
> On Sat, Nov 25, 2023 at 07:58:12PM +0000, Greg Kroah-Hartman wrote:
> > On Sat, Nov 25, 2023 at 03:43:02PM +0000, Mark Brown wrote:
> > > On Sat, Nov 25, 2023 at 02:35:41PM +0000, Greg Kroah-Hartman wrote:
> 
> > > > That would be great, but I don't see that here, do you?  All I see is
> > > > the shutdown sequence changing because someone wants it to go "faster"
> > > > with the threat of hardware breaking if we don't meet that "faster"
> > > > number, yet no knowledge or guarantee that this number can ever be known
> > > > or happen.
> 
> > > The idea was to have somewhere to send notifications when the hardware
> > > starts reporting things like power supplies starting to fail.  We do
> > > have those from hardware, we just don't do anything terribly useful
> > > with them yet.
> 
> > Ok, but that's not what I recall this patchset doing, or did I missing
> > something?  All I saw was a "reorder the shutdown sequence" set of
> > changes.  Or at least that's all I remember at this point in time,
> > sorry, it's been a few days, but at least that lines up with what the
> > Subject line says above :)
> 
> That's not in the series, a bunch of it is merged in some form (eg, see
> hw_protection_shutdown()) and more of it would need to be built on top
> if this were merged.

The current kernel has enough infrastructure to manage essential functions
related to hardware protection:
- The Device Tree specifies the source of interrupts for detecting
  under-voltage events. It also details critical system regulators and some
  of specification of backup power supplied by the board.
- Various frameworks within the kernel can identify critical hardware
  conditions like over-temperature and under-voltage. Upon detection, these
  frameworks invoke the hw_protection_shutdown() function.

> > > > Agreed, but I don't think this patch is going to actually work properly
> > > > over time as there is no time values involved :)

If we're to implement a deadline for each shutdown call (as the requirement for
"time values" suggests?), then prioritization becomes essential. Without
establishing a shutdown order, the inclusion of time values might not be
effectively utilized.  Am I overlooking anything in this regard?

> > > This seems to be more into the area of mitigation than firm solution, I
> > > suspect users will be pleased if they can make a noticable dent in the
> > > number of failures they're seeing.
>
> > Mitigation is good, but this patch series is just a hack by doing "throw
> > this device type at the front of the shutdown list because we have
> > hardware that crashes a lot" :)

The root of the issue seems to be the choice of primary storage device.

All storage technologies - HDD, SSD, eMMC, NAND - are vulnerable to power
loss. The only foolproof safeguard is a backup power source, but this
introduces its own set of challenges:

1. Batteries: While they provide a backup, they come with limitations like a
finite number of charge cycles, sensitivity to temperature (a significant
concern in industrial and automotive environments), higher costs, and
increased device size. For most embedded applications, a UPS isn't a viable
solution.

2. Capacitors: A potential alternative, but they cannot offer prolonged
backup time. Increasing the number of capacitors to extend backup time leads
to additional issues:
   - Increased costs and space requirements on the PCB.
   - The need to manage partially charged capacitors during power failures.
   - The requirement for a power supply capable of rapid charging.
   - The risk of not reaching a safe state before the backup energy
     depletes.
   - In specific environments, like explosive atmospheres, storing large
     amounts of energy can be hazardous.

Given these considerations, it's crucial to understand that such design choices
aren't merely "hacks". They represent a balance between different types of
trade-offs.

> > > It feels like if we're concerned about mitigating physical damage during
> > > the process of power failure that's a very limited set of devices - the
> > > storage case where we're in the middle of writing to flash or whatever
> > > is the most obvious case.
> 
> > Then why isn't userspace handling this?  This is a policy decision that
> > it needs to take to properly know what hardware needs to be shut down,
> > and what needs to happen in order to do that (i.e. flush, unmount,
> > etc.?)  And userspace today should be able to say, "power down this
> > device now!" for any device in the system based on the sysfs device
> > tree, or at the very least, force it to a specific power state.  So why
> > not handle this policy there?
> 
> Given the tight timelines it does seem reasonable to have some of this
> in the kernel - the specific decisions about how to handle these events
> can always be controlled from userspace (eg, with a sysfs file like we
> do for autosuspend delay times which seem to be in a similar ballpark).

Upon investigating the feasibility of a user space solution for eMMC
power control, I've concluded that it's likely not possible. The primary
issue is that most board designs don't include reset signaling for
eMMCs. Additionally, the eMMC power rail is usually linked to the
system's main power controller. While powering off is doable, cleanly
powering it back on isn’t feasible. This is especially problematic when
the rootfs is located on the eMMC, as power cycling the storage device
could lead to system instability.

Therefore, any user space method to power off eMMC wouldn't be reliable
or safe, as there's no way to ensure it can be turned back on without
risking the integrity of the system. The design rationale is clear:
avoiding the risks associated with powering off the primary storage
device.

Considering these constraints, the only practical implementation I see
is integrating this functionality into the system's shutdown sequence.
This approach ensures a controlled environment for powering off the
eMMC, avoiding potential issues.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
