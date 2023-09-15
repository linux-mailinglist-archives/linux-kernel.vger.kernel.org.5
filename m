Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635ED7A2503
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjIORnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjIORnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:43:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A41E7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:42:57 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-404f881aa48so2475e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694799775; x=1695404575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbtlr43kt/diRRH/R7UEHAjjrKVtroV6ieprwTcwbLg=;
        b=3fJsGOKt0HRBb6VDfnXJdncTCw70yaleFUa37+2EKyK0bZBQccdcJrVF9kWFjMottO
         A43q1DLym62cgnZ3l31YhbmU1B928t2i+kk0NQvZNLjHfk3dxyyWMIqRHeTmAUS27wof
         TLGIQBufVf4de1TL9rnFB4AmdqynNJRpIoy67NQMF1I0SgunzDqIlmo9DWXp5j21r5H2
         8zrfP5Gf1yZNWvxvgHKwUt2pugkHDC+b7O90xbBcixJ5U7UQjPKi2cp4RIYIr3Kv4qwm
         B8vZcYCpkfbrVfFupnZnjSBzFUVV5sFTDfLafzPindYEs/e7xncdqxon2QFuUpYI8qEG
         5YRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799775; x=1695404575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbtlr43kt/diRRH/R7UEHAjjrKVtroV6ieprwTcwbLg=;
        b=Lx5uHLYcy+EaO05B9WlrGe0kl649WJ4qkFvGs/opkYpHPV1k7RE4qk0PAxGMH+N+/H
         ycZH1nnXpjmIrINHSq7WWI4mUyeEeaM01mJol0W8fD4CiZvsvYbSEZtcXeQKxG184YY7
         P4OMGcAgDZi24MG696JPRSdCSjQS2+GZ3IgUYwXzaeg6lcbhFdCehxw6elJvFyjgLWBr
         6L06YGEkfNW/bbs0Jr/InnOOD2gOvSwGLDuiWTHOOAaezib42769hAd7j3JdQAnMOJve
         LA2heORO09stxQ3uxvnmdV66JuBeNK5q8loL9iSEwh248BpFYd9n0oC4OBjy8dzoHC0b
         Sctw==
X-Gm-Message-State: AOJu0Yy34awBvzr/eIV7R+AIKOkOx2CbWM5OXaW6jMkKaOsK3C9voOMo
        oDGP5WZNktEdAkzeHevvjrk/86yo1kiYsGNRjqAz
X-Google-Smtp-Source: AGHT+IGEPo9DxoztrrStksAGVAJ9KnnjEkcPrR36gPwW16sHyGBd6hxrsWCoWy477Ya+fqMsPbbMzcWzRSoLwuvJtoY=
X-Received: by 2002:a05:600c:354c:b0:3fe:dd72:13ae with SMTP id
 i12-20020a05600c354c00b003fedd7213aemr15185wmq.0.1694799775385; Fri, 15 Sep
 2023 10:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230915152238.1144706-1-linux@roeck-us.net> <20230915152238.1144706-3-linux@roeck-us.net>
In-Reply-To: <20230915152238.1144706-3-linux@roeck-us.net>
From:   John Stultz <jstultz@google.com>
Date:   Fri, 15 Sep 2023 10:42:43 -0700
Message-ID: <CANDhNCqH6qmkcGk=oi9=W0ggHr_KNsJxd=QZo=9GewbbNTLF_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] rtc: alarmtimer: Use maximum alarm time offset
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 8:22=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> Some userspace applications use timerfd_create() to request wakeups after
> a long period of time. For example, a backup application may request a
> wakeup once per week. This is perfectly fine as long as the system does
> not try to suspend. However, if the system tries to suspend and the
> system's RTC does not support the required alarm timeout, the suspend
> operation will fail with an error such as
>
> rtc_cmos 00:01: Alarms can be up to one day in the future
> PM: dpm_run_callback(): platform_pm_suspend+0x0/0x4a returns -22
> alarmtimer alarmtimer.4.auto: platform_pm_suspend+0x0/0x4a returned -22 a=
fter 117 usecs
> PM: Device alarmtimer.4.auto failed to suspend: error -22
>
> This results in a refusal to suspend the system, causing substantial
> battery drain on affected systems.
>
> To fix the problem, use the maximum alarm time offset as reported by rtc
> drivers to set the maximum alarm time. While this may result in early
> wakeups from suspend, it is still much better than not suspending at all.
>
> This patch standardizes system behavior if the requested alarm timeout
> is larger than the alarm timeout supported by the rtc chip. Currently,
> in this situation, the rtc driver will do one of the following.
> - It may return an error.
> - It may limit the alarm timeout to the maximum supported by the rtc chip=
.
> - It may mask the timeout by the maximum alarm timeout supported by the R=
TC
>   chip (i.e. a requested timeout of 1 day + 1 minute may result in a 1
>   minute timeout).
>
> With this patch in place, if the rtc driver reports the maximum alarm
> timeout supported by the rtc chip, the system will always limit the alarm
> timeout to the maximum supported by the rtc chip.
>
> Cc: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Use API function instead of accessing rtc core internals directly.
>     Modify comment in code per feedback received.
>
>  kernel/time/alarmtimer.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> index 8d9f13d847f0..0dc68372efd0 100644
> --- a/kernel/time/alarmtimer.c
> +++ b/kernel/time/alarmtimer.c
> @@ -290,6 +290,17 @@ static int alarmtimer_suspend(struct device *dev)
>         rtc_timer_cancel(rtc, &rtctimer);
>         rtc_read_time(rtc, &tm);
>         now =3D rtc_tm_to_ktime(tm);
> +
> +       /*
> +        * If the RTC alarm timer only supports a limited time offset, se=
t the
> +        * alarm time to the maximum supported value.
> +        * The system may wake up earlier (possibly much earlier) than ex=
pected
> +        * when the alarmtimer runs. This is the best the kernel can do i=
f
> +        * the alarmtimer exceeds the time that the rtc device can be pro=
grammed
> +        * for.
> +        */
> +       min =3D rtc_bound_alarmtime(rtc, min);
> +

Thanks for all the iterations on this Guenter! This looks nice.

Acked-by: John Stultz <jstultz@google.com>

thanks
-john
