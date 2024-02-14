Return-Path: <linux-kernel+bounces-65651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0652855005
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C526E1C28EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9908184FCB;
	Wed, 14 Feb 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GI5OsJ1w"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA43E83A17
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931204; cv=none; b=toqmiopZAhJH4NJKUso+t/ZPDHytYpg4bHrDFnwiuRBHGPi0Ug/2C8Ei7+q2LpFIAH8MVPNiHz7cqhZGhCoZCfwUYjx208uyzenrHIocgx9NqVkciXmDWftD95rgBbZCSr9gCOU3Iiy9Fx9hi+pgLtoEVOq8cPYp8xWLnuCpkgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931204; c=relaxed/simple;
	bh=zJ9UnsbBVQk+7CK64IucZXo37BDgEgF/64+egIlJnYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tg/dX7BKg74TteCkgTpYxrVVVIztWcX0hi5b6QPP4uodQ3gDBeLxWD+ZKcoilpWPRld/O4fGnJ9pDGxCW5/VtwMu1dewur6wo/BbLFUlRj9XW19B9cS9A1g/A2jstIqZWMryEYRevmaRk9zrZ80eIX7nx2vaCdGBvO4GYrMfX/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GI5OsJ1w; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-561587ce966so1966839a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707931200; x=1708536000; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=236lqzUHLILRkjMonxzcy3On2gm7C9J5rPgBDfLu9uc=;
        b=GI5OsJ1wz5H57Sg4mAXsqobe1T4cnGXVVvPIZYy9/pYyPNM7H7qlJanQEFrYmi6fw0
         5AunEgggKy9cS5hSKY5UfCfii2Sw2D1XK+mC6FBEuZ1c3KrX7G+6O/OGKMvZPYjNoSwK
         sUt+1NPmOynEM9Mc6gCnvzntgqXkRcHQGhm4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707931200; x=1708536000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=236lqzUHLILRkjMonxzcy3On2gm7C9J5rPgBDfLu9uc=;
        b=WQgkALc9Y7Wa+SV4fNjIaIrO/AOqVO6HPrQGB3uhrZW5pJaOEUH2OQS+7lopOHPysn
         OzwHjCfuyUATs7fNA8hNIRy0tI41BIHAbHtkJCyG+WBsYTptK5d0GUdabz7eP8Lskbyp
         har+0ffZrQd7s1SrHzza8qiz9a9qbH/iNrNR5XkphXKf8NSYbkdfy+HF9bUEpqs+D0gT
         MEF/DeirERtdxOjmbXh9he7Cippd40A8WYQXOV8G8g1pdoy0pa4AL5nke0JRwNnm96L4
         SkQJdcX35NJJYLW7f5tq+DNrJw9UBtsMOIcVNJVGC0/Sc68N39YZr9P7tAc2HKTnzcO7
         ISyg==
X-Forwarded-Encrypted: i=1; AJvYcCXevKqPytyqSn0Tm5BYkZK67PV5fk5tKXn4pUbLs6vd9psvepfzisbIvLx5gjulBjoLKV3+dN1xiwQWnY/mOsoj4wHeTMlQrtCk/3De
X-Gm-Message-State: AOJu0Yzh9mu0eW621b487YXvJiXXJUM9wd1yuyE281vNM/MCo5dKco10
	LD1QvJLR8w9/lRd1L16aTcFRotmjxGOGcdl+iMSfh/bico5hXgVkxasT+1U/qV4Gn0VMJuNbU1F
	GoT8=
X-Google-Smtp-Source: AGHT+IGTzn/MRKZ55WwbZtPC5eQOt+pk4nB8u5Hy3P4h+3jAB0qsDBVdAeivGjlWV5uB6c4uzFnb0A==
X-Received: by 2002:a05:6402:12c9:b0:562:1094:7556 with SMTP id k9-20020a05640212c900b0056210947556mr2531898edx.8.1707931200437;
        Wed, 14 Feb 2024 09:20:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhWzpvmpO4Ap68HbT1AQZtZJddDbED5itpyKxwIfXK5pKnoKbhO0N/ZlTShGub2zJobGpqaV4SPYsDeHX5ljzr2rBS0l83SFVi1l9a
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id b8-20020a509f08000000b005637db1a071sm706980edf.86.2024.02.14.09.19.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 09:19:59 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-561587ce966so1966752a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:19:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqLr6LSnw2RYFXLswX5jQedpj08gTwq4i1r1nCHdTeKxwcDZXJNYp1HcpU5QLeGJCDGNHIukIZqHhT57kB4f5EfGn/fGNUy/izGyOU
X-Received: by 2002:a05:6402:5410:b0:561:5e21:8b89 with SMTP id
 ev16-20020a056402541000b005615e218b89mr2620799edb.13.1707931198880; Wed, 14
 Feb 2024 09:19:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240114183600.135316-1-vincent.guittot@linaro.org> <6ec54a8f-a602-4f33-96ce-0204f07046e1@nvidia.com>
In-Reply-To: <6ec54a8f-a602-4f33-96ce-0204f07046e1@nvidia.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Feb 2024 09:19:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgjiVanO4ZS1hy2sfAFTN_pYtQqVQb_g+dbrP34M6xTDw@mail.gmail.com>
Message-ID: <CAHk-=wgjiVanO4ZS1hy2sfAFTN_pYtQqVQb_g+dbrP34M6xTDw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix frequency selection for non invariant case
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	wkarny@gmail.com, qyousef@layalina.io, tglx@linutronix.de, rafael@kernel.org, 
	viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Thierry Reding <treding@nvidia.com>, 
	Sasha Levin <sashal@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
	Shardar Mohammed <smohammed@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 09:12, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> We have also observed a performance degradation on our Tegra platforms
> with v6.8-rc1. Unfortunately, the above change does not fix the problem
> for us and we are still seeing a performance issue with v6.8-rc4. For
> example, running Dhrystone on Tegra234 I am seeing the following ...
>
> Linux v6.7:
> [ 2216.301949] CPU0: Dhrystones per Second: 31976326 (18199 DMIPS)
> [ 2220.993877] CPU1: Dhrystones per Second: 49568123 (28211 DMIPS)
> [ 2225.685280] CPU2: Dhrystones per Second: 49568123 (28211 DMIPS)
> [ 2230.364423] CPU3: Dhrystones per Second: 49632220 (28248 DMIPS)
>
> Linux v6.8-rc4:
> [   44.661686] CPU0: Dhrystones per Second: 16068483 (9145 DMIPS)
> [   51.895107] CPU1: Dhrystones per Second: 16077457 (9150 DMIPS)
> [   59.105410] CPU2: Dhrystones per Second: 16095436 (9160 DMIPS)
> [   66.333297] CPU3: Dhrystones per Second: 16064000 (9142 DMIPS)
>
> If I revert this change and the following ...
>
>   b3edde44e5d4 ("cpufreq/schedutil: Use a fixed reference frequency")
>   f12560779f9d ("sched/cpufreq: Rework iowait boost")
>   9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor
>
> ... then the perf is similar to where it was ...

Ok, guys, this whole scheduler / cpufreq rewrite seems to have been
completely buggered.

Please tell me why we shouldn't just revert things as per above?

Sure, the problem _I_ experienced is fixed, but apparently there are
others just lurking, and they are even bigger degradations than the
one I saw.

We're now at rc4, we're not releasing a 6.8 with the above kinds of
numbers. So either there's another obvious one-liner fix, or we need
to revert this whole thing.

Yes, dhrystones is a truly crappy benchmark, but partly _because_ it's
such a horribly bad benchmark it's also a very simple case. It's pure
CPU load with absolutely nothing interesting going on. Regressing on
that by a factor of three is a sign of complete failure.

                  Linus

