Return-Path: <linux-kernel+bounces-31696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D455883329A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 04:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FE01C2102D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A4010FD;
	Sat, 20 Jan 2024 03:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOqEMhuu"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B7710E1
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 03:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705721394; cv=none; b=kL6iSW4nkvpgqhy0WT6RDdoYdiYwJgfhuwdz9X8lLlKl864GOlxUV+TEACy5J101RIeqMLF7mOT9ksdmnPNCHIKcpHCmNRKKYIyTb6lV4L9S5EN78S1pSxowKt9GfOPzpFbA/KMDj57vPOLbYxgXVbLpWIeg0N3x5IRBl5NZZ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705721394; c=relaxed/simple;
	bh=xbnQZOx28WmoGt2XT3jLWJumutdYg/I0u6R/G1QTffg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHgieCOX/JyVSGMncmOL8PToNB9QE5SldRUyZT7UgAiGsnnTxJQgwkWeNflUcrSm6ElNDj9lvd6bboLAfOgxI1lTCMjZu7QNX74Vn9T2aHUefzdqMIpuRp0+oG5+O7sC0l8GbCdCLJcpiW0/w16Ea7ABIiupzDXc0lyV1hsrwZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OOqEMhuu; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bb9b28acb4so1276784b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 19:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705721392; x=1706326192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBi0MnIhTeHFZnl9T+tnlQ3cfbcTfmn0O/Ru1tIJH1I=;
        b=OOqEMhuu+YDfXrXgoeC7x2JDL7ISXr25apu3yyIAp/I90e355L8Frb5HuZ2IubeaTx
         DnpbliGbmbRQimu9vNnGppYb68wbUysi3V5/ro04BJ8/0efW+USucnrcux36Ssdjjko/
         CIyx8LeBzVgLisssvQU+ssKznY8+Uw/w+tUuaiqX9jbe31PFHitoxStlyQBKGQ+i/I0D
         6eMyuWlnn+mbg0m0DxPn71odTXIQygje2TiO7Yr65PsSWTGMOFYgftEuSLLVAcJDJ0iB
         CGC4DmJwm390gMlmpc0kLVkWveXZhJsR1vGdnwP4F/ck+hiAKfTYO1z/cJhYXdDriFr3
         bA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705721392; x=1706326192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBi0MnIhTeHFZnl9T+tnlQ3cfbcTfmn0O/Ru1tIJH1I=;
        b=jk+D4/uFB05InIqacnacQAUffE3AK0J7jw3/lk2N4YVjqzMmH5MD9SZ/ZRJQgZNVKI
         diLXgfqpJ4wT72ANc25r3+P/vT3DqQVipUnMUJkTavroxGS3ct0BUwdoLXV3qMYRd8t8
         YP0qaGUe0dL8jHQJc1VulyD3Y7jz+YftI9oNJxtFkNchXB4tPqQ4wIiGbZFqWgw8yGkO
         7CRri5ZA+tXXsU/lYlxTRJCs203lGckNPeEYOrwYCTwbgsUf55GBJYIJLXZEfOSG14/J
         i/aUUtPBn5QTecdaEkPm4g/GtI/IGzLg81v43BGi98+Nh5C5JKicRWbkYf2YcT815WiD
         3ofQ==
X-Gm-Message-State: AOJu0YzNN3asaX3UbHa4sEjZIOsJ3deqf6MGxkhxaSRYxlMR+4rD9NX5
	zYObytWKd9YoYioGSzxOtgNYtnXJsqv9ag/KQ5IA+8ihM/yVlWizLBQPFBxKHxUDJJVleE+qEDl
	3dLDHUsynh7/B85efY0E7GUj3V/hNb/ozTrCb
X-Google-Smtp-Source: AGHT+IGma6ybEcKp8hcSGGUi79zBmMI1KIY/puHKMVy1MGXuzTOSbFhURueu5c3+yQhLNk391BMjhapAC6D4v5PZvUo=
X-Received: by 2002:a54:4198:0:b0:3bd:5b4d:3dfd with SMTP id
 24-20020a544198000000b003bd5b4d3dfdmr625510oiy.76.1705721391897; Fri, 19 Jan
 2024 19:29:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117192534.1327608-1-dylanbhatch@google.com> <20240119141501.GA23739@redhat.com>
In-Reply-To: <20240119141501.GA23739@redhat.com>
From: Dylan Hatch <dylanbhatch@google.com>
Date: Fri, 19 Jan 2024 19:29:40 -0800
Message-ID: <CADBMgpwixDpGxWxFhMup9YD7DoCc3UPz8jYwFvUPQvhJGdeEUQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] getrusage: move thread_group_cputime_adjusted()
 outside of lock_task_sighand()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	Frederic Weisbecker <frederic@kernel.org>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, 
	Ard Biesheuvel <ardb@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Mike Christie <michael.christie@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Stefan Roesch <shr@devkernel.io>, 
	Joey Gouly <joey.gouly@arm.com>, Josh Triplett <josh@joshtriplett.org>, Helge Deller <deller@gmx.de>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Florent Revest <revest@chromium.org>, 
	Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 6:16=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> thread_group_cputime() does its own locking, we can safely shift
> thread_group_cputime_adjusted() which does another for_each_thread loop
> outside of ->siglock protected section.
>
> This is also preparation for the next patch which changes getrusage() to
> use stats_lock instead of siglock. Currently the deadlock is not possible=
,
> if getrusage() enters the slow path and takes stats_lock, read_seqretry()
> in thread_group_cputime() must always return 0, so thread_group_cputime()
> will never try to take the same lock. Yet this looks more safe and better
> performance-wise.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/sys.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/sys.c b/kernel/sys.c
> index e219fcfa112d..70ad06ad852e 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1785,17 +1785,19 @@ void getrusage(struct task_struct *p, int who, st=
ruct rusage *r)
>         struct task_struct *t;
>         unsigned long flags;
>         u64 tgutime, tgstime, utime, stime;
> -       unsigned long maxrss =3D 0;
> +       unsigned long maxrss;
> +       struct mm_struct *mm;
>         struct signal_struct *sig =3D p->signal;
>
> -       memset((char *)r, 0, sizeof (*r));
> +       memset(r, 0, sizeof(*r));
>         utime =3D stime =3D 0;
> +       maxrss =3D 0;
>
>         if (who =3D=3D RUSAGE_THREAD) {
>                 task_cputime_adjusted(current, &utime, &stime);
>                 accumulate_thread_rusage(p, r);
>                 maxrss =3D sig->maxrss;
> -               goto out;
> +               goto out_thread;
>         }
>
>         if (!lock_task_sighand(p, &flags))
> @@ -1819,9 +1821,6 @@ void getrusage(struct task_struct *p, int who, stru=
ct rusage *r)
>                 fallthrough;
>
>         case RUSAGE_SELF:
> -               thread_group_cputime_adjusted(p, &tgutime, &tgstime);
> -               utime +=3D tgutime;
> -               stime +=3D tgstime;
>                 r->ru_nvcsw +=3D sig->nvcsw;
>                 r->ru_nivcsw +=3D sig->nivcsw;
>                 r->ru_minflt +=3D sig->min_flt;
> @@ -1839,19 +1838,24 @@ void getrusage(struct task_struct *p, int who, st=
ruct rusage *r)
>         }
>         unlock_task_sighand(p, &flags);
>
> -out:
> -       r->ru_utime =3D ns_to_kernel_old_timeval(utime);
> -       r->ru_stime =3D ns_to_kernel_old_timeval(stime);
> +       if (who =3D=3D RUSAGE_CHILDREN)
> +               goto out_children;
>
> -       if (who !=3D RUSAGE_CHILDREN) {
> -               struct mm_struct *mm =3D get_task_mm(p);
> +       thread_group_cputime_adjusted(p, &tgutime, &tgstime);
> +       utime +=3D tgutime;
> +       stime +=3D tgstime;
>
> -               if (mm) {
> -                       setmax_mm_hiwater_rss(&maxrss, mm);
> -                       mmput(mm);
> -               }
> +out_thread:
> +       mm =3D get_task_mm(p);
> +       if (mm) {
> +               setmax_mm_hiwater_rss(&maxrss, mm);
> +               mmput(mm);
>         }
> +
> +out_children:
>         r->ru_maxrss =3D maxrss * (PAGE_SIZE / 1024); /* convert pages to=
 KBs */
> +       r->ru_utime =3D ns_to_kernel_old_timeval(utime);
> +       r->ru_stime =3D ns_to_kernel_old_timeval(stime);
>  }
>
>  SYSCALL_DEFINE2(getrusage, int, who, struct rusage __user *, ru)
> --
> 2.25.1.362.g51ebf55
>
>

Tested-by: Dylan Hatch <dylanbhatch@google.com>

