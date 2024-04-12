Return-Path: <linux-kernel+bounces-143385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901088A37E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4663428721F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9AD15217C;
	Fri, 12 Apr 2024 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXF3Zz5Q"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E759152179
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 21:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712957556; cv=none; b=MHQWApybscyPka1EshkkzooWe6R65+0S4LGK4aQVnLSgVVEsJLeUzBWhW+oRIaH+cHduHAGMHVlQRAFu9SPWuD1kYq9CG66pQEqo1MKFkctH8SxWn6l1pVKA2SuwkzkssbcMbbshZChycIve8QbqiMz809EU8IT6AB9e0fIw27I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712957556; c=relaxed/simple;
	bh=gbwgYTpF/BcSQV0HXsiHe1579SMMnmR3GWasc0GUJc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcAoHJeZk7QqYAt5VjfUtxyvhpVfeGxr40oR2S/0mfiAsve0ZZnS1zbyuui02ypibV7BjNI88YQrrLQcZ61ppHbtEXtLXj87lQ+1PFN2CbQCyJFYBEEQZvpgx4uKXQqxpKOMFD+5kp+0id09cjHc9dYT0Dg6l3md9GnRidaF1r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PXF3Zz5Q; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-434ffc2b520so36021cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712957553; x=1713562353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bOsXTEuHSJ7y+R+ng6MulWBYUcUx1JMdZqOniqnEV8=;
        b=PXF3Zz5QqLYslSKTWLtcejFioLU/JxedoaAIRJRnT2LwRU0VHDhIbDWBYXwccSlK6O
         p6I4na2yEtF7n81cnN2YWnhlY2CxombfhzCf4LidohTwflZ/5jnlBqyHsLvV2Zg6vuCj
         P2Fg42gkRyjpNn9vaUBQWMiQ0suyYXJZyzKlOQKIPvVpHxrzO7g6v3rxUqekY9SR3XTv
         c8Id6+hvKH24pblUcRDVcv310beaPnS+BXmL2KAc3WPBe8FKpaqeL/zx1t63bLXWzit6
         BntzBJlGFjbKkXCYp4/F1mSNpTMZSuaf36z+zX3+rjeZUUdxtfcofiIm1s0ndcnXIAlP
         TfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712957553; x=1713562353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bOsXTEuHSJ7y+R+ng6MulWBYUcUx1JMdZqOniqnEV8=;
        b=uvWd4hOuTyZhXbuGH4+WDQ1CAGYq4kRhYWqayYaV6iIsrN2WCQS1+q2rqy4uQPi1i4
         Y3/s0y6d3bU+2ue+o7SXj89f7EVnjvE6VzxH7umuwaK4tHHTKub7Nu1wq69nn2w2T/s9
         y8j0sizH7judh3YVPF0RAH/RMn5xQ28twMx9woUcLfmgpL4PTiW7XLOZwGWFi+C04nq9
         /zy2440FskwcprZa3h2IW6EebA67cfy3n2Tb+ljW0NxGc08EGOlyVTuuDDWuqClHLA7h
         KnErDL2DEyqtONjk/09Ij6mhHxnxUlXa36l9Qsj8zatiJylE0afpC1xo6eHc0ImGXOMb
         Yu1w==
X-Forwarded-Encrypted: i=1; AJvYcCVG1fThKCAjfsERehLWDbVCqFsZyNA1QhE0vyTodGC2C3fVqLFSY6TAPDfnUjRP4lI4AbLAj9RPyUFAhL8UIpLjO8AmtL36yzdCAsOS
X-Gm-Message-State: AOJu0Yy8gXBnQVwNKzLVP79u7uIlRsOEKcnKY03SCNlG4E594d13tKLr
	VKUFL0x7urvDdH3N4TM9QDk6KH0ncFRvDfIpnMEhoi6cZi3UCl1x96tjoZV3dFN9SF00GAJdaY4
	sw6LuguQr/eHyiBMFghx137Ceqo4K9RbTMJUU
X-Google-Smtp-Source: AGHT+IHoLnA8rSSQsZ3I5df06ZmXxHEMFSYbpT/WK4qJDmffFK7AEoxvfrE5gza6mQMl3dOr4fy1NaKIHmZsf8NM7Zs=
X-Received: by 2002:a05:622a:1995:b0:434:a690:e326 with SMTP id
 u21-20020a05622a199500b00434a690e326mr25736qtc.9.1712957553270; Fri, 12 Apr
 2024 14:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412025903.489470-1-davidgow@google.com>
In-Reply-To: <20240412025903.489470-1-davidgow@google.com>
From: Rae Moar <rmoar@google.com>
Date: Fri, 12 Apr 2024 17:32:21 -0400
Message-ID: <CA+GJov7BGQmPUCzA_3Em6P0tXAWnUX-YD5r3pdPKFSSNL0tgyw@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix race condition in try-catch completion
To: David Gow <davidgow@google.com>
Cc: Kees Cook <keescook@chromium.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Guenter Roeck <linux@roeck-us.net>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Brendan Higgins <brendan.higgins@linux.dev>, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:59=E2=80=AFPM David Gow <davidgow@google.com> wr=
ote:
>
> KUnit's try-catch infrastructure now uses vfork_done, which is always
> set to a valid completion when a kthread is created, but which is set to
> NULL once the thread terminates. This creates a race condition, where
> the kthread exits before we can wait on it.
>
> Keep a copy of vfork_done, which is taken before we wake_up_process()
> and so valid, and wait on that instead.
>
> Fixes: 4de2a8e4cca4 ("kunit: Handle test faults")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/lkml/20240410102710.35911-1-naresh.kamboj=
u@linaro.org/
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Acked-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Signed-off-by: David Gow <davidgow@google.com>

Hello,

This fix looks good to me. I have tested it and besides the fortify
test error discussed in the previous patch series I am happy.

Thanks!
-Rae

Reviewed-by: Rae Moar <rmoar@google.com>


> ---
>  lib/kunit/try-catch.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index fa687278ccc9..6bbe0025b079 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -63,6 +63,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>  {
>         struct kunit *test =3D try_catch->test;
>         struct task_struct *task_struct;
> +       struct completion *task_done;
>         int exit_code, time_remaining;
>
>         try_catch->context =3D context;
> @@ -75,13 +76,16 @@ void kunit_try_catch_run(struct kunit_try_catch *try_=
catch, void *context)
>                 return;
>         }
>         get_task_struct(task_struct);
> -       wake_up_process(task_struct);
>         /*
>          * As for a vfork(2), task_struct->vfork_done (pointing to the
>          * underlying kthread->exited) can be used to wait for the end of=
 a
> -        * kernel thread.
> +        * kernel thread. It is set to NULL when the thread exits, so we
> +        * keep a copy here.
>          */
> -       time_remaining =3D wait_for_completion_timeout(task_struct->vfork=
_done,
> +       task_done =3D task_struct->vfork_done;
> +       wake_up_process(task_struct);
> +
> +       time_remaining =3D wait_for_completion_timeout(task_done,
>                                                      kunit_test_timeout()=
);
>         if (time_remaining =3D=3D 0) {
>                 try_catch->try_result =3D -ETIMEDOUT;
> --
> 2.44.0.683.g7961c838ac-goog
>

