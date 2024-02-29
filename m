Return-Path: <linux-kernel+bounces-86947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E76E86CD62
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD6C1F223A5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E113614A4EA;
	Thu, 29 Feb 2024 15:48:04 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C47F14A4D8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221684; cv=none; b=Qop3V5cDr1oK4gHjroLDReiRwyPdukLr5pMv0cGY6ojxewvNwQ5Np0imXre6UMCCELihJ3rbch9kQ3/Ky+9HA9eM9YxjXT+f/pn8qzH8EOqyFmMacaKpG6NMYIIPR7+dpw25udlBFxoxdC0jLSZDp62+RIB4qYa8S6teYMY8jfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221684; c=relaxed/simple;
	bh=70x9FaZb7eaNHHGA2X6zEO7ykIH+n9GJcs73CL5eOGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFdD8upOpEw7AtwBcMkrm2i94T/eRZwQT1YzVJ90XnxWD8ZWVTRj/qS8B/msnvRAWvrtXN4tHVRQHLuXPRb0hWkmcfTGJXyDsUJ/ztXImtSBXEed6MXJ0q/L61+RpwWnuirfnXDjzqmi4ilSM5ouZTQUFOVnSxWk8ulO8ZgLCsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 910B068D05; Thu, 29 Feb 2024 16:47:56 +0100 (CET)
Date: Thu, 29 Feb 2024 16:47:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	"kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Dexuan Cui <decui@microsoft.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Message-ID: <20240229154756.GA10137@lst.de>
References: <20240228133930.15400-1-will@kernel.org> <20240228133930.15400-7-will@kernel.org> <SN6PR02MB4157A62353559DA8DB8BC4ADD45F2@SN6PR02MB4157.namprd02.prod.outlook.com> <SN6PR02MB41577D09E97B1D9645369D58D45F2@SN6PR02MB4157.namprd02.prod.outlook.com> <20240229133346.GA7177@lst.de> <SN6PR02MB4157314F142D05E279B7991ED45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157314F142D05E279B7991ED45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 29, 2024 at 03:44:11PM +0000, Michael Kelley wrote:
> Any thoughts on how that historical behavior should apply if
> the DMA min_align_mask is non-zero, or the alloc_align_mask
> parameter to swiotbl_tbl_map_single() is non-zero? As currently
> used, alloc_align_mask is page aligned if the IOMMU granule is
> >= PAGE_SIZE. But a non-zero min_align_mask could mandate
> returning a buffer that is not page aligned. Perhaps do the
> historical behavior only if alloc_align_mask and min_align_mask
> are both zero?

I think the driver setting min_align_mask is a clear indicator
that the driver requested a specific alignment and the defaults
don't apply.  For swiotbl_tbl_map_single as used by dma-iommu
I'd have to tak a closer look at how it is used.

