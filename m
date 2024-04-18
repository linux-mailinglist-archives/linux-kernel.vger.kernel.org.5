Return-Path: <linux-kernel+bounces-150373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 383B98A9E18
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6972D1C21B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4900316C457;
	Thu, 18 Apr 2024 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZrIHbHK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890E36FC3;
	Thu, 18 Apr 2024 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453339; cv=none; b=tk34OL1S9sUjRy7vj++BM4QSjr43R4iEVzescWwyPWvuM8nbd3TAW8ErN8qhbp7iDAxOy/Qm/qdvd1Cq4AoUqF37o78pSw/wCgV+Mk/xcFqljnfUTyhWLSzZCeJhVXIwLgTXCFBRC52Yy24TSdoChDXh2ZPb4f/FQyt0it4/HWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453339; c=relaxed/simple;
	bh=JpiF5ElI4lcmX/EUD9g24qsqs5xg246A2G5pUX74rxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joLXA5tLEJgQTyxH1pp3buvA9td0Hrj76xyvxyf2XUII9iSijSH7JVpy+I50YZ1sj3olRxpfH8iyTFgoG6F2SBEJaoJrhHNysb74Hjoev1StUIY5qHkiHY5t0iw90a6DNJa/ekdoVdrkuDwVFY6Sd7oyvOvNDuupuanwa/j3I1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZrIHbHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CFAC113CE;
	Thu, 18 Apr 2024 15:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713453339;
	bh=JpiF5ElI4lcmX/EUD9g24qsqs5xg246A2G5pUX74rxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZrIHbHKSsjRh1IGRI2A14msmxTRR68bQNXQOwZTqQMN1LshiHDJ/CV0TLo8JzfG/
	 Dgp9LUUP9pwUHFqmROKyQiID2rAUG8XpPYS4jDcxEpYdeWMYuNlFhaSgm1HkaqAYqj
	 wFpWgoXkKhADvujy6wEBAiyGTaoLIwyETwXtCK9SjFUrVuePYDQ4Cu/bZeWkw1Tuor
	 L+c5IvpkoMSSL4AV6DFycLb+jLIZU3mJF1WxXLgcAKwRDmHzfM/3NMz7FLbBQdMKiB
	 U/YefxlZ1yqoSgwtwKcYte/hi5TFw68Wjog0mNqUS7fpaz7OQ9Mad1uWzAeCsCJ5zQ
	 X9TPthpkgOhAg==
Date: Thu, 18 Apr 2024 08:15:36 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com, song@kernel.org,
	ribalda@chromium.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev,
	ns <0n-s@users.noreply.github.com>
Subject: Re: [PATCH 0/2] x86/purgatory: Avoid kexec runtime warning with LLVM
 18
Message-ID: <20240418151536.GB1435416@dev-arch.thelio-3990X>
References: <20240417-x86-fix-kexec-with-llvm-18-v1-0-5383121e8fb7@kernel.org>
 <46343CD5-24D6-46BF-92A7-0B0FA0E6937D@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46343CD5-24D6-46BF-92A7-0B0FA0E6937D@alien8.de>

On Thu, Apr 18, 2024 at 01:14:35PM +0200, Borislav Petkov wrote:
> On April 17, 2024 11:53:44 PM GMT+02:00, Nathan Chancellor <nathan@kernel.org> wrote:
> >Hi all,
> >
> >After LLVM commit d8a04398f949 ("Reland [X86] With large code model, put
> >functions into .ltext with large section flag (#73037)") [1], which
> >landed in the 18.x cycle, there is a runtime warning when loading a
> >kernel via kexec due to the presence of two text sections (.text and
> >.ltext).
> 
> How much of this silliness should we expect now for other parts of the kernel?

Not sure. If I could predict the future, I wouldn't be doing kernel
development :) The only reason the purgatory got bit by that LLVM change
is because it uses '-mcmodel=large', which is not very common within the
kernel (I only see it in arch/um and arch/powerpc other than here).

> Can we turn this off?

No, not as far as I am aware. I suspect it is because for the majority
of programs, this is not an issue so it does not justify having a reason
to make it toggleable but I am not the author of the LLVM change so I
cannot say. However, if this has been the solution when the issue of
multiple text sections was first brought up in 97b6b9cbba40, I would
just be adding '.ltext' and '.lrodata' to the '.text' and '.rodata'
sections to this linker script, so it would be nice to do this so that
any future changes are either taken care of by the '.text.*'
automatically like '.text.hot' or '.text.<func>' would have been or they
are caught by the orphan warnings and addressed in a separate change.

> Why does llvm enforce .ltext for large code models and why gcc doesn't do that? Why does llvm need to do that, what requirement dictates that?

Not sure, I can only go off of what is in the commit message of the LLVM
change that introduced this optimization and the surrounding PR
discussion, which just seems to indicate a desire to keep small/medium
and large text separate *shrug*

https://github.com/llvm/llvm-project/commit/d8a04398f9492f043ffd8fbaf2458778f7d0fcd5

https://github.com/llvm/llvm-project/pull/73037

Cheers,
Nathan

