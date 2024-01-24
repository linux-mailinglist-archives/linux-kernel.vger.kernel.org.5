Return-Path: <linux-kernel+bounces-36397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC6983A007
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A30E1C23D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34F95392;
	Wed, 24 Jan 2024 03:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zc2Jy78C"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33325C85
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706066458; cv=none; b=Cw8lA2+YfAsO8HpfnvCq+cWpSF4qd0qhUoEAuYvbfkse455DrXHj7KAJm368SRoa7gFAxwOWsj6ZVwerGK7l6yUxF5n19SkkKIKYYyjP+EQmnaau6F8JfAOwNbdK69kDFwOFr/Zdw5jjGxd64RIGY3ukL3HjpLUXAOkDZyxto6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706066458; c=relaxed/simple;
	bh=agwPmDihLYdvwGlc0JnDhON85wkS8jgIYwKErH9Z/K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDHKRoKbcWVLgEm660yhvug44ZlljWBUYQiD+5HKUqOFJaABpvtjUznvH2x8Wh76mQLusf3N34iApLzDesfNmHalkuMNLefwr4j6LCh4J4JSNvBTufkkUsh4tZvgxru7wLiKoaEYzUOX6bmFlPMOkmb1O0em4ZWd2YtXt0/0ZRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zc2Jy78C; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-337d05b8942so5726364f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706066455; x=1706671255; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KAePt3EbboVv3TxbwUCofAP8uUAMMkWJoXv+3X6ccPI=;
        b=Zc2Jy78CmFWDyplXwjE9OTxXZayfJSXj3ziERUK/5Ynrsr/crhWaNw+8DQ0g6OCzfy
         TKPmV/12vdstSItx8sNGQ8yPW+/0wd+lVcD5e7OqdLVKXEC3jBP3Dp5Y22Qv2ecoXn/Q
         8QqPvzpE2FXvHiRrj4jsMWa6j3aTI4wtmxS5GckmAwe2F2V/eoWTginhbzHKqhD+ypfj
         tApBjORg6YhdlxCE0l7JTCe/Uhe1lF4xbHmGaPssmqF2uOkWXoO7Ujwg/mSezc1ykfk7
         e+2DzQB0mq/ZC6aEmkMTPPTnV03juE2Ze5uHywkGhHRTmjjp8D+cADG7I3cmdP1sN9KJ
         mQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706066455; x=1706671255;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAePt3EbboVv3TxbwUCofAP8uUAMMkWJoXv+3X6ccPI=;
        b=fa3kxteRQ3u8jhkwHg1hVuUKecqLS/WMq2lXtk2sYsecMi2QwzfA+hFlhXt6xOx/XL
         +kk8cHuWTosRccLkIMI9C6YmcJ3lTLESm4Wo1DFKqQex90FKGjX3UQC1H3ZlDyqWHdtG
         AcGvn3CcCPNJ6pqL3rauejJqqLgMj7rXFFov1/QB2SQiiOFCJCl1AFtPk+6C81U8VAoU
         kJISROLX75/T8V3Om7TDV5qn2hrK3E7mLj6N+AN5+oRJ/Q318IatPzKmWKniY0VewSAD
         QZWCq6Ft1+PgmvByf/OIOVeKwgk7sl9KwWpd6ZYXM73+kdznZLPmMIvuj89YnphYsmr0
         6Ppg==
X-Gm-Message-State: AOJu0YxzrCAFwxc5FAwPJhPWIt/VQ7iM1ElzrQYbVXSUP8D8xmYZEjUb
	MTnWOSWlVGA89ukgp30Dj32g1au2V7slJp4b315dAQaWWu9qMkotcFTGZCYsvx9hkraCLhfkxPu
	WtiDnPpFgATGulMf8/ziYB2prAmEw8xLTFuc+
X-Google-Smtp-Source: AGHT+IG52SOXahv8KuKJM5amdkEJrHh+itGyuLplJrEk2YxxxRBnMyB3thEL7drxZ7rWTHHm76P8VMONmx+BrYEP4UE=
X-Received: by 2002:a5d:448a:0:b0:337:c6b6:7e30 with SMTP id
 j10-20020a5d448a000000b00337c6b67e30mr124733wrq.36.1706066454776; Tue, 23 Jan
 2024 19:20:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-2-yosryahmed@google.com> <87wms0toh4.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAJD7tkb=-0mP1CXEmAd4QjMXKgep7myHShiwUSNnY1cjfRqfJA@mail.gmail.com> <878r4ftodl.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <878r4ftodl.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 23 Jan 2024 19:20:17 -0800
Message-ID: <CAJD7tkbKxfuy-uWrOMVnOeDpx-TuJwosxk2jG_0Gx4bi1tUBog@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: swap: update inuse_pages after all cleanups are done
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > In swap_range_free, we want to make sure that the write to
> > si->inuse_pages in swap_range_free() happens *after* the cleanups
> > (specifically zswap_invalidate() in this case).
> > In swap_off, we want to make sure that the cleanups following
> > try_to_unuse() (e.g. zswap_swapoff) happen *after* reading
> > si->inuse_pages == 0 in try_to_unuse().
> >
> > So I think we want smp_wmb() in swap_range_free() and smp_mb() in
> > try_to_unuse(). Does the below look correct to you?
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 2fedb148b9404..a2fa2f65a8ddd 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -750,6 +750,12 @@ static void swap_range_free(struct
> > swap_info_struct *si, unsigned long offset,
> >                 offset++;
> >         }
> >         clear_shadow_from_swap_cache(si->type, begin, end);
> > +
> > +       /*
> > +        * Make sure that try_to_unuse() observes si->inuse_pages reaching 0
> > +        * only after the above cleanups are done.
> > +        */
> > +       smp_wmb();
> >         atomic_long_add(nr_entries, &nr_swap_pages);
> >         WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
> >  }
> > @@ -2130,6 +2136,11 @@ static int try_to_unuse(unsigned int type)
> >                 return -EINTR;
> >         }
> >
> > +       /*
> > +        * Make sure that further cleanups after try_to_unuse() returns happen
> > +        * after swap_range_free() reduces si->inuse_pages to 0.
> > +        */
> > +       smp_mb();
> >         return 0;
> >  }
>
> We need to take care of "si->inuse_pages" checking at the beginning of
> try_to_unuse() too.  Otherwise, it looks good to me.

Hmm, why isn't one barrier at the end of the function enough? I think
all we need is that before we return from try_to_unuse(), all the
cleanups in swap_range_free() are taken care of, which the barrier at
the end should be doing. We just want instructions after
try_to_unuse() to not get re-ordered before si->inuse_pages is read as
0, right?

>
> > Alternatively, we may just hold the spinlock in try_to_unuse() when we
> > check si->inuse_pages at the end. This will also ensure that any calls
> > to swap_range_free() have completed. Let me know what you prefer.
>
> Personally, I prefer memory barriers here.

Ack.

