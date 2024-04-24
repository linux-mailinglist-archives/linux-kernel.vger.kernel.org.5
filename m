Return-Path: <linux-kernel+bounces-156323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D6B8B0126
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901591F237B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBC9156675;
	Wed, 24 Apr 2024 05:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc4cK+IU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A6813CFAD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713937183; cv=none; b=nJxSwDSwll1k5lGrkVOVWetC6oBOt0BdSSSN84gQFdNO5ZkGhGIFtF9/A7LTMLgyVscvOhkyhl8Lc2H6muVTd3zOOBKH8q/t3lf3dC8rMIQyElksp+b6q6h7Pp8yA6klaBTEFCHu2bv5Eikp98BFBmk7XsQRYS5Efu1uJFx0PJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713937183; c=relaxed/simple;
	bh=Yws6ZbleFBhbnE7nhrQmbFagTNx3rTvdGwwajD+oWlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVFsgCREMj2A2NFbhyD25wO8A4BQ3uxkgxbA9wPSACa4vVpv7Jfeugyvi/WufqZfKOLL7Uq5B9jBeEan1otSmLPg+Mn5YCTf34I6Z0vJiATu9AfTV+npmM9SUlNLdWSoG6ZkEszdpNYLqpY/qQBWlVLIQ9bERI23d3wMAkIVqy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tc4cK+IU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF9DC113CE;
	Wed, 24 Apr 2024 05:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713937182;
	bh=Yws6ZbleFBhbnE7nhrQmbFagTNx3rTvdGwwajD+oWlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tc4cK+IUOAvwyFMaaTYmPgvzFu99UYEkr87vBeU8ToxzsurCZGHudx+VM6qODGmOm
	 swaWLjovCNvLIdq+DefQ6d/Dlvm38Z2YR486HCMAFflkhxSP9msnUXHCVfZTTJeGJo
	 0If5aMm6LrtZPae4Jh6EMJKGuhRIvgFblfvkSW9S7YOvfUJwoT5MNcU5y+IG0PA7yc
	 BPJQk2McVF9f3tuq6nSV0OymE/ixcQIjsMfVEfl1GiEFehUajYUm1T1eaiFbqqHm+V
	 7aLURrZ3+FpYz766dAdL9rTQSOFKWEGzqiFfg6j7ulfWwEOpEu7pRL4NPU2E/2EY4v
	 g2vXNtCWUjwsg==
Date: Tue, 23 Apr 2024 22:39:40 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Will Deacon <will@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] cpu: Ignore "mitigations" kernel parameter if
 CPU_MITIGATIONS=n
Message-ID: <20240424053940.3ypivvztvv35dpu7@treble>
References: <20240420000556.2645001-1-seanjc@google.com>
 <20240420000556.2645001-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240420000556.2645001-3-seanjc@google.com>

On Fri, Apr 19, 2024 at 05:05:55PM -0700, Sean Christopherson wrote:
> +#ifdef CONFIG_CPU_MITIGATIONS
>  extern bool cpu_mitigations_off(void);
>  extern bool cpu_mitigations_auto_nosmt(void);
> +#else
> +static inline bool cpu_mitigations_off(void)
> +{
> +	return false;
> +}

This should probably return true?

-- 
Josh

