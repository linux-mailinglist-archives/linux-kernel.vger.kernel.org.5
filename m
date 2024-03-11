Return-Path: <linux-kernel+bounces-99561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB098789F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90251F2198C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7778D56B77;
	Mon, 11 Mar 2024 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fe9JsAcN"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947A957302
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192087; cv=none; b=gVMWOlYLrZkBxiQeOdVxWt6Lwm5mB87e7eITk8qpZppYaOjoCHOn2Y9sBvnsm9l8cG5lj3AqzqLrODz/YEdXj3cj7d7NqVyh6jdOaA6mTAN5yvCSA7MekDnwPRIrFHgfdMw0JZZY0hgLKfxuS63GOPn1ujxdmYDYpBE8AD0t+iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192087; c=relaxed/simple;
	bh=A6ntQXftXcfk9NPKtChVN+Afbvy2gvAYMqZPZc9sTXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4F/QUF0W4lcXcDqjaiksrCWzTHjMXhIlEmTaRE4o/3Ig+6aMxRLXJ4uhciQxB4K/m++NMb2ZxvYBGxodJWUcmoyURi1BaVxcnns7Y55w7mdgMONbdM0B97Ti5wikZyU6XGWkIyh1SihynSDaUrZboahv8OYA80IVJktiJGusio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fe9JsAcN; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42ef8193ae6so20731cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710192084; x=1710796884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWb2A9iIkGs3AmFlz53bU5Efj9ZUWJhfOe0zRp0tGRc=;
        b=fe9JsAcNoppnf2NHLwSLwh8xceOCZguLT1vqJQ+vx3TMH5gp7+Py1/+ZZry+jaxZye
         JHnSqCJuoIbruT0jYmEiG323JHDGZ8R7TVUwotAERoHvoFFlMVgp3dJ5KxXkjIa0EAKg
         TPJdrO9vzTPwNmTdW1NucQCPjgzu5HccyYZHjQCWA74O4VJ+WJJaiISObYdBZrhlmkzE
         xjXPvyRTnOluHpoP54BbvKobb0OAaRr9TvbZ48GSe4ZJgKxyx8NC0OQMfYXpkhT2Kuq4
         mpBNA4XsZVI0Eam65OS7N7erBrL7+lWXvFJm6Tr8yf3M7KiYXs45AjTgcguK0UgXvIsT
         N9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710192084; x=1710796884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWb2A9iIkGs3AmFlz53bU5Efj9ZUWJhfOe0zRp0tGRc=;
        b=G3LWKPK8H6719JY6l+aBlK74/xrsnRSjeAb+uVXDdzq3ayRYdbgPGYrYg05ShJSyhQ
         SngJ5dT2pAZE89WWupakhaa96s7VX5loMNVmTCr5VGDchVM6lWmjP509BDgK2ghgnzXB
         LL3SdXy19Ej2rsxR6yQ8j0yATIx1/jOU6AK4oNnH/8SQNTs1OmSedboOrKjeij56RaKQ
         qd3XU8ktuwDQxR6NvXaQkFa8SQtRvYETYpCgAKqtMP/GG1NHAI1DL7ftqxyQspQqHJPK
         ibW4FkMIrANkaPMdLxwdFnI4NxDcXlWAc4w0/kX2ooLQ6Ha/mnElZyyRn80PZfNqFCdN
         /N6w==
X-Forwarded-Encrypted: i=1; AJvYcCWH/wx2iQjDMn5szc63/6XcIsloAs825P0N3w967lWI11Tu+BpjvXPTOjGZBGWeUY0W+t7N4D2KUVKm9f/m6UbmlohVycamUqtghARQ
X-Gm-Message-State: AOJu0YywUodqKain7SQInSc+J7aF51u8qqKg0lxh1e4TSVTOmUAMAU8Q
	dhRD2V/6qmdDW3UWsrORI2njw3zs0FX+WZq4UvTcHtMLf/Po4+jWJyvP7utfkj2uxUzG84rzA2A
	KbClLYQbTZTN8axGy98p2Lt3cWHqZ9W8los+9
X-Google-Smtp-Source: AGHT+IGiw3N/c7EMgtHBYf+GhpaM4BMFpUmbsLp7eZNB/I9uRFUCN7Phn/vKm3/rRq1HFpGOLfkrYTvw5DSVfzOksbM=
X-Received: by 2002:ac8:748f:0:b0:42f:213a:dc9b with SMTP id
 v15-20020ac8748f000000b0042f213adc9bmr36743qtq.19.1710192084473; Mon, 11 Mar
 2024 14:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301194037.532117-1-mic@digikod.net> <20240301194037.532117-5-mic@digikod.net>
In-Reply-To: <20240301194037.532117-5-mic@digikod.net>
From: Rae Moar <rmoar@google.com>
Date: Mon, 11 Mar 2024 17:21:11 -0400
Message-ID: <CA+GJov7in4o6bXt_JDqeGjjD08yOweiUshesS4cUWTHYfgJAwQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] kunit: Handle test faults
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	Kees Cook <keescook@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, James Morris <jamorris@linux.microsoft.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marco Pagani <marpagan@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Thara Gopinath <tgopinath@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-um@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:40=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> Previously, when a kernel test thread crashed (e.g. NULL pointer
> dereference, general protection fault), the KUnit test hanged for 30
> seconds and exited with a timeout error.
>
> Fix this issue by waiting on task_struct->vfork_done instead of the
> custom kunit_try_catch.try_completion, and track the execution state by
> initially setting try_result with -EFAULT and only setting it to 0 if

Hello!

Thanks for your patch! This has been tested and seems pretty good to
me but I just have a few questions. First, do you mean here "setting
try_result with -EINTR"  instead?

But happy to add the tested-by.

Tested-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> the test passed.
>
> Fix kunit_generic_run_threadfn_adapter() signature by returning 0
> instead of calling kthread_complete_and_exit().  Because thread's exit
> code is never checked, always set it to 0 to make it clear.
>
> Fix the -EINTR error message, which couldn't be reached until now.
>
> This is tested with a following patch.
>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240301194037.532117-5-mic@digikod.net
> ---
>
> Changes since v1:
> * Added Kees's Reviewed-by.
> ---
>  include/kunit/try-catch.h |  3 ---
>  lib/kunit/try-catch.c     | 14 +++++++-------
>  2 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/include/kunit/try-catch.h b/include/kunit/try-catch.h
> index c507dd43119d..7c966a1adbd3 100644
> --- a/include/kunit/try-catch.h
> +++ b/include/kunit/try-catch.h
> @@ -14,13 +14,11 @@
>
>  typedef void (*kunit_try_catch_func_t)(void *);
>
> -struct completion;
>  struct kunit;
>
>  /**
>   * struct kunit_try_catch - provides a generic way to run code which mig=
ht fail.
>   * @test: The test case that is currently being executed.
> - * @try_completion: Completion that the control thread waits on while te=
st runs.
>   * @try_result: Contains any errno obtained while running test case.
>   * @try: The function, the test case, to attempt to run.
>   * @catch: The function called if @try bails out.
> @@ -46,7 +44,6 @@ struct kunit;
>  struct kunit_try_catch {
>         /* private: internal use only. */
>         struct kunit *test;
> -       struct completion *try_completion;
>         int try_result;
>         kunit_try_catch_func_t try;
>         kunit_try_catch_func_t catch;
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index cab8b24b5d5a..c6ee4db0b3bd 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -18,7 +18,7 @@
>  void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
>  {
>         try_catch->try_result =3D -EFAULT;
> -       kthread_complete_and_exit(try_catch->try_completion, -EFAULT);
> +       kthread_exit(0);
>  }
>  EXPORT_SYMBOL_GPL(kunit_try_catch_throw);
>
> @@ -26,9 +26,12 @@ static int kunit_generic_run_threadfn_adapter(void *da=
ta)
>  {
>         struct kunit_try_catch *try_catch =3D data;
>
> +       try_catch->try_result =3D -EINTR;
>         try_catch->try(try_catch->context);
> +       if (try_catch->try_result =3D=3D -EINTR)
> +               try_catch->try_result =3D 0;
>
> -       kthread_complete_and_exit(try_catch->try_completion, 0);
> +       return 0;

Really my only question is why we do not need to still do a
kthread_exit(0) here? I realize we are not checking the thread's exit
code but isn't it safer to call kthread_exit(). I'm new to kthread so
I am not too sure.

>  }
>
>  static unsigned long kunit_test_timeout(void)
> @@ -58,13 +61,11 @@ static unsigned long kunit_test_timeout(void)
>
>  void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *contex=
t)
>  {
> -       DECLARE_COMPLETION_ONSTACK(try_completion);
>         struct kunit *test =3D try_catch->test;
>         struct task_struct *task_struct;
>         int exit_code, time_remaining;
>
>         try_catch->context =3D context;
> -       try_catch->try_completion =3D &try_completion;
>         try_catch->try_result =3D 0;
>         task_struct =3D kthread_create(kunit_generic_run_threadfn_adapter=
,
>                                      try_catch, "kunit_try_catch_thread")=
;
> @@ -75,8 +76,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>         }
>         get_task_struct(task_struct);
>         wake_up_process(task_struct);
> -
> -       time_remaining =3D wait_for_completion_timeout(&try_completion,
> +       time_remaining =3D wait_for_completion_timeout(task_struct->vfork=
_done,
>                                                      kunit_test_timeout()=
);
>         if (time_remaining =3D=3D 0) {
>                 try_catch->try_result =3D -ETIMEDOUT;
> @@ -92,7 +92,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>         if (exit_code =3D=3D -EFAULT)
>                 try_catch->try_result =3D 0;
>         else if (exit_code =3D=3D -EINTR)
> -               kunit_err(test, "wake_up_process() was never called\n");
> +               kunit_err(test, "try faulted\n");
>         else if (exit_code =3D=3D -ETIMEDOUT)
>                 kunit_err(test, "try timed out\n");
>         else if (exit_code)
> --
> 2.44.0
>

