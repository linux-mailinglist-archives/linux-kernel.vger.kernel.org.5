Return-Path: <linux-kernel+bounces-94280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2F2873C6C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE881F218D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61181C02;
	Wed,  6 Mar 2024 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="VvZ2tEfw"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5377F5D8F0
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743237; cv=none; b=qAI+DxoRx4FIBag96amVWinEZOfQ0cAHlFOK3lR41OqOtIxIhYc9dPX5xFo5tbuWRHjEMg5uTNzutDBmvbIW7V9+MTt8OP3lmzbsuyx/VaXHEVg/O0ql0oJIQtyC71El6XFBax5Fw2515871aRxpuCtN22MIFs/sMVNfrxyjSSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743237; c=relaxed/simple;
	bh=DzK8eeew7owQbLWBsnwtpFXZ2gPBFj5rnJtQIM4ikNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0V2d8mZ1K0D+atVM3QKOGJbJajQ66JQ2lqA0adpZfJNjmO32dFjkMCyYh8PgylucI7MVPiaiC6p6Mg/6aRO6zP3Pg9CEHixAymSVKwmbZ763JCBp3p/U1p/7f9JK3wzvhtE6REW1qkneiGIt7W643VXCZeab3OAoS1/u+zzAak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=VvZ2tEfw; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 15B751C85E6;
	Wed,  6 Mar 2024 17:40:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1709743233;
	bh=DzK8eeew7owQbLWBsnwtpFXZ2gPBFj5rnJtQIM4ikNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VvZ2tEfwn2bqRzHS/qHGD1wjA5vJ9Lwb+SpS9Xzeyd3iF5xLQnSRn2H9meRXaLsiC
	 sIDk3RVghO8bZPyXTv4oFmAKcCaD8gFuuxpACD9REdbNCJV5mA8s4lKWS7JT52lBoA
	 VlIcO3k5WJagMlFckeHt+aqxRwG+IEVBDqc1zhN+waw0VClxL0MLISRsUoG9INsBIl
	 VHgj2O4gNC2c6oLC2aSWRM0XHCYcrLae2/x5GPgn6/uQ5BPIe6TUoiPJZM1E7iMz5R
	 vkgI6rTxzJiUkgCL4NPntkl+EdSDAIgbHwBNuaMnMS+HNR1PazdGGltEpe4Fr1wmKA
	 T0WNYi/tYLc0w==
Date: Wed, 6 Mar 2024 17:40:31 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, will@kernel.org,
	mhklinux@outlook.com, petr@tesarici.cz, hch@lst.de
Subject: Re: [PATCH] iommu/dma: Document min_align_mask assumption
Message-ID: <Zeicf08_vcO3oYnn@8bytes.org>
References: <dbb4d2d8e5d1691ac9a6c67e9758904e6c447ba5.1709553942.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbb4d2d8e5d1691ac9a6c67e9758904e6c447ba5.1709553942.git.robin.murphy@arm.com>

On Mon, Mar 04, 2024 at 12:05:42PM +0000, Robin Murphy wrote:
> iommu-dma does not explicitly reference min_align_mask since we already
> assume that that will be less than or equal to any typical IOVA granule.
> We wouldn't realistically expect to see the case where it is larger, and
> that would be non-trivial to support, however for the sake of reasoning
> (particularly around the interaction with SWIOTLB), let's clearly
> enforce the assumption.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks Robin.

