Return-Path: <linux-kernel+bounces-38110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDAC83BB09
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2781F2699A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A67E17593;
	Thu, 25 Jan 2024 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ojo9RQ+N"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7861758B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169277; cv=none; b=OhqR1Xo3/n9ysWDV7NPhHr4HHjRa24YptszZfhsYTEOQQuNKOmBd++Ce6gAd9P/gACLeVPbR3ZaB23CPD37kKpBxHJMuvNYgU8uITVV7GW5pHuv2io5jCL4pugbCHJ5Glg97iTdc0Udz0BfkrHLDRtUCPl5zVr8DsNLZkBrhcBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169277; c=relaxed/simple;
	bh=OTlI1L9zjwJc4w+ZT/ak5VEN8mlf08a8t/2VQhZgzlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luu+qy/4mV1bKA0cnX+1Ahm6XBD2BMFB1N69q8krkTtev2MfvRiHR/xB8244n1kb9SQkC5tQ/q/FdmDnSx3SRnaV2dekKXKBuIoJMm0cAon6axORfDWiBIelbpfWwimVhRkLGoxGkT0B3/G5gJXWfl9YH6keRnejDA4ZPL2RESY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ojo9RQ+N; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so5781309a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 23:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706169274; x=1706774074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OTlI1L9zjwJc4w+ZT/ak5VEN8mlf08a8t/2VQhZgzlU=;
        b=ojo9RQ+N4tcKw89uoTZqx6BLb8xHhejHSTaaSOLhKI6idqdw9xxxb3rVDRKpovxZRD
         lq+h0qn/RnDST2HI/3EQiQxOtJpHIDltIGTRLaL+sUAND4lzBar1UGBIhWXcBT65uX8H
         U4IfxmRnYTDLnBENMJPq2w3cUV4ztG7LI9eQwUwCDZLAsK7CXbrG35eM6gHvUQRedkZk
         XM9M0YWouV3N3sKfAvMtvBdmjEtKMeo1z2VRdJcHHjEGTpyQTyOP/thXXI2wHAmirUgc
         E7BV8IKyt6fLz0k7RM0VqgREgXBrEu/7Q3yJUfSlNXGX+VcUPRZy/cTtm1GSoKXfwuRX
         Xlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706169274; x=1706774074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTlI1L9zjwJc4w+ZT/ak5VEN8mlf08a8t/2VQhZgzlU=;
        b=FRCmbzOtkOVq2D8msp9mUUVyuQ4J70aKkewh1AFU7mlImdzY1Ah7yhI9sJmIUV/+vz
         G0V0m1hOKNctAc37dnt9GbNg3gU6NiZWSk5iEuwOY8jZyCaNXy7UpaNwP0PiAhBCp9ah
         wDFAdSGZ3rWHNlizK+pJZ3uJES3JYMZGtBtpQO9tW4gihJvtldwJ25WNWstnDo7SN2MO
         xhYTMO0PECtFo5aAcRTLa5QmpLizODfJ0DyPiGN1idqvRmsuxbXhNfW+TdWZvWJnguuG
         oq3T4aOoMBQcpQ4UclFraW1cAexG6uqsDiM/3l40iA69MRmGsC00zKSQ4p9iSCU/YJyX
         frDg==
X-Gm-Message-State: AOJu0Yz6RlbK91IfS2DzffLaFrk7hR/sy1C5Lb9NSbQSBiL0GJo0rI0s
	eF24NESO2CoWo8IbjS9GkOXhDXNGbdj5B2BppolSIiS2sFd1SjWWWPaJJHA/79p27+KGpOBHzLe
	Y3I1Sz7AToxAcz4v4H5shskl94Mg/6kFQ2AFf
X-Google-Smtp-Source: AGHT+IHGsYUG/xmrj077kIPkVc4N006GE5jLsMFSZAJ8/OVovj5aS5vWBD1f/drx/kDCcyfmmYtVKT26uupvFMAYejo=
X-Received: by 2002:a17:907:c28b:b0:a31:1cf8:404f with SMTP id
 tk11-20020a170907c28b00b00a311cf8404fmr281591ejc.94.1706169274045; Wed, 24
 Jan 2024 23:54:34 -0800 (PST)
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
 <f3fa799f-1815-4cfe-abc8-3ba929fcd1ba@bytedance.com>
In-Reply-To: <f3fa799f-1815-4cfe-abc8-3ba929fcd1ba@bytedance.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 24 Jan 2024 23:53:55 -0800
Message-ID: <CAJD7tka6UuEuuP=df-1V3vwsi0T0QhLORTRDs6qDvA81iY6SGA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, Huang Ying <ying.huang@intel.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Hello,
>
> I also thought about this problem for some time, maybe something like below
> can be changed to fix it? It's likely I missed something, just some thoughts.
>
> IMHO, the problem is caused by the different way in which we use zswap entry
> in the writeback, that should be much like zswap_load().
>
> The zswap_load() comes in with the folio locked in swap cache, so it has
> stable zswap tree to search and lock... But in writeback case, we don't,
> shrink_memcg_cb() comes in with only a zswap entry with lru list lock held,
> then release lru lock to get tree lock, which maybe freed already.
>
> So we should change here, we read swpentry from entry with lru list lock held,
> then release lru lock, to try to lock corresponding folio in swap cache,
> if we success, the following things is much the same like zswap_load().
> We can get tree lock, to recheck the invalidate race, if no race happened,
> we can make sure the entry is still right and get refcount of it, then
> release the tree lock.

Hmm I think you may be onto something here. Moving the swap cache
allocation ahead before referencing the tree should give us the same
guarantees as zswap_load() indeed. We can also consolidate the
invalidate race checks (right now we have one in shrink_memcg_cb() and
another one inside zswap_writeback_entry()).

We will have to be careful about the error handling path to make sure
we delete the folio from the swap cache only after we know the tree
won't be referenced anymore. Anyway, I think this can work.

On a separate note, I think there is a bug in zswap_writeback_entry()
when we delete a folio from the swap cache. I think we are missing a
folio_unlock() there.

>
> The main differences between this writeback with zswap_load() is the handling
> of lru entry and the tree lifetime. The whole zswap_load() function has the
> stable reference of zswap tree, but it's not for shrink_memcg_cb() bottom half
> after __swap_writepage() since we unlock the folio after that. So we can't
> reference the tree after that.
>
> This problem is easy to fix, we can zswap_invalidate_entry(tree, entry) early
> in tree lock, since thereafter writeback can't fail. BTW, I think we should
> also zswap_invalidate_entry() early in zswap_load() and only support the
> zswap_exclusive_loads_enabled mode, but that's another topic.

zswap_invalidate_entry() actually doesn't seem to be using the tree at all.

>
> The second difference is the handling of lru entry, which is easy that we
> just zswap_lru_del() in tree lock.

Why do we need zswap_lru_del() at all? We should have already isolated
the entry at that point IIUC.

