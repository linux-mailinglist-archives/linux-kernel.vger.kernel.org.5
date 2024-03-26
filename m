Return-Path: <linux-kernel+bounces-119216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9385888C5C5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5811C630A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E0513C68E;
	Tue, 26 Mar 2024 14:50:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959C213C674
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464605; cv=none; b=XYMOxzyI492c0Vt12/cLA9O+fSsbvxEuy9hE7qNihweNMtWC5XCZtJ1GzrKIL6ID/owtNO+6AIkfhavuJ8sbCy4tgKniWhUF+f+eP1DTN/K3NaBjo/zWa3CAhn2ymx55dbqCdv9MSj/ZYsjGvEngdFPLug/LZ6/WWwIAVhlXNT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464605; c=relaxed/simple;
	bh=K283dq0rMCMbXlbjFmsIYUEw3mlmXF2plQnChcVoYxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a41CK21z4Efd0Y++uNoE7x1L3Nf+tQBzxZJ02y82jisHHOI885WwgTG5TsUlvyYRZH2LHDR9EVz8PKsaQAISzNfp8IJHDup4z6JUTSSwd9nCweTHCITX1HDiW+wGuMursOgoiqYa2u190delaX9S/31j2bAiO+o+ORw/OUH6VWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BBA1339;
	Tue, 26 Mar 2024 07:50:36 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C25E3F694;
	Tue, 26 Mar 2024 07:50:00 -0700 (PDT)
Date: Tue, 26 Mar 2024 14:49:57 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: David Laight <David.Laight@aculab.com>
Cc: 'Arnd Bergmann' <arnd@arndb.de>, Alexandre Ghiti <alex@ghiti.fr>,
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
Message-ID: <ZgLglSl94dnWIoqX@FVFF77S0Q05N.cambridge.arm.com>
References: <CAHVXubjLWZkjSapnsWJzimWg_2swEy7tQ-DQ6ri8yMk8-Qsc-A@mail.gmail.com>
 <88de4a1a-047e-4be9-b5b0-3e53434dc022@sifive.com>
 <b5624bba-9917-421b-8ef0-4515d442f80b@ghiti.fr>
 <f786e02245424e02b38f55ae6b29d14a@AcuMS.aculab.com>
 <d323eb10-c79b-49cb-94db-9b135e6fd280@ghiti.fr>
 <ZgGosOiW6mTeSnTL@FVFF77S0Q05N>
 <eeccbc9f-7544-42c9-964f-2b4c924c2b2f@app.fastmail.com>
 <ZgHCpgHh1ypSyrtv@FVFF77S0Q05N>
 <95eb125d-dd54-42f1-b080-938faca6a8a1@app.fastmail.com>
 <882fc86da89f4adb81570cde3a653e6f@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <882fc86da89f4adb81570cde3a653e6f@AcuMS.aculab.com>

On Tue, Mar 26, 2024 at 10:19:28AM +0000, David Laight wrote:
> From: Arnd Bergmann
> > Sent: 25 March 2024 20:38
> > 
> > On Mon, Mar 25, 2024, at 19:30, Mark Rutland wrote:
> > > On Mon, Mar 25, 2024 at 07:02:13PM +0100, Arnd Bergmann wrote:
> > >> On Mon, Mar 25, 2024, at 17:39, Mark Rutland wrote:
> > >
> > >> If an architecture ignores all the top bits of a virtual address,
> > >> the largest TASK_SIZE would be higher than the smallest (positive,
> > >> unsigned) PAGE_OFFSET, so you need TASK_SIZE_MAX to be dynamic.
> > >
> > > Agreed, but do we even support such architectures within Linux?
> > 
> > Apparently not.
> > 
> > On 32-bit architectures, you often have TASK_SIZE==PAGE_OFFSET,
> > but not on 64-bit -- either the top few bits in PAGE_OFFSET are
> > always ones, or the user and kernel page tables are completely
> > separate.
> 
> ISTR that arm64 uses (something like) bit 56 to select kernel
> with the annoying 'feature' that the high bits can be ignored
> just to complicate things.

Yes, bit 55.

We choose our TASK_SIZE_MAX to be below 2^55, so no kernel address will pass
access_ok(), and we pre-mangle the TBI bits for userspace so they can't affect
the check and fail unexpectedly.

So it doesn't actually matter -- leave that aspect to arch code.

Mark.

