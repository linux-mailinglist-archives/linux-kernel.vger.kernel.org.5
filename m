Return-Path: <linux-kernel+bounces-123481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5B2890945
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A90298D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D782137930;
	Thu, 28 Mar 2024 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="2f8XVu/M"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF4C1C6BD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654318; cv=none; b=XCcA3/eAYFncgBfyZ01l3csGY+zmIzgShj8rgtGnGz97jbfAI+3VVSdpd0jxWV2ZglxgPlJRQ5FBz2YupekNUkVykrR8RKrzcmBSW/3kWOnJcij3VjwEYtKq5Q/DT/zutiaclpXBfaitP6zHMHEUiE5LBulR9CnZsYbODedlFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654318; c=relaxed/simple;
	bh=vatiIdJrdRlS2MYbi4ISypIEpVHIfQtH9o7WH2N3czU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRYqe9GGqiKXEaWKWtBo7SPR5A5ZZifzmSJHU1GtTJUe26gXK1REmVXbKDLdl2J4Vpq1yj63zSPHcH6HrG3ULCJh1qaB0TtFShyi/x0eqxR4UU6h4E2sJEL0R7h5SZmKl1ZeBF7F7kZyBKS2S+YoJtWFMGAisrVgz+3cPi4vkpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=2f8XVu/M; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6986eb97f31so5274626d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711654314; x=1712259114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cLx2tAUygTKT9ZnXo1CoRPLOCNpgrVxvtKfxkgCnBAA=;
        b=2f8XVu/MnAeUvh88B5tAjLqTywOFNTfjaeNlH0794OPk9uZO2+Ow2fFUOZelzCpO5t
         HJG1grB+taQNo7Rht5MfTZVGzqkCBIZZwFZXQSsIuzlyHUVLwJMVRy/cN4GbEIgorGEh
         HgvWoEoSCvCK350jMu1Aix29mBlULEeoE4cCe8qkA3MjC8P2X+6vPe6BmVJnV+fFQFUn
         4IYrsoMILqBGAjb2GjcquPHTaaAeTqyFRgIYKAKlnakqbec9jD+kMEVbUVfS7/wYO/PF
         e3w8yXbjITL7UX/AiViuIlLv3Maov5O0+dm7rzXHHUm/G7HIOHdIz+GeWNuUVW76tpuP
         kUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711654314; x=1712259114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLx2tAUygTKT9ZnXo1CoRPLOCNpgrVxvtKfxkgCnBAA=;
        b=NietvUxxewOYVWvHYXKjqIJl1ayJYCnLS0BHU9UK+VFSTyYMMUtVgmN7qgWvVLg48R
         T9/w2WgXiocjMbBo9ZuOYl8Gn68TX4f0sSfNJrjgIfwDMtq2NbqueqAV4UrESl64IwJF
         o2krlj6pu0JVoLKgAHWSCYxBORm3TYEEzlXKVeejFaYL3w6RT8rsRXpmRPe/5trlcJ6v
         Kgtmk2MNMx7hGfoJoOJ1nb/Xp3R93yglPVIwvWEo2FBjOwATf62T8cKXFShyfXSnXYUg
         1dZ6Rf14nS7eJuNQVKu3O6w/7z6j1e5YxuYGh7qs7eR65wy1KCTgnN3nTerv8M3iYI6o
         ss3g==
X-Forwarded-Encrypted: i=1; AJvYcCXNrXhyAA/PTjPeIscdjn+uw7ZmuG3mmxAnaLw/KZe7g0MZD+gDAQWQBsnPkVlBK5SRfgjuYIkJqDhL6cJTXRzqPZVo5oLriY9HLgT0
X-Gm-Message-State: AOJu0YwTla41JgGcDfSCPycIE2KFeSAy/9BaUL7H+YFpkrPH6J8NXQwa
	tt8xR8dbjLtistG2HQRain3LdNwFHORAyQAEQQloWRszltcW15XXF27CUx8FrJw=
X-Google-Smtp-Source: AGHT+IG3oeFxi/SoH6RhVsCiO2Ck0qJVQMFlhPMiza6MKoCQGZpKInywwRvyKo1hMkhmCE3WNVSUSw==
X-Received: by 2002:a0c:fe64:0:b0:696:9aae:5d9f with SMTP id b4-20020a0cfe64000000b006969aae5d9fmr224256qvv.3.1711654314646;
        Thu, 28 Mar 2024 12:31:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:bb1f])
        by smtp.gmail.com with ESMTPSA id 9-20020a0562140d6900b006967f875b72sm901512qvs.139.2024.03.28.12.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:31:54 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:31:49 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/9] mm: zswap: drop support for non-zero same-filled
 pages handling
Message-ID: <20240328193149.GF7597@cmpxchg.org>
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-7-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325235018.2028408-7-yosryahmed@google.com>

On Mon, Mar 25, 2024 at 11:50:14PM +0000, Yosry Ahmed wrote:
> The current same-filled pages handling supports pages filled with any
> repeated word-sized pattern. However, in practice, most of these should
> be zero pages anyway. Other patterns should be nearly as common.
> 
> Drop the support for non-zero same-filled pages, but keep the names of
> knobs exposed to userspace as "same_filled", which isn't entirely
> inaccurate.
> 
> This yields some nice code simplification and enables a following patch
> that eliminates the need to allocate struct zswap_entry for those pages
> completely.
> 
> There is also a very small performance improvement observed over 50 runs
> of kernel build test (kernbench) comparing the mean build time on a
> skylake machine when building the kernel in a cgroup v1 container with a
> 3G limit:
> 
> 		base		patched		% diff
> real		70.167		69.915		-0.359%
> user		2953.068	2956.147	+0.104%
> sys		2612.811	2594.718	-0.692%
> 
> This probably comes from more optimized operations like memchr_inv() and
> clear_highpage(). Note that the percentage of zero-filled pages during
> this test was only around 1.5% on average, and was not affected by this
> patch. Practical workloads could have a larger proportion of such pages
> (e.g. Johannes observed around 10% [1]), so the performance improvement
> should be larger.
> 
> [1]https://lore.kernel.org/linux-mm/20240320210716.GH294822@cmpxchg.org/
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

This is an interesting direction to pursue, but I actually thinkg it
doesn't go far enough. Either way, I think it needs more data.

1) How frequent are non-zero-same-filled pages? Difficult to
   generalize, but if you could gather some from your fleet, that
   would be useful. If you can devise a portable strategy, I'd also be
   more than happy to gather this on ours (although I think you have
   more widespread zswap use, whereas we have more disk swap.)

2) The fact that we're doing any of this pattern analysis in zswap at
   all strikes me as a bit misguided. Being efficient about repetitive
   patterns is squarely in the domain of a compression algorithm. Do
   we not trust e.g. zstd to handle this properly?

   I'm guessing this goes back to inefficient packing from something
   like zbud, which would waste half a page on one repeating byte.

   But zsmalloc can do 32 byte objects. It's also a batching slab
   allocator, where storing a series of small, same-sized objects is
   quite fast.

   Add to that the additional branches, the additional kmap, the extra
   scanning of every single page for patterns - all in the fast path
   of zswap, when we already know that the vast majority of incoming
   pages will need to be properly compressed anyway.

   Maybe it's time to get rid of the special handling entirely?

