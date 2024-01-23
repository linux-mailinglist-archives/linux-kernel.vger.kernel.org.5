Return-Path: <linux-kernel+bounces-36195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06331839D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0A91F26A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7C854F80;
	Tue, 23 Jan 2024 23:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tdnfCNv9"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EA355793
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706053709; cv=none; b=ApvPY7vq3CspZ7/TQ1C3kGAY4ojRq7JmZ6WiBK4Vva0Vo5o4fCVPr6mVC4bzvVlwZTXd9K5FYRmsUBc3EEGnL9tA1U/jYPGdnMW79ifYFQ5RwRjfLV1Nt4pr9JfPLJQ/xDMQgWh0BbCUIVkoe7WEZN7B4eM8lwlDKRJ4qyy3yzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706053709; c=relaxed/simple;
	bh=IwX2wtHQH1+nxKFih9UqVPofuuYwe1PhXZSEfc3TjFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HAYkgVntnonAnJgc1Ej53DRJCD4jqk701JBhQK6KkPEiiCMUcCxBRoBuN8glZbWwP6XWW8Tjl4cR2XXDsoMJV/Py6lf5+i07aOtmSeJlCZqcoZ21d+WTCFNeShdUMmr7tvs6IVJK6arb5UW5b3iLjFdEbyU8QDAzzIJJo+4ncSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tdnfCNv9; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59505514213so2143380eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706053707; x=1706658507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0Bp35cL1x3lGQxlfc4+guhnqQEgRZaUR2F38UGa/UU=;
        b=tdnfCNv9NnZtogxwEFhwzgqF0oDbHTsIVRxWE0ocijmNjeRBSLqVgr5tVMNfTRJFR4
         1pPUScDstHceDxS9leEChptlem2sMNp4DkKuX0YpWOX2K38x8kE/erjwIPVpePu4siqa
         7LsZfZOWUJu7LBpx/YfWT8WmK89S38uja2fDgyFf8eL3dGCv9jHmjvPExX2XXmt4wg/f
         sQ/VIzOL6J4zLQ/9UatoCZZbdNfGtTNfAckz8mBbgjLHKolXTY11Qgg5gPtLabAm2N23
         kyN/IhMb4AZdKm+Aoho+jObJIyxt7Ity/IiVbh9c7iQ+9xt2ctWH5s+iFcx2cA2N2DWt
         c7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706053707; x=1706658507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0Bp35cL1x3lGQxlfc4+guhnqQEgRZaUR2F38UGa/UU=;
        b=TA5VxJlYXLOOf1O/FD3iiEvZuN1rxHJWtoqSFLIsesb9VjkAal16oSDp1fmx3zK4AY
         o0V248pQJLObiesRFlWw2A7HwfJ9RolK7z7LC3EJgrSNR2OH0HGxgAX9xFWKog3231vE
         1PISFN+5xXjjKNUk6e0NCHs3lYi8VlbCLENWE0L2jJhx1HFeV/IQK9UXfPvbnOFUb8zv
         3sCByN9uOP+AS1mCMsXgehP9xISFVM+8hEmNadCS/TXdq7uTOoUCLt8RFr2efbBlCjs5
         3y3SI5US7sR60CTpWBU7KtCJ3aFaHx5ccFfD5+Bdy0Ef9BvoAad+ZuQCpRrZ0OWQxpwS
         u8eA==
X-Gm-Message-State: AOJu0Yw/10Z67Azp3NoSCYW/yPyYvCMKNJ5XZDvLQzAwkvysNZO0swjg
	LoCpyNhPTuWjjUdT54bR0YcTt36FMNuQLnm/xBspRoMimvUCIA32myVdxecMQH+yXiW1Pkx2hbn
	l2U7fCrDSH/ul0DODJULTkWPRuEqtlKSJc10L
X-Google-Smtp-Source: AGHT+IEc6tZwuspGDiTrzLXVJ/0+9dgg85zddA0oPzI1DYgWPgzh3Qng0dcAYVmxP9ut6AyBqOXyF6YvsQ8WQJgN7qg=
X-Received: by 2002:a05:6870:8911:b0:206:a1d8:6d7f with SMTP id
 i17-20020a056870891100b00206a1d86d7fmr152325oao.59.1706053706786; Tue, 23 Jan
 2024 15:48:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123153313.GA21832@redhat.com> <20240123153355.GA21854@redhat.com>
In-Reply-To: <20240123153355.GA21854@redhat.com>
From: Dylan Hatch <dylanbhatch@google.com>
Date: Tue, 23 Jan 2024 15:48:15 -0800
Message-ID: <CADBMgpxpn1otErZkhG3NxSMUWGPSFUG7HFmJG3po46k_D2PXnw@mail.gmail.com>
Subject: Re: [PATCH 1/3] fs/proc: do_task_stat: move thread_group_cputime_adjusted()
 outside of lock_task_sighand()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 7:35=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> thread_group_cputime() does its own locking, we can safely shift
> thread_group_cputime_adjusted() which does another for_each_thread loop
> outside of ->siglock protected section.
>
> Not only this removes for_each_thread() from the critical section with
> irqs disabled, this removes another case when stats_lock is taken with
> siglock held. We want to remove this dependency, then we can change the
> users of stats_lock to not disable irqs.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  fs/proc/array.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index ff08a8957552..45ba91863808 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -511,7 +511,7 @@ static int do_task_stat(struct seq_file *m, struct pi=
d_namespace *ns,
>
>         sigemptyset(&sigign);
>         sigemptyset(&sigcatch);
> -       cutime =3D cstime =3D utime =3D stime =3D 0;
> +       cutime =3D cstime =3D 0;
>         cgtime =3D gtime =3D 0;
>
>         if (lock_task_sighand(task, &flags)) {
> @@ -546,7 +546,6 @@ static int do_task_stat(struct seq_file *m, struct pi=
d_namespace *ns,
>
>                         min_flt +=3D sig->min_flt;
>                         maj_flt +=3D sig->maj_flt;
> -                       thread_group_cputime_adjusted(task, &utime, &stim=
e);
>                         gtime +=3D sig->gtime;
>
>                         if (sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_STOP=
_STOPPED))
> @@ -562,10 +561,13 @@ static int do_task_stat(struct seq_file *m, struct =
pid_namespace *ns,
>
>         if (permitted && (!whole || num_threads < 2))
>                 wchan =3D !task_is_running(task);
> -       if (!whole) {
> +
> +       if (whole) {
> +               thread_group_cputime_adjusted(task, &utime, &stime);
> +       } else {
> +               task_cputime_adjusted(task, &utime, &stime);
>                 min_flt =3D task->min_flt;
>                 maj_flt =3D task->maj_flt;
> -               task_cputime_adjusted(task, &utime, &stime);
>                 gtime =3D task_gtime(task);
>         }
>
> --
> 2.25.1.362.g51ebf55
>

Signed-off-by: Dylan Hatch <dylanbhatch@google.com>

