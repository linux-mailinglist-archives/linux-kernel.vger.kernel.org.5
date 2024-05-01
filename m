Return-Path: <linux-kernel+bounces-165165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9F88B88DE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4A91C209BC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5985960B96;
	Wed,  1 May 2024 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eL6YOqnp"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C95028F;
	Wed,  1 May 2024 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561607; cv=none; b=nytBgwOFV59eMf1KHQWSSuuzUnulrzgX39BHlMx49BClTnnNgfB0UoX9FvYgatA/Jsct1lfM1KtsF4svU26ONxeRNnbZyhi9MgtGuoB1fUDn0Wcbd2ACSMcFlt71z8xvFn6Qtt0C/l8knZmqcL7k/Zd0HvOEG4zQlmXZKA0v+P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561607; c=relaxed/simple;
	bh=hqFVMicxiJEATeOF/1jtox+rOiQl5zLUQQK3VQGe1ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cy5/TJMe5TInNIY5YfWlSIKG8KlVAcbHt/DUbXngtrfUN+6KUKjhzEjxjQ0OCVUozfUnLpV9x4wjIiG90jvr7KJBaCPxV5lrRaRnET2+9l6PdF0kICsOIhKaEbTC+CswtfZqSyGmJtTZSYn4cOQu3C3JqvXQgUhZNAF+VnmJzpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eL6YOqnp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aNpiIghGKhPJ0ZIxsrzl9Nb+y+hsY2vBs19eG4Yd/jM=; b=eL6YOqnpySW2lWXLYPLdhXlpO/
	0Z/4wH1ftAMvgh9jO3if19zP4ThcY0bxTX5I5xow1Y0EOZt+V1VO+a8C5E379CH6JOr6uUtIVy2o5
	CpinvZONv3FR2koeGLiTyHfLxT269URPDm8ceepTtAPEZ11d9gwZHGymjl4ia6dz2kr6uOYnyo57/
	g657iUjhv20jq0gV6KRanU1KStOlqk9xo8zoKu+bkU9dsF+p96ZIWZqLWALill5zOermPnuNtEhdr
	NEQyX8Xm2H3QanwU+igqLYuTtja6/l5lW0yH9IPLT0xJeUaJLWxlaR5ohbuSi5rrHEk7A0flsV/8k
	TU7tF6Iw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s27mx-0000000HM6l-1X6Z;
	Wed, 01 May 2024 11:06:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0BBA7300362; Wed,  1 May 2024 13:06:15 +0200 (CEST)
Date: Wed, 1 May 2024 13:06:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hardening: Refresh KCFI options, add some more
Message-ID: <20240501110614.GI40213@noisy.programming.kicks-ass.net>
References: <20240426222940.work.884-kees@kernel.org>
 <20240430092140.GE40213@noisy.programming.kicks-ass.net>
 <202404301037.9E34D4811@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404301037.9E34D4811@keescook>

On Tue, Apr 30, 2024 at 10:48:36AM -0700, Kees Cook wrote:
> On Tue, Apr 30, 2024 at 11:21:40AM +0200, Peter Zijlstra wrote:
> > On Fri, Apr 26, 2024 at 03:29:44PM -0700, Kees Cook wrote:
> > 
> > > - CONFIG_CFI_CLANG=y for x86 and arm64. (And disable FINEIBT since
> > >   it isn't as secure as straight KCFI.)
> > 
> > Oi ?
> 
> Same objection I always had[1]: moving the check into the destination
> means attacks with control over executable memory contents can just omit
> the check.

I thought it was game over if you could write arbitrary test anyway?

The whole CFI thing was about clobbering data (function pointers to be
more specific), and both are robust against that.


