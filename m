Return-Path: <linux-kernel+bounces-164987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBAE8B8616
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BA4283AF1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660984D11B;
	Wed,  1 May 2024 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WFVem5/C"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383844CB4E
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714548704; cv=none; b=ZngJ1gFlorUjMERK4xh5KMgMw6va7RosCD42k3a1XIdx2N5u5BuqymX771rFb94tzcpKoZH/F00afiP9hDQ5YAT28Knb/Sijzvac9WQvN98UKYbnQUKge6vgWJFuJxBlXSHJvRCGFtfp+SDmCOldBOxiFalwxPXsL86SY0HflrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714548704; c=relaxed/simple;
	bh=oUy1TAwlnhXThw+ui/oC/8aQc/CovlUHkSG4zXgbPN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fs3VBUoYLOr/MnjJDV40hOAUyetgjvfyw6f1gMheJ8IsziYkGi5MmUv1KvfWYkq1D+esuQt/epjVnulah6CoHVqe9R7fvkfbPjhonkKhvFpBQW1wHX8u8nopMGSRg7CuJZ1PAVrQXiRu6mZ847KWvDe/JCGvBdJYhgfEI19WCIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WFVem5/C; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 1 May 2024 07:31:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714548700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sl6DYhZs4KcDMj2OuFfOTtj126Sqpmu4poaggNg8mUs=;
	b=WFVem5/Ci1b7QI5aBq7JA9nVh9Oa+2Qf1y8HBiBhp2DxvffdPV8c0K9PR6OoZ9s6Dcu0QW
	+koQu0s5YUjjMxQXskwVCqRmvnsfEfbtGD0NEhLT6xVaW5LfH2869kG3HQu0QZb/AUXbFz
	02fgtQhtXJQMxLWYmLFu/2tVJ7iPmqI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sebastian Ott <sebott@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 5/6] KVM: arm64: show writable masks for feature
 registers
Message-ID: <ZjHv14-GBafptt-m@linux.dev>
References: <20240426104950.7382-1-sebott@redhat.com>
 <20240426104950.7382-6-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426104950.7382-6-sebott@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 26, 2024 at 12:49:49PM +0200, Sebastian Ott wrote:
> Instead of using ~0UL provide the actual writable mask for
> non-id feature registers in the output of the
> KVM_ARM_GET_REG_WRITABLE_MASKS ioctl.

Urgh, yeah in retrospect I think we should've constrained this to the
registers KVM considers "id regs" (the space occupied by known registers
or otherwise RAZ).

> Explicitely set the mask for CLIDR_EL1 to make sure we present
> the same value to userspace than before.

typo: explicitly

Also, we know the set of mutable bits for CLIDR_EL1 as it is handled in
set_clidr(). The mask really should match that, since the UAPI is
documented as "allowing userspace to know what fields can be changed for
the system register"

-- 
Thanks,
Oliver

