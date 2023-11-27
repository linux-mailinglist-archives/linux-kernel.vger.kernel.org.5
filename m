Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CDF7F9EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjK0LoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjK0LoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:44:15 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F2118A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:44:21 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r7a27-0003bW-A7; Mon, 27 Nov 2023 12:44:11 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1r7a26-00Bvlk-Fb; Mon, 27 Nov 2023 12:44:10 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r7a26-0045Qh-Cp; Mon, 27 Nov 2023 12:44:10 +0100
Date:   Mon, 27 Nov 2023 12:44:10 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Christian Loehle <christian.loehle@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        =?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <20231127114410.GE877872@pengutronix.de>
References: <2023112520-paper-image-ef5d@gregkh>
 <20231125085038.GA877872@pengutronix.de>
 <2023112506-unselfish-unkind-adcb@gregkh>
 <ZWHM0lRPOp/efyD5@finisterre.sirena.org.uk>
 <2023112541-uptown-tripping-05f3@gregkh>
 <ZWIWBhBN8AmK7tAJ@finisterre.sirena.org.uk>
 <2023112504-cathedral-pulmonary-83ce@gregkh>
 <ZWMaMIGUo9DeyEH+@finisterre.sirena.org.uk>
 <20231126193125.GB877872@pengutronix.de>
 <8ffb32c8-907c-4266-b8be-c7309418b9f0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ffb32c8-907c-4266-b8be-c7309418b9f0@arm.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 11:27:31AM +0000, Christian Loehle wrote:
> On 26/11/2023 19:31, Oleksij Rempel wrote:
> > On Sun, Nov 26, 2023 at 10:14:45AM +0000, Mark Brown wrote:
> >> On Sat, Nov 25, 2023 at 07:58:12PM +0000, Greg Kroah-Hartman wrote:
> >>> On Sat, Nov 25, 2023 at 03:43:02PM +0000, Mark Brown wrote:
> >>>> On Sat, Nov 25, 2023 at 02:35:41PM +0000, Greg Kroah-Hartman wrote:
> >>
> >>>>> That would be great, but I don't see that here, do you?  All I see is
> >>>>> the shutdown sequence changing because someone wants it to go "faster"
> >>>>> with the threat of hardware breaking if we don't meet that "faster"
> >>>>> number, yet no knowledge or guarantee that this number can ever be known
> >>>>> or happen.
> >>
> >>>> The idea was to have somewhere to send notifications when the hardware
> >>>> starts reporting things like power supplies starting to fail.  We do
> >>>> have those from hardware, we just don't do anything terribly useful
> >>>> with them yet.
> >>
> >>> Ok, but that's not what I recall this patchset doing, or did I missing
> >>> something?  All I saw was a "reorder the shutdown sequence" set of
> >>> changes.  Or at least that's all I remember at this point in time,
> >>> sorry, it's been a few days, but at least that lines up with what the
> >>> Subject line says above :)
> >>
> >> That's not in the series, a bunch of it is merged in some form (eg, see
> >> hw_protection_shutdown()) and more of it would need to be built on top
> >> if this were merged.
> > 
> > The current kernel has enough infrastructure to manage essential functions
> > related to hardware protection:
> > - The Device Tree specifies the source of interrupts for detecting
> >   under-voltage events. It also details critical system regulators and some
> >   of specification of backup power supplied by the board.
> > - Various frameworks within the kernel can identify critical hardware
> >   conditions like over-temperature and under-voltage. Upon detection, these
> >   frameworks invoke the hw_protection_shutdown() function.
> > 
> >>>>> Agreed, but I don't think this patch is going to actually work properly
> >>>>> over time as there is no time values involved :)
> > 
> > If we're to implement a deadline for each shutdown call (as the requirement for
> > "time values" suggests?), then prioritization becomes essential. Without
> > establishing a shutdown order, the inclusion of time values might not be
> > effectively utilized.  Am I overlooking anything in this regard?
> > 
> >>>> This seems to be more into the area of mitigation than firm solution, I
> >>>> suspect users will be pleased if they can make a noticable dent in the
> >>>> number of failures they're seeing.
> >>
> >>> Mitigation is good, but this patch series is just a hack by doing "throw
> >>> this device type at the front of the shutdown list because we have
> >>> hardware that crashes a lot" :)
> > 
> > The root of the issue seems to be the choice of primary storage device.
> > 
> > All storage technologies - HDD, SSD, eMMC, NAND - are vulnerable to power
> > loss. The only foolproof safeguard is a backup power source, but this
> > introduces its own set of challenges:
> 
> I disagree and would say that any storage device sold as "industrial" should
> guarantee power-fail safety. Plus, you mentioned data loss isn't even your concern,
> but the storage device fails/bricks.
> > 
> > 1. Batteries: While they provide a backup, they come with limitations like a
> > finite number of charge cycles, sensitivity to temperature (a significant
> > concern in industrial and automotive environments), higher costs, and
> > increased device size. For most embedded applications, a UPS isn't a viable
> > solution.
> > 
> > 2. Capacitors: A potential alternative, but they cannot offer prolonged
> > backup time. Increasing the number of capacitors to extend backup time leads
> > to additional issues:
> >    - Increased costs and space requirements on the PCB.
> >    - The need to manage partially charged capacitors during power failures.
> >    - The requirement for a power supply capable of rapid charging.
> >    - The risk of not reaching a safe state before the backup energy
> >      depletes.
> >    - In specific environments, like explosive atmospheres, storing large
> >      amounts of energy can be hazardous.
> 
> And also just practically, ensuring a safe power down could be in the order
> of a second, so it would be quite a capacitor.
> 
> > 
> > Given these considerations, it's crucial to understand that such design choices
> > aren't merely "hacks". They represent a balance between different types of
> > trade-offs.
> > 
> >>>> It feels like if we're concerned about mitigating physical damage during
> >>>> the process of power failure that's a very limited set of devices - the
> >>>> storage case where we're in the middle of writing to flash or whatever
> >>>> is the most obvious case.
> >>
> >>> Then why isn't userspace handling this?  This is a policy decision that
> >>> it needs to take to properly know what hardware needs to be shut down,
> >>> and what needs to happen in order to do that (i.e. flush, unmount,
> >>> etc.?)  And userspace today should be able to say, "power down this
> >>> device now!" for any device in the system based on the sysfs device
> >>> tree, or at the very least, force it to a specific power state.  So why
> >>> not handle this policy there?
> >>
> >> Given the tight timelines it does seem reasonable to have some of this
> >> in the kernel - the specific decisions about how to handle these events
> >> can always be controlled from userspace (eg, with a sysfs file like we
> >> do for autosuspend delay times which seem to be in a similar ballpark).
> > 
> > Upon investigating the feasibility of a user space solution for eMMC
> > power control, I've concluded that it's likely not possible. The primary
> > issue is that most board designs don't include reset signaling for
> > eMMCs. Additionally, the eMMC power rail is usually linked to the
> > system's main power controller. While powering off is doable, cleanly
> > powering it back on isn’t feasible. This is especially problematic when
> > the rootfs is located on the eMMC, as power cycling the storage device
> > could lead to system instability.
> > 
> > Therefore, any user space method to power off eMMC wouldn't be reliable
> > or safe, as there's no way to ensure it can be turned back on without
> > risking the integrity of the system. The design rationale is clear:
> > avoiding the risks associated with powering off the primary storage
> > device.
> > 
> > Considering these constraints, the only practical implementation I see
> > is integrating this functionality into the system's shutdown sequence.
> > This approach ensures a controlled environment for powering off the
> > eMMC, avoiding potential issues.
> 
> You don't need the RST signal, in fact even if you had it it would be
> the wrong thing to do. (Implementation is vendor-specific but RST
> assumes that eMMCs' VCC and VCCQ are left untouched.)

It means, if VCC and VCCQ are off on reboot or watchdog reset, there is
potentially bigger problem?

> You can try turning off eMMC cache completely and/or sending power down
> notification on 'emergency shutdown', but since power-loss/fail behavior
> is vendor-specific asking the storage device vendor how to ensure a safe
> power-down.
> Anyway the proper eMMC power-down methods are up to a second in timeouts,
> so infeasible for your requirements from what I can see.

Ok. So, increasing capacity at least to one second should be main goal
for now? But even if capacity is increased, emergency shutdown should
notify eMMCs as early as possible? 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
