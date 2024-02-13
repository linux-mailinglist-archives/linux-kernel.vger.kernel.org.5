Return-Path: <linux-kernel+bounces-64003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D54358538D5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142811C2311C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EF55FF01;
	Tue, 13 Feb 2024 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CgP8ztxo"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD06A5F563
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846331; cv=none; b=liHc3MnRSY14cX6am5f7kdIfoZy28bumMIk5sXCiO7pMW7jrYCO4NQKmVStUcChJ4g4TIGyi2pZ8T5KeU/XLcQTRz0aNIX8fs1Az3oS9hWkvaJQg7khLbWnzQiy8YfW1IJaOSy1A8FHEK9OBl4uwqn5skEzbSN2Tuv5KNJ8eJIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846331; c=relaxed/simple;
	bh=n03lbBp1zR0JN/uywXAdDCOyEB1rONWr55lwzpMjzLI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uNNPP/YFsOcsFjr7GBvfsJoTaCfaDc+1483EvNMy07qUAoh9oH0LoWgeSW/TREKpb72BsEqwcVIVveqvYIHPXytz8lS7nNtze2UU7GhwQ/ULcGHdlaQLciefWRpg4s6DpYi5Saayv+N5PjB/141hn9eHLZhN1p8AxiUqXCzIsJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CgP8ztxo; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso1897221276.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707846329; x=1708451129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXlhzdNPTrDKXAkgc5vsL7hh9f5XZEfrWoq47VPOT/k=;
        b=CgP8ztxoSfXwoKVi+fm+ly0sWz+TcvagpyoJ3eJAUA/mfpMKNMxH5zwaTDsen2HDBQ
         wE29lKmfEvolCV+Nqty5UluuprBA+Fawoqn2NfphDoVzsxhFLSui5vOffMFgfuFzAegn
         CYN1PIbwm5kiOfsS32RVFnxbd9i0zeoHv+3eXjfdNoHjrmXQGV1/zu4blJU3F4So3Fx5
         6tJjJy2VlMhxgGmYd2u/WQrxUyL2mn+zPhILWfZK8Ct1/xesw9hzK1mEvO6L9APABG3Q
         jLp2ghddQauw65iVkzHRqcGvc0zWHGxheyxuUnE3piFnXy9HhcLgWiuK2e9sLQCd46Dl
         GX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707846329; x=1708451129;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wXlhzdNPTrDKXAkgc5vsL7hh9f5XZEfrWoq47VPOT/k=;
        b=OZeY93CyK+yu8PnoDqPaF4cBrWdwrhslwmebifLIUgpSu2BW4otFqWOJ47u7Ka3yXR
         N4/dGzlUfUAiY7r9t35TtJC5iXoTE/DWre+rsD/ja09O9OFbtsl306ZDzhorFRaG8+Rq
         UmWg9DhMwFDgX7EiSSK+1FnxCqcmWLIdrTYkZ3m2xEO+fDGuh3WR6tKUaq9UPUyNF/Lb
         Psurhx4GspVxjuPoSAx2tuHZhGLHXLDe8IUatCcsEg3JycDI38mD/O06QFoGAJoo+vv+
         gG2SkcDqAg5XOyKjJPR/46NiJxMHpYIAbMkCOGtFQVLZFncrho3fDbi20GMnJF0q5zgk
         c8sQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6fOegCVpO0tw7MYs4cn0YrD8GcAHhoO7UEkR5yKLqG7R9x7ADlhQgz0BBKGivslEiRyVqYL6w87ciguWlBF3qQRGCN+DdawAXCSV2
X-Gm-Message-State: AOJu0YyPBCExNhPtyTpZqoBvrlXLejrvL15g0zFm5fh8C5Uca5c9FqKF
	URlQQxtFKLzTTVvHukymxu6b49U5vg3FDW7UcFDNuBHN4X/H+dM0ZKcYSH78NmcoaNNw3c+Qvgl
	DzHaUOWh2KQztk6VLdQ==
X-Google-Smtp-Source: AGHT+IGZTxxVMztPl41LtC95lrjWgcnvviGpN/tMTecDRzoIWpNi9hdSkUB+X9urFFRzjgntUMqgnKc15MZULdUa
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1083:b0:dcd:2f2d:7a0f with
 SMTP id v3-20020a056902108300b00dcd2f2d7a0fmr53739ybu.9.1707846328778; Tue,
 13 Feb 2024 09:45:28 -0800 (PST)
Date: Tue, 13 Feb 2024 17:45:26 +0000
In-Reply-To: <1e5ffefa-8c80-44b8-986f-ee574c3b3349@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240210-zswap-global-lru-v1-0-853473d7b0da@bytedance.com>
 <20240210-zswap-global-lru-v1-2-853473d7b0da@bytedance.com>
 <CAJD7tkYdEWrrQj+MFNpDR6FHc60czXcuawh3dd1rSF=QQm6+yg@mail.gmail.com> <1e5ffefa-8c80-44b8-986f-ee574c3b3349@bytedance.com>
Message-ID: <ZcuqtiIsAmDedOqK@google.com>
Subject: Re: [PATCH 2/2] mm/zswap: change zswap_pool kref to percpu_ref
From: Yosry Ahmed <yosryahmed@google.com>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:31:16PM +0800, Chengming Zhou wrote:
> On 2024/2/13 06:42, Yosry Ahmed wrote:
> > On Sun, Feb 11, 2024 at 5:58=E2=80=AFAM Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> >>
> >> All zswap entries will take a reference of zswap_pool when
> >> zswap_store(), and drop it when free. Change it to use the
> >> percpu_ref is better for scalability performance.
> >>
> >> Testing kernel build in tmpfs with memory.max=3D2GB
> >> (zswap shrinker and writeback enabled with one 50GB swapfile).
> >>
> >>         mm-unstable  zswap-global-lru
> >> real    63.20        63.12
> >> user    1061.75      1062.95
> >> sys     268.74       264.44
> >=20
> > Are these numbers from a single run or the average of multiple runs?
>=20
> The average of 5 runs. And I just checked/compared each run result,
> the improvement is stable. So yes, it should be a real performance gain.
>=20
> > It just seems that the improvement is small, and percpu refcnt is
> > slightly less intuitive (and uses a bit more memory), so let's make
> > sure there is a real performance gain first.
>=20
> Right, percpu_ref use a bit more memory which should be ok for our use ca=
se,
> since we almost have only one zswap_pool to be using. The performance gai=
n is
> for zswap_store/load hotpath.
>=20
> >=20
> > It would also be useful to mention how many threads/CPUs are being used=
 here.
>=20
> My bad, the testing uses 32 threads on a 128 CPUs x86-64 machine.

Thanks for the clarification. Please include such details in the commit
message.

