Return-Path: <linux-kernel+bounces-130749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8381897CB3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAC11F22AA0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873B4156C54;
	Wed,  3 Apr 2024 23:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RV7GYcjm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F6156C4B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 23:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187896; cv=none; b=R7EGpEd+ZSGT568UVIeZHx61BSF3NAmYSo/XlJ5dGGIPLXUpc5A5h5PEk0j1CHzhXhgG/57j+AmXCUZXxoogy9rLf8DBIAXejFKNoQGKid/lwJ053h384VJHllFO7dlQbdIOZDaNBwqh6grzW4eq+kK7tSyJBD36B2SPaSpEzHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187896; c=relaxed/simple;
	bh=km9WrjrljLnrGGBMhJMqtSVQkEOEoORatY4UgWPCrhI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pvaYXdtTRhggA4dBSLBEUt9khCL0Yu3BZebIc7VNiRCEd+uSRDGduB6USQ9ksEHR5/TGtQV9Az9dtQqkLi3qEWlCdes3AOM1myb3RJpQA5tbPCi9GqeF22zm3rUFZiJukTqcXJ6+nvAiI0U9eyqB6Uk/KcZ8W33eXVKeQjl0jIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RV7GYcjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27297C43390;
	Wed,  3 Apr 2024 23:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712187896;
	bh=km9WrjrljLnrGGBMhJMqtSVQkEOEoORatY4UgWPCrhI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RV7GYcjmC1peJ0K+6FY0qq/5hSfZCqUJ2QNUdpb36t3OAFaxi4FIhiRPOlfjWOmB+
	 /ud3+bqKCOc8B7qynP/pFR9M6i2xUeFZC2o5G/FIWr86jnalK6ebcSYxmezEfEAAwY
	 qEzEr4Q/6wcwSKE6hfjU4gyCyoZQsyrTUL37YxInBx03Rvu/aGC3Dg7ddui9zju7zT
	 u5HYDBHA4woR7MjA0UIH5lJ5bros70GI7v/Mv0q9sIrhKtnwgdp13v6VgBCR22I3rW
	 SSV9EGak+zZhFFO3HON2I/X992RARtXhQdSsERIO7HiMey7dt6+AEbK8dqX8KTWxCm
	 RitZLYXh9l5lQ==
Date: Thu, 4 Apr 2024 08:44:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, Will
 Deacon <will@kernel.org>, anil.s.keshavamurthy@intel.com,
 aou@eecs.berkeley.edu, davem@davemloft.net, jarkko@kernel.org,
 linux-arm-kernel@lists.infradead.org, mhiramat@kernel.org,
 naveen.n.rao@linux.ibm.com, palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH v2 1/4] arm64: patching: always use fixmap
Message-Id: <20240404084450.802bae64e3ed08197fd0dad1@kernel.org>
In-Reply-To: <Zg2XXmMb_wWS4fJH@arm.com>
References: <20240403150154.667649-1-mark.rutland@arm.com>
	<20240403150154.667649-2-mark.rutland@arm.com>
	<Zg2XXmMb_wWS4fJH@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2024 18:52:30 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Wed, Apr 03, 2024 at 04:01:51PM +0100, Mark Rutland wrote:
> > For historical reasons, patch_map() won't bother to fixmap non-image
> > addresses when CONFIG_STRICT_MODULE_RWX=n, matching the behaviour prior
> > to the introduction of CONFIG_STRICT_MODULE_RWX. However, as arm64
> > doesn't select CONFIG_ARCH_OPTIONAL_KERNEL_RWX, CONFIG_MODULES implies
> > CONFIG_STRICT_MODULE_RWX, so any kernel built with module support will
> > use the fixmap for any non-image address.
> > 
> > Historically we only used patch_map() for the kernel image and modules,
> > but these days its also used by BPF and KPROBES to write to read-only
> > pages of executable text. Currently these both depend on CONFIG_MODULES,
> > but we'd like to change that in subsequent patches, which will require
> > using the fixmap regardless of CONFIG_STRICT_MODULE_RWX.
> > 
> > This patch changes patch_map() to always use the fixmap, and simplifies
> > the logic:
> > 
> > * Use is_image_text() directly in the if-else, rather than using a
> >   temporary boolean variable.
> > 
> > * Use offset_in_page() to get the offset within the mapping.
> > 
> > * Remove uintaddr and cast the address directly when using
> >   is_image_text().
> > 
> > For kernels built with CONFIG_MODULES=y, there should be no functional
> > change as a result of this patch.
> > 
> > For kernels built with CONFIG_MODULES=n, patch_map() will use the fixmap
> > for non-image addresses, but there are no extant users with non-image
> > addresses when CONFIG_MODULES=n, and hence there should be no functional
> > change as a result of this patch alone.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/kernel/patching.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> > 
> > Catalin, Will, this is a prerequisite for the final two patches in the
> > series. Are you happy for this go via the tracing tree?
> 
> Fine by me.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks Catalin. I'll pick this series to linux-trace tree.

Thank you!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

