Return-Path: <linux-kernel+bounces-124382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525108916A8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBCA4B216FA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F213F52F8C;
	Fri, 29 Mar 2024 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sZ5ny+kd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E0552F7D;
	Fri, 29 Mar 2024 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711707670; cv=none; b=tlCXn55LxtHVB4jJF8MpEaOt/rlbjFmPfz8esKXATB4wgiD3fzKFTkNTITI1Z5iv3oa/Pn/+lPzppXiCLEuFta+XfnKoNhJlLuheSrfc59Tc8av/KeSsAne0r5XDTyqWDpXz+1W2aRIW/6gWKYg+OubpvFG8+6e0zfP3twweXEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711707670; c=relaxed/simple;
	bh=FWV0RPdSwemXt+VGyB5/jZs/u/Zy2oHIfu++kCKBnr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0KUG/d+BxAnq4Lhth+7idCI6gvs2J2q+VNooI3uysZ0bRiBO7plNIAMrO8TcEVqQLS4yQJZFuhbfOCw5yI3WYm6YVoT4x6knXvwdOFyuRiXATnCdhe/lmrITmoayDxqyrLFL1QHptqjMOZ+hLisD5AGDcKFYBlcKO5RzbnEA9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sZ5ny+kd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9AAC433C7;
	Fri, 29 Mar 2024 10:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711707669;
	bh=FWV0RPdSwemXt+VGyB5/jZs/u/Zy2oHIfu++kCKBnr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZ5ny+kdCbNSKTKZyRo7jS/7rGT/lKqkbt9VoyfJzJ81aqlnbezfr4GPKClAdoCQu
	 r4WZNLJDbodV83wSHMEHtB+nn2Q7pqWPjV7T0rsBWAFoV66t+CYik9ENgLLzLvQaWm
	 bSUzjgpUtZ6cX0hPe6rd2jokvbGhw7nZfqg+RBh4=
Date: Fri, 29 Mar 2024 11:21:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nikhil V <quic_nprakash@quicinc.com>
Cc: Charan Teja Kalla <quic_charante@quicinc.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH RESEND STABLE v6.1] iommu: Avoid races around default
 domain allocations
Message-ID: <2024032955-exponent-nativity-fba4@gregkh>
References: <cbf1295589bd90083ad6f75a7fbced01f327c047.1708680521.git.quic_nprakash@quicinc.com>
 <2024030403-self-morality-062e@gregkh>
 <6dcf6bc5-e1e5-8388-8bcb-c093a5fb61ed@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dcf6bc5-e1e5-8388-8bcb-c093a5fb61ed@quicinc.com>

On Tue, Mar 05, 2024 at 01:01:12PM +0530, Nikhil V wrote:
> 
> 
> On 3/4/2024 6:55 PM, Greg KH wrote:
> > On Mon, Mar 04, 2024 at 04:40:50PM +0530, Nikhil V wrote:
> > > From: Charan Teja Kalla <quic_charante@quicinc.com>
> > > 
> > > This fix is applicable for LTS kernel, 6.1.y. In latest kernels, this race
> > > issue is fixed by the patch series [1] and [2]. The right thing to do here
> > > would have been propagating these changes from latest kernel to the stable
> > > branch, 6.1.y. However, these changes seems too intrusive to be picked for
> > > stable branches. Hence, the fix proposed can be taken as an alternative
> > > instead of backporting the patch series.
> > > [1] https://lore.kernel.org/all/0-v8-81230027b2fa+9d-iommu_all_defdom_jgg@nvidia.com/
> > > [2] https://lore.kernel.org/all/0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com/
> > > 
> > > Issue:
> > > A race condition is observed when arm_smmu_device_probe and
> > > modprobe of client devices happens in parallel. This results
> > > in the allocation of a new default domain for the iommu group
> > > even though it was previously allocated and the respective iova
> > > domain(iovad) was initialized. However, for this newly allocated
> > > default domain, iovad will not be initialized. As a result, for
> > > devices requesting dma allocations, this uninitialized iovad will
> > > be used, thereby causing NULL pointer dereference issue.
> > > 
> > > Flow:
> > > - During arm_smmu_device_probe, bus_iommu_probe() will be called
> > > as part of iommu_device_register(). This results in the device probe,
> > > __iommu_probe_device().
> > > 
> > > - When the modprobe of the client device happens in parallel, it
> > > sets up the DMA configuration for the device using of_dma_configure_id(),
> > > which inturn calls iommu_probe_device(). Later, default domain is
> > > allocated and attached using iommu_alloc_default_domain() and
> > > __iommu_attach_device() respectively. It then ends up initializing a
> > > mapping domain(IOVA domain) and rcaches for the device via
> > > arch_setup_dma_ops()->iommu_setup_dma_ops().
> > > 
> > > - Now, in the bus_iommu_probe() path, it again tries to allocate
> > > a default domain via probe_alloc_default_domain(). This results in
> > > allocating a new default domain(along with IOVA domain) via
> > > __iommu_domain_alloc(). However, this newly allocated IOVA domain
> > > will not be initialized.
> > > 
> > > - Now, when the same client device tries dma allocations via
> > > iommu_dma_alloc(), it ends up accessing the rcaches of the newly
> > > allocated IOVA domain, which is not initialized. This results
> > > into NULL pointer dereferencing.
> > > 
> > > Fix this issue by adding a check in probe_alloc_default_domain()
> > > to see if the iommu_group already has a default domain allocated
> > > and initialized.
> > > 
> > > Cc: <stable@vger.kernel.org> # see patch description, fix applicable only for 6.1.y
> > > Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> > > Co-developed-by: Nikhil V <quic_nprakash@quicinc.com>
> > > Signed-off-by: Nikhil V <quic_nprakash@quicinc.com>
> > > ---
> > >   drivers/iommu/iommu.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > 
> > Why RESEND?  What happened to the first send?
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> Hi Greg,
> 
> There are no changes as such w.r.t first send, [1]. It is resent to gain
> attention on this patch. Also, we have added a proper Cc: stable tag with
> this patch.

Thanks, now queued up.

greg k-h

