Return-Path: <linux-kernel+bounces-56792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7822384CF3C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2DBDB27FE3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0D781AD8;
	Wed,  7 Feb 2024 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ow+7rXcb"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399D0811F2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324429; cv=none; b=X3CmLmDA4UIfpS6hQTL5i54f/C1Bgu4S6iR9hfkWVKAGPYUAUiCzfkFzQUAWetdj7J7Txwn0CODhFz+GntvWxYNIo0VxPTbcHpMMOzJCUYxxZzZ+wDZCcPVyKlY+zg59lSBBQKMGFgXE+arcLXMXt97rvZOLDkvqN5zYjigsQeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324429; c=relaxed/simple;
	bh=Ol4YWhmXZ05lW3VETc45pz1X+eRFewdDFCHvvqRzc9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i17pbL+kl/xmdJxj+mWgR06L6nzoUzhRc9+ewWPRg+MjNfurtj/tdzNmrl0t1eUpKQea+TMBD+Ifp+jvEhdWcWVFrfqy2GmcmxVxlIpQy+EM8Lr+Y6VbdypbGqxdea/4Okd6XsNPyAOpF5davQMwIsZbKGxeAIQSKGl4HUVEWd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ow+7rXcb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so114407066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 08:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707324426; x=1707929226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5QDMbEXnz0a9DJjbd5r5ka2eJdhDxqak19jUyB3HAI=;
        b=ow+7rXcbY1RjEyfPxcrxiQ6vQqDsvO/jM1QyhwTRqHB990dK8LsJmtSbxJiMPaynf3
         AP7i0FETO9NYbF1ZYCMQVRxRs2wkVyDM3mjiOsHjoV1qMQIZHo7KpOz6RJQtl1MFAKNI
         chMo5jxCMleq4P6fpykjDbz3pGrlRuRWNf4l/LUjaPGKJAX4TntWu+r24AFOlGqBe8Ir
         bYDmzGvvXtLJFs8jTnjTCdwubISppD6sdK6eHoxTVgxNmjGS91Y4WWJHeK4HoxArFMbp
         wNOo7IALy+N1G+yzr85H+T0gN5SA0ZV2WlqM2sU7FRMqzRYYPSrM32qie2mI4muv/h7t
         aiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324426; x=1707929226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5QDMbEXnz0a9DJjbd5r5ka2eJdhDxqak19jUyB3HAI=;
        b=cxqBQu/oNWJlACQKD4BqrrWehD7V2rjOrECSnzsKUoMV/wTT4gIzFoksgovf+hKacy
         Lhm1+NijwQiTDfgnDFAd3MuvEbYYxm6C2bOImRqvIPhBGjLVt+QXRhFk7mHRcfhwHKrB
         11hrG2UcxlTWyxEyBqwWwSxLB7gC2PynxGujJ205bhrg2wj4mdhBMLKAi4KqvEylwV52
         8Yg67BpNupgMH0Sme/UBm89akrAL5wMzgvoXV2pmb9jt2uaD2gP+Bmh2iykkgDMAEPpJ
         N2daMEN8C8Aj3sMOahc+QBlKw3vaxvPpErb15oy8AITippuxRarNFTDh0HojFeCPTj1F
         yEsA==
X-Gm-Message-State: AOJu0YxLBHziG00BBf+osGro/j6tJLY0e3Te377oJYmyRWeSsXS78RxD
	2KYRBgS6+p8hEkSwfU7KYRMBAj9bItBXYYco4f8OudNu/2cO5IIhgTlsMeGC0ZIGQfQ7IHWkWHl
	3GR0G78OpxAWY3AS2+SnBRYWn+dXwkxPL1YBx/a8ZlKpl5lgswDyA
X-Google-Smtp-Source: AGHT+IEjBWmKKxMZOlCnOzgDrv3CrfFruuJM0bmRpPVsf2LKoVwWBoQSkipYza9xI5vPvlQEnJTcUTd5RZWKfXjPYic=
X-Received: by 2002:a17:906:550:b0:a37:20be:b37 with SMTP id
 k16-20020a170906055000b00a3720be0b37mr3849178eja.58.1707324426344; Wed, 07
 Feb 2024 08:47:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207100619.3947442-1-pranavpp@google.com>
In-Reply-To: <20240207100619.3947442-1-pranavpp@google.com>
From: Pranav Prasad <pranavpp@google.com>
Date: Wed, 7 Feb 2024 08:46:55 -0800
Message-ID: <CACkwYU02EBFet1LgJR29UkLs4gkWck1rnVP7kz+Gti0aAVP_cg@mail.gmail.com>
Subject: Re: [PATCH 0/2] alarmtimer: Rework the suspend flow in alarmtimer
To: tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please ignore this patch series, submitting v2 with some more suggested fix=
es.

Pranav

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

