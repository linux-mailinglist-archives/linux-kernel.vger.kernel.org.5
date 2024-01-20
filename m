Return-Path: <linux-kernel+bounces-31695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D0C833299
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 04:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE601F22964
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C19310FC;
	Sat, 20 Jan 2024 03:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqL7KcxA"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04C8ED6
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 03:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705721284; cv=none; b=PKv4PK/lGliw0s+RMcS7n6xKkevOACGM8rWRitLzE9YLI6De4oLpFCfHPU5RgaxWKJMH3SmyLZiu41+ZsZ3Hx8O6xkKER6nc0XcwgyCNJoWg1d6E6tU0i20iHQF4GPirJTtDBCg2AFISqRSU1dUeuMhD1VaMTp3HoTKOGgrGHwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705721284; c=relaxed/simple;
	bh=qk3zH/sond1ZY5Cpon/m/ew2ReOaf9OG2Mn+5iCDlxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXET40TfmJPffnLbqM9bgk88uRQ1IRhc0PiN+BoY0tcezr8HRNYdh0AUYzSLjsfG5my3jCs7wTcmEOx5tMYaiX/Ra68oI0QyyLvEqLGY9qhKeM65MwbHcqnUOQmUg6A4JAR8NBJax8atZGqvvG67oK7E/X95FwiavIYDBPxqPs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RqL7KcxA; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-21424f34003so160249fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 19:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705721281; x=1706326081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFEd7ujpZp03jO09gM8Y/Avww823mrMIDvArhboSb7U=;
        b=RqL7KcxAK8w1wQ42yjalbPgPBP8aY1Ah9NgOlJ1E5AH3RDHYc9O/BaoLSUg0MqE2MU
         uF9tfd3tl7PdtrPRZc+PpEDfvo4+usuHkmWbGDWB2oXwDAa0pEcKLq3UQyk5kTkfDYqu
         /1F5FnZ61iGUUSyS5nSO1wand+RJRVvjOIAVq81uJxGSPaKQpc3GPACHBo4v1+wIS84K
         EHsFU4neLuUhHRewZyN0eWcSe5IxBcDymEnL0dx1Oc95qnrrofPHHSyFe/4ydSwnGT+l
         lGm6CwQJJziCxY0+mD3I0kaCb7ZpX0W6WuLxpbJetOq35VNvaICR/BGDMocjKXXAabki
         iTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705721281; x=1706326081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFEd7ujpZp03jO09gM8Y/Avww823mrMIDvArhboSb7U=;
        b=szq4AGZGvDFCMO1SNkn+9on7QryZSxs3pCMiAbWWabmgCywZbxfghJQ0/KV1shUMI3
         gjLLaAFsUrP1hleb6XbOusq86du0gwTnpi2UhGeLc9qDKFbnRzY+4jZFSr0cMF/iw3r3
         4ms2uow7FDNMuwcK6Phe4BlS/PvdgIXT6S0Gpv14P3qwCfM0bfuee7JJYuJSeTNL7TXY
         UhoX6v9INH+UMMxoXq+8V+l5J2KBa8UB0qmrbjhkv0E+FBnzrXLecgSMgU/sKa0BU+hp
         hg0THQNAEja1l60K+RUKysCl1gxwLeBUyq8EQWuWNuJJPCo3gb2dHRqiFLl90VPCdB4k
         62ig==
X-Gm-Message-State: AOJu0YyaONjChDrSzVz22l5JMnI908Tr97lKlyTkvpdjUSty98DBKad6
	Cy2jo3yGLaUwZOjdtR/kaSl0I8CEntaKzDKTqDigTuE9z3fWUPzyNXBs5pxFRmyUatQa+l8i6oh
	lu67Ty1duAKz8sjbVx3ctYAclkaIt9h7thbFy
X-Google-Smtp-Source: AGHT+IEflTo/ZT8wOcgMq8IFETMUAehE3B9et+oYhGqZSru7oCNsH1wNBuCkdZZTBl71y2e16ECc47pzS8k59WcNJZ8=
X-Received: by 2002:a05:6871:148:b0:210:817c:4af4 with SMTP id
 z8-20020a056871014800b00210817c4af4mr828694oab.72.1705721280677; Fri, 19 Jan
 2024 19:28:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117192534.1327608-1-dylanbhatch@google.com>
 <20240119141501.GA23739@redhat.com> <20240119141529.GB23739@redhat.com>
In-Reply-To: <20240119141529.GB23739@redhat.com>
From: Dylan Hatch <dylanbhatch@google.com>
Date: Fri, 19 Jan 2024 19:27:49 -0800
Message-ID: <CADBMgpxC+BP-wfrM-wP1nbZOcRb0LbsmMDQ3LQ8hUKYsF3QECw@mail.gmail.com>
Subject: Re: [PATCH 2/2] getrusage: use sig->stats_lock
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
> Rather than lock_task_sighand(), sig->stats_lock was specifically designe=
d
> for this type of use. This way getrusage runs lockless in the likely case=
.
>
> TODO:
>         - Change do_task_stat() to use sig->stats_lock too, then we can
>           remove spin_lock_irq(siglock) in wait_task_zombie().
>
>         - Turn sig->stats_lock into seqcount_rwlock_t, this way the
>           readers in the slow mode won't exclude each other. See
>           https://lore.kernel.org/all/20230913154907.GA26210@redhat.com/
>
>         - stats_lock has to disable irqs because ->siglock can be taken
>           in irq context, it would be very nice to change __exit_signal()
>           to avoid the siglock->stats_lock dependency.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/sys.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 70ad06ad852e..f8e543f1e38a 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1788,7 +1788,9 @@ void getrusage(struct task_struct *p, int who, stru=
ct rusage *r)
>         unsigned long maxrss;
>         struct mm_struct *mm;
>         struct signal_struct *sig =3D p->signal;
> +       unsigned int seq =3D 0;
>
> +retry:
>         memset(r, 0, sizeof(*r));
>         utime =3D stime =3D 0;
>         maxrss =3D 0;
> @@ -1800,8 +1802,7 @@ void getrusage(struct task_struct *p, int who, stru=
ct rusage *r)
>                 goto out_thread;
>         }
>
> -       if (!lock_task_sighand(p, &flags))
> -               return;
> +       flags =3D read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
>
>         switch (who) {
>         case RUSAGE_BOTH:
> @@ -1829,14 +1830,23 @@ void getrusage(struct task_struct *p, int who, st=
ruct rusage *r)
>                 r->ru_oublock +=3D sig->oublock;
>                 if (maxrss < sig->maxrss)
>                         maxrss =3D sig->maxrss;
> +
> +               rcu_read_lock();
>                 __for_each_thread(sig, t)
>                         accumulate_thread_rusage(t, r);
> +               rcu_read_unlock();
> +
>                 break;
>
>         default:
>                 BUG();
>         }
> -       unlock_task_sighand(p, &flags);
> +
> +       if (need_seqretry(&sig->stats_lock, seq)) {
> +               seq =3D 1;
> +               goto retry;
> +       }
> +       done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
>
>         if (who =3D=3D RUSAGE_CHILDREN)
>                 goto out_children;
> --
> 2.25.1.362.g51ebf55
>
>

I applied these to a 5.10 kernel, and my repro (calling getrusage(RUSAGE_SE=
LF)
from 200K threads) is no longer triggering a hard lockup.

Tested-by: Dylan Hatch <dylanbhatch@google.com>

