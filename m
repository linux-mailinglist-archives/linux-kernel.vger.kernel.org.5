Return-Path: <linux-kernel+bounces-130443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18B489782B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 030451C2170D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC541153810;
	Wed,  3 Apr 2024 18:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7wQeRaO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5516D153597
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168728; cv=none; b=nVIm3+NxA0cicc9PuCmLnUctajVO6FY1F5Ssh8mnMoqdhMJ3d+Nz272g05fIsRlPyqXuqpEKrbiaT6kYoxIy15r/m+CFOD9SevgTnvFuDRB025yIig5GepyCDAmRsIFSOuuSKfkNFUoLaWZvrDNhUrALjOPV7bZE0F22/s8M9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168728; c=relaxed/simple;
	bh=49xRMMJoQJIUdr7zdlVs8BfmW6KWUNR4b9vQnfKmZbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1gqhOby4TxkPyyBlDrDr1ggJfAyb1gBMsi3Lj+sOBfaxrcaogxh7LGm7HLVCN/IiXFF+UNbJZsTJUnTHhYjuYZBu0BEjPiqKFPAzYXHmRdB6JZBhs4tBaVcezDG9IwwIAcN3PKVT//FD+fc/2C0/YXFLLFQ3UaVq2ygnTaGxfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7wQeRaO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712168726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YXsmqoOHzY6mBushOHoxlZz3TK/EfZqT4lQukaq20AM=;
	b=P7wQeRaO8pvv+bsOulr62tjYpf9C/Ld0fZFLGcYNPH5EYnIjilLCjxadWI9eW7sFMOz2Sl
	YOtZmbPJrKk3igLm1q8w23oy+TciBsvtxjKiAoMtSgx1j9gd25lh9l5ZeYbV3Zmx4aZXY2
	s47pBu5TUZPUCNmoQImKpUIaxAbU+eE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-ktY1h6jYMaWS_RT1fk0KSA-1; Wed, 03 Apr 2024 14:25:25 -0400
X-MC-Unique: ktY1h6jYMaWS_RT1fk0KSA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-69120b349c9so127216d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 11:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712168724; x=1712773524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXsmqoOHzY6mBushOHoxlZz3TK/EfZqT4lQukaq20AM=;
        b=PTDmGtAPruISxDu+j1J8M4g/dRxASljJkdnisJIbIW/spZf3p3bu7N8qz1fGSI7Bf/
         q9HAlNzV/4vgr9uCjJcIV5L/6aLtYrHYCqTJrfWr4v4k+qQiM1Fe4+Y3cngIJFL3Zw2J
         aXhM1NRA319wuCU/xmVM7XY3hma6BUhauJKcZRTWnp8hzFSWb5r6kr0MRwgd3IGBuZpV
         FnBGHHYsQF0VV1scL7V3vFTK/M9pvpQcVSSLmXaYPrfFBB1I1g/B1xp0LZgVL5RQgltd
         bSzYhJMbWgc+2QMecV/aPaVNrzHOCWg5E7tsuLPfKJ5UlpdYaj1ZQKVvGiLm7IR8efta
         m8Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWyIG6svPUlpsCZCJEBpPWVCiDaWpEaYN16RBSnrNBjgWYCMPwmrT2QaIpE5QkZpE+wIgYBsAgSqvhrLY+T9URqC+EVBO17fMSYto6Q
X-Gm-Message-State: AOJu0YxnfqAHHYtDBrTcGKnC2XwEkcCd08iaosqewqIZ+M9lfE7hOmgH
	m4+wBZi199zVqB7xatcoq6g+qxzx1JJxm8b+5nae5lLkUtQdorB2PliBwq1CltouCw2S9PnPfHS
	EayiyMRCTzBbbPeK+hVMmzNoDLN+vMq5iia001HGIp9V+iOXKkgiETyO2LqDrgw==
X-Received: by 2002:ad4:5cab:0:b0:699:2242:4ee8 with SMTP id q11-20020ad45cab000000b0069922424ee8mr129105qvh.3.1712168724106;
        Wed, 03 Apr 2024 11:25:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOuNMZozoa6aScFD4XBgyXphotERni3kWeSwgWQ4wF27W29jsLbCwW0feeq4rwhZfTMS4o4A==
X-Received: by 2002:ad4:5cab:0:b0:699:2242:4ee8 with SMTP id q11-20020ad45cab000000b0069922424ee8mr129072qvh.3.1712168723495;
        Wed, 03 Apr 2024 11:25:23 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id s15-20020a0562140caf00b00698fd63d167sm4435500qvs.123.2024.04.03.11.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 11:25:23 -0700 (PDT)
Date: Wed, 3 Apr 2024 14:25:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Andrew Jones <andrew.jones@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	linux-arm-kernel@lists.infradead.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH v4 05/13] mm/arch: Provide pud_pfn() fallback
Message-ID: <Zg2fEP4eEeLhgDwE@x1n>
References: <20240327152332.950956-1-peterx@redhat.com>
 <20240327152332.950956-6-peterx@redhat.com>
 <20240402190549.GA706730@dev-arch.thelio-3990X>
 <ZgyKLLVZ4vN56uZE@x1n>
 <20240402225320.GU946323@nvidia.com>
 <ZgyWUYVdUsAiXCC4@xz-m1.local>
 <20240403120841.GB1723999@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240403120841.GB1723999@nvidia.com>

On Wed, Apr 03, 2024 at 09:08:41AM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 02, 2024 at 07:35:45PM -0400, Peter Xu wrote:
> > On Tue, Apr 02, 2024 at 07:53:20PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Apr 02, 2024 at 06:43:56PM -0400, Peter Xu wrote:
> > > 
> > > > I actually tested this without hitting the issue (even though I didn't
> > > > mention it in the cover letter..).  I re-kicked the build test, it turns
> > > > out my "make alldefconfig" on loongarch will generate a config with both
> > > > HUGETLB=n && THP=n, while arch/loongarch/configs/loongson3_defconfig has
> > > > THP=y (which I assume was the one above build used).  I didn't further
> > > > check how "make alldefconfig" generated the config; a bit surprising that
> > > > it didn't fetch from there.
> > > 
> > > I suspect it is weird compiler variations.. Maybe something is not
> > > being inlined.
> > > 
> > > > (and it also surprises me that this BUILD_BUG can trigger.. I used to try
> > > >  triggering it elsewhere but failed..)
> > > 
> > > As the pud_leaf() == FALSE should result in the BUILD_BUG never being
> > > called and the optimizer removing it.
> > 
> > Good point, for some reason loongarch defined pud_leaf() without defining
> > pud_pfn(), which does look strange.
> > 
> > #define pud_leaf(pud)		((pud_val(pud) & _PAGE_HUGE) != 0)
> > 
> > But I noticed at least MIPS also does it..  Logically I think one arch
> > should define either none of both.
> 
> Wow, this is definately an arch issue. You can't define pud_leaf() and
> not have a pud_pfn(). It makes no sense at all..
> 
> I'd say the BUILD_BUG has done it's job and found an issue, fix it by
> not defining pud_leaf? I don't see any calls to pud_leaf in loongarch
> at least

Yes, that sounds better too to me, however it means we may also risk other
archs that can fail another defconfig build.. and I worry I bring trouble
to multiple such cases.  Fundamentally it's indeed my patch that broke
those builds, so I still sent the change and leave that for arch developers
to decide the best for the archs.

I think if wanted, we can add that BUILD_BUG() back when we're sure no arch
will break with it.  So such changes from arch can still be proposed
alongside of removal of BUILD_BUG() (and I'd guess some other arch will
start to notice such build issue soon if existed.. so it still more or less
has similar effect of a reminder..).

Thanks,

-- 
Peter Xu


