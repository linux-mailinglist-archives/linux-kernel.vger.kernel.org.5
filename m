Return-Path: <linux-kernel+bounces-74003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336DA85CED1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442B62834F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3412F38F82;
	Wed, 21 Feb 2024 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NTKL0Yc2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD1139AC5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486625; cv=none; b=kbb0o/E+ZM0VtviftegeupSQ7WfMXwl6FKssp6BZ0woyemH/qp1z9JxuynVNuctBScAcTQm51P1WrBhp6I7VGcyM4dqKnyQBDsc3cQr+xA2qz0gcW/kVFjWSskO8fpCAZYWC3tFnI/r+D3g3mWGfetPyQPLCBf1DuFiZdGwjBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486625; c=relaxed/simple;
	bh=vbOYKSOfdfXf+a4GJHe6lHkZOMnmMuhk1Gp/avp8rPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1SP1thFvs2GJBD9dctVlcE1mZcfX/pQu+zDh127RYOjMNmfmdmhy8fzZVjGoHHb5Jl1o8kBcZqqhCTr2Gv3q9iAoe+9oPkJZNukjZvvHbAdXMxolzJRCrhCsbnzuzu23gn2mH7LCDZ+G8EpjiHL6swIVFeRmB9mTqwKDwhHgKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NTKL0Yc2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bm8ztZBWaX+I8ZmKrLPgnl2Mm9WYFeNRbyX8E0zkgqk=; b=NTKL0Yc2oC+1BhjF1U7uQGgpLG
	oWjWcyVPyMdO4ISjl1oM1ToVHQAoDNPUU6EbUdcGE7U1eg4lFPoC/rNVHEU2d4DXJpIxUFerOxjpo
	wcsm82gKEc0cgv4WjlEoJ/CEcYqhjvjJRahP8ZvTDTyj3Lgwj7UOlqVWVHPYwJc42qdxuH2+DC6H0
	iBn1thsA7O8JGOUx6JNUke4/yf0Orzcz+6rEFmK/Bpk64mcs+5Ea0C+yJV9Ik+zx/tf1Uiw8PFNXb
	rT+c5T0BgaKsCLhMF8eCOB75B4bgu7DggyNl6+NLktIJAXufwCG4WYDmFmjDH9k3EqPipnbtXCPUe
	cHtwXk+g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcdPa-0000000HIb0-2xJF;
	Wed, 21 Feb 2024 03:36:46 +0000
Date: Wed, 21 Feb 2024 03:36:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, muchun.song@linux.dev
Subject: Re: [PATCH 1/3] mm/memory: Change vmf_anon_prepare() to be non-static
Message-ID: <ZdVvzu5OrdUoxc-O@casper.infradead.org>
References: <20240220231424.126600-1-vishal.moola@gmail.com>
 <20240220231424.126600-2-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220231424.126600-2-vishal.moola@gmail.com>

On Tue, Feb 20, 2024 at 03:14:22PM -0800, Vishal Moola (Oracle) wrote:
> In order to handle hugetlb faults under the VMA lock, hugetlb can use
> vmf_anon_prepare() to ensure we can safely prepare an anon_vma. Change
> it to be a non-static function so it can be used within hugetlb as well.

I think the prototype for this should probably live in mm/internal.h?

> +++ b/include/linux/hugetlb.h
> @@ -272,6 +272,7 @@ void hugetlb_vma_unlock_write(struct vm_area_struct *vma);
>  int hugetlb_vma_trylock_write(struct vm_area_struct *vma);
>  void hugetlb_vma_assert_locked(struct vm_area_struct *vma);
>  void hugetlb_vma_lock_release(struct kref *kref);
> +vm_fault_t vmf_anon_prepare(struct vm_fault *vmf);
>  
>  int pmd_huge(pmd_t pmd);
>  int pud_huge(pud_t pud);
> 

