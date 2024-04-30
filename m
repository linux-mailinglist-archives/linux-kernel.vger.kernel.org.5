Return-Path: <linux-kernel+bounces-163204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACC98B6724
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4FB1C221E8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD7F2F28;
	Tue, 30 Apr 2024 01:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rIGb2SwZ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878AE1C33
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439144; cv=none; b=Dl+YwSQtQf6sVazO49WgYVhnLrmlwGnuFNP3WCThf2SUeMkPlW55Z0eLyAzxIc/TpEkmcdbb6hkCBH1VeekQo49EZ+nWv+/NbmU5Gf/CN47mAWxO6ySHfyN9mNXcmykAsUnqAJM0nd/K6g3Ysn+zL2VyCIVgi5NLOkkxqB0sC9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439144; c=relaxed/simple;
	bh=TK5MtPXbmMywsCNK4eaJvcbQwX7I5488OjtThsv2tq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIFqRDtIhAsuGgTNcygRkmcmUTImLitVg1E71lO/+lnw4L2AidydsFCtiWNys4tvpBoRqCrBvnmM92YWnDHGuZ8SH96enI/VWvj5O3DL+9awxwq/3au2I5UrqoIWDoOSf1ldDaaNJNHBGpTz7RGbbACF1gFl/Ato3vaZHNjaOB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rIGb2SwZ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso3220a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714439141; x=1715043941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaputj2Z1W/10vL4BFBUxMxYDeoWPqOOi+AGsgxCP8A=;
        b=rIGb2SwZdN7Z6v8EfXQefKicqrqWr0TUXLHLLSTZpEhWV9O6YvdhwTzB+o5ckJGxG2
         ZGcFMJPQSrf5FtzNqpYvehIwI0R/qMWXBhDmy3ZDGA+m4DKZZfv5mA2WvxZPLGhJCMmI
         kOdJ3mcDr+pcdZoHMuui6Wb8wyBR34L7KhoGUh6NugWgBvyWtV+k6fugQQmsd+cg5Aaa
         VxTnBL6EJAUaxOdnCfYmXREGg5Nk3NaQyHdMOiz3EROLmtFUyghCCpQGphY3YZNbohEo
         095ofikSZLAk2lniyAPdEBl20ExNLq4izGuqMWFuiJWmndnHfPG5W9K4tdvwU+pVE17E
         WawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714439141; x=1715043941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaputj2Z1W/10vL4BFBUxMxYDeoWPqOOi+AGsgxCP8A=;
        b=LRtQxhymMZ3jTM7Jt5dy4vYGpdCF9a+TgAGurqdxALPmQs/jprol9uY+0cmBh+jrgu
         n8INK0x8rt2rgJ7qDJhTV4GbUh5fERUYqe0U/YO1SPCPFrPysFKF0egKZGRQCCERt3mX
         OryxLnWIJNvF3LFEALbbXRBRDWWk2TiUltlCfCOcGbldyG7jXsTk0S0dSSmvtJlopsoj
         I7KAWrMryZMAUwSm0pCDqtR8AQgDkaHxw0W3bcvxBEZcow4rY/mSUcm2v2PCd4Np/CD4
         929hRyi+LdsqgD3CXGmoMgCCLb5+9MgRBrg8mlc0u1EYMYm0HbdEWryNpd8qBG+zwtkH
         V48w==
X-Forwarded-Encrypted: i=1; AJvYcCVELhJsaPB/3bDG/rpYjEue8fsOgwje+nJNidgw2NdtkgdhsiTvmROLGRGCEvWwyVK9UKYujI4hmRczrfvoZ17FtmIsvHE/x5Eh6Hq3
X-Gm-Message-State: AOJu0YxoWGLjKc+hJD5RMZ5rL40t40TgW81UeX/KUyJz5OFKB4OM9Kd1
	tHad6vr3jEf/NSz4tIdbzaTtwjDdHVf0CoOj7gqZkALDrkDWIneS6ar+oinTa0hvOJXpwlkfRx7
	TzvDD8DhDBOOl3d28cqKUJOLUrRoO8UPMHTFz
X-Google-Smtp-Source: AGHT+IG7LNX5veX8mreZLpnWG+Z3Cfj8RR3WtQABkQDJ65b4W0+sr62DOWgadzsbFuhb69tkll6WhyZyUSWm9YxG7Ew=
X-Received: by 2002:a05:6402:70b:b0:572:4e7c:90d9 with SMTP id
 w11-20020a056402070b00b005724e7c90d9mr44036edx.5.1714439140728; Mon, 29 Apr
 2024 18:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430004909.425336-1-edliaw@google.com>
In-Reply-To: <20240430004909.425336-1-edliaw@google.com>
From: Edward Liaw <edliaw@google.com>
Date: Mon, 29 Apr 2024 18:05:14 -0700
Message-ID: <CAG4es9VDsiWdhAHuBkS-+GkQeW+m5DeJC0mdDLEmOh1PDfQBdw@mail.gmail.com>
Subject: Re: [PATCH] kselftest: Add a ksft_perror() helper
To: stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc: kernel-team@android.com, Mark Brown <broonie@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, will resend this; I forgot to prefix that it was intended for
the 6.6.y branch.

On Mon, Apr 29, 2024 at 5:49=E2=80=AFPM Edward Liaw <edliaw@google.com> wro=
te:
>
> From: Mark Brown <broonie@kernel.org>
>
> [ Upstream commit 907f33028871fa7c9a3db1efd467b78ef82cce20 ]
>
> The standard library perror() function provides a convenient way to print
> an error message based on the current errno but this doesn't play nicely
> with KTAP output. Provide a helper which does an equivalent thing in a KT=
AP
> compatible format.
>
> nolibc doesn't have a strerror() and adding the table of strings required
> doesn't seem like a good fit for what it's trying to do so when we're usi=
ng
> that only print the errno.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> Stable-dep-of: 071af0c9e582 ("selftests: timers: Convert posix_timers tes=
t to generate KTAP output")
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  tools/testing/selftests/kselftest.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftest=
s/kselftest.h
> index e8eecbc83a60..ad7b97e16f37 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -48,6 +48,7 @@
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include <stdarg.h>
> +#include <string.h>
>  #include <stdio.h>
>  #include <sys/utsname.h>
>  #endif
> @@ -156,6 +157,19 @@ static inline void ksft_print_msg(const char *msg, .=
.)
>         va_end(args);
>  }
>
> +static inline void ksft_perror(const char *msg)
> +{
> +#ifndef NOLIBC
> +       ksft_print_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
> +#else
> +       /*
> +        * nolibc doesn't provide strerror() and it seems
> +        * inappropriate to add one, just print the errno.
> +        */
> +       ksft_print_msg("%s: %d)\n", msg, errno);
> +#endif
> +}
> +
>  static inline void ksft_test_result_pass(const char *msg, ...)
>  {
>         int saved_errno =3D errno;
> --
> 2.44.0.769.g3c40516874-goog
>

