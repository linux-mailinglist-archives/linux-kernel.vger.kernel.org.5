Return-Path: <linux-kernel+bounces-36196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BCC839D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4E61F269E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE5A54735;
	Tue, 23 Jan 2024 23:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HxBKSEoS"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B062B9CE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706053841; cv=none; b=CaO/YsBbmg+kAhWl2KwpuoyISNcxm0D/tS7n6qYPs4yi5keL81cRqirWTbeapi7tVkN51Ab5gbkYHNxzkE/rK+Jq94RpUb6bsK+qOtZDFuyK9PNA1DJlbmazoLrpYm4z39sRFYJOq0xOIs1APLphOpzFphqGTvi0nfogofTbBUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706053841; c=relaxed/simple;
	bh=1lx1idBnJq/0vBe+QwQG4vh2KirqNn1ExSghd7jUPLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCR/4VqdVJYAv7gSckB4qqPkeKEbPLD3KWMPWVc6JrwAAMqIntLRLZreUAMENcHvOn/SH5ZPrPYsSrurg9bJPB5PChTDce1gF52/7ed77a4IpvpZSnaDMCOf/iSjBcfJlcOvuGYWVJQbecCUVetHqpMqZEc9eZPe8CKDhEZCQIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HxBKSEoS; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-203ae9903a6so2033016fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706053838; x=1706658638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lS5kHgL4Lbwrk3IfwwkZKTfyix8IeE+z8vJ5AzdHzEY=;
        b=HxBKSEoSKKOAsDfTa3G/qxEqgjix1t4RaX5G52jEp9qgamUuPFWSibII2vGxYtEVv7
         fZo37S15OLhLFM/PiTpX21/ganvEeL2GLPnf/LPmAPsZvhyTb5nDjKvI7SAPbhOIk80V
         fI4mLV+o+a1QhJ3u0t+Q3lfB0aF00JwUwigFQY6NkwW0sQVK2YTOGBRj99OpEjVkrz3i
         amSGkgqbvESpliH2h1hKMvbVMYH5mKJ5ml1et4dmMTuM43ZlYkWnsBa9Fz1X3lu403GM
         LFX37TUVY/l26Iqqntm/gYiGd4xSUWZH/YU2bMpoo8agS1L5NrOEeUf/9/3XKIGXaHEB
         0Dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706053838; x=1706658638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lS5kHgL4Lbwrk3IfwwkZKTfyix8IeE+z8vJ5AzdHzEY=;
        b=Q/bqp8Yr+1Rb0Rt7RvGulASXHlt2dy3VIxkAmI/RTNJw9kiKnv5713uZO+NSk6OliR
         vN3ObubQZkmMOcc0ECEPcPpc5QfhqxT1bvQwKVZN/AlGxJEzxMv8/Ixjkl1K8ZfPqg71
         qRJq6dpJaaERQZgY5DMn2+nMLmYKF/jJmyCzRj5KRu+Pt6i2Ku42cZi5bL2/EXr+Kpqm
         np9nA7K12oR8tmb5AAGv3PxEVEP9mK93twN5jRIwuPWY03uUOWT6CLlYxD2/3wXA8cq1
         VYDPnfRUarZ6A7f4joVw/YVmJsT9wdfIz/IUfxBCnXyN+ovW4HlH9MnM0ssdD20jx5kP
         j0dQ==
X-Gm-Message-State: AOJu0Yy5wogqsoQ+m4cuO6YhBPVkiOiB1UjvLRG5JMJVaqqBMYXh1qcr
	8n/x6X2441SYq0jXx1blp0eOsas96KKZ8flyuw5pUWi0c+As1EbSUiaPBBBmWjJRYF808B7ZbtX
	4D5zplN4HmZxBB/oQK1OmiF6+vAlwDh2BoOm5
X-Google-Smtp-Source: AGHT+IH2Xnzv8FWdbf4xo9ZYlqN4jBx/i6FEB4MwMbburvzmR+wbHMUQsexaszlsZm2mqAx7sMChPTyK2QIY/U0r8Uw=
X-Received: by 2002:a05:6870:14d3:b0:210:817c:4af4 with SMTP id
 l19-20020a05687014d300b00210817c4af4mr2328437oab.72.1706053838500; Tue, 23
 Jan 2024 15:50:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123153313.GA21832@redhat.com> <20240123153357.GA21857@redhat.com>
In-Reply-To: <20240123153357.GA21857@redhat.com>
From: Dylan Hatch <dylanbhatch@google.com>
Date: Tue, 23 Jan 2024 15:50:27 -0800
Message-ID: <CADBMgpw4m-PZJrqW4YBbM_ssFB210wbDvxAS69pEWTDCGdKGnA@mail.gmail.com>
Subject: Re: [PATCH 2/3] fs/proc: do_task_stat: use sig->stats_lock to gather
 the threads/children stats
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 7:35=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> lock_task_sighand() can trigger a hard lockup. If NR_CPUS threads call
> do_task_stat() at the same time and the process has NR_THREADS, it will
> spin with irqs disabled O(NR_CPUS * NR_THREADS) time.
>
> Change do_task_stat() to use sig->stats_lock to gather the statistics
> outside of ->siglock protected section, in the likely case this code
> will run lockless.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  fs/proc/array.c | 58 +++++++++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 26 deletions(-)
>
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 45ba91863808..34a47fb0c57f 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -477,13 +477,13 @@ static int do_task_stat(struct seq_file *m, struct =
pid_namespace *ns,
>         int permitted;
>         struct mm_struct *mm;
>         unsigned long long start_time;
> -       unsigned long cmin_flt =3D 0, cmaj_flt =3D 0;
> -       unsigned long  min_flt =3D 0,  maj_flt =3D 0;
> -       u64 cutime, cstime, utime, stime;
> -       u64 cgtime, gtime;
> +       unsigned long cmin_flt, cmaj_flt, min_flt, maj_flt;
> +       u64 cutime, cstime, cgtime, utime, stime, gtime;
>         unsigned long rsslim =3D 0;
>         unsigned long flags;
>         int exit_code =3D task->exit_code;
> +       struct signal_struct *sig =3D task->signal;
> +       unsigned int seq =3D 1;
>
>         state =3D *get_task_state(task);
>         vsize =3D eip =3D esp =3D 0;
> @@ -511,12 +511,8 @@ static int do_task_stat(struct seq_file *m, struct p=
id_namespace *ns,
>
>         sigemptyset(&sigign);
>         sigemptyset(&sigcatch);
> -       cutime =3D cstime =3D 0;
> -       cgtime =3D gtime =3D 0;
>
>         if (lock_task_sighand(task, &flags)) {
> -               struct signal_struct *sig =3D task->signal;
> -
>                 if (sig->tty) {
>                         struct pid *pgrp =3D tty_get_pgrp(sig->tty);
>                         tty_pgrp =3D pid_nr_ns(pgrp, ns);
> @@ -527,27 +523,9 @@ static int do_task_stat(struct seq_file *m, struct p=
id_namespace *ns,
>                 num_threads =3D get_nr_threads(task);
>                 collect_sigign_sigcatch(task, &sigign, &sigcatch);
>
> -               cmin_flt =3D sig->cmin_flt;
> -               cmaj_flt =3D sig->cmaj_flt;
> -               cutime =3D sig->cutime;
> -               cstime =3D sig->cstime;
> -               cgtime =3D sig->cgtime;
>                 rsslim =3D READ_ONCE(sig->rlim[RLIMIT_RSS].rlim_cur);
>
> -               /* add up live thread stats at the group level */
>                 if (whole) {
> -                       struct task_struct *t;
> -
> -                       __for_each_thread(sig, t) {
> -                               min_flt +=3D t->min_flt;
> -                               maj_flt +=3D t->maj_flt;
> -                               gtime +=3D task_gtime(t);
> -                       }
> -
> -                       min_flt +=3D sig->min_flt;
> -                       maj_flt +=3D sig->maj_flt;
> -                       gtime +=3D sig->gtime;
> -
>                         if (sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_STOP=
_STOPPED))
>                                 exit_code =3D sig->group_exit_code;
>                 }
> @@ -562,6 +540,34 @@ static int do_task_stat(struct seq_file *m, struct p=
id_namespace *ns,
>         if (permitted && (!whole || num_threads < 2))
>                 wchan =3D !task_is_running(task);
>
> +       do {
> +               seq++; /* 2 on the 1st/lockless path, otherwise odd */
> +               flags =3D read_seqbegin_or_lock_irqsave(&sig->stats_lock,=
 &seq);
> +
> +               cmin_flt =3D sig->cmin_flt;
> +               cmaj_flt =3D sig->cmaj_flt;
> +               cutime =3D sig->cutime;
> +               cstime =3D sig->cstime;
> +               cgtime =3D sig->cgtime;
> +
> +               if (whole) {
> +                       struct task_struct *t;
> +
> +                       min_flt =3D sig->min_flt;
> +                       maj_flt =3D sig->maj_flt;
> +                       gtime =3D sig->gtime;
> +
> +                       rcu_read_lock();
> +                       __for_each_thread(sig, t) {
> +                               min_flt +=3D t->min_flt;
> +                               maj_flt +=3D t->maj_flt;
> +                               gtime +=3D task_gtime(t);
> +                       }
> +                       rcu_read_unlock();
> +               }
> +       } while (need_seqretry(&sig->stats_lock, seq));
> +       done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
> +
>         if (whole) {
>                 thread_group_cputime_adjusted(task, &utime, &stime);
>         } else {
> --
> 2.25.1.362.g51ebf55
>

Signed-off-by: Dylan Hatch <dylanbhatch@google.com>

