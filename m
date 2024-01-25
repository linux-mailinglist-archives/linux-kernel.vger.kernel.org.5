Return-Path: <linux-kernel+bounces-37978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BC083B913
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF8D1F24384
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FCF101E8;
	Thu, 25 Jan 2024 05:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sFB4Lmgi"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F67D533
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 05:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706160544; cv=none; b=t2NfkUQubdXvtkBTsamyNI75DkIr3Chv6dKjOSbav5h5UkMbVsbOF7p1V9MqpyrwyL3FMd9kBShga7lIY8lRZOsAuKGTkjyQ4+tO8PUkLJ/QadWa3C5octtZzerrM4QEXtRcIPnowlt6y6YYsCg6rUg90od1VN7i0TQRPlguke8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706160544; c=relaxed/simple;
	bh=E4kea5CZHNufTR5jgb/Q/PX96viBBmgx4U54wss/2JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqnGJHRgIy9Bxm1fRV231NypoRC6rmwGeZiDy7822rMV6CQgwqJsKqi5tNLL8Bpx0XRzL90qxegYPA6LinlT98JXNnKf8CN/vvmpkhTtSXhvWREjQNLvIGaXlTq76JjrhSUfLfDkkc9IIpad3LmhJVP/wVzTYVqfpoFCchYugXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sFB4Lmgi; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2903498ae21so3618289a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 21:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706160542; x=1706765342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mB72gzBDyyMoSpJLQwvx7iM/246zvXStdgAa5oAjJU=;
        b=sFB4Lmgiax1TOFd07Bpy+IyBdNW/XZvEBrqUP0X1yQCAARJQn/dLBJVHtEBLlzKg0u
         YO8kJZufXjxtB6NEKyY6nb2PbSzxdNpj3KA42VzPe5G07UtvbgVGS+rOoyWlgJfI7/wT
         IIc81HgOULh4AwnR7E57RBtuEQi6Thya1iU+otT5OFbLl7B2xcMg3JiJE76G5h5JDgFF
         +QaVZW7E63Ywau/BkNJyibUJdxNQ125qUFMf09VAYz1RJ5DQleMNvsV0BaIn2X6JrliM
         kv2zYrt8PHr/oVlXwptZJrNDDlV7B3X2q+efp2qCuVsJTLOV9oXeCwyNENH555MbBDFi
         EivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706160542; x=1706765342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mB72gzBDyyMoSpJLQwvx7iM/246zvXStdgAa5oAjJU=;
        b=o0elctxiji9sprxmcLx0frPc0tgHu+/gbTtUlICTwIeDeBm3xz0UNYhmRjuD3Fy+1/
         Q1nS4lOnO7YV7acFQ5LcdObZOcBVdrNWFH87Mly2AHlREgGxr6B9Hp3PCpWEJgaCfPbQ
         AVqvvHQD/M0bnYPaeiSKP3yxUfEmjKNaEa+Diz61a+RvnGyTEMx3oCRocDK1lDvPrr6n
         1cQnN8IWfYK/GV/wG+QD9pyr1hy3MGgwcl6pGybOK8/QWTQ6ii6J9csL9mY/4MMwvImD
         s2GrVgyOYsyimjIVtLv/k61vDFl7IsXEAPP6WoTKfjnDvQgUGy6qHPP0sPokkioTfpK+
         fpZg==
X-Gm-Message-State: AOJu0YzyxnUkSbJiZMYNoBQ1r6AjiK9OCVhupbokhLL9sRdEXoUOc6Fz
	FIsIA9rsgXhZqYJRrTxwiUoKtrJd5a++KRBhFdEXPPMPUsZZpsM+dwIO7kVFSqLWN3g0CPExspJ
	IiNSHWnt4HLP+l914hiMbbmp47Y1qbNb9xj78
X-Google-Smtp-Source: AGHT+IGU7rlZHTBcMGgY8U3AiVPrAd0pz3BvId/to0cEC9znv583R2ez772KByWmujaXXVwQci+7kASiZiY9SRvv3rI=
X-Received: by 2002:a17:90a:f189:b0:290:fdcb:f310 with SMTP id
 bv9-20020a17090af18900b00290fdcbf310mr218996pjb.49.1706160541952; Wed, 24 Jan
 2024 21:29:01 -0800 (PST)
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
 <CAJD7tkaVdJ9B_UDQs+o1nLdbs62CeKgbCyEXbMdezaBgOruEWw@mail.gmail.com>
In-Reply-To: <CAJD7tkaVdJ9B_UDQs+o1nLdbs62CeKgbCyEXbMdezaBgOruEWw@mail.gmail.com>
From: Chris Li <chriscli@google.com>
Date: Wed, 24 Jan 2024 21:28:50 -0800
Message-ID: <CAF8kJuNkwGNw=Nnu1MVOewKiqT0ahj5DkKV_Z4VDqSpu+v=vmw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yosry,

On Tue, Jan 23, 2024 at 10:58=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>

> >
> > Thanks for the great analysis, I missed the swapoff/swapon race myself =
:)
> >
> > The first solution that came to mind for me was refcounting the zswap
> > tree with RCU with percpu-refcount, similar to how cgroup refs are
> > handled (init in zswap_swapon() and kill in zswap_swapoff()). I think
> > the percpu-refcount may be an overkill in terms of memory usage
> > though. I think we can still do our own refcounting with RCU, but it
> > may be more complicated.
>
> FWIW, I was able to reproduce the problem in a vm with the following
> kernel diff:

Thanks for the great find.

I was worry about the usage after free situation in this email:

https://lore.kernel.org/lkml/CAF8kJuOvOmn7wmKxoqpqSEk4gk63NtQG1Wc+Q0e9FZ9OF=
iUG6g@mail.gmail.com/

Glad you are able to find a reproducible case. That is one of the
reasons I change the free to invalidate entries in my xarray patch.

I think the swap_off code should remove the entry from the tree, just
wait for each zswap entry to drop to zero.  Then free it.

That way you shouldn't need to refcount the tree. The tree refcount is
effectively the combined refcount of all the zswap entries.
Having refcount on the tree would be very high contention.

Chris

> diff --git a/mm/zswap.c b/mm/zswap.c
> index 78df16d307aa8..6580a4be52a18 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -880,6 +880,9 @@ static enum lru_status shrink_memcg_cb(struct
> list_head *item, struct list_lru_o
>          */
>         spin_unlock(lock);
>
> +       pr_info("Sleeping in shrink_memcg_cb() before
> spin_lock(&tree->lock)\n");
> +       schedule_timeout_uninterruptible(msecs_to_jiffies(10 * 1000));
> +
>         /* Check for invalidate() race */
>         spin_lock(&tree->lock);
>         if (entry !=3D zswap_rb_search(&tree->rbroot, swpoffset))
>
> This basically expands the race window to 10 seconds. I have a
> reproducer script attached that utilizes the zswap shrinker (which
> makes this much easier to reproduce btw). The steps are as follows:
> - Compile the kernel with the above diff, and both ZRAM & KASAN enabled.
> - In one terminal, run zswap_wb_swapoff_race.sh.
> - In a different terminal, once the "Sleeping in shrink_memcg_cb()"
> message is logged, run "swapoff /dev/zram0".
> - In the first terminal, once the 10 seconds elapse, I get a UAF BUG
> from KASAN (log attached as well).

