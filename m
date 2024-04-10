Return-Path: <linux-kernel+bounces-139445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEC68A0372
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0EB61F25249
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E496A8BE2;
	Wed, 10 Apr 2024 22:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IYnXB5PV"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26FD883D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788413; cv=none; b=lS7FOAZVpoMh/sxfQOhc8q3exR1rrl4i38TynqSuI5UvsvGJ76pm8SmenUjAKNjeZ9rbv7r5XAtXoo5lY4lOHJU4C4fUTh7fKf5flzUNGqYDd5/08H9VAuuBbKHXvqdGQFsjxOSouZst5wLLt500yT4yuzAXyqAMMHp4Xjwe0VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788413; c=relaxed/simple;
	bh=4ft8+BLnp4b5tUU7G3n/2WvSh88QV/cvF1d+A/V40wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQX7LkatSzbsWiy7u+9OXjBvsogwfPE+IQp1h1xvzjmJ9VZlx0vy5puQ2nyE99XaUSvY3tCkMz+CC4W/uCBzCAtyAAW3kzs9sPyDj9bJMRI40eOQqkBIyLbd73xF0ncmnOf9ntAd0mZafu1/LfZYhZrcxsjrZ0v6zv7YPBlDhkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IYnXB5PV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4154d38ce9dso17655e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712788409; x=1713393209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGcSmVs/OyYWYMT/pav2rCPGZAehytayienznXagGm4=;
        b=IYnXB5PVVXKgKBzTotaL9+ZIICp7UOVZLEhhAVOCc1qtI7Z5ZMr1775RIuGV5zB9Pp
         wzEmgOcqI+iBnAB/MRXtl+LEvcmcKmhrsa1VBGBEIuKufEvmvtgtBwXro4JGrIaQWil3
         loEDNbKRM2ANY4ZnNPWavAcjFMAuE9+ySrjl2xW8EgYhUOPd0uIa/hggP+Bo82l7YEOA
         +qpwtedsFUHUbOlrJQr0I6WAeC5wiGxe6gZFp3LL/Sxnki+wTo0QSqaZQ1zsR0yQhCmK
         TZjFyg41yInAdbooWF4t9CFPpiTgJywCTrJNuRcbgNDPWZtTsYBt5ZucHhJtj5PKk1vF
         S/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712788409; x=1713393209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGcSmVs/OyYWYMT/pav2rCPGZAehytayienznXagGm4=;
        b=DvGOkzitkCNTcpDxWbML/goi2GWGmD5hcXL9vjkapPaRTPUxIsoxfBzZEJxmsuYXDe
         azzoA9J4P3VrJ0RXrPWk/CPudjpNWLh8y4120btFPnCqe/+3PgviDF+7NI/VZc2FvAfW
         640tdyDPNm9x3wmj/6igv0uGizLwoxmqZwTEMIHYALIiTvhCHVv7p5fBs7Vh2wOeedGE
         hRTv9dXMjIy3QgXCQSe+7syHqQZlXvCMsmazO9hGmnnX/Ur35EChsX/4a+CipsStRK5g
         wMpogM9iEUsSkiw84FArvF5D35WZ+k4Eiv4R0rIzpEW9PKDNeKp+06qHV9rY86JaX6Eo
         MVdw==
X-Forwarded-Encrypted: i=1; AJvYcCVrLQ0NSpqe0t/ux62iT2aMBIdg+U0jZSfBP9BJAkkQ7ljB5AKFbOt+2E0NIHdFcrukusyHXgzk3CCqUptnLv3SBmYHCBL+bZ+hzArv
X-Gm-Message-State: AOJu0Ywe8SbWyqTmrZfc09HFqT9RrRitc6sgME57bWiRSM+fldj9YXpw
	lK9UHXvZsL7vV1/mcNpWGkOmqQdW6EkPmGPww/RKgdV8ra951mHgjfUq00hNsavudkgRSJVuzGa
	4MTIvOQdEirz4c6ss8UkLfykvEwnN59UKBHU=
X-Google-Smtp-Source: AGHT+IEBbpFtvARmE1LPzV9bk/pygsBn+sOPIDeU2X2UzQNazot/tH3r4k8KEounn2kt3p3wZnVlOihZCa85CyVDhxA=
X-Received: by 2002:a05:600c:3503:b0:416:6d90:38fe with SMTP id
 h3-20020a05600c350300b004166d9038femr69216wmq.4.1712788409046; Wed, 10 Apr
 2024 15:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404145408.GD7153@redhat.com> <87le5t9f14.ffs@tglx>
 <20240406150950.GA3060@redhat.com> <20240406151057.GB3060@redhat.com>
 <CACT4Y+Ych4+pdpcTk=yWYUOJcceL5RYoE_B9djX_pwrgOcGmFA@mail.gmail.com>
 <20240408102639.GA25058@redhat.com> <20240408184957.GD25058@redhat.com>
 <87il0r7b4k.ffs@tglx> <20240409111051.GB29396@redhat.com> <877ch67nhb.ffs@tglx>
 <20240409133802.GD29396@redhat.com> <CANDhNCrverCP+nB53XnMKFH4sTvxmtchiLWyGbNW6du=8xOSNg@mail.gmail.com>
 <871q7c3l47.ffs@tglx>
In-Reply-To: <871q7c3l47.ffs@tglx>
From: John Stultz <jstultz@google.com>
Date: Wed, 10 Apr 2024 15:33:17 -0700
Message-ID: <CANDhNCpas4AQuAquVMVFgN3NCfCsVgg993Kjad8MjvSZAbsXow@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/timers/posix_timers: reimplement check_timer_distribution()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Oleg Nesterov <oleg@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kasan-dev@googlegroups.com, 
	Edward Liaw <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 3:31=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Wed, Apr 10 2024 at 15:21, John Stultz wrote:
> > On Tue, Apr 9, 2024 at 6:39=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> =
wrote:
> > This is working great here (on both 6.6 and the older 6.1)! Thanks so
> > much for fixing this!
> > One nit below, but otherwise:
> >   Tested-by: John Stultz <jstultz@google.com>
> >
> >> +err:
> >> +       ksft_print_msg(errmsg);
> >
> > This bit is causing the following warning:
> > posix_timers.c:250:2: warning: format not a string literal and no
> > format arguments [-Wformat-security]
> >   250 |  ksft_print_msg(errmsg);
> >       |  ^~~~~~~~~~~~~~
> >
> > A simple fix is just to switch it to:
> >   ksft_print_msg("%s", errmsg);
>
> Can you please send a delta patch against tip timers/urgent?

Will do! Apologies for not getting to test and reply earlier.
-john

