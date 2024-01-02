Return-Path: <linux-kernel+bounces-14448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C84D821D2B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F47FB21E6F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B197D12E59;
	Tue,  2 Jan 2024 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rjz8h67B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3CD12E47
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CD5C433C8;
	Tue,  2 Jan 2024 13:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704203819;
	bh=rQxuLAMr4pQbTcIQCi2LRMYbM09Z6yq1KaBQw0i2III=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rjz8h67BRpHSuLNqUsuBfgJRholz2cNuwKU+lAWcvhvF4VfoXl61Il+8CBQjfh+ic
	 G7x9Pi6w0los4hsNQbgadVCSSB4hWYRk/SW7vjML7E5obPu5H/NoF+1P8n6RfSzX+7
	 YPXmNrZu9hECrGWt3H+yAMT0sf0mRO4f4QR7hAG3ydMd2a8NTxMMoaL3ZUNhspx8Wy
	 SMUZToHCseG4Bv50K15+5tr4i3W5srkBGiX0w3tJttEAtjL+vrPs0KPHSvHJCNXvPN
	 uNyOvYLlaywnYFy5gQPcJHm4nwDTLP1UGdKDFOukx2rA5xgzlkeMu+GUHI6Y9QU1Rq
	 /N48OJannnguQ==
Date: Tue, 2 Jan 2024 15:56:35 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Deepak Gupta <debug@rivosinc.com>, rick.p.edgecombe@intel.com,
	broonie@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: abstract shadow stack vma behind
 arch_is_shadow_stack_vma
Message-ID: <ZZQWE0wFdtHP-3dh@kernel.org>
References: <20231222235248.576482-1-debug@rivosinc.com>
 <20231227134514.13629032c39decdf1dddcc75@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227134514.13629032c39decdf1dddcc75@linux-foundation.org>

On Wed, Dec 27, 2023 at 01:45:14PM -0800, Andrew Morton wrote:
> On Fri, 22 Dec 2023 15:51:04 -0800 Deepak Gupta <debug@rivosinc.com> wrote:
> 
> > x86 has used VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) to encode shadow
> > stack VMA. VM_SHADOW_STACK is thus not possible on 32bit. Some arches may
> > need a way to encode shadow stack on 32bit and 64bit both and they may
> > encode this information differently in VMAs.
> 
> Is such a patch in the pipeline?  Otherwise we're making a change that
> serves no purpose.
> 
> > This patch changes checks of VM_SHADOW_STACK flag in generic code to call
> > to a function `arch_is_shadow_stack_vma` which will return true if arch
> > supports shadow stack and vma is shadow stack else stub returns false.
> > 
> > ...
> >
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -352,8 +352,21 @@ extern unsigned int kobjsize(const void *objp);
> >   * for more details on the guard size.
> >   */
> >  # define VM_SHADOW_STACK	VM_HIGH_ARCH_5
> > +
> > +static inline bool arch_is_shadow_stack_vma(vm_flags_t vm_flags)
> > +{
> > +	return (vm_flags & VM_SHADOW_STACK) ? true : false;
> > +}
> 
> The naming seems a little wrong.  I'd expect it to take a vma* arg. 
> Maybe just drop the "_vma"?

I'd suggest to use vma_is_shadow_stack() to make it inline with other
vma_is_*() tests.

-- 
Sincerely yours,
Mike.

