Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3596D7BE547
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376855AbjJIPqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346635AbjJIPqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:46:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBEFA6;
        Mon,  9 Oct 2023 08:46:02 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696866360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XH23ZMvqgrmaeRSjhLmgU15jQm5qtsIZN6JJfhQAze0=;
        b=4b1lzjesqSd+9oWwnDHeBz1GobWMhQ5zprubpgC55W1fswn45mIN6K8cR7ev20hWHGtx1D
        +ealOFOeu/GBFVfEI1M5ZxWjvitHYE/f24WMBm1qxP17mLKLwF5eDUaElyFhiKxJpgE536
        KTnotnqIvWfRu4BWqAYPiMyKFxg4epay4Gy3h4cpA9g3IzC1WjGNml+Bew+fMA/A8sqw7c
        Spa1HA3cy5E6ro3rddIQbkCV+bInrIGjotbn3NnTT5iU8MZ27kB6ifAqZCEPEdTIx4NFIB
        I8z8EVKmto/39MI7wFfC07CaYuBget53aD06jZnI13ltseNLRWq3jQHFjrKJSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696866360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XH23ZMvqgrmaeRSjhLmgU15jQm5qtsIZN6JJfhQAze0=;
        b=DrR9+n7CvmlYXklFRDhT9Do4W7N6vo99qz5PEq6P3PFaAZU727vzOjm8ZbrnYyqbiVsYPt
        6gytuckpAXk54dAA==
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.au@gmail.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] alarmtimer: Fix rebind failure
In-Reply-To: <TYCPR01MB112697A5D4B57101CDE27C88D86CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20230922081208.26334-1-biju.das.jz@bp.renesas.com>
 <87il7fq1al.ffs@tglx>
 <TYCPR01MB112697A5D4B57101CDE27C88D86CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Date:   Mon, 09 Oct 2023 17:46:00 +0200
Message-ID: <87fs2jpznr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09 2023 at 15:30, Biju Das wrote:
>> Subject: Re: [PATCH v2] alarmtimer: Fix rebind failure
>> 
>> On Fri, Sep 22 2023 at 09:12, Biju Das wrote:
>> > +static void alarmtimer_rtc_remove_device(struct device *dev) {
>> > +	struct rtc_device *rtc = to_rtc_device(dev);
>> > +
>> > +	if (rtcdev == rtc) {
>> > +		module_put(rtc->owner);
>> > +		if (device_may_wakeup(rtc->dev.parent))
>> > +			device_init_wakeup(&alarmtimer_pdev->dev, false);
>> > +
>> > +		platform_device_unregister(alarmtimer_pdev);
>> > +		put_device(dev);
>> > +		alarmtimer_pdev = NULL;
>> > +		rtcdev = NULL;
>> > +	}
>> 
>> That's broken versus alarmtimer_get_rtcdev() and any user of it.
>
> You mean we should update[1] (charger-manager driver)as it is the one
> using alarmtimer_get_rtcdev()??

# git grep -c alarmtimer_get_rtcdev
drivers/power/supply/charger-manager.c:1
include/linux/alarmtimer.h:2
kernel/time/alarmtimer.c:10

Thanks,

        tglx
