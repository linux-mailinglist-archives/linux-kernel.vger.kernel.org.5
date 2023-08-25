Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249BE787EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240489AbjHYDxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240451AbjHYDxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:53:03 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334F91BEF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 20:52:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso32075e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 20:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692935576; x=1693540376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8XCsd3dg9SHzVc93cSUW+7XULv1BqDUgoLvkdXt9LQ=;
        b=4Op9SD+Qa88h0+8rpH6igQOn5AfJhrGga8ZKs/SpoL596LEZbZfqRfqh6bYNth8Wh1
         jZ5x6Haw036dGURJVDqwZjPn3DivmvNiMwhy0ckJe9BpuZXz0dgnTf3mhlGMS+4zZD3y
         R3aqY6i/7ml7j2hFhogBTt/YzuHDpT+FgOIejVQMiIWDqn5CEKBWP0eg5ESnoRucBblH
         acz7Aucqor1+dJcNDfCMcugnHHZnYxd/8qKGzzZM/X2qrzJBLZ3qw7+eit0g53o77P51
         Ws/YhRAzebYBh5jAhl9WNzK9IRFTXTiC9oKyHezTuf7YK9WRCqBUhOsuWJaqIPKCnFFG
         VjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692935576; x=1693540376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8XCsd3dg9SHzVc93cSUW+7XULv1BqDUgoLvkdXt9LQ=;
        b=ROyEKaBPOpk2i2KOzy3MundyfstPEbMl3pS0fd/VCqFjnDXagWHgn7XntlEEvNXNAf
         fJf2DI3UodkwCJHnH5WH9LJSU2DlTJHeeTB+hTl/aUyhKSSbf45zHa2+IZTaGFeUYenx
         J85SQEuECbPdeRzRzFiBLFwok8kwzDUPAcBcHF8DI39TDHkDoV/QEimutRuzm0dHaorZ
         UOfCfZHnHehPp3zoAZeJEcWSroJkfV22zNe351tbPF9UyRnXyc4087IvMZ1EGGANcDjA
         wULivaU4bPscbTmKIRmR55HDyQ3k6+sjYbYOH/ZdwM/W5B+oECPZ8VAiVqkjtxjLH1IP
         4GAg==
X-Gm-Message-State: AOJu0YzjtPvaOaNX05whFD40XJ5laUf9nHjpkxGwOwkw8OX7Dm/RQ97g
        1DgUV6p5OJWAiI7ARLT4MokkQi/J2XLP6qaY5lL2
X-Google-Smtp-Source: AGHT+IFw4sr21T6acK/w27R+QgtzDfutLP2a6XR4YfzAYQTBljP59BOnmQFhetUgIA/0GOCIu7mErNkY68JnCalCw7E=
X-Received: by 2002:a05:600c:600b:b0:3f6:f4b:d4a6 with SMTP id
 az11-20020a05600c600b00b003f60f4bd4a6mr79754wmb.7.1692935576567; Thu, 24 Aug
 2023 20:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230817225537.4053865-1-linux@roeck-us.net> <20230817225537.4053865-3-linux@roeck-us.net>
In-Reply-To: <20230817225537.4053865-3-linux@roeck-us.net>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 24 Aug 2023 20:52:44 -0700
Message-ID: <CANDhNCqd5VdwGaqHdeFK=Sui+fX_s7SxXnto9jdF_+0c-cuYSw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] rtc: alarmtimer: Use maximum alarm time offset
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
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

On Thu, Aug 17, 2023 at 3:55=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
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
> drivers to set the maximum alarm time. While this will result in brief
> spurious wakeups from suspend, it is still much better than not suspendin=
g
> at all.
>
> Cc: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Rename range_max_offset -> alarm_offset_max
>
>  kernel/time/alarmtimer.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
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
> +        * If the RTC alarm timer only supports a limited time offset, se=
t
> +        * the alarm time to the maximum supported value.
> +        * The system will wake up earlier than necessary and is expected
> +        * to go back to sleep if it has nothing to do.
> +        * It would be desirable to handle such early wakeups without ful=
ly
> +        * waking up the system, but it is unknown if this is even possib=
le.
> +        */
> +       if (rtc->alarm_offset_max &&
> +           rtc->alarm_offset_max * MSEC_PER_SEC < ktime_to_ms(min))
> +               min =3D ms_to_ktime(rtc->alarm_offset_max * MSEC_PER_SEC)=
;

I don't really have an objection here, but I wonder if this would be
better abstracted by a rtc_ function?

ktime_t rtc_bound_ktime_interval(ktime interval)
{
  if (!rtc->alarm_offset_max)
      return interval;
  return ms_to_ktime(min(rtc->alarm_offset_max, ktime_to_ms(interval)));
}

(simple enough to throw into rtc.h maybe as an inline function?)

Then the above would be tweaked to:
min =3D rtc_bound_interval(min);

thanks
-john
