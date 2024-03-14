Return-Path: <linux-kernel+bounces-103261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69DF87BD22
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C181F23D3F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47335B5B6;
	Thu, 14 Mar 2024 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSaR2vE1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A92C5A78A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421172; cv=none; b=b8Iawv7GDj2NUes0GLXm+aGLBU9CQDiPHWO+M/XGxvBAflgtpcwaj/gbLAyj1JeHZ3RRcwmwYJW9lFfyS+OvXpRDwJXibxI0HpVxd1AoH6VUUgcdIhuymqA/j7Z4BbNAVXUQ3SVtorUaQ/D3KFo0BFDQktnOVFJNPqgx2FQUgDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421172; c=relaxed/simple;
	bh=yVKWvtTcilhjLoZ+TCPRFpuKTw3Iw+UQUwWQlErhy+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obubffJNFL9FfTBNqjBztuHwOZvlngmiFZjRB6g22XdCryana6QO6xSdmSFvmBAysziYx5KGvVWWiJ4YdZw5264BmrpvLzG/BY8WZiiR/gaJCizXnz5PMSCbKjS51wDEePIU5y+ywR0Az3Ns65M92OCapLAceQoeyZT537hnxfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSaR2vE1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710421169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jKCzOVXDDLeWui+9xMnOflGFcsiyeRgIZTuCOA+l7OQ=;
	b=dSaR2vE1rU3Gnl/T8xSffNMNi88szzSueQV13TvvBalN/AdPVq9Ov+nn0E+ZfCm+fTYunp
	bxNc5qaajufWsHRWiO+rh22T9fOeqLcvGfBpEW8R5/b94nQ7+5aO/74SxU0top+MzSVwNT
	7tF0nuLDRatjXqBQaWAjIuNkwVeHNO0=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-DKrn_YalNFWWHJcRfkGRmw-1; Thu, 14 Mar 2024 08:59:27 -0400
X-MC-Unique: DKrn_YalNFWWHJcRfkGRmw-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4d424421d4aso121574e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710421167; x=1711025967;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKCzOVXDDLeWui+9xMnOflGFcsiyeRgIZTuCOA+l7OQ=;
        b=rjaNoFzL5w8y3a12RYa4MrgJjQDestKTbd6MyUFgJw2SoI9QVXmsvo5qa6MItqVTSN
         avHkD027skjsNT/wiHTogZ1ciZoDmWCpdJst38Gf0HRc5UEwVjK1V1Ca8rvki80qxqyg
         3isU/Ym6Uh5gpwuT/c/CFyManH4jlHLBr+umWwpy+yo8IJN2RuiCVD2Y0OpZB9nqRC/D
         +op7jO1zT/P5445vS35+J4VxKyzjubsmHboQ2lKstbcDJOmjVbpg2wothl00crGR3VV0
         K8xHdETb2PCJQmauSJnh7Tw9VZEtBQ8QLC9JQvV9gu2McklKI+ccHkjdcUD9S3pUQS58
         /S0A==
X-Gm-Message-State: AOJu0YyMp69Kxle3OZuwlbq6ao7uQKq+sF8GOCh2CIemwqqxFU8Lk3vH
	c6m9VgD8i8YGB1ojFgoEBTKg8HFbVEkjpQ6qzKoCqNo3PIxOPmt3lAPy5x2QepQKxfAUqg98bZi
	hmru/hm0lBbe/RJEPHU/5h4Y3JQVrmkQg7kaY4MYPjjhKO4KNe6OIMtDmWXWEeg==
X-Received: by 2002:a67:f405:0:b0:476:7cf:5495 with SMTP id p5-20020a67f405000000b0047607cf5495mr1410169vsn.3.1710421167227;
        Thu, 14 Mar 2024 05:59:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpB2lM/GBtztEZpRh5zxenkJs3cKW/cbCqzpceWYQibEUdWkJxv7eCQPooUilH8iyb4M7ppQ==
X-Received: by 2002:a67:f405:0:b0:476:7cf:5495 with SMTP id p5-20020a67f405000000b0047607cf5495mr1410155vsn.3.1710421166816;
        Thu, 14 Mar 2024 05:59:26 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id q14-20020a05621419ee00b00690edd77658sm413155qvc.75.2024.03.14.05.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 05:59:26 -0700 (PDT)
Date: Thu, 14 Mar 2024 08:59:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"x86@kernel.org" <x86@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 11/13] mm/treewide: Replace pXd_huge() with pXd_leaf()
Message-ID: <ZfL0qh0re5BpYGba@x1n>
References: <20240313214719.253873-1-peterx@redhat.com>
 <20240313214719.253873-12-peterx@redhat.com>
 <0f929f80-92fd-4824-a7d6-839f1aef4c8a@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f929f80-92fd-4824-a7d6-839f1aef4c8a@csgroup.eu>

On Thu, Mar 14, 2024 at 08:50:20AM +0000, Christophe Leroy wrote:
> 
> 
> Le 13/03/2024 à 22:47, peterx@redhat.com a écrit :
> > From: Peter Xu <peterx@redhat.com>
> > 
> > Now after we're sure all pXd_huge() definitions are the same as pXd_leaf(),
> > reuse it.  Luckily, pXd_huge() isn't widely used.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   arch/arm/include/asm/pgtable-3level.h | 2 +-
> >   arch/arm64/include/asm/pgtable.h      | 2 +-
> >   arch/arm64/mm/hugetlbpage.c           | 4 ++--
> >   arch/loongarch/mm/hugetlbpage.c       | 2 +-
> >   arch/mips/mm/tlb-r4k.c                | 2 +-
> >   arch/powerpc/mm/pgtable_64.c          | 6 +++---
> >   arch/x86/mm/pgtable.c                 | 4 ++--
> >   mm/gup.c                              | 4 ++--
> >   mm/hmm.c                              | 2 +-
> >   mm/memory.c                           | 2 +-
> >   10 files changed, 15 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> > index e7aecbef75c9..9e3c44f0aea2 100644
> > --- a/arch/arm/include/asm/pgtable-3level.h
> > +++ b/arch/arm/include/asm/pgtable-3level.h
> > @@ -190,7 +190,7 @@ static inline pte_t pte_mkspecial(pte_t pte)
> >   #define pmd_dirty(pmd)		(pmd_isset((pmd), L_PMD_SECT_DIRTY))
> >   
> >   #define pmd_hugewillfault(pmd)	(!pmd_young(pmd) || !pmd_write(pmd))
> > -#define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
> > +#define pmd_thp_or_huge(pmd)	(pmd_leaf(pmd) || pmd_trans_huge(pmd))
> 
> Previous patch said pmd_trans_huge() implies pmd_leaf().

Ah here I remember I kept this arm definition there because I think we
should add a patch to drop pmd_thp_or_huge() completely.  If you won't mind
I can add one more patch instead of doing it here.  Then I keep this patch
purely as a replacement patch without further changes on arch-cleanups.

> 
> Or is that only for GUP ?

I think it should apply to all.

> 
> >   
> >   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >   #define pmd_trans_huge(pmd)	(pmd_val(pmd) && !pmd_table(pmd))
> 
> 
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index c95b9ec5d95f..93aebd9cc130 100644
> > --- a/mm/hmm.c
> > +++ b/mm/hmm.c
> > @@ -429,7 +429,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
> >   		return hmm_vma_walk_hole(start, end, -1, walk);
> >   	}
> >   
> > -	if (pud_huge(pud) && pud_devmap(pud)) {
> > +	if (pud_leaf(pud) && pud_devmap(pud)) {
> 
> Didn't previous patch say devmap implies leaf ? Or is it only for GUP ?

This is an extra safety check that I didn't remove.  Devmap used separate
bits even though I'm not clear on why.  It should still imply a leaf though.

Thanks,

> 
> >   		unsigned long i, npages, pfn;
> >   		unsigned int required_fault;
> >   		unsigned long *hmm_pfns;
> 
> 

-- 
Peter Xu


