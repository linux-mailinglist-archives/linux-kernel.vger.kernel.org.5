Return-Path: <linux-kernel+bounces-105036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EFD87D7FF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 03:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1836282D05
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 02:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0B81FBB;
	Sat, 16 Mar 2024 02:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D209z5es"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07736639
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 02:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710556878; cv=none; b=RPB86ouwOOpQ5f424s1A5HJiX4CVoqP8OV1PSb6p3Ug5wJYzDYufq7qZZ36VlsCB0POAVYTYaKuXaqSjMiWBzBtQYreWF15renRkMwSDQCstYItDX4JsFdjO31f7JBIMqrRyCrryxegcAZXQ819bABiWrO+YhAr8sGK7kSDwcSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710556878; c=relaxed/simple;
	bh=gcTe6wh4B5zmy1bx9LBFzVIfXnt5DDXUYS3DhCe+5ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkG2H6m1GfsQlBZpS5pYuQ6/FwUYl7w1eWJlrD2new71P+QhRElJoY+cBnJwcdDbQ3mqL7usmle+dh0R5BEFmNfyNb/QLpiR3k4Y4/FTuFSIDWs9omA8575sae/WwjxJ2nK8kYmsrMFUNp5Kq78ddr4tLvAid3iYb15u6lfD6SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D209z5es; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-690fed6816fso16785346d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 19:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710556876; x=1711161676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs/qHkwiAn1LVXTsqARJfQt1+fMTbCUVX2OKxRrwDh0=;
        b=D209z5esCYy1o9y9CV8qk4DqLYmAiXAV90B/TintCIrDPYrb5+ps4aeZS9JRTQvJb8
         xKdWkWtBspFw80Xa3Cq9jG4i3FWmPhC773+jHWgNyHe3QbzFkgKy6a4ukeBbpzgJzSOT
         sOhlJpLA97XRc3jWpzibZSx56l0Tnbn6bpRs/x++hvfWakoAvcHAjKNzPirRJ4ludR/s
         QxpKI/H7iGgKVODndC/dxo9wmRxsh31j5RDwnFs09LNVtcmoagYmzNfhg+0YnsiIN3iz
         8tm8eyteFmBLtboM+/EedagpqWNf8MsqK8z6u5O/IrgsphCFZP2VdqB9f+LOAoZM+VCg
         8c4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710556876; x=1711161676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xs/qHkwiAn1LVXTsqARJfQt1+fMTbCUVX2OKxRrwDh0=;
        b=ELcM54tmLBbGm3NoIt2LjdhrQYO8Oh0fFlCN41MC4ez8h8WWiwDFi+8/1KmhhtLJq7
         vFroCOIwga2aGe6tFXPpRPrEfHgNHtgnsgfTypYiYAtpwP+0NevBOCzjFMl5fuvaa4Xi
         5PYcmJ6R5oo/bNlhPlChnbnfJsn19DaPNKb/wOsDRtKjcOoryO4ecn64g0E8b3nuq+5B
         InuMhEFszuN7J7P5Inl1M4JcMrL75IpW3E2UzeOAv3eEoCHoWSN1lzSwrjsvuTQn18md
         X5y3CAiyb6SwBWtkzD8jmwuAGRcQRqgy1RI9rYuxdRktxUAy5CWPluFBfyciCVPCbMvl
         kHVg==
X-Forwarded-Encrypted: i=1; AJvYcCWv+G+9pGL4+Lp06/zDD6L5lVtOlpiHXNKqWjw/pcIU9j2Y+MpLqaYIfNtqDKqvwc6B0meqScGBN4Aeeb1djJtr/3mi6J2dmk6wLCbd
X-Gm-Message-State: AOJu0YzqkPu9omqxxfjrfhvk9jBKmvuJcBv7xnqu1LQD26ILYR6l7IE9
	d50yZHkMIixKLiuRknVOGWKFfAN25KRzqqcbcg1nRIxcieNfWWrgd+te/cJ0sg46mv+NELF8wSA
	3XyyUrehPOWbu41utzZCgWhNm5cc=
X-Google-Smtp-Source: AGHT+IF5tONZB4WFghFyRw0b/5i6NrX1pN/BkvK3odjKYKS+CpaF/PdomnXTS4SOt7YODWcXGP/woySosc89VsvPe/c=
X-Received: by 2002:a05:6214:947:b0:691:6122:68b2 with SMTP id
 dn7-20020a056214094700b00691612268b2mr4987586qvb.27.1710556875878; Fri, 15
 Mar 2024 19:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314164941.580454-1-hannes@cmpxchg.org> <1551fa14-2a95-49fd-ab1a-11c38ae29486@linux.dev>
 <20240315093010.GB581298@cmpxchg.org> <ae197190-6a15-49c5-ab3c-3eaac6dd4c5c@linux.dev>
 <20240315095556.GC581298@cmpxchg.org>
In-Reply-To: <20240315095556.GC581298@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sat, 16 Mar 2024 09:41:04 +0700
Message-ID: <CAKEwX=OH=057RRGS0wv9tMKJK6+w8RMQa8neTPW1wfhpEmuZLw@mail.gmail.com>
Subject: Re: [PATCH] mm: cachestat: fix two shmem bugs
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 4:55=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> When cachestat on shmem races with swapping and invalidation, there
> are two possible bugs:
>
> 1) A swapin error can have resulted in a poisoned swap entry in the
>    shmem inode's xarray. Calling get_shadow_from_swap_cache() on it
>    will result in an out-of-bounds access to swapper_spaces[].
>
>    Validate the entry with non_swap_entry() before going further.
>
> 2) When we find a valid swap entry in the shmem's inode, the shadow
>    entry in the swapcache might not exist yet: swap IO is still in
>    progress and we're before __remove_mapping; swapin, invalidation,
>    or swapoff have removed the shadow from swapcache after we saw the
>    shmem swap entry.
>
>    This will send a NULL to workingset_test_recent(). The latter
>    purely operates on pointer bits, so it won't crash - node 0, memcg
>    ID 0, eviction timestamp 0, etc. are all valid inputs - but it's a
>    bogus test. In theory that could result in a false "recently
>    evicted" count.
>
>    Such a false positive wouldn't be the end of the world. But for
>    code clarity and (future) robustness, be explicit about this case.
>
>    Bail on get_shadow_from_swap_cache() returning NULL.
>
> Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
> Cc: stable@vger.kernel.org                              [v6.5+]
> Reported-by: Chengming Zhou <chengming.zhou@linux.dev>  [Bug #1]
> Reported-by: Jann Horn <jannh@google.com>               [Bug #2]
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Nice catch! Thanks for the report, Chengming and Jann, and thanks for
the fix, Johannes!
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

> ---
>  mm/filemap.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 222adac7c9c5..0aa91bf6c1f7 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -4198,7 +4198,23 @@ static void filemap_cachestat(struct address_space=
 *mapping,
>                                 /* shmem file - in swap cache */
>                                 swp_entry_t swp =3D radix_to_swp_entry(fo=
lio);
>
> +                               /* swapin error results in poisoned entry=
 */
> +                               if (non_swap_entry(swp))
> +                                       goto resched;
> +
> +                               /*
> +                                * Getting a swap entry from the shmem
> +                                * inode means we beat
> +                                * shmem_unuse(). rcu_read_lock()
> +                                * ensures swapoff waits for us before
> +                                * freeing the swapper space. However,
> +                                * we can race with swapping and
> +                                * invalidation, so there might not be
> +                                * a shadow in the swapcache (yet).
> +                                */
>                                 shadow =3D get_shadow_from_swap_cache(swp=
);
> +                               if (!shadow)
> +                                       goto resched;
>                         }
>  #endif
>                         if (workingset_test_recent(shadow, true, &working=
set))
> --
> 2.44.0
>

