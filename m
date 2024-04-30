Return-Path: <linux-kernel+bounces-164237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962D78B7B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31971C22825
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0436143725;
	Tue, 30 Apr 2024 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alu9ZDqB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191C377114;
	Tue, 30 Apr 2024 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489980; cv=none; b=egWPxDpUSnt2mYVqPzren3R24+plguR41c91FNTzvmHwK7W1leVYxmSQEgqINa1HB6vCWzKI2xLgweveuXR31d/3u6Qud+KtzEMT61AF+5tfj4iWCrs3GPK6rqkseDY8oTAUtAh2ssq/lQngtUcffS4AYR4PLDX44u2xSLHNPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489980; c=relaxed/simple;
	bh=0ylOZDQHC7yOPGXzY28yXwxGB6oYY62WRnpPvHL+x7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sF7vocuZU4wxKMs0Dw5pqgNiF0cgaonUgsg8WqyswUz2dFI358M/aaPebaQaQ61cb/tcipR2xyvjQn1djGkBBwdVY6yBWOGqJlJcMsRqhrIi9usDwX1siZHwEqFaZO4sHsV9sCmYfRgR7lhrzuE8Rvd1c3c6vnL4Tkn6xtL18zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alu9ZDqB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CD1C2BBFC;
	Tue, 30 Apr 2024 15:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714489979;
	bh=0ylOZDQHC7yOPGXzY28yXwxGB6oYY62WRnpPvHL+x7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=alu9ZDqBE6hKNEUy+qO6QNXCO8b73Tddm/aI+siMKv/KVZq/71e2XA9nCj+WCPgg3
	 iTT3M581SC+LxMQyjbw4PN96h3ROb9uktvtw6Ww7BNSX8svJY1flJrf60+ugOu1DhA
	 JdZ86ukLGdPOROgeb31SZ6T7ODYrfloz2113EdsXmYZSib6mAA1dXtmzpAAxUz8fHn
	 HztG8m8zNsXd1hLutfMO5Sssjh7P0vdwaCEsnwDv3bz26eqxOK0e2bJQ5bA/th+D1Q
	 qBZ3JkHvaW86cx3mjFsigjgWY51d3tMT8J3EA/qaW+XJDGH2h6KCeT/3nQfPvHnyMV
	 STc+1q9pfrr1g==
Date: Tue, 30 Apr 2024 08:12:56 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hardening: Refresh KCFI options, add some more
Message-ID: <20240430151256.GA1012249@dev-arch.thelio-3990X>
References: <20240426222940.work.884-kees@kernel.org>
 <20240429221650.GA3666021@dev-arch.thelio-3990X>
 <202404292233.9A98A7C@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404292233.9A98A7C@keescook>

On Mon, Apr 29, 2024 at 10:35:03PM -0700, Kees Cook wrote:
> On Mon, Apr 29, 2024 at 03:16:50PM -0700, Nathan Chancellor wrote:
> > On Fri, Apr 26, 2024 at 03:29:44PM -0700, Kees Cook wrote:
> > [...]
> > > +# Enable Kernel Control Flow Integrity (currently Clang only).
> > > +CONFIG_CFI_CLANG=y
> > > +# CONFIG_CFI_PERMISSIVE is not set
> > 
> > Should this be a part of kernel/configs/hardening.config because RISC-V
> > supports it (and 32-bit ARM will soon too)?
> 
> Probably yes. I was worried it might be "noisy" for archs that don't
> support it, but frankly if someone is using "make hardening.config" they
> probably want to know about unsupported options. :)

It would be potentially noisy as it is currently written since someone
building with GCC for arm64 or x86_64 could merge hardening.config into
their configuration and they would see CONFIG_CFI_CLANG get enabled by
merge_config.sh but on oldconfig or olddefconfig, it would get flipped
off again because the toolchain dependencies are not met. Might as well
make it architecture agnostic at that point :)

Cheers,
Nathan

