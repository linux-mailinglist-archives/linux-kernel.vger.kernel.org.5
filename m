Return-Path: <linux-kernel+bounces-110897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5024886568
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB9F1B22A12
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742C26FA7;
	Fri, 22 Mar 2024 03:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="M2kzSqfp"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F87539A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711077561; cv=none; b=V90owtS6InuuxbYEMQqdudo6t6cZNxcFq+B9yfjmMcl879DwEsBKXvY0kGq9QEvI874LsbO+qFax3cXRLgnu0e1gXKD/5Curb7yC6bE+5YLp7HOdV9En+QkXOe0Gzcy3T4NdTGCNu3XnJ1ZS3lsmEZTK9jLCEny8U/QdzD/4MGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711077561; c=relaxed/simple;
	bh=fvJZZaBkvTwZ2GfFM/bql1AFaWmzpydGZRMgQq4xgY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FK7yQaGi6PK620qExuJXproVuIegLa/dhfw8fXrc9a2XYTmIvyZYfDqOdl96dCanBxh9M6KqHunMPv1Iib4yVY09Du7bjD/0zaj/PBrLufZKLYqkSXQt4+CORBzsI7bqSy56d94utIrc2zJV9CmWI/4mpom+kQNkyR6rNEyobCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=M2kzSqfp; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78a2a97c296so110228285a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 20:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711077557; x=1711682357; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7AULlavfdEfOUm/GPX2L+Nif3qOYoN+V+nZ3StdUxak=;
        b=M2kzSqfpCq673SQ0TmiuFtPT0x/sSz+RtMRAurOWFJJ4CoNA0x1Rs2ygqoKR2mNo7E
         8MPLp99Xzoi1C535GXfma+aDDomA+4yVOcPd0+qkAAU0hpddi/yPGxOJmuAwYGS6MjbZ
         PpdEhe11C90bVh3VldVIVHoJZcjv5aBH6NMevNWVqpu0DQ7L2JbY7XmNAZrYjvtemyFS
         T0ng5oyp+QH/psp4DbeaaCtqIBao2yMMUXSv8WWzrn0Bm3dno7x8hlxsxhjqeVo6sXUZ
         k3aKQAGzTZCgQM478S8aDnjSsx/r15sRaG5WVwHn67XVdRsBWLCnXVSv++Q/12XkDkS2
         zPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711077557; x=1711682357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AULlavfdEfOUm/GPX2L+Nif3qOYoN+V+nZ3StdUxak=;
        b=dPyZCQixlMAgmERh9ls9nTCL2a2dyvDuujgy1aNc9Da83e8RfCLGJ5xKXtrRVcBkt2
         IWHwxtKaMbnUzWCtuL7PX5iNLfg7mapMiIwOJ5hzMLe5+5kP8ttxAQBpY0tumZBYPQ9U
         0ZNeHp1k04W8ZPq1mh9zpnA0dPnZj3gjDNdPdsuvCwTAMRCB6mvk35tqzwnIhDe+8LFO
         KlsF0TFxhcQ7Ayo1RHlj8ubQPN0LodgZ6QTOfZNwFLJ0Rafp3teTtZzkGF5wNvaQMzNd
         yfR4J7+FHtGStRzt6tuy0KhLRu8t7PwC04lCqzwFHOkmavNpTL5HOd/5/IVzKrC3fs0p
         ceUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwuhoy76LLL9m3Gau14oNIySLrF/IS0p7kmmN1lfStebFwq6TXN1CiMtpE0ObFdvH0/S/TAUWfQv09LtJ0agMp+QsDwvkDqu033QKY
X-Gm-Message-State: AOJu0YxiXyoTinZike33nTCYYNTFawX0ySVK9jRtdMxivxiEfeRnrMnF
	L9I0rtfW044L0y7lIFWinY2Ei1En0TbVbpa3vKe68ZsJ7HUfxk/cmro9wI2iQWI=
X-Google-Smtp-Source: AGHT+IGeEElG2Dj2jPJzIQlEFbUdLTQ8YBWA/SaQDhmGpaNmeQgTBDh0ATOszhGcScXdso/ksZeIgw==
X-Received: by 2002:ac8:5b89:0:b0:42e:f660:8067 with SMTP id a9-20020ac85b89000000b0042ef6608067mr1390189qta.36.1711077557158;
        Thu, 21 Mar 2024 20:19:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:16be])
        by smtp.gmail.com with ESMTPSA id ew9-20020a05622a514900b0042f0996be6esm513421qtb.3.2024.03.21.20.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 20:19:16 -0700 (PDT)
Date: Thu, 21 Mar 2024 23:19:07 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] zswap: initialize entry->pool on same filled entry
Message-ID: <20240322031907.GA237176@cmpxchg.org>
References: <20240321-zswap-fill-v1-1-b6180dbf7c27@kernel.org>
 <CAJD7tkY8os3yvYLiotaiRuYa1jdEGiPHQsZEU6E52zRBQ34kQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkY8os3yvYLiotaiRuYa1jdEGiPHQsZEU6E52zRBQ34kQQ@mail.gmail.com>

On Thu, Mar 21, 2024 at 04:56:05PM -0700, Yosry Ahmed wrote:
> On Thu, Mar 21, 2024 at 4:53 PM Chris Li <chrisl@kernel.org> wrote:
> >
> > Current zswap will leave the entry->pool uninitialized if
> > the page is same  filled. The entry->pool pointer can
> > contain data written by previous usage.
> >
> > Initialize entry->pool to zero for the same filled zswap entry.
> >
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > ---
> > Per Yosry's suggestion to split out this clean up
> > from the zxwap rb tree to xarray patch.
> >
> > https://lore.kernel.org/all/ZemDuW25YxjqAjm-@google.com/
> > ---
> >  mm/zswap.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index b31c977f53e9..f04a75a36236 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1527,6 +1527,7 @@ bool zswap_store(struct folio *folio)
> >                         kunmap_local(src);
> >                         entry->length = 0;
> >                         entry->value = value;
> > +                       entry->pool = 0;
> 
> This should be NULL.
> 
> That being said, I am working on a series that should make non-filled
> entries not use a zswap_entry at all. So I think this cleanup is
> unnecessary, especially that it is documented in the definition of
> struct zswap_entry that entry->pool is invalid for same-filled
> entries.

Yeah I don't think it's necessary to initialize. The field isn't valid
when it's a same-filled entry, just like `handle` would contain
nonsense as it's unionized with value.

What would actually be safer is to make the two subtypes explicit, and
not have unused/ambiguous/overloaded members at all:

struct zswap_entry {
	unsigned int length;
	struct obj_cgroup *objcg;
};

struct zswap_compressed_entry {
	struct zswap_entry entry;
	struct zswap_pool *pool;
	unsigned long handle;
	struct list_head lru;
	swp_entry_t swpentry;
};

struct zswap_samefilled_entry {
	struct zswap_entry entry;
	unsigned long value;
};

Then put zswap_entry pointers in the tree and use the appropriate
container_of() calls in just a handful of central places. This would
limit the the points where mistakes can be made, and suggests how the
code paths to handle them should split naturally.

Might be useful even with your series, since it disambiguates things
first, and separates the cleanup bits from any functional changes,
instead of having to do kind of everything at once...

