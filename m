Return-Path: <linux-kernel+bounces-65862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 817C28552EA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300751F2BF5D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A96813A89A;
	Wed, 14 Feb 2024 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wQsTIVVs"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB56513A861
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937727; cv=none; b=KccfSktObYQFYikCOal4Q8jDKL3BA4VIJyH2Js2okGcfUMInjRDrz461YWXNUhB0rGggk2CGcgZTTtjmGtBoRw2IrmDdc9Ehb6/uRR5aXe11DHoo4VXRaE2cyADXhBq9lBRhsAVMqjVAgfFpvTrPnc5+o1wEtkR8o0KsYwFkyj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937727; c=relaxed/simple;
	bh=xpNEvbzGkpF0R/0F7+c38TH/3aQeLHhKoDQGGcjh+UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZOwjnc/OHys2gzktD1sq69wBCtOafqOCl9i9iT4qCMl8pCwSSwfbhsin5iQ+Gzt0VzxirUciCdI/49QdRFQExvCEWoiKntNxcCUXxFo+RwwRreqKx7Iv8Dt4z5R2Y1EX1UvTNtutkOZwzW60wGKbI7d/eIkl2Zq0uQ8hjd2ZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wQsTIVVs; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d2e19120b5so2981137241.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707937725; x=1708542525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwUBPVEdz2Mb4xRgarDfSSvXTzOIX30z+lxdA48Cm8c=;
        b=wQsTIVVscbtG+q4ZAyQsT6OHBe78O+AdUX4Std0nDP7682XBUmIvYbAuytG0JAcQTO
         WMgs70e36nB+Fc3XAEH3BawwzqByXLjdNVwnZXUONJwJTSRJHG462v3y56L5fWYtWALC
         LfoZcnEUUrJQjbQsVsaxwk4XqqXIHnn9Ow2QY/2eGhS81comIJBQFpb8yPN87OYnRePw
         wwIbLXpzmxY3icJRDkz5sYBkdI6DNdY470Zj2ZKdLR6P4Rp4YQaCOL5Fr9hcJHgIfugB
         xdHpO0Pd6I+KOHpNEnylJdw97XWdD1PJStSO/9xhXnp+3LOPZ1LN3ML6XaVtmDdF/I5p
         7q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707937725; x=1708542525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwUBPVEdz2Mb4xRgarDfSSvXTzOIX30z+lxdA48Cm8c=;
        b=K5lQHnmCbDJlZfgbwVEWkFEouDV/410pzdsHvHxXcsbOS84PlYwTfeG2rbYKfQ00LC
         vHSDOoa9nc5F1vu962//EQkZTzrWwWy3nKdoLHgJx44dvEeWFKEhrsqY/O1rl0R78TAD
         VH2C9uakBxUx22xBjlBPdn6whv8/C26By9ZctC9M5ZxTejEwAOhk1D98TpncqMoOAGiX
         qhP4a2uY7xrmp/06OOrNAG4GmheeDwdno05dFuFBjb4hCZQ7lR4QJYoNm27YpSaf2zy9
         rD+jVCkS1ur/JJqQF8g0sNlDh16FkzJb4BPCpKx63/fwkf51vvn2gf/BC0Eo0vJoC0bk
         v0Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXb87QBUWf1oldvfo+FAci2b7WrC0PcVXLZGH1zanhooM7nMOZm4QwCr5kZutRqQqfrSuB3hUxbLITaw9awcAOYSn4YHrGlqcStZPHS
X-Gm-Message-State: AOJu0Ywpnp6kbB0oZEsCjdAMpGrgxrE7TrAkGjl+2aSI7Y8AKz5fo03G
	I3FI3KpWudOuTsKLdsG7B4jLWq6YrjvCPmgWUb+obEnmzsUkq+yYvsmpg2l25rnRUYhcslNF9me
	IaZEIPFhvxhExNA5+7SVNeZ9W1lUbMEtEutiu6Q==
X-Google-Smtp-Source: AGHT+IHt2zKg1Viq09Cw/ydSj98IJRF5zOxddaIryD7u0RWkJpb5yab6GTBs/iPGXEd3i8Uqs6NLJFMBKv6YMNGuY98=
X-Received: by 2002:a05:6102:f14:b0:46e:e716:aa0b with SMTP id
 v20-20020a0561020f1400b0046ee716aa0bmr2347721vss.11.1707937724757; Wed, 14
 Feb 2024 11:08:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214084419.6194-1-brgl@bgdev.pl> <4a08c610-c249-4b56-b09c-09e1fd07f723@paulmck-laptop>
In-Reply-To: <4a08c610-c249-4b56-b09c-09e1fd07f723@paulmck-laptop>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 14 Feb 2024 20:08:33 +0100
Message-ID: <CAMRc=McXr_3OD6Uf+PKD-wLQfJKJSWes3fh_ZD9fnrPyF9GoSQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] gpio: fix SRCU bugs
To: paulmck@kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	Mark Brown <broonie@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 7:44=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Wed, Feb 14, 2024 at 09:44:15AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Here are four fixes to some bugs in recent SRCU changes. The first one =
fixes
> > an actual race condition. The other three just make lockdep happy.
>
> For 1/4-3/4:
>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
>
> For 4/4, you are playing with fire, but I will assume that you know what
> you are doing.  ;-)
>

Up until this rework, this gdev->chip pointer could go from under any
user at any point. Now we have this gpio_device wrapper that provides
an entry point to using the chip safely while protected by the SRCU
read lock. Anyone who is still accessing gpio_chip directly (and not
being the GPIO provider themselves) is asking for trouble. There's
however no point in spamming lockdep splats in this case. I may end up
adding a warning to these routines.

Unfortunately, it's hard to fix 15 years of technical debt. :(

Thanks for the Acks.
Bartosz

[snip]

