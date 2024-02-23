Return-Path: <linux-kernel+bounces-78882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD924861A11
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0CB31C24BD4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CE0133985;
	Fri, 23 Feb 2024 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQvtPPi9"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F71128834
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709918; cv=none; b=jPU/q8SFU9tMHlQSlvkZ7BpE15Ge8RqlRu4W/XF6BjfMD6HZb/3yqBJRUo3RFH4ZGU094+VuMwzTGImxVUpZfibURHXxllgjIsFqBB7irhkjcWJH6FNobj2xxvg9Yvb1OZlhN5CPAuw6NO0P5pcPTEw01omJzxH2fNmBJoz29wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709918; c=relaxed/simple;
	bh=E0OHldkh2v+0MAmP6aby59DUzL+2alnG2lOXSqHREbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKm9tGmHvKkfOkscGx0gyRGv5e0QsUz7TPx1LyTMroIN/OguuWQQKI0a+QUa6g7kxm9nsOzYrxIACQnKPEZ9XTBeQXV0MmIuLIBBoEWAkrtk9iN26AWVqXzcRsxK3kDDAGRlCCJ8Oh7ZGKw1UqSsEmb5/R6qJZK1A14Ie/atbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQvtPPi9; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68f51ba7043so6993836d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708709915; x=1709314715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQha6Db7BGmzVAECCcFfEwysEpHphSP0pMsHuZkmas0=;
        b=bQvtPPi9aoyUZbrcmpIXjj45Q0N8chRQ/DRdAk/ktrixiLLPyIpP0gcDUknR7hXnkO
         rIsM3BXTlXBI8v2RNXE+DEFUl8xfqvGLWw2013GpuHHELE4Pw/44xlz/7AzvnBYee3s7
         +dLrUpBCvDG6d+iAYXMoAg9A8ynHAZHa4DHcs3O7RyhiS+D4rKe+HEVQTWLus56qL5K7
         NDyHoAEUDyb0F8M2/fH6BcPEW1IM/Aunanam32jy9dwoMinjhIf0quA5QOXFcMofczXU
         BKmb9x7wr+N4l9YNZdpYMDDiEQivyr0EPFdIkZ/WOdgYxlr3nEqFpucN5yfZxE/b04og
         I3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708709915; x=1709314715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQha6Db7BGmzVAECCcFfEwysEpHphSP0pMsHuZkmas0=;
        b=r0+8W9PpOiCTl3vZ6I2wIY3k1Zl4ljLiuuJFv07lOFlZDI2E/v6DGYapH9YuK++n17
         Sd6fN2NTHJEqb19tnqdhnte0FzVUUuHNTVihfWdzj8luT5KBx645gVcxwM7KH8O28T6j
         q76UXdp3BnpNEZ65vqiUMbq9ZmNH7MQaqgjNSWFmsQ7DDh+BQQ0E8A1g0xI7ppadS4sc
         YoeN2/94lMbfRir/EyjMnV4aMFNT7OPRplokBZ/JiZ8zpqhTMuCv4tTdpUi1vpbbxpK8
         CbHD4UHSk+OLh3UhuKi8y035pRuQQ9C6gbpkkaaDha6lMVEZGdKdGPS92kbd+eGU2dfm
         C26w==
X-Forwarded-Encrypted: i=1; AJvYcCXfLvKfcbuwesimyM0skdt6GqteNcWws2OSTnNRrAtUqI5uWuCt+IiZhEu65ttlQwQ71bNfLCjRaVE/peCrKWCbU6ws5IpuP5lJXR2A
X-Gm-Message-State: AOJu0YymViCq+9fdTOzfdVXchoVP2RoZDS82BxsEyR9rpbGTNN4sFTWy
	/J2xtVSs19xj4cySC1RvWZq12pTD/e/9vhQPkvc6frlRntDDGa6H+++bnomg3kSxQvBuhUjFMTw
	KpWTunJr1SIAbxbKR0w1z2R9wSWjU6peKKCtF
X-Google-Smtp-Source: AGHT+IGZ8nB/bBWl1cHIQ2s49iIYkm/IyW2oZ+4Wnr8YByscHIMWXGlJ1RtmEoQ14Agew8SXUnnP/DWdmS2TDOqWrNM=
X-Received: by 2002:a05:6214:2b8a:b0:68c:425b:ea9 with SMTP id
 kr10-20020a0562142b8a00b0068c425b0ea9mr668685qvb.42.1708709915421; Fri, 23
 Feb 2024 09:38:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111210539.636607-1-carlosgalo@google.com>
 <ZdWshXSoLthv6J6b@tiehlicka> <CABtOLR+gpU2BYxcGCCqccZGcRDF337z3JJ=7nvC47ANHmS1tNA@mail.gmail.com>
 <ZddXLGdJ0QDZTvJS@tiehlicka> <CABtOLR+G6jyfV_7YUabJnmt=oN12fzPHB7viq9fTJb44wtefiw@mail.gmail.com>
In-Reply-To: <CABtOLR+G6jyfV_7YUabJnmt=oN12fzPHB7viq9fTJb44wtefiw@mail.gmail.com>
From: Carlos Galo <carlosgalo@google.com>
Date: Fri, 23 Feb 2024 09:38:22 -0800
Message-ID: <CABtOLR+HgxauAFyV6rFy=W75eF2c9KhvMAVok52NFzm2J0FhXA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Update mark_victim tracepoints fields
To: Michal Hocko <mhocko@suse.com>
Cc: rostedt@goodmis.org, akpm@linux-foundation.org, surenb@google.com, 
	android-mm@google.com, kernel-team@android.com, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 9:59=E2=80=AFAM Carlos Galo <carlosgalo@google.com>=
 wrote:
>
> On Thu, Feb 22, 2024 at 6:16=E2=80=AFAM Michal Hocko <mhocko@suse.com> wr=
ote:
> >
> > On Wed 21-02-24 13:30:51, Carlos Galo wrote:
> > > On Tue, Feb 20, 2024 at 11:55=E2=80=AFPM Michal Hocko <mhocko@suse.co=
m> wrote:
> > > >
> > > > Hi,
> > > > sorry I have missed this before.
> > > >
> > > > On Thu 11-01-24 21:05:30, Carlos Galo wrote:
> > > > > The current implementation of the mark_victim tracepoint provides=
 only
> > > > > the process ID (pid) of the victim process. This limitation poses
> > > > > challenges for userspace tools that need additional information
> > > > > about the OOM victim. The association between pid and the additio=
nal
> > > > > data may be lost after the kill, making it difficult for userspac=
e to
> > > > > correlate the OOM event with the specific process.
> > > >
> > > > You are correct that post OOM all per-process information is lost. =
On
> > > > the other hand we do dump all this information to the kernel log. C=
ould
> > > > you explain why that is not suitable for your purpose?
> > >
> > > Userspace tools often need real-time visibility into OOM situations
> > > for userspace intervention. Our use case involves utilizing BPF
> > > programs, along with BPF ring buffers, to provide OOM notification to
> > > userspace. Parsing kernel logs would be significant overhead as
> > > opposed to the event based BPF approach.
> >
> > Please put that into the changelog.
>
> Will do.
>
> > > > > In order to mitigate this limitation, add the following fields:
> > > > >
> > > > > - UID
> > > > >    In Android each installed application has a unique UID. Includ=
ing
> > > > >    the `uid` assists in correlating OOM events with specific apps=
.
> > > > >
> > > > > - Process Name (comm)
> > > > >    Enables identification of the affected process.
> > > > >
> > > > > - OOM Score
> > > > >    Allows userspace to get additional insights of the relative ki=
ll
> > > > >    priority of the OOM victim.
> > > >
> > > > What is the oom score useful for?
> > > >
> > > The OOM score provides us a measure of the victim's importance. On th=
e
> > > android side, it allows us to identify if top or foreground apps are
> > > killed, which have user perceptible impact.
> >
> > But the value on its own (wihtout knowing scores of other tasks) doesn'=
t
> > really tell you anything, does it?
>
> Android uses the OOM adj_score ranges  to categorize app state
> (foreground, background, ...). I'll resend a v3 with the commit text
> updated to include details about this.
>
> > > > Is there any reason to provide a different information from the one
> > > > reported to the kernel log?
> > > > __oom_kill_process:
> > > > pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, =
file-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n"=
,
> > > >                 message, task_pid_nr(victim), victim->comm, K(mm->t=
otal_vm),
> > > >                 K(get_mm_counter(mm, MM_ANONPAGES)),
> > > >                 K(get_mm_counter(mm, MM_FILEPAGES)),
> > > >                 K(get_mm_counter(mm, MM_SHMEMPAGES)),
> > > >                 from_kuid(&init_user_ns, task_uid(victim)),
> > > >                 mm_pgtables_bytes(mm) >> 10, victim->signal->oom_sc=
ore_adj);
> > > >
> > >
> > > We added these fields we need (UID, process name, and OOM score), but
> > > we're open to adding the others if you prefer that for consistency
> > > with the kernel log.
> >
> > yes, I think the consistency would be better here. For one it reports
> > numbers which can tell quite a lot about the killed victim. It is a
> > superset of what you already asking for. With a notable exception of th=
e
> > oom_score which is really dubious without a wider context.
>
> Sounds good, I'll resend a v3 that includes these fields as well.
>
> Thanks,
> Carlos
>

I posted V3 here:
https://lore.kernel.org/all/20240223173258.174828-1-carlosgalo@google.com/

Thanks,
Carlos
> > --
> > Michal Hocko
> > SUSE Labs

