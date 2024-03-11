Return-Path: <linux-kernel+bounces-99632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58384878AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733671C203A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB07858213;
	Mon, 11 Mar 2024 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+1K1gxa"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706972E40E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197555; cv=none; b=W3sTHMf39V6N+f8EHCBSjUVICoYQKPhU7FNnUKkq8oiPUHw75UljtX/L/8fs23wqG5fs91jCP1m5rwccxQvpG1Z38QM8oEPPaF1RQZhKLnSOfoIqHjpwD+SgvfK1PHDgMs9IcNrcbN77WvEqT4IKBeXGx3S6cHo7JBXzXcZ9uiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197555; c=relaxed/simple;
	bh=3tNuY2Sy9qmDsPWY1JjCOuYp6NlDhqMEB/g+/Q5zep8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfqGBIuWX9DPxmih+rrMsrxl5SATzDeJuTpcwJTgMK9E0PYLL9kMfOnbYI+Zt8gvZPJQZ9KIv3tsUWvdVF8dvW8elDD4PZnF18e+rqYg6aijxQDMEayYxxImB/Kk0wX/dh9qdb7GQh0DZKJGWpuMcxGO2LqMVLXcGN1IGRepahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+1K1gxa; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7db44846727so1439896241.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710197552; x=1710802352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sG6rccbriKueItsKjb2cJTEQoJ9sZCgOF8qwmAyEOIk=;
        b=Y+1K1gxaKSup3QPZQAcwMaYVY13eFWmTYk07xlTCMLyrerOrHD8FGD/XfnPJ1wAAxs
         nhenkeCNOvV1juVZE12sHn6x6aOrP4bIvfDGuFccGLa4jIE61uG+9yjO/PWqH0j+xl2z
         /LsBlOzR+Plp0xAlR+u4fAugEsOb8KUcmztS3WRoqFdOnIr4XnZBoa1FkWDdwMJKwufW
         5QGNJqDd8wmYH0q2G/yfJ1RLc2Tz/PZb2WkxPfqMQ5Ei688DjYV5cyB7mTkhlwqPJzwN
         seW1/ei0jMF57I6sVnzIhs/P/gLHzEMV3ermiKLUxmrzexxCenO9U0ds+jNfwT7du1SB
         4c8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710197552; x=1710802352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sG6rccbriKueItsKjb2cJTEQoJ9sZCgOF8qwmAyEOIk=;
        b=A/65DKqE6YVjeypYKRPR/BcvxO6nTyZjQ2bn660kNlZ2r/sa1IIr1WCAXVmFJIvm0G
         qADxGzoX5pWqWJc0b630Vt9gKDPCTHJdSUBmQ2NzWaD6L+TIUhyC9hpqA0LfnZoJ2GSz
         ShLf+5AfGG4cp5d0YClFnnYm5BzWY57sGmhONVLd0LHKjXLLO8wTJfD9aKhbc576kJPo
         mAWdaMTq+CfRlBXAcGMzF7reYMbbYmqG6CUTPLFb45anwCh+yI4gDlnxwMwFcqjTB1/6
         Ejpm6Pj//lN37O+4eaHO59PrHgGJsJvShiUgxoEpnxqBiFuyv4GoevxU/hZUzC1FHveU
         fV8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJSxOFTFTj94tzgzzvvh32h5GdDiZ55aZgLs/WKHNwpzuSeuzJj6CE+sZaxfG+xfUw9FbZ16RHqCjtAosQz979enxQtR/+NtRHYs7r
X-Gm-Message-State: AOJu0YxKkT/3Wjv4U1SXMOtHIk1/V02oQI06EjmfYy6/nsTwgVxHSaYe
	dDsIJPfIPUfC1PvOXvtCQMI2fN1t8eFBe/Fj3YfGyf6of8Oex8ssjP60ZwpDMAZz2TcK25XXw7G
	e3H5a5EkHUoXoFE1p/K8JdwaK+EhjvRC+hro=
X-Google-Smtp-Source: AGHT+IH7qn/+9W5kdTLPVGt8Aqa7YlqUn9/0gVz+ZYZapZNofZ2SvtCNgguWY9fAufPRjGpcezwjUHJnSF0J2s4EgvU=
X-Received: by 2002:a05:6102:419e:b0:473:ed7:fbc with SMTP id
 cd30-20020a056102419e00b004730ed70fbcmr5238749vsb.5.1710197552386; Mon, 11
 Mar 2024 15:52:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311-zswap-xarray-v5-1-a3031feb9c85@kernel.org>
In-Reply-To: <20240311-zswap-xarray-v5-1-a3031feb9c85@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 12 Mar 2024 06:52:21 +0800
Message-ID: <CAGsJ_4z1CTzBHLdpyyHpwhQeXmN7dXbsoHJ1zcXFS2x=D2Xedg@mail.gmail.com>
Subject: Re: [PATCH v5] zswap: replace RB tree with xarray
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 6:26=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> Very deep RB tree requires rebalance at times. That
> contributes to the zswap fault latencies. Xarray does not
> need to perform tree rebalance. Replacing RB tree to xarray
> can have some small performance gain.
>
> One small difference is that xarray insert might fail with
> ENOMEM, while RB tree insert does not allocate additional
> memory.
>
> The zswap_entry size will reduce a bit due to removing the
> RB node, which has two pointers and a color field. Xarray
> store the pointer in the xarray tree rather than the
> zswap_entry. Every entry has one pointer from the xarray
> tree. Overall, switching to xarray should save some memory,
> if the swap entries are densely packed.
>
> Notice the zswap_rb_search and zswap_rb_insert always
> followed by zswap_rb_erase. Use xa_erase and xa_store
> directly. That saves one tree lookup as well.
>
> Remove zswap_invalidate_entry due to no need to call
> zswap_rb_erase any more. Use zswap_free_entry instead.
>
> The "struct zswap_tree" has been replaced by "struct xarray".
> The tree spin lock has transferred to the xarray lock.
>
> Run the kernel build testing 10 times for each version, averages:
> (memory.max=3D2GB, zswap shrinker and writeback enabled,
> one 50GB swapfile, 24 HT core, 32 jobs)
>
> mm-9a0181a3710eb             xarray v5
> user       3532.385                     3535.658
> sys        536.231                      530.083
> real       200.431                      200.176
>
> ---
>
>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
> Changes in v5:
> - Remove zswap_xa_insert(), call xa_store and xa_erase directly.
> - Remove zswap_reject_xarray_fail.
> - Link to v4: https://lore.kernel.org/r/20240304-zswap-xarray-v4-1-c4b456=
70cc30@kernel.org
>
> Changes in v4:
> - Remove zswap_xa_search_and_earse, use xa_erase directly.
> - Move charge of objcg after zswap_xa_insert.
> - Avoid erase old entry on insert fail error path.
> - Remove not needed swap_zswap_tree change
> - Link to v3: https://lore.kernel.org/r/20240302-zswap-xarray-v3-1-590025=
2f2302@kernel.org
>
> Changes in v3:
> - Use xa_cmpxchg instead of zswap_xa_search_and_delete in zswap_writeback=
_entry.
> - Use xa_store in zswap_xa_insert directly. Reduce the scope of spinlock.
> - Fix xa_store error handling for same page fill case.
> - Link to v2: https://lore.kernel.org/r/20240229-zswap-xarray-v2-1-e50284=
dfcdb1@kernel.org
>
> Changes in v2:
> - Replace struct zswap_tree with struct xarray.
> - Remove zswap_tree spinlock, use xarray lock instead.
> - Fold zswap_rb_erase() into zswap_xa_search_and_delete() and zswap_xa_in=
sert().
> - Delete zswap_invalidate_entry(), use zswap_free_entry() instead.
> - Link to v1: https://lore.kernel.org/r/20240117-zswap-xarray-v1-0-6daa86=
c08fae@kernel.org
> ---
>  mm/zswap.c | 166 +++++++++++++++----------------------------------------=
------
>  1 file changed, 41 insertions(+), 125 deletions(-)

It appears to be a suitable figure. And LGTM,

Reviewed-by: Barry Song <baohua@kernel.org>

Thanks
Barry

