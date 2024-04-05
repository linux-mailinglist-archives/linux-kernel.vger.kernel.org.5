Return-Path: <linux-kernel+bounces-133517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C142C89A4C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A807285F13
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EAA172BC2;
	Fri,  5 Apr 2024 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nglUFMIc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0427B171E5C;
	Fri,  5 Apr 2024 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712344747; cv=none; b=SoDVSD/Eu+9pLooMUeMziWWxHiwvbcgHrkzJU5bI4GQQ7XK74xmqDaw3VBX9JObEgJinzDLZStjL6YavjexhqYgtFBhof12CDmO5xOQ1qpg9yHIYVcEVazaIP6v05vksk1gy7Dg8f3BPgYry8ZCOSacqk1+T5VPyh+KY4/9rQC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712344747; c=relaxed/simple;
	bh=L6vX7CjDCEkXaoyr0KauLMbKwx1/o9eMOU1Qr4aqHT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+1rr037p9/flInducb/0AF0PCzbdxZM5nEJ0FuaF1EmnE+Gr8GHYkzTqMKtWXywJtL+z2LqLSUbqZsL1MMgIgG9YITr2LifPE0WPeR+xH3B4TaTZX5BUorA1eJSMHa8pVYbJMoCNIz3ZIwXISqoMuitRKugqvYuHrBA1sVQkYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nglUFMIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1BDC433F1;
	Fri,  5 Apr 2024 19:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712344746;
	bh=L6vX7CjDCEkXaoyr0KauLMbKwx1/o9eMOU1Qr4aqHT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nglUFMIcwBXUHbWv00JUtYltYmtLBKyc9V1PPH4fkJp8K8OtAf2qo2d8IX0veYAMv
	 zXfkn8p5QmSZMVbnHSAeUQ8M6dztnVKDh7B8WghBsg8yuStPkFteW25jFdkEjm3ZHU
	 a52RLTb1parYC4icBfxD3rlaMQtzUugGH8oWbdtFP0TLMleNeSvVxtWX2MgWVN8yhg
	 TU2+DzboewbSKsQfGYLZ1dATtZZVFQp6hFtJmfEL3ZNCAlGQzsrx4na5EQRKM3hI/a
	 gyEJiGyZq2Q1n3XkaWcJ90jxSK7MSJnSmcjQiLJ/lLELFrJbF/YD6CfQeQhfmgwyPy
	 HbNyNbDweEDfA==
Date: Fri, 5 Apr 2024 15:19:04 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH 0/6] Faster AES-XTS on modern x86_64 CPUs
Message-ID: <20240405191904.GA1205@quark.localdomain>
References: <20240326080305.402382-1-ebiggers@kernel.org>
 <CAMj1kXH4fNevFzrbazJptadxh_spEY3W91FZni5eMqD+UKrSUQ@mail.gmail.com>
 <20240326164755.GB1524@sol.localdomain>
 <6629b8120807458ab76e1968056f5e10@AcuMS.aculab.com>
 <20240404013529.GB24248@quark.localdomain>
 <142077804bee45daac3b0fad8bc4c2fe@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <142077804bee45daac3b0fad8bc4c2fe@AcuMS.aculab.com>

On Thu, Apr 04, 2024 at 07:53:48AM +0000, David Laight wrote:
> > >
> > > How much does the kernel_fpu_begin() cost on real workloads?
> > > (ie when the registers are live and it forces an extra save/restore)
> > 
> > x86 Linux does lazy restore of the FPU state.  The first kernel_fpu_begin() can
> > have a significant cost, as it issues an XSAVE (or equivalent) instruction and
> > causes an XRSTOR (or equivalent) instruction to be issued when returning to
> > userspace when it otherwise might not be needed.  Additional kernel_fpu_begin()
> > / kernel_fpu_end() pairs without returning to userspace have only a small cost,
> > as they don't cause any more saves or restores of the FPU state to be done.
> > 
> > My new xts(aes) implementations have one kernel_fpu_begin() / kernel_fpu_end()
> > pair per message (if the message doesn't span any page boundaries, which is
> > almost always the case).  That's exactly the same as the current xts-aes-aesni.
> 
> I realised after sending it that the code almost certainly already did
> kernel_fpu_begin() - so there probably isn't a difference because all the
> fpu state is always saved.
> (I'm sure there should be a way of getting access to (say) 2 ymm registers
> by providing an on-stack save area to allow wide data copies or special
> instructions - but that is a different issue.)
> 
> > I think what you may really be asking is how much the overhead of the XSAVE /
> > XRSTOR pair associated with kernel-mode use of the FPU *increases* if the kernel
> > clobbers AVX or AVX512 state, instead of just SSE state as xts-aes-aesni does.
> > That's much more relevant to this patchset.
> 
> It depends on what has to be saved, not on what is used.
> Although, since all the x/y/zmm registers are caller-saved I think they could
> be 'zapped' on syscall entry (and restored as zero later).
> Trouble is I suspect there is a single piece of code somewhere that relies
> on them being preserved across an inlined system call.
> 
> > I think the answer is that there is no additional overhead.  This is because the
> > XSAVE / XRSTOR pair happens regardless of the type of state the kernel clobbers,
> > and it operates on the userspace state, not the kernel's.  Some of the newer
> > variants of XSAVE (XSAVEOPT and XSAVES) do have a "modified" optimization where
> > they don't save parts of the state that are unmodified since the last XRSTOR;
> > however, that is unimportant here because the kernel's FPU state is never saved.
> > 
> > (This would change if x86 Linux were to support preemption of kernel-mode FPU
> > code.  In that case, we may need to take more care to minimize use of AVX and
> > AVX512 state.  That being said, AES-XTS tends to be used for bulk data anyway.)
> > 
> > This is based on theory, though.  I'll do a test to confirm that there's indeed
> > no additional overhead.  And also, even if there's no additional overhead, what
> > the existing overhead actually is.
> 
> Yes, I was wondering how it is used for 'real applications'.
> If a system call that would normally return immediately (or at least without
> a full process switch) hits the aes code it gets the cost of the XSAVE added.
> Whereas the benchmark probably doesn't do anywhere near as many.
> 
> OTOH this is probably no different.

I did some tests on Sapphire Rapids using a system call that I customized to do
nothing except possibly a kernel_fpu_begin / kernel_fpu_end pair.

On average the bare syscall took 70 ns.  The syscall with the kernel_fpu_begin /
kernel_fpu_end pair took 160 ns if the userspace program used xmm only, 340 ns
if it used ymm, or 360 ns if it used zmm.  I also tried making the kernel
clobber different registers in the kernel_fpu_begin / kernel_fpu_end section,
and as I expected this did not make any difference.

Note that without the kernel_fpu_begin / kernel_fpu_end pair, AES-NI
instructions cannot be used and the alternative would be xts(ecb(aes-generic)).
On the same CPU, encrypting a single 512-byte sector with xts(ecb(aes-generic))
takes about 2235ns.  With xts-aes-vaes-avx10_512 it takes 75 ns.  (Not a typo --
it really is almost 30 times faster!)  So it seems clear the FPU state save and
restore is worth it even just for a single sector using the traditional 512-byte
sector size, let alone a 4096-byte sector size which is recommended these days.

- Eric

