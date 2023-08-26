Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A71F789639
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 13:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjHZLQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 07:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjHZLPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 07:15:34 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC83E1987;
        Sat, 26 Aug 2023 04:15:28 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1c4d8eaa8ebso1244728fac.0;
        Sat, 26 Aug 2023 04:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693048528; x=1693653328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ChGvzopdI6D06ur+9n254we/TUNLfKzd+bLG66SVQsY=;
        b=pZ+36/GEW/YZXKGLV5MtTdWTEo5jsA37k4tIZILufMzfM4Sg+bATUrvZCXqNT+mg0k
         qyfJS/CGrHcbApQQNpSooa2TVhlqJhjNK3o8BsAf/DFcS1kl1Mg99LzNHvWnuytQ+TWP
         /j711VCImvmFnWadCijWFoIALjSJSLmgZRrQLi+pJOEhvXoSfI6h9lpoStUyh04x4im4
         /PjzWSvC6CMU6rMlqJ1aybr/UT+cCRtAPnIHjuP2Oy25z7zkBHctIKvPC8H3J0d9heYL
         dUEtsTObuyUP0EQ9iCI0YgKdvbjKTuYdU0hVM+dm7NMp6OOf+p4qG90gF2CN0ccHm9JB
         DDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693048528; x=1693653328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChGvzopdI6D06ur+9n254we/TUNLfKzd+bLG66SVQsY=;
        b=gNLWdMp8UIin0qO5cQ3Btb5X7lzRpJQIfZgIcXew4o0Sfu8fZyZXTzhZFMSKGU9cJi
         y+ovQcJs5AksKHlRYWYnIEiFnexnxIYPsX9EOjEUwyjAc6RtSlFNJQcj9BzQp8/G12I6
         0uOassaqDqE64tydH+0IxXaVXmFioCgrRED+1o5S8++BIjZ9CxZn1JR4tNmJDPIp5Zk0
         HSKAnTLmgbv83/zNlWNALgJ7LgkqjfRWRnQrgdQwO0Tb/rtav+cdSEgsN2e+w3NylELS
         gIv97lLcxWoqdqoNpRwXjoKgAnFRUhn+CrCPxotVGQrPfoMPctc65s1kkOclb1Rm5/Vb
         ce8Q==
X-Gm-Message-State: AOJu0Yy9fkjoLbvy4hWx0ChcxkQnZlsWZyf0yoS4UYxfJz+EJ6NESVZZ
        wvPVCHR7HtNrrMaxVOsJSEY=
X-Google-Smtp-Source: AGHT+IFsOotk4PhiP42PeuoLCCGf3KThYtlafXR2DSNSG/p9XSWC62Pg/AlWk22+NLlI97jHO5le/g==
X-Received: by 2002:a05:6870:2182:b0:1bf:94d6:6f8d with SMTP id l2-20020a056870218200b001bf94d66f8dmr6454213oae.31.1693048527897;
        Sat, 26 Aug 2023 04:15:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j22-20020a62b616000000b006889664aa6csm3069484pff.5.2023.08.26.04.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 04:15:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 26 Aug 2023 04:15:25 -0700
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
Message-ID: <38213512-c8b5-477d-945c-bbdfb56266b8@roeck-us.net>
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

Side note, since someone asked: The behavior is exactly what we see today
if a rtc driver silently truncates the requested alarm time. The system
is _expected_ to to back to sleep, but what it does depends on its actual
configuration. For example, if suspend was requested manually and
auto-suspend is disabled, it may well be that the system stays up after
the initial timeout. Again, that is exactly the same behavior that
is observed today, but with this patch the system doesn't fail the
initial suspend request because the requested timeout is not supported
by the rtc driver.

Not sure if I should add some text along that line above for clarification.
If so please let me know.

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
> {
>   if (!rtc->alarm_offset_max)
>       return interval;
>   return ms_to_ktime(min(rtc->alarm_offset_max, ktime_to_ms(interval)));
> }
> 
> (simple enough to throw into rtc.h maybe as an inline function?)
> 
> Then the above would be tweaked to:
> min = rtc_bound_interval(min);
> 

How should I proceed ? Would sending two patches on top of patch 1
to introduce the API and use it be ok ?

Thanks,
Guenter
