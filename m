Return-Path: <linux-kernel+bounces-75877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CAE85F02E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66AC41C22AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD3817583;
	Thu, 22 Feb 2024 03:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="apGU9qyw"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C9E111B2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573880; cv=none; b=BDXtZOIn83o5FFAdQ/rt+LzjziYtfNl76/G1OP5TadSNsrY/9n5QBu60dtzZBbbeNjNVwDlgZwmoQSHoc03ihFA9sE5TLFB9XUJuKxli/4gzvgilMkZL5Lp+ZiXBZ4O25vpuRtPX/3i5lGTx0gAG7MERBD7INwoHS6Sj43kZhc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573880; c=relaxed/simple;
	bh=U8r0bihuYdw2bLbxoL06ppuLdubJ4RlmL6Hu0e74X6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GE7N4YFVRoLAEVeWb3KUVJ4kS12OtTB2PhklPf334zvgGRwDE6dbxqNQhYopCu27ccn0q6Pqz6r+Kke6jZsUK2EmhyOQ8Oi470ojRDo1SOo2AH3qJ/BRdYNU8sfpliv57pSsBfaZiWPw4GaRdbORI0M6T5yYIH8Wve3onKYdPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=apGU9qyw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i/7HIyFgwgzD7YbEDR31NVPlVkKUleWuI0Mc79KExFQ=; b=apGU9qywdin7SKMFel85/KBcxq
	dYyK6+2aDKa8SI4lIUbdk5vL8F/W3opK2JsUcA5cPvRrB8xCLy+95KzcQ7NTjZqy5bPe3/67Zh4WW
	hK8CG3AyqzQvw0cMVwsYaBhfM/+OmSqlEbo3MfnyYOGoNuSal00W5s0vE/g/Nq0Z9uLaDPouvqU08
	zI+BXEYpwdpSiagmuzFestJBOfYN/E8dzzHW/v4/xvZvome5KYLvknMA2HUfUUh0BerLnJPfgT3Cs
	rMvsjf5nZRxDaKt1zE1qMmW1WrkE+4d1V/ixzdisgsUSZzQr9RpCs2+8ND7O1qxdRbNZcFXlftSNy
	z2OQdYSg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd07A-00000002VKP-1vyV;
	Thu, 22 Feb 2024 03:51:16 +0000
Date: Thu, 22 Feb 2024 03:51:16 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, muchun.song@linux.dev
Subject: Re: [PATCH v2 4/5] hugetlb: Use vmf_anon_prepare() instead of
 anon_vma_prepare()
Message-ID: <ZdbEtEa-G-EuZ2n2@casper.infradead.org>
References: <20240221234732.187629-1-vishal.moola@gmail.com>
 <20240221234732.187629-5-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221234732.187629-5-vishal.moola@gmail.com>

On Wed, Feb 21, 2024 at 03:47:31PM -0800, Vishal Moola (Oracle) wrote:
> hugetlb_no_page() and hugetlb_wp() call anon_vma_prepare(). In
> preparation for hugetlb to safely handle faults under the VMA lock,
> use vmf_anon_prepare() here instead.
> 
> Additionally, passing hugetlb_wp() the vm_fault struct from hugetlb_fault()
> works toward cleaning up the hugetlb code and function stack.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

>  static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>  		       unsigned long address, pte_t *ptep, unsigned int flags,
> -		       struct folio *pagecache_folio, spinlock_t *ptl)
> +		       struct folio *pagecache_folio, spinlock_t *ptl,
> +		       struct vm_fault *vmf)

Is it worth removing vma, address and flags?


