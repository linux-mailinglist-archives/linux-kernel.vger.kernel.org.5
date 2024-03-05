Return-Path: <linux-kernel+bounces-92485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF82872112
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CDE21F21C1F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A77185C6C;
	Tue,  5 Mar 2024 14:05:51 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E300186136
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647551; cv=none; b=guFctYd3Yws2R9x69mLBKgGtBLtKy8qZm/1vIlJON+kTXE7AyCDdZgoE48wO0JOtwC9YFxHx8immsRYahPypOdc3vG3Mqx9svBRQVxKjyEqCNx/cAg8twftB7/Y3Db7ew0+JcbirmB1OUA820Gi60XZEtWF4G4BCTdUffq5kABg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647551; c=relaxed/simple;
	bh=l6/9FLs3sfDp1nSrT9HHBWHSPnKmAZsIayGG9uKmBck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgBkIG1QwfYgF6bxqb4eDWWWZI/sen3eIvrNgRV8Q+v2K3pgAIZc0Qh/SgKAu7lBHCRu8xt38E1vn++V0mi/vCFyIIOJmSlK3EaoQDQFnFzmBGC09/mSgt8mndekT/ENLqjVfCiISJchRa7aWklhB9JCBm1ROsiLXogYrbeE6yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 007F268C7B; Tue,  5 Mar 2024 15:05:43 +0100 (CET)
Date: Tue, 5 Mar 2024 15:05:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Michael Kelley <mhklinux@outlook.com>,
	Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	"kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Dexuan Cui <decui@microsoft.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Message-ID: <20240305140543.GB3659@lst.de>
References: <20240229133346.GA7177@lst.de> <SN6PR02MB4157314F142D05E279B7991ED45F2@SN6PR02MB4157.namprd02.prod.outlook.com> <20240229154756.GA10137@lst.de> <20240301163927.18358ee2@meshulam.tesarici.cz> <20240301180853.5ac20b27@meshulam.tesarici.cz> <8869c8b2-29c3-41e4-8f8a-5bcf9c0d22bb@arm.com> <20240301194212.3c64c9b2@meshulam.tesarici.cz> <SN6PR02MB41571DA1EE99BFAA65869024D4232@SN6PR02MB4157.namprd02.prod.outlook.com> <20240304120055.56035c21@meshulam.tesarici.cz> <ffd7646b-37b1-4cd2-822a-848b36b076c9@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffd7646b-37b1-4cd2-822a-848b36b076c9@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 04, 2024 at 01:37:56PM +0000, Robin Murphy wrote:
> FWIW I'm also starting to wonder about getting rid of the alloc_size 
> argument and just have SWIOTLB round the end address up to alloc_align_mask 
> itself as part of all these calculations. Seems like it could potentially 
> end up a little simpler, maybe?

Yes, that does sound simpler and most importantly harder to get wrong..


