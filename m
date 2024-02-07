Return-Path: <linux-kernel+bounces-56829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6B684CFCC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3FB1F2278C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE998002F;
	Wed,  7 Feb 2024 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BBLStwxT"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A372446C8
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707326978; cv=none; b=OfqqD8CbNl85meztwwYCpzaxqC5eGvcIboqSxhQMwewC9KYNdtrHdWMxfV+nI6ZqbtZdUkVdroysSepR1czFXYBvFsb3T9IjOAjkHEJUyf7JNykd6wZ77Shs+ynmj8tlTvDIgHjIs0R21ZzS8kbvIPhK0jv8zGcVEWRwr2WR0WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707326978; c=relaxed/simple;
	bh=++Bklq5ymOBIPQQU4XmU9PUUxhf2RrPGXBz2NxWi4y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1bTbze71nPDKxzJYdzTC7oIHffxU63QD+Yl0W5h1V6IvmeqMnoUs3e21aOvcWNp56ML/ZUW1M8OPPBAQjKHUmVx+9nhiMonZoJ6AgvE+uDWt/t/KzGLR3aexnhzKcZEAYQV6OxKFP1krzhAt4JgA8Jf4qSAhpe5RX8ZsdPO/1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BBLStwxT; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51167496943so1412253e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 09:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707326974; x=1707931774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGf3jNllSJ1jiYrkiqgx4SfdodgVl2gqXkNeLLnWW+o=;
        b=BBLStwxTdqaBbNsgo06Ogn2L3CJH2jc9u6ge9mm46P1Nsu+3gk31PFEbnAf0TReEbm
         JpkEit/K2JEMCBYaFOnqNTq+Z4LEblz9q72xiYe81nXnVYtnNpXAbAfobl0qfs1z6u5q
         xd6bBWyVWf7P6b8rPXHLf9xxTCh1o/DC8cohf3qHoACJN2GwektTl0l5k7Xyc/M/Hmij
         Jcvpkkoh5cR8kLCwC4eLMBe5vhh53Ut7LU+/sp98mUDJviRLQarz/Iy24bHZRUQBtUOt
         DOLWqSG0j+4F6nPUCJWPQ0TOAC2KLxMyQCgVmTz+SMm53gzp/D7DHcd6jTl2DX9Eej5B
         5YyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707326974; x=1707931774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGf3jNllSJ1jiYrkiqgx4SfdodgVl2gqXkNeLLnWW+o=;
        b=lZ7HodljhXFhBUP01laKcxayblflTtpQdvM1jZY5MVn7nb7Z9ApcZ2vF3oKAkAy2lY
         aME7CbGKvJ4lcBxehM00/qkgbTAHbCkxdiOkiaANAx/8NpSgFfxNnTLqcen5QNl87g4g
         u70vOnlhmKJHID6KxhqaVtFWBvbsAamWTEjkDLaRtqqOX4pK9VoAHCeU83N6VeAzjSX/
         ir9nJLRy6HCVZlpp8BHx0HzVYG9JpMwIspudk3gbGhWMTsDe5HW7bUoOHSQ44dtiqF+s
         SqQo3f47TsIr2L+a7LdaYOGGTzyljaYBwgX49LmUdLdMbKFB5X6S5zCJx+N7Rp0kwLib
         dTMw==
X-Gm-Message-State: AOJu0YytQP32yRZW6v+yON/RZJ+/GZj50xgyMIZmOY5XyHD5hWnLMMp5
	CbAgYvqFTQ56VRjA4qnrp9dT+R9YI2Sgg4KcHAmfdwqXnPBhf2yhqZGCwMqI2I1e6WlnhRhZju0
	f+o7amtUrPmshj/gojcrY5pjAyqT82cmJIgOe
X-Google-Smtp-Source: AGHT+IGUbzSAAo+a5mDR+wLIlDyCc9vlKpByQMits6/mHIp6FihqrfXRNw/3GOPQJSg0T39OIVKrGBBykkkLqzJuuFQ=
X-Received: by 2002:a19:6513:0:b0:511:484a:daca with SMTP id
 z19-20020a196513000000b00511484adacamr4426708lfb.18.1707326974208; Wed, 07
 Feb 2024 09:29:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207100619.3947442-1-pranavpp@google.com> <20240207100619.3947442-3-pranavpp@google.com>
 <CACkwYU22HOuB=8qpTTUoxZUm7kpnWhSeH2ui3vsHg8AP__xd9Q@mail.gmail.com>
In-Reply-To: <CACkwYU22HOuB=8qpTTUoxZUm7kpnWhSeH2ui3vsHg8AP__xd9Q@mail.gmail.com>
From: Pranav Prasad <pranavpp@google.com>
Date: Wed, 7 Feb 2024 09:29:23 -0800
Message-ID: <CACkwYU31qGLYSNZRyZerddNRxSWS3UL=X19Wevx2cATXKOWDoQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] alarmtimer: Modify alarmtimer suspend callback to
To: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, Kelly Rossmoyer <krossmo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please ignore this patch, submitting v2 with some more suggested fixes.

Pranav


On Wed, Feb 7, 2024 at 8:39=E2=80=AFAM Pranav Prasad <pranavpp@google.com> =
wrote:
>
> Please ignore this patch, submitting v2 with some more suggested fixes.
>
> Pranav
>
> On Wed, Feb 7, 2024, 2:06=E2=80=AFAM Pranav Prasad <pranavpp@google.com> =
wrote:
>>
>> The alarmtimer driver currently fails suspend attempts when there is an
>> alarm pending within the next suspend_check_duration_ns nanoseconds, sin=
ce
>> the system is expected to wake up soon anyway. The entire suspend proces=
s
>> is initiated even though the system will immediately awaken. This proces=
s
>> includes substantial work before the suspend fails and additional work
>> afterwards to undo the failed suspend that was attempted. Therefore on
>> battery-powered devices that initiate suspend attempts from userspace, i=
t
>> may be advantageous to be able to fail the suspend earlier in the suspen=
d
>> flow to avoid power consumption instead of unnecessarily doing extra wor=
k.
>> As one data point, an analysis of a subset of Android devices showed tha=
t
>> imminent alarms account for roughly 40% of all suspend failures on avera=
ge
>> leading to unnecessary power wastage.
>>
>> To facilitate this, register a PM notifier in the alarmtimer subsystem
>> that checks if an alarm is imminent during the prepare stage of kernel
>> suspend denoted by the event PM_SUSPEND_PREPARE. If an alarm is imminent=
,
>> it returns the errno code ETIME instead of EBUSY to userspace in order t=
o
>> make it easily diagnosable.
>>
>> Signed-off-by: Pranav Prasad <pranavpp@google.com>
>> Signed-off-by: Kelly Rossmoyer <krossmo@google.com>
>> ---
>>  kernel/time/alarmtimer.c | 121 ++++++++++++++++++++++++++++-----------
>>  1 file changed, 88 insertions(+), 33 deletions(-)
>>
>> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
>> index e5d2e560b4c1..229de937c266 100644
>> --- a/kernel/time/alarmtimer.c
>> +++ b/kernel/time/alarmtimer.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/compat.h>
>>  #include <linux/module.h>
>>  #include <linux/time_namespace.h>
>> +#include <linux/suspend.h>
>>
>>  #include "posix-timers.h"
>>
>> @@ -115,6 +116,87 @@ static int alarmtimer_sysfs_add(void)
>>         return ret;
>>  }
>>
>> +/**
>> + * alarmtimer_init_soonest - Initializes parameters to find soonest ala=
rm.
>> + * @min: ptr to relative time to the soonest alarm to expire
>> + * @expires: ptr to absolute time of the soonest alarm to expire
>> + * @type: ptr to alarm type
>> + *
>> + */
>> +static void alarmtimer_init_soonest(ktime_t *min, ktime_t *expires, int=
 *type)
>> +{
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&freezer_delta_lock, flags);
>> +       *min =3D freezer_delta;
>> +       *expires =3D freezer_expires;
>> +       *type =3D freezer_alarmtype;
>> +       freezer_delta =3D 0;
>> +       spin_unlock_irqrestore(&freezer_delta_lock, flags);
>> +}
>> +
>> +/**
>> + * alarmtimer_get_soonest - Finds the soonest alarm to expire among the=
 alarm bases.
>> + * @min: ptr to relative time to the soonest alarm to expire
>> + * @expires: ptr to absolute time of the soonest alarm to expire
>> + * @type: ptr to alarm type
>> + *
>> + */
>> +static void alarmtimer_get_soonest(ktime_t *min, ktime_t *expires, int =
*type)
>> +{
>> +       int i;
>> +       unsigned long flags;
>> +
>> +       /* Find the soonest timer to expire */
>> +       for (i =3D 0; i < ALARM_NUMTYPE; i++) {
>> +               struct alarm_base *base =3D &alarm_bases[i];
>> +               struct timerqueue_node *next;
>> +               ktime_t delta;
>> +
>> +               spin_lock_irqsave(&base->lock, flags);
>> +               next =3D timerqueue_getnext(&base->timerqueue);
>> +               spin_unlock_irqrestore(&base->lock, flags);
>> +               if (!next)
>> +                       continue;
>> +               delta =3D ktime_sub(next->expires, base->get_ktime());
>> +               if (!(*min) || (delta < *min)) {
>> +                       *expires =3D next->expires;
>> +                       *min =3D delta;
>> +                       *type =3D i;
>> +               }
>> +       }
>> +}
>> +
>> +static int alarmtimer_pm_callback(struct notifier_block *nb,
>> +                           unsigned long mode, void *_unused)
>> +{
>> +       ktime_t min, expires;
>> +       int type;
>> +
>> +       switch (mode) {
>> +       case PM_SUSPEND_PREPARE:
>> +               /* Initialize parameters to find soonest timer */
>> +               alarmtimer_init_soonest(&min, &expires, &type);
>> +
>> +               /* Find the soonest timer to expire */
>> +               alarmtimer_get_soonest(&min, &expires, &type);
>> +
>> +               if (min =3D=3D 0)
>> +                       return NOTIFY_DONE;
>> +
>> +               if (ktime_to_ns(min) < suspend_check_duration_ns) {
>> +                       pr_warn("[%s] Suspend abort due to imminent alar=
m\n", __func__);
>> +                       return notifier_from_errno(-ETIME);
>> +               }
>> +       }
>> +
>> +       return NOTIFY_DONE;
>> +}
>> +
>> +static struct notifier_block alarmtimer_pm_notifier =3D {
>> +       .notifier_call =3D alarmtimer_pm_callback,
>> +};
>> +
>>  /**
>>   * alarmtimer_get_rtcdev - Return selected rtcdevice
>>   *
>> @@ -181,6 +263,7 @@ static int alarmtimer_rtc_add_device(struct device *=
dev)
>>  static inline void alarmtimer_rtc_timer_init(void)
>>  {
>>         rtc_timer_init(&rtctimer, NULL, NULL);
>> +       register_pm_notifier(&alarmtimer_pm_notifier);
>>  }
>>
>>  static struct class_interface alarmtimer_rtc_interface =3D {
>> @@ -296,48 +379,20 @@ EXPORT_SYMBOL_GPL(alarm_expires_remaining);
>>  static int alarmtimer_suspend(struct device *dev)
>>  {
>>         ktime_t min, now, expires;
>> -       int i, ret, type;
>> +       int ret, type;
>>         struct rtc_device *rtc;
>> -       unsigned long flags;
>>         struct rtc_time tm;
>>
>> -       spin_lock_irqsave(&freezer_delta_lock, flags);
>> -       min =3D freezer_delta;
>> -       expires =3D freezer_expires;
>> -       type =3D freezer_alarmtype;
>> -       freezer_delta =3D 0;
>> -       spin_unlock_irqrestore(&freezer_delta_lock, flags);
>> +       /* Initialize parameters to find soonest timer */
>> +       alarmtimer_init_soonest(&min, &expires, &type);
>>
>>         rtc =3D alarmtimer_get_rtcdev();
>>         /* If we have no rtcdev, just return */
>>         if (!rtc)
>>                 return 0;
>>
>> -       /* Find the soonest timer to expire*/
>> -       for (i =3D 0; i < ALARM_NUMTYPE; i++) {
>> -               struct alarm_base *base =3D &alarm_bases[i];
>> -               struct timerqueue_node *next;
>> -               ktime_t delta;
>> -
>> -               spin_lock_irqsave(&base->lock, flags);
>> -               next =3D timerqueue_getnext(&base->timerqueue);
>> -               spin_unlock_irqrestore(&base->lock, flags);
>> -               if (!next)
>> -                       continue;
>> -               delta =3D ktime_sub(next->expires, base->get_ktime());
>> -               if (!min || (delta < min)) {
>> -                       expires =3D next->expires;
>> -                       min =3D delta;
>> -                       type =3D i;
>> -               }
>> -       }
>> -       if (min =3D=3D 0)
>> -               return 0;
>> -
>> -       if (ktime_to_ns(min) < suspend_check_duration_ns) {
>> -               pm_wakeup_event(dev, suspend_check_duration_ns/NSEC_PER_=
MSEC);
>> -               return -EBUSY;
>> -       }
>> +       /* Find the soonest timer to expire */
>> +       alarmtimer_get_soonest(&min, &expires, &type);
>>
>>         trace_alarmtimer_suspend(expires, type);
>>
>> --
>> 2.43.0.594.gd9cf4e227d-goog
>>

