Return-Path: <linux-kernel+bounces-102257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A43987AFDE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6371C26074
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756A162168;
	Wed, 13 Mar 2024 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnNlYLBO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62950A6C;
	Wed, 13 Mar 2024 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350503; cv=none; b=BunFUkTnldBA4bwmGGLS4jnmgCOREFPZzjWAxCG/KcnQvLemnng7zNWnPBXcRENLvAb9yHC46gf/fUsi0QzoIkWxZkaaEtpzQnXaSonpBcO26xmUuqSI/P+LtKykXIoyI4jQacKUsvi1DucRkCKNP6ixhc35MK5Lm4NmJOehgwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350503; c=relaxed/simple;
	bh=2+HrNPQNNrVW2SJnqA5HjU8yBIrVF6D+riwSfpUrNxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lllLrNmlIhNwbQeCPfBLYhD6EZpw3xwwSgYeqMLMcdmRTbV26ZBmeLzH/tdbPQy1/tQJ/8ozHhzK0LfSZYOD/gHOEs1BxqhpKNZ87yQzTkjPS27Hq9uIAtyfGCh4xaubiRuT2/xLriDDTGhh+G9epb6bcKzXW3dygh0D6aPaJnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnNlYLBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB54FC433F1;
	Wed, 13 Mar 2024 17:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710350503;
	bh=2+HrNPQNNrVW2SJnqA5HjU8yBIrVF6D+riwSfpUrNxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nnNlYLBOEBemLClK28M3tirohPxrI8276u9bgKJNFG7AT4s1MUEOQIyZgoGzSD12+
	 ZvZR4ab6rf/N/GYcd2cEyziyM5H1Nr3IgUNtc5XE310ejJK2Rvpg1N24u5EWuRN/g/
	 T2Dt7Scnc0QZf2f5qhWSa3pBA3lec6w1jaPeTCj6QwyNVmtgrNgfMG/TAOAq02Qs2D
	 2n6NvKzuuH/k/Wmf+9ao4Azr0QhIA3vts5c0bYjjTMPOnJCBtYrAPT4KATDTb1YeMt
	 pCTL2EvdQykyihCSponjrJmQyX8TqE8zopRYMDCeHS7Enzt/Dcovtpo+O1XCio1eAo
	 j6VkmEIRpYMRw==
Date: Wed, 13 Mar 2024 10:21:41 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Qiang Zhang <qiang4.zhang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Stable@vger.kernel.org
Subject: Re: [PATCH] memtest: use {READ,WRITE}_ONCE in memory scanning
Message-ID: <20240313172141.GB3064248@dev-arch.thelio-3990X>
References: <20240312080422.691222-1-qiang4.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312080422.691222-1-qiang4.zhang@intel.com>

On Tue, Mar 12, 2024 at 04:04:23PM +0800, Qiang Zhang wrote:
> memtest failed to find bad memory when compiled with clang. So use
> {WRITE,READ}_ONCE  to access memory to avoid compiler over optimization.

This commit message is severely lacking in details in my opinion,
especially for a patch marked for stable. Did a kernel or LLVM change
cause this (i.e., has this always been an issue or is it a recent
regression)? What is the transformation that LLVM does to break the test
and why is using READ_ONCE() or WRITE_ONCE() sufficient to resolve it?

> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Qiang Zhang <qiang4.zhang@intel.com>
> ---
>  mm/memtest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memtest.c b/mm/memtest.c
> index 32f3e9dda837..c2c609c39119 100644
> --- a/mm/memtest.c
> +++ b/mm/memtest.c
> @@ -51,10 +51,10 @@ static void __init memtest(u64 pattern, phys_addr_t start_phys, phys_addr_t size
>  	last_bad = 0;
>  
>  	for (p = start; p < end; p++)
> -		*p = pattern;
> +		WRITE_ONCE(*p, pattern);
>  
>  	for (p = start; p < end; p++, start_phys_aligned += incr) {
> -		if (*p == pattern)
> +		if (READ_ONCE(*p) == pattern)
>  			continue;
>  		if (start_phys_aligned == last_bad + incr) {
>  			last_bad += incr;
> -- 
> 2.39.2
> 

