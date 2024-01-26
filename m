Return-Path: <linux-kernel+bounces-40467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B9783E0F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7E4CB23915
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E32A208D4;
	Fri, 26 Jan 2024 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjBadUjo"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29804208A0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706292115; cv=none; b=PTC4GwDAZJYnmNpXkCaav91PvXGHINU+CeKxvhU4A1jAbBfXnB0AVoXq51hld3EK8pi6JYJn0DncBew1CRf3GBHmVtbpX0vrK4zqrpWm78bL3CwoxON+R89KPeeGX8RmWVansvdYMZMPjRbP8eK/wOjekOLNC+699VMU4MOyr9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706292115; c=relaxed/simple;
	bh=F5YzQnUucQZ6fzAnf3y//JkzF0b0m/3coQMZQsPpeRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyjVWPro7OGbegBbwAEP40cdSDvv+04vSRieOhXsaM+cQypRrvRzugno6hdPh6OPfT0DxrmT/E0RtCwfGpbp5OAbKvT75zWGkJ8kdgyAcpyxC9HcximiN6KqSVLo95l7EefYsKc2WtqY1sU+kI3cJMyn8gy5/BMdqt9qUE3sPD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjBadUjo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d71e24845aso5898985ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706292113; x=1706896913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fx/oG5PXDH7ISrPE2BoXtmDPEKGIaT38k7FxJNHTTk=;
        b=mjBadUjoGmrvazxyPWK1UwbFlfHHa1f49rN/GATGtXmockavk1BBZbSw4A/mTgl/tu
         OYHsvbrfH2AleiJBeMKbDIxP270P2BIEEXxz0nYbX40Hq3x8PuMxfU6tBvy7wBqAk7J4
         QcSIKAcDsV2oTrKzj2QUN2Ez3yKKNngXEbulcHynE365LZ6lNSeqUkD1Nt4rle4yuWQT
         ATLMLJovAEG1IYoyH93Y9SIyvBWZGYMs7Yep2hHZfTTGviY7BYcSlrTSwRd1b90/kBnq
         U/5sXZXeDTXDYdedDmNCrvMsKjsDq2uXc5Gfq9xyojxrXaGlqXMRXTVeMgo7E/x3Z9At
         OqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706292113; x=1706896913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fx/oG5PXDH7ISrPE2BoXtmDPEKGIaT38k7FxJNHTTk=;
        b=v8GLZ3TjYOEPl72uw5FVNWz4/OK6OGwkXbDdiaimNBPsX1qaHkUH1hgNT4j8Shawaq
         0heniQKcxIYY8jDchZhdSR8XLGxsDWgJIwIt0k+o+oR5P7hovA+jnfn7vfAHxvTEVPpe
         FDAQ0mnT5PWXMm86mYR0x7nwNPVJUFlfiLgdFR3r66hW5H0zpw3zni2UjlncP9E/t2JB
         iKc5kmO5pDiekgoT0Uo7/m9XbHXylJk/VvaOjI/YEkUJ1YtyE49zo2TZKGRGqeQIWIan
         t5COrDMk68IB6gZvOpSFuZtnAYmT1BWI6aNjluQ38sWo9c65rIKR+9GyIOWvIxJA+Agf
         U5gA==
X-Gm-Message-State: AOJu0YxveS654VA6ckxL7IpTyvipO+VrePIZV//clGSz8hbCj3yyqAkM
	BAWZ/+iT5b5Sey6bExpgr76K6c37OmmY5H44ZEeH9DB8QkZD5FK4/yDyN5HT9XjjXcOrQ4JFDYX
	AtGhNnTen0nwG1+4Fje9QAcx1egs=
X-Google-Smtp-Source: AGHT+IFjCbe5A5wnFIhoOUN+JJ65PwA2PjTQ/M7wh3gWE7z/aEt7Zp7h6MVeMyekVcw9217nrjr12bvWsVpFjVoC7/Q=
X-Received: by 2002:a17:903:192:b0:1d8:aef6:15c4 with SMTP id
 z18-20020a170903019200b001d8aef615c4mr29913plg.13.1706292113140; Fri, 26 Jan
 2024 10:01:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126083015.3557006-1-chengming.zhou@linux.dev>
In-Reply-To: <20240126083015.3557006-1-chengming.zhou@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 26 Jan 2024 10:01:41 -0800
Message-ID: <CAKEwX=NzDY57n6ogx6=VaaEx8j_Jtvz5BeuMDAW-KuDXmsyQFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/zswap: don't return LRU_SKIP if we have dropped
 lru lock
To: chengming.zhou@linux.dev
Cc: hannes@cmpxchg.org, yosryahmed@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 12:31=E2=80=AFAM <chengming.zhou@linux.dev> wrote:
>
> From: Chengming Zhou <zhouchengming@bytedance.com>
>
> LRU_SKIP can only be returned if we don't ever dropped lru lock, or
> we need to return LRU_RETRY to restart from the head of lru list.

Ooops. You're right! I just double checked and only LRU_REMOVED_RETRY
and LRU_RETRY indicate we might have dropped the lock. My bad.

>
> Actually we may need to introduce another LRU_STOP to really terminate
> the ongoing shrinking scan process, when we encounter a warm page

Yup. This is what I was trying (and failing) to do. To be honest, this
needs to be even stronger: short-circuit ALL concurrent/ongoing zswap
shrinker scan processes that are touching this memcg (as they will
also shrink into warmer regions going forward). But that's a bit more
engineering to do. LRU_STOP, which stops this scan process, would be a
good place to start.

> already in the swap cache. The current list_lru implementation
> doesn't have this function to early break from __list_lru_walk_one.
>
> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

> ---
>  mm/zswap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 00e90b9b5417..81cb3790e0dd 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -901,10 +901,8 @@ static enum lru_status shrink_memcg_cb(struct list_h=
ead *item, struct list_lru_o
>                  * into the warmer region. We should terminate shrinking =
(if we're in the dynamic
>                  * shrinker context).
>                  */
> -               if (writeback_result =3D=3D -EEXIST && encountered_page_i=
n_swapcache) {
> -                       ret =3D LRU_SKIP;
> +               if (writeback_result =3D=3D -EEXIST && encountered_page_i=
n_swapcache)
>                         *encountered_page_in_swapcache =3D true;
> -               }
>
>                 goto put_unlock;
>         }
> --
> 2.40.1
>

