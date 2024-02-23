Return-Path: <linux-kernel+bounces-78290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578A586116F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839851C21B40
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31167BAFC;
	Fri, 23 Feb 2024 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7CS91D9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF527B3E3;
	Fri, 23 Feb 2024 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691136; cv=none; b=krD9ueKbD/h6xY6SIfrIfpyzuVSgVvACkG7Exo/zT+q1sUZxNMnEsMUem5Uhi/AfoZsSuhQBQb3nUzQbDJwbMO0G5UjUjL4Luk+zjI8AqQRb9MY/bN8+UPbnd+qFZ9qKKWj9r46nPMA42Z0+3PRh0GkPvZCrSGy9F+prrrqxuAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691136; c=relaxed/simple;
	bh=8Of16FeuK62BABqKCILjWT3Z7WbQBNIne5rn4ZE3mAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsMtB6LUAW4gjlnm285OdvK6E6aro8zHuDwPs1HYl3Ad+CBeeibwR9ghZvhnSiUjBm5G2CVZqi4vdzojiLwVEE8boodsy10C/vsQdwz4V6aO/PRW8az2aWciKPpaQTRPy8xZhd2YmfjsaRjwjMoSnRzXJcFXo375wAg/CE6ix5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7CS91D9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7800C433C7;
	Fri, 23 Feb 2024 12:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708691135;
	bh=8Of16FeuK62BABqKCILjWT3Z7WbQBNIne5rn4ZE3mAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7CS91D93l5F/DEdZGaKzR35RysxD2B4cH/G/VgiWBw4DEdFqMcvHkhlt9LBpYp8y
	 GIG7u9B0KuEn4XbmV+6NZRYHKmFFR4BCSZsmiynuG28s26sg6xOQvx6jFd39yDmFA9
	 FMRqap7cdnUJgnaxH5deMKISFOmSxk2Wc1nkBoIcNfCfXFCuwTPDD5i3z8NJ+Omudb
	 0jMV0716KSF3cKt4D9gPM9LyWRLzEP2fXR+7aSvXvWczZLEJjcfEFOhF9UM500qTkr
	 UNibDK6AFFawjAsq+iZj+zrQO0pyfPfZXavrT59l9H2aV97d5fyVjmpk9jHZZ1jNjf
	 wcQkOffOWKEzw==
Date: Fri, 23 Feb 2024 12:25:30 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v4 0/5] Fix double allocation in swiotlb_alloc()
Message-ID: <20240223122529.GA10641@willie-the-truck>
References: <20240221113504.7161-1-will@kernel.org>
 <ZdiC4OpEMQHQjEtv@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdiC4OpEMQHQjEtv@Asurada-Nvidia>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 23, 2024 at 03:34:56AM -0800, Nicolin Chen wrote:
> On Wed, Feb 21, 2024 at 11:34:59AM +0000, Will Deacon wrote:
> > This is version four of the patches which I previously posted at:
> > 
> > v1: https://lore.kernel.org/r/20240126151956.10014-1-will@kernel.org
> > v2: https://lore.kernel.org/r/20240131122543.14791-1-will@kernel.org
> > v3: https://lore.kernel.org/r/20240205190127.20685-1-will@kernel.org
> > 
> > Thanks to Petr for his Reviewed-by tag on the first three.
> > 
> > Changes since v3 include:
> > 
> >   - Use umax() instead of max() to fix a build warning if the first
> >     patch is applied to older kernels which warn on signedness
> >     mismatches.
> > 
> >   - Add two new patches to the end of the series to resolve some
> >     additional issues with NVME and 64KiB pages, reported by Nicolin.
> >     I've added them to this series, as the first three patches make it
> >     easier to fix this problem in the SWIOTLB code.
> > 
> >   - Add Reviewed-by tags from Petr
> > 
> > Cheers,
> > 
> > Will
> > 
> > Cc: iommu@lists.linux.dev
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> > Cc: Dexuan Cui <decui@microsoft.com>
> > Cc: Nicolin Chen <nicolinc@nvidia.com>
> 
> This fixes the bug with NVME on arm64/SMMU when PAGE_SIZE=64KiB.
> 
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks, Nicolin! Please can you also respond to Michael's observation on
your patch (5/5)? I didn't think we needed anything extra there, but since
it's your patch I'd prefer to hear your opinion.

https://lore.kernel.org/lkml/SN6PR02MB4157828120FB7D3408CEC991D4572@SN6PR02MB4157.namprd02.prod.outlook.com/

Cheers,

Will

