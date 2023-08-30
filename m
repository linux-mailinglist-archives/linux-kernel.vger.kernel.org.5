Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B4078E383
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344522AbjH3XuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjH3XuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:50:05 -0400
X-Greylist: delayed 4199 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 16:50:02 PDT
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D74CC;
        Wed, 30 Aug 2023 16:50:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B92F2CE1F43;
        Wed, 30 Aug 2023 21:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF2DC433C7;
        Wed, 30 Aug 2023 21:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693430172;
        bh=MFcgEPzadrj8OBEPDc4xZvWqz8FVULHxOHOFHETze94=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Gnt4JGiX0C8dQpoa6f+FB9sFqf8/CzfwR0o7H7uij54rg9bVazAz7he1VxePlg+Er
         cvBCI55ETH3vYDq4awZwBnEf9OiYrHzCUNrRZUOk0+n0eGPvHFO6ENJyXVTrzLEILv
         r8clBWvr2nHEWwivdR43RDT9hSczqUl0XK7zwLVq6N9tP25U66YRMj8MTAmI8t1s3B
         xjUqPSOw63mgs3iNqOc/vX99Eq5BOP98Pt5exaPHhX44OR5qWFkVEtdhWlDvGr23Q1
         OYoFtHflC8RLCr1Ax+eGV2sQEGvPEozMQ7m4dkLlWVG0FM6uJYSSH1PxdWhGiRvGUN
         SxKtSRPZ0irIg==
Message-ID: <8bde38a9e447fc4c3a8834220a3073fa.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <afa30d68-4f53-4903-b470-0d337c9aa7aa@roeck-us.net>
References: <20230817225537.4053865-1-linux@roeck-us.net> <20230817225537.4053865-3-linux@roeck-us.net> <6991631008bab403e957534d6d05360c.sboyd@kernel.org> <afa30d68-4f53-4903-b470-0d337c9aa7aa@roeck-us.net>
Subject: Re: [PATCH v2 2/7] rtc: alarmtimer: Use maximum alarm time offset
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Wed, 30 Aug 2023 14:16:09 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Guenter Roeck (2023-08-30 00:13:09)
> On 8/29/23 14:50, Stephen Boyd wrote:
> > Quoting Guenter Roeck (2023-08-17 15:55:32)
> >> Some userspace applications use timerfd_create() to request wakeups af=
ter
> >> a long period of time. For example, a backup application may request a
> >> wakeup once per week. This is perfectly fine as long as the system does
> >> not try to suspend. However, if the system tries to suspend and the
> >> system's RTC does not support the required alarm timeout, the suspend
> >> operation will fail with an error such as
> >>
> >> rtc_cmos 00:01: Alarms can be up to one day in the future
> >> PM: dpm_run_callback(): platform_pm_suspend+0x0/0x4a returns -22
> >> alarmtimer alarmtimer.4.auto: platform_pm_suspend+0x0/0x4a returned -2=
2 after 117 usecs
> >> PM: Device alarmtimer.4.auto failed to suspend: error -22
> >>
> >> This results in a refusal to suspend the system, causing substantial
> >> battery drain on affected systems.
> >>
> >> To fix the problem, use the maximum alarm time offset as reported by r=
tc
> >> drivers to set the maximum alarm time. While this will result in brief
> >> spurious wakeups from suspend, it is still much better than not suspen=
ding
> >> at all.
> >>
> >> Cc: Brian Norris <briannorris@chromium.org>
> >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> ---
> >> v2: Rename range_max_offset -> alarm_offset_max
> >>
> >>   kernel/time/alarmtimer.c | 13 +++++++++++++
> >>
> >> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> >> index 8d9f13d847f0..895e3a6d6444 100644
> >> --- a/kernel/time/alarmtimer.c
> >> +++ b/kernel/time/alarmtimer.c
> >> @@ -290,6 +290,19 @@ static int alarmtimer_suspend(struct device *dev)
> >>          rtc_timer_cancel(rtc, &rtctimer);
> >>          rtc_read_time(rtc, &tm);
> >>          now =3D rtc_tm_to_ktime(tm);
> >> +
> >> +       /*
> >> +        * If the RTC alarm timer only supports a limited time offset,=
 set
> >> +        * the alarm time to the maximum supported value.
> >> +        * The system will wake up earlier than necessary and is expec=
ted
> >> +        * to go back to sleep if it has nothing to do.
> >=20
> > Does this assume that the kernel is configured for autosuspend
> > (CONFIG_PM_AUTOSLEEP)? Maybe we should only do this when that config is
> > enabled.
> >=20
>=20
> It doesn't really assume anything. It standardizes behavior if the rtc
> does not support the requested alarm time. Today that either fails
> or the rtc silently adjusts the alarm time (sometimes to 1 day + 1 minute=
 ->
> one minute) depending on the implementation in the rtc driver. With this
> patch in place, the the rtc driver informing the rtc core about the limit,
> the alarm would fire at the maximum time supported by the rtc if the
> requested alarm time is larger than its limit.
>=20
> I see that as improvement, no matter if CONFIG_PM_AUTOSLEEP is enabled or=
 not.

Agreed. It's an improvement.

The ABI of alarmtimers seem to be "Run this timer at time X, and wake up
the system from suspend if necessary to run the timer at time X".

>=20
> > If userspace is the one autosuspending, then I don't know what we do, or
> > how the kernel knows it is OK. Maybe we need another alarmtimer clock id
> > that will fail creation if the wakeup time is larger than what the rtc
> > can be programmed for? Or maybe that new clock id can have this fixed
> > behavior to wakeup early with the assumption that userspace will go back
> > to sleep, and outdated userspace can use the original alarmtimer clock
> > id if they don't care about suspend failing?
> >=20
>=20
> I don't know how to answer this. Again, I see my suggested patch as impro=
vement
> over not suspending at all or resuming at a more or less random time, whi=
ch
> is what you get today depending on the rtc driver.
>=20
> Actually, I would argue that the above situation applies even if the rtc =
supports
> the requested alarm time. Currently, if userspace is the one autosuspendi=
ng,
> the system wakes up after the alarm time expires (assuming the rtc suppor=
ts it).
> Then what ? Your above question applies to that situation as well and is
> really independent of the alarm time limit supported by the rtc.

The comment in the code is causing me confusion. It says

  The system will wake up earlier than necessary and is expected
  to go back to sleep if it has nothing to do.

I'd reword this to not talk about auto-suspend because the ABI of
alarmtimers doesn't concern itself with autosuspend.

  The system will wake up earlier (possibly much earlier) than when the
  alarmtimer runs. This is the best the kernel can do because the
  alarmtimer exceeds the time that the rtc device can be programmed for.

>=20
> I would agree that various improvements on how to handle the situation wh=
ere
> the requested alarm time is larger than the rtc limit may be possible,
> but I see those as independent and orthogonal to this patch.

I certainly hope that userspace isn't relying on the existing behavior.

>=20
> > I see another problem too. What do we do if an alarmtimer is created,
> > the rtc device is unregistered, and then we enter suspend? It looks like
> > alarmtimer_suspend() bails out early with no error, so suspend
> > continues. That looks wrong. Presumably we should fail suspend entirely
> > at that point because we'll never be able to wakeup to run the
> > alarmtimer.
>=20
> Maybe I am missing something, but I think this is equivalent of not having
> an rtc in the system, or for CONFIG_RTC_CLASS=3Dn. Currently the system j=
ust
> suspends without waking up in those situations. Changing that would be a
> substantial functional change since suddenly systems without rtc would
> simply fail to suspend if there is a pending alarm.

We fail alarmtimer creation in the case that CONFIG_RTC_CLASS=3Dn or when
there isn't an rtc. See alarmtimer_get_rtcdev() and how it is called. I
doubt it ever really happens in practice, but it looks possible to
simulate by unbinding the rtc device driver.
