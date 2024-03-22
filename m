Return-Path: <linux-kernel+bounces-111731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EB9887010
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7997D1C22A02
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497495674C;
	Fri, 22 Mar 2024 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MY7ylr7p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD05E524DF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122921; cv=none; b=lH08/CwB3ceMg2n65/s/8g7Cwl9gZj0GurKJNm/UUPxmWnF9O8rC/NgbzZtkd9BVaMAEwj/QHBK6LX+FgKqwyDY7B08wWKnDILDbwH/j9HiByP/AH4RE/D/pco7d5T0N5DOmCEVNX/JfjrcrM/4lEpDXEfG5ms66Aez2d6dJQfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122921; c=relaxed/simple;
	bh=oXVrUcTO1N7PmhcN7MRPWUzD46Z484ESd0twio3AZBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVlqSUjwZmeOFA0P3F9P1nWDSqoaAo6IYegXsTnG95LptBPuu44dJMSne2ZwqjLMhr+DpkJ4WmWR8fKX3T1T15pvJc+fL4UmFVRxGa5TP6JjlwfznULtSjcF1+WpfYfOcIuLFiMK9uzAOzS/nNbxCHtZbDVc3b1Xm+FDiWTI4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MY7ylr7p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711122918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJLFb75dlh9Ilo5izUjxoeGL/8+am1RJvB8MBnP+8/Q=;
	b=MY7ylr7po+b1XrK0Q9tWQ8ggR80AH0obGLq6hNRTy/UGpQvSWjiodFdhJa5DsjbRt3q6Ni
	P3/Oh+qaqsHeySCSeM+DV0QpGqGARCDacTgm9JqxZNfmCBC075lwURV325Ql/Jsp7glUyn
	QjpxynzJzbb3If7VrUC8Ta0Z2X2pFBM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-R70Aj0XmNdWQ-2jJ7u8oSw-1; Fri, 22 Mar 2024 11:55:16 -0400
X-MC-Unique: R70Aj0XmNdWQ-2jJ7u8oSw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-69672754479so912086d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711122916; x=1711727716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJLFb75dlh9Ilo5izUjxoeGL/8+am1RJvB8MBnP+8/Q=;
        b=Ji7mpx1pXAIWJxDI67P6yCnyVeb0XzYCwfLugDh5VPHGL9HeVrMMOdbOqV72ezCG6j
         FpQdQDeVi5zdDEuPhE0G/eswfK+kgJFynYr49yRiR/Ij1XePzwaUMXmvrXVzekaXug28
         Ji1NwJPm6CcXLSFx6MOjhY9zXswYj4H9e/clkBzZmRDa80ci+yM187leRWIIGG0HQUtT
         1LN9ouYHsblmf8A+1IfOlnSCO8MkjGS0N+6eH0i6/cwhkntOA3qOD+TEH3qwHEcZyO/E
         84Qjtec3SOapT6Qec7/vPVHaySkn3PU2SQeyWFwKf36G66BemAhZ1T+zYhpzfChHlCGt
         U+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXs8JpOLfD6ZHrXARc/Kz6B20wWywgjBJDKtTtkbIpMFezk/Ghug+ce/aFDzZ9B3N5zwDGdx4I+JGbLPEdpBJZMMPH3yAvZBoePBjRB
X-Gm-Message-State: AOJu0Yw8Y9eqXV/TRI0UJSZ/6XNkvpUqCDPiHVMgxm7Wt3qP9jRhtKnD
	xVf3eGRSixFYLb0jJ2JbaYx/nwOlWF1g8KMBy1b6LMYLjZOkjuJFakjlZkSq0Easu3wiDx6sssA
	aICzUw1A+NCLjd2QctrejVFxNcydM04B1Y7sBaSZa5vy5kEURi5I8naShF/22Yw==
X-Received: by 2002:a05:6214:2b86:b0:696:732f:41ce with SMTP id kr6-20020a0562142b8600b00696732f41cemr1030617qvb.0.1711122916045;
        Fri, 22 Mar 2024 08:55:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcGgYl+6vk8GOgJHrnHh9Bk553GXwTOWFwJfwdxmayaEVIZH35b8wrrTSaV+/rgNR3L0gYLQ==
X-Received: by 2002:a05:6214:2b86:b0:696:732f:41ce with SMTP id kr6-20020a0562142b8600b00696732f41cemr1030577qvb.0.1711122915578;
        Fri, 22 Mar 2024 08:55:15 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id jx12-20020a0562142b0c00b0068ff8bda6c7sm1185452qvb.92.2024.03.22.08.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:55:14 -0700 (PDT)
Date: Fri, 22 Mar 2024 11:55:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
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
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Christoph Hellwig <hch@infradead.org>,
	linux-riscv@lists.infradead.org,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 12/12] mm/gup: Handle hugetlb in the generic
 follow_page_mask code
Message-ID: <Zf2p38Pb51T3e9uB@x1n>
References: <20240321220802.679544-1-peterx@redhat.com>
 <20240321220802.679544-13-peterx@redhat.com>
 <20240322133012.GI159172@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240322133012.GI159172@nvidia.com>

Jason,

On Fri, Mar 22, 2024 at 10:30:12AM -0300, Jason Gunthorpe wrote:
> On Thu, Mar 21, 2024 at 06:08:02PM -0400, peterx@redhat.com wrote:
> 
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
> 
> I think this is probably fine for the moment, at least for this
> series, as CONT_PTE is still very new.
> 
> But it will need to be optimized. "slow" GUP is the only GUP that is
> used by FOLL_LONGTERM and it still needs to be optimized because you
> can't assume a FOLL_LONGTERM user will be hitting the really slow
> fault path. There are enough important cases where it is just reading
> already populted page tables, and these days, often with large folios.

Ah, I thought FOLL_LONGTERM should work in most cases for fast-gup,
especially for hugetlb, but maybe I missed something?  I do see that devmap
skips fast-gup for LONGTERM, we also have that writeback issue but none of
those that I can find applies to hugetlb.  This might be a problem indeed
if we have hugetlb cont_pte pages that will constantly fallback to slow
gup.

OTOH, I also agree with you that such batching would be nice to have for
slow-gup, likely devmap or many fs (exclude shmem/hugetlb) file mappings
can at least benefit from it due to above.  But then that'll be a more
generic issue to solve, IOW, we still don't do that for !hugetlb cont_pte
large folios, before or after this series.

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks!

-- 
Peter Xu


