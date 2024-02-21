Return-Path: <linux-kernel+bounces-74667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC0085D779
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2AC1F23D45
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A5147F5C;
	Wed, 21 Feb 2024 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNnIhRuw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A31041740
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516535; cv=none; b=h6ZMKZUNF8vgN/SYiDoFBz8H+I1veJLsZ7VPkhtEVYU2n15lcdzQZO0btkQ6rJGAsu0dPJuPwusm0YtJvzLrhhQEoOd2UkOZ9ENnzHdFXmx2KUhERPOkH4gCmfOS4nhKoKIPhLREoP3Jz3XDU3/r0o+ZADmeU8MVFJr1TC8fXn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516535; c=relaxed/simple;
	bh=BEkM38bqHddTPCsgf39ufvkDQzRXtZEp09KQ6OMKXjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPiNYqAxg6XiCago6jFUU3s02nn5nVZRjOPWlqTLzMeNcEP6FAdzNsoV02tqPVjCHTQvwUKd0+TcET3VwpCTg3bgwVNaaoE5zhxonsgFDVpVjjjVhqgYiA1xEFaushsj0OcBL95FPQG/8cDN4NjJTvJ3nf0G+AI2Vp0AFaZlL7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNnIhRuw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708516532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PLsLM/ECtgqgj6YScdKuDzdQeO2PVy2fvKFbE23nuA4=;
	b=gNnIhRuwWXTUPY94+SLGU4tBD9l1D8CovC5/vKWMsRxSlPhO0cBiF7pFB87rnB2tPz8nlg
	CfGMNE02QxUeMZoUBo4mmcfUsIsK6cXArci/zzuUbYND48wcArZo8zcGHK2oMZrjIseIlr
	Sz0tdoqwe0K0Dyl0iMU/DpEAjjqFupA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-LlyLNLsSNrecmjh3f-hMXw-1; Wed, 21 Feb 2024 06:55:31 -0500
X-MC-Unique: LlyLNLsSNrecmjh3f-hMXw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5ce9b15f4ccso2844691a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:55:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708516530; x=1709121330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLsLM/ECtgqgj6YScdKuDzdQeO2PVy2fvKFbE23nuA4=;
        b=anHyroS34zwbAT5Af98vLJPTnQ/TmpAoWfHJK43t2OYZU1hMOJm+yaPnvtM0IEOMHh
         BlKURUPom0pfRK4YcduW08fkD/5xEWyDqw+QuX2y+UTFOHWn0BxJSSXkCTYi4kIZF6Vc
         M+/HBsrlUuIEs/wc14S7lcmBmHEYdZZwnT7aT1kQRZ8/lVQBb1y7KTjT1fYCAynYRfcj
         azlhn5N7Q+n256e+rAly7dTwMvQ+fYYzmq/JGF+ImSSuvxc/7QkNFWJ1l2YLrQ26KIIw
         /BMHcw4oYlNWdEKMFXNJL5GP8tfIz7WmLQtwW9mUxcYkjLzlMwkqsOfGuR00jYz7fKYR
         riCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX65aMzZxsYqOxHN73Z/vwPpOmxVqW3QeH5Psj7nGKOFVe+ui1JEh/bBl+ea6XWPd2ZrvO22gnUpYejnHml/nUfhCcCWJICtl0sHltq
X-Gm-Message-State: AOJu0YxisYwYcwR6L0td+8Hz3mZ6P8ipxEMbtxXutTkXZeeJBkKjfJuD
	eQMdV9SZdG8kadCKqAr7gIFrjV+t5/Fmv5WjCkqxKoWj2URkQHIrpkpo8W4zMtbwuTqHDWycI5h
	l6fl3WpRkY1ia599XslYDrSXCsO2jJZETPr1QJbK6By7ih8ADqckeuk3wS+ygiw==
X-Received: by 2002:a05:6a21:3397:b0:1a0:cd02:b2f1 with SMTP id yy23-20020a056a21339700b001a0cd02b2f1mr196518pzb.3.1708516530458;
        Wed, 21 Feb 2024 03:55:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRO+9lM9EY5N92dCc9bYoUlt/pUN8sgkXoKwNhU9AZ+BNLKu2lSvew+Aw+SPUl5ZIlIuODvw==
X-Received: by 2002:a05:6a21:3397:b0:1a0:cd02:b2f1 with SMTP id yy23-20020a056a21339700b001a0cd02b2f1mr196492pzb.3.1708516530136;
        Wed, 21 Feb 2024 03:55:30 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902a9c300b001dc0955c635sm4149309plr.244.2024.02.21.03.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 03:55:29 -0800 (PST)
Date: Wed, 21 Feb 2024 19:55:17 +0800
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
Subject: Re: [PATCH v2 06/13] mm/gup: Drop folio_fast_pin_allowed() in hugepd
 processing
Message-ID: <ZdXkpYEuRAxoLtHI@x1n>
References: <20240103091423.400294-1-peterx@redhat.com>
 <20240103091423.400294-7-peterx@redhat.com>
 <20240115183748.GR734935@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240115183748.GR734935@nvidia.com>

On Mon, Jan 15, 2024 at 02:37:48PM -0400, Jason Gunthorpe wrote:
> > Drop that check, not only because it'll never be true for hugepd per any
> > known plan, but also it paves way for reusing the function outside
> > fast-gup.
> 
> I didn't see any other caller of this function in this series? When
> does this re-use happen??

It's reused in patch 12 ("mm/gup: Handle hugepd for follow_page()").

Thanks,

-- 
Peter Xu


