Return-Path: <linux-kernel+bounces-90836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC3D870594
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EBF41C22485
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2B94A9BF;
	Mon,  4 Mar 2024 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7umev13"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451613B29A;
	Mon,  4 Mar 2024 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566329; cv=none; b=PhPSgsAnDG22kFGmUP7TaDnNMQmv/8N9vOP0K5O4IZKilJG3GtvHKZY0e3P9Fx06Kxi9oCW+udziep4s5Fkyv/t/7dKfWvdRPvgPu1sqAexcInPgrQr4a3ovzobZlJ4YNg3WzJq8Ca7t0kbjVyR/VMhG6Y7UoStO0d10Z524m2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566329; c=relaxed/simple;
	bh=IdRitC6F7nifQvPVz5e9YSZwKUHZjAx+E0QvkQGFJaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLxcIN8kZOzR4BlVZN40eXPG/w7ahMKexN3iupLSiUIz9Xd6mosKrvqg5aya96R34fvjhQISwidRlTr0RJ4ZP4Ug/FxHAvKb3C66bOdPkUHkbWzDMYgcniNQQQX6Cwx86FWCn79Cs54AvT7tGbZrKjaAPd+WstMI+n9/QcxTCRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7umev13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34AAC43390;
	Mon,  4 Mar 2024 15:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709566328;
	bh=IdRitC6F7nifQvPVz5e9YSZwKUHZjAx+E0QvkQGFJaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7umev13qkbaai4cI8CRvb/qV3QLoTKH+zy4IscyXT/F91ectlFLWyI1B33Cav6n3
	 HZqvF4Z/y5Mz5dOGO43+SMYEQYwIh2nHQ9HGI8TDh1LwJxcJUIcCm3xndrNCyvFCZl
	 Wig4zzr1uS7FVoyOsxLe9kGYOG5pz9nrU3pZ/jZ7Yhv/a2CQvfc5r8lORHvhVfS+Ic
	 pOc8RKHtRmMM6yF5173HVFihMy5GDEX0RGLEbFXsAOHxG8hgbQLNMqITfcsEeQh8i5
	 6g/scjJUrG4WJUt/63UxFehNiD5fewpY5V3et7YorgnwGSIQtXHY7mNF87EGC4CsWk
	 dEoDBPY4kV/jA==
Date: Mon, 4 Mar 2024 15:32:03 +0000
From: Will Deacon <will@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Message-ID: <20240304153203.GA21077@willie-the-truck>
References: <20240228133930.15400-1-will@kernel.org>
 <20240228133930.15400-7-will@kernel.org>
 <SN6PR02MB4157A62353559DA8DB8BC4ADD45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157A62353559DA8DB8BC4ADD45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 29, 2024 at 06:07:32AM +0000, Michael Kelley wrote:
> From: Will Deacon <will@kernel.org> Sent: Wednesday, February 28, 2024 5:40 AM
> > 
> > For swiotlb allocations >= PAGE_SIZE, the slab search historically
> > adjusted the stride to avoid checking unaligned slots. However, this is
> > no longer needed now that the code around it has evolved and the
> > stride is calculated from the required alignment.
> > 
> > Either 'alloc_align_mask' is used to specify the allocation alignment or
> > the DMA 'min_align_mask' is used to align the allocation with 'orig_addr'.
> > At least one of these masks is always non-zero.
> 
> I think the patch is correct, but this justification is not.  alloc_align_mask
> and the DMA min_align_mask are often both zero.  While the NVMe
> PCI driver sets min_align_mask, SCSI disk drivers do not (except for the
> Hyper-V synthetic SCSI driver).   When both are zero, presumably
> there are no alignment requirements, so a stride of 1 is appropriate.

Sorry, yes, I messed up the commit message here as I was trying to reason
through the allocation case separately from the mapping case. However, I
need to digest the rest of this thread before doing the obvious fix...

Will

