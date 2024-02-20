Return-Path: <linux-kernel+bounces-73103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B490085BD9D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B0A28668A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A032474E14;
	Tue, 20 Feb 2024 13:48:56 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09A96A346;
	Tue, 20 Feb 2024 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436934; cv=none; b=Eh1hgIu8FOawRLMqGZ13/1ssJX8l4+8410GYNFCqowe09ZTmUDZtkl9KkW6b876jkptrI/ODg6ozdGpgc6DnLSVgGJGNN6xD2UEFzn8bIiYKrHkKWoBlINUzSMNAQ+3wwkM8lz36s3dE2CPUlmNG26FdOCMrSkTjUu//IfGybuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436934; c=relaxed/simple;
	bh=SynaioFw+yQpRvdCOCb1Co5Ewh+f1Mqe+AUZhxJedIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiloiwJMgQord0zf3T2ag9K2+24IwQ9XTwC0gRG5Q2Wu/ZWq4LOn5xIomPTjNZ6wtnrwAvwkRrlkGNS9CRQw3VWXGIX+LoF6jysrWXPh3HvMOOIa60n6A2vkuZe4Bnfzjsx8mQq8RhMksSf+ub4ixw6bZ2xlritjjWBLwdLC65A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rcQUF-0007Od-00; Tue, 20 Feb 2024 14:48:43 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 06587C0A1E; Tue, 20 Feb 2024 14:39:40 +0100 (CET)
Date: Tue, 20 Feb 2024 14:39:40 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] MIPS: Unify register numbering macros for uasm
Message-ID: <ZdSrnG493wn2U+5s@alpha.franken.de>
References: <20240209-regname-v1-0-2125efa016ef@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209-regname-v1-0-2125efa016ef@flygoat.com>

On Fri, Feb 09, 2024 at 06:07:46PM +0000, Jiaxun Yang wrote:
> Hi all,
> 
> This is a attempt to unify register numbering macros for uasm,
> in response to review comment [1].
> 
> This is a rather large cosmetic change so I decided to send
> it as a sepreate set.
> 
> Please review.
> Thanks
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Jiaxun Yang (8):
>       MIPS: Unify define of CP0 registers for uasm code
>       MIPS: regdefs.h: Guard all defines with __ASSEMBLY__
>       MIPS: regdefs.h: Define a set of register numbers
>       MIPS: traps: Use GPR number macros
>       MIPS: page: Use GPR number macros
>       MIPS: tlbex: Use GPR number macros
>       MIPS: kvm/entry: Use GPR number macros
>       MIPS: pm-cps: Use GPR number macros
> 
>  arch/mips/include/asm/mipsregs.h | 249 +++++++++++++++++-----
>  arch/mips/include/asm/regdef.h   |  91 +++++++++
>  arch/mips/kernel/pm-cps.c        | 134 ++++++------
>  arch/mips/kernel/traps.c         |   6 +-
>  arch/mips/kvm/entry.c            | 431 +++++++++++++++++----------------------
>  arch/mips/mm/page.c              | 202 +++++++++---------
>  arch/mips/mm/tlbex.c             | 214 +++++++++----------
>  7 files changed, 737 insertions(+), 590 deletions(-)
> ---
> base-commit: 445a555e0623387fa9b94e68e61681717e70200a
> change-id: 20240209-regname-4c14f1147e25

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

