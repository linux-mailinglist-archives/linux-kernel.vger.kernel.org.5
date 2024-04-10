Return-Path: <linux-kernel+bounces-139011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0099F89FD70
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FF5CB22AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05A917B507;
	Wed, 10 Apr 2024 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAZKST1a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5087B16EC19
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767915; cv=none; b=N/BBE6/PalCoy61wVKKTz6aIsRj9RP/yajPTsvRMyg2jB0I/l1nW8X8DxgwSuhllpfb54lqq1qr59v8Jc42OzLFxjip2g43QLu1Mjw7/nm3IaPnqBoVJYZNjikbfG9lsEpb95vtBjAwieB4/lYlRbF5TR1U9RqWILtWJPwyJnww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767915; c=relaxed/simple;
	bh=W6hcxSWg9ob2ocRpk5F329HNm3ajb6QxOhA+beuCJS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFGjW9t9Z1lbW4gqN7uS+gPYrfVuHDZykrUnzpNdeZGS6b+EsEq/RKdsXaHPu3+9Uxd7lXid44+01d0A4Jz2mZO/gWBLC3xp/BrMbHrxepJD/1f+vXFvlmvgUbjoWs7y6bv4c6CTcGZ49K5vh2owUT1dLpcn1zi6TbuJHrYb2y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAZKST1a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712767912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QFHTukiXY57xoz5RuwGszCofTpKthMowKSA+9lxkDw=;
	b=LAZKST1ahMEsBXjSnB9IKVXnYa7W6fyGDmsI9YU1n+VmyRxMs+sv01V5tG8DYMIXsmkUIo
	cYMxHarXXMOD9YJze2MFlqyQB/vGjQKb/kp2FMlZMdu0bkNRQp873+jTTwxsaRDCG0cxpg
	frPe78FI1cuG4abf09m67AQnRprg4+U=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-HrhsCzzaOFeAV3bO7U_BYw-1; Wed, 10 Apr 2024 12:51:51 -0400
X-MC-Unique: HrhsCzzaOFeAV3bO7U_BYw-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c5f0e4c257so607697b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712767910; x=1713372710;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6QFHTukiXY57xoz5RuwGszCofTpKthMowKSA+9lxkDw=;
        b=jHtYoANP0oiORM/2aA2Ut3EAGeT/OCPFcgL50JRqKEQJHHZziyU29u1WM4Nb/QlCHZ
         fTCkigUHZzjWjW6OZy1Lqxgzyv019DYMDMRENVTs0yxYh83pCcnU7dPKZ5BKui+Bxqi9
         K468bFAUDT8Qfp0fegFPTb+fFylpWu6o8w9yiioq4B+MzF0j16dAvxVZeDZF+FJDufEU
         pWz32Jc1Mmwlj//mZ/c+0oL/ak98gakQf29EBK4r6axefeERFT2Rnm5tctLbbG5gWM2/
         PhaJfXC+J2oGHaayM9wUpbMCXE0jUOiHNNHyF9FKBPl5KnIQk8IbG7QYwjBcK10FXXYl
         q3yA==
X-Forwarded-Encrypted: i=1; AJvYcCXkMutu1vEx1Jtb/K6lWaZXP3m3IW+tpU8Yr4jB+ExIAKQtsP+HjNr3XD1p9YrpzF95OPMqxu7Twg8gFkPLk3MadScNV4Ul3EGPAhY9
X-Gm-Message-State: AOJu0Yzb0FC3frq9SSN7Zn4wj+NsH5UrGnkgc3ObUZJpKuZnoVeTWCrS
	adE0KkdqnvNbNGanyjDftJKF9U/kyec+Jv6BbFFgHmkcG3naJg4GEPHqJjxr7Av1L4uPBEPVmEL
	Zeth3pNn8j0nSaH5jEP1OkdzKlz8y8ZrUYDBqiNfRV/RT7d+48bZ3c/8EG+YHLw==
X-Received: by 2002:a05:6871:e01c:b0:22e:88bd:6b26 with SMTP id by28-20020a056871e01c00b0022e88bd6b26mr3324098oac.3.1712767909971;
        Wed, 10 Apr 2024 09:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsRyU4Eg1Ca6QSjMpID+FUrJ5uo3xERUGBXUdopyEdp96asJtfX/Vaj7VBwOUDdobP6pk6bw==
X-Received: by 2002:a05:6871:e01c:b0:22e:88bd:6b26 with SMTP id by28-20020a056871e01c00b0022e88bd6b26mr3324065oac.3.1712767909305;
        Wed, 10 Apr 2024 09:51:49 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id po27-20020a05620a385b00b0078d5e60b52esm4172639qkn.114.2024.04.10.09.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 09:51:48 -0700 (PDT)
Date: Wed, 10 Apr 2024 12:51:47 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, hughd@google.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, iii@linux.ibm.com,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] mm/shmem: Inline shmem_is_huge() for disabled
 transparent hugepages
Message-ID: <ZhbDoxxFAe0QQYz_@x1n>
References: <20240409155407.2322714-1-sumanthk@linux.ibm.com>
 <594dbec7-b560-44e5-a684-93dcb8ba85df@redhat.com>
 <Zhavr9NxvayDhU9X@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <29b613a8-f0d5-4f5f-adbc-d64ed8908044@redhat.com>
 <Zha5V0QxODZR4qOW@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <1ce2fe6c-b56a-4582-a5d8-babc8fccef52@redhat.com>
 <Zha_auw6yBx0YRWQ@x1n>
 <61a3bd6b-a352-4e02-8357-81ac7b9f2848@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61a3bd6b-a352-4e02-8357-81ac7b9f2848@redhat.com>

On Wed, Apr 10, 2024 at 06:40:55PM +0200, David Hildenbrand wrote:
> On 10.04.24 18:33, Peter Xu wrote:
> > On Wed, Apr 10, 2024 at 06:12:34PM +0200, David Hildenbrand wrote:
> > > On 10.04.24 18:07, Sumanth Korikkar wrote:
> > > > On Wed, Apr 10, 2024 at 05:51:28PM +0200, David Hildenbrand wrote:
> > > > > On 10.04.24 17:26, Sumanth Korikkar wrote:
> > > > > > On Wed, Apr 10, 2024 at 02:34:35PM +0200, David Hildenbrand wrote:
> > > > > > > On 09.04.24 17:54, Sumanth Korikkar wrote:
> > > > > > > > In order to  minimize code size (CONFIG_CC_OPTIMIZE_FOR_SIZE=y),
> > > > > > > > compiler might choose to make a regular function call (out-of-line) for
> > > > > > > > shmem_is_huge() instead of inlining it. When transparent hugepages are
> > > > > > > > disabled (CONFIG_TRANSPARENT_HUGEPAGE=n), it can cause compilation
> > > > > > > > error.
> > > > > > > > 
> > > > > > > > mm/shmem.c: In function ‘shmem_getattr’:
> > > > > > > > ./include/linux/huge_mm.h:383:27: note: in expansion of macro ‘BUILD_BUG’
> > > > > > > >       383 | #define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })
> > > > > > > >           |                           ^~~~~~~~~
> > > > > > > > mm/shmem.c:1148:33: note: in expansion of macro ‘HPAGE_PMD_SIZE’
> > > > > > > >      1148 |                 stat->blksize = HPAGE_PMD_SIZE;
> > > > > > > > 
> > > > > > > > To prevent the possible error, always inline shmem_is_huge() when
> > > > > > > > transparent hugepages are disabled.
> > > > > > > > 
> > > > > > > 
> > > > > > > Do you know which commit introduced that?
> > > > > > Hi David,
> > > > > > 
> > > > > > Currently with CONFIG_CC_OPTIMIZE_FOR_SIZE=y and expirementing with
> > > > > > -fPIC kernel compiler option, I could see this error on s390.
> > > > > 
> > > > > Got it. I assume on Linus' tree, not mm/unstable?
> > > > 
> > > > It's not yet upstream.
> > > > > 
> > > > > > 
> > > > > > However, default kernel compiler options doesnt end up with the above
> > > > > > pattern right now.
> > > > > 
> > > > > Okay, just asking if this is related to recent HPAGE_PMD_SIZE changes:
> > > > > 
> > > > > commit c1a1e497a3d5711dbf8fa6d7432d6b83ec18c26f
> > > > > Author: Peter Xu <peterx@redhat.com>
> > > > > Date:   Wed Mar 27 11:23:22 2024 -0400
> > > > > 
> > > > >       mm: make HPAGE_PXD_* macros even if !THP
> > > > > 
> > > > > Which is still in mm-unstable and not upstream.
> > > > 
> > > > Not related to this commit. I tried on master branch.
> > > 
> > > Thanks! Can you try with Peters patch? (ccing Peter)
> > > 
> > > If I am not wrong, that should also resolve the issue you are seeing.
> > 
> > David,
> > 
> > Do you mean this one?
> > 
> > https://lore.kernel.org/all/20240403013249.1418299-4-peterx@redhat.com/
> > 
> 
> No, I meant:
> 
> https://lore.kernel.org/all/20240327152332.950956-4-peterx@redhat.com/
> 
> which removes the "#define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })" that we
> seem to trigger here.
> 
> 
> ... but it's been a long day, so maybe I'm all wrong :)

Ah..  So I thought it was one step further. :)

Then that shouldn't be the case; it didn't remove it but defined properly
with HPAGE_PMD_SHIFT:

+#define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)

Now we even have that properly defined for HUGETLB_PAGE, while prior to
that we should hit this issue easier (even with !THP+HUGETLB_PAGE).

> 
> > That's indeed similar but that was for pud_pfn() not HPAGE_* stuff.
> > 
> > I just had a quick look, Sumanth's fix looks valid, and IIUC the goal is
> > also that we should keep these build checks around for the long term goal
> > (Jason definitely preferred that [1] too, which I agree).
> > 
> > I removed that build check there for pud_pfn just to avoid other build
> > fallouts for other archs as a temporary measure.  For this one if it's in
> > common code for a long time and if it's the single spot maybe it's nice to
> > have this patch as proposed, as it means it optimizes the if check too
> > besides fixing the build error.  After all referencing HPAGE_* with
> > !THP+!HUGETLB shouldn't happen logically.
> > 
> > [1] https://lore.kernel.org/r/20240404112404.GG1723999@nvidia.com
> > 
> > Thanks,
> > 
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Peter Xu


