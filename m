Return-Path: <linux-kernel+bounces-38187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E827183BC30
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03FC1C212F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEDF1B94B;
	Thu, 25 Jan 2024 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZIvt/fe"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A4510A1B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172187; cv=none; b=TGpTBRozV/W9Ze37xqFrigReT8ioj/5qNgcId/90Zt/xsz/AjRQueGaqjW+QX0jEhYU7VVVoZO88gY1AMABnFhmM0a/u0BcQtfMtOxKdLy4xpixSPtIlkxjh1gZCY0OPK4YEIWjIIkTt7bh3j9l10me05Q5HtEyZpYs46ZChlec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172187; c=relaxed/simple;
	bh=11S0UO+gDmS6HDjilZ1t1nfAQtcwLEq5BD+umSpnkLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8Qw/rVNSzRMmrQVC48hDnOREroUScYLnltvnT1/zDPpBD/PY/+VQ7qi88GAg/0bggPIfNpXYVxDhqYAVWXroLUvdqY+vUhmtwbh8Ntte/0nN4+0Gmw4Ooz/5bBHSRQf9BFyJ9FBeHq7VyvhvSmS8u9oEHoSDw0PPSj1dSGwn4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZIvt/fe; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso656770166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706172184; x=1706776984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11S0UO+gDmS6HDjilZ1t1nfAQtcwLEq5BD+umSpnkLc=;
        b=wZIvt/feV/KLEzGbd5AqQWe+r6I+cuzqnseoExl0ayCUIOy+w2MQ4ZRI8loNxqx/Ay
         piakixIKIcpNI0kuKPbZTb3oTuN96DqjEVGR/mTnrjllyg73lj0ECuwZD9DqW2yYUcKy
         u8diwDg+aQ4Lz0WnrllG5W8W4wk9ycLD0PLSqrGqHorZjwY4qYHp1TbbmoFGt8uIby6z
         ra9CSl7hOODnqL9nTt6cjL+/IImsnXZkYuKIuEZYWkkuAS/lRkXNCRPslFfve7x+CUIV
         4TN1zMdllfnsq0ZrwgB3VW1VFqw9bbCvWLJo+PVJO5wVs1ueZwkBaldBFw0UBpkMSVhm
         NQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706172184; x=1706776984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11S0UO+gDmS6HDjilZ1t1nfAQtcwLEq5BD+umSpnkLc=;
        b=IlENySDcwTirjZVuuWNaLM5/YPXz47DEsc0MFoLXG5ps/KCsvkdpvCHp143JMi3zYu
         jEyYeb5Qhzg6CgaWgAhaozHqq9A4rrvUwT+Cgh3oYW1kWFNf3JyDWzoKuzc4NjssrL3U
         A0XWLU+0dCUIcARIUtPJr/+mL0r20sXvp9EWywuIYwyAhbkDm32i+eb4/dHsrQi8R2+r
         VJcyvwAhbqGYgR8pGZ7IQvGrScRpp+RwRc2gOzSU0LFPB6WCmnvffGnKDT3yP2Q7d90P
         YlrVBiQ1PRSdLPL5qgqiSny4/ndn6jFZeC+9sCf321NO6WdVXQoNxWssxrd6j2J3O5AG
         Lhdw==
X-Gm-Message-State: AOJu0YyHMLo4/dXIdy4WN3ume0YlPtn1jr77wdg1643+u1IND0yNs5TX
	ihmwHAjESsSmAZ03oh7ODo7BQxMALRnzXKmknh4QkIL1i0FrkrkLcKv0DQ5QAtvVoLZTo2ndwHU
	KgnVYSfF7BMVcv2XIvsc/kefL0ZPFe9TFQkmc
X-Google-Smtp-Source: AGHT+IGTG1XjzgU3aQCCbABZMVQoZ8Bl8q24hej4cTrNRk/VasQ3nHKJnd+7qP97wlCr8mA0ur7Cr/Ch/YQ6qRpRuno=
X-Received: by 2002:a17:906:9c8f:b0:a30:150:917f with SMTP id
 fj15-20020a1709069c8f00b00a300150917fmr460924ejc.154.1706172183687; Thu, 25
 Jan 2024 00:43:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-3-yosryahmed@google.com> <20240122201906.GA1567330@cmpxchg.org>
 <CAJD7tkaATS48HVuBfbOmPM3EvRUoPFr66WhF64UC4FkyVH5exg@mail.gmail.com>
 <20240123153851.GA1745986@cmpxchg.org> <CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com>
 <20240123201234.GC1745986@cmpxchg.org> <CAJD7tkZC6w2EaE=j2NEVWn1s7Lo2A7YZh8LiZ+w72jQzFFWLUQ@mail.gmail.com>
 <f3fa799f-1815-4cfe-abc8-3ba929fcd1ba@bytedance.com> <CAJD7tka6UuEuuP=df-1V3vwsi0T0QhLORTRDs6qDvA81iY6SGA@mail.gmail.com>
 <1496dce3-a4bb-4ccf-92d6-701a45b67da3@bytedance.com>
In-Reply-To: <1496dce3-a4bb-4ccf-92d6-701a45b67da3@bytedance.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 25 Jan 2024 00:42:27 -0800
Message-ID: <CAJD7tkbrQw7FWx-EDKKCtH_E03xEd5Y+8BqRjE8d29JSOCGybg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, Huang Ying <ying.huang@intel.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:30=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2024/1/25 15:53, Yosry Ahmed wrote:
> >> Hello,
> >>
> >> I also thought about this problem for some time, maybe something like =
below
> >> can be changed to fix it? It's likely I missed something, just some th=
oughts.
> >>
> >> IMHO, the problem is caused by the different way in which we use zswap=
 entry
> >> in the writeback, that should be much like zswap_load().
> >>
> >> The zswap_load() comes in with the folio locked in swap cache, so it h=
as
> >> stable zswap tree to search and lock... But in writeback case, we don'=
t,
> >> shrink_memcg_cb() comes in with only a zswap entry with lru list lock =
held,
> >> then release lru lock to get tree lock, which maybe freed already.
> >>
> >> So we should change here, we read swpentry from entry with lru list lo=
ck held,
> >> then release lru lock, to try to lock corresponding folio in swap cach=
e,
> >> if we success, the following things is much the same like zswap_load()=
.
> >> We can get tree lock, to recheck the invalidate race, if no race happe=
ned,
> >> we can make sure the entry is still right and get refcount of it, then
> >> release the tree lock.
> >
> > Hmm I think you may be onto something here. Moving the swap cache
> > allocation ahead before referencing the tree should give us the same
> > guarantees as zswap_load() indeed. We can also consolidate the
> > invalidate race checks (right now we have one in shrink_memcg_cb() and
> > another one inside zswap_writeback_entry()).
>
> Right, if we successfully lock folio in the swap cache, we can get the
> tree lock and check the invalidate race, only once.
>
> >
> > We will have to be careful about the error handling path to make sure
> > we delete the folio from the swap cache only after we know the tree
> > won't be referenced anymore. Anyway, I think this can work.
>
> Yes, we can't reference tree if we early return or after unlocking folio,
> since the reference of zswap entry can't protect the tree.
>
> >
> > On a separate note, I think there is a bug in zswap_writeback_entry()
> > when we delete a folio from the swap cache. I think we are missing a
> > folio_unlock() there.
>
> Ah, yes, and folio_put().

Yes. I am preparing a fix.

>
> >
> >>
> >> The main differences between this writeback with zswap_load() is the h=
andling
> >> of lru entry and the tree lifetime. The whole zswap_load() function ha=
s the
> >> stable reference of zswap tree, but it's not for shrink_memcg_cb() bot=
tom half
> >> after __swap_writepage() since we unlock the folio after that. So we c=
an't
> >> reference the tree after that.
> >>
> >> This problem is easy to fix, we can zswap_invalidate_entry(tree, entry=
) early
> >> in tree lock, since thereafter writeback can't fail. BTW, I think we s=
hould
> >> also zswap_invalidate_entry() early in zswap_load() and only support t=
he
> >> zswap_exclusive_loads_enabled mode, but that's another topic.
> >
> > zswap_invalidate_entry() actually doesn't seem to be using the tree at =
all.
> >
> >>
> >> The second difference is the handling of lru entry, which is easy that=
 we
> >> just zswap_lru_del() in tree lock.
> >
> > Why do we need zswap_lru_del() at all? We should have already isolated
> > the entry at that point IIUC.
>
> I was thinking how to handle the "zswap_lru_putback()" if not writeback,
> in which case we can't use the entry actually since we haven't got refere=
nce
> of it. So we can don't isolate at the entry, and only zswap_lru_del() whe=
n
> we are going to writeback actually.

Why not just call zswap_lru_putback() before we unlock the folio?

