Return-Path: <linux-kernel+bounces-130393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F10D89782D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AFD9B3CFE5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB378152E19;
	Wed,  3 Apr 2024 17:52:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652E5433CB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712166755; cv=none; b=jQkg9xpA+hT5DwvqxA8D/RHPsTQ1WOPtk4aHaIM5xuwmPWPzX8k9MQpyBtVfh168xykf5LnLCcS2XDv5X2uQYFsXx1zsY8hLGLf7/YUgwUbnXegu91ZkXEvIhIIduAtG+YhhM18OSiXDk4WFWLASvmeYkYscZYozCgfQ8X7xO0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712166755; c=relaxed/simple;
	bh=JUy0awJ1oS9mjfmuuGKejJwXrwXoXCh/aOb7jFwo4AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P407LiZbH3I9GJ0vkyArYOXjIp8g+6pzHk3R9H25d6AJP0ZPiH5qh5p0ZlAiirjVOgDc3bxWZlLgWaDStW0vpMJEsHBJGo5uVw7t3Mg17mAVjHOp/inbNXAZXQQoqEUH/5531SVoag0HLnCL3Z+W0JkNv+h5mj18qFLA6fG8rcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32A9C433C7;
	Wed,  3 Apr 2024 17:52:32 +0000 (UTC)
Date: Wed, 3 Apr 2024 18:52:30 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	anil.s.keshavamurthy@intel.com, aou@eecs.berkeley.edu,
	davem@davemloft.net, jarkko@kernel.org,
	linux-arm-kernel@lists.infradead.org, mhiramat@kernel.org,
	naveen.n.rao@linux.ibm.com, palmer@dabbelt.com,
	paul.walmsley@sifive.com
Subject: Re: [PATCH v2 1/4] arm64: patching: always use fixmap
Message-ID: <Zg2XXmMb_wWS4fJH@arm.com>
References: <20240403150154.667649-1-mark.rutland@arm.com>
 <20240403150154.667649-2-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403150154.667649-2-mark.rutland@arm.com>

On Wed, Apr 03, 2024 at 04:01:51PM +0100, Mark Rutland wrote:
> For historical reasons, patch_map() won't bother to fixmap non-image
> addresses when CONFIG_STRICT_MODULE_RWX=n, matching the behaviour prior
> to the introduction of CONFIG_STRICT_MODULE_RWX. However, as arm64
> doesn't select CONFIG_ARCH_OPTIONAL_KERNEL_RWX, CONFIG_MODULES implies
> CONFIG_STRICT_MODULE_RWX, so any kernel built with module support will
> use the fixmap for any non-image address.
> 
> Historically we only used patch_map() for the kernel image and modules,
> but these days its also used by BPF and KPROBES to write to read-only
> pages of executable text. Currently these both depend on CONFIG_MODULES,
> but we'd like to change that in subsequent patches, which will require
> using the fixmap regardless of CONFIG_STRICT_MODULE_RWX.
> 
> This patch changes patch_map() to always use the fixmap, and simplifies
> the logic:
> 
> * Use is_image_text() directly in the if-else, rather than using a
>   temporary boolean variable.
> 
> * Use offset_in_page() to get the offset within the mapping.
> 
> * Remove uintaddr and cast the address directly when using
>   is_image_text().
> 
> For kernels built with CONFIG_MODULES=y, there should be no functional
> change as a result of this patch.
> 
> For kernels built with CONFIG_MODULES=n, patch_map() will use the fixmap
> for non-image addresses, but there are no extant users with non-image
> addresses when CONFIG_MODULES=n, and hence there should be no functional
> change as a result of this patch alone.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kernel/patching.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> Catalin, Will, this is a prerequisite for the final two patches in the
> series. Are you happy for this go via the tracing tree?

Fine by me.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

