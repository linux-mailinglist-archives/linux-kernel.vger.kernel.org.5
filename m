Return-Path: <linux-kernel+bounces-39448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2DD83D14B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4CA2B282F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5B61C05;
	Fri, 26 Jan 2024 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sEiRY5xT"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348741385
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227571; cv=none; b=bFdQypt3YB/wDxis7wANKqZn0662HGPzXYRcXWFM2k798qojXUNyIH0RpkXLXjzuwgpp6viRs5/3ujJydBlctpOuOrloPz4SA9bUFXGb/7gGvufcVxxldb5MKQhwG6GIsb8r88f960F5m1X+LEJ9Ft6QQ2SpYHqOkhjMcrMNJE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227571; c=relaxed/simple;
	bh=CTaBfPMAh5RInl2XuFIpRflJuilb7lxx/hmHalIIO+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhfL35Ypu99ibdqQyxkuTvPVseKRhjhkV99s0PttJItlBYL9NXCfOHGpx73MT7JK/8G40wiyQR8OVYQYFebfLnbTfULBagbrw6TOpp5aX/IjWdG2duYOEUvG5lMm2KGHOYoFcut6SwTBfF3HmTPBsRArBum3w8cX1YksmEr2k0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sEiRY5xT; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a6833c21eso5729037a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706227567; x=1706832367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTaBfPMAh5RInl2XuFIpRflJuilb7lxx/hmHalIIO+Q=;
        b=sEiRY5xT5vt8rL93jNiE1Fl0soUwELLdvj1kYYI1XwHRPyXa7oplPYLBX4e9lVz+ch
         /cVt7E4rDGR0gwI57Ml7ndS9t7DjY/TRfPv9IjMSltpYiq7D71ZrXEgaG/jCogYeQjku
         m14ORQCcfd0VASstrbKT/ncYpS6XbcS23jQY/Ei9tVmPPnteRwscqx2YmG/u3uSnwQyl
         /m/BLSqwYdlurb+khe/x1/svvuOQra5XcZye2O0iyf1wx/d8SqSKE2qv7STrWPCOVGO9
         lBBZdge3ah3s2s752ICTbyKr/+7IfqHbeAOXsPVPDgfmPLRK+9n7bIhL/g2O+5l7NxaF
         WdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706227567; x=1706832367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTaBfPMAh5RInl2XuFIpRflJuilb7lxx/hmHalIIO+Q=;
        b=vRyt5KUNwDTilqV5X0Fxrf02WyQ21YeazUt1EDeo560PBkzplznSWa9sP/7Y/pDYZT
         nQzlhligwQ8AyFUdC0illH1l1u8gsfSA9JJhGneQWsea9JgJTww04pjchluEs73k2Bmv
         FfDWuPAb9J2kX+27ht7TI1X/Gw+wtp0mrevgHr7JJXwBL3dlkvltEiAxOxE5m9CstQYa
         IxO/W4wKFBMLzYGpoxV+4L2fDg+gdZD4I+gGIBWIQeiCu57b/BkoRkJLfDJ+4Usvi3O+
         VCc0f0Xkjh1/hS6lkc70Q5G8JPPXxk2tzl4sHc/tcEVdnrZPhp3TLQSlfevlBoh6cRKp
         hENg==
X-Gm-Message-State: AOJu0YwWsAndquJKmYY7XxUE6NMqJzF8L1oNpqk+RM38K6D/Wp5vqeFl
	t+ElTykMFytybaps7PsAVxlXsHtyhPApq+vc4am/tluVsxqAHBbRfPlqDVb6Z+JB9xWgcYLUN6F
	dbPrE1Bf6OLJeSNL6ecYIP+l+lTiwKfN16sD8
X-Google-Smtp-Source: AGHT+IEqiV//nfkl3hULWrkNSJjo2+J0TL1+ln3XDwZNwNn1bP2F95OOCQ/HSLyXacNqGl88q12Tj1CuNNsviW125uM=
X-Received: by 2002:a17:906:f1d0:b0:a2f:e46c:f124 with SMTP id
 gx16-20020a170906f1d000b00a2fe46cf124mr188939ejb.54.1706227567062; Thu, 25
 Jan 2024 16:06:07 -0800 (PST)
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
 <f7379622-4081-4424-9353-289257cf8555@bytedance.com>
In-Reply-To: <f7379622-4081-4424-9353-289257cf8555@bytedance.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 25 Jan 2024 16:05:28 -0800
Message-ID: <CAJD7tkaMexNwGHq4G4FjNoWs9_wapY-kttm66Bb9xHF=OReYKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, Huang Ying <ying.huang@intel.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 4:03=E2=80=AFPM Chengming Zhou
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
> >
> > We will have to be careful about the error handling path to make sure
> > we delete the folio from the swap cache only after we know the tree
> > won't be referenced anymore. Anyway, I think this can work.
> >
> > On a separate note, I think there is a bug in zswap_writeback_entry()
> > when we delete a folio from the swap cache. I think we are missing a
> > folio_unlock() there.
> >
>
> Hi, want to know if you are preparing the fix patch, I would just wait to
> review if you are. Or I can work on it if you are busy with other thing.

If you're talking about implementing your solution, I was assuming you
were going to send a patch out (and hoping others would chime in in
case I missed something).

I can take a stab at implementing it if you prefer that, just let me know.

