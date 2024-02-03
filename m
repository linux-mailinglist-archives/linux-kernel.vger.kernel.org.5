Return-Path: <linux-kernel+bounces-50918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3618483C1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260E1284A19
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87CCF9E6;
	Sat,  3 Feb 2024 04:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="CwXwk+cT"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76159F9FF
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 04:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706934888; cv=none; b=uwnUwT4QbYU/BiMPsIJcvBUdYeSpTo7trrakEK+HvET0XYI7grbjsBKBuwQRcwmsgZgkq9tUNvUn75PQ1CDEnQonbJFJN2NoJatJG5/tUoB2V54jzsIf8K5+irH/q+1SHObxFdOGXG0SwtUH8PdYZzGx8QE/d5+0GsLX1yQzq68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706934888; c=relaxed/simple;
	bh=B6IZS2BTnQcZfDh3L2ip4LzFdJI5EEsmT+nOePGT0/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JGxj6ENR81zus5/o9+qnzS2eQqZ3dmFhT36Hvcy1H+GKGLeYFG93veLAgm+BnPhGzZk2RU50hDpmmJj157e8M7RRAPtKQX9TpBAzPon80y4Cnx1sa1mXxWfMbItnYslSaNTUb50APIb031th02TVNGd0+QTXpSOaIxwY3/wLE1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CwXwk+cT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d89f0ab02bso39595ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 20:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706934886; x=1707539686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEyrgFwwKoShgj6vdkFSEjnvjtQ1aT81MmdRSOV1nTY=;
        b=CwXwk+cTGQDkC+1TxBeWXs8v+wi6fu2O39c+mVs5XvSPu+0OXvy3Wqiu2TXpeMeZ+/
         bMgll+XGzOVqGnXRQD88NI0RDp7Sq0eH4l/22Ifp6bg3noXBQPh58OpcLmamKrnmgohM
         PYeLLNT4K0EXtn75CMjG7vNuM0Rz8p7rd7llNclwJpgJuHTcWOOcDaPcukoAX3ZT3fPA
         SP+mfydLnK8seDHA4S/mtU0RseG5rOtJbNGd4I1Nwg5Mp6bNNGPQlmsNiuZRm2Trs+kl
         KrdatiezX00xu/X1AQLHHfe2adc8xRYJHSW8WFX5cClKXxKToEVwMZt53KeTY8TdZy3P
         nDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706934886; x=1707539686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEyrgFwwKoShgj6vdkFSEjnvjtQ1aT81MmdRSOV1nTY=;
        b=KfiDCysEnMkjKcXVWNr1ZwnL0irtBCc6ALE9dIsa1XSrKG8nW68GNw8SPhJM6s+do7
         8sEtQ0KbBKP2EBYD8SE3kZ97JvibjygMVQw9uxUCBy0g3RQHVK0QE+MFp1cQOJRI9M2K
         XL69O+WxXtYuq0Lt4xHkbxTLEJBK/ky5TFPmWbU/KSNAPmlzLf3gQyzOAsR1pF0VVgsX
         beSq9/60p8ciT8MGiDw35QX216mIGRLnyCs50H5f0qfTrTUxWI4L5AOsGwwHR2Qv73eJ
         ZQyOE9Wf+/IOxBZnu0riiC+InO2lFYdWR7n9p7o0xy5/J90WEBwb9GYprKC3+h9xWQiG
         BwHw==
X-Gm-Message-State: AOJu0YyerHhvLY23RMh8NuwuH8FBXmEsBRIDFAIBrIhLwvjeF81q2SeA
	KDSMdz76XMVHnGtECZ5zjKckl6dU8ffeF2FFqBbJz0EEOXm/wTVSjwxwodyWvMsFCwheQSQQFjA
	v2GhRjiIcV/PZ+uekN7+udMJ9K4g6qKvGfQyr
X-Google-Smtp-Source: AGHT+IGDiblbM8v5IY8+18PVR34EF9Hdinoguwe39nhCn0T8cbHUFMRAZhZMvp3/mjXn6wiUTo/tZ74uZGteNAYzk/4=
X-Received: by 2002:a17:902:e801:b0:1d9:4c70:9731 with SMTP id
 u1-20020a170902e80100b001d94c709731mr73869plg.29.1706934885315; Fri, 02 Feb
 2024 20:34:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203003414.1067730-1-yosryahmed@google.com>
 <CALvZod6pKLhLm6v7da1sm_axvSR07f_buOc9czRfLb5mpzOanw@mail.gmail.com> <CAJD7tkaLs8JTdLEm1UcpO9amYHwDie=TW12f+7q1y_ipxC15cQ@mail.gmail.com>
In-Reply-To: <CAJD7tkaLs8JTdLEm1UcpO9amYHwDie=TW12f+7q1y_ipxC15cQ@mail.gmail.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Fri, 2 Feb 2024 20:34:33 -0800
Message-ID: <CALvZod62OZVQ7sYKY5V4685eo3RC8esXNyK87JG9VLX3bjeKpw@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixes-unstable] mm: memcg: fix struct
 memcg_vmstats_percpu size and alignment
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 8:23=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Fri, Feb 2, 2024 at 8:13=E2=80=AFPM Shakeel Butt <shakeelb@google.com>=
 wrote:
> >
> > On Fri, Feb 2, 2024 at 4:34=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> > >
> > > Commit da10d7e140196 ("mm: memcg: optimize parent iteration in
> > > memcg_rstat_updated()") added two additional pointers to the end of
> > > struct memcg_vmstats_percpu with CACHELINE_PADDING to put them in a
> > > separate cacheline. This caused the struct size to increase from 1200=
 to
> > > 1280 on my config (80 extra bytes instead of 16).
> > >
> > > Upon revisiting, the relevant struct members do not need to be on a
> > > separate cacheline, they just need to fit in a single one. This is a
> > > percpu struct, so there shouldn't be any contention on that cacheline
> > > anyway. Move the members to the beginning of the struct and cachealig=
n
> > > the first member. Add a comment about the members that need to fit
> > > together in a cacheline.
> > >
> > > The struct size is now 1216 on my config with this change.
> > >
> > > Fixes: da10d7e140196 ("mm: memcg: optimize parent iteration in memcg_=
rstat_updated()")
> > > Reported-by: Greg Thelen <gthelen@google.com>
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > ---
> > >  mm/memcontrol.c | 19 +++++++++----------
> > >  1 file changed, 9 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index d9ca0fdbe4ab0..09f09f37e397e 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -621,6 +621,15 @@ static inline int memcg_events_index(enum vm_eve=
nt_item idx)
> > >  }
> > >
> > >  struct memcg_vmstats_percpu {
> > > +       /* Stats updates since the last flush */
> > > +       unsigned int                    stats_updates ____cacheline_a=
ligned;
> >
> > Why do you need ____cacheline_aligned here? From what I understand for
> > the previous patch you want stats_updates, parent and vmstats on the
> > same cacheline, right?
>
> Yes. I am trying to ensure that stats_updates sits at the beginning of
> a cacheline to ensure they all fit in one cacheline. Is this
> implicitly guaranteed somehow?
>
> >
> > I would say just remove the CACHELINE_PADDING() from the previous
> > patch and we are good.
>
> IIUC, without CACHELINE_PADDING(), they may end up on different cache
> lines, depending on the size of the arrays before them in the struct
> (which depends on several configs). Am I misunderstanding?
>

Yeah keeping them at the start will be better. Move
____cacheline_aligned to the end of the struct definition like:

struct memcg_vmstats_percpu {
..
} ____cacheline_aligned;


> >
> > In the followup I plan to add usage of __cacheline_group_begin() and
> > __cacheline_group_end() usage in memcg code. If you want, take a stab
> > at it.
>
> For now, I am just looking for something simple to fix the struct size
> proliferation for v6.8, but this would be interesting to see. I wonder
> how __cacheline_group_end() works since the end is decided already by
> __cacheline_group_begin() and the cacheline size.

