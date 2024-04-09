Return-Path: <linux-kernel+bounces-137137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B545C89DD67
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40AE1C210F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7668780619;
	Tue,  9 Apr 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Z5npzQD+"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B9B101EC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674670; cv=none; b=Wi3UV4ySndAaKVRvtYrUvE9WxvMqT0DmTVo7w8DtBuKP68Owk3UHOPmPLbaK7cDCb56LMS+TPYH6adAKGJv+hO2A6nGAYspqH6s+M/aCBlGNyO83JSjfEZzs/Vkq7j2DlKuWTNb3ysXvanYFH0SkAqb3EHJ3TYX3KHwXBqMZgSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674670; c=relaxed/simple;
	bh=+rERABquUHVnqfnzmkwXHkN1pl5WCYHFDsLhJodDQ9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKd8gWjvKArDpjmyuzPTu7OHajNSLD+xXfYcjJA8LEZ90FMyWXtDvyT/X4BqsJPg9PvE4CK/fUseX0zqDwRjXuajp2uFPP25ovxO3BGXdXf8bD4XV2xJY0muDrjY21i6daGjPal77p8j1JbaxuH/dLXTctFxdh3h4kGT7G3+vCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Z5npzQD+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so2106895ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 07:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712674668; x=1713279468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KRtG0O9PlGLuqvqnFnAE4sDUuRarxdCuMY2hGSYEjvM=;
        b=Z5npzQD+1dnSQnQT5oHQ0jp5YBxBjtzOO2KVzxJt34skaxXHt8kSNTtXaBsGMD+ySV
         Ng+BmigZmUrur2sP/hJkICBGdrfK1Se+/ljzGtGFPCkqVBWPle2JdbpHPkCLX0j5Z2j+
         6FrkV2v/PQa2ycSn0tS7MTYYzmWmC6lP3ImXQl0pEqFQGV4Il17gxLL1OhMwA+MkFQff
         t8KkELgDJ6aQASoSxWGoOffKF4eCknrFEGzVZQdtQEicHF1NG5uxZ9AOSrsmYBzV4YuO
         /DbIGVx59vrk5rwtwRnUkd3mrZog6tLTAM/Cr5QiksM21OLU6pTrCRrEyOcGn4rhlLjg
         BWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712674668; x=1713279468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRtG0O9PlGLuqvqnFnAE4sDUuRarxdCuMY2hGSYEjvM=;
        b=ZRGKt02Q/G08hToi6Kwu1rIenxmFx+IELky1XpbjJRMQuzaux6FwEFqZUx37UhfWp2
         0dOaKYTqLx0UBuzIcNfhPAJEmRIOK8nilg/oEJhhyIjKUt2LF3UOSpaqzO+jdBfWphnS
         MUORihk4YlZoVrUwv8Wql1P+GFrMI/Axr2yoB+KgFs9PgI0tcXCXXQOfM7kB8dMPl7IG
         ccYZXpKtSpLQPZlMSDJgtc6N0RvsthYw3asZBNGrPYyXHHcg2KaeHgJjpTPcto9Z9dPa
         F9nChv96bxUlqsVBVf5sLTsnCvXcudBIKfy386zplFD3k2g5ybCkV/oJS2eKQxEoRXTq
         zplA==
X-Forwarded-Encrypted: i=1; AJvYcCVb7Yff531mDMgSYXktwkqDfkTtiHx/Mr+wcZjcxlyw67gMAl83d2H+Eq+hO2f8tvFfF1LUx8Ppv+NqiOkG71bLCzeUwrJ+2884JiKL
X-Gm-Message-State: AOJu0Yx9vz5zdw0uCau8stRzNc+Fo5zPEZ/cDu2/+IfjVRVWnZvZH33s
	DObBtMnSp2qJkH2YYootbJ0jPO8ea1D6R5/lQB2U3CztbC58WddBsC3JMeZ9Gig=
X-Google-Smtp-Source: AGHT+IGF/xNXm9cP6sPDD6qfC29r9zNqUeI9ckB1s95Y2d7+syXyy85GJYZq1XB53v/ZaK1//dFMEw==
X-Received: by 2002:a17:903:228b:b0:1e3:ce12:ef77 with SMTP id b11-20020a170903228b00b001e3ce12ef77mr4371269plh.11.1712674667750;
        Tue, 09 Apr 2024 07:57:47 -0700 (PDT)
Received: from bytedance ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902e18400b001e0287592c4sm8949899pla.267.2024.04.09.07.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 07:57:47 -0700 (PDT)
Date: Tue, 9 Apr 2024 22:57:40 +0800
From: Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, ryncsn@gmail.com,
	nphamcs@gmail.com, songmuchun@bytedance.com, david@redhat.com,
	chrisl@kernel.org, guo.ziliang@zte.com.cn, yosryahmed@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: swap: prejudgement swap_has_cache to avoid page
 allocation
Message-ID: <20240409145740.GA543696@bytedance>
References: <20240408121439.GA252652@bytedance>
 <20240408132704.f966adc8d3928df4d3b8c0a9@linux-foundation.org>
 <87edbf8hta.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edbf8hta.fsf@yhuang6-desk2.ccr.corp.intel.com>

On Tue, Apr 09, 2024 at 09:07:29AM +0800, Huang, Ying wrote:
> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> > On Mon, 8 Apr 2024 20:14:39 +0800 Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com> wrote:
> >
> >> Based on qemu arm64 - latest kernel + 100M memory + 1024M swapfile.
> >> Create 1G anon mmap and set it to shared, and has two processes
> >> randomly access the shared memory. When they are racing on swap cache,
> >> on average, each "alloc_pages_mpol + swapcache_prepare + folio_put"
> >> took about 1475 us.
> >
> > And what effect does this patch have upon the measured time?  ANd upon
> > overall runtime?
> 
> And the patch will cause increased lock contention, please test with
> more processes and perhaps HDD swap device too.

Hi Ying,

Thank you for your suggestion.
It may indeed cause some lock contention, as mentioned by Kairui before.

If so, is it recommended?
---
  unsigned char swap_map, mapcount, hascache;
  ...
  /* Return raw data of the si->swap_map[offset] */
  swap_map = __swap_map(si, entry);
  mapcount = swap_map & ~SWAP_HAS_CACHE;
  if (!mapcount && swap_slot_cache_enabled)
  ...
  hascache = swap_map & SWAP_HAS_CACHE;
  /* Could judge that it's being added to swap cache with high probability */
  if (mapcount && hascache)
    goto skip_alloc;
  ...
---
In doing so, there is no additional use of locks.

> 
> >> So skip page allocation if SWAP_HAS_CACHE was set, just
> >> schedule_timeout_uninterruptible and continue to acquire page
> >> via filemap_get_folio() from swap cache, to speedup
> >> __read_swap_cache_async.
> 
> --
> Best Regards,
> Huang, Ying

