Return-Path: <linux-kernel+bounces-72281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2623285B193
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB9BEB209EB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A6351C3B;
	Tue, 20 Feb 2024 03:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bv35xI68"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CF94A3F;
	Tue, 20 Feb 2024 03:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708400548; cv=none; b=OwcvChHxJmHePZVK5kCZjUaA6W1Sh/eKR4nZHTQ/6Lcpvw2gUBT7GinKoIT9/xHZ7bdbOIIcCqZkuYJzcA9Zv65kLWcQVMJEeFnxpoNl7h4Dly05SshlJ1piquHN47IO7KQExkS7bWp7oGUQ0WI5YKu2N6JTVpxj0HML9fXKhyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708400548; c=relaxed/simple;
	bh=fbYtNy7kXIiPTIQYAblSw6Gig2Ph+K8EsXx9oUctBO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdDnTV5DXl5Fk4UZSTFLLxo4mRyOukCnvp0VW7QtFrHF8VX8ZwhUruHmO324vtqHbs3T7pZ2PlpYFpPAm73LnAbvsAgh1JAf26/gB55ZJxtkvyikekgSPOHhrHXF626sLJMaSWGCg6JGyRX4FCro9AfZ9umeNOC49EAV9CymPlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bv35xI68; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d220e39907so48363891fa.1;
        Mon, 19 Feb 2024 19:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708400544; x=1709005344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YBW0iFVBOwdaYNTEi3AnGx7giAdQn2LsYMgaIrZ6FM=;
        b=Bv35xI68MHxt8KmvwMX/obWTv+LgmqmubsK4R1Ng4FJaK+3SmZHdvQIAYTTDYfQXe1
         vSN6JEgfbqmSl1aJfrsONiIJn6w8nW5K95OdJhmPunPYnvwLQ7N21OQLuCo4irfUxDi5
         n1wfZ1Pl3/RZuQWt7Yx93Ix6shfty7+psKMk2BaSZYsVk0HUjwhrn/v3qqvnG0hZcDXW
         NwtXmLfPEn/aeEGjeaCZu1IwGjhFuvbzOutLsMunJywpnAWBk6zw+elRtf/9qoexBkAG
         UOEL9JPfpU9+Ra0PE8pum/CJ6CHkp07xrw1+vr01Wvj3Ff8OGjTRIC0+3hQbYnFtwjsp
         5XxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708400544; x=1709005344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YBW0iFVBOwdaYNTEi3AnGx7giAdQn2LsYMgaIrZ6FM=;
        b=wMubXbKK+YiBvCugirp82EpyT3YN2HCPMRB3RHGVUpr5Zc3cKPtPDA6QuZSSGiUm/4
         sJ5dNRo9pELuWPo1ElzB3oZvjYcSE0rrLziCOb+f19uBXdWfbBeEVqr062SNU0z6e4Yy
         xxVxTCuBBG/LrHj0f/v2qOaVlOuYONq898WVq3jfnPIWTtfYhi8xDmRckoNqQDl5QDEY
         9C88qmgL2KzhJYg99sGpyWYGZxqPJ2NEb9iefggIexlhmN/hQckX1iUzG8uPpyFZPGei
         cOGlsI63H3e+0zmTvyEpMslwKXE4v7HyUZlYivoeiGLcE4qOQUVcr+i5WWaM5sXNN3R0
         ylug==
X-Forwarded-Encrypted: i=1; AJvYcCXBas6E1Dk/KD09YHo1xcbo3E2Q8wPJS0elRmq31B2C37JBdYvkU5asWrAink9WETiJySqOIfpvXG5/6f4XzgHud/dG54D/bg36SUGscj1DWH0hkeZBTIB0iJM44i+Lp4enC5T5
X-Gm-Message-State: AOJu0YyrB4dEwQRetGxDG2pyb7bCehbEfJcoqnBDhnZwyt5Nvj62yCb+
	GMAjk7WfRRgfnEOxtaFitHY9bRir5Pm9FOkllJPirZQgACNbefK7D+AkppD/SQCFloSnfZ2Usb1
	AZSh3zedgJvakPjBbkdFQlSxGOCM=
X-Google-Smtp-Source: AGHT+IFUdqhJ1ck10sT6eDa/vnx33reMzjJD6WE2mtMnQZK5BEREIDmnyv1I2drdG4Do2HdBONDamROPOk/Xcek4N0c=
X-Received: by 2002:a2e:9816:0:b0:2d2:42ce:3e5b with SMTP id
 a22-20020a2e9816000000b002d242ce3e5bmr2429934ljj.8.1708400544242; Mon, 19 Feb
 2024 19:42:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219082040.7495-1-ryncsn@gmail.com> <20240219173147.3f4b50b7c9ae554008f50b66@linux-foundation.org>
In-Reply-To: <20240219173147.3f4b50b7c9ae554008f50b66@linux-foundation.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 20 Feb 2024 11:42:07 +0800
Message-ID: <CAMgjq7DgBOJhDJStwGuD+C6-FNYZBp-cu6M_HAgRry3gBSf7GA@mail.gmail.com>
Subject: Re: [PATCH v4] mm/swap: fix race when skipping swapcache
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, "Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Barry Song <v-songbaohua@oppo.com>, Yu Zhao <yuzhao@google.com>, 
	SeongJae Park <sj@kernel.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Aaron Lu <aaron.lu@intel.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 9:31=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 19 Feb 2024 16:20:40 +0800 Kairui Song <ryncsn@gmail.com> wrote:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
> > swapin the same entry at the same time, they get different pages (A, B)=
.
> > Before one thread (T0) finishes the swapin and installs page (A)
> > to the PTE, another thread (T1) could finish swapin of page (B),
> > swap_free the entry, then swap out the possibly modified page
> > reusing the same entry. It breaks the pte_same check in (T0) because
> > PTE value is unchanged, causing ABA problem. Thread (T0) will
> > install a stalled page (A) into the PTE and cause data corruption.
> >
> > @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       if (!folio) {
> >               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >                   __swap_count(entry) =3D=3D 1) {
> > +                     /*
> > +                      * Prevent parallel swapin from proceeding with
> > +                      * the cache flag. Otherwise, another thread may
> > +                      * finish swapin first, free the entry, and swapo=
ut
> > +                      * reusing the same entry. It's undetectable as
> > +                      * pte_same() returns true due to entry reuse.
> > +                      */
> > +                     if (swapcache_prepare(entry)) {
> > +                             /* Relax a bit to prevent rapid repeated =
page faults */
> > +                             schedule_timeout_uninterruptible(1);
>
> Well this is unpleasant.  How often can we expect this to occur?
>

The chance is very low, using the current mainline kernel and ZRAM,
even with threads set to race on purpose using the reproducer I
provides, for 647132 page faults it occured 1528 times (~0.2%).

If I run MySQL and sysbench with 128 threads and 16G buffer pool, with
6G cgroup limit and 32G ZRAM, it occured 1372 times for 40 min,
109930201 page faults in total (~0.001%).

