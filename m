Return-Path: <linux-kernel+bounces-79702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2999862594
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 15:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582821F22C65
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F5B42056;
	Sat, 24 Feb 2024 14:12:13 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAABF18622;
	Sat, 24 Feb 2024 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708783933; cv=none; b=B0byjrv4gcGUfw9CRwl+US627BgWIspCkcC8fKOi8mHRxhJGksx7zI8Ayle48Mt0yZFEG/nnTuIZZe+/ELhHPB9AzReckD3js59aWEeFNURQpEDim8FnxTQHzFCrYx3zlBUs1wXjOYeVr38KSUFtZyFcozQAnWBTtHvNkTqQHco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708783933; c=relaxed/simple;
	bh=0FgNsjxOprgob6IpBDE43VocMkHW5zVSFxJ4WpG2R4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOzIO/dbsHedx9I6Fcau7zwkVzVh36bsZhIr2wpCIWRrMeB2UQj7xrt2HgN1GEqgITuGnJcCz1cQ/ehlkJllWyt5G/mFU8lOeWv2Zp21Ox9N/4+/F4fjrPvzFtRk4dy6pM0Gs1tc4l5sMc37yb4pLio2Ztkj47yl6vwC3+7ZXZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bc21303a35so654848b6e.0;
        Sat, 24 Feb 2024 06:12:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708783931; x=1709388731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FgNsjxOprgob6IpBDE43VocMkHW5zVSFxJ4WpG2R4s=;
        b=OfNrZlfxfnaGwJ59xbGxHbN0xhVjMlGVY9fVe4h6haq8jjx9wxMXGZp5M2cpwhJ2vs
         JTBF1JhS0d+pijdy0CKW8REitYtdonh8O3rh601ymGy+MpD9QZYYXsFIi3BG1gBFoVEr
         6iPoiVqUHzS/vhYaUiDGf/vds/EAC9Sah8kWffpaoL4nRCi5HcT/MJbxP2j4le2B1c2+
         ZBosKRV2nNSGnHwPGODyPqSEFbaYYOiXKu7O5JWF9R5tWBspkfT5PxBEg8o7D4BsbqH3
         a8+yQvE0uBF9YgyxU3sx1GuAuxjSEF017Vr84w0fk/JWc0IODqMRMrYQoxdSOy02g4k1
         xuhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyDxxzO+3cnzK7OjGc5ra0HSrT2B4B+xPpPKXjqLTWLxClhLzvxWStT9mThUfuHduSbAEaJ5dbK/ysr6deGmrwskt6KlI0mQFwFFjErx7gyNKVja/peew/4JwOJJwyrmcWALcr/T4=
X-Gm-Message-State: AOJu0YybLC48V1WIZa55YC7PQF5/2yNwhH6MJrHYLaZGcMUpMNFJm1e+
	ShTLm1JAQQ6AKrxCf16lsS4hGG1R8dR4zymjmVzJPiFpQKz9nO4QchpDDchwk94pBkcYm6xh4Rj
	uB7NK6s0d2EFeCt2XSVZno+nPWD8=
X-Google-Smtp-Source: AGHT+IEVnUZQ1BW/6uiqG0tAPjBJBhge0xO0MypFZh90pjdUMU6FtbvTfMVVjuP/it801XVImJNU1DnIzuC7z3kUutk=
X-Received: by 2002:a4a:d037:0:b0:5a0:3d13:a45a with SMTP id
 w23-20020a4ad037000000b005a03d13a45amr2466185oor.0.1708783930814; Sat, 24 Feb
 2024 06:12:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <002f01da5ba0$49cbf810$dd63e830$@telus.net> <CAKfTPtA-jizig0sh_shmkAMudAxDPYHP0SdanZe=Gc57jVKouQ@mail.gmail.com>
 <003801da5bae$02d6f550$0884dff0$@telus.net> <CAKfTPtC7pOtb-srrgQLFbTueLLDqHay+GQBm9=sNsnZDg_UYSQ@mail.gmail.com>
 <000b01da5d09$8219f900$864deb00$@telus.net> <CAKfTPtB8v30LzL3EufRqbfcCceS2nQ_2G8ZHuoD5N1_y-pvFbg@mail.gmail.com>
 <001b01da5ea7$86c7a070$9456e150$@telus.net> <CAKfTPtD4Un-A2FcdsvKnNZskG=xH0wrsT3xzaWDs--mQjgZ3rg@mail.gmail.com>
 <003001da6061$bbad1e30$33075a90$@telus.net> <CAKfTPtC82YXOw5yYPNkHHyF+DYSG+Ts9OjnwsVjbd_HcUsZQMg@mail.gmail.com>
 <c03533dc-73fc-4d97-8248-0affbddbed32@leemhuis.info>
In-Reply-To: <c03533dc-73fc-4d97-8248-0affbddbed32@leemhuis.info>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 24 Feb 2024 15:11:59 +0100
Message-ID: <CAJZ5v0hfMuiZCFU6e9TZ7yZV1qER2ymOM7d=AAf5beyMOyHg+g@mail.gmail.com>
Subject: Re: sched/cpufreq: Rework schedutil governor performance estimation -
 Regression bisected
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Doug Smythies <dsmythies@telus.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 2:44=E2=80=AFPM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 16.02.24 14:17, Vincent Guittot wrote:
> > On Thu, 15 Feb 2024 at 23:53, Doug Smythies <dsmythies@telus.net> wrote=
:
> >>
> >> This email thread appears as if it might be moving away from a regress=
ion
> >> caused by your commit towards a conclusion that your commit exposed
> >> a pre-existing bug in the intel_psate.c code.
> > Ok
>
> Well, even in that case it's a regression that must be fixed -- ideally
> before 6.8. Did anything happen towards that?
>
> I noticed that Doug send the fix "cpufreq: intel_pstate: fix pstate
> limits enforcement for adjust_perf call back":
> https://lore.kernel.org/all/20240217213010.2466-1-dsmythies@telus.net/
>
> Is that supposed to fix the problem? Looks a bit like it, but I'm not
> totally sure. In that case I'd say it likely should be applied to 6.8,
> but Rafael apparently applied it to 6.9.

This hasn't reached linux-next yet, so I rebased it on top of -rc5 in
order to push it as a 6.8 fix.

> I'd also say that a Fixes: would be good as well (to ensure that fix is
> also backported in case anyone backports 9c0b4bb7f630), but I know that
> subsystems handle this differently.

So I added a Fixes: tag to it, but it points to the original change
that missed the check.

Thanks!

