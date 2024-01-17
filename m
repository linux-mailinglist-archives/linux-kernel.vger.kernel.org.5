Return-Path: <linux-kernel+bounces-29297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5C3830C56
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BB61F266A8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A7F22EF3;
	Wed, 17 Jan 2024 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBRJKlLR"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944162261D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705514304; cv=none; b=KKG+DVxPK7cI5dsZKgxa5mbbjaKz3gdCvz0rS+Y2dkfrGhPglkpUaSQnAyjWU/YgVFBcDahDuH5DdS+/nzUhNuj5PNIsPGUpdw4U7TnSvrOUQJVsVJ0EOaW3lD0//jbZdmbHx+xN4SHLehglBzfvOzitKnJw/1O6RXJjyJHaKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705514304; c=relaxed/simple;
	bh=5/WheQCY1GfJ9JRKjt4HIIR4VyIIs5pvPXBbl33C4XU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Ei46QYNtSiifuotYIR/ReggaQr1lTvWUrEIzX1DFviYbNwy+gU3dEfKhuvKH5GolEfkMiKTJiM7hxhDlis3dvi0XyOKASG3WBD10LPa6cE1OYmb7eRHrTIuDbQ7zKA1uQUYINQ5ML66ngLB4XxOsxV+C21OvfZL+11rWKCnFPxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YBRJKlLR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e87d07c07so15920485e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705514301; x=1706119101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2N3wMQ1N8kNumoIXaU/Gd0BY/kYZ+3Wuem2jd4aYAMY=;
        b=YBRJKlLR8YWSKn3NQ1RH8uogA9tsv76rCbb3LGnqY2Z/e603tmA7J22PSGv+YJPvac
         4uFl47h3dKkyj5na/b/eZnlid5DQ59JbixvTAt8uiuarLdhBpm3k6lxHh+zWRGu721RU
         6adW8uxXfF2xXidY2CbuVkmbt9ChSB9aq0aTLCuashXRfc/BUOVA8vToUdnUVdZcIEkK
         pKorm4N9Xlw9yv1vH2WabhCDfL1rdJmgl7da20InfYZMLsaNbcIGp+VdO1iW9PV19enM
         m9ZX589GtPgDMdBmoaKfVZxHK9VkyPHoowaeQVdAqGwFvA+n25ltMpuWuxeBIPc2yJb3
         lh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705514301; x=1706119101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2N3wMQ1N8kNumoIXaU/Gd0BY/kYZ+3Wuem2jd4aYAMY=;
        b=QCnA6YVZCe3d7yzvOFPFxQtQ9IJwEv5PtmLFbrtltwPMdQbJDe9MDeNK1HChFnEfV7
         PGiDXshPOnfQpo5qVVKcp05KnfILkHTptmGdHv4Sq/STKr/7xCRBN3kYO3WA1Numy+Qm
         opWkffRRpjMk9YoH1j0Ie1A7YZoNpERUD7yk8wYSyMb+p8lETQrXRJt7ZUjO4AFFs9oR
         /fU36jpiIKaZnAETR4Vihy9uD/kA9+NtlqUpK7BN7dNiJ0iA7/ZvmqIkeCDLq03gtSva
         Gs/IZ09iE+/j1/dY8o+xu614lIaYwHQ2Ioi09tXk3xprtdQWVvDHPYvxTvs/X15+Ot1n
         LA3Q==
X-Gm-Message-State: AOJu0YzKIY1Uu0R9wplyR9HoqrtzsTB4TVqJb9ES/0WzP/p2A+roTOpX
	/4ZqNvggvkQBEgg+IOHMoJe57h1Qc3kFSmt9xux3Rkx5puBK
X-Google-Smtp-Source: AGHT+IFED+aI0emD0hl4/wfw/EziOFuIQI8+L+gsJORCcs4u++apT1Vz0NxW16XidB8y+pyynVAXW8iYYI/0nNgDwO4=
X-Received: by 2002:a05:600c:21ce:b0:40e:5b60:9ef3 with SMTP id
 x14-20020a05600c21ce00b0040e5b609ef3mr5800539wmj.41.1705514300624; Wed, 17
 Jan 2024 09:58:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024142706.195517-1-hezhongkun.hzk@bytedance.com>
 <CAKEwX=OiNB+pPhb-3Tf7O=F7psKE3EOpwmbPSeLSOyuHpj3i+Q@mail.gmail.com>
 <CACSyD1P6HmH9tSvONnNxYv8P+am_hH2dK3UJQd9_+o6EWkPsXA@mail.gmail.com>
 <CAKEwX=PC3C-PrWAH3XiYGyR4ujqBJQBBX6uRa2jXKCy9VMyRCQ@mail.gmail.com>
 <CACSyD1O7t0+BXUujJ81RAdEys3MUnmpu0sRADLazoyvayx5DLA@mail.gmail.com>
 <CAKEwX=P5AC+ubnunnZr5vMiC6fFU+E_E7jg_FZztWwZRYSxTWQ@mail.gmail.com>
 <CACSyD1Nnc_w3epbt6+EMt7a-4pAzgW1hbE=G5Fy5Tc5R5+uxKw@mail.gmail.com>
 <CAKEwX=NuXR9Ot1eRFsp9n-3Tq9yhjD9up+jyvXeOzQ4xK9kEPA@mail.gmail.com>
 <CAKEwX=Oj2dR6a4-DeccvcVdJ-J7b=83uCWQAf5u7U0sySudnkw@mail.gmail.com>
 <CAJD7tkb2oda=4f0s8w8xn+t_TM1b2Q_otbb86VPQ9R1m2uqDTA@mail.gmail.com>
 <CACSyD1ODCikYLDzO4LkQeDzB4sqDWCULwCdehw9inP-qyw3_Jg@mail.gmail.com>
 <CAJD7tkY=zmGiPoWNjVaVeU+NPxV2t48J5-CxEP9=nBK8nAh0XA@mail.gmail.com>
 <CAKEwX=Na3dg+KZwvtQi-Nj79Am-1tttDw50_qStkobmYGUC6NA@mail.gmail.com>
 <CACSyD1Pp8gkxwTXZuinm6wiZs0e5U2B5oND4rj29dzmRApFjhQ@mail.gmail.com>
 <CAKEwX=OsTQCJd12S3NajRMRy_s3q3yGFpS7S=_3-yOYK6+ezzA@mail.gmail.com>
 <CACSyD1NgqoFKuHSgdw_bzgK_StsLrNQ+7wHVBqsnHcB-2rD2ow@mail.gmail.com>
 <CACSyD1Np1JbKB9punaigGbJ7y2ZWou1Sr7bczanHv4-1UQZ==A@mail.gmail.com>
 <CAJD7tkbfe5duVhN7kJhkQZLCbK48giVZ8LBx=RQDmp80oa2FDA@mail.gmail.com>
 <CACSyD1PERLG_68OXwzuGH-cqOuS1k8N_fE5Xu-KACZ34UYephw@mail.gmail.com> <CAJD7tkYu5Nm4DETjE1DvwuhAq=C6V=Pv9dx9W_oBw=ihwwTuQg@mail.gmail.com>
In-Reply-To: <CAJD7tkYu5Nm4DETjE1DvwuhAq=C6V=Pv9dx9W_oBw=ihwwTuQg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jan 2024 09:57:44 -0800
Message-ID: <CAJD7tkasktc68qtDE=9v6uZ-tvEyf-6X11B88bpisb+0x4gzHg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 9:53=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Wed, Jan 17, 2024 at 1:53=E2=80=AFAM Zhongkun He
> <hezhongkun.hzk@bytedance.com> wrote:
> >
> > > >
> > > > Please forgive me for adding additional information about this patc=
h.
> > > >
> > > > I have finished the opt for introducing a folio_add_lru_tail(), but
> > > > there are many
> > > > questions:
> > > > 1) A new page can be move to LRU only by lru_add_fn, so
> > > >     folio_add_lru_tail could not add pages to LRU for the following=
 code
> > > >     in folio_batch_move_lru(),which is added by Alex Shi for
> > > >     serializing memcg changes in pagevec_lru_move_fn[1].
> > > >
> > > > /* block memcg migration while the folio moves between lru */
> > > >         if (move_fn !=3D lru_add_fn && !folio_test_clear_lru(folio)=
)
> > > >             continue;
> > > > To achieve the goal, we need to add a new function like  lru_add_fn
> > > > which does not have the lru flag and folio_add_lru_tail()
> > > > +               if (move_fn !=3D lru_add_fn && move_fn !=3D lru_mov=
e_tail_fn_new &&
> > > > +                       !folio_test_clear_lru(folio))
> > > >
> > > > 2)  __read_swap_cache_async has six parameters, so there is no spac=
e to
> > > > add a new one, add_to_lru_head.
> > > >
> > > > So it seems a bit hacky just for a special case for the reasons abo=
ve.
> > >
> > > It's a lot of plumbing for sure. Adding a flag to current task_struct
> > > is a less-noisy yet-still-hacky solution. I am not saying we should d=
o
> > > it, but it's an option. I am not sure how much task flags we have to
> > > spare.
> >
> > Got it.
>
> Actually this won't really work. Writebak can be asynchronous, so
> there would be no logical place to unset the flag.

Scratch that. We would only need the flag to be set until
folio_add_lru() is called (in __read_swap_cache_async()) -- so it can
work.

I am not sure if it's worth it though or if it's even acceptable. It
seems like current->flags are short of space.

