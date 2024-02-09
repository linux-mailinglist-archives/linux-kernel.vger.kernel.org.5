Return-Path: <linux-kernel+bounces-59881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5570484FCDE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D1128F15F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4834B83CAF;
	Fri,  9 Feb 2024 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="LI87siHd"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF6F82867
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507017; cv=none; b=Ba30CUZYpAOU+8BoAf8AVBdcpFIMC8J22iaxlPQr9cvNQTJTvWSLUhzR6dgQhgPqYhxbFqLaP6+wWIgw29wQa6vCYpC+N/jHs+Y/TUO12aHST8LL/mKDbA86eG8wG4VLzK7BT8I9JU27DM/v2tUt0Y5a3v8gGVq08GX3oGyzh7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507017; c=relaxed/simple;
	bh=iFes5GRh2skRFj9697U1IQcZuCTwNj4lR6607L6O8G4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=em9lWXxzcsbD7kPCjVGVwLzvZWY/gNUPmhqdCZ9KZC/QKRV+mJntBbG7JuPxmEofiHXqQg2znlE9+A8fpKzDNB3ovhbC92BJuFwPJk+iexf+Qwp0FE55xqun9hyEC9jI/Z2Wo/gUHjY9mlbh4t6rrdlmMMSFaMSVHeAruV4BVS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LI87siHd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40f00adacfeso3465e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 11:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707507014; x=1708111814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8m6ZQ/7fN/zyza1TL+nlZ4zBwwXXrryZUn9xvH88MM=;
        b=LI87siHd1uRVyQ68PCo1p/pGdTEeiFNAjX7OgSFHHi7qdIg0IvEoXEm6TZdIpXSlnu
         TzNRsPXOPBYQpTCpraquh46mAQjYAq23sikjry1w5aRm7buOh1co8ULqf2wOXNhWeQ83
         Eo6lw8juUeILbJrBNckvozQ6JhxrTJIt2oIiymYs10XI4GTZ5v5ZdyaI60rqSB2mViLm
         qZV4Z+rjaRQaVa+wahMhBg+wCRYoM/Xa0ryj+mDCfEhE7mbuBqpTTG/W5P/QMc6FY+YL
         PSVySmLisKT8uPLTin9K267xlLcb7vuviUAwNq8qrYVigmzZK64atkORGWnkrMlq9RfF
         bEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707507014; x=1708111814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8m6ZQ/7fN/zyza1TL+nlZ4zBwwXXrryZUn9xvH88MM=;
        b=leA3k31l1IDTl0976yaO9lOs09SQPQEJwDaFlMl7uzMaWNNgLJSEfJu18bGrjzJHTQ
         CGMRXOgGQIkA4IeKQKrFBv0HvUoaKPwcaOntuC0tmMzMvrEgKI+LLjYzxEVeacxI5f7j
         lowmGtv2okNWH76fH+bkRSjzc5oTHSFYdJiwNgdi/u2lLI4kmcHiAZhnfMlfcxZ/7Ehp
         GVjQXTzSE615bgOPI/LAjwuGzeiwImL31aj6MnwY0Y3RgnxB9qHk745COMT9RgB9LOFq
         Jm+Rv6Fbzj71vKRObOxWPbZd204qtV5MWq4um3SC/gWEtr/sHzlGXEWRcpv/28FrNTf3
         740A==
X-Gm-Message-State: AOJu0Yy2H2sldc5ohefjCXplMcV+sse9zUy6ETrJXT8OQCJ5JN4Dd9PM
	b+tkJUbycaDF5+QqkDQc9gZCrHPDT2SBKNlGNKjzNIqWRt8MyOPbPC02oQ7AjV+6LsK00i42KCD
	VnrcCBy3cnsTPcOp+8PMgZ0SCh1rVs68/C1xrEYtYP1k3/pBvMbI=
X-Google-Smtp-Source: AGHT+IHkPdscTIisSRL+FGFFUE72uGSGVVkt+Xq/MByEp/zSKOlkw/UljjoLXr7sbQlvX0NHvwYUJg+DRgdIS9w//4s=
X-Received: by 2002:a05:600c:5190:b0:410:86f1:27bb with SMTP id
 fa16-20020a05600c519000b0041086f127bbmr46908wmb.3.1707507013823; Fri, 09 Feb
 2024 11:30:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208195622.758765-1-pranavpp@google.com> <20240208195622.758765-3-pranavpp@google.com>
In-Reply-To: <20240208195622.758765-3-pranavpp@google.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 9 Feb 2024 11:30:01 -0800
Message-ID: <CANDhNCoNuAXSn7-M1SY6q+RZoPjEa1_dHzpdG20et2Sbm5AoDw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] alarmtimer: Modify alarmtimer suspend callback to
 check for imminent alarm using PM notifier
To: Pranav Prasad <pranavpp@google.com>
Cc: tglx@linutronix.de, sboyd@kernel.org, linux-kernel@vger.kernel.org, 
	krossmo@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 11:56=E2=80=AFAM Pranav Prasad <pranavpp@google.com>=
 wrote:
>
> The alarmtimer driver currently fails suspend attempts when there is an
> alarm pending within the next suspend_check_duration_ns nanoseconds, sinc=
e
> the system is expected to wake up soon anyway. The entire suspend process
> is initiated even though the system will immediately awaken. This process
> includes substantial work before the suspend fails and additional work
> afterwards to undo the failed suspend that was attempted. Therefore on
> battery-powered devices that initiate suspend attempts from userspace, it
> may be advantageous to be able to fail the suspend earlier in the suspend
> flow to avoid power consumption instead of unnecessarily doing extra work=
.
> As one data point, an analysis of a subset of Android devices showed that
> imminent alarms account for roughly 40% of all suspend failures on averag=
e
> leading to unnecessary power wastage.
>
> To facilitate this, register a PM notifier in the alarmtimer subsystem
> that checks if an alarm is imminent during the prepare stage of kernel
> suspend denoted by the event PM_SUSPEND_PREPARE. If an alarm is imminent,
> it returns the errno code ETIME instead of EBUSY to userspace in order to
> make it easily diagnosable.

Thanks for continuing to iterate on this!

One concern below...

> +static int alarmtimer_pm_callback(struct notifier_block *nb,
> +                           unsigned long mode, void *_unused)
> +{
> +       ktime_t min, expires;
> +       struct rtc_device *rtc =3D NULL;
> +       int type;
> +
> +       switch (mode) {
> +       case PM_SUSPEND_PREPARE:
> +               /* Find the soonest timer to expire */
> +               if (!alarmtimer_get_soonest(rtc, &min, &expires, &type))
> +                       return NOTIFY_DONE;
> +
> +               if (ktime_to_ns(min) <
> +                       suspend_check_duration_ms * NSEC_PER_MSEC) {
> +                       pr_warn("[%s] Suspend abort due to imminent alarm=
\n", __func__);
> +                       pm_wakeup_event(&rtc->dev, suspend_check_duration=
_ms);
> +                       return notifier_from_errno(-ETIME);
> +               }
> +       }
> +
> +       return NOTIFY_DONE;
> +}
> +

So the alarmtimer_pm_callback provides an earlier warning that we have
an imminent alarm, looks ok to me.


> @@ -296,49 +379,14 @@ EXPORT_SYMBOL_GPL(alarm_expires_remaining);
>  static int alarmtimer_suspend(struct device *dev)
>  {
..
> +       /* Find the soonest timer to expire */
> +       if (!alarmtimer_get_soonest(rtc, &min, &expires, &type))
>                 return 0;
>
> -       if (ktime_to_ns(min) < suspend_check_duration_ms * NSEC_PER_MSEC)=
 {
> -               pm_wakeup_event(dev, suspend_check_duration_ms);
> -               return -EBUSY;
> -       }

It seems like we'd want to preserve the check in alarmtimer_suspend()
as well, no? As the various suspend calls might take awhile and in
that time, the next timer may have slipped into the window of being
imminent.

thanks
-john

