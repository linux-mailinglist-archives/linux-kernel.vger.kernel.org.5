Return-Path: <linux-kernel+bounces-138981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5145389FCF0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA21F1F221C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EF617A937;
	Wed, 10 Apr 2024 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxM7bIKO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A98CEC3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766833; cv=none; b=ccqzUpsMrIBUkI6E3+U/PjrKdppNYjj/BbMl3LzEPnTZub9A67UXK1j3Kl4iICyqDM6XDXlWz4ucFNbZEuEAXWfp0TEDcQXRib0D7WbhW7iZQbzJaJ0BaOcaJl/g5ADfPRUNeUB+6OuzBc6XdlkKrvg552I69YxW2Grho1Ta4wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766833; c=relaxed/simple;
	bh=UMS/eyWgwHQ3yM65JOAqgS7M+xl3pWqS5ZqjDWpiBFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WM2Uw+UhcB7wKYtXD57uuAvCyqoYot7ShNhR0C0wxwQIiJjk8ZOZ0AA8x12bIGVeui3Kv3Lsc80fK6MeQZQJBqyUGsmKlFvbl6ZqCBaI4MbIe+JTMDr5M2y4rb5VtglUTv139i6k9h6NUS56j9Ewdn10NyjXY1Gm4uf2T5WM9To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxM7bIKO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712766831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqUP56LAHm5QWmZInX2pt0/23Oe37lP9qAH/Ei2rnL0=;
	b=UxM7bIKO2WG4xHB55887S6UcB8fNuQYTbOv4jmlVxY66c27gi4DLEEuZKJ1DMtYLPE41lP
	NlJQo1BqYGNXBAsBejLt7RKFhb0aVptbHMZs9u8TRgk6b5jOpvdR9cdjq+UFC/N6iVtCt+
	Wbk25ubNs7Wh2WeBmqPfy+6IzWER4Rs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-n2TiKQZ1OEOUGppaDdzyZw-1; Wed, 10 Apr 2024 12:33:49 -0400
X-MC-Unique: n2TiKQZ1OEOUGppaDdzyZw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-69627b26a51so2104366d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712766829; x=1713371629;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqUP56LAHm5QWmZInX2pt0/23Oe37lP9qAH/Ei2rnL0=;
        b=PFVRJEfvI64rv61KdEhklDm8YweMfRJXMT96meK5IemSL4/5EqNLuVMIZxn9gpavSH
         QZMzZ0bJW5s8tW5agRNiBSfne+jPg4v5LF8EyBDADkvRGO2/6cu9JeH7+F9KDMVcIcpA
         8Ql6aOixcNcdUEFOxk1dKP7hG4zmb7cACUsdW8xA7WZhOaeTvFZmaYZ1214HNdMSmutY
         DoBhEJ4WNfQXwkDl2ro4eGvYr1bIU52OKLYvw2eEjAeiSS3za+gbq0buMVC0tnBReXI2
         855DdbbFJIA8eOHVekPlTslbH2cp1jWcb/6Mt2IZr7oV58FZPy/hCqY+a4IC9GWyg7TI
         deWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8gDdilzOBbYtrsAvucqCmAe6bxTpwwtHuy6hZv8aWng4VxiiFbRmAPMJgmP+rGyJKCUWui2F2vUfi8gmqK6N8rnd8YLAlsaRrrUo5
X-Gm-Message-State: AOJu0YzDiKCbvBBhhVgklxhusLDROBT5CXu7cRup6g7hSU1RwSZ07nuZ
	nGg/13WjwhJe1GnObLYyEJ+t0cNN+Imy83qVXNM7LC2YAgWFusUpZV4J23yuXwkNKb76vyBBoOZ
	QulWjqjNK7Aa3/NtbmsDoTIPpr96nJ7oRVI+uY0+t/2Pq8tufB/fulUNHNd6PBQ==
X-Received: by 2002:a05:6214:3018:b0:699:4a1:e12d with SMTP id ke24-20020a056214301800b0069904a1e12dmr3340431qvb.0.1712766829186;
        Wed, 10 Apr 2024 09:33:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhHEeK0Z21Hv+XY+0uQzZDjNJnCyA6fiR8by+XEvbvIcY63kybP9mgoWUYTyVjx2wWFUSKrg==
X-Received: by 2002:a05:6214:3018:b0:699:4a1:e12d with SMTP id ke24-20020a056214301800b0069904a1e12dmr3340388qvb.0.1712766828551;
        Wed, 10 Apr 2024 09:33:48 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id u10-20020a05621411aa00b0069b407ac4fasm529376qvv.6.2024.04.10.09.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 09:33:48 -0700 (PDT)
Date: Wed, 10 Apr 2024 12:33:46 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, hughd@google.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, iii@linux.ibm.com,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] mm/shmem: Inline shmem_is_huge() for disabled
 transparent hugepages
Message-ID: <Zha_auw6yBx0YRWQ@x1n>
References: <20240409155407.2322714-1-sumanthk@linux.ibm.com>
 <594dbec7-b560-44e5-a684-93dcb8ba85df@redhat.com>
 <Zhavr9NxvayDhU9X@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <29b613a8-f0d5-4f5f-adbc-d64ed8908044@redhat.com>
 <Zha5V0QxODZR4qOW@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <1ce2fe6c-b56a-4582-a5d8-babc8fccef52@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ce2fe6c-b56a-4582-a5d8-babc8fccef52@redhat.com>

On Wed, Apr 10, 2024 at 06:12:34PM +0200, David Hildenbrand wrote:
> On 10.04.24 18:07, Sumanth Korikkar wrote:
> > On Wed, Apr 10, 2024 at 05:51:28PM +0200, David Hildenbrand wrote:
> > > On 10.04.24 17:26, Sumanth Korikkar wrote:
> > > > On Wed, Apr 10, 2024 at 02:34:35PM +0200, David Hildenbrand wrote:
> > > > > On 09.04.24 17:54, Sumanth Korikkar wrote:
> > > > > > In order to  minimize code size (CONFIG_CC_OPTIMIZE_FOR_SIZE=y),
> > > > > > compiler might choose to make a regular function call (out-of-line) for
> > > > > > shmem_is_huge() instead of inlining it. When transparent hugepages are
> > > > > > disabled (CONFIG_TRANSPARENT_HUGEPAGE=n), it can cause compilation
> > > > > > error.
> > > > > > 
> > > > > > mm/shmem.c: In function ‘shmem_getattr’:
> > > > > > ./include/linux/huge_mm.h:383:27: note: in expansion of macro ‘BUILD_BUG’
> > > > > >      383 | #define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })
> > > > > >          |                           ^~~~~~~~~
> > > > > > mm/shmem.c:1148:33: note: in expansion of macro ‘HPAGE_PMD_SIZE’
> > > > > >     1148 |                 stat->blksize = HPAGE_PMD_SIZE;
> > > > > > 
> > > > > > To prevent the possible error, always inline shmem_is_huge() when
> > > > > > transparent hugepages are disabled.
> > > > > > 
> > > > > 
> > > > > Do you know which commit introduced that?
> > > > Hi David,
> > > > 
> > > > Currently with CONFIG_CC_OPTIMIZE_FOR_SIZE=y and expirementing with
> > > > -fPIC kernel compiler option, I could see this error on s390.
> > > 
> > > Got it. I assume on Linus' tree, not mm/unstable?
> > 
> > It's not yet upstream.
> > > 
> > > > 
> > > > However, default kernel compiler options doesnt end up with the above
> > > > pattern right now.
> > > 
> > > Okay, just asking if this is related to recent HPAGE_PMD_SIZE changes:
> > > 
> > > commit c1a1e497a3d5711dbf8fa6d7432d6b83ec18c26f
> > > Author: Peter Xu <peterx@redhat.com>
> > > Date:   Wed Mar 27 11:23:22 2024 -0400
> > > 
> > >      mm: make HPAGE_PXD_* macros even if !THP
> > > 
> > > Which is still in mm-unstable and not upstream.
> > 
> > Not related to this commit. I tried on master branch.
> 
> Thanks! Can you try with Peters patch? (ccing Peter)
> 
> If I am not wrong, that should also resolve the issue you are seeing.

David,

Do you mean this one?

https://lore.kernel.org/all/20240403013249.1418299-4-peterx@redhat.com/

That's indeed similar but that was for pud_pfn() not HPAGE_* stuff.

I just had a quick look, Sumanth's fix looks valid, and IIUC the goal is
also that we should keep these build checks around for the long term goal
(Jason definitely preferred that [1] too, which I agree).

I removed that build check there for pud_pfn just to avoid other build
fallouts for other archs as a temporary measure.  For this one if it's in
common code for a long time and if it's the single spot maybe it's nice to
have this patch as proposed, as it means it optimizes the if check too
besides fixing the build error.  After all referencing HPAGE_* with
!THP+!HUGETLB shouldn't happen logically.

[1] https://lore.kernel.org/r/20240404112404.GG1723999@nvidia.com

Thanks,

-- 
Peter Xu


