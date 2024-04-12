Return-Path: <linux-kernel+bounces-143300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 179EA8A36F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95351281DDD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F89D1514D3;
	Fri, 12 Apr 2024 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tVcUfZGX"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E3C14A091;
	Fri, 12 Apr 2024 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712953250; cv=none; b=b0Ok1ZZV37suVQCqax4XPd5E9mZb3nfF3A3EkG/F3WRLy91Qb/lcwwojuJMKIAdtiXzV1oBRb9C9nau6KAkU0dP1rvQCtMapoL0cjrqrEQnwH4UtzWQwbHe0AuXJznDVpLiEPtHpC2Dh+bWyQGsKsgAeb4+xk+z8w1YCYJBi8CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712953250; c=relaxed/simple;
	bh=4xLHEQcQ1V8eybg8jbVcylscrNjj4X7QeUnaQO5RvwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtebS1eWiJ9npnH+1/mDqKqAAHm2y+PrBbR4qtebBZQ/vX8CLRAc5fudzcNJHeFcPPD8WdOcL4ZvxzZPrfm1cbd9oYDUg+X612j8H0gul1dS9dcHSEqj7uASbBgpdyw9rmLJgvaHNq66YSRDznZ3Le1ULdW2ObW9pTb+aXt2yaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tVcUfZGX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V1ruHJWRhf9traik+clLxlyBbZ44QWr1+mb3lIChcXg=; b=tVcUfZGXCKsFcNpkt+aEDu9t3Y
	jPqsuKJ9q72BDW1DhXj91fBpPaEe9KiTfpBSIKkmUw9sdkO0ugrN/z9l1viJj027h8ykD8nx8Ob08
	IZM7kfWn53Oxo4lXAB0LHC9yViVMMXJfaO6iOxXOCVPYiisFhGib5Wg5WIGdUbORp5xCqco7CMu7N
	0CpG25SDEufzlILmoYXKO003r8Nu98HHs8azBbeljcsZ0su/xw9GtVrvJfgykzwAQPoERVtsH26f6
	moWp5BiaEQraIkhpAgr+Mgd7GiP8SZL+negT14TpvvukRZm6iuN9xMh/K/3yNZBgSFjWM75uvUdWH
	MIt+cqgg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvNO9-00000001B6L-1DtP;
	Fri, 12 Apr 2024 20:20:48 +0000
Date: Fri, 12 Apr 2024 13:20:43 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kallsyms: replace deprecated strncpy with strscpy
Message-ID: <ZhmXm4xVMY5QPEGn@bombadil.infradead.org>
References: <20240412-strncpy-kernel-module-kallsyms-c-v1-1-ba3f0fc16163@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412-strncpy-kernel-module-kallsyms-c-v1-1-ba3f0fc16163@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Apr 12, 2024 at 06:53:47PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces. The goal is to remove its use completely [2].
> 
> namebuf is eventually cleaned of any trailing llvm suffixes using
> strstr(). This hints that namebuf should be NUL-terminated.
> 
> static void cleanup_symbol_name(char *s)
> {
> 	char *res;
> 	...
> 	res = strstr(s, ".llvm.");
> 	...
> }
> 
> Due to this, use strscpy() over strncpy() as it guarantees
> NUL-termination on the destination buffer. Drop the -1 from the length
> calculation as it is no longer needed to ensure NUL-termination.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> Link: https://github.com/KSPP/linux/issues/90 [2]
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks! Queued up on modules-next.

  Luis

