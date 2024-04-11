Return-Path: <linux-kernel+bounces-141459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5698A1E93
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B80B2243D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2D213A400;
	Thu, 11 Apr 2024 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vSoiG2zy"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4674A52F61
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859133; cv=none; b=uwH9uiTdl1wBrEOLsUeAtL4X9KDesZkcAM1SaZ/j7Jqbl+92lre3JPcw0VZccEWeHWdRSTRpObSFPFNVKuvihwKPFRbmLcz9omoJJoNPlK4sl8ZtL8e57mV1qwHijIjL7HzvIxWmbUyEbURcACl60z2FlsFxfVrIUOdWD0oc4ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859133; c=relaxed/simple;
	bh=/dUJA+XbUGenD4g8v83RfIj7fBGYLUqYG5CdW+CW3Hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgNkqdfy9r+STBLzeBJWuf3H4/C9KZZHO9G7Gffg1GAAQQYttIQRFE5RzOFihn8XqbZSXqjdReOXRY0xegBKtsa35ql8gbUguVYUsMJJXRBna1Np5vQfLv3yL2yZ02X1XyxxICF3h/TsLKwnGJoX4LSxAz5IA0U7ijjarcvuLf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vSoiG2zy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41641a889ccso10945e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712859131; x=1713463931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHxm013cvc73THS5FG/NfOp7xgo/HGk9+aw/ZnEUmUY=;
        b=vSoiG2zyGTZ80NJ7G6Lt3XuLVEOgWGAUe/fXqzCXLYGV2Tl2avVdiQLGJqVT+Rz46g
         ynEfJX4eiD3j6l9WXpZT8X/0JUKYaBwuIXJ/SNJbiE6wtaf8enuLLzv1ZcnCr56CE9Av
         0SJgyKy2yv5cIr1S+SYMQi6ZGpO8dVXUFX+n5UaROqhKtatQa1YVk98LaEI9ZFptbWnx
         HUExqpm+SLiLSQLTDsaNVVss/mIvQeJ2rZZZ1Ai8vKzx7g8SXqI2SXr59K9IlMoRbsN6
         sv8SNto6UvRUSVoGbZgFr5QDj4rROy0HHiR/5LVa3Y7l8zzKE5FovJHBe0Xm/7LXl6su
         QWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712859131; x=1713463931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHxm013cvc73THS5FG/NfOp7xgo/HGk9+aw/ZnEUmUY=;
        b=Z7IVqNW65kq9tuEEDtW5wtsV1LfDEWvbUeY/Iea9wuOiaZz1rcgIxfJ7JC0ekmiomF
         R6ULaUd2ov0yqJokJf1bcu0fy8HCey7dDlxiCECDyNMt2CPLOMnYB6l+tVGsJJDK7spe
         EbfbhSpjJnSumlIdHZBrTvQw6iBmYGcIb4oqRHpjsI1g98nW6hIDi+RuTyXEVA47Maj9
         rdqo0+iJ1qVddfWZKAzLXPKRRE/MnrJ+qiNaJr2Hg6AcC85TORW7SNnRJDmM7/DIT+ks
         WNZo6xXkPuSRU98ckLOIT6SJwERIUsvHm9FSL/GQ0WWAZT0wU1QDvoflYz/AqWxC1dBI
         4KRg==
X-Gm-Message-State: AOJu0YwA5Ndt5NtjXZqh5R5MMxAD3CVyJ3ssFRtt2Ci77I105lZF45Bn
	qiNSFFJazSrPDSBvPG1x+k/vOjHqk8ywAc3vNWrS0MzV1bC98xjbezDaNv60ltLKG5XsXq2I0Og
	p98DBfK4mZxZ3AV0pFWoDIQ0qSE1uQPB6IEc=
X-Google-Smtp-Source: AGHT+IET2OjDmigYTA+klusxCOo2xcGggARz2NyK1d1Aq9DKT8j1m4xgCtR+8b3T5JLCku8nxoJa9KeESPqI2Ti+IcE=
X-Received: by 2002:a05:600c:3b1b:b0:415:4436:2a12 with SMTP id
 m27-20020a05600c3b1b00b0041544362a12mr4008wms.3.1712859130655; Thu, 11 Apr
 2024 11:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410232637.4135564-1-jstultz@google.com> <20240410232637.4135564-2-jstultz@google.com>
 <20240411153945.GA2507795@dev-arch.thelio-3990X>
In-Reply-To: <20240411153945.GA2507795@dev-arch.thelio-3990X>
From: John Stultz <jstultz@google.com>
Date: Thu, 11 Apr 2024 11:11:59 -0700
Message-ID: <CANDhNCoaMX7B5_SLuo-oaYD6VGdqT7vqPw2fe8ONz7AFqO22qg@mail.gmail.com>
Subject: Re: [PATCH 2/3] selftests: timers: Fix uninitialized variable warning
 in ksft_min_kernel_version
To: Nathan Chancellor <nathan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>, 
	Carlos Llamas <cmllamas@google.com>, kernel-team@android.com, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 8:39=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
> On Wed, Apr 10, 2024 at 04:26:29PM -0700, John Stultz wrote:
> > Building with clang, I see the following warning:
> >
> > In file included from posix_timers.c:17:
> > ./../kselftest.h:398:6: warning: variable 'major' is used uninitialized=
 whenever '||' condition is true [-Wsometimes-uninitialized]
> >         if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &min=
or) !=3D 2)
> >             ^~~~~~~~~~~~
> > ./../kselftest.h:401:9: note: uninitialized use occurs here
> >         return major > min_major || (major =3D=3D min_major && minor >=
=3D min_minor);
> >                ^~~~~
> >
> > This is a bit of a red-herring as if the uname() call did fail,
> > we would hit ksft_exit_fail_msg() which should exit.
>
> Correct, although we have not really conveyed that to the compiler,
> right? exit() is noreturn, which means all functions that call exit()
> unconditionally are also noreturn, such as ksft_exit_fail_msg(). LLVM
> will figure this out once it performs inlining and such but that happens
> after clang's static analysis phase that this warning occurs in. I think
> a better solution would be to add __noreturn to the functions in
> tools/testing/selftests/kselftest.h that call exit(), so that the
> compiler is aware of this through all pipeline phases, maybe something
> like this? It resolves the wawrning for me.

No objection from me if this is the better approach.

Would you send that patch out?

thanks
-john

