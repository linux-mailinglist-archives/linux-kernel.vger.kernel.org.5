Return-Path: <linux-kernel+bounces-101044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0BE87A161
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6741F22427
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95119BE65;
	Wed, 13 Mar 2024 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+SFhrBm"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF07BA2B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710295734; cv=none; b=rbfj2dniqIhtBmDlkYSka2Q1sh1L29j593FYPdB/PcvFVKfyVhpCPpvpzehDYYXkgroes0EpjdXqfwGwA5myQeL1t6+3ots+AuR6ZI7kGwHWDhyXsyXkIgEnMps0FYjwvMLG/eRzmvwOTBtq2lrCCpInqNfhv9JbLlAj82tCRKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710295734; c=relaxed/simple;
	bh=ZX2eHyPyf4WlgykQVje6yiqVGnJt1S5l/nmDOWfN6UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLeV7MCJJ//0QnK+WJD2u4cprPIQxZb+ZFde0y04ecbhFn3557slPbyb2RIRyhbA2mW4GSSrVb4QGZ+b3+M7L45rt8FgvqKQQiEaOaVh0ciOwHi1PG3VhVjDeRu1elujwrzHpmBQGykMpq+u1T4r4ImO3Wat28jjNdEwUtQWyts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j+SFhrBm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412f81fd561so25675e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710295731; x=1710900531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NhuLx8Hd3VM7u/rZLXcaWHkS4clRr3sag751o8/rg4=;
        b=j+SFhrBmQUJo4LlKLIcFCNy/1DPfou1GzzTWQKZWGJ4MDARvJpjdXox4ay5PiRZo1o
         deExWP/S6LfoD5Lh2OuSpU3vUCbwe3TQTuXlLyWjxWf15jeEzjGYf6EvIStdVvTBczor
         PJcbRTYbb0Yd+iZTzuOS3rP8O65hdXGDHrw6VAtIlWRKE6nPJlBE7Nqi4CkvUzwyMa8v
         lTTXmnyfYtuYVkMMTLSYjbGvmd3NiSeBS1DBEIh3y3MWn5+7ZGF+8D7IazUtMG9CVkh9
         zLdTSSorxniR1GDiXpV8W4hXOSIzTpLUVttCJhYLkp3R0lHx8ZOKeNnq/R+xqGxF//sX
         xKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710295731; x=1710900531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NhuLx8Hd3VM7u/rZLXcaWHkS4clRr3sag751o8/rg4=;
        b=CpvuY5LcGdeQnKGFJ+AcBhj6QKXEYoJQ3s2h1judO+FFGvGl3BuqZf/dOUOQnr3zfo
         fjqCxPf3I88rDf3x+qz4Zf9qzMAgspm0d0lNRPOdUZUEKpFsVz4z0WaEQA6LwzMkfc+g
         KX2VpExLSOsqiecu5nCp29a1TLMHxxLQ4tfDo5UgxevwpHZDpxFzt7B+Pmm6hCY+3sCz
         kkQKTikFdQq5FzZEmg1Ju+HKa3KNkh12KXWLDnm+XfQGWSQ7Mukm9mNgDK90ZFzpoQDR
         f32IhLXlAX2gJzPT3CKezzGHfBk02eepRjgPHzHD2UWC4B4fubDpQp2/9+KqXjXdc2pJ
         XG4A==
X-Forwarded-Encrypted: i=1; AJvYcCU4aIBnZhE1BAR3/bHs6W617l0TPtLH5x52uWWYPUFlMloZRhp/0e9nM+j0ayrytynwWtHT46pD836HCNrV4XnjxI422okYt1tYVWCw
X-Gm-Message-State: AOJu0YzFEx7jgzQ1sPobct+qHwvbD5GXHJBAlTR2kS6uHYqU24YWmJIR
	myiSFFgK+yPhF8NQc25RiNA+6iixYW80pRB2j/z+dAhi5IveLOCFyDirh2KaSaXHE+DKVHL6Ano
	yAfcvMyAxoVN3NoGJ0PBOxyJHQl2Z5/hC0u+K
X-Google-Smtp-Source: AGHT+IE22TKRWGA/6PaqMQKmQT2rQFAdr8rQqytN9on+vBz0f5TKP19RwLycd+OGxliog1WsIbUL3rhPAZw/TnTsIEY=
X-Received: by 2002:a05:600c:3d18:b0:412:f547:e3e0 with SMTP id
 bh24-20020a05600c3d1800b00412f547e3e0mr76860wmb.4.1710295730982; Tue, 12 Mar
 2024 19:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcWOh9u3uqZjNFMa@chrisdown.name> <20240229235134.2447718-1-axelrasmussen@google.com>
 <ZeEhvV15IWllPKvM@chrisdown.name> <CAJHvVch2qVUDTJjNeSMqLBx0yoEm4zzb=ZXmABbd_5dWGQTpNg@mail.gmail.com>
 <CALOAHbBupMYBMWEzMK2xdhnqwR1C1+mJSrrZC1L0CKE2BMSC+g@mail.gmail.com>
 <CAJHvVcjhUNx8UP9mao4TdvU6xK7isRzazoSU53a4NCcFiYuM-g@mail.gmail.com>
 <ZfC16BikjhupKnVG@google.com> <20240312210822.GB65481@cmpxchg.org>
In-Reply-To: <20240312210822.GB65481@cmpxchg.org>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 12 Mar 2024 22:08:13 -0400
Message-ID: <CAOUHufa4zgWtA_XyWZUcQ7pqbarC2VpJd-=J--gy8tCGQin+yQ@mail.gmail.com>
Subject: Re: MGLRU premature memcg OOM on slow writes
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Chris Down <chris@chrisdown.name>, cgroups@vger.kernel.org, kernel-team@fb.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 5:08=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, Mar 12, 2024 at 02:07:04PM -0600, Yu Zhao wrote:
> > Yes, these two are among the differences between the active/inactive
> > LRU and MGLRU, but their roles, IMO, are not as important as the LRU
> > positions of dirty pages. The active/inactive LRU moves dirty pages
> > all the way to the end of the line (reclaim happens at the front)
> > whereas MGLRU moves them into the middle, during direct reclaim. The
> > rationale for MGLRU was that this way those dirty pages would still
> > be counted as "inactive" (or cold).
>
> Note that activating the page is not a statement on the page's
> hotness. It's simply to park it away from the scanner. We could as
> well have moved it to the unevictable list - this is just easier.
>
> folio_end_writeback() will call folio_rotate_reclaimable() and move it
> back to the inactive tail, to make it the very next reclaim target as
> soon as it's clean.
>
> > This theory can be quickly verified by comparing how much
> > nr_vmscan_immediate_reclaim grows, i.e.,
> >
> >   Before the copy
> >     grep nr_vmscan_immediate_reclaim /proc/vmstat
> >   And then after the copy
> >     grep nr_vmscan_immediate_reclaim /proc/vmstat
> >
> > The growth should be trivial for MGLRU and nontrivial for the
> > active/inactive LRU.
> >
> > If this is indeed the case, I'd appreciate very much if anyone could
> > try the following (I'll try it myself too later next week).
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 4255619a1a31..020f5d98b9a1 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -4273,10 +4273,13 @@ static bool sort_folio(struct lruvec *lruvec, s=
truct folio *folio, struct scan_c
> >       }
> >
> >       /* waiting for writeback */
> > -     if (folio_test_locked(folio) || folio_test_writeback(folio) ||
> > -         (type =3D=3D LRU_GEN_FILE && folio_test_dirty(folio))) {
> > -             gen =3D folio_inc_gen(lruvec, folio, true);
> > -             list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
> > +     if (folio_test_writeback(folio) || (type =3D=3D LRU_GEN_FILE && f=
olio_test_dirty(folio))) {
> > +             DEFINE_MAX_SEQ(lruvec);
> > +             int old_gen, new_gen =3D lru_gen_from_seq(max_seq);
> > +
> > +             old_gen =3D folio_update_gen(folio, new_gen);
> > +             lru_gen_update_size(lruvec, folio, old_gen, new_gen);
> > +             list_move(&folio->lru, &lrugen->folios[new_gen][type][zon=
e]);
> >               return true;
>
> Right, because MGLRU sorts these pages out before calling the scanner,
> so they never get marked for immediate reclaim.
>
> But that also implies they won't get rotated back to the tail when
> writeback finishes.

Those dirty pages are marked by PG_reclaim either by

  folio_inc_gen()
  {
    ...
    if (reclaiming)
      new_flags |=3D BIT(PG_reclaim);
    ...
  }

or [1], which I missed initially. So they should be rotated on writeback
finishing up.

[1] https://lore.kernel.org/linux-mm/ZfC2612ZYwwxpOmR@google.com/

> Doesn't that mean that you now have pages that
>
> a) came from the oldest generation and were only deferred due to their
>    writeback state, and
>
> b) are now clean and should be reclaimed. But since they're
>    permanently advanced to the next gen, you'll instead reclaim pages
>    that were originally ahead of them, and likely hotter.
>
> Isn't that an age inversion?
>
> Back to the broader question though: if reclaim demand outstrips clean
> pages and the only viable candidates are dirty ones (e.g. an
> allocation spike in the presence of dirty/writeback pages), there only
> seem to be 3 options:
>
> 1) sleep-wait for writeback
> 2) continue scanning, aka busy-wait for writeback + age inversions
> 3) find nothing and declare OOM
>
> Since you're not doing 1), it must be one of the other two, no? One
> way or another it has to either pace-match to IO completions, or OOM.

Yes, and in this case, 2) is possible but 3) is very likely.

MGLRU doesn't do 1) for sure (in the reclaim path of course). I didn't
find any throttling on dirty pages for cgroup v2 either in the
active/inactive LRU -- I assume Chris was on v2, and hence my take on
throttling on dirty pages in the reclaim path not being the key for
his case.

With the above change, I'm hoping balance_dirty_pages() will wake up
the flusher, again for Chris' case, so that MGLRU won't have to call
wakeup_flusher_threads(), since it can wake up the flusher too often
and in turn cause excessive IOs when considering SSD wearout.

