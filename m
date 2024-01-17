Return-Path: <linux-kernel+bounces-29363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D169A830D48
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F98283644
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD4D249EC;
	Wed, 17 Jan 2024 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHywwykz"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E7E22EF8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705519783; cv=none; b=PLDUCcTsN0JeyhtMWGQvW/gRrG0ieSsY9hcYMhYnJHuE8XIjCasPBpyICpAa7EYwZF2O/LIiPjUn25dIpm4LbsXI5NmqCLrIbZEZAo/Nqh5s/UMj5OrwFISZwJumThcnFM6RFLaXdhwQJW7ejfPNfxpF/nMmMqI5e8URKIGQsQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705519783; c=relaxed/simple;
	bh=4ez/Z4yfTa+2hWY1tMDS+MRix3YJpTVOMkTSJWQySQs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=uZ92KH/tna+HrGTkW88iQLCB/JPJNxeWm3/2tEegJDQAHdxYwU/ywP7x8uKNlYQxuFvw0eeHIuxUTeXPpEBLrE7A/G4knyoLIQ+FIiVh9BV2dQsFp4VmOOZCPxPw8jlhSYpoQM/giNF93hGAq4OcZQtOTEfLE3AfD3Ys7CbSVZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHywwykz; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7beda2e6794so295082039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705519781; x=1706124581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwdOXy7SGjLb95yHRM4TBRusWdEvPGWfjIJ+jxRtxVo=;
        b=AHywwykzuMC3Pe1qWB9QDkHtmBpguR4Q7xygPttlyNY20JDPRaixRElovADYtX2gwS
         XpaOrr2xfwUa5uuD87u02Nvk3h4kmDgfxohV9loEu/Cr9cKoq9K0OIPVxR4n5Kr/e5VR
         lmGRhxe8AVVgHQIFjdXGYpX1gLhlAYFlWOM4fSGTRxnBrgdySxNKkpJUB2qXvu8fNrtd
         pvFEirIjpFN9SUdtgXl+ZLKYDr+DfBei6EmszCKzBbz8eewl7VjFTv+pz5baZ36hKsgx
         tAYRREOruO3h38ZkQN70hpWkHhSX55i3to8ZggmON9Ux19sE7xYDsV6X9Bn8fILXzDAe
         fidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705519781; x=1706124581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwdOXy7SGjLb95yHRM4TBRusWdEvPGWfjIJ+jxRtxVo=;
        b=A8hRbHg9uUHQXsIwiZF4Ztkjd8SYEbAo6SV0FxZQ0Pqezf+vpLdwt++sSQ5UB69FIP
         HbnwTOANKwHrUxqCImCkgl6VF9+b0n6OKAHpjtGTHs+LGJ7QfVseH8Cb8rnaAXGSsG67
         W2P+TttY6o6Wuh1qcY2MGagJck0vZc+Ek5mXyecdwySEil8nVD4LmGnVLf+cj0uV9lkR
         fSDSCK/9EWwBpxL/0rv0VOZEJiNlGRCmVIPxIIp2NARz0nb9jmAkprwCoKRFJESFNP4B
         jooRCsktJOOeHEny/Hdq5zam/934XC7CqFmSc3+6pd6l0N8T9dyZc8ZBmMmJVfuVJnoU
         oxLw==
X-Gm-Message-State: AOJu0Yz4gh7jYoZvaAreGVpRCqKyAog9cDqnfcVlr1VXPshJy5Fl5oSJ
	4IM6NbYfecLC8bcF8y6N37xqRbYrexLfDmbdopw=
X-Google-Smtp-Source: AGHT+IF+ZHy71HvFx/DWrxMtc91jGIFhsUoG/dWbvXmmATBmGxQTh082HisPIy+9T23OzDXsqA+ntB9TKizShofqL2Q=
X-Received: by 2002:a5e:d91a:0:b0:7bf:5355:dd23 with SMTP id
 n26-20020a5ed91a000000b007bf5355dd23mr916618iop.6.1705519780874; Wed, 17 Jan
 2024 11:29:40 -0800 (PST)
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
 <CAJD7tkbfe5duVhN7kJhkQZLCbK48giVZ8LBx=RQDmp80oa2FDA@mail.gmail.com> <CACSyD1PERLG_68OXwzuGH-cqOuS1k8N_fE5Xu-KACZ34UYephw@mail.gmail.com>
In-Reply-To: <CACSyD1PERLG_68OXwzuGH-cqOuS1k8N_fE5Xu-KACZ34UYephw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 17 Jan 2024 11:29:29 -0800
Message-ID: <CAKEwX=Ok1SE6X=_mt3fGjUTt5qKvRm329zOPiMg6WRTZsuHRgg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 1:52=E2=80=AFAM Zhongkun He
<hezhongkun.hzk@bytedance.com> wrote:
>
> > >
> > > Please forgive me for adding additional information about this patch.
> > >
> > > I have finished the opt for introducing a folio_add_lru_tail(), but
> > > there are many
> > > questions:
> > > 1) A new page can be move to LRU only by lru_add_fn, so
> > >     folio_add_lru_tail could not add pages to LRU for the following c=
ode
> > >     in folio_batch_move_lru(),which is added by Alex Shi for
> > >     serializing memcg changes in pagevec_lru_move_fn[1].
> > >
> > > /* block memcg migration while the folio moves between lru */
> > >         if (move_fn !=3D lru_add_fn && !folio_test_clear_lru(folio))
> > >             continue;
> > > To achieve the goal, we need to add a new function like  lru_add_fn
> > > which does not have the lru flag and folio_add_lru_tail()
> > > +               if (move_fn !=3D lru_add_fn && move_fn !=3D lru_move_=
tail_fn_new &&
> > > +                       !folio_test_clear_lru(folio))

Hmm yeah, I guess it is a bit more plumbing to do. I prefer this
though - not very fond of hacking current's flag just for a small
optimization :) And I'd argue this is the "right" thing to do -
draining the other LRU operation batches just so that we can
successfully perform an add-to-tail seems hacky and wrong to me.

> > >
> > > 2)  __read_swap_cache_async has six parameters, so there is no space =
to
> > > add a new one, add_to_lru_head.

Matthew's solution seems fine to me, no? i.e using a single flag
parameter to encapsulate all boolean arguments.

> > >
> > > So it seems a bit hacky just for a special case for the reasons above=
.
> >
> > It's a lot of plumbing for sure. Adding a flag to current task_struct
> > is a less-noisy yet-still-hacky solution. I am not saying we should do
> > it, but it's an option. I am not sure how much task flags we have to
> > spare.
>
> Got it.
> >
> > >
> > > Back to the beginning,  lru_add_drain() is the simplest option=EF=BC=
=8Cwhich is common
> > > below the __read_swap_cache_async(). Please see the function
> > > swap_cluster_readahead()
> > > and swap_vma_readahead(), of course it has been batched.
> > >
> > > Or we should  leave this problem alone=EF=BC=8Cbefore we can write ba=
ck zswap
> > > in batches.
> >
> > Calling lru_add_drain() for every written back page is an overkill
> > imo. If we have writeback batching at some point, it may make more
> > sense then.
>
> Agree.

Agree. lru_add_drain() does quite a bit, and doing it for every
written page makes batching less effective. And as argued above, I
don't think we should do this.

I'm fine with waiting til writeback batching too :) But that will be a
bigger task.


>
> >
> > Adding Michal Hocko was recently complaining [1] about lru_add_drain()
> > being called unnecessarily elsewhere.
>
> Got it, thanks.
> >
> > [1]https://lore.kernel.org/linux-mm/ZaD9BNtXZfY2UtVI@tiehlicka/

