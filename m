Return-Path: <linux-kernel+bounces-145866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 928058A5C18
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 225EAB241AB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322A5156675;
	Mon, 15 Apr 2024 20:12:44 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B61156652;
	Mon, 15 Apr 2024 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713211963; cv=none; b=sSUBkyTe7y8FAFgCajOZY6opGTULkyP+1rBWhfvngWbaa77AMHgbwB2guvTrrpVQRCWzxv+N0uMwjSVIQQlGk2nw2IKBQsKtxGtwWanHCEpqNewU0SKVupVn/SSwEZAMPyxn+fleVYaXEa6dj9Cl/yXC1qfsq+6n35mA2V8EO68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713211963; c=relaxed/simple;
	bh=NuOPpB9j3aJ1Lio7+rBX0plGF9Yi2yGnbDVH1cBRp6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgGe/6SiehLAnMnSaq1dDdIi2XoOBZODsXMa71juaH7aGzOZhtDrOjovq+8bagjZSjY1hzIwGQnFtcvXIRDA2H/UdZU0K4L5lqw4oemzASmhBmHFH7RPYyvY8UOAayKsglM6hfDRTvsWkODQcjxDaATDCrgL84aaiEUUZ5fm+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0FF3140E00B2;
	Mon, 15 Apr 2024 20:12:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VWcs05e6tN85; Mon, 15 Apr 2024 20:12:33 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B40740E0187;
	Mon, 15 Apr 2024 20:12:24 +0000 (UTC)
Date: Mon, 15 Apr 2024 22:12:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waiman Long <longman@redhat.com>, x86@kernel.org
Subject: Re: [tip: locking/core] locking/atomic/x86: Introduce
 arch_try_cmpxchg64_local()
Message-ID: <20240415201119.GBZh2J57f3aouPE_JR@fat_crate.local>
References: <20240414161257.49145-1-ubizjak@gmail.com>
 <171312759954.10875.1385994404712358986.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <171312759954.10875.1385994404712358986.tip-bot2@tip-bot2>

On Sun, Apr 14, 2024 at 08:46:39PM -0000, tip-bot2 for Uros Bizjak wrote:
> The following commit has been merged into the locking/core branch of tip:
> 
> Commit-ID:     d26e46f6bf329cfcc469878709baa41d3bfc7cc3
> Gitweb:        https://git.kernel.org/tip/d26e46f6bf329cfcc469878709baa41d3bfc7cc3
> Author:        Uros Bizjak <ubizjak@gmail.com>
> AuthorDate:    Sun, 14 Apr 2024 18:12:43 +02:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Sun, 14 Apr 2024 22:40:54 +02:00
> 
> locking/atomic/x86: Introduce arch_try_cmpxchg64_local()
> 
> Introduce arch_try_cmpxchg64_local() for 64-bit and 32-bit targets
> to improve code using cmpxchg64_local().  On 64-bit targets, the
> generated assembly improves from:
> 
>     3e28:	31 c0                	xor    %eax,%eax
>     3e2a:	4d 0f b1 7d 00       	cmpxchg %r15,0x0(%r13)
>     3e2f:	48 85 c0             	test   %rax,%rax
>     3e32:	0f 85 9f 00 00 00    	jne    3ed7 <...>
> 
> to:
> 
>     3e28:	31 c0                	xor    %eax,%eax
>     3e2a:	4d 0f b1 7d 00       	cmpxchg %r15,0x0(%r13)
>     3e2f:	0f 85 9f 00 00 00    	jne    3ed4 <...>
> 
> where a TEST instruction after CMPXCHG is saved.  The improvements
> for 32-bit targets are even more noticeable, because double-word
> compare after CMPXCHG8B gets eliminated.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Waiman Long <longman@redhat.com>
> Link: https://lore.kernel.org/r/20240414161257.49145-1-ubizjak@gmail.com
> ---
>  arch/x86/include/asm/cmpxchg_32.h | 34 ++++++++++++++++++++++++++++++-
>  arch/x86/include/asm/cmpxchg_64.h |  6 +++++-
>  2 files changed, 40 insertions(+)

Ok, maybe I'm missing the point here or maybe the commit message doesn't
explain but how does this big diffstat justify one less insn?

And no, 32-bit doesn't matter.

This looks like too crazy micro-optimization to me to be worth the 40
insertions.

But I could be wrong and I'd gladly read explanations for why I am.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

