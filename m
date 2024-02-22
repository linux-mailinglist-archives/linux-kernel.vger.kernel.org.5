Return-Path: <linux-kernel+bounces-76057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79F685F26E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5681F1F214ED
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6679A17C9B;
	Thu, 22 Feb 2024 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxxz19jE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612917BD9
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589097; cv=none; b=JjWg/eIzSO5IC1tviXmvKx/y2Bcv1WR4H71FsD9iJNbLoj/fo10V3E3qrmU2U667mUe0ZqQPLNkQkAxbBY8nRSs15mkuEauBqPmLjfbSDrA1BGfDoxUZxDuIZ6gv4hwV/mGJKRqjLbStTphHil5G0amNiJ7wbNxIVopJ07UmwN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589097; c=relaxed/simple;
	bh=xv7ZGBVTVz5CYCrEU7gRF98qLi999UCjY6IunUI60oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZPFpTkx6j0kGd4jQS5+Ra3s9gWVC+W7y4eu5Z6vn2mbOuS3HGa1uUMyz2+t254XlO3cLsc0BwUMLrL1hPa0GF116RTlULxab8LWz9nT5PqrduQgwE/xiWO7vnYL5xKa1aSFs6NMIgKyUUVGv8H4OSAIDOjjU+TD1I1sNNqQLXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fxxz19jE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708589094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Qz0IA0kUehz+OG0swe7slV1s58KjzFRhgWAnSqUkqI=;
	b=fxxz19jESmDTBE6Ttcpn4CluMCZmCDheD1gdMQcQzbyCS7U8umZ4dea9kAzxwJ1VM7PWpZ
	AUKgAegVR7lq1rJ/jqpNurTKJyPyNPUY/Ge57mZt4257swRszsZPi94axgGr6CHs68rmAR
	lm//rBceeo18txFywinYPPS9IHSDi4g=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-PBdCM1ZqOkupOalYoJOCuQ-1; Thu, 22 Feb 2024 03:04:53 -0500
X-MC-Unique: PBdCM1ZqOkupOalYoJOCuQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6e46611af43so635794a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708589092; x=1709193892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Qz0IA0kUehz+OG0swe7slV1s58KjzFRhgWAnSqUkqI=;
        b=wx0a4CDKx0xU5gxw/guAKE6jaeApqOvJ3P5dISVSPtnuHCGAiGG2MMN7G6wziFG8GM
         Cv2OlrNfLwpr1di4F+l4rW9C9rgt5JU/mMEy6R4wy/afzvY08/s0O2D87/TjvuWh/QwI
         Jw/FnRnhkbdvw7GxD6bHwsdKc4X2jsDHo4QpnzJLYiy8gy26wKL0ITy8IXstlnkIlg9Z
         Dg/L6sTk0cNG0mtHdVuxNkfluVmwiaNWx5LBDWLKl7u0fMjjhTeIk/JwjQaY7HDOWp4t
         Hj+bWwlGt2w0W4IrU8vVIw4xePanZDWxZvI+nY3asiQ9MZqRwe2jz5heb4+V38uqdA/Q
         r9Bg==
X-Forwarded-Encrypted: i=1; AJvYcCX8e5/A7N/yg/wGdXi5yo8DbTbXgOrn8LkUHBTKjNh94TT/QuOenI/HrOhqCg9W2UM29jIFs84liEj+zEdW6uJpeq1HL+GiW+0gGAtk
X-Gm-Message-State: AOJu0YxSMjbGwg7gr8dZsaqQm7WHPKrL2Ic7LDmDlJbpMjbJrqJ6Kb/p
	94n318O3Hih1e7Dt8IfApsJdLIhS/dTgsJdDDtsWIurZ3SAnPlxq+0a1iXiXOyFYDjeq81nTNbn
	Uc6uoPCSafhss8nfhC+dWepdbqWm3OU8hu3dwgeA248G72ZnnK/ATJcv4TQy+3w==
X-Received: by 2002:a05:6359:4113:b0:176:6149:5558 with SMTP id kh19-20020a056359411300b0017661495558mr16051641rwc.1.1708589092290;
        Thu, 22 Feb 2024 00:04:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZ/pl9m1WfSqai2cvVXv5Lf1ZKvJ4xKR9ln5/WSKPeld/1kI04FNn1XDkCL6gJC29eFxMWrw==
X-Received: by 2002:a05:6359:4113:b0:176:6149:5558 with SMTP id kh19-20020a056359411300b0017661495558mr16051606rwc.1.1708589091922;
        Thu, 22 Feb 2024 00:04:51 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a21-20020a056a0011d500b006e0d1e6036bsm10300214pfu.129.2024.02.22.00.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:04:51 -0800 (PST)
Date: Thu, 22 Feb 2024 16:04:38 +0800
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Yang Shi <shy828301@gmail.com>, linux-riscv@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Mike Rapoport <rppt@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Jones <andrew.jones@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 03/13] mm: Provide generic pmd_thp_or_huge()
Message-ID: <ZdcAFpRijQdaYV2A@x1n>
References: <20240103091423.400294-1-peterx@redhat.com>
 <20240103091423.400294-4-peterx@redhat.com>
 <20240115175551.GP734935@nvidia.com>
 <ZdXEYfs_xhS_9gRo@x1n>
 <20240221125753.GQ13330@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221125753.GQ13330@nvidia.com>

On Wed, Feb 21, 2024 at 08:57:53AM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 21, 2024 at 05:37:37PM +0800, Peter Xu wrote:
> > On Mon, Jan 15, 2024 at 01:55:51PM -0400, Jason Gunthorpe wrote:
> > > On Wed, Jan 03, 2024 at 05:14:13PM +0800, peterx@redhat.com wrote:
> > > > From: Peter Xu <peterx@redhat.com>
> > > > 
> > > > ARM defines pmd_thp_or_huge(), detecting either a THP or a huge PMD.  It
> > > > can be a helpful helper if we want to merge more THP and hugetlb code
> > > > paths.  Make it a generic default implementation, only exist when
> > > > CONFIG_MMU.  Arch can overwrite it by defining its own version.
> > > > 
> > > > For example, ARM's pgtable-2level.h defines it to always return false.
> > > > 
> > > > Keep the macro declared with all config, it should be optimized to a false
> > > > anyway if !THP && !HUGETLB.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  include/linux/pgtable.h | 4 ++++
> > > >  mm/gup.c                | 3 +--
> > > >  2 files changed, 5 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > > > index 466cf477551a..2b42e95a4e3a 100644
> > > > --- a/include/linux/pgtable.h
> > > > +++ b/include/linux/pgtable.h
> > > > @@ -1362,6 +1362,10 @@ static inline int pmd_write(pmd_t pmd)
> > > >  #endif /* pmd_write */
> > > >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> > > >  
> > > > +#ifndef pmd_thp_or_huge
> > > > +#define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
> > > > +#endif
> > > 
> > > Why not just use pmd_leaf() ?
> > > 
> > > This GUP case seems to me exactly like what pmd_leaf() should really
> > > do and be used for..
> > 
> > I think I mostly agree with you, and these APIs are indeed confusing.  IMHO
> > the challenge is about the risk of breaking others on small changes in the
> > details where evil resides.
> 
> These APIs are super confusing, which is why I brought it up.. Adding
> even more subtly different variations is not helping.
> 
> I think pmd_leaf means the entry is present and refers to a physical
> page not another radix level.
> 
> > > eg x86 does:
> > > 
> > > #define pmd_leaf	pmd_large
> > > static inline int pmd_large(pmd_t pte)
> > > 	return pmd_flags(pte) & _PAGE_PSE;
> > > 
> > > static inline int pmd_trans_huge(pmd_t pmd)
> > > 	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
> > > 
> > > int pmd_huge(pmd_t pmd)
> > >         return !pmd_none(pmd) &&
> > >                 (pmd_val(pmd) & (_PAGE_PRESENT|_PAGE_PSE)) != _PAGE_PRESENT;
> > 
> > For example, here I don't think it's strictly pmd_leaf()? As pmd_huge()
> > will return true if PRESENT=0 && PSE=0 (as long as none pte ruled out
> > first), while pmd_leaf() will return false; I think that came from
> > cbef8478bee5. 
> 
> Yikes, but do you even want to handle non-present entries in GUP
> world? Isn't everything gated by !present in the first place?

I am as confused indeed.

> 
> > Besides that, there're also other cases where it's not clear of such direct
> > replacement, not until further investigated.  E.g., arm-3level has:
> > 
> > #define pmd_leaf(pmd)		pmd_sect(pmd)
> > #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
> > 						 PMD_TYPE_SECT)
> > #define PMD_TYPE_SECT		(_AT(pmdval_t, 1) << 0)
> > 
> > While pmd_huge() there relies on PMD_TABLE_BIT ()
> 
> I looked at tht, it looked OK.. 
> 
> #define PMD_TYPE_MASK               (_AT(pmdval_t, 3) << 0)
> #define PMD_TABLE_BIT               (_AT(pmdval_t, 1) << 1)
> 
> It is the same stuff, just a little confusingly written

True, my eyes decided to skip all the shifts. :-( Ok then, let me see
whether I can give it a stab on the pXd_huge() mess.

Thanks,

-- 
Peter Xu


