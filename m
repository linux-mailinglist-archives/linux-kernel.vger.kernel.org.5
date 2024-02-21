Return-Path: <linux-kernel+bounces-74037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C01485CF25
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C05A1B229E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB2839864;
	Wed, 21 Feb 2024 03:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oeNRFWc2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAD03984F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708487169; cv=none; b=Cs+FZh3AoqOtOwVtTS8+1+kkuGsBV2wpSSbG6tZb0Kd4cg2kjHSTSKohA88U8IX1GBwhhJDYoj4NN+/zSSCOzsdLsXiUT9YToDyZL8muV8TlnLinpT+ZXnpN68SB17w/Uk7FaQsGpDLGTAEfKrmVne9sorecflSfOrwKpAxzWOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708487169; c=relaxed/simple;
	bh=qoZYpfoIMqwzNvBKaj8Y4jwspMYjlaeD7EZzns/grmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VboBoZit29dGglWWKd8Oh2ZK/VP+JAbkZCeGtq5paHEAgdMuF9XExm9Pmno2WcMU0ywvP9VDA7KFvrv7Kiqmqm8DGg+YzlflXtZeuyMLd6VWBl4mIkqQZ+mqr+JP9ktFaWSZJ2tz1hlupiI8f74Xv+Cud8VAjdZ+strd7RbGCrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oeNRFWc2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7jcKjsukADh5+keVVSLqyfpNdnse8y8447nXXm1V7B0=; b=oeNRFWc25tfV3lK+WrlEDzfeWI
	cjeGrM54UrUqSndPcwUvnNw7aa0FMp3k1x7EPVok05Y52pOMZtZ+0ZxqO5p54mm8MFz/qb11rqEUr
	TeLy4UgbXeax4nRTHFJNIkIKijENSDa4vsLLocw6jCm2DgkLeY4B1ui0RRoMrxB2o1z93N8LARlTf
	Vzux8RNvIREo9A924k4/G+e5luqWkbscASt85vVw1Io5mOzUgFoi7Q6tH+iZLm4IMgkj6vpojPZmy
	KbjLg5y884jpnbXFX+4uYQiN1kEIszohPs4aWKj9HHfYUNc/89uKTiiNIc86qAMTEIhspqpQJhXiZ
	jmd8LOJw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcdYa-0000000HJio-13FB;
	Wed, 21 Feb 2024 03:46:04 +0000
Date: Wed, 21 Feb 2024 03:46:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, muchun.song@linux.dev
Subject: Re: [PATCH 2/3] hugetlb: Use vmf_anon_prepare() instead of
 anon_vma_prepare()
Message-ID: <ZdVx_Jr9tm2lV0Ku@casper.infradead.org>
References: <20240220231424.126600-1-vishal.moola@gmail.com>
 <20240220231424.126600-3-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220231424.126600-3-vishal.moola@gmail.com>

On Tue, Feb 20, 2024 at 03:14:23PM -0800, Vishal Moola (Oracle) wrote:
> +++ b/mm/hugetlb.c
> @@ -5834,9 +5834,15 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>  	struct folio *old_folio;
>  	struct folio *new_folio;
>  	int outside_reserve = 0;
> -	vm_fault_t ret = 0;
> +	vm_fault_t ret = 0, anon_ret = 0;

Do we need a second variable here?  Seems to me like we could
unconditionally assign to ret:

> -	if (unlikely(anon_vma_prepare(vma))) {
> -		ret = VM_FAULT_OOM;
> +	anon_ret = vmf_anon_prepare(&vmf);
> +	if (unlikely(anon_ret)) {
> +		ret = anon_ret;



>  	unsigned long haddr = address & huge_page_mask(h);
>  	struct mmu_notifier_range range;
> +	struct vm_fault vmf = {
> +				.vma = vma,
> +				.address = haddr,
> +				.real_address = address,
> +				.flags = flags,
> +	};

We don't usually indent quite so far.  One extra tab would be enough.

Also, I thought we talked about creating the vmf in hugetlb_fault(),
then passing it to hugetlb_wp() hugetlb_no_page() and handle_userfault()?
Was there a reason to abandon that idea?


