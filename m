Return-Path: <linux-kernel+bounces-77245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37473860284
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A081F2543B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019A2548E6;
	Thu, 22 Feb 2024 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n5Y1zwo5"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDA514B824
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629633; cv=none; b=KEXEIVMOu0xaVG6gXJWL0jq3vWFjtgAYnODSPJRkBHDvVQc20AO1l82PCTls1n8YJwWghD+D9QP5Jjap4WO8ZNouGVzvcFwvYuNj3TGBiwjVaWf3v+LtK6g5eF6dXnCkQEWLY+u5TAqKAN6Q8IIwOHz7TPwqnB+3qd4D1obzqJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629633; c=relaxed/simple;
	bh=NI/Koe2CrQjb3OlXia8exOChMcl0s7CtRCQE/GU2cEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V23XYyZhCSU3nxpzYqPkqdGtCHFA40O3ekvRYtwQzDO143ODpzIkO5+GyyLtmqLs2CEIJla4YTGp8Vq1vkqyUB5g+yS1u6VH7vB/ImAYXF9EheyZGKjYvC0vARCtMKzqkYLAJFod224+G2QnO7d5luCaNxe3RY63ETMnEvnuFfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n5Y1zwo5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607cd6c11d7so1591237b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708629630; x=1709234430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NI/Koe2CrQjb3OlXia8exOChMcl0s7CtRCQE/GU2cEg=;
        b=n5Y1zwo57LGNzYXlE7rOb+sFV56rQOe5lrlWSlQSeQENIvUChh/2XhuCKFmNHE5AX2
         0im5UOYBPt5qD4YRM49KYRXA1jtrh1PIGZepYtmxW1yriW5T2RtzqTDugz2bHq4IDLpH
         81X5S0FdZt0fdd6Hi9lERLAYF1VyfADxrfb6EzIURmt/ZGLA7GdOKaCpee+3jaiCwgi9
         qQFwndvzFH740o+9ks6EcHOTaAx9u//CLxoYmNB68L0xxVUNunK+KT5USeLOVVkCEu9U
         7F4r8MnV37CTLeJHXe7w9lrKYeFTHSdr+ZK/k8OKpV5+0WGbqXzRTp7QOb/BKtwBxs/8
         HEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708629630; x=1709234430;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NI/Koe2CrQjb3OlXia8exOChMcl0s7CtRCQE/GU2cEg=;
        b=af3z3Deb2dOHDuoicVsT5hNqAzSKDCg5D1/Rhk+4HHUG/ZOBqBGjonjAAnL2oif/Sk
         JJlI1HJ5dPQ4lM1+CpIdW3uE2EM6831a1a0ytSesfQwVv5+5qvTnL59OidWZj25BGkx3
         gzgoBoLYS7WdgBraSZJ9Kz0Latkc5l/sol9+Qj3wSHKU52ZbBuTyon6s2s7R8EY5X/dx
         RC9tf20QSVp+5/AJ0nC8IwTt0Gmw5uqQixtm0jTXiQyD2N0A4p6K9Y32gqJG/NqlDosi
         mB7cJgJrGLbjjPryB9JrYmyp1hnl9OCr/ENyaoAUmEQ0G2juvbgzDEkFv7KRhjhYzmtj
         IOWw==
X-Forwarded-Encrypted: i=1; AJvYcCVm4YiBCf2fZHElk3tmiQwiC++rDFdZK7dyaq7hZz3ka334hd2rJ0FEu9AmBj8HeeZQdkev9lOPqWune3AKIgPzzIzaoWxTLutvNtna
X-Gm-Message-State: AOJu0YxKmHjn8AMfGVUsqdrs44BuZpbDBrmLzm0NVjz+i2hCmYq12QgV
	0xVNfV/JJK7oExHy92qOdXJzVvqZxq8TRQoA01nZiqlqE6uSBFgir6d4s3H/B+ACN+RkZAl1WrM
	/a3Go5yUF8DkIIj04oA==
X-Google-Smtp-Source: AGHT+IGetz4V2Sr7DuWLHIVvxqx/VQGxETay3qgiPi7I20KxUZw+yYeh2iQbnGqzMLDaLR4aUYNqzFb12po+bfBY
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:701:b0:dc7:66ec:9038 with SMTP
 id k1-20020a056902070100b00dc766ec9038mr1336ybt.1.1708629630720; Thu, 22 Feb
 2024 11:20:30 -0800 (PST)
Date: Thu, 22 Feb 2024 19:20:28 +0000
In-Reply-To: <CAKEwX=MELnV5uzMg2sR0iLd9jiwe-Z9sTh1dhDRiescrDce5rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAJD7tkbRF6od-2x_L8-A1QL3=2Ww13sCj4S3i4bNndqF+3+_Vg@mail.gmail.com>
 <CAKEwX=MELnV5uzMg2sR0iLd9jiwe-Z9sTh1dhDRiescrDce5rA@mail.gmail.com>
Message-ID: <ZdeefPytg81oXVAc@google.com>
Subject: Re: [RFC] Analyzing zpool allocators / Removing zbud and z3fold
From: Yosry Ahmed <yosryahmed@google.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, Linux-MM <linux-mm@kvack.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>, 
	Chris Down <chris@chrisdown.name>, Seth Jennings <sjenning@redhat.com>, 
	Dan Streetman <ddstreet@ieee.org>, Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 01:23:43PM +0700, Nhat Pham wrote:
> On Fri, Feb 9, 2024 at 10:27=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > I did not perform any sophisticated analysis on these histograms, but
> > eyeballing them makes it clear that all allocators have somewhat
> > similar latencies. zbud is slightly better than zsmalloc, and z3fold
> > is slightly worse than zsmalloc. This corresponds naturally to the
> > build times in (a).
> >
> > (c) Maximum size of the zswap pool
> >
> > *** zsmalloc ***
> > 1,137,659,904 bytes =3D ~1.13G
> >
> > *** zbud ***
> > 1,535,741,952 bytes =3D ~1.5G
> >
> > *** z3fold ***
> > 1,151,303,680 bytes =3D ~1.15G
> >
> > zbud consumes ~32.7% more memory, and z3fold consumes ~1.8% more
> > memory. This makes sense because zbud only stores a maximum of two
> > compressed pages on each order-0 page, regardless of the compression
> > ratio, so it is bound to consume more memory.
> >
> > -------------------------------- </Results> ---------------------------=
-----
> >
> > According to those results, it seems like zsmalloc is superior to
> > z3fold in both efficiency and latency. Zbud has a small latency
> > advantage, but that comes with a huge cost in terms of memory
> > consumption. Moreover, most known users of zswap are currently using
> > zsmalloc. Perhaps some folks are using zbud because it was the default
> > allocator up until recently. The only known disadvantage of zsmalloc
> > is the dependency on MMU.
> >
> > Based on that, I think it doesn't make sense to keep all 3 allocators
> > going forward. I believe we should start with removing either zbud or
> > z3fold, leaving only one allocator supporting MMU. Once zsmalloc
> > supports !MMU (if possible), we can keep zsmalloc as the only
> > allocator.
> >
> > Thoughts and feedback are highly appreciated. I tried to CC all the
> > interested folks, but others feel free to chime in.
>=20
> I already voiced my opinion on the other thread, but to reiterate, my
> vote is towards deprecating/removing z3fold :)
> Unless someone can present a convincing argument/use case/workload,
> where z3fold outshines both zbud and zsmalloc, or at least is another
> point on the Pareto front of (latency x memory saving).

I can re-send the RFC to mark z3fold as deprecated with a reference to
the data here or a quote to some of it. Alternatively, we can remove the
code directly if we believe there are no users.

There were some conflicting opinions last time and I was hoping we can
settle them.

I am also low key hoping Andrew would chime in at some point with what
he prefers (deprecate, remove, or leave as-is).

