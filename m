Return-Path: <linux-kernel+bounces-131527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0A989890D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ACBDB21B76
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76248128384;
	Thu,  4 Apr 2024 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCPvt677"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ED8128361
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238367; cv=none; b=kkBkBtv/y9wORr9Wsytni7Q3SAjNob3A04/xedWCTTvGWJXLVEqIRBlex4I59m72GfwK05J5c3djYlpsi9c4VQZmp77NzgPUDs/qed2jsNr3SEscdmqo2lJt+mw80Y/DUsM4+1Xy85BVHTkFSdu5FhECLaFfkr+1QoH+mhWVs7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238367; c=relaxed/simple;
	bh=h7s8i68ZyCWn59nSV0PE6ZG8mJhzJGtaDhaD8CtIEkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pC40nDIhRv8N+MGknYC2Ahlm45hMvSsyWNXJEYqAu+VmY38dSllr2bCvATDWUEcWEyfmGWxroFDK/jyXK4UOrfELflB2a7ZqD8EwqghzkEEkbYWi2H1yq62zthOMvAjNhW31cpnjGJfeol2MixeBVrTcT/ewlDeNyrVHXPBe4Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCPvt677; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712238365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EmzOZMLQMmyXptbwJ4TCleo+H/I/LAr89e90GsrIjic=;
	b=YCPvt677QpQDfggeQ8boCkLQGiv0wbOuhcM4/o7VX3ld7rIhucuVWc+RmqPanYvoKCZh4A
	DAV70f1o7+olIpdbWEAv4F4q1x+C3r3FYE7JbiBVk2mN3/NAbZWm1Il5lTM+lOlyt5FR/Q
	NiQfcXxIyzg04eZ1rv3ef+fhjkHIbYc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-6GNVay9bN-Cv9PUYmp2zqg-1; Thu, 04 Apr 2024 09:46:02 -0400
X-MC-Unique: 6GNVay9bN-Cv9PUYmp2zqg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78d438954abso10224985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 06:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712238362; x=1712843162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmzOZMLQMmyXptbwJ4TCleo+H/I/LAr89e90GsrIjic=;
        b=CEopuVULOeDtkhOoLcmHfPNw9/JO2vCUwtiN5oiGPjltt/GD6CXxYPF7/q3mkP9tMP
         8F0+FAVAJhWdM4vs573a8EJERGenvClbn87NCI3f6yaeagTJ9PHCVkOVhK01ObN5elSy
         wcx06h6b5L2+RFPGTIIFBiz7bXi1iEg3/326KTXLZ6+esLs0YyxjREnlphy26Pn2V9u4
         W20n0mDq6jtm+remMeyYkyUaCjnOKSfft9HVsnHsiD84imauj+Uf4yFa+v2T88vBFR/y
         gRNNTmcy1odzdr9OzdIG630vcWNba0Dyzps7wSwlMc5c3gwPaoHu09AZBAi8HPx8Xd8H
         7Dfw==
X-Forwarded-Encrypted: i=1; AJvYcCV4w3TZ/wq22KXDRpb0KTO0AfKwx6Q488PriHLOj2tnNt4FPURgFbUx3+13/sz/UM2kDWQH+n8RsAJlE/TDHzzciO43ZTxO+wXRb4uA
X-Gm-Message-State: AOJu0YyL8gWyPfL6VxekYrVMaZIVPhxJa7IKkURR700SrGGydWWyuS5/
	VQHgn648kAqeSVobiWYJrZpRGTXn94+YzZSkbKsaaWLa7HBO1l6frByB8WEzRzTd7id0LLSvcR6
	bRDcnglyEfgbkUNGWBLuYQq0I1qDEiYw4eFy4D7b5TBwrHC08n+e1TawtVtK40g==
X-Received: by 2002:a05:6214:5084:b0:699:2f16:4d2d with SMTP id kk4-20020a056214508400b006992f164d2dmr2447152qvb.3.1712238361990;
        Thu, 04 Apr 2024 06:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJdNkFmzOBKBFyhb53lG1h+VUGQqqfUd/DRv4waZks+wqY9XKFnnPlb39Aj880wVEqUvqQog==
X-Received: by 2002:a05:6214:5084:b0:699:2f16:4d2d with SMTP id kk4-20020a056214508400b006992f164d2dmr2447114qvb.3.1712238361317;
        Thu, 04 Apr 2024 06:46:01 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id g12-20020a0562141ccc00b0069915b47bf4sm2696616qvd.146.2024.04.04.06.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 06:46:01 -0700 (PDT)
Date: Thu, 4 Apr 2024 09:45:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Ryan Roberts <ryan.roberts@arm.com>, loongarch@lists.linux.dev
Subject: Re: [PATCH 1/3] mm: Allow anon exclusive check over hugetlb tail
 pages
Message-ID: <Zg6vFtciZAl4SQHW@x1n>
References: <20240403013249.1418299-1-peterx@redhat.com>
 <20240403013249.1418299-2-peterx@redhat.com>
 <Zg3u5Sh9EbbYPhaI@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zg3u5Sh9EbbYPhaI@casper.infradead.org>

On Thu, Apr 04, 2024 at 01:05:57AM +0100, Matthew Wilcox wrote:
> On Tue, Apr 02, 2024 at 09:32:47PM -0400, peterx@redhat.com wrote:
> > +++ b/include/linux/page-flags.h
> > @@ -1095,7 +1095,13 @@ PAGEFLAG(Isolated, isolated, PF_ANY);
> >  static __always_inline int PageAnonExclusive(const struct page *page)
> >  {
> >  	VM_BUG_ON_PGFLAGS(!PageAnon(page), page);
> > -	VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
> > +	/*
> > +	 * Allow the anon-exclusive check to work on hugetlb tail pages.
> > +	 * Here hugetlb pages will always guarantee the anon-exclusiveness
> > +	 * of the head page represents the tail pages.
> > +	 */
> > +	if (PageHuge(page) && !PageHead(page))
> > +		page = compound_head(page);
> 
> I think this should be written as:
> 
> 	/*
> 	 * HugeTLB stores this information on the head page; THP keeps
> 	 * it per page
> 	 */

This comment does look clean and cleaner indeed.  And yes, mention THP can
be helpful too.

> 	if (PageHuge(page))
> 		page = compound_head(page);

I would think PageHead() check would help us to avoid compound_head() on
heads, which should still be the majority cases iiuc (assuming page->flags
is already around in the cache anyway).  I've no strong opinion though, as
I can hardly tell a difference in reality.

> 
> >  	return test_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags);
> >  }
> 

Thanks,

-- 
Peter Xu


