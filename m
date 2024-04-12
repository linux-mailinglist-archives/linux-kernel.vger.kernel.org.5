Return-Path: <linux-kernel+bounces-142884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF9C8A31A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66BE2B222F9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184B9146A79;
	Fri, 12 Apr 2024 14:56:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5477383CD8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933779; cv=none; b=tfhC0wZxMQoqMeRBhHNjVcTuOA56i8Mntftriwuv8KW0N4acBTcX9yVZrj+rgHq5ox+mSRlTwOeAi5De0dp6cxMOMkvv1bcInwDMraQ71r7O6Ym7FX339crWWjZQQXkpQ5fBlrim6TYGkfF1GGxfl1NUJ+21CwQwGy/r0B2Gsdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933779; c=relaxed/simple;
	bh=Hy6hh7uApPUxf7/MqJfKIj9pzl3U6tocuYJF5Ds3Qac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=les3J3ThJ1SKhy8/t7whM3QUMul+7F5CXlf4BWp6SuQRLraSMazlz5uTU4hK3aFk1DI9A1EQ6rYwm0AGuk3SMnEOeG2SXmCR6imRBQvpuXUGLO1Ytb316FOpMicQZVd9RL5JRtN4X210htWXeGPJdXkoiIVMk6afpLJJr2GeCgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ECDA339;
	Fri, 12 Apr 2024 07:56:46 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.37.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C7963F64C;
	Fri, 12 Apr 2024 07:56:16 -0700 (PDT)
Date: Fri, 12 Apr 2024 15:56:08 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, David Hildenbrand <david@redhat.com>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Speed up boot with faster linear map creation
Message-ID: <ZhlLiM912mFj_dam@FVFF77S0Q05N.cambridge.arm.com>
References: <20240412131908.433043-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412131908.433043-1-ryan.roberts@arm.com>

On Fri, Apr 12, 2024 at 02:19:05PM +0100, Ryan Roberts wrote:
> Hi All,
> 
> It turns out that creating the linear map can take a significant proportion of
> the total boot time, especially when rodata=full. And most of the time is spent
> waiting on superfluous tlb invalidation and memory barriers. This series reworks
> the kernel pgtable generation code to significantly reduce the number of those
> TLBIs, ISBs and DSBs. See each patch for details.
> 
> The below shows the execution time of map_mem() across a couple of different
> systems with different RAM configurations. We measure after applying each patch
> and show the improvement relative to base (v6.9-rc2):
> 
>                | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
>                | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
> ---------------|-------------|-------------|-------------|-------------
>                |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
> ---------------|-------------|-------------|-------------|-------------
> base           |  168   (0%) | 2198   (0%) | 8644   (0%) | 17447   (0%)
> no-cont-remap  |   78 (-53%) |  435 (-80%) | 1723 (-80%) |  3779 (-78%)
> batch-barriers |   11 (-93%) |  161 (-93%) |  656 (-92%) |  1654 (-91%)
> no-alloc-remap |   10 (-94%) |  104 (-95%) |  438 (-95%) |  1223 (-93%)
> 
> This series applies on top of v6.9-rc2. All mm selftests pass. I've compile and
> boot tested various PAGE_SIZE and VA size configs.

Nice!

> Ryan Roberts (3):
>   arm64: mm: Don't remap pgtables per-cont(pte|pmd) block
>   arm64: mm: Batch dsb and isb when populating pgtables
>   arm64: mm: Don't remap pgtables for allocate vs populate

For the series:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Catalin, Will, are you happy to pick this up?

Mark.

