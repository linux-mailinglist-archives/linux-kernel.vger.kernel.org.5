Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E954C77E49C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343954AbjHPPEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343957AbjHPPD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:03:57 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70532684;
        Wed, 16 Aug 2023 08:03:55 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A64BE20003;
        Wed, 16 Aug 2023 15:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692198234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qH2B3kaqc6zMAtbHFvaHpCR6NMBsAraFbuMNrJUPJig=;
        b=RpxshUiAvUr9lcEJ4n9fSwHREhh9jijfqHo8BkUP8VoYSysXR6U6yalV06QG+HpbhzH5eS
        QG5dovTZorv2NrfyjgNhA6iXA5ciKgXlAhiWKn4zjtqoYPM3nEvEh+LjtGWEnlhjJSCkCY
        VKtNgcaQ+JnKRXN9B94AkHLdpb8fn81PVNUSXDXvsxC82JpZogaytFjUuON7H+FGz0pyJL
        cf5dcfb05sFkKjcXaLzqqCvJZe2ppffPKmD3Im4kCJv0FsYzcTAlOmFALU/NvEcvSNmkGG
        +f5fJClzPkGJk6F22H77Mx4+IQli8/QeQV3SNvSCIQ9TiE9Dp1mjAcn98sWNTg==
Date:   Wed, 16 Aug 2023 17:03:53 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 0/7] rtc: Add support for limited alarm timer offsets
Message-ID: <20230816150353137debc5@mail.local>
References: <20230816133936.2150294-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816133936.2150294-1-linux@roeck-us.net>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 16/08/2023 06:39:29-0700, Guenter Roeck wrote:
> Some alarm timers are based on time offsets, not on absolute times.
> In some situations, the amount of time that can be scheduled in the
> future is limited. This may result in a refusal to suspend the system,
> causing substantial battery drain.
> 
> This problem was previously observed on a Chromebook using the cros_ec
> rtc driver. EC variants on some older Chromebooks only support 24 hours
> of alarm time in the future. To work around the problem on affected
> Chromebooks, code to limit the maximum alarm time was added to the cros_ec
> rtc driver with commit f27efee66370 ("rtc: cros-ec: Limit RTC alarm range
> if needed"). The problem is now seen again on a system using the cmos
> RTC driver on hardware limited to 24 hours of alarm time, so a more
> generic solution is needed.
> 
> Some RTC drivers remedy the situation by setting the alarm time to the
> maximum supported time if a request for an out-of-range timeout is made.
> This is not really desirable since it may result in unexpected early
> wakeups. It would be even more undesirable to change the behavior
> of existing widely used drivers such as the cmos RTC driver.
> 
> The existing range_max variable in struct rtc_device can not be used
> to determine the maximum time offset supported by an rtc chip since
> it describes the maximum absolute time supported by the chip, not the
> maximum time offset that can be set for alarms.
> 
> To reduce the impact of this problem, introduce a new variable
> rtc_time_offset in struct rtc_device to let RTC drivers report the maximum
> supported alarm time offset. The code setting alarm timers can then
> decide if it wants to reject setting alarm timers to a larger value, if it
> wants to implement recurring alarms until the actually requested alarm
> time is met, or if it wants to accept the limited alarm time. Use the new
> variable to limit the alarm timer range.
> 
> The series is intended to solve the problem with minimal changes in the
> rtc core and in affected drivers.
> 
> An alternative I had considered was to have the alarmtimer code guess the
> maximum timeout supported by the rtc hardware. I discarded it as less
> desirable since it had to retry repeatedly depending on rtc limitations.
> This often resulted in error messages by the rtc driver.  On top of that,
> it was all but impossible to support rtc chips such as tps6586x which
> can only support wake alarms up to 16,383 seconds in the future.
> 
> The first patch of the series adds support for providing the maximum
> supported time offset to the rtc core. The second patch uses that value
> in the alarmtimer code to set the maximum wake-up time from system suspend.
> Subsequent patches add support for reporting the maximum alarm timer offset
> to a subset of affected drivers.
> 
> Previous discussion:
>     https://lore.kernel.org/lkml/Y19AdIntJZGnBh%2Fy@google.com/T/#mc06d206d5bdb77c613712148818934b4f5640de5
> 

I'm fine with the series, however, this doesn't solve the issue for RTCs
that have an absolute limit on the alarm (as opposed to an offset to the
current time/date).



> ----------------------------------------------------------------
> Guenter Roeck (7):
>       rtc: Add support for limited alarm timer offsets
>       rtc: alarmtimer: Use maximum alarm time offset
>       rtc: cros-ec: Detect and report supported alarm window size
>       rtc: cmos: Report supported alarm limit to rtc infrastructure
>       rtc: tps6586x: Report maximum alarm limit to rtc core
>       rtc: ds1305: Report maximum alarm limit to rtc core
>       rtc: rzn1: Report maximum alarm limit to rtc core
> 
>  drivers/rtc/rtc-cmos.c     | 11 +++++++++++
>  drivers/rtc/rtc-cros-ec.c  | 38 +++++++++++++++++++++++---------------
>  drivers/rtc/rtc-ds1305.c   |  3 ++-
>  drivers/rtc/rtc-rzn1.c     |  1 +
>  drivers/rtc/rtc-tps6586x.c |  1 +
>  include/linux/rtc.h        |  1 +
>  kernel/time/alarmtimer.c   | 13 +++++++++++++
>  7 files changed, 52 insertions(+), 16 deletions(-)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
