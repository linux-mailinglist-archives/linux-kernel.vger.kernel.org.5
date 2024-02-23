Return-Path: <linux-kernel+bounces-77994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAFF860DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E4B282B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F26E5C8F1;
	Fri, 23 Feb 2024 09:19:28 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5323E1A731;
	Fri, 23 Feb 2024 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679968; cv=none; b=BwdRAooxNYuNn6CXbTo0nkoGnmI9w1SETPTwFevZPOAXyYWjqcaRrytrIjOkxU5wgXGdTP4bks1v5VJeXjnELQKLo6HyNr9dF5U1JmDOyA6R6Az/h2IhrKrFzM/Cn75mzAuV6bEHX/4QD5CtXHhZ00LZZB5wmaBXuMAywxyFMAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679968; c=relaxed/simple;
	bh=B2LN/yniV9iT2GJ1kbsrmW4avghqfoHXIm5XQIcvZAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6isupdtZ5TbkEBf8dji4BwmY7H3ak/Sqva/tY1r1FHcjsAAZcA+Rn6ZTlYDBLERb/XMgh86OCQX30yDKb30PBzGCgtYP4VcwaLhUz2rJBYt4IYvIklOHfmSeLWgJZFmPIk6G5+7Arf60QZ6uNIAv1TPWn2L8zZJB7d3WuvccQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rdRi6-0003JB-00; Fri, 23 Feb 2024 10:19:14 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id C738DC0267; Fri, 23 Feb 2024 10:18:00 +0100 (CET)
Date: Fri, 23 Feb 2024 10:18:00 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 0/8] MIPS: Aggregate build fixes
Message-ID: <ZdhiyFzR3sC4nc+p@alpha.franken.de>
References: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>

On Fri, Feb 02, 2024 at 06:21:39PM +0000, Jiaxun Yang wrote:
> Hi all,
> 
> This series is a collection of build fixes that have been lying
> at my local trees for a while, some of them are for Clang built
> linux and others are for some wiredo configurations.
> 
> Please review.
> 
> Thanks
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Jiaxun Yang (8):
>       MIPS: Probe toolchain support of -msym32
>       MIPS: Remove cc-option checks for -march=octeon
>       MIPS: Fallback CPU -march flag to ISA level if unsupported
>       MIPS: BMIPS: Drop unnecessary assembler flag
>       MIPS: Loongson64: test for -march=loongson3a cflag
>       MIPS: Limit MIPS_MT_SMP support by ISA reversion
>       MIPS: Implement microMIPS MT ASE helpers
>       MIPS: mipsregs: Set proper ISA level for virt extensions
> 
>  arch/mips/Kconfig                  |   3 +-
>  arch/mips/Makefile                 |  46 ++++---
>  arch/mips/include/asm/asmmacro.h   |  22 ++--
>  arch/mips/include/asm/mipsmtregs.h | 256 ++++++++++++++++++++++---------------
>  arch/mips/include/asm/mipsregs.h   |  22 +++-
>  arch/mips/kernel/vpe-mt.c          |   4 +-
>  6 files changed, 211 insertions(+), 142 deletions(-)
> ---
> base-commit: 076d56d74f17e625b3d63cf4743b3d7d02180379
> change-id: 20240202-llvm-msym32-6392d410f650

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

