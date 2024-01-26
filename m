Return-Path: <linux-kernel+bounces-40388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BAE83DF5E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4DDCB21FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED06A1EA6F;
	Fri, 26 Jan 2024 17:00:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C9A1DFD8;
	Fri, 26 Jan 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706288430; cv=none; b=RNkvQLgoaSzihldOxrFGHQj7slAKY47v98V6Zu8622y+AcGEXl72Q0lPTo7WhgYpB6fps2qtA+x+v6YViFrDHmK0GhdJXhwrkN0LboCZoUKSah//XwjKJpdnXFq/yDdGUuFRssQqpMH9jS2mVW5ekiLBbgrx09RagOgt0ZLIGjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706288430; c=relaxed/simple;
	bh=IKSWKIZsjMZWZWERh7avT8L31KXo0Zec9oXMsAJHcmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyGjSN8eU7AGaDDrUg8Mf7Ugka0pdhRHuLGa/ZUuZ4SqcWp5Dw87z74VHKoe52McBeapjTYhE+kIBAuzpuw5TFRQzxahNvoqj+JUTH7hOXkNsreM8nWU/+1AK/8QB8eoEosaUAKEFhS73kgdow8q3lhe141V2ENsgeQ7mbsGDHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16DBF1FB;
	Fri, 26 Jan 2024 09:01:12 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.47.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14E733F762;
	Fri, 26 Jan 2024 09:00:24 -0800 (PST)
Date: Fri, 26 Jan 2024 17:00:15 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: akpm@linux-foundation.org, masahiroy@kernel.org, nicolas@fjasle.eu,
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/11] arm64: Kconfig: Clean up tautological LLVM version
 checks
Message-ID: <ZbPlFGHjJg9X_pHt@FVFF77S0Q05N>
References: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
 <20240125-bump-min-llvm-ver-to-13-0-1-v1-5-f5ff9bda41c5@kernel.org>
 <ZbOsvhDB-6LMVACP@FVFF77S0Q05N>
 <20240126161025.GA3265550@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126161025.GA3265550@dev-arch.thelio-3990X>

On Fri, Jan 26, 2024 at 09:10:25AM -0700, Nathan Chancellor wrote:
> On Fri, Jan 26, 2024 at 12:59:55PM +0000, Mark Rutland wrote:
> > On Thu, Jan 25, 2024 at 03:55:11PM -0700, Nathan Chancellor wrote:
> > >  config CPU_BIG_ENDIAN
> > >  	bool "Build big-endian kernel"
> > > -	depends on !LD_IS_LLD || LLD_VERSION >= 130000
> > >  	# https://github.com/llvm/llvm-project/commit/1379b150991f70a5782e9a143c2ba5308da1161c
> > 
> > We can delete the URL here, since that was just to describe why this depended
> > upon LLVM 13+; it's weird for it to sit here on its own.
> 
> I think this is the URL for the fix for the problem brought up by
> commit 146a15b87335 ("arm64: Restrict CPU_BIG_ENDIAN to GNU as or LLVM
> IAS 15.x or newer"), so I think it should stay? It does not look like I
> ever added a link or context for the LLD line, I definitely should have.

Whoops; I clearly misread that, and yes it should stay.

Sorry about that; for the patch as-is:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

