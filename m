Return-Path: <linux-kernel+bounces-77028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EF2860042
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E140C1C25A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE40153BEF;
	Thu, 22 Feb 2024 17:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KtqvEuLS"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2709157E73
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624790; cv=none; b=qdEbWEosevxZcA/6zIk5dh3Aaqb3ZGH3Nez71SVY6HZT2CukqkjJLo23+DlW60GApKICZWNyAbjOwI6fwRgPfhEMi+rGxrqPF5O0Xv501aQUZ47nC9LtX19SaQNQR/R3oIhBQxy8LMBWeflsEsy4Z9YWQwIkUVjtdU/vivgwsnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624790; c=relaxed/simple;
	bh=fvwsKYe0sii5hYFlzMGzO5Ryz+nnM+pKugmbYqz/abQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDiuvUSPeRfpHTKf4boZd24R5v1UkVaxxzV+XyBgX2GZaK+gyptxnPekf62BHo/uhEfJnk/KMy80w6N1y2RiGea+LeO58qrUg4YhPtxTBmtZ4XyoaT0AO3RBL1rUGNtz6Q5fgaB9G6v67Cxzso6A5By8KXHoHeOpt4EJ92KKyiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KtqvEuLS; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7d2e19120b5so4475404241.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708624788; x=1709229588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAfh0deUlctQewLM9rYvzLmpV0jruOlVqgBOdUhaXcI=;
        b=KtqvEuLS+5Ie6g8HMyfv9ed1jJ2/tAIsuOpR/xsv5o2LIrQLEeCNLIZr9uXntaniX1
         HfnrBAYU0qbtCLjMV/M3c/XLwQiYXEsxgCbpXsqbS3F/UhJgoeNmPtguinTWC6IgJbPU
         +zEfwyk+ttsMuyUFk5TYaB99eGQ2tahZ8ZMhW3zB0YB7gp709vF1mGitR5jLpCmAx2UH
         tH0LpZ0xpW1JlFDsc78HcN+jjBjy+D/zwz8BLj+KgB0NsDxVjVsDBqPwVCRiVsi21MlI
         dJW7icCfhwyBIPzkQBJbZaSvPCQdkvjWRk/e74fi6yBbYe1tQ3GLNWCQEP2TCVtyZl8l
         cMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708624788; x=1709229588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAfh0deUlctQewLM9rYvzLmpV0jruOlVqgBOdUhaXcI=;
        b=BpaQW9gr+oj1jZUs5nL+vqWsI+7oNJokr6hIWrA8AOHfFo6PkJ9HUmH5lOpry4DXqD
         xKvhyzfhP7EDPpPjEFXNkSvEcoZVbhrILZAP/mZ2NlXk38byNkFO5ulOaiiV555XxkAY
         h44EzVBChqDEskxMSGDeaF24E4gOY5hDJkSGImAGY+gXOUcPyPynaewzpjFIcv/nVfj5
         V2ykASf6b7ICojuOdnqZm+8thqlORKvUgucdh2Bk7aPXqIf0i8Gc8C0LTC5ThRkPjZAi
         5Knr52ks+Mba+RC9HK7FkeSbzGQCwQI22KWF9GpUwJKZ4/95gH4Dofnv2aZnYEHtlpfw
         oDdw==
X-Forwarded-Encrypted: i=1; AJvYcCV7/OaZSzH5ybqGQU9+pWs0MIWZQut2CgcutYEG3CuF8A4GUO33B58tF0jkV7zuTW1b2xw5xg5cMvc55hV1I9RAQfxZ/nze72WchKjW
X-Gm-Message-State: AOJu0Yw5GPNVw+sbF3j692q8/q+uKxnlIOwsC/+2Mb0vlnKEiTCCDxaY
	fHn7+a3y760J/zT8IAEVqQx1MZMMwUbEcXCKCE3B7wxKXeTMbiSEiTW14vwaaamzUKFVOgmJ5FT
	bIGIvWOGFKUDYq2/B/6K5zM2ZyZG8Ur/iIAIi
X-Google-Smtp-Source: AGHT+IFAcQHAiZ1fQ8mfYjH9A8yIg25e7KdgVRcZ1st9GcOueJ6vRhI4a0/vUzUq8j3sQqvTbwrNpNPCpjk0U2FyxTo=
X-Received: by 2002:a67:fbd3:0:b0:470:5fdd:d5c with SMTP id
 o19-20020a67fbd3000000b004705fdd0d5cmr12228729vsr.31.1708624787593; Thu, 22
 Feb 2024 09:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111210539.636607-1-carlosgalo@google.com>
 <ZdWshXSoLthv6J6b@tiehlicka> <CABtOLR+gpU2BYxcGCCqccZGcRDF337z3JJ=7nvC47ANHmS1tNA@mail.gmail.com>
 <ZddXLGdJ0QDZTvJS@tiehlicka>
In-Reply-To: <ZddXLGdJ0QDZTvJS@tiehlicka>
From: Carlos Galo <carlosgalo@google.com>
Date: Thu, 22 Feb 2024 09:59:34 -0800
Message-ID: <CABtOLR+G6jyfV_7YUabJnmt=oN12fzPHB7viq9fTJb44wtefiw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Update mark_victim tracepoints fields
To: Michal Hocko <mhocko@suse.com>
Cc: rostedt@goodmis.org, akpm@linux-foundation.org, surenb@google.com, 
	android-mm@google.com, kernel-team@android.com, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 6:16=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Wed 21-02-24 13:30:51, Carlos Galo wrote:
> > On Tue, Feb 20, 2024 at 11:55=E2=80=AFPM Michal Hocko <mhocko@suse.com>=
 wrote:
> > >
> > > Hi,
> > > sorry I have missed this before.
> > >
> > > On Thu 11-01-24 21:05:30, Carlos Galo wrote:
> > > > The current implementation of the mark_victim tracepoint provides o=
nly
> > > > the process ID (pid) of the victim process. This limitation poses
> > > > challenges for userspace tools that need additional information
> > > > about the OOM victim. The association between pid and the additiona=
l
> > > > data may be lost after the kill, making it difficult for userspace =
to
> > > > correlate the OOM event with the specific process.
> > >
> > > You are correct that post OOM all per-process information is lost. On
> > > the other hand we do dump all this information to the kernel log. Cou=
ld
> > > you explain why that is not suitable for your purpose?
> >
> > Userspace tools often need real-time visibility into OOM situations
> > for userspace intervention. Our use case involves utilizing BPF
> > programs, along with BPF ring buffers, to provide OOM notification to
> > userspace. Parsing kernel logs would be significant overhead as
> > opposed to the event based BPF approach.
>
> Please put that into the changelog.

Will do.

> > > > In order to mitigate this limitation, add the following fields:
> > > >
> > > > - UID
> > > >    In Android each installed application has a unique UID. Includin=
g
> > > >    the `uid` assists in correlating OOM events with specific apps.
> > > >
> > > > - Process Name (comm)
> > > >    Enables identification of the affected process.
> > > >
> > > > - OOM Score
> > > >    Allows userspace to get additional insights of the relative kill
> > > >    priority of the OOM victim.
> > >
> > > What is the oom score useful for?
> > >
> > The OOM score provides us a measure of the victim's importance. On the
> > android side, it allows us to identify if top or foreground apps are
> > killed, which have user perceptible impact.
>
> But the value on its own (wihtout knowing scores of other tasks) doesn't
> really tell you anything, does it?

Android uses the OOM adj_score ranges  to categorize app state
(foreground, background, ...). I'll resend a v3 with the commit text
updated to include details about this.

> > > Is there any reason to provide a different information from the one
> > > reported to the kernel log?
> > > __oom_kill_process:
> > > pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, fi=
le-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
> > >                 message, task_pid_nr(victim), victim->comm, K(mm->tot=
al_vm),
> > >                 K(get_mm_counter(mm, MM_ANONPAGES)),
> > >                 K(get_mm_counter(mm, MM_FILEPAGES)),
> > >                 K(get_mm_counter(mm, MM_SHMEMPAGES)),
> > >                 from_kuid(&init_user_ns, task_uid(victim)),
> > >                 mm_pgtables_bytes(mm) >> 10, victim->signal->oom_scor=
e_adj);
> > >
> >
> > We added these fields we need (UID, process name, and OOM score), but
> > we're open to adding the others if you prefer that for consistency
> > with the kernel log.
>
> yes, I think the consistency would be better here. For one it reports
> numbers which can tell quite a lot about the killed victim. It is a
> superset of what you already asking for. With a notable exception of the
> oom_score which is really dubious without a wider context.

Sounds good, I'll resend a v3 that includes these fields as well.

Thanks,
Carlos

> --
> Michal Hocko
> SUSE Labs

