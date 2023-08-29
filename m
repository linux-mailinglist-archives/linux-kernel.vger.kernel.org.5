Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B06578CEF8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbjH2Vue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238557AbjH2Vu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8CA107;
        Tue, 29 Aug 2023 14:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 976216351E;
        Tue, 29 Aug 2023 21:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEF4C433C8;
        Tue, 29 Aug 2023 21:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693345822;
        bh=U/l32QlMVAaPte5bD4QT0elttRsFrPc4ZIwaQ1O0ouY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bOUwFzvKtT45GrRxfuvHLwAW81f7eBzSXr9zZ6oaZcTfDGqYd9msBEzj0595LDRIE
         36EDKxwgGRZjgYRD2aomvhojeEuoQA7qLFtavjRLMzce3wSS5+35vAtCu2rx27erN5
         FHZ18oZuPweRMSCWGFJ7AUBbXJP0EKwbN+Z7tlexaQVV+BggiQkENQt3QA+5eCqj56
         BRiH8spWV+dcUJScphSNeguYTDWG3vgDP6vhRA1JuU+9EMlyd1Y5HeFavpTRiCJ7UM
         FCiPJd27lBIEWE/5OpqdVwTgdGafWlkfu1SgS0oUnTyVA8Armq9WBcL55Jb/C+4Vr9
         xyTAeqlSRVVsg==
Message-ID: <6991631008bab403e957534d6d05360c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230817225537.4053865-3-linux@roeck-us.net>
References: <20230817225537.4053865-1-linux@roeck-us.net> <20230817225537.4053865-3-linux@roeck-us.net>
Subject: Re: [PATCH v2 2/7] rtc: alarmtimer: Use maximum alarm time offset
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Tue, 29 Aug 2023 14:50:19 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Guenter Roeck (2023-08-17 15:55:32)
> Some userspace applications use timerfd_create() to request wakeups after
> a long period of time. For example, a backup application may request a
> wakeup once per week. This is perfectly fine as long as the system does
> not try to suspend. However, if the system tries to suspend and the
> system's RTC does not support the required alarm timeout, the suspend
> operation will fail with an error such as
>=20
> rtc_cmos 00:01: Alarms can be up to one day in the future
> PM: dpm_run_callback(): platform_pm_suspend+0x0/0x4a returns -22
> alarmtimer alarmtimer.4.auto: platform_pm_suspend+0x0/0x4a returned -22 a=
fter 117 usecs
> PM: Device alarmtimer.4.auto failed to suspend: error -22
>=20
> This results in a refusal to suspend the system, causing substantial
> battery drain on affected systems.
>=20
> To fix the problem, use the maximum alarm time offset as reported by rtc
> drivers to set the maximum alarm time. While this will result in brief
> spurious wakeups from suspend, it is still much better than not suspending
> at all.
>=20
> Cc: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Rename range_max_offset -> alarm_offset_max
>=20
>  kernel/time/alarmtimer.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> index 8d9f13d847f0..895e3a6d6444 100644
> --- a/kernel/time/alarmtimer.c
> +++ b/kernel/time/alarmtimer.c
> @@ -290,6 +290,19 @@ static int alarmtimer_suspend(struct device *dev)
>         rtc_timer_cancel(rtc, &rtctimer);
>         rtc_read_time(rtc, &tm);
>         now =3D rtc_tm_to_ktime(tm);
> +
> +       /*
> +        * If the RTC alarm timer only supports a limited time offset, set
> +        * the alarm time to the maximum supported value.
> +        * The system will wake up earlier than necessary and is expected
> +        * to go back to sleep if it has nothing to do.

Does this assume that the kernel is configured for autosuspend
(CONFIG_PM_AUTOSLEEP)? Maybe we should only do this when that config is
enabled.

If userspace is the one autosuspending, then I don't know what we do, or
how the kernel knows it is OK. Maybe we need another alarmtimer clock id
that will fail creation if the wakeup time is larger than what the rtc
can be programmed for? Or maybe that new clock id can have this fixed
behavior to wakeup early with the assumption that userspace will go back
to sleep, and outdated userspace can use the original alarmtimer clock
id if they don't care about suspend failing?

I see another problem too. What do we do if an alarmtimer is created,
the rtc device is unregistered, and then we enter suspend? It looks like
alarmtimer_suspend() bails out early with no error, so suspend
continues. That looks wrong. Presumably we should fail suspend entirely
at that point because we'll never be able to wakeup to run the
alarmtimer.
