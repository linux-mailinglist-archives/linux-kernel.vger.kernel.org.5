Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06109787F68
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 07:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbjHYFrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 01:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbjHYFq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:46:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B971BE2;
        Thu, 24 Aug 2023 22:46:53 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c0bae4da38so4614335ad.0;
        Thu, 24 Aug 2023 22:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692942413; x=1693547213;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dll96d/hiQOyeYZTGIJoWlJp+5l4kEPx4aAYFwgvlDw=;
        b=T7Zh6JYotJaeDsR6fw5icJd2oZgRj1yWrsPz54t9R8rsRabT+ePe1eFERp0JTu4Bab
         nRdn4DXtZOT6B8SvHuLlACOMPMle9BcSImliEhU2cSSzPdwLBR0qdEhmIhcmSQ6G2wSZ
         20kb07PBaxf3U8ss+lTmNixl3wQ8BlxQZbvso3cLcv487mFQInPmkij/YeNlN+Ot2aMk
         QoGtE6YdWPCc+IO6Y+CtmZKDDSZt+j0+2+R4KMKBlIH8Om92eYYf5rY0H4NKHiVR9y8w
         gy9pGTwoaAAJx1ZNI+sFz01MZGRbxnNsZvW6N19l7XqH1bUj3cthV9CNH9XsTWm/Hi9D
         4bCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692942413; x=1693547213;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dll96d/hiQOyeYZTGIJoWlJp+5l4kEPx4aAYFwgvlDw=;
        b=MSinCJDEhL8lxRy3MVhOmdmK8vK/Mn2ZA4Y01vij3E9/iy5FrV5L7mKQxEvuMlnMrq
         MJwMHAiYoJMr5Pi1tUH6WM4GfecQSEqMeKUvF7WC40Al1g48GlVcVW0MskBpQqtZW0rO
         OXVPjs7zzYRSX2sgB+e3jEh6XlM8DvL4mHU+JOe6aHORGzozf8pfLYrpBqtwOMHkGzHY
         Q0KZ0cXdGMX1HRzW7G9U6HP6NGgW13kTmc9gdNArQzdhYveAWKi2Jj9zfxAhVEjNqu/W
         /4itZ7mahyVfgz4DAerJcBcB0Ves8jHSj4+1uUIagCBPCezG7mx+Dr/5eP2MBZqkLXrw
         ChMQ==
X-Gm-Message-State: AOJu0YzBB/Uq1Hx3V+8zL0YOBJdSMu7TJWSrQfht+VXAPKRc6+8O72mi
        9RhE7C7wGQcIR+ZcJWS7dYs=
X-Google-Smtp-Source: AGHT+IGcJA4JgXuhIyI/2JwO0j7o/0qsvj2QBHgJ4avWyHeXsZYynN6wAZPrcWDe/qnK50GQELucoA==
X-Received: by 2002:a17:902:d2ce:b0:1b6:a37a:65b7 with SMTP id n14-20020a170902d2ce00b001b6a37a65b7mr25673183plc.23.1692942413135;
        Thu, 24 Aug 2023 22:46:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902c38600b001bdccf6b8c9sm703020plg.127.2023.08.24.22.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 22:46:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 24 Aug 2023 22:46:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     John Stultz <jstultz@google.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 2/7] rtc: alarmtimer: Use maximum alarm time offset
Message-ID: <1dfdd796-3ea3-4c7b-b0b6-cf8a50513e87@roeck-us.net>
References: <20230817225537.4053865-1-linux@roeck-us.net>
 <20230817225537.4053865-3-linux@roeck-us.net>
 <CANDhNCqd5VdwGaqHdeFK=Sui+fX_s7SxXnto9jdF_+0c-cuYSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCqd5VdwGaqHdeFK=Sui+fX_s7SxXnto9jdF_+0c-cuYSw@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 08:52:44PM -0700, John Stultz wrote:
> On Thu, Aug 17, 2023 at 3:55 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Some userspace applications use timerfd_create() to request wakeups after
> > a long period of time. For example, a backup application may request a
> > wakeup once per week. This is perfectly fine as long as the system does
> > not try to suspend. However, if the system tries to suspend and the
> > system's RTC does not support the required alarm timeout, the suspend
> > operation will fail with an error such as
> >
> > rtc_cmos 00:01: Alarms can be up to one day in the future
> > PM: dpm_run_callback(): platform_pm_suspend+0x0/0x4a returns -22
> > alarmtimer alarmtimer.4.auto: platform_pm_suspend+0x0/0x4a returned -22 after 117 usecs
> > PM: Device alarmtimer.4.auto failed to suspend: error -22
> >
> > This results in a refusal to suspend the system, causing substantial
> > battery drain on affected systems.
> >
> > To fix the problem, use the maximum alarm time offset as reported by rtc
> > drivers to set the maximum alarm time. While this will result in brief
> > spurious wakeups from suspend, it is still much better than not suspending
> > at all.
> >
> > Cc: Brian Norris <briannorris@chromium.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v2: Rename range_max_offset -> alarm_offset_max
> >
> >  kernel/time/alarmtimer.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> > index 8d9f13d847f0..895e3a6d6444 100644
> > --- a/kernel/time/alarmtimer.c
> > +++ b/kernel/time/alarmtimer.c
> > @@ -290,6 +290,19 @@ static int alarmtimer_suspend(struct device *dev)
> >         rtc_timer_cancel(rtc, &rtctimer);
> >         rtc_read_time(rtc, &tm);
> >         now = rtc_tm_to_ktime(tm);
> > +
> > +       /*
> > +        * If the RTC alarm timer only supports a limited time offset, set
> > +        * the alarm time to the maximum supported value.
> > +        * The system will wake up earlier than necessary and is expected
> > +        * to go back to sleep if it has nothing to do.
> > +        * It would be desirable to handle such early wakeups without fully
> > +        * waking up the system, but it is unknown if this is even possible.
> > +        */
> > +       if (rtc->alarm_offset_max &&
> > +           rtc->alarm_offset_max * MSEC_PER_SEC < ktime_to_ms(min))
> > +               min = ms_to_ktime(rtc->alarm_offset_max * MSEC_PER_SEC);
> 
> I don't really have an objection here, but I wonder if this would be
> better abstracted by a rtc_ function?
> 
> ktime_t rtc_bound_ktime_interval(ktime interval)

Probably more like like rtc_bound_alarm_interval(),
but fine with me.

> {
>   if (!rtc->alarm_offset_max)
>       return interval;
>   return ms_to_ktime(min(rtc->alarm_offset_max, ktime_to_ms(interval)));

alarm_offset_max is in seconds, so that would need some tweaking.

Guenter

> }
> 
> (simple enough to throw into rtc.h maybe as an inline function?)
> 
> Then the above would be tweaked to:
> min = rtc_bound_interval(min);
> 
> thanks
> -john
