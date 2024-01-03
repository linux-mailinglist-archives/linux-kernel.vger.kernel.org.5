Return-Path: <linux-kernel+bounces-16022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2DC823717
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00F6287A84
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFFF1D69F;
	Wed,  3 Jan 2024 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FgufvgkB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA321D69C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 816B640E01F9;
	Wed,  3 Jan 2024 21:26:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XxZ4BEil3FHZ; Wed,  3 Jan 2024 21:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704317190; bh=YnhIhGi7uhmYxobYW5Yk8gatYZadsKTzT27pewe8GL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FgufvgkBUsdVTQtZl0QxP+Abk5mq8N8zb86jkEXKJkSxv5Ba6qSDFvhAsUAIm7ZyR
	 ft3NZUnMhA4hQN1dV0ZH15XnWNi4OK1zdcrD02Q9rubsCzgSt0jI2ShbgzSAdgVMG9
	 mFSDqBzQR1zFVnQNMWnsflGEYiIWdsl4tVAihxiBIIhttEmHoztHn1s5NFlC1EPUgM
	 /+8eFX72He1+7uwCr7rVbR8XHaClyVhfKKm3Seg+aX/TNpbpFnOBY0buoEdgO2/I6F
	 74qKslZfzCaVpR7gThUoXqX/jeqYulAhazEMxTwVJAFlGWr2vohzk/YFiScaS9aqfl
	 g0+zC4ScuU0WOLQdLNAhAaTMMeO2kAYxFje64atZ3KfXLaXmYaaIKE8ObuYKTk8B5w
	 Rmq6G5NEbUPbb1K3A6Lt7t6N/8nrn/32V21IhQs3F6b1jfGD97k3sgPIpIUSezp81J
	 mlkA2KFt6rioLLpU2+P/xLauKXTl4m+5k7aI9gzBVUGyVBp9be/M5jB6h547lkdSVH
	 zKX2QLlhR1zyFaDRhFeIY2bO1C6M1vOGtWFvnNjuKyptCHpodgIlfdEh/iv27r3DB2
	 czNMg+HOUMmHCixkCdTJAJulOEuTpa2CXRiJiR4EgvLJ2YkhFLAAE3PSCgN0ggImVK
	 4pSfp51sircrnyfG6urmBNQM=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 017D640E01F7;
	Wed,  3 Jan 2024 21:26:20 +0000 (UTC)
Date: Wed, 3 Jan 2024 22:26:16 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] x86/tools: objdump_reformat.awk: Skip bad instructions
 from llvm-objdump
Message-ID: <20240103212616.GGZZXQ+IKGPb+EqVcu@fat_crate.local>
References: <20231205-objdump_reformat-awk-handle-llvm-objdump-bad_expr-v1-1-b4a74f39396f@kernel.org>
 <20240103181542.GA629234@dev-arch.thelio-3990X>
 <20240103181852.GDZZWlDJMVvqAZdpfV@fat_crate.local>
 <20240103205506.GA152662@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240103205506.GA152662@dev-arch.thelio-3990X>

On Wed, Jan 03, 2024 at 01:55:06PM -0700, Nathan Chancellor wrote:
> On Wed, Jan 03, 2024 at 07:18:52PM +0100, Borislav Petkov wrote:
> > On Wed, Jan 03, 2024 at 11:15:42AM -0700, Nathan Chancellor wrote:
> > > Ping? I am still seeing this issue.
> > 
> > Does this need a Fixes tag and needs to go to Linus now or are you fine
> > with 6.8-rc0?
> 
> This is only needed due to the recent changes from Sam and myself in
> x86/build

I don't understand: those three commits seem unrelated to LLVM objdump
outputting "<unknown>".

Or are you saying that you've *started* running the insn decoder selftest
with llvm's objdump and those three commits are addressing differences
in the output and this outstanding commit is needed too for the bad
opcode case?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

