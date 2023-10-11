Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAD27C4C79
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345054AbjJKH7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjJKH7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:59:47 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF19591
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:59:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qqU7w-0006Ab-CQ; Wed, 11 Oct 2023 09:59:32 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qqU7v-000qiI-HM; Wed, 11 Oct 2023 09:59:31 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qqU7v-00Ds9z-EG; Wed, 11 Oct 2023 09:59:31 +0200
Date:   Wed, 11 Oct 2023 09:59:31 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Naresh Solanki <naresh.solanki@9elements.com>,
        zev@bewilderbeest.net, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 3/3] regulator: fixed: forward under-voltage events
Message-ID: <20231011075931.GA3305420@pengutronix.de>
References: <20231010085906.3440452-1-o.rempel@pengutronix.de>
 <20231010085906.3440452-3-o.rempel@pengutronix.de>
 <5e51792a-cc93-4364-a51b-c2b116d89369@sirena.org.uk>
 <20231010125531.GA3268051@pengutronix.de>
 <c2ee404d-d07f-42c6-b5ba-41659773e8eb@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2ee404d-d07f-42c6-b5ba-41659773e8eb@sirena.org.uk>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 06:19:59PM +0100, Mark Brown wrote:
> On Tue, Oct 10, 2023 at 02:55:31PM +0200, Oleksij Rempel wrote:
> 
> > The hardware I am working with has an under-voltage sensor on the 24V
> > supply regulator and some backup capacitors to run SoC for 100ms. I want
> > to forward under-voltage events across a chain of different regulators
> > to a designated consumer. For instance, to the mmc driver, enabling it
> > to initiate shutdown before power loss occurs.  Additionally, a bit can
> > be set in the volatile memory of a scratch pad in an RTC clock to record
> > sudden power loss, which can be checked on the next system start.
> 
> So it sounds like the underlying need is to flag the notifications from
> one of the regulators as being system wide and then take action based on
> those notifications somewhere basically disconnected?  That does seem
> like a good use case.
> 
> The MMC doesn't specifically care that it is handling a regulator
> notification, it more wants to know that the system is dying and doesn't
> really care how we figured that out so if we can hook it into a system
> level notificaiton it'd be happy and would also be able to handle other
> critical faults.  I would have thought that we should have some
> mechanisms for this already for RAS type stuff but I'm drawing a blank
> on what it actually is if there is an existing abstraction.  It could
> potentially go through userspace though there's latency concerns there
> which might not be ideal, there should at least be some policy for
> userspace.

The project I'm working prefers reducing user space daemons to configure and
enforce RAS policies due to time and financial budget constraints. The customer
is inclined to invest only in essential infrastructure.

Configuration through the device tree and kernel defaults is preferable.
For instance, having a default kernel governor that doesn’t require user
space configuration aligns with the project’s objectives.

While a proper UAPI might not be implemented in the first run, the
design will allow for it to be added and extended by other projects in
the future.

> For the regulator itself we probably want a way to identify regulators
> as being system critical so they start notifying.  It would be tempting
> to just do that by default but that would likely cause some issues for
> example with regulators for things like SD cards which are more likely
> to get hardware problems that don't comprimise the entire system.  We
> could do that with DT, either a property or some sort of runtime
> consumer, but it might be better to have a control in sysfs that
> userspace can turn on?  OTOH the ability do something about this depends
> on specific hardware design...
> 
> I've copied in Sebastian since this sounds like the sort of thing that
> power supplies might have some kind of handling for, or at least if we
> need to add something we should make it so that the power supplies can
> be joined up to it.  I do see temperature and capacity alerts in the
> sysfs ABI for power supplies, but nothing for voltage.

Thank you for pointing towards the power supply framework. Given the hardware
design of my project, I can envision mapping the following states and
properties within this framework:

1. States:
   - POWER_SUPPLY_STATUS_FULL: When the capacitor is fully charged.
   - POWER_SUPPLY_STATUS_DISCHARGING: Triggered when an under-voltage event is
                                      detected.

2. Technology:
   - POWER_SUPPLY_TECHNOLOGY_CAPACITOR

3. Capacity Level:
   - Post under-voltage detection, the system would immediately transition to
     POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL state.

4. Properties:
   - POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW: 100ms, representing the time until
                                          complete power loss.
   - POWER_SUPPLY_TYPE_MAINS: Under normal operation.
   - POWER_SUPPLY_TYPE_BATTERY: Triggered when under-voltage is detected.

Considering the above mapping, my initial step would be to create a simple
regulator coupled (if regulator is still needed in this casr) with a Device
Tree (DT) based power supply driver.  This setup would align with the existing
power supply framework, with a notable extension being the system-wide
notification for emergency shutdown upon under-voltage detection.

> I've also coped in Naresh and Zev who've been discussing something
> vaugely similar with userspace notifications for the userspace consumer
> - it's not the same thing given that you don't specifically need
> userspace to be involved here but it feels like it might have something
> of a similar shape, or at least there might be some shared interest.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
