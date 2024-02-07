Return-Path: <linux-kernel+bounces-56818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C61484CF9E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB606B259A0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402E9823C4;
	Wed,  7 Feb 2024 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uX323w5t"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B25811EC
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707326226; cv=none; b=XoVUZMRZCY9A+wzLdflKLLynIqA+7VrgyPa5/Q7TSC3RpG3Xomrg0jkUaWMmn+3J46IUhjvc2/hwtspKUn5n0zqu0JaxxrwydvawYLx1et1xzwXgkBkh+xb4CC+wcjJK+dy3+OZO9qG1UD5+eHfDG/GenZZi7sepm8CyFAXE63U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707326226; c=relaxed/simple;
	bh=SlVgvMr9mTs5h6+GHURwDx1gzJGKB04YlXeMNaq1X2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGg5yOAgXrQicT/uqpevVrHVanVwMoQlFPKvTvyzOd7JJDXXuVcn0AGzPetnFfSlYX9ZI9YffhnjL0jbjpVLtPJYxzgmc0vmpsXhFeHV57USOVOMROC9xVpbpROMSQToA0vNNr6tdbZM9E7OR1NdqrAU+THg3DDnBsRdS2SBlUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uX323w5t; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-560c696ccffso55384a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 09:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707326223; x=1707931023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DTvCS76/e8jai8Lk1LPsUrtKHnibkC66/Oj/foOwb0=;
        b=uX323w5tuBwH0FCUUseIuFmyZJjW8f+Uq8ApWFSviYabNL0FnEdejflJK2a/VIFs1i
         hZMbdg706oi5VnMeBb0wEXhXQtBbyGsTAqD2MvT4RNjZ/3tqp9pd5Bv07Yh+EgXlSKnh
         /3KXDxaMz1A5mZBXOzsY+8/YAhwkLZzOwhxyT1Q6tU24GYKRpv3rxPGD+oSU6tZVY9RU
         uys7SGkil38dTyquBr93I9G4vJvAfubcXn2LtoKwGWMHk+3syl+wC/bWH9TqU3lwaeFK
         hGvWkF6NDhR0BNMTex8O7YtkpRlj92+cLaaQRQh31COvV3W2567OPsGNZITKu26G+ClK
         dL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707326223; x=1707931023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DTvCS76/e8jai8Lk1LPsUrtKHnibkC66/Oj/foOwb0=;
        b=cNvm++8yjxJ2DPrRNz79zilA9JgtylwN/7hByQZg+0hPaA6McqDmUY5ymjs4SBJpum
         jKOGazC5JFVWQME5fXLLgsSi1iarynKgOGEWyztmU2xI/jEzTaIWGQd/9RDWzVPwyWzz
         w74mmFUqMmbXCRevWiK4l1qDMB11zjwuUN9YQWk+WWQLlNTtFRIU8v9EU+6v5tkhv2Bt
         kE9h+Cu1G2l7FtO46wZNM3ofoqz7wOSK7qNguVh0r/DQPMHpGrDVIreY0Dawty33KIw+
         IjEu23MNDFexflOJnY8kv4XZUFPtn+daJLH9e26Xp03AY5ZvrzVCoUdcZ2NlWaMvnHD8
         S5Ew==
X-Gm-Message-State: AOJu0YzncMI5ClNZsekShEyw3ZYH7lkkCp+81MplCdlaM3gwL4/4r8Fl
	tlKbszNv35Fx6lQu8F3ZsZ9fdxw2XqB23aUoWVnS5MxckVxOJs3rWL9vSvIIv712I/tj87ZswBp
	m7Yr7jBBIhdaLj8GTRWTr43x/LZPCQ3EIPhoc
X-Google-Smtp-Source: AGHT+IE/9zes9hDXQ+X5q6BRGTXYxRu4ZyqYLQdTFKodBKoAN9qzShs3gOIUyXNF5YP7KJyDSSMwGx/4PPS7zSLzu/k=
X-Received: by 2002:a17:906:71d0:b0:a38:5443:f4e0 with SMTP id
 i16-20020a17090671d000b00a385443f4e0mr136841ejk.19.1707326222768; Wed, 07 Feb
 2024 09:17:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207100619.3947442-1-pranavpp@google.com> <CACkwYU02EBFet1LgJR29UkLs4gkWck1rnVP7kz+Gti0aAVP_cg@mail.gmail.com>
In-Reply-To: <CACkwYU02EBFet1LgJR29UkLs4gkWck1rnVP7kz+Gti0aAVP_cg@mail.gmail.com>
From: Pranav Prasad <pranavpp@google.com>
Date: Wed, 7 Feb 2024 09:16:51 -0800
Message-ID: <CACkwYU1UUhanBVEEZSaNupXEod4QR-mDBCnWjHZSQyuLzzCv9w@mail.gmail.com>
Subject: Re: [PATCH 0/2] alarmtimer: Rework the suspend flow in alarmtimer
To: tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 2:06=E2=80=AFAM Pranav Prasad <pranavpp@google.com> =
wrote:
>
> Hi!
>
> During the driver suspend phase of kernel suspend, alarmtimer's suspend
> callback is invoked and it identifies the earliest next wakeup alarm and
> programs that into the HW real time clock (RTC). However, there is an
> exception to this process. If the next alarm is within the next 2 seconds=
,
> the alarmtimer driver fails to suspend. In this case, a non-trivial amoun=
t
> of power is spent to freeze and unfreeze all userspace processes and to
> suspend and resume a number of devices. In the vast majority of cases, th=
e
> imminent alarm that caused the failure was likely already scheduled befor=
e
> suspend even started. This provides an opportunity to reduce power
> consumption if the suspend failure decision is made earlier in the suspen=
d
> flow before the unnecessary extra work is done. This patch series aims to
> achieve a kernel suspend flow in which the check for an imminent alarm is
> performed early during the suspend prepare phase.
>
> Pranav Prasad (2):
>   alarmtimer: Create alarmtimer sysfs to make duration of kernel suspend
>     check configurable
>   alarmtimer: Modify alarmtimer suspend callback to check for imminent
>     alarm using PM notifier
>
>  kernel/time/alarmtimer.c | 178 +++++++++++++++++++++++++++++++--------
>  1 file changed, 144 insertions(+), 34 deletions(-)
>
> --
> 2.43.0.594.gd9cf4e227d-goog
>

Please ignore this patch series, submitting v2 with some more suggested fix=
es.

Pranav

On Wed, Feb 7, 2024 at 8:46=E2=80=AFAM Pranav Prasad <pranavpp@google.com> =
wrote:
>
> Please ignore this patch series, submitting v2 with some more suggested f=
ixes.
>
> Pranav
>
> On Wed, Feb 7, 2024 at 2:06=E2=80=AFAM Pranav Prasad <pranavpp@google.com=
> wrote:
> >
> > Hi!
> >
> > During the driver suspend phase of kernel suspend, alarmtimer's suspend
> > callback is invoked and it identifies the earliest next wakeup alarm an=
d
> > programs that into the HW real time clock (RTC). However, there is an
> > exception to this process. If the next alarm is within the next 2 secon=
ds,
> > the alarmtimer driver fails to suspend. In this case, a non-trivial amo=
unt
> > of power is spent to freeze and unfreeze all userspace processes and to
> > suspend and resume a number of devices. In the vast majority of cases, =
the
> > imminent alarm that caused the failure was likely already scheduled bef=
ore
> > suspend even started. This provides an opportunity to reduce power
> > consumption if the suspend failure decision is made earlier in the susp=
end
> > flow before the unnecessary extra work is done. This patch series aims =
to
> > achieve a kernel suspend flow in which the check for an imminent alarm =
is
> > performed early during the suspend prepare phase.
> >
> > Pranav Prasad (2):
> >   alarmtimer: Create alarmtimer sysfs to make duration of kernel suspen=
d
> >     check configurable
> >   alarmtimer: Modify alarmtimer suspend callback to check for imminent
> >     alarm using PM notifier
> >
> >  kernel/time/alarmtimer.c | 178 +++++++++++++++++++++++++++++++--------
> >  1 file changed, 144 insertions(+), 34 deletions(-)
> >
> > --
> > 2.43.0.594.gd9cf4e227d-goog
> >

