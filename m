Return-Path: <linux-kernel+bounces-59913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5061884FD47
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E8B28BABF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF47084A5D;
	Fri,  9 Feb 2024 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Elj3WDB/"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A34C7FBBC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707508887; cv=none; b=jZumTUcypKW/u1H3oT5tT15MCS5/0cYMyGREMXrY2ahqP/8BTZMCGwUBKwcfTg6LnA/VdFHpuL/ZpW2rWdbOVs0TPVqcV0nFKZfRHqk1nPXYja+v4uLRGufZf9IL+C706oTLPXlENyMojSITHsEvzUpNqmwQ/CyIN3L1uB6kWlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707508887; c=relaxed/simple;
	bh=5I7BpgixLa5faa6xc3mh89nbOLW/xnTlcqzhbXqlJeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2HYq/6/Io70148YR1A/IkOcEk0N4Ew/Ss2BPN7xg/wVxG2NKDcbJswXBhLMj5W8dsFi4mtDTm4q558oKYyAuM4HEI/h86YFeRe/kaJhWiQfKreJwQi1TzTOiIAoTyFFTa5Xlv4O3w3Zl1RmLeAxZIEUwWBfJCXXI9hL3t339GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Elj3WDB/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40f00adacfeso5495e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 12:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707508884; x=1708113684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/UIg69uZRSDx+2JUC17BVpi9Ay6+IMre1Ut9Rszi/0=;
        b=Elj3WDB/E7Ii13t0ZhrMTaXPoH4eoh6qZBjLZW9cAl8OOS7dwoqWWOxyxZdB+qc3Gb
         /UYE/Itgq0othdFoUi8uV2Xk5f8QQrgePIW6u1N6OMxz4RtV1qMPOwasgkok2BP403o+
         HzE9tjXefgFfSQLVaCDEi2XsIU4K+e0cYxAiOTPpELHDWC1aOCkW/agwwckgGbTQ9U1P
         8jzAsyfHrD/KWTjoPpKjlsbuy4PK2tgFUcp1eAGZT+DkYEstHFiTTl6yMykMS/8sIO8t
         SSt1MkRybUN6/eG9pANWe5m540juN6AeVcb2WNpP0EAv9pFMGpyvqADHca8yh1llgFBs
         IxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707508884; x=1708113684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/UIg69uZRSDx+2JUC17BVpi9Ay6+IMre1Ut9Rszi/0=;
        b=RSdXsqY1Z2eJ24YQ/j7DhfE8l1vIQf87q+R7i2bOf569W6gzbhjEewlXUDKuEZLNTa
         xXpH7IrXHahmwHfDswVUNvupVXZgbTQ9G78VgfPDwn7ti+bVbT411Wvv8KvqKqe+wBCV
         rwCXbzyQP743MV16IbwmXriUbrfKpkmkzTnExQPm0ECqE/DDwLClYd2DbzH/XY2+fTyY
         XZKL9IXY/iD72A53g1O+HgN1Sdo88pfrWyCkLMgnWAdZzsMgAgqbzwPVGVZUVz/Qop7T
         D3BMkN6XqRfyNpCFgv4Gr5cU8sFHBHN1kg/pi273RPWlmI4NoMa4+x+2domNv/y1S01Y
         2QDg==
X-Forwarded-Encrypted: i=1; AJvYcCW/76V76QeO8qYLBhXXXFnBQbWQExSGvIQ6U8AfN/rGSMh7PMRg8kTn3ERGjfyRZ7NbNrDQQCoqD4RdBXLVINtCtVmymhjkneZKGjcS
X-Gm-Message-State: AOJu0YzsdYnE+SjeyBxRI4yKer/zGOj32k3ZuVGMzMqhDfn3foVe6yqp
	FY7s2YrryYHw8qqtQX/cVZDE0V98R4OABi8HSxBmfnl5VKWQcb6vNjaZgJZaf6r3oLZJwr69hdj
	5R67OKZYoaO2Dzc3YRvlHB2dcmjzG9iRqUME=
X-Google-Smtp-Source: AGHT+IGHZg7lYJ8/6PYkgwHzUIocJAQzcnCe362rAeI00bmROEof/r+DL+mStcwOxp1GXBWpFKblNmcZkghlileV2zY=
X-Received: by 2002:a05:600c:a39c:b0:410:3e15:3586 with SMTP id
 hn28-20020a05600ca39c00b004103e153586mr173017wmb.5.1707508883649; Fri, 09 Feb
 2024 12:01:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208195622.758765-1-pranavpp@google.com> <20240208195622.758765-2-pranavpp@google.com>
In-Reply-To: <20240208195622.758765-2-pranavpp@google.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 9 Feb 2024 12:01:10 -0800
Message-ID: <CANDhNCovFCekU3wKYNMZWNgcr1=yyDnKNoehXe-x3Ep6-c58eg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] alarmtimer: Create alarmtimer sysfs to make
 duration of kernel suspend check configurable
To: Pranav Prasad <pranavpp@google.com>
Cc: tglx@linutronix.de, sboyd@kernel.org, linux-kernel@vger.kernel.org, 
	krossmo@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 11:56=E2=80=AFAM Pranav Prasad <pranavpp@google.com>=
 wrote:
>
> Currently, the alarmtimer_suspend does not allow the kernel
> to suspend if the next alarm is within 2 seconds.
> Create alarmtimer sysfs to make the value of 2 seconds configurable.
> This allows flexibility to provide a different value based on the
> type of device running the Linux kernel. As a data point, about 40% of
> kernel suspend failures in a subset of Android devices were due to
> this check. A differently configured value can avoid these suspend
> failures which performs a lot of additional work affecting the
> power consumption of these Android devices.
>
> Signed-off-by: Pranav Prasad <pranavpp@google.com>

I might suggest flipping the order of these two patches, as I'm more
wary of UABI changes, so I don't want to hold up the second patch on
interface bike shedding.

> ---
>  kernel/time/alarmtimer.c | 61 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> index 4657cb8e8b1f..e4b88c8dc0e1 100644
> --- a/kernel/time/alarmtimer.c
> +++ b/kernel/time/alarmtimer.c
> @@ -33,6 +33,8 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/alarmtimer.h>
>
> +static const char alarmtimer_group_name[] =3D "alarmtimer";
> +
>  /**
>   * struct alarm_base - Alarm timer bases
>   * @lock:              Lock for syncrhonized access to the base
> @@ -63,6 +65,56 @@ static struct rtc_timer              rtctimer;
>  static struct rtc_device       *rtcdev;
>  static DEFINE_SPINLOCK(rtcdev_lock);
>
> +/* Duration to check for soonest alarm during kernel suspend */
> +static unsigned long suspend_check_duration_ms =3D 2 * MSEC_PER_SEC;

Naming is hard, but "suspend_check_duration" feels particularly opaque
for a tunable knob.
I can't say I've got a better suggestion off the top of my head, but
this might be something worth thinking a bit more on.

"imminent_alarm_window" maybe? Though that's not obvious it is
connected to suspend, and maybe sounds more urgent than it should.
"suspend_alarm_pending_window"?

It might also be nice to provide some more details in the commit
message about why this should be configurable, and how a user of the
interface might choose a proper value to use (including the downsides
of going too far in either direction?).

thanks
-john

