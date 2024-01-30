Return-Path: <linux-kernel+bounces-44567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7966184244C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABCBD1C239DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAA667E78;
	Tue, 30 Jan 2024 12:01:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5506067E6D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616098; cv=none; b=MsBq951J5L/uCFdhUsin56hfs1PJ+81xSKKX+evhX7dyvJmxQvXGZIGx4MSGYUsGB0OZx0Jfs7MAuoGaRL9iw7gEyQnMobw7oXD6WH2VzJwJOuvN8sKbKX9jKrnOFHWe82adSqRWGScNrTxxeruvW0e/FXFTrNUX2YZGp/HZCgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616098; c=relaxed/simple;
	bh=481BpRBp9cVKd8wrjM/xBAlEXnWqNi2ovI4ZoN7a6cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDjlWev52vsBpym+PPFjBsr3gAIOGHy78FpVFZIeCUeTNb6J/HKy7LmbjARaRuTF0T7ulZ/T4miu5v/BVl5fZeSv7nvy0GLbUOxOXXhMbLSHgFmVt7Gn2Mq+ZqEv/IfGcERPMn43mgvp2X2Q1wFpf/Lk5oudLy/d3HjrICu8jDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DDFDDA7;
	Tue, 30 Jan 2024 04:02:19 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.48.92])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57FCA3F762;
	Tue, 30 Jan 2024 04:01:31 -0800 (PST)
Date: Tue, 30 Jan 2024 12:01:26 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, wangkefeng.wang@huawei.com,
	Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH v10 3/6] arm64: add uaccess to machine check safe
Message-ID: <ZbjlFXVC_ZPYbKhR@FVFF77S0Q05N>
References: <20240129134652.4004931-1-tongtiangen@huawei.com>
 <20240129134652.4004931-4-tongtiangen@huawei.com>
 <ZbfjvD1_yKK6IVVY@FVFF77S0Q05N>
 <23795738-b86e-7709-bc2b-5abba2e77b68@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23795738-b86e-7709-bc2b-5abba2e77b68@huawei.com>

On Tue, Jan 30, 2024 at 07:14:35PM +0800, Tong Tiangen wrote:
> 在 2024/1/30 1:43, Mark Rutland 写道:
> > On Mon, Jan 29, 2024 at 09:46:49PM +0800, Tong Tiangen wrote:
> > Further, this change will also silently fixup unexpected kernel faults if we
> > pass bad kernel pointers to copy_{to,from}_user, which will hide real bugs.
> 
> I think this is better than the panic kernel, because the real bugs
> belongs to the user process. Even if the wrong pointer is
> transferred, the page corresponding to the wrong pointer has a memroy
> error.

I think you have misunderstood my point; I'm talking about the case of a bad
kernel pointer *without* a memory error.

For example, consider some buggy code such as:

	void __user *uptr = some_valid_user_pointer;
	void *kptr = NULL; // or any other bad pointer

	ret = copy_to_user(uptr, kptr, size);
	if (ret)
		return -EFAULT;

Before this patch, when copy_to_user() attempted to load from NULL it would
fault, there would be no fixup handler for the LDR, and the kernel would die(),
reporting the bad kernel access.

After this patch (which adds fixup handlers to all the LDR*s in
copy_to_user()), the fault (which is *not* a memory error) would be handled by
the fixup handler, and copy_to_user() would return an error without *any*
indication of the horrible kernel bug.

This will hide kernel bugs, which will make those harder to identify and fix,
and will also potentially make it easier to exploit the kernel: if the user
somehow gains control of the kernel pointer, they can rely on the fixup handler
returning an error, and can scan through memory rather than dying as soon as
they pas a bad pointer.

> In addition, the panic information contains necessary information
> for users to check.

There is no panic() in the case I am describing.

> > So NAK to this change as-is; likewise for the addition of USER() to other ldr*
> > macros in copy_from_user.S and the addition of USER() str* macros in
> > copy_to_user.S.
> > 
> > If we want to handle memory errors on some kaccesses, we need a new EX_TYPE_*
> > separate from the usual EX_TYPE_KACESS_ERR_ZERO that means "handle memory
> > errors, but treat other faults as fatal". That should come with a rationale and
> > explanation of why it's actually useful.
> 
> This makes sense. Add kaccess types that can be processed properly.
> 
> > 
> > [...]
> > 
> > > diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
> > > index 478e639f8680..28ec35e3d210 100644
> > > --- a/arch/arm64/mm/extable.c
> > > +++ b/arch/arm64/mm/extable.c
> > > @@ -85,10 +85,10 @@ bool fixup_exception_mc(struct pt_regs *regs)
> > >   	if (!ex)
> > >   		return false;
> > > -	/*
> > > -	 * This is not complete, More Machine check safe extable type can
> > > -	 * be processed here.
> > > -	 */
> > > +	switch (ex->type) {
> > > +	case EX_TYPE_UACCESS_ERR_ZERO:
> > > +		return ex_handler_uaccess_err_zero(ex, regs);
> > > +	}
> > 
> > Please fold this part into the prior patch, and start ogf with *only* handling
> > errors on accesses already marked with EX_TYPE_UACCESS_ERR_ZERO. I think that
> > change would be relatively uncontroversial, and it would be much easier to
> > build atop that.
> 
> OK, the two patches will be merged in the next release.

Thanks.

Mark.

