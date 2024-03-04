Return-Path: <linux-kernel+bounces-90640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053118702A0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90DF81F267DF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527A23D968;
	Mon,  4 Mar 2024 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p5+WAq3b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6DA3D57C;
	Mon,  4 Mar 2024 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558723; cv=none; b=EeepLYhVZcc9mhgA3om/i2MpZI2gCXjQ4pP6kftolefuKa0Lc8u+VF6DYuYomXQqpGHw6zrRnanxYq7nfNGp6oT2HReXRsOCahgGp8EK1ECpIXKpOiZqGWazUKepj1hLv06B3xEK6qa1YkNsBj8PJCTdCOBxzwppJj+XcxOJ73Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558723; c=relaxed/simple;
	bh=7k5KTxhcjg0DBPGEReEyIU1YQdK9/ETlpA6DECaW8oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbcHb1lkwRM57nxqxxQtDscREbIsBc/fhu1VMUs38+b56BXk+E+cB7c+LHlbyF2fkyWSd1ApSwVQBKz5qWcsD7S1OJO6N1whE/JaAxDlcZlUCStC9UjJKEFUHpUomlYD+0ax6abe/ZwnkqOT1hixu1YJlj8xbc+y7IY/E3R2IvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p5+WAq3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E157C433C7;
	Mon,  4 Mar 2024 13:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709558723;
	bh=7k5KTxhcjg0DBPGEReEyIU1YQdK9/ETlpA6DECaW8oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p5+WAq3bQpF0mHhs2r+TE58RSsMX6QZ/3R4qUKMp18a7M8pacdx7uZi2mr5Nq++Nx
	 //KBCSiHXZ9945m/SvLcA1RluCDFy2j7YiMcTG3hVUrEi3iz2E3xCwKndwnT0tnDRB
	 DCqfsULJi8T85cQfKBm2ChMrfx9FSAEMQNun3QN4=
Date: Mon, 4 Mar 2024 14:25:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nikhil V <quic_nprakash@quicinc.com>
Cc: Charan Teja Kalla <quic_charante@quicinc.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH RESEND STABLE v6.1] iommu: Avoid races around default
 domain allocations
Message-ID: <2024030403-self-morality-062e@gregkh>
References: <cbf1295589bd90083ad6f75a7fbced01f327c047.1708680521.git.quic_nprakash@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbf1295589bd90083ad6f75a7fbced01f327c047.1708680521.git.quic_nprakash@quicinc.com>

On Mon, Mar 04, 2024 at 04:40:50PM +0530, Nikhil V wrote:
> From: Charan Teja Kalla <quic_charante@quicinc.com>
> 
> This fix is applicable for LTS kernel, 6.1.y. In latest kernels, this race
> issue is fixed by the patch series [1] and [2]. The right thing to do here
> would have been propagating these changes from latest kernel to the stable
> branch, 6.1.y. However, these changes seems too intrusive to be picked for
> stable branches. Hence, the fix proposed can be taken as an alternative
> instead of backporting the patch series.
> [1] https://lore.kernel.org/all/0-v8-81230027b2fa+9d-iommu_all_defdom_jgg@nvidia.com/
> [2] https://lore.kernel.org/all/0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com/
> 
> Issue:
> A race condition is observed when arm_smmu_device_probe and
> modprobe of client devices happens in parallel. This results
> in the allocation of a new default domain for the iommu group
> even though it was previously allocated and the respective iova
> domain(iovad) was initialized. However, for this newly allocated
> default domain, iovad will not be initialized. As a result, for
> devices requesting dma allocations, this uninitialized iovad will
> be used, thereby causing NULL pointer dereference issue.
> 
> Flow:
> - During arm_smmu_device_probe, bus_iommu_probe() will be called
> as part of iommu_device_register(). This results in the device probe,
> __iommu_probe_device().
> 
> - When the modprobe of the client device happens in parallel, it
> sets up the DMA configuration for the device using of_dma_configure_id(),
> which inturn calls iommu_probe_device(). Later, default domain is
> allocated and attached using iommu_alloc_default_domain() and
> __iommu_attach_device() respectively. It then ends up initializing a
> mapping domain(IOVA domain) and rcaches for the device via
> arch_setup_dma_ops()->iommu_setup_dma_ops().
> 
> - Now, in the bus_iommu_probe() path, it again tries to allocate
> a default domain via probe_alloc_default_domain(). This results in
> allocating a new default domain(along with IOVA domain) via
> __iommu_domain_alloc(). However, this newly allocated IOVA domain
> will not be initialized.
> 
> - Now, when the same client device tries dma allocations via
> iommu_dma_alloc(), it ends up accessing the rcaches of the newly
> allocated IOVA domain, which is not initialized. This results
> into NULL pointer dereferencing.
> 
> Fix this issue by adding a check in probe_alloc_default_domain()
> to see if the iommu_group already has a default domain allocated
> and initialized.
> 
> Cc: <stable@vger.kernel.org> # see patch description, fix applicable only for 6.1.y
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> Co-developed-by: Nikhil V <quic_nprakash@quicinc.com>
> Signed-off-by: Nikhil V <quic_nprakash@quicinc.com>
> ---
>  drivers/iommu/iommu.c | 3 +++
>  1 file changed, 3 insertions(+)

Why RESEND?  What happened to the first send?

thanks,

greg k-h

