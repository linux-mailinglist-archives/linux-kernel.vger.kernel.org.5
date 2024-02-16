Return-Path: <linux-kernel+bounces-69272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C09858679
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657DB1C21005
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46899137C4E;
	Fri, 16 Feb 2024 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dOExT7Gh"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7B0135A62
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708113716; cv=none; b=isEgENpT1jmhM1jthgFILpUiGPGJUSWm9QZdM5A5W+rYGlzjjWsulFBxOws3zZ/KQ0xDQ9K6ZdCCwNztRG+0LnZr7Qs2XKWX/A+/W7G0MCFOs+OhZ6MzWoUXs9DKEixSxAe17+q2hJ5mqWX/CzdnhLOQhx5fkU14KETm4Oyv8Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708113716; c=relaxed/simple;
	bh=NuyAjhXJza4q0jRrAdQBVNUOFB0Q3GISFLDj6J9JQHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M3/Llo2daHptOGl0mpwPsVhaU42k7H2aeijzxunl8Y2xJcXB+1y6CjJBVBw/RSzi488rUXO6FT9kZY43Y6DUgU96QQjlA5zEbhjRvVSdk0QwBH3hWGxZjlqsv0ySU/KOJfpKnswqPxLA+K2qi1xNfkDuiHc5RJL8mEfi7WvNSUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dOExT7Gh; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so5261039276.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708113714; x=1708718514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hnC1Wqu1hjzO44T2i0P4fr+YtBb6/PxLiNAZpb948xQ=;
        b=dOExT7GhJzeTmIik1aKj1ZwA/he4l/GYUS8mvocVlOoOQS4qYrTuY2zNH/aniNE4sV
         0fIw88UltgPRCxzgBjWwDv7riekqZzIhGd4ePw2u72LEQ+wdnSYo5HXMsKGjrEsYnhMt
         6785oyrINHNAhVKnA1TEDQtDiXRidj+Qzlg9DNni67ba/h/xX06RobHKt6k1mgOn/brw
         NoZnLQOKO3SQbXDlk+nV1yBoPfPM7oH0eiL3KbievHnAmHyxJf/TWfecz2PX+lnQ5MKO
         OtA5JdNwZINAFuoLaKqzK5x5XFyWUktR+uM1ApQ5JxR1jEKt1aagEM9uqyHsVxNcgxIp
         7T7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708113714; x=1708718514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnC1Wqu1hjzO44T2i0P4fr+YtBb6/PxLiNAZpb948xQ=;
        b=KeDP1+DkpwaQpSuflwuhFL79KA0UmtXdUkbKJBnG5qHMEfuyobm39pFKqopvOYPzJC
         rjFhWBeB1BzljINYEWgX9nBlmbQID/6oCfuQlqjAek6F9ZaMiNeGgxlGXLORiqK9TBM0
         0V4dUQ+U5F7APpFPYEnE4VJF1E4nALvETP1rl1Wbc24CVj39CZ4BWAvVj9lZ9hlUv5K2
         LFpnRgnHT5cGjMfwYXqKXy56dS74ymNEyt5K7f3AnlopvCR/1af0Jp10gIGWMJgWdVdc
         DDumDaSJgbqi5VE0lQiZQCyNtyKCiYogLFfARDzkkrXQEeQyIvT3PC7tw9PX3hDAvdMf
         PLAA==
X-Forwarded-Encrypted: i=1; AJvYcCWLj3jkfdZ0i0oeHK7N7Y7uSSaUC5Me9IV/B4QMugsL3esfb5OI+tYr0GBawS33UoSDBoA3ZGH/VRnmGkE71YDlPLfydRUwzqA+9A6T
X-Gm-Message-State: AOJu0YwknlpqLY01l34AxuvyRYyLU2dZlvFnXCng+AX44mRN2IDoCzmq
	321tLP68G104l4bcOHL+svganN5G8VW7KBicYMnGHgqYP+vhVf0ovf/Ezo+65RxKxdq/WM4lvjt
	HytxOH00+ynyG7luGuw==
X-Google-Smtp-Source: AGHT+IFsCdaVZr8ZBA4nJqkvY7/NE5G/bJ2OgSA7Qdq0i5ahbMzq/UWaYnaW84Y6C8WrjD7VtzJgJ7eIeU2LSu+N
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1105:b0:dc6:d678:371d with
 SMTP id o5-20020a056902110500b00dc6d678371dmr1411009ybu.3.1708113713690; Fri,
 16 Feb 2024 12:01:53 -0800 (PST)
Date: Fri, 16 Feb 2024 20:01:51 +0000
In-Reply-To: <CAGsJ_4zSDP_A32jUPrYPwZ=uwU4o0a6x-GW2HO3vu8yUh0qYjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240216030539.110404-1-21cnbao@gmail.com> <Zc8bjZFZAZneObQG@google.com>
 <b717ae0c-ed4f-4ebc-90cf-51a8da0a6583@bytedance.com> <CAGsJ_4zSDP_A32jUPrYPwZ=uwU4o0a6x-GW2HO3vu8yUh0qYjA@mail.gmail.com>
Message-ID: <Zc-_L70_b6Dw1BQa@google.com>
Subject: Re: [PATCH] mm: zswap: increase reject_compress_poor but not
 reject_compress_fail if compression returns ENOSPC
From: Yosry Ahmed <yosryahmed@google.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Nhat Pham <nphamcs@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="us-ascii"

> > >> diff --git a/mm/zswap.c b/mm/zswap.c
> > >> index 6319d2281020..9a21dbe8c056 100644
> > >> --- a/mm/zswap.c
> > >> +++ b/mm/zswap.c
> > >> @@ -1627,7 +1627,10 @@ bool zswap_store(struct folio *folio)
> > >>      dlen = acomp_ctx->req->dlen;
> > >>
> > >>      if (ret) {
> > >> -            zswap_reject_compress_fail++;
> > >> +            if (ret == -ENOSPC)
> > >> +                    zswap_reject_compress_poor++;
> > >> +            else
> > >> +                    zswap_reject_compress_fail++;
> > >
> > > With this diff, we have four locations in zswap_store() where we
> > > increment zswap_reject_compress_{poor/fail}.
> > >
> > > How about the following instead?A
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index 62fe307521c93..3a7e8ba7f6116 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -1059,24 +1059,16 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
> > >        */
> > >       ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
> > >       dlen = acomp_ctx->req->dlen;
> > > -     if (ret) {
> > > -             zswap_reject_compress_fail++;
> > > +     if (ret)
> > >               goto unlock;
> > > -     }
> > >
> > >       zpool = zswap_find_zpool(entry);
> > >       gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
> > >       if (zpool_malloc_support_movable(zpool))
> > >               gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
> > >       ret = zpool_malloc(zpool, dlen, gfp, &handle);
> > > -     if (ret == -ENOSPC) {
> > > -             zswap_reject_compress_poor++;
> > > -             goto unlock;
> > > -     }
> > > -     if (ret) {
> > > -             zswap_reject_alloc_fail++;
> > > +     if (ret)
> > >               goto unlock;
> > > -     }
> > >
> > >       buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
> > >       memcpy(buf, dst, dlen);
> > > @@ -1086,6 +1078,10 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
> > >       entry->length = dlen;
> > >
> > >  unlock:
> > > +     if (ret == -ENOSPC)
> > > +             zswap_reject_compress_poor++;
> > > +     else if (ret)
> > > +             zswap_reject_alloc_fail++;
> >
> > Here have two cases: zswap_reject_compress_fail, zswap_reject_alloc_fail.

Ah brain fart, sorry.

> 
> Is it safe to differentiate these two cases by checking ret == -ENOMEM ?
> otherwise, it seems the original patch still makes more sense?

I don't think it is in all cases, some allocators return other error
codes. It seems unlikely that we'll get any of them, but it can be
missed in the future. How about we use different return codes to
differentiate failures, and still centralize the counters handling.

Something like the following (ideally that one is not a brain fart):

diff --git a/mm/zswap.c b/mm/zswap.c
index 62fe307521c93..20ba25b7601a7 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1021,12 +1021,12 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 {
 	struct crypto_acomp_ctx *acomp_ctx;
 	struct scatterlist input, output;
+	int comp_ret = 0, alloc_ret = 0;
 	unsigned int dlen = PAGE_SIZE;
 	unsigned long handle;
 	struct zpool *zpool;
 	char *buf;
 	gfp_t gfp;
-	int ret;
 	u8 *dst;

 	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
@@ -1057,26 +1057,18 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 	 * but in different threads running on different cpu, we have different
 	 * acomp instance, so multiple threads can do (de)compression in parallel.
 	 */
-	ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
+	comp_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
 	dlen = acomp_ctx->req->dlen;
-	if (ret) {
-		zswap_reject_compress_fail++;
+	if (comp_ret)
 		goto unlock;
-	}

 	zpool = zswap_find_zpool(entry);
 	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
 	if (zpool_malloc_support_movable(zpool))
 		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
-	ret = zpool_malloc(zpool, dlen, gfp, &handle);
-	if (ret == -ENOSPC) {
-		zswap_reject_compress_poor++;
-		goto unlock;
-	}
-	if (ret) {
-		zswap_reject_alloc_fail++;
+	alloc_ret = zpool_malloc(zpool, dlen, gfp, &handle);
+	if (alloc_ret)
 		goto unlock;
-	}

 	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
 	memcpy(buf, dst, dlen);
@@ -1086,6 +1078,13 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 	entry->length = dlen;

 unlock:
+	if (comp_ret == -ENOSPC || alloc_ret == -ENOSPC)
+		zswap_reject_compress_poor++;
+	else if (comp_ret)
+		zswap_reject_compress_fail++;
+	else if (alloc_ret)
+		zswap_reject_alloc_fail++;
+
 	mutex_unlock(&acomp_ctx->mutex);
 	return ret == 0;
 }

> 
> >
> > >       mutex_unlock(&acomp_ctx->mutex);
> > >       return ret == 0;
> > >  }
> > >
> > >>              goto put_dstmem;
> > >>      }
> > >>
> > >> --
> > >> 2.34.1
> > >>
> 
> Thanks
> Barry

