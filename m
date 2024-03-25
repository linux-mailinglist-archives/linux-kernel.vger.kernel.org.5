Return-Path: <linux-kernel+bounces-117487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CF088ABE5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2942E1F66F75
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE855130E4F;
	Mon, 25 Mar 2024 16:40:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC64512B143
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384834; cv=none; b=Mq5THbbQksRVDl7AXhiQhmBx7sBFgyFcrricyIGjjzgjkNaokmumCVUHF1zGP9aS3WhRptdwCh+qqKUlyVoaCGAIoHRIseOYtLGVrHYr6Ea7WinIcs3i8MY89zPTPtjmOjMpZ/a1xRImuJHzKZTxz3uwgINQvNr5o9YOdi4i6vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384834; c=relaxed/simple;
	bh=3JD2cP34z98jlVGvzHKp989vlhvR8mbop7iAsu3vAbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9Jj8t+MYEfC5ruUodgIjZlyGfECpJkeYOcUSAcex5O91Pv2V0oDP9cJpZ/KacEOfFHg0rxlIUqONImxYfi8zRUxzR25E/900O6tUtSHEW+n7obA+NBRGYdmtn0OmGCCVxHDkoYL494yPRsYgDN365+NGsgmCurqhWj8aEULnJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CABC2F4;
	Mon, 25 Mar 2024 09:41:03 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECE4F3F64C;
	Mon, 25 Mar 2024 09:40:26 -0700 (PDT)
Date: Mon, 25 Mar 2024 16:39:12 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: David Laight <David.Laight@aculab.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Charlie Jenkins <charlie@rivosinc.com>, Guo Ren <guoren@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Xiao Wang <xiao.w.wang@intel.com>, Yangyu Chen <cyy@cyyself.name>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
Message-ID: <ZgGosOiW6mTeSnTL@FVFF77S0Q05N>
References: <20240313180010.295747-1-samuel.holland@sifive.com>
 <CAHVXubjLWZkjSapnsWJzimWg_2swEy7tQ-DQ6ri8yMk8-Qsc-A@mail.gmail.com>
 <88de4a1a-047e-4be9-b5b0-3e53434dc022@sifive.com>
 <b5624bba-9917-421b-8ef0-4515d442f80b@ghiti.fr>
 <f786e02245424e02b38f55ae6b29d14a@AcuMS.aculab.com>
 <d323eb10-c79b-49cb-94db-9b135e6fd280@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d323eb10-c79b-49cb-94db-9b135e6fd280@ghiti.fr>

On Mon, Mar 25, 2024 at 08:30:37AM +0100, Alexandre Ghiti wrote:
> Hi David,
> 
> On 24/03/2024 20:42, David Laight wrote:
> > ...
> > > The use of alternatives allows to return right away if the buffer is
> > > beyond the usable user address space, and it's not just "slightly
> > > faster" for some cases (a very large buffer with only a few bytes being
> > > beyond the limit or someone could fault-in all the user pages and fail
> > > very late...etc). access_ok() is here to guarantee that such situations
> > > don't happen, so actually it makes more sense to use an alternative to
> > > avoid that.
> > Is it really worth doing ANY optimisations for the -EFAULT path?
> > They really don't happen.
> > 
> > The only fault path that matters is the one that has to page in
> > data from somewhere.
> 
> Which is completely avoided with a strict definition of access_ok(). I see
> access_ok() as an already existing optimization of fault paths by avoiding
> them entirely when they are bound to happen.

I think the point that David is making is that address+size pairs that'd fail
access_ok() *should* be rare, and hence it's a better trade-off to occasionally
handle faults for those if it makes the common case of successful access_ok()
smaller or faster. For any well-behaved userspace applications, access_ok()
should practically never fail, since userspace should be passing good
address+size pairs as arguments to syscalls.

Using a compile-time constant TASK_SIZE_MAX allows the compiler to generate
much better code for access_ok(), and on arm64 we use a compile-time constant
even when our page table depth can change at runtime (and when native/compat
task sizes differ). The only abosolute boundary that needs to be maintained is
that access_ok() fails for kernel addresses.

Mark.

