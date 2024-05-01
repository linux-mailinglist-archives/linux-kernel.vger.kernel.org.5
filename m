Return-Path: <linux-kernel+bounces-165028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469A48B86CD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79A01B21D28
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B3E4EB38;
	Wed,  1 May 2024 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MIwH6gqc"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70564E1D2
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714551457; cv=none; b=ab3DurJAezAAyzhmcAC1VCqDl2vVlQxnafHEQgh2AMNjKpvt9daX5W/dvD5ymz3lyYgbJiZ6uOQzxy7TrgYuRZZ86tDqqZwwscIDXb4y3blZC4LEk0AALXr53NFqUwSrzoDnP7MaTuhhhmiwfeuLMVDySru5vHoBsFUodCv67vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714551457; c=relaxed/simple;
	bh=MNK5gLF/R3MmhNubtHY49Z4q3G20BNl/rBdmK8H7BG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SamkQt8wkqxDRRZNhGBPm3mLZ5LpCdcuGPZoycbXU2qq4+Tv1vMxiGTd2ZwgPONeC/xCcOzZglKHwrcTOA4V/MIUFU3u9/MuDKtvcu4zlQRkUwOuOQpJKMh9XV25d2dFc/n+fSKsxSi6XOqHzPdqItMw+bFYGwy4zOsxRHvJD/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MIwH6gqc; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 1 May 2024 08:17:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714551453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=akW+2UMs2xoloXlr720i0CCqdD/KMrFp+0W48l7CE/E=;
	b=MIwH6gqcLnuS2znrPZs4k8FP7bQYUTCRBRlB3CubDp2sfoKsbpAowrVD2I8jIe32QOQxD4
	vsNGZtvghVrvnorcdQEGF0cO/8rRalhFMj0yjWAOZ5JMjivARWW/3Go/9xCZY2xn3zxZI8
	aKXxqiEY+SrUnVP3LLvW9oJ/LBSxfCM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sebastian Ott <sebott@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 0/6] KVM: arm64: emulation for CTR_EL0
Message-ID: <ZjH6mgJa-ilmPu95@linux.dev>
References: <20240426104950.7382-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426104950.7382-1-sebott@redhat.com>
X-Migadu-Flow: FLOW_OUT

Hi Sebastian,

On Fri, Apr 26, 2024 at 12:49:44PM +0200, Sebastian Ott wrote:
> Hej folks,
> 
> I'm looking into supporting migration between 2 Ampere Altra (Max)
> machines (using Neoverse-N1). They are almost identical regarding
> their feature id register state except for CTR_EL0.DIC which is set
> on one machine but not the other.
> 
> CTR_EL0 is currently marked as invariant and migrating a VM between
> those 2 machines using qemu fails.

I left some feedback on the series, but in addition to that would it be
possible to augment the set_id_regs selftest to exercise the CTR_EL0
mutability?

-- 
Thanks,
Oliver

