Return-Path: <linux-kernel+bounces-159984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9C88B3728
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9911C21E70
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D440145B24;
	Fri, 26 Apr 2024 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kstsaHIR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355641C6D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714134245; cv=none; b=kICsy7qwuva7mRv+XpY3RdGtL7+O2wSKL1tFWINDlqwH3Iov/aKeyVE6f6uwn0jZAr53DQt5YdkXjK/TSZ9TPOiiDSudz7so4gyfhmlrruKKq10V70/c3fqbF2vMWSRQacj9myvi9Y8/V4SK9fMgFi7SQps3mX00D62uAQanvDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714134245; c=relaxed/simple;
	bh=9cvGgf6hipxxJapz58GN2PB+3Lbpwbf+b3JzQ0ChyHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHtt+t851zsm7brnQshCDEYMQYLFtiY1Y0AM6AOW+SsEu5DNE+Wn77aej+QNaYcN0gpw+S8o4M0htQb7adsaAIehTaJCg5gtNT/lCUZgXIaSNmlWVU0RbnxWWR1KkVF+Yx7J5Cv6h3UMH7FbaT70evEowoAaQQ3GabuBQwsM1Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kstsaHIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F4BC113CD;
	Fri, 26 Apr 2024 12:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714134245;
	bh=9cvGgf6hipxxJapz58GN2PB+3Lbpwbf+b3JzQ0ChyHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kstsaHIRcEF4YJnrfxedsHtMzeMNuTN3bhr0m0pj7Z/E1KFyoYUX/qVGWXq5LfvsK
	 JGQsrbM6mwGbcBLGU6njOv64v61xwvHtGplegXyoTIw48Ym64U3sqKjqA8O/00ApCA
	 8zcFOA/+XP+l1IvkoWQo3kjWvXiyXahr3sePob1N9GFVUCW2TQUHkEjzf3aySo30gS
	 k+wSdzIovXmFjJoE+aruvTftxso74Kxv2CV7bhl7Sn+YWGJDqa5dUrwwI8OB9c/YSc
	 82zSp1oFy27n+PpMQDwMCp/EusDVTPCiGN+43Y3Vi60rbwqPRjdcJTterTGknr+X+t
	 EDMj9aEq/Avnw==
Date: Fri, 26 Apr 2024 08:24:02 -0400
From: Paul Gortmaker <paulg@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: Intermittent Qemu boot hang/regression traced back to INT 0x80
 changes
Message-ID: <20240426122402.GA36092@kernel.org>
References: <20240424185806.GB101235@kernel.org>
 <20240424195157.GGZili3b-AxmUDlipA@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424195157.GGZili3b-AxmUDlipA@fat_crate.local>

[Apologies for repeated info; last mail didn't make it to the list]

[Re: Intermittent Qemu boot hang/regression traced back to INT 0x80 changes] On 24/04/2024 (Wed 21:51) Borislav Petkov wrote:

> On Wed, Apr 24, 2024 at 02:58:06PM -0400, Paul Gortmaker wrote:
> ...
> > pci 0000:00:1d.0: [8086:2934] type 00 class 0x0c0300 conventional PCI endpoint
> > pci 0000:00:1d.0: BAR 4 [io  0xc080-0xc09f]
> > pci 0000:00:1d.1: [8086:2935] type 00 class 0x0c0300 conventional PCI endpoint
> > pci 0000:00:1d.1: BAR 4 [io  0xc0a0-0xc0bf]
> > pci 0000:00:1d.2: [8086:2936] type 00 class 0x0c0300 conventional PCI endpoint
> > <hang - not always exactly here, but always in this block of PCI printk>
> 
> How would those commits have anything to do with such an early hang?!
> 
> Nothing that early is issuing INT80 32-bit syscalls, is it?
> 
> Btw, can you checkout the Linus tree at...
> 
> f35e46631b28 Merge tag 'x86-int80-20231207' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> f4116bfc4462 x86/tdx: Allow 32-bit emulation by default
> 
> 
> <-- here and test that commit as the top one?
> 
> 55617fb991df x86/entry: Do not allow external 0x80 interrupts 

They both show the issue, but that really doesn't matter now.  When you
guys pointed out it really didn't make sense, I did what I should have
done before - tested the crap out of ^1, the trunk just before the
INT80 merge:

commit f35e46631b28a63ca3887d7afef1a65a5544da52
Merge: 55b224d90d44 f4116bfc4462
       ^^^^^^^^^^^^
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Dec 7 11:56:34 2023 -0800

    Merge tag 'x86-int80-20231207' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

..which would be 55b224d90d44 (parisc merge).  So I left that run
for near 24h (almost 2000 runs), and got 8 PCI-hang instances.  :(
Which means INT80 isn't even there yet.

So I owe you guys an apology for pointing the finger at INT80.  I still
don't understand how the pseudo bisect on v6.6-stable seems so
"concrete".  The v6.6.6 worked "fine" (it seemed) and v6.6.7 died fairly
quickly.  The revert of INT80 on v6.6.7 seemed to "fix" it - but if so,
it was only because it perturbed something else.

I already knew my "good" bisect points were not "proven" good, but only
statistically "good".  Seems I need to revisit some of those "good" data
points (both on v6.6-stable) and on mainline and test longer.

> 
> which reminds me - that hang could be actually that guest kernel
> panicking but the panic not coming out to the console.
> 
> When it hangs, can you connect with gdb to qemu and dump stack and
> registers?
> 
> Make sure you have DEBUG_INFO enabled in the guest kernel.

I want to try some of these things, but I also don't want to
accidentally lose the reproducer I have.  Maybe I'll see if I can
reproduce it at home, since I'll lose use of the current box in a week
anyway...

Again, sorry for the false positive.  I let the v6.6-stable testing bias
my mainline conclusions to where I didn't test underneath INT80.  I'll
follow up with more details once (if?) I manage to properly sort this.

Paul.
--

> 
> Is this even a guest?
> 
> I know you had guests last time you reported the alternatives issue.
> 
> Right, and then test the tree checked out at this commit:
> 
> be5341eb0d43 x86/entry: Convert INT 0x80 emulation to IDTENTRY
> 
> The others should be unrelated...
> 
> b82a8dbd3d2f x86/coco: Disable 32-bit emulation by default on TDX and SEV
> 
> Hmm.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

