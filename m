Return-Path: <linux-kernel+bounces-87557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC2B86D5E2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BA91F231E1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF36F6D525;
	Thu, 29 Feb 2024 21:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFKFW96s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B54F6D503;
	Thu, 29 Feb 2024 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240803; cv=none; b=DgsBRwxkOCvnmI6qLvBZUNBy1TRiO33cVFAISOriHmHNNGDv2uyhLnbS9KypXL8w+ibz8cKMmhW5d6PF6771qHH6v7UlJo7jiJadhUCQ6dpRfJNRYUATBQr9n5nQuveoUjndqc4hdcHpkl5l9qyXBs7/i7UlWifhk7lpF7F4Bzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240803; c=relaxed/simple;
	bh=AEjYtbKr9ZxceLUwWxzAgzu87zcJb3nLNbDcnS6bRS4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cebCOL8ADyVy68XTCzIq4Ha1cYyRSRF53i+/DtDYIwe3eWUsUTv0Ibh77ThMeqGXBTru8OxYpU7uGF8vmzPwmqbBVUlLirCAduAujp+yLqe8eambhjtUbLeRX1wGw4HCenZ8TgZqOLpwhh1T0mNsCoEbw/GVvfsI8LCWumPCGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFKFW96s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF351C433F1;
	Thu, 29 Feb 2024 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709240802;
	bh=AEjYtbKr9ZxceLUwWxzAgzu87zcJb3nLNbDcnS6bRS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bFKFW96sIiJGSerm8V0bNCD1SbFpGcH/jDdjnh4RISImFg9R0/QLxoUqbMF5f6JXJ
	 ORnFl3JyAhMJN9MkJO1le80pH4UK/bdn6EpKh3PKAwnwHo27GndhmCouKfNFHe0Csw
	 1/iToOeuEUcZ5liziICd9GbPgezx1mJo2E7pHzz/S3JtN7xuCTA22hBMTvzvWGWXUf
	 DDyborhhtQlAOxY+QJcmFzr0ZFBL6UoxhMMXo3Yo+TKfcQ4bMY60AjqEwj4+5dAgbd
	 egOHbUlLATGcB4yk3C8SQDfRgmV4pljL9ydcLl6A+ilyVdaUmMbcespX3oZPyRvXRS
	 11bYcGkPSOkcA==
Date: Thu, 29 Feb 2024 15:06:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, robin.murphy@arm.com,
	jgg@ziepe.ca, kevin.tian@intel.com, dwmw2@infradead.org,
	will@kernel.org, lukas@wunner.de, yi.l.liu@intel.com,
	dan.carpenter@linaro.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: avoid sending explicit ATS invalidation
 request to released device
Message-ID: <20240229210640.GA362869@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229033138.3379560-1-haifeng.zhao@linux.intel.com>

On Wed, Feb 28, 2024 at 10:31:38PM -0500, Ethan Zhao wrote:
> The introduction of per iommu device rbtree also defines the lifetime of
> interoperation between iommu and devices, if the device has been released
> from device rbtree, no need to send ATS invalidation request to it anymore,
> thus avoid the possibility of later ITE fault to be triggered.
> 
> This is part of the followup of prior proposed patchset
> 
> https://do-db2.lkml.org/lkml/2024/2/22/350

Please use https://lore.kernel.org/ URLs instead.  This one looks like
https://lore.kernel.org/r/20240222090251.2849702-1-haifeng.zhao@linux.intel.com/

> To make sure all the devTLB entries to be invalidated in the device release
> path, do implict invalidation by fapping the E bit of ATS control register.
> see PCIe spec v6.2, sec 10.3.7 implicit invalidation events.

s/implict/implicit/

s/fapping/?/  (no idea :)  "flipping"?  Oh, probably "flapping" per the
comment below.  But I think "flapping" is ambiguous; "setting" would be
better)

s/v6.2/r6.2/ (also below in comment)

> Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table interface")
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 6 ++++++
>  drivers/iommu/intel/pasid.c | 7 +++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 6743fe6c7a36..b85d88ccb4b0 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1368,6 +1368,12 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
>  	pdev = to_pci_dev(info->dev);
>  
>  	if (info->ats_enabled) {
> +		pci_disable_ats(pdev);
> +		/*
> +		 * flap the E bit of ATS control register to do implicit
> +		 * ATS invlidation, see PCIe spec v6.2, sec 10.3.7

s/invlidation/invalidation/

I would put the comment above the pci_disable_ats(), so it looks like
this:

  /* comment ... */
  pci_disable_ats(pdev);
  pci_enable_ats(pdev, VTD_PAGE_SHIFT);

  pci_disable_ats(pdev);

because the spec says the E field must change from Clear to Set to
cause invalidation of all ATC entries, so it's important to see that
we clear E first, then set it.

> +		 */
> +		pci_enable_ats(pdev, VTD_PAGE_SHIFT);
>  		pci_disable_ats(pdev);
>  		info->ats_enabled = 0;
>  		domain_update_iotlb(info->domain);
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 108158e2b907..5f13e017a12c 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -215,6 +215,13 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
>  		return;
>  
>  	sid = info->bus << 8 | info->devfn;
> +	/*
> +	 * If device has been released from rbtree, no need to send ATS
> +	 * Invalidation	request anymore, that could cause ITE fault.
> +	 */
> +	if (!device_rbtree_find(iommu, sid))
> +		return;
> +
>  	qdep = info->ats_qdep;
>  	pfsid = info->pfsid;
>  
> -- 
> 2.31.1
> 

