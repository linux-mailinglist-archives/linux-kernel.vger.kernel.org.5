Return-Path: <linux-kernel+bounces-139535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0AA8A040C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50512835CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F983E494;
	Wed, 10 Apr 2024 23:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fXrj4RLu"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A5D28370
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791715; cv=none; b=L9QC0v+Mjyn/DOonjMAMzFJ7+SQEdnbUEuTKP0VBzS16eiG81bC1Gt+A3FwRVprzmvLHrizsllNEGep34KU43XQF3mE61E3P/caPYskwuP+UMpNvDhWVWha3ne4qbpTn3qL/CZ1bPfP0UDny6va5HRdl0uTJzmwMJPjtuR6XJW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791715; c=relaxed/simple;
	bh=IskzSE1OOdWxLV4wEIgj5iiPGJft461h1onztXKb1j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poe/GKkhepcYcRbGLCDVOxZgjPovgykp/KbsGcmvFlaD8Fw+0DQqPH5hkwLKc6TNEoDPMeY7Wa74yFTa653B8yWVHHSuW9TiOGlTodPPRYBnf3Ya4/6RhZilabDO+HrLDcvyzpyHXavsxIn+HT6ckPCt1Jutq6kLEkCV1wbLtyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fXrj4RLu; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so7772676a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712791712; x=1713396512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xY8IaUaFZA+Gv7USloz4HDmI2WsvnF1MlA0Fl2dmZs=;
        b=fXrj4RLu9sAbZ7sPAQd32d1M4R4GFFtoFGqGHumpuco1APIGovQQ3ZCrddAMz0qADz
         G3mM9QrLb5lBhszOKSHy7fy18jZEzwi5lXlsqc0pCo1cluQTqPGzKQ3zI86LCAGJ6a1r
         gwaNU72pQeBZFqq7cy8I2qu3w2Whu02yKxnexdPQSKqGKqj4FusJ05jHAvRaA/scixFe
         +NthHyjYmN66k7EUDDQgOxDqXew/jeIMaKbHFFAJXoMPtQBMu8QNUNrGmBGX4kxFSbvs
         1feVp9/fpGC8pCrdFmzdF3hL6oVWB2HCKOk+5kcaZyuZdbCzP6zZeLutKv9ug5EvXiYi
         W2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712791712; x=1713396512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xY8IaUaFZA+Gv7USloz4HDmI2WsvnF1MlA0Fl2dmZs=;
        b=XNvly7iqTZREmztzDZCsyyeI8Zt3TztUCBlFxpravs2tQHotxrxm2rm7yX42S/NIe8
         4oMUU53Sx4K8lPQxZ8HQqGqVvAAj+T7+eNb5GyPNlPT5b9qxLPwFuBj/baOn3DkHmeaI
         FAElC1R5vNpOULEatwJWBonKFBekHbQtUof3u+96wE/wIL7I0HtRmpqLifGl4KDskC2/
         vtXdCkCL0GA9w84DxTzrTnyft4YA2M6dhlL29W9f0hM1KCmPGhBVxWtebtpeeukZaupE
         RNd7+fyjaEEU33poCF7jFT3t+qHGUjF1q8ffwUlbfZcibDmUKSSlp7d6x6b4SL2808Sw
         JD/Q==
X-Gm-Message-State: AOJu0YzaoI8+QsMb85xQIhSB9ousz907CourcX4t321qB4u4ugqA2a4t
	ctirx3ZJ5S7wxTfHxpoyldFe7FDlN0TPwpGhvauj7g7GHs98kmcNNf9aFTv20Dhx6riPkOraAGC
	DtwTjgViuRpSrsJuuox7lQQwNn/9tiF65n2QO
X-Google-Smtp-Source: AGHT+IFmOsrz5Hq/L8KjpOuaXMrNhjFmuTtpfw3wP32V8jN+t6rexPb4kfOSRskN6xAUqM5KYt/4+RS5HeJCyNqNRcY=
X-Received: by 2002:a50:9512:0:b0:56e:3172:20dd with SMTP id
 u18-20020a509512000000b0056e317220ddmr3084056eda.27.1712791711605; Wed, 10
 Apr 2024 16:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410232637.4135564-1-jstultz@google.com>
In-Reply-To: <20240410232637.4135564-1-jstultz@google.com>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 10 Apr 2024 16:28:19 -0700
Message-ID: <CAFhGd8oRJG6Amrr8VxriXP11NgVPbPBdaKKWbuCSowSxrGEcMg@mail.gmail.com>
Subject: Re: [PATCH 1/3] selftests: timers: Fix posix_timers ksft_print_msg warning
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>, 
	Carlos Llamas <cmllamas@google.com>, kernel-team@android.com, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 4:26=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
>
> After commit 6d029c25b71f ("selftests/timers/posix_timers:
> Reimplement check_timer_distribution()") I started seeing the
> following warning building with an older gcc:
>
> posix_timers.c:250:2: warning: format not a string literal and no format =
arguments [-Wformat-security]
>   250 |  ksft_print_msg(errmsg);
>       |  ^~~~~~~~~~~~~~
>
> Fix this up by changing it to ksft_print_msg("%s", errmsg)
>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Edward Liaw <edliaw@google.com>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: kernel-team@android.com
> Cc: linux-kselftest@vger.kernel.org
> Fixes: 6d029c25b71f ("selftests/timers/posix_timers: Reimplement check_ti=
mer_distribution()")
> Signed-off-by: John Stultz <jstultz@google.com>

Yep, makes sense.

Acked-by: Justin Stitt <justinstitt@google.com>

> ---
>  tools/testing/selftests/timers/posix_timers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testin=
g/selftests/timers/posix_timers.c
> index d86a0e00711e..348f47176e0a 100644
> --- a/tools/testing/selftests/timers/posix_timers.c
> +++ b/tools/testing/selftests/timers/posix_timers.c
> @@ -247,7 +247,7 @@ static int check_timer_distribution(void)
>                 ksft_test_result_skip("check signal distribution (old ker=
nel)\n");
>         return 0;
>  err:
> -       ksft_print_msg(errmsg);
> +       ksft_print_msg("%s", errmsg);
>         return -1;
>  }
>
> --
> 2.44.0.478.gd926399ef9-goog
>

