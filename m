Return-Path: <linux-kernel+bounces-38127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F61483BB34
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3901F2134C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB410179BD;
	Thu, 25 Jan 2024 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ot/b39Vo"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40C817993
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169730; cv=none; b=PXKZPtoUY7bl1TbuMSluYfvajYCfZ7b8AGDz8qwLxyAHpop1bOuwok6WTEQLfvF6G0RxoitE7g/Uke9xa7cM7hFc8IvXsvnhHS93qtfh/ATF7nfZlZdkGtnsB0IkepIB/EvmfYKD8OPhyrlhr9Y5fj7nUW0U3FVZQqpnrGP3CRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169730; c=relaxed/simple;
	bh=PYtWgD4rvDQmrq3lWJUNa9UCsY8pPiBym7BtIKU0F8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbOYsM3MMD6e3GBuw5oT6R3cYeVLHPBL58XQCqAobi14ZoBGGhwj1/2+nyYqVveZxLXpAgdXra6nUYfLdxjKo8s7cW+FGK/RsDAbNeT/TclBIdT85OBGVoLKZ5DcugVLDuo9F+Q7AlmQjMkjZgaLlc9dHDY+Q2UTqVGz5VFu08o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ot/b39Vo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so7217831a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706169727; x=1706774527; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tJTE/yuT8MZrw97UqmztbZ7ZEAwNhGQRB7tydgxKimQ=;
        b=Ot/b39VoDMvbItvR6fBvBEhjmtxka1H0kINJDmNXDzrjsNCWDPXkRTV0iFPCz1n8Hs
         liVs34t/7/NL60COBNFFbanY+Wg3rIkh+ZGK/mLlzgaXcRRSDC9S3+xlIbSQ8+m0kBs6
         23cXbcVLhcZC0lu2WCDOJbcFsd9zGcTcKcH+5FS9YFn0b2qm41LRRUZwZgrheaIvIIKl
         HeKbv502LsuH5BgcUXhPOU1dWF0RZ6DNOqCV6PBvLSKnzbfro5b/MbDpoOgT6MCwJDjL
         Bnt3yONGX//RL71M6WyKgAzpN5Ij7d190IhBCyFMkRHeGZCAINnrWKG2KTB7xipT6wvC
         qjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706169727; x=1706774527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJTE/yuT8MZrw97UqmztbZ7ZEAwNhGQRB7tydgxKimQ=;
        b=GwWp2TAmNgK6SD9iaFaMk3kXkqj87SffzQwIdg3NZ1nC//cS/yIK1parQt/zgIGXiR
         4E6co9Kz2c7ClNE8JaOFdJYY3DjB5eKSPGPnJ5Qrszfg+UPFMcO5QfMVod3F3/EMxn+o
         2J35fqp2CnpY/my7JQtzjqv+jywoP2SSh92K30J45RYsCo0cGMeWZEIUQfiuxcg0X+rr
         jxpN0MwI5QhaJo5cd46p+Frh97aB9IzRJXwrFPoQ6N50JRUPRHkGHtmrMw6Lm0im7AQD
         Ik4/fLByhQAKiO3pQmstkuFI59XAhYALB906QeO4D/wo7U6iC7Rl+t+nA5yn+6JD1iwl
         xIFw==
X-Gm-Message-State: AOJu0YwSurbmjzP6UUmB1DFdRbpGKJpRktnLHwSQ9wLltvJ6zJHoaV/g
	oUF7E61ze28suUT60aZRU2x4e2zE6eK3+bnl62p4yqzwa5/47tQNGqtAGvCC3ErMYVxu+WoQ99b
	DoOkFsyIXT8AG15qQaml3lxXPdri5p7iEo+He
X-Google-Smtp-Source: AGHT+IFBxEgqElI9XgzvYcwbchTYtJajHZzzzhYy+npFIa4ZNL6M1S+Q5fJHGPX9DWrIfrJiH6wW/v8WtLmcLWnRJaY=
X-Received: by 2002:a17:907:9686:b0:a31:630a:2053 with SMTP id
 hd6-20020a170907968600b00a31630a2053mr332390ejc.69.1706169726809; Thu, 25 Jan
 2024 00:02:06 -0800 (PST)
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
 <f3fa799f-1815-4cfe-abc8-3ba929fcd1ba@bytedance.com> <CAF8kJuOv0FHsHgp=i7ZzjTpvZ7fN8uOQ3DT=8Q2eYWzRM7Hsgw@mail.gmail.com>
In-Reply-To: <CAF8kJuOv0FHsHgp=i7ZzjTpvZ7fN8uOQ3DT=8Q2eYWzRM7Hsgw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 25 Jan 2024 00:01:30 -0800
Message-ID: <CAJD7tkY=qy+dfKacFOBx4uW6hDJwf20ODBgVWRP919hEY5URnQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Chris Li <chrisl@kernel.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > // lru list lock held
> > shrink_memcg_cb()
> >   swpentry = entry->swpentry
> >   // Don't isolate entry from lru list here, just use list_lru_putback()
> >   spin_unlock(lru list lock)
> >
> >   folio = __read_swap_cache_async(swpentry)
> >   if (!folio)
> >     return
> >
> >   if (!folio_was_allocated)
> >     folio_put(folio)
> >     return
> >
> >   // folio is locked, swapcache is secured against swapoff
> >   tree = get tree from swpentry
> >   spin_lock(&tree->lock)
>
> That will not work well with zswap to xarray change. We want to remove
> the tree lock and only use the xarray lock.
> The lookup should just hold xarray RCU read lock and return the entry
> with ref count increased.

In this path, we also invalidate the zswap entry, which would require
holding the xarray lock anyway.

