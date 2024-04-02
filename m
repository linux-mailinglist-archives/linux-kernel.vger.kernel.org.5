Return-Path: <linux-kernel+bounces-128489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9745D895B7F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372C51F22C49
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF5315AADC;
	Tue,  2 Apr 2024 18:11:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3021015AAD7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081511; cv=none; b=UTtxr5iK+/akvjZjqkF8lXUd2IV4K8+brgLxqHqZQaM8OT321h3/Y9LW470q/QyAB+v4X057P8BEywnEbQRDAZVwqxF/iMOgkz4jV4FnOIR2JZGH1XAqVmL7gZFO8ph3GioJN39r+4k6jWB8JJ9RVgwJIK2k0BD2PVMwy7AEq5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081511; c=relaxed/simple;
	bh=4JmSWPxQ7WjqtjBMCMN4q6rtpi1w4hviH2iHcZhRAYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpJkcD6tDUIqOmsVGBlZv+rzdOiBusqlewH9IGbTq16MyOM4aQBLvkgT8mplYhZYfNl0OZc2sE1ou/WXIyl2DqVwttXh4O0gzfyQFTxd1FnOORTQQG2miJONTaxtVGN2jW+zENSUq1eNPUzVpSgwEzWz3JLOLWkVV1n6uhAp5go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E5FD1007;
	Tue,  2 Apr 2024 11:12:19 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.234])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D30633F766;
	Tue,  2 Apr 2024 11:11:46 -0700 (PDT)
Date: Tue, 2 Apr 2024 19:11:43 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Vineet Gupta <vineetg@rivosinc.com>
Cc: Will Deacon <will@kernel.org>, Andrew Waterman <andrew@sifive.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>, Dave Martin <Dave.Martin@arm.com>
Subject: Re: ARM SVE ABI: kernel dropping SVE/SME state on syscalls
Message-ID: <ZgxKXy6r0X7Whu5U@FVFF77S0Q05N>
References: <bc21c53f-23b9-4596-b757-fc7707f91f24@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc21c53f-23b9-4596-b757-fc7707f91f24@rivosinc.com>

On Wed, Mar 27, 2024 at 05:30:00PM -0700, Vineet Gupta wrote:
> Hi Will, Marc,
> 
> In the RISC-V land we are hitting an issue and need some help
> understanding the SVE ABI about dropping the state on syscalls (and its
> implications etc - in hindsight)
> 
> If I'm reading the arm64 code correctly, SVE state is unconditionally
> (for any syscall whatsoever) dropped in following code path:
> 
> el0_svc
>     fp_user_discard
> 
> The RISC-V Vector ABI mandates something similar and kernel implements
> something similar.
> 
>     2023-06-29 9657e9b7d253 riscv: Discard vector state on syscalls  
> 
> However in recent testing with RISC-V vector builds we are running into
> an issue when this just doesn't work.
> 
> Just for some background, RISC-V vector instructions relies on
> additional state in a VTYPE register which is setup using an apriori
> VSETVLI insn.
> So consider the following piece of code:
> 
>    3ff80:    cc787057              vsetivli    zero,16,e8,mf2,ta,ma    
> <-- sets up VTYPE
>    3ff84:    44d8                    lw    a4,12(s1)
>    3ff86:    449c                    lw    a5,8(s1)
>    3ff88:    06f75563              bge    a4,a5,3fff2
>    3ff8c:    02010087              vle8.v    v1,(sp)
>    3ff90:    020980a7              vse8.v    v1,(s3)   <-- Vector store
> instruction
> Here's the sequence of events that's causing the issue 
>
> 1. The vector store instruction (in say bash) takes a page fault, enters
> kernel.
> 2. In PF return path, a SIGCHLD signal is pending (a bash sub-shell
> which exited, likely on different cpu).

At this point, surely you need to save the VTYPE into a sigframe before
delivering the signal?

> 3. kernel resumes in userspace signal handler which ends up making an
> rt_sigreturn syscall - and which as specified discards the V state (and
> makes VTYPE reg invalid).

The state is discarded at syscall entry, but rt_sigreturn() runs *after* the
discard. If you saved the original VTYPE prior to delivering the signal, it
should be able to restore it regardless of whether it'd be clobbered at syscall
entry.

Surely you *must* save/restore VTYPE in the signal frame? Otherwise the signal
handler can't make any syscall whatsoever, or it's responsible for saving and
restoring VTYPE in userspace, which doesn't seem right.

> 4. When sigreturn finally returns to original Vector store instruction,
> invalid VTYPE triggers an Illegal instruction which causes a SIGILL (as
> state was discarded above).
> 
> So there is no way dropping syscall state would work here.

As above, I don't think that's quite true. It sounds to me like that the actual
bug is that you don't save+restore VTYPE in the signal frame?

> How do you guys handle this for SVE/SME ? One way would be to not do the
> discard in rt_sigreturn codepath, but I don't see that - granted I'm not
> too familiar with arch/arm64/*/**

IIUC this works on arm64 because we'll save all the original state when we
deliver the signal, then restore that state *after* entry to the rt_sigreturn()
syscall.

I can go dig into that tomorrow, but I don't see how this can work unless we
save *all* state prior to delivering the signal, and restoring *all* that state
from the sigframe.

> Other thing I wanted to ask is, have there been any perf implications of
> this ABI decision: as in if this was other way around, userspace (and/or
> compilers) could potentially leverage the fact that SVE/SME state would
> still be valid past a syscall - and won't have to reload/resetup etc.

I believe Mark Brown has made some changes recently to try to avoid some of
that impact. He might be able to comment on that.

Mark.

