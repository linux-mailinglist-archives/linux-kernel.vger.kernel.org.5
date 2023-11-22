Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A577F44D7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343687AbjKVLWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343649AbjKVLWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:22:41 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318D9B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:22:38 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r5lJ7-0007CM-Sz; Wed, 22 Nov 2023 12:22:13 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1r5lJ7-00AnbT-0P; Wed, 22 Nov 2023 12:22:13 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r5lJ6-003I31-Ta; Wed, 22 Nov 2023 12:22:12 +0100
Date:   Wed, 22 Nov 2023 12:22:12 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-mmc@vger.kernel.org, kernel@pengutronix.de,
        Ye Bin <yebin10@huawei.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Naresh Solanki <naresh.solanki@9elements.com>,
        zev@bewilderbeest.net, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org,
        =?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: mmc: handling of Under-Voltage Events in eMMC
Message-ID: <20231122112212.GA783262@pengutronix.de>
References: <20230929130028.GB2825985@pengutronix.de>
 <CAPDyKFqUtNEbK2tzD+qOK+dFcDyBxvcNwOHWPJDLhTWGGkoHQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDyKFqUtNEbK2tzD+qOK+dFcDyBxvcNwOHWPJDLhTWGGkoHQw@mail.gmail.com>
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

Hi Ulf, Hi Mark,

On Tue, Oct 10, 2023 at 04:48:24PM +0200, Ulf Hansson wrote:
> On Fri, 29 Sept 2023 at 15:00, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >
> > Hi,
> >
> > I'm working on a project aiming to protect eMMC during power loss. Our
> > hardware setup includes an under-voltage detector, circuits to disable
> > non-critical components, and enough capacitance to allow the CPU to run
> > for 100ms.
> >
> > I've added an interrupt handler to the fixed regulator to emit
> > REGULATOR_EVENT_UNDER_VOLTAGE events, and modified
> > drivers/mmc/host/sdhci.c to receive these events. Currently, the handler
> > only produces debug output.
> >
> > What is the recommended approach for handling under-voltage situations?
> > Should the driver finish ongoing write commands, block new ones, and
> > shut down the eMMC? I'm looking for direction here.
> 
> That's indeed a very good question. From a general point of view, I
> think the best we can do is to stop any new I/O requests from being
> managed - and try to complete only the last ongoing one, if any.
> Exactly how to do that can be a bit tricky though.
> 
> Beyond that, we should probably try to send the eMMC specific commands
> that allow us to inform the eMMC that it's about to be powered-off.
> Although, I am not sure that we actually will be able to complete
> these operations within 100ms, so maybe it's not really worth trying?
> See mmc_poweroff_notify(), for example.

Some puzzle parts are now mainline, for example regulator framework
can be configured to detect under-voltage events and execute
hw_protection_shutdown(). So far it worked good enough to complete
mmc_poweroff_notify() withing 100ms window. The problem is, the chance to
execute mmc_poweroff_notify() depends on kernel configuration. If there are too
many drivers and devices, mmc_poweroff_notify() will be not executed in time.

For now, I workaround it by registering a reboot notifier for mmc shutdown.
It works, because kernel_power_off() is executing all registered reboot
notifiers at first place and there are no other slow reboot notifiers.
But, it seems to be not reliable enough. Probably notifier prioritization
is needed to make it more predictable.

So far, I have two variants to implement it in more predictable way:
variant 1 - forward the under-voltage notification to the mmc framework and
  execute mmc_poweroff_notify() or bus shutdown.
variant 2 - use reboot notifier and introduce reboot notifier prioritization.

Are there other options? What are your preferences?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
