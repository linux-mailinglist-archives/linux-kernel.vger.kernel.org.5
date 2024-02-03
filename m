Return-Path: <linux-kernel+bounces-50919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813F88483C5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9726B238B7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E9A101D0;
	Sat,  3 Feb 2024 04:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="yl+/Trfj"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247CCFC03
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 04:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706935229; cv=none; b=pU7wbvwfGOhnW//WDjH4AVqcHzmQj8gOXZumQ1oJmKrSWsyu0WbZ36Owufrrq3jqIhTd/RVbeYH4+EH/E42GduSSzuS1TYjWlxZi3HQ1pJZ58eolcoPT+mS6X2i5B+g9reRW+x7b+Hbn61jMW4AP9JCh01DS0p3kCBbgCNcUrU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706935229; c=relaxed/simple;
	bh=Q/Xu7hm2YukDwe6Qh5mRdxuk6IIvv00CKnPljk3l1FE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzSP1WEh1hRkFRmCJb/VSM8y0bdLi5te81Q7tZEk52baMChvSjw/Gs5k6ixJIVLTIBj/wO+jAcyQ6TmAt15+al47GTPLUXwYqpHBf+s2S30I5vAnJG7DuL156H8q06HPCRsS2Hk2ZkC0o0irTlXairIX+cjJMjGt0f7pItx20s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yl+/Trfj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so381981066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 20:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706935226; x=1707540026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpXXG/EMRhEf0E4UMXfbSBAtkE3fSF2flaNq2YKC3mA=;
        b=yl+/TrfjJrkHgOdy3psdaa941jyt3uNxNbs1naUPcM2CYrlsRheJJf82EnNiPJETu1
         xplai+x9uQuLq3pvsWOjCE8kgfsonLbyFlwLYTWywkzEdmTI17Pmjwj5ZCfkfjeFDTSe
         9w4Dg6J1aHAQvf5C8GbFEk2oK7jqFbelMY0hFzXhXjpHjTtB6OkOaV2NONDEXBVY8Eax
         i/elbZUL+80fFLRpuGps4PLGmVxx4aYdXffDywPHhNxoeNAAhhCCqLJL7k0ON08ZqPE+
         jgWZmW822fmRnXtvoyyjkXC7lCuHKTDcWcTgK0dlg4gLc811T7UHtDXHzE2NL0l1P20Y
         jt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706935226; x=1707540026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpXXG/EMRhEf0E4UMXfbSBAtkE3fSF2flaNq2YKC3mA=;
        b=ON/y7bTkVFbFvtR3sufgjAuEYJIgK4tKF5OvxKPwr2gmHfA3P3HUy6XB4eGMOrI6Nt
         NZvEZGx8pCg4cbd3a7uVWFQBbYIOvGQfUFhCVYHYBsSYAyNf+F9DxpEuU7Prbpr/ccV1
         7oK9IAeof8QBWeqFArTD+mqXsdS1n+wG+m6VuWKQew6nYJKrWnUIyaOWeWPo/1IDMQU7
         GXQqfJUjj/AnypBnZ9KXhQSob8B/aSMcUlhcgEETcSCRLNm7C6+g6zhNYiBbCAOzICNM
         D7xWhkqy/K9GlgkIUYs1wq6hnlNF4ZQ9qoWJqQtl1t09Aa61WAPyOX1z/8OTDypOnT02
         eaHQ==
X-Gm-Message-State: AOJu0YxKT7M6+TSbRdiO1bK+K4aavbKa7WwNZ7I+cR7AABCg8ePvyhfp
	shfWIBkQvLgUuvA97fxILPexatNBtDYxskE0JdKQ66oYRJeBxa2geM4zjXfZsj3bjE2puRy9Ua7
	yy2InImKQmhHeLAzKL1UqQ54LNRenxhNrpdIp
X-Google-Smtp-Source: AGHT+IEOqG40Y65sLEOSy86hePJBYD/7doxLjCm+pORd3Q1Ko/44+czAM1deYOmfsGNTWOU4rUzQvXxGBiJdk9yWGT4=
X-Received: by 2002:a17:906:5ad3:b0:a36:8d18:4c25 with SMTP id
 x19-20020a1709065ad300b00a368d184c25mr6140159ejs.16.1706935226165; Fri, 02
 Feb 2024 20:40:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203003414.1067730-1-yosryahmed@google.com>
 <CALvZod6pKLhLm6v7da1sm_axvSR07f_buOc9czRfLb5mpzOanw@mail.gmail.com>
 <CAJD7tkaLs8JTdLEm1UcpO9amYHwDie=TW12f+7q1y_ipxC15cQ@mail.gmail.com> <CALvZod62OZVQ7sYKY5V4685eo3RC8esXNyK87JG9VLX3bjeKpw@mail.gmail.com>
In-Reply-To: <CALvZod62OZVQ7sYKY5V4685eo3RC8esXNyK87JG9VLX3bjeKpw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 2 Feb 2024 20:39:49 -0800
Message-ID: <CAJD7tkbzaiOWpxPTf6xbNvy=6HXdLbnGQMGgi6Krq9q4j+L-WQ@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixes-unstable] mm: memcg: fix struct
 memcg_vmstats_percpu size and alignment
To: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 8:34=E2=80=AFPM Shakeel Butt <shakeelb@google.com> w=
rote:
>
> On Fri, Feb 2, 2024 at 8:23=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > On Fri, Feb 2, 2024 at 8:13=E2=80=AFPM Shakeel Butt <shakeelb@google.co=
m> wrote:
> > >
> > > On Fri, Feb 2, 2024 at 4:34=E2=80=AFPM Yosry Ahmed <yosryahmed@google=
com> wrote:
> > > >
> > > > Commit da10d7e140196 ("mm: memcg: optimize parent iteration in
> > > > memcg_rstat_updated()") added two additional pointers to the end of
> > > > struct memcg_vmstats_percpu with CACHELINE_PADDING to put them in a
> > > > separate cacheline. This caused the struct size to increase from 12=
00 to
> > > > 1280 on my config (80 extra bytes instead of 16).
> > > >
> > > > Upon revisiting, the relevant struct members do not need to be on a
> > > > separate cacheline, they just need to fit in a single one. This is =
a
> > > > percpu struct, so there shouldn't be any contention on that cacheli=
ne
> > > > anyway. Move the members to the beginning of the struct and cacheal=
ign
> > > > the first member. Add a comment about the members that need to fit
> > > > together in a cacheline.
> > > >
> > > > The struct size is now 1216 on my config with this change.
> > > >
> > > > Fixes: da10d7e140196 ("mm: memcg: optimize parent iteration in memc=
g_rstat_updated()")
> > > > Reported-by: Greg Thelen <gthelen@google.com>
> > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > > ---
> > > >  mm/memcontrol.c | 19 +++++++++----------
> > > >  1 file changed, 9 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index d9ca0fdbe4ab0..09f09f37e397e 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -621,6 +621,15 @@ static inline int memcg_events_index(enum vm_e=
vent_item idx)
> > > >  }
> > > >
> > > >  struct memcg_vmstats_percpu {
> > > > +       /* Stats updates since the last flush */
> > > > +       unsigned int                    stats_updates ____cacheline=
_aligned;
> > >
> > > Why do you need ____cacheline_aligned here? From what I understand fo=
r
> > > the previous patch you want stats_updates, parent and vmstats on the
> > > same cacheline, right?
> >
> > Yes. I am trying to ensure that stats_updates sits at the beginning of
> > a cacheline to ensure they all fit in one cacheline. Is this
> > implicitly guaranteed somehow?
> >
> > >
> > > I would say just remove the CACHELINE_PADDING() from the previous
> > > patch and we are good.
> >
> > IIUC, without CACHELINE_PADDING(), they may end up on different cache
> > lines, depending on the size of the arrays before them in the struct
> > (which depends on several configs). Am I misunderstanding?
> >
>
> Yeah keeping them at the start will be better. Move
> ____cacheline_aligned to the end of the struct definition like:
>
> struct memcg_vmstats_percpu {
> ...
> } ____cacheline_aligned;

Will send a v2 shortly, thanks. I honestly didn't know what the
difference was, but both gave me the same results. Is using
____cacheline_aligned with the first member the same as using it at
the end of the definition?

