Return-Path: <linux-kernel+bounces-104209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD4A87CAB9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BFE283A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE35A17C67;
	Fri, 15 Mar 2024 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="e2ObiOYU"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5ED17BCF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710495021; cv=none; b=kh+4XjtWwB+vYBNsskVBEqM3VOEqdInlIOibzFXWQA6PndaAIc9HY8a9pvTGSG/nc99PazXNC07CIathaBM7CiPriHxbtDAczu3DBv/WhqX/LzJi+DY0ssDOsLbwj1skvcnDUkRoVPsGuoXET3SuL9P+d1mF2jIPLK5h51uJx+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710495021; c=relaxed/simple;
	bh=g3X1pUt7jFI+HdUCQpvYwADA6tUtWhahWt24HFCNLfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmxaFCWIBdcuZbdMUq2aXNoDsq5kZ1qU2ULvJPKEQ6HWnsYCOEpDqYDGZ/u2kIWMa02ear7cw4McMLFoHf9uAdejbXg+Vwefuyx42jVDaFD9hE7IsUAx7HnUIMBr91TdIK6mis9UL8rLQK+rEe89Dibwj/eSjjarGRIak4Qhdk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=e2ObiOYU; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e675181ceaso715341a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 02:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710495016; x=1711099816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uJKtKRMFEMeF4Mmf4g2WQiKCZWOmuVmsbV5eFf6Z+B0=;
        b=e2ObiOYUFdkW9KSggox7HjtIEjCaEdRfc3S5G3Vpfh2B0P6llAaF+rYcw4EbK+CDAe
         8D8AAf6v466RRPLkWEnnCJHtZkdECd0cBiGIfC2V6dzJTbNrFGrMbyIwA8JqI705nkfL
         eohskW9tGqGV2Vt3IvUzCfGFxPi0nZvxWTVAtSPiIoSTfXP3eL8PvzxSQNIYYCMI1vrD
         dSpN0jpEtGDM3yCbvzFf/kCqHD8PGpiLJ6kLuqcgB85es3uapOlN+bIyVdGVY8rYpNnO
         /pHq/Ds0W1i1ei+sOXxcmwOZQiZ0NS9o44ASirWiGEpZZ63ZXHoiHPJFPejfd6FSgSYA
         GrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710495016; x=1711099816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJKtKRMFEMeF4Mmf4g2WQiKCZWOmuVmsbV5eFf6Z+B0=;
        b=r2wsQsrozJm7ouYHGoMExSeqw1QiNp/GfSl28dPRBf1DoP9e1XZXlQenRftPQ7/9Uq
         yeNwjn+UjPLYemIJsngmPcpJ1R0askUX5E2Rd3ko/YaV/j+SVQXfYngBhJpSfz/vahGp
         z21yoe7b5xDOARrYEDFJBf+VEn0bGD6ciytrNjpArOOcP6f4nz/sNM73AX915yQ/ZnuO
         S7v+YZcMZz9IdBMc1cyaUmDzOCUefxYj5UlTamlIzJWDtQDDInD3FYDAbp21KndcrNu4
         DGQpRsb54yrwWAK/Yj8fKU7Enm1+RPAvjE222dDti0imgF6qiF6zNo4tLxV3Sx26eg8E
         BGGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbeVPfD7SMm4rt0I4HQ3oQ1toMRr8ydo7QSFdIeBfs2wZgzIhVCaFq5D95uHfbtVvvS/TqADrz/kiYHDYM/2aMS7pmYwrFdSzorFu1
X-Gm-Message-State: AOJu0YztdP10V0gm8MJU+E50Uf4a+Zx752U+W3lsyzvOZ5gGZJ8rYjS1
	PqJg0B+DqS5q0dHlWg4rLdYyo+v6I170sEZIl8AqS3ytRxZM54E9YKfsG36+CBg=
X-Google-Smtp-Source: AGHT+IFp2YoYUbwxHkcAKgs6oStQ1bHx0LsiJ10qDtFcXvMcWAyBXweqXXH4+sXdBr0mHY4jwRrJgA==
X-Received: by 2002:a05:6830:928:b0:6e5:23d8:a4c5 with SMTP id v40-20020a056830092800b006e523d8a4c5mr4159356ott.34.1710495016530;
        Fri, 15 Mar 2024 02:30:16 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id b18-20020a630c12000000b005dca5caed40sm2072175pgl.81.2024.03.15.02.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 02:30:15 -0700 (PDT)
Date: Fri, 15 Mar 2024 05:30:10 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] mm: cachestat: avoid bogus workingset test during
 swapping & invalidation races
Message-ID: <20240315093010.GB581298@cmpxchg.org>
References: <20240314164941.580454-1-hannes@cmpxchg.org>
 <1551fa14-2a95-49fd-ab1a-11c38ae29486@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551fa14-2a95-49fd-ab1a-11c38ae29486@linux.dev>

On Fri, Mar 15, 2024 at 11:16:35AM +0800, Chengming Zhou wrote:
> On 2024/3/15 00:49, Johannes Weiner wrote:
> > When cachestat against shmem races with swapping and invalidation, the
> > shadow entry might not exist: swapout IO is still in progress and
> > we're before __remove_mapping; or swapin/invalidation/swapoff has
> > removed the shadow from swapcache after we saw a shmem swap entry.
> > 
> > This will send a NULL to workingset_test_recent(). The latter purely
> > operates on pointer bits, so it won't crash - node 0, memcg ID 0,
> > eviction timestamp 0, etc. are all valid inputs - but it's a bogus
> > test. In theory that could result in a false "recently evicted" count.
> 
> Good catch!
> 
> > 
> > Such a false positive wouldn't be the end of the world. But for code
> > clarity and (future) robustness, be explicit about this case.
> > 
> > Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
> > Reported-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  mm/filemap.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 222adac7c9c5..a07c27df7eab 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -4199,6 +4199,9 @@ static void filemap_cachestat(struct address_space *mapping,
> >  				swp_entry_t swp = radix_to_swp_entry(folio);
> >  
> 
> IIUC, we should first check if it's a real swap entry using non_swap_entry(), right?
> Since there maybe other types of entries in shmem.

Good point, it could be a poisoned entry. I'll add the
non_swap_entry() check on swp.

> And need to get_swap_device() to prevent concurrent swapoff here,
> get_shadow_from_swap_cache() won't do it for us.

We're holding rcu_read_lock() for the xarray iteration, so if we see
the swap entry in the shmem mapping, it means we beat shmem_unuse()
and swapoff hasn't run synchronize_rcu() yet.

So it's safe. But I think it could use a comment. Maybe the
documentation of get_swap_device() should mention this option too?

