Return-Path: <linux-kernel+bounces-151826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5096F8AB475
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3B4CB22848
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4510113C3DE;
	Fri, 19 Apr 2024 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baibHG+R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB4D130E20;
	Fri, 19 Apr 2024 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713548072; cv=none; b=V+QZnKSbI37jhTISW6rTngDXMKXh7d7TZmGz6r6pyIZ3WUVUhrP5qTVfHOFr8MFYeOY6fj2dgg1I4eMcnA+O9A+l2Clf0ykXcj1fpB3CdsXxduhRSZQBnT4us4uLwQ0CvZiOa9Dw5DKuLiZmWglNBT2F4/m/YaKXYqSc9NYpXEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713548072; c=relaxed/simple;
	bh=T5zVCIITP/wX9S8rlRsdZ/1DLYcJwklmwpbYROHRq4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCDmPy7G1ymaRkGxYwAMyZL8tyqCRGaAb0IN6ljadk9RJ3aE506nEmBu5ZxZDhuL0UkXlKdQcOkfOS4jx1TbgsGjHF7xsg42EmwUWXflj6wKI7st0i29/yul7Y8zEShnqbOvQ2Yl6o7uGNHtdIurAxikHEKxImmhwEkfm1E6now=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baibHG+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CA1C2BD11;
	Fri, 19 Apr 2024 17:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713548072;
	bh=T5zVCIITP/wX9S8rlRsdZ/1DLYcJwklmwpbYROHRq4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=baibHG+RzI0GfDlkaJMVUfv2BZtCAK63VLlj1hmQt8DV48IlzX9GerHApxrtwg+at
	 swp7cwWJU1CXeklWh3K96nry4/R0KNRn64ePRjmca4qLyRvBWpyX1t74pCdmOp3V7V
	 lGnNwQbZ05qUhP9gUUX1DHof19/Y95HEwOYAOyaF8dZ3Fai3zaBUmGEwANHvEQrtTg
	 vzf8cQ3eqJlNgMxStBC4kGSns1KfkfCZvcGqfEKd/2mmtRecxoU3qjQk6/T0ZeHM+j
	 bVZfymhGnzIxRkuK2DuoYkKe0cNSdBQjYD8rUB3GIpLpkV3Ee+dD07Rf9Wp7ga9qj3
	 DPD0H9T7tML9A==
Date: Fri, 19 Apr 2024 10:34:29 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] cpu: Re-enable CPU mitigations by default for !X86
 architectures
Message-ID: <20240419173429.dj6nzgg3t23f52ol@treble>
References: <20240417001507.2264512-1-seanjc@google.com>
 <20240417001507.2264512-2-seanjc@google.com>
 <20240419160537.namt5yaxhhvwwa3r@treble>
 <ZiKgAh1aNBGHpOof@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZiKgAh1aNBGHpOof@google.com>

On Fri, Apr 19, 2024 at 09:46:58AM -0700, Sean Christopherson wrote:
> > It seems confusing to have two config options which have very similar
> > names and similar purposes (with subtle differences depending on the
> > arch).
> > 
> > How about we instead just get rid of the x86-specific
> > SPECULATION_MITIGATIONS and replace it with a menu which depends on
> > CPU_MITIGATIONS:
> 
> Huh, didn't realize that was possible.
> 
> I agree that having two things for the same thing is confusing, though Boris'
> idea to do s/SPECULATION_MITIGATIONS/X86_CPU_MITIGATIONS would help a fair bit
> on that front.
> 
> My only hesitation is that x86's menu and the common config knob end up in
> completely different locations.

I'm thinking this is a minor issue because CPU_MITIGATIONS is enabled by
default, so it should almost always be enabled unless the user disables
it, in which case they wouldn't be looking for the x86-specific
mitigations anyway.

Regardless it seems very common for a menu "depends on" to be in a
different file.  We could put CPU_MITIGATIONS in arch/Kconfig which is a
fairly logical place for the dependency.

-- 
Josh

