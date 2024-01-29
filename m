Return-Path: <linux-kernel+bounces-42211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D751583FDF8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E486B2144D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A3945BE7;
	Mon, 29 Jan 2024 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0M7yB0P8"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F059F45959;
	Mon, 29 Jan 2024 06:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706508190; cv=none; b=pd0Sb2qJLNsBLU0TKl4VgpN7KV7bJLzyRiyUhZ0Ho9JZg/0pQPmMPP5sf+G8l9NrWwfF5P0ZN8fMRiemPknyboPWQLUOnmMXdAT87cnFJRyALyziCfh0OUKVVrlcIKs6/UU8tt/ImYlrLpkqdoatlWgFjR3+YUfmej6uvibbbMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706508190; c=relaxed/simple;
	bh=x8/7KaoluoPO5WDySCKhzBdWae05hg8D2uInhEtRJ/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCQk6NAJ5/RJ5ZCZzIM2VlP7yBErQyfRF66o1HraQlhmmzXnrgtsJ/wozhNb+OUhRbysPJZOsoP/Db5FXTn63fXFbOHQlehpuIBP/0rc4IPtvyE62xOLPDm6u0hkOBT/u5ggyN5aJlOiEyfot4AcffQCuIHNfhisqkwmYu58vcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0M7yB0P8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1rltRGXbUtJPiVTvee3DGElZrEg5MBSlivgvAtcJSKE=; b=0M7yB0P8rn3UkuNR6s6SHjfSpk
	XEdxUnGF+o4mxHea3x7MPkruVsyo4OhwBQ8gnIanhOqW4x+/24d091hGbw2Dz4Kk+kRlK+1zfZn76
	7CpRazR+PjKPkHKnPh8Tf4Tjviuw0Ei52BgWHv5YKkDhJJYLcEXMAIkV5R86ivWFL5z4XURvw7V0k
	wTAZhwXYMoc0GNHC+gDG4CFvmDXG+lStn3RB55Fr455KZ7XSWv4M4adj9/axv/EHSV5beoq6yuQGr
	jSKIkG5aNmS+oX8c5y/TKu/m63RVYKG8txL04vKNhEYAfBHlU3dJee3c1p9utQ9rapNKATV4e48rM
	9OmMVvKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUKja-0000000BPAm-00lQ;
	Mon, 29 Jan 2024 06:03:06 +0000
Date: Sun, 28 Jan 2024 22:03:05 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA
Message-ID: <Zbc_mdOYxMIxWAdd@infradead.org>
References: <20240127064512.16744-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127064512.16744-1-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jan 27, 2024 at 02:45:12PM +0800, Lu Baolu wrote:
> Commit 62edf5dc4a524 ("intel-iommu: Restore DMAR_BROKEN_GFX_WA option for
> broken graphics drivers") was introduced 24 years ago as a temporary
> workaround for graphics drivers that used physical addresses for DMA and
> avoided DMA APIs. This workaround was disabled by default.
> 
> As 24 years have passed, it is expected that graphics driver developers
> have migrated their drivers to use kernel DMA APIs. Therefore, this
> workaround is no longer required and could been removed.

How about you Cc the intel graphics maintainers and get a confirmation?


