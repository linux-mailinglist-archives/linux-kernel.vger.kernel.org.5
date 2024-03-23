Return-Path: <linux-kernel+bounces-112145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B66D88763B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 01:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1811C223E4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40FEA41;
	Sat, 23 Mar 2024 00:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ac/1hIHU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FB37F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711154771; cv=none; b=EdeFJ8KkhojYm+gU1EbfsQQWxZbS/zmrl4/oEnPGmWZG9f3CJgN7a8OsSZU609fyDUNXmC9pw3hzqUnGSBPN84NSgqCH+TEC3s8kKVn/ajC0AgTt5E0LObdbcxc0SqpuQgpRDcYA2lLBLD+0gRe6b6MBy5VXS8vtoBMny3CABaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711154771; c=relaxed/simple;
	bh=9xcACmmVKZuc8/yw3nvYfa+fYalzbt5xtdS2ix9Qfa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NW/OqHd/ONpNyUaMq+XY0W/n2IwuB4elvlhCJq783oz8/NqoVVhFiheTDf/VkxjthapSvgxTQkbhFaXjpMiaMohV0DRspl/m1nB9WACdJCL23x5i4aehyqMTITutPZ94d+g8GD9sAE0RTyX36EAwHz/X4H0THgTN1fiFE+/eRAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ac/1hIHU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711154767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1OPeHdcChNLXNL4AZVVP+Dj6erLbPxRFcj0CZKU2hHc=;
	b=ac/1hIHUi10/DvPszFnqX3YgmNqMGOPRLoWiI4hswIwakW5L0Wpf5Q7mrGuajVooPlWn+X
	WOkH9Jrxelp3OpfTGP2HemSb+i01nYlE+7Pqlj3zTJH0o/njaWf0JxMn+865wLImOLA6II
	KcGbg2W8xMXSR5N7NtbriUJfnWuwlUQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-CzCTmCwtOn-IBPOWBQU28g-1; Fri, 22 Mar 2024 20:46:06 -0400
X-MC-Unique: CzCTmCwtOn-IBPOWBQU28g-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-43137863434so2173351cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711154763; x=1711759563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OPeHdcChNLXNL4AZVVP+Dj6erLbPxRFcj0CZKU2hHc=;
        b=hvDu+VHR5qEy0Z0t6wPuIuuSKzRVmlFB8SSSweazRFeuER1GGqFkXv+n29yNcdG/sW
         6Nw8L2G744zlglXgMXSWpcawekUoMUqQix910voQmtoVdJa5CoBFgpUxdG4UW8Yw+D/6
         csUrEQEEWCeVBwYFD30EwyVHNR/Hf0G08wQHrtPiLNCGV3Q/C9SVkTXchb4zljr+ZdNH
         kCMnoOxFarqGJ0xors71TOXd1ESSOYvLc2wqyxRYbvoNXbUUiv3hZx7RXrMmHSIYwKnM
         vI1uMm8/fsmMPzFQqdaqMddDPh7oAeGc0LlpZaWzcY6plAYBclIS7G8qxcEBkftSFmdb
         BKzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKMtfT9ausseJTBQA0K8wBO/KBc4hz9i94jX6p4EqDXCih2SAPDDRA29AugOcCmZrG/FffVxlmlCYMV4yl0W+17wMAOLMxSrs7jZ6j
X-Gm-Message-State: AOJu0Yyhdoqw7FuFyr1FY/ksgQhF8e7cwpa+JVn0RnQdZjsZ8LpfZ22y
	nOeGlf/17N6EsOjWTM4saRNpnrDznnxq/o5kC6xHpqTy1ndkiO6XyliV38oZGUdtSPe4EasbrfU
	XlG1MOYWOZ8be9ZpYkD7gCmL1kKvEqtdA2+s5nv8q4SwRGcHFMtJSfpePzGBitg==
X-Received: by 2002:a05:6214:3d8c:b0:696:1892:c19f with SMTP id om12-20020a0562143d8c00b006961892c19fmr1028559qvb.3.1711154762752;
        Fri, 22 Mar 2024 17:46:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxKOcFDVxpG3qeQleX58Tuq2r0TaBTmm4VWGOLqVds86GEmp/lVpAtwxST9mY/JIaYF94G+w==
X-Received: by 2002:a05:6214:3d8c:b0:696:1892:c19f with SMTP id om12-20020a0562143d8c00b006961892c19fmr1028507qvb.3.1711154762082;
        Fri, 22 Mar 2024 17:46:02 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id jf8-20020a0562142a4800b006942dcac56asm1567334qvb.103.2024.03.22.17.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 17:46:01 -0700 (PDT)
Date: Fri, 22 Mar 2024 20:45:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yang Shi <shy828301@gmail.com>, John Hubbard <jhubbard@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Andrew Jones <andrew.jones@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Christoph Hellwig <hch@infradead.org>,
	linux-riscv@lists.infradead.org,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 12/12] mm/gup: Handle hugetlb in the generic
 follow_page_mask code
Message-ID: <Zf4mR_OxE5Ft4VJg@x1n>
References: <20240321220802.679544-1-peterx@redhat.com>
 <20240321220802.679544-13-peterx@redhat.com>
 <20240322134818.9b312f77629f79fcf1564b6f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240322134818.9b312f77629f79fcf1564b6f@linux-foundation.org>

On Fri, Mar 22, 2024 at 01:48:18PM -0700, Andrew Morton wrote:
> On Thu, 21 Mar 2024 18:08:02 -0400 peterx@redhat.com wrote:
> 
> > From: Peter Xu <peterx@redhat.com>
> > 
> > Now follow_page() is ready to handle hugetlb pages in whatever form, and
> > over all architectures.  Switch to the generic code path.
> > 
> > Time to retire hugetlb_follow_page_mask(), following the previous
> > retirement of follow_hugetlb_page() in 4849807114b8.
> > 
> > There may be a slight difference of how the loops run when processing slow
> > GUP over a large hugetlb range on cont_pte/cont_pmd supported archs: each
> > loop of __get_user_pages() will resolve one pgtable entry with the patch
> > applied, rather than relying on the size of hugetlb hstate, the latter may
> > cover multiple entries in one loop.
> > 
> > A quick performance test on an aarch64 VM on M1 chip shows 15% degrade over
> > a tight loop of slow gup after the path switched.  That shouldn't be a
> > problem because slow-gup should not be a hot path for GUP in general: when
> > page is commonly present, fast-gup will already succeed, while when the
> > page is indeed missing and require a follow up page fault, the slow gup
> > degrade will probably buried in the fault paths anyway.  It also explains
> > why slow gup for THP used to be very slow before 57edfcfd3419 ("mm/gup:
> > accelerate thp gup even for "pages != NULL"") lands, the latter not part of
> > a performance analysis but a side benefit.  If the performance will be a
> > concern, we can consider handle CONT_PTE in follow_page().
> > 
> > Before that is justified to be necessary, keep everything clean and simple.
> > 
> 
> mm/gup.c:33:21: warning: 'follow_hugepd' declared 'static' but never defined [-Wunused-function]
>    33 | static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
>       |                     ^~~~~~~~~~~~~
> 
> --- a/mm/gup.c~mm-gup-handle-hugepd-for-follow_page-fix
> +++ a/mm/gup.c
> @@ -30,10 +30,12 @@ struct follow_page_context {
>  	unsigned int page_mask;
>  };
>  
> +#ifdef CONFIG_HAVE_FAST_GUP
>  static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
>  				  unsigned long addr, unsigned int pdshift,
>  				  unsigned int flags,
>  				  struct follow_page_context *ctx);
> +#endif
>  
>  static inline void sanity_check_pinned_pages(struct page **pages,
>  					     unsigned long npages)
> _
> 
> 
> This looks inelegant.
> 
> That's two build issues so far.  Please be more expansive in the
> Kconfig variations when testing.  Especially when mucking with pgtable
> macros.

Andrew,

Apologies for that, and also for a slightly late response.  Yeah it's time
I'll need my set of things to do serious build tests, and I'll at least
start to cover a few error prone configs/archs in with that.

I was trying to rely on the build bot in many of previous such cases, as
that was quite useful to me to cover many build issues without investing my
own test setups, but I think for some reason it retired and stopped working
for a while.  Maybe I shouldn't have relied on it at all.

For this specific issue, I'm not sure if CONFIG_HAVE_FAST_GUP is proper?
As follow_hugepd() is used in slow gup not fast.  So maybe we can put that
under CONFIG_MMU below that code (and I think we can drop "static" too as I
don't think it's anything useful).  My version of fixup attached at the end
of email, and I verified it on m68k build.

I do plan to post a small fixup series to fix these issues (so far it may
contain 1 formal patch to touch up vmstat_item_print_in_thp, and 2 fixups
where I'll mark the subject with "fixup!" properly).  Either you can pick
up below or you can wait for my small patchset, should be there either
today or tomorrow.

Thanks,

===8<===
diff --git a/mm/gup.c b/mm/gup.c
index 4cd349390477..a2ed8203495a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -30,11 +30,6 @@ struct follow_page_context {
        unsigned int page_mask;
 };
 
-static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
-                                 unsigned long addr, unsigned int pdshift,
-                                 unsigned int flags,
-                                 struct follow_page_context *ctx);
-
 static inline void sanity_check_pinned_pages(struct page **pages,
                                             unsigned long npages)
 {
@@ -505,6 +500,12 @@ static inline void mm_set_has_pinned_flag(unsigned long *mm_flags)
 }
 
 #ifdef CONFIG_MMU
+
+struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
+                          unsigned long addr, unsigned int pdshift,
+                          unsigned int flags,
+                          struct follow_page_context *ctx);
+
 static struct page *no_page_table(struct vm_area_struct *vma,
                                  unsigned int flags, unsigned long address)
 {
===8<===

-- 
Peter Xu


