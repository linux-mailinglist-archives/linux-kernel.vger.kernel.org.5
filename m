Return-Path: <linux-kernel+bounces-112042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8131887481
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB9B1C212FA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484EC80059;
	Fri, 22 Mar 2024 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJyq42aI"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2136F81205
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711143711; cv=none; b=Jx+Kc/cWu30G6Y7uX2JP0NLZgSEOQZIBeCmjqvPOP5NZ0cwUCsHY2id2QWAcWKM+6CYr92+ZcYpu58oXxj31zH0753o8sqtRUBZDNWA8E4SM9vPakkHtsnp9dEbHQZi0innKI6F3B6ZNQjpu6os5JvT6fRwkZDVt9ujHiYdbdrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711143711; c=relaxed/simple;
	bh=RQll5QYZhzufGj+S1fYXa+jgiDZDq7VQ1QzparuV7Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOkFER/scrGPrFu5PnVXr4061Rk3fm2bHI0h9mL+lpmlvn7VYx3UQxiNUFeZ4EJbBmZF9DzIsOIlnhSBep0WVoJedwv7XlNkDfYlNtqzFq8l0x9cD9ISlIVxSPa24aXLowE4nLnH9//45tGQ9uUC9e7Bz0sOBeQSNaMqu0ATGlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJyq42aI; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7e08498aa43so1094916241.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711143709; x=1711748509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQll5QYZhzufGj+S1fYXa+jgiDZDq7VQ1QzparuV7Ek=;
        b=ZJyq42aI3gZcW2/lT6byH3r/SIXhrwPHi5NoWFtuzSGzjHwQ4CNsoWY4aVst6lFiAh
         Tbvv1uObWy+KfOFV67E/g4tGWuLPfYDL7vvYvrS34JYyrF+cljMxrzLLknR3FaJZ8mZx
         bBiTOmQfwkFCWdIutvPZJHfzGA6QqarQ7thee032fHHZ8fF9XGbQFurwhZLUN9MIP2zM
         /VOavZelr/X9sCUkh+I6ZTc/tKE4U74oZzltbEuxAJ9KrXamhJjDzGHyHikHBGkDDWwf
         D0NJ3ycpkhFDB/mhtrnk4+246Vz7nCZVCCG5YKpuYB/UhPWR9BaKR37QNUVbyBmam7z4
         JNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711143709; x=1711748509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQll5QYZhzufGj+S1fYXa+jgiDZDq7VQ1QzparuV7Ek=;
        b=WsKmusJjPdz9FlfFiod9QB1VQvGc3vf7QGR3t4PXlHimSWgbLX1MDvniogDsrUy2lf
         F7Oy972CvbqyrRlW+eri7R8Ga6RewBo2HDnxUJD9MhA8aT6Dsdu3mcRYx9y5qrEHyinC
         4ZYJuS/JbhmL0QpdoWLkj+15yZ5T31nPHd/kIth8yld5vvn4wSRds6kL5CeERN8lNiac
         XEzAc1XUD/l2UghG46hkpMKzGvSKlIX7eo7BNYTRGoN8/eJb/OHaEzJCAPr46Xoo2Q0v
         gQjPl/dbyksG978eGPHCRJwHRV103Xhi2BoSJ/QM/6cB50ACim5eIlbZfdVf9oLWpfqV
         A9zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp/+UtTYVUBY7SYS4v0HUf29R8aeWL6FK5CjKywW3+a2aZ9WqjX6+xurVesglMRfphXvvIgn/bi2OoI5E7c2zjKsD5en67ULER7iK1
X-Gm-Message-State: AOJu0YxZleg50bhJvjMnjFYm16edjOwctj047MBFn9oaUm3mPjNboCbY
	KfXxKq0rd5qw9xOYlKR+qrGWbJdeRcHf7Mwcy9M/OHWhKDDhYiF6PHovKCug/5B02rs1CStXJpj
	RL0OFu44m5iI8yQr70+18l59P9vc=
X-Google-Smtp-Source: AGHT+IEv9fJIOeOrs93WlB1QNmSJh28TuaydQyrjMI4d8y02To3CTcqsbR+SmmiDpNQBw6ucVRiADjzXkF8yR9BNSCo=
X-Received: by 2002:a05:6102:f0d:b0:473:2d91:c4d5 with SMTP id
 v13-20020a0561020f0d00b004732d91c4d5mr988952vss.25.1711143704130; Fri, 22 Mar
 2024 14:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322163939.17846-1-chengming.zhou@linux.dev> <CAJD7tkYuYEsKFvjKKRxOx3fCekA03jPpOpmV7T20q=9K=Jb2bA@mail.gmail.com>
In-Reply-To: <CAJD7tkYuYEsKFvjKKRxOx3fCekA03jPpOpmV7T20q=9K=Jb2bA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 23 Mar 2024 10:41:32 +1300
Message-ID: <CAGsJ_4yc-XB3+FkcZTy1aZ0n6ZKEkfWVYk_TjqqrdcROa5VYtA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: add folio in swapcache if swapin from zswap
To: Yosry Ahmed <yosryahmed@google.com>
Cc: chengming.zhou@linux.dev, hannes@cmpxchg.org, nphamcs@gmail.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 8:38=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Fri, Mar 22, 2024 at 9:40=E2=80=AFAM <chengming.zhou@linux.dev> wrote:
> >
> > From: Chengming Zhou <chengming.zhou@linux.dev>
> >
> > There is a report of data corruption caused by double swapin, which is
> > only possible in the skip swapcache path on SWP_SYNCHRONOUS_IO backends=
.
> >
> > The root cause is that zswap is not like other "normal" swap backends,
> > it won't keep the copy of data after the first time of swapin. So if

I don't quite understand this, so once we load a page from zswap, zswap
will free it even though do_swap_page might not set it to PTE?

shouldn't zswap free the memory after notify_free just like zram?

> > the folio in the first time of swapin can't be installed in the pagetab=
le
> > successfully and we just free it directly. Then in the second time of
> > swapin, we can't find anything in zswap and read wrong data from swapfi=
le,
> > so this data corruption problem happened.
> >
> > We can fix it by always adding the folio into swapcache if we know the
> > pinned swap entry can be found in zswap, so it won't get freed even tho=
ugh
> > it can't be installed successfully in the first time of swapin.
>
> A concurrent faulting thread could have already checked the swapcache
> before we add the folio to it, right? In this case, that thread will
> go ahead and call swap_read_folio() anyway.
>
> Also, I suspect the zswap lookup might hurt performance. Would it be
> better to add the folio back to zswap upon failure? This should be
> detectable by checking if the folio is dirty as I mentioned in the bug
> report thread.

I don't like the idea either as sync-io is the fast path for zram etc.
or, can we use
the way of zram to free compressed data?

>

