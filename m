Return-Path: <linux-kernel+bounces-12279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F145481F242
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A7B3B21803
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C107847F6A;
	Wed, 27 Dec 2023 21:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="00mkvWBW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176AB22089
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 21:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64181C433C7;
	Wed, 27 Dec 2023 21:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703713515;
	bh=EI47mPqwG9pb/xWc0waHIziKYxkBwVMBRxN+4PJlnow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=00mkvWBWZXYPjc3yn3MWBUVxJ+Zd2aFDKLGvt48GvXfi2sCguaNXXi5czmjPDRIlA
	 cW8rybJshDUYKhSlAQ3ObSbEmEz+LIJ9aEWBXnQqTl7DWD+yLHlI2nF/Gq3CZQWiYV
	 bVOvllVHWKs8TRi1gvzqjyaUJbeSmKdijAfmsjjM=
Date: Wed, 27 Dec 2023 13:45:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: rick.p.edgecombe@intel.com, broonie@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: abstract shadow stack vma behind
 arch_is_shadow_stack_vma
Message-Id: <20231227134514.13629032c39decdf1dddcc75@linux-foundation.org>
In-Reply-To: <20231222235248.576482-1-debug@rivosinc.com>
References: <20231222235248.576482-1-debug@rivosinc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Dec 2023 15:51:04 -0800 Deepak Gupta <debug@rivosinc.com> wrote:

> x86 has used VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) to encode shadow
> stack VMA. VM_SHADOW_STACK is thus not possible on 32bit. Some arches may
> need a way to encode shadow stack on 32bit and 64bit both and they may
> encode this information differently in VMAs.

Is such a patch in the pipeline?  Otherwise we're making a change that
serves no purpose.

> This patch changes checks of VM_SHADOW_STACK flag in generic code to call
> to a function `arch_is_shadow_stack_vma` which will return true if arch
> supports shadow stack and vma is shadow stack else stub returns false.
> 
> ...
>
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -352,8 +352,21 @@ extern unsigned int kobjsize(const void *objp);
>   * for more details on the guard size.
>   */
>  # define VM_SHADOW_STACK	VM_HIGH_ARCH_5
> +
> +static inline bool arch_is_shadow_stack_vma(vm_flags_t vm_flags)
> +{
> +	return (vm_flags & VM_SHADOW_STACK) ? true : false;
> +}

The naming seems a little wrong.  I'd expect it to take a vma* arg. 
Maybe just drop the "_vma"?


