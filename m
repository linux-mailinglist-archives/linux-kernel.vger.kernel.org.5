Return-Path: <linux-kernel+bounces-164154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996D58B79F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87401C22E05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C905C1527AA;
	Tue, 30 Apr 2024 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frz5ogwe"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700EE181B99;
	Tue, 30 Apr 2024 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487458; cv=none; b=jirVxAdsa3HtRfulG/degneLLxmtxtChYa+22M8NZD7enTDPMb/Aa3wcjKYS63kZgErergVLBUBkKe/YMEfJYDcmSaYrK9uYBTwO02HFnh6F2AzS1+VutZ6ytDJFNIFTFXcWSd80FNfZCsmzuzAU38BheTOS/7216Voqun7WPDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487458; c=relaxed/simple;
	bh=oIu77yJ8jUXRAwXdOkexEPrPZO91cF32r9M6/AkM+Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgu77TJR+hQfkHl1B0AZ6KNGBl0xNlcOBrQODsRhVCsiW5UYvZAWpZFgn4Rd4ZLQR+MVDe9tu8osr/oQCZ4EriLIeN5gS3uGNBcqZ9QYMhttXonctWLNIdYYY1tmD66T8KW4gr6pypSZPlfKI249xa7HwXYrhS41PZtXU6qJUdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frz5ogwe; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2dd6c14d000so71243071fa.0;
        Tue, 30 Apr 2024 07:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714487454; x=1715092254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEOadgbQT3YL3EGb5PWaYHsAq47K4P1J7w8JkzUt/l0=;
        b=frz5ogweENkcEl9Df8RpRAB/8GNkkDQy3kOZb0aEYZfg0/s+blhkRLbJo4yOA6mb1v
         VIEqdzziroKlS1tzv+pO0ZArhdVpdPza6F5LdwLatdoJE8oB1/zPuUSUySGgALpFYJTU
         FuBplNdm9/O6eFLHD1S93tf0Dh/5xMaS1EDjBvzrQkS2L598ZB69qonFyw5VSTQB9jUd
         MsUDC6uT0YfBEDjCGVC3vT7iJMY7VEQdQFc0u7D4mxR2H6i/iZumXbz9m79q8B6QCwFh
         y4EenglfTf3RlOZJ+8RIwJ9cl70CNOWEgJv2yoTptVCjfJBMP+EaQ5Eg7yvhXVHSqZDB
         Fkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714487454; x=1715092254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEOadgbQT3YL3EGb5PWaYHsAq47K4P1J7w8JkzUt/l0=;
        b=qaSKCGQtaipWC1qe7T4MJmhPsdai1bLGmHb8Y56IfsPHnrX5WRnenLM5ve2O4AhCcr
         1zTnhO07Tl6jLhsp+ZgJyDOl1gvPq4Dt3yLYFu/m+eA1WrI7gPtHRH74Ho4a0JYfo6t8
         NHMc/yl5rVo4k1EraSTOXZqrK8ZTvjDBcb7FOo81/ytG8fiR7urrDERGh53l4rit7egT
         VAV8cEHl9CjNeqD/FLNBQaTkKmK2K0elpYLcFfL1aG3g6wVjfUcisFKS6ORCfZMWivMD
         bPfQkvhz86tT/c7qBej5y/ZflnktP5q1oVKvByhqnS2Vr4OU6fyg1uYiAIs4CMII3Y5p
         5RHA==
X-Forwarded-Encrypted: i=1; AJvYcCUJjRrsYRJE6Jq/esJR/FgjphdRi5vAVKWaKS53aU4moG32goCZ7BWYgTFN9S9xVbwIZw39MFW8rtt6GMeW/6+74pBOAkEdcc8L5GA7EZbLwry/pb3xYFpZqyqjsdBdruMJNPWLH77QQyyT638=
X-Gm-Message-State: AOJu0YxcWY75dppE7du71cxjji39rHejDaj8UBjYHerwqb5FkUXmTwjf
	WbZQ6zat6gOiREjE20TvcmjCn1ida5g6Hs8tec3rNHVsPlAhFR4tGbJbhppnr52HRrFPmIyKgDS
	yF0FnsjTg6LHL7HZbtO4rckGgCEM=
X-Google-Smtp-Source: AGHT+IGjOrb4BHOISLk99QfwZ1zS8Uq99QSSFpGq0P8HcPecTZ6qZzCz7vA6fnsaQ871JWWvDVySYkqIhti1ybrIaV8=
X-Received: by 2002:a2e:9b0f:0:b0:2df:e2d1:f4b5 with SMTP id
 u15-20020a2e9b0f000000b002dfe2d1f4b5mr6985340lji.21.1714487454257; Tue, 30
 Apr 2024 07:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240428142937.785925-1-peteryin.openbmc@gmail.com>
 <20240428142937.785925-2-peteryin.openbmc@gmail.com> <d231737bfa9f3dd3c0a4370ab2e86557a407980d.camel@codeconstruct.com.au>
 <CAPSyxFRG8mooBg1QWZk8sw=cWzoUQqk=WnyAtgPfRBmQRKtvaQ@mail.gmail.com> <e694ba58197687dce68d568dfcb078ff3a6c6fed.camel@codeconstruct.com.au>
In-Reply-To: <e694ba58197687dce68d568dfcb078ff3a6c6fed.camel@codeconstruct.com.au>
From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Tue, 30 Apr 2024 22:30:43 +0800
Message-ID: <CAPSyxFSVkyKQ2xvg92xqpkL=0WYqt+rP_+TjcM19mEMtu4FPng@mail.gmail.com>
Subject: Re: [PATCH v8 1/1] drivers: watchdog: revise watchdog bootstatus
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: patrick@stwcx.xyz, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>, linux-watchdog@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,
  Thanks, I am going to fix it in V9.

On Tue, Apr 30, 2024 at 9:38=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Mon, 2024-04-29 at 22:54 +0800, Peter Yin wrote:
> > Hi Andrew,
> >     I am not sure how to add the Fixes tag, Is it like this?
> >
> > Fixes: 6a6c7b006e5c (watchdog: aspeed: Add support for
> > aspeed,reset-mask DT property).
>
> Approximately, yes, but it must not be wrapped.
>
> Some more info is provided in the submitting-patches documentation:
>
> https://docs.kernel.org/process/submitting-patches.html#describe-your-cha=
nges
>
> > Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> >
> > Is it the correct commit ID or should I base on which commit ID?
> >
>
> The correct commit ID to use is the one that introduces the problem.
> Using `git blame drivers/watchdog/aspeed_wdt.c` it appears you're
> changing the behaviour that was introduced in 49d4d277ca54 ("aspeed:
> watchdog: Set bootstatus during probe"):
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D49d4d277ca54e04170d39484c8758a0ea9bca37d
>
> Andrew

