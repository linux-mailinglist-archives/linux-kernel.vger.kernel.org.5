Return-Path: <linux-kernel+bounces-29593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C3A83108A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD8128D9E2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A23F10EA;
	Thu, 18 Jan 2024 00:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IvLn4M8d"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A25A20
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705538102; cv=none; b=odvBoixEdU+QYGTPsBUu4bTnFoYf7C48DQaaJLTq8w+IEBNFvHAWgnRjEAwQPmC2+Twmp8l/kgVPpXgBAh+cmx0+gp4HZ4RNGVcrejICeWb/ClKJ6795qsJV1WS7l+dvvQajyengFrzPRV7GjpoJkbBoYZ1rya6CTurJb3cC1FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705538102; c=relaxed/simple;
	bh=qcqd6AUvMwYNsZlOf7YHd38WVMzw7ST5ATjLnWUfFGA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=hrIRy3HvAdbHhVIbPh3GJMUqBH79kiGLwL1Xyj68s0u1LYmC7YArWlwgUvrMg4eYTymq4TIry1NW7oTVyY4aYeFqM3lqua8dAnTaGkZVNVLzClM5AHa8mHNAKNQVFCqpMqNbat7kB2UG8zG+IOcgkoeNRRa/MO6Kdrcm1XpHo3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IvLn4M8d; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a298accc440so1429503866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705538099; x=1706142899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHr9OYj+8osifau/ZxeJjzIY/aqizhg6RN0qn/bjsq0=;
        b=IvLn4M8d5Vm6UphCxLGrMlcoH46ZVqgpdlIKEBT6pja4q24K5AJauiXUjwMfQu+R8f
         XlUyhEWxty0hSBb0q0r9dFHhcOf5iabki6ZPS6i8o6lgMXfqWmGN5rd6A71LMQLV5YjU
         4N3qH3ZBcDUjmhfPJrA4UCRj+qJpIeQ/Vu8CoRMHJkS4T+QuL5LsYq8GENmFdjtzcem6
         8mnljbn7wQwfGUXBmTPmwbAGWKgbPFfod3yMAxHapS7LKOz1J/yZOWQExXkl+rXN1MtC
         DjMnWEG/3WRq/Qo92WfEICKQOjRy626DXT8FXUsVOL2OAbJxn/ZURBdWswZwWatecooa
         kBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705538099; x=1706142899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHr9OYj+8osifau/ZxeJjzIY/aqizhg6RN0qn/bjsq0=;
        b=cvqmheP6IXK6ApTC1Bizu30XzisZGNQtCIpV3+7qlnqwh08kMb9aOFNRMvnQvzt3pN
         xBVF7/Ergv0eT5J/QsUSySaDnsXTPlYsCh6arLspMmEbaEapllBeH8zQxguLPg3T0TK2
         VMhfSqNMfMnynUFE5FeVBojOabUmud0ZAAXwfawuJ/0nWTng+KqSKuFCWcH5/VOB9htA
         Ncd+4ONmVjSWGPFAu3oKv1UFsNEUR9c9vNdaN99lU11IWuui8o/5BsjGJHJXUFwyhPGk
         Ir9QSKVhITw5pT2u1fkAMs4TBlFVSPE/x3DGOMaBPz4pMBAy+InwVU2r5ZubGNef7UY+
         hoXA==
X-Gm-Message-State: AOJu0YwXMAP7Vmg2GDtMeR9mr/M995llc4B5ywcf/R/bKxRejiuoBUr7
	mh+V+vUSjlM9cBBKpn1LZW9zxpwPRZPHx/mg9Sim6rDrtysTAWkmbaj16Sy6mF3XABYcxiPy4n8
	z/+WAA/5vpjefYr/nebczOEq//1jrV7SVlvx1
X-Google-Smtp-Source: AGHT+IGbAiDkcXcm7pW2ktD3Dh0e10s+YY/j/4ISHJhJVoaVO+RLvh2Dc1/kWTocvvEgIGPZZJeBIgohXVCGjT61FkQ=
X-Received: by 2002:a17:906:9c8e:b0:a2c:4fc6:15d9 with SMTP id
 fj14-20020a1709069c8e00b00a2c4fc615d9mr26497ejc.20.1705538099259; Wed, 17 Jan
 2024 16:34:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com>
 <CAJD7tkY7Xvjg37EEw2M=uRknphY0pf3ZVpyX2s2QyiJ=Axhihw@mail.gmail.com>
 <CAF8kJuP4o3Ebg-aYKF9=ftbdu97RnkXnYL-8RuVjYAeXd+ng3A@mail.gmail.com>
 <CAJD7tkYfo6mNjHQJt4yfVuh55tMyVMRnbeq5ki42tYHBEgP_eA@mail.gmail.com> <CAF8kJuO=3-DMV-rXBZE-hVUXzQcV5B1HPFGzpzL99_5WggqF9Q@mail.gmail.com>
In-Reply-To: <CAF8kJuO=3-DMV-rXBZE-hVUXzQcV5B1HPFGzpzL99_5WggqF9Q@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jan 2024 16:34:23 -0800
Message-ID: <CAJD7tkadpOmERPzUyYUX=8=POan=Pm1zSae81zyRhYLXDHo_7g@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm/zswap: optimize the scalability of zswap rb-tree
To: Chris Li <chrisl@kernel.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 4:18=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Yosry,
>
> On Wed, Jan 17, 2024 at 3:48=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > > Currently the xarray patch should have everything it takes to use RCU
> > > read lock. However taking out the tree spinlock is more work than
> > > previously. If we are going to remove the tree spinlock, I think we
> > > should revert back to doing a zswap tree lookup and return the zswap
> > > entry with reference increased. The tree mapping can still decouple
> > > from the zswap entry reference count drop to zero.  Anyway, my V1 of
> > > the xarray patch will not include removing the tree spinlock.
> >
> > Interesting. What do you mean by removing the tree spinlock? My
> > assumption was that the xarray reduces lock contention because we do
> > not need a lock to do lookups, but we still need the lock otherwise.
> > Did you have something in mind to completely remove the tree lock?
>
> In my current xarray series, it adds the xarray alongside the rb tree.
> Xarray has its own internal lock as well. Effectively zswap now has
> two locks instead of just one previously.  The xarray lock will not
> have any contention due to the xarray lock taken inside the zswap rb
> tree lock. The eventual goal is reducing the two locks back to
> one(xarray lock), which is not in my V1 patch. Your understanding is
> correct, the xarray still needs to have one lock for protecting the
> write path.

Hmm I don't understand. What's the point of keeping the rbtree if we
have the xarray? Doesn't it end up being more expensive and bug-prone
to maintain both trees?

When you say "eventual goal", do you mean what the patch would morph
into in later versions (as in v1 is just a proof of concept without
removing the rbtree), or follow up patches?

