Return-Path: <linux-kernel+bounces-43843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BCA841971
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2BF1C24E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D649364C6;
	Tue, 30 Jan 2024 02:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpGWGzS0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763032E62A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706582508; cv=none; b=CI5zSnmAuvlRmUwfI78xupkFWc1Ov4wkgZCs1vz8QHZ0mYWt+/SGzqMa4eHFkhxJTAdGNpIg/ZP0zTN2SsHVx6kopc5RV+88U0R1VZWrlXbaMrGVLvPA95bif3rmpDt7IfbLvX3cOnkQnAj985lnodxiW/lk0oa5rmWaDHi8umg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706582508; c=relaxed/simple;
	bh=9Ut89lTFvq6e5zUsCJr9shpwYxDSjuxBW81gAsURs/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7p5iSPPPNzi45QTggrgFQf9xKTU/rNeNKQOrKSit2jgud3ejE7q/6YPJuq2WZiBAbCPiFnew9YqElS5MAMKOVQztnlupVzoWi+qhLanRrxLWWX9AhWuzENqyzDQ8fQuuTluuLfFswwYn+V+vkRlNuh5JdegYfVQuP9wRqneoo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpGWGzS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F94C433F1;
	Tue, 30 Jan 2024 02:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706582508;
	bh=9Ut89lTFvq6e5zUsCJr9shpwYxDSjuxBW81gAsURs/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KpGWGzS0rU9bW2NfkcGOQIeDMhTtcxkWvt03ID4ShGnoZgMPDhszFEpiQSAdIl83D
	 1Ia/QTCZkN8ZaPolnrovBBC2WyYXO3C1avKLVm5nLYcDREeL/et/km68xTwFWndN5y
	 GgXRwlaSs5GxWO2xcSMD23b8GKI7M6BBZtELrfYt+2uJSn9kodwSb+tyfzHpsUaxdb
	 6oY49H9ppM/EkcaFHNPUoorX0C/zaSXWChza3l9JWsBnTiAsbeMWdaAXdhVuPo+/yp
	 gbHyPcyUtT36AT9wn201Jca+iA0jvcBY5A6BV5fogvBtZxoIGziH7R1toxrb3qYSE7
	 mAFe2RG/+zZdQ==
Date: Tue, 30 Jan 2024 10:28:57 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] riscv: optimize memcpy/memmove/memset
Message-ID: <Zbhe6c4kCYv0uIZv@xhacker>
References: <20240128111013.2450-1-jszhang@kernel.org>
 <20240129-prelaw-tweet-ae59a90ded20@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129-prelaw-tweet-ae59a90ded20@spud>

On Mon, Jan 29, 2024 at 06:16:13PM +0000, Conor Dooley wrote:
> On Sun, Jan 28, 2024 at 07:10:10PM +0800, Jisheng Zhang wrote:
> > This series is to renew Matteo's "riscv: optimized mem* functions"
> > sereies.
> > 
> > Compared with Matteo's original series, Jisheng made below changes:
> > 1. adopt Emil's change to fix boot failure when build with clang
> > 2. add corresponding changes to purgatory
> > 3. always build optimized string.c rather than only build when optimize
> > for performance
> > 4. implement unroll support when src & dst are both aligned to keep
> > the same performance as assembly version. After disassembling, I found
> > that the unroll version looks something like below, so it acchieves
> > the "unroll" effect as asm version but in C programming language:
> > 	ld	t2,0(a5)
> > 	ld	t0,8(a5)
> > 	ld	t6,16(a5)
> > 	ld	t5,24(a5)
> > 	ld	t4,32(a5)
> > 	ld	t3,40(a5)
> > 	ld	t1,48(a5)
> > 	ld	a1,56(a5)
> > 	sd	t2,0(a6)
> > 	sd	t0,8(a6)
> > 	sd	t6,16(a6)
> > 	sd	t5,24(a6)
> > 	sd	t4,32(a6)
> > 	sd	t3,40(a6)
> > 	sd	t1,48(a6)
> > 	sd	a1,56(a6)
> > And per my testing, unrolling more doesn't help performance, so
> > the "c" version only unrolls by using 8 GP regs rather than 16
> > ones as asm version.
> > 5. Add proper __pi_memcpy and __pi___memcpy alias
> > 6. more performance numbers.
> > 
> > Per my benchmark with [1] on TH1520, CV1800B and JH7110 platforms,
> > the unaligned medium memcpy performance is running about 3.5x ~ 8.6x
> > speed of the unpatched versions's! Check patch1 for more details and
> > performance numbers.
> > 
> > Link:https://github.com/ARM-software/optimized-routines/blob/master/string/bench/memcpy.c [1]
> > 
> > Here is the original cover letter msg from Matteo:
> > Replace the assembly mem{cpy,move,set} with C equivalent.
> > 
> > Try to access RAM with the largest bit width possible, but without
> > doing unaligned accesses.
> > 
> > A further improvement could be to use multiple read and writes as the
> > assembly version was trying to do.
> > 
> > Tested on a BeagleV Starlight with a SiFive U74 core, where the
> > improvement is noticeable.
> 
> However, with allmodconfig it doesn't compile:
>   Redirect to /build/tmp.zzMIlhgQQo and /build/tmp.vxnoxu8G5e
>   Tree base:
>   0c526539d432 ("riscv: optimized memcpy")
>   Building the whole tree with the patch
>   ../arch/riscv/lib/string.c:118:7: error: expected identifier or '('
>   ../arch/riscv/lib/string.c:118:7: error: expected ')'
>   ../arch/riscv/lib/string.c:143:7: error: expected identifier or '('
>   ../arch/riscv/lib/string.c:143:7: error: expected ')'
>   ../arch/riscv/lib/string.c:118:7: error: expected identifier or '('
>   ../arch/riscv/lib/string.c:118:7: error: expected ')'
>   ../arch/riscv/lib/string.c:143:7: error: expected identifier or '('
>   ../arch/riscv/lib/string.c:143:7: error: expected ')'
> 
> Seems to be the case both with llvm and gcc.

Hi Conor,

This is due to missing proper FORTIFY_SOURCE handling.
Below trival patch can fix it :)
I'm waiting for more comments before sending out v2.

diff --git a/arch/riscv/lib/string.c b/arch/riscv/lib/string.c
index 022edda68f1c..bfaab058f2cb 100644
--- a/arch/riscv/lib/string.c
+++ b/arch/riscv/lib/string.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2021 Matteo Croce
  */

+#define __NO_FORTIFY
 #include <linux/types.h>
 #include <linux/module.h>
> 
> Cheers,
> Conor.
> 



