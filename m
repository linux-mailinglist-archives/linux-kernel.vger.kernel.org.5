Return-Path: <linux-kernel+bounces-117711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31B488B575
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBE24C44EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609A93FBA0;
	Mon, 25 Mar 2024 18:30:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6D44C7D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391425; cv=none; b=cdVimvrH2mH5qOiYuBbx+eE071v30Po9FbXDaYvlDOIlEhbICSgo6f5PvAbgtc7ryBNSexYBZ3LD4WzHY+3x6d2LIoClMTD/heLh2Imavuo50h4kVNYJX2XSxWEuPtVx9ybwAwCebkdFabMe3b+zpwW3Yqn/x6QS5qL/pY48E9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391425; c=relaxed/simple;
	bh=2VXxq70Xu5k4H6YqcuOfLx1H+38OuiTNGp8GyXVcVVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIJheins2TJaOuXO1D18BKgXTQXYBSiKgESHmNA3gd4wZvCasERWq6C7nHLOjyqcK0+R3FAkmQI15ZSGHk+NciTXF8FB9kAqOT2KBz74q0e9YFTbs0fDvC9a8hG7kDiq+GCV3wSnpTge2rqchknJJdUjtkvYO8Yrai5iQPUDosA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3769B2F4;
	Mon, 25 Mar 2024 11:30:54 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FEC93F64C;
	Mon, 25 Mar 2024 11:30:17 -0700 (PDT)
Date: Mon, 25 Mar 2024 18:30:08 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Ghiti <alex@ghiti.fr>, David Laight <David.Laight@aculab.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Charlie Jenkins <charlie@rivosinc.com>, guoren <guoren@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Xiao W Wang <xiao.w.wang@intel.com>, Yangyu Chen <cyy@cyyself.name>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
Message-ID: <ZgHCpgHh1ypSyrtv@FVFF77S0Q05N>
References: <20240313180010.295747-1-samuel.holland@sifive.com>
 <CAHVXubjLWZkjSapnsWJzimWg_2swEy7tQ-DQ6ri8yMk8-Qsc-A@mail.gmail.com>
 <88de4a1a-047e-4be9-b5b0-3e53434dc022@sifive.com>
 <b5624bba-9917-421b-8ef0-4515d442f80b@ghiti.fr>
 <f786e02245424e02b38f55ae6b29d14a@AcuMS.aculab.com>
 <d323eb10-c79b-49cb-94db-9b135e6fd280@ghiti.fr>
 <ZgGosOiW6mTeSnTL@FVFF77S0Q05N>
 <eeccbc9f-7544-42c9-964f-2b4c924c2b2f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeccbc9f-7544-42c9-964f-2b4c924c2b2f@app.fastmail.com>

On Mon, Mar 25, 2024 at 07:02:13PM +0100, Arnd Bergmann wrote:
> On Mon, Mar 25, 2024, at 17:39, Mark Rutland wrote:
> 
> > Using a compile-time constant TASK_SIZE_MAX allows the compiler to generate
> > much better code for access_ok(), and on arm64 we use a compile-time constant
> > even when our page table depth can change at runtime (and when native/compat
> > task sizes differ). The only abosolute boundary that needs to be maintained is
> > that access_ok() fails for kernel addresses.
> 
> As I understand, this works on arm64 and x86 because the kernel
> mapping starts on negative 64-bit addresses, so the highest user
> address (TASK_SIZE = 0x000fffffffffffff) is still smaller than the
> lowest kernel address (PAGE_OFFSET = 0xfff0000000000000).

Yep; the highest posible user address is always below the lowest possible
kernel address, and any "non-canonical" address between the two ranges faults.
There's some fun with TBI (Top Byte Ignore) and MTE, but that only affects how
to mangle the pointer before the check, and doesn't affect the definition of
the VA boundary.

In general, so long as TASK_SIZE_MAX is <= the lowest possible kernel address
and TASK_SIZE_MAX > the highest possible user address, it all works out.

> If an architecture ignores all the top bits of a virtual address,
> the largest TASK_SIZE would be higher than the smallest (positive,
> unsigned) PAGE_OFFSET, so you need TASK_SIZE_MAX to be dynamic.

Agreed, but do we even support such architectures within Linux?

> It doesn't look like this is the case on riscv, but I'm not sure
> about this part.

It looks like riscv is in the same bucket as arm64 and x86 per:

  https://www.kernel.org/doc/html/next/riscv/vm-layout.html

.. which says:

| The RISC-V privileged architecture document states that the 64bit addresses
| "must have bits 63-48 all equal to bit 47, or else a page-fault exception
| will occur.": that splits the virtual address space into 2 halves separated
| by a very big hole, the lower half is where the userspace resides, the upper
| half is where the RISC-V Linux Kernel resides.

Mark.

