Return-Path: <linux-kernel+bounces-87558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA8686D5E3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF82528A233
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BADC6D51C;
	Thu, 29 Feb 2024 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmlYJ0BY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AE574BE6;
	Thu, 29 Feb 2024 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240848; cv=none; b=t7g6hDFzK4vCCaRHXJAaEOpudmctwE2wT/MdZdIdrPQ7lC7rTsdsPAxbNkBHgc29Lxquyqv05U0olNscxaj0xHikpqev0WoLQoWB2G11UHt4Mr+FsUz4ulj2JadvzCn2mtKxIGx0aMKqWNP/J2+gt1bWWtx6Ngww1FV+R4AFWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240848; c=relaxed/simple;
	bh=J6nl5xudWoaHe5zt2ZmvKLymkNzx1v+WzoPkxo7Ue94=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=suovqQg6Akop3TTz6AXuwdrhWVfWQM36myAEZBgx+Az7raOIoPYn55lOMbk6+z/E3dxTCL2NIYqqgCMB3Lha6SB3LtyFCvzDq/+ujGpT3CSnrmkL2+EtxgK6HEFVyYdRKR6llGoRW09WcAhlixF5REiVmqQZU40dhwyYVDzrJN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmlYJ0BY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3BEC433F1;
	Thu, 29 Feb 2024 21:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709240848;
	bh=J6nl5xudWoaHe5zt2ZmvKLymkNzx1v+WzoPkxo7Ue94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KmlYJ0BYjLjSdDhJPfMWjeAbasyaPJyxC5J5JG5g9OpaBI/OR5KF5myyHrzftRLKT
	 2d7M7lO5gv/wY3vsu9dOs+HU9cVpFI+2Lsea5uCZSwfPxH05KOrOAhVBUnqnaHZGx7
	 AaACX2V6QPzfh9/UcwVxDoseikUQz2j/mvH/n7Tfc1II+lw45KCiBnVECXD9KFFiky
	 403mfSB593j48zUgQkxtW24ECMmUNq440NoGr6WNlocpiZkhqmN+rjcMxQ1NRCJsHj
	 ppa89wrCYjojAiPm8lKM+1dRhEF0s3tGyaSGiLIRKFC1qcIFpx6LxxEUbUmC3v3C6h
	 oUmHBZwVqW3PQ==
Date: Thu, 29 Feb 2024 15:07:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, robin.murphy@arm.com,
	jgg@ziepe.ca, kevin.tian@intel.com, dwmw2@infradead.org,
	will@kernel.org, lukas@wunner.de, yi.l.liu@intel.com,
	dan.carpenter@linaro.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: improve ITE fault handling if device was
 released
Message-ID: <20240229210726.GA363458@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229040724.3393042-1-haifeng.zhao@linux.intel.com>

On Wed, Feb 28, 2024 at 11:07:24PM -0500, Ethan Zhao wrote:
> Break the loop to blindly retry the timeout ATS invalidation request
> after ITE fault hit if device was released or isn't present anymore.
> 
> This is part of the followup of prior proposed patchset
> 
> https://do-db2.lkml.org/lkml/2024/2/22/350

Use lore URL, please.

> Fixes: 6ba6c3a4cacf ("VT-d: add device IOTLB invalidation support")
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
>  drivers/iommu/intel/dmar.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index d14797aabb7a..d01d68205557 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1273,6 +1273,9 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>  {
>  	u32 fault;
>  	int head, tail;
> +	u64 iqe_err, ite_sid;
> +	struct device *dev = NULL;
> +	struct pci_dev *pdev = NULL;
>  	struct q_inval *qi = iommu->qi;
>  	int shift = qi_shift(iommu);
>  
> @@ -1317,6 +1320,13 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>  		tail = readl(iommu->reg + DMAR_IQT_REG);
>  		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>  
> +		/*
> +		 * SID field is valid only when the ITE field is Set in FSTS_REG
> +		 * see Intel VT-d spec r4.1, section 11.4.9.9
> +		 */
> +		iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
> +		ite_sid = DMAR_IQER_REG_ITESID(iqe_err);
> +
>  		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
>  		pr_info("Invalidation Time-out Error (ITE) cleared\n");
>  
> @@ -1326,6 +1336,21 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>  			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
>  		} while (head != tail);
>  
> +		/*
> +		 * If got ITE, we need to check if the sid of ITE is one of the
> +		 * current valid ATS invalidation target devices, if no, or the
> +		 * target device isn't presnet, don't try this request anymore.
> +		 * 0 value of ite_sid means old VT-d device, no ite_sid value.
> +		 */
> +		if (ite_sid) {
> +			dev = device_rbtree_find(iommu, ite_sid);
> +			if (!dev || !dev_is_pci(dev))
> +				return -ETIMEDOUT;
> +			pdev = to_pci_dev(dev);
> +			if (!pci_device_is_present(pdev) &&
> +				ite_sid == pci_dev_id(pci_physfn(pdev)))
> +				return -ETIMEDOUT;
> +		}
>  		if (qi->desc_status[wait_index] == QI_ABORT)
>  			return -EAGAIN;
>  	}
> -- 
> 2.31.1
> 

