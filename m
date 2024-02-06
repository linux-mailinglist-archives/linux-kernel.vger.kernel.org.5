Return-Path: <linux-kernel+bounces-54687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8A484B280
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A3C1C238DE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960FF12E1F0;
	Tue,  6 Feb 2024 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sC+ynBUj"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E672612E1D9
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215320; cv=none; b=orfFi99QxTrVX+9KLaupKWkawWaao084TnVy8q+S661O+4H9J7WagNSeS0Qn5SOKFwlcBISbrLyCHk1TClJQllQuJf6tnuwXQnQnQsRiRj+CfqlDme10tLH29+7Wop/o5OZUHzRH1qLfYcfGXDgRRsIuIVS2dN1vll8nk7hBi4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215320; c=relaxed/simple;
	bh=12ljC+gaSJ1gkfLRkLsG39AQOSWyWJvCPPJpVFot1CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk6g/61Lbw/39cKKwg6WUEEEzIdaA4qT6ZYINhkyVGNW92YAXXj6YWJFKuBoO7FM/imw5Qbn7OnCN/ZGoBgpmMAyt+MaKhHu6981FpssSbT/TXn3SGW0epaCWWBuIBxGVK27VtvydqSoMMk6HE8RS70z1Duru2Xa0oTGofoeIRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sC+ynBUj; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 6 Feb 2024 10:28:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707215316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UH4qnyV5AlPKuzyHE4nU37Hkz+CAr8GksiGngTSrZn0=;
	b=sC+ynBUjP2HdG1anTszZxl9OkpuQhhXiL+XqX9h1SsafTSnJQaWBtEA/1X4NVwjU4mAgrj
	FDC2SjZo1erNoQrKFmiJEVJKovL9V9OLMFyI4sZdaMLBSIoP7TkY+vG2k1d1PcvoMoaSu7
	Ud1L6lkEXjRKG6SfDrs0QxCo8xf9xpE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Saurav Sachidanand <sauravsc@amazon.com>
Cc: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] KVM: arm64/vgic: Populate GICR_TYPER with Aff3
Message-ID: <ZcIJzn9KLR_bWdwc@linux.dev>
References: <20240205184326.78814-1-sauravsc@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205184326.78814-1-sauravsc@amazon.com>
X-Migadu-Flow: FLOW_OUT

Hi Saurav,

On Mon, Feb 05, 2024 at 06:43:26PM +0000, Saurav Sachidanand wrote:

[...]

> diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> index c15ee1df036a..26bc838ce14c 100644
> --- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> +++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> @@ -324,6 +324,7 @@ static unsigned long vgic_mmio_read_v3r_typer(struct kvm_vcpu *vcpu,
>  	u64 value;
>  
>  	value = (u64)(mpidr & GENMASK(23, 0)) << 32;
> +	value |= (u64)((mpidr >> 32) & GENMASK(7, 0)) << 56;

This looks suspiciously similar to what MPIDR_AFFINITY_LEVEL()
accomplishes. I think we can tolerate a few extra lines of code to make
the entire thing more self-documenting, like:

	value = ((u64)MPIDR_AFFINITY_LEVEL(mpidr, 3) << 56 |
		MPIDR_AFFINITY_LEVEL(mpidr, 2) << 48 |
		MPIDR_AFFINITY_LEVEL(mpidr, 1) << 40 |
		MPIDR_AFFINITY_LEVEL(mpidr, 0) << 32);

-- 
Thanks,
Oliver

