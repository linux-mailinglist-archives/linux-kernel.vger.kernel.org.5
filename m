Return-Path: <linux-kernel+bounces-35490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 459128391F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94551F2515F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9A75FBAE;
	Tue, 23 Jan 2024 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OZ4uDMvo"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00383604A6;
	Tue, 23 Jan 2024 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022103; cv=none; b=R99d7P7/ithGWzJYBzgi5YRAS08/XJPjG5tHdpUakAOZRc2nu01CrIrLJJ0Ppo6xi2GEhsC7oZpO82LMZP3nl/DeABA1Kw1kU77DtsbgSPKWgpGo9NqYF8DGRT8G81tlGSbUvPMYQRk72+BBjFjKpNX8hTLFkkZN5bZyybgBwFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022103; c=relaxed/simple;
	bh=ShMrW1ADV7iv+pVf3ziJG/80/SbMo2RZcy8p0RkUoJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/IEDz2gDRSCHmxBK5XFWH1/zjXtlFjaJvCP5sBE7GVtDyByH2YMq/Ko7MB/tjOU013VaqIrCvP554ukGdgfSB2LvBZgzUY4CiNpuEjvT9MMfxY7SMCwbYfnGzbczzVKEysqNrUd4QT6b0sw9fQ08GS6g57gJG0DsR5Y1HibPkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OZ4uDMvo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PepByJiWQ5z0YJAy3zsX5i+pG7M9t28NlsHRNrHyzFg=; b=OZ4uDMvo60iZ4l06WQT6UPpOyK
	1Mzz1amI2B4lmc7SzQBo9/H5nZHwSc+ahhYWItLeLfbqvNQjOpLZ379CUtpyrKiJpaFB3y3qceoFn
	2/09mBIgxlyPrDWwBI1N1vIcVhBAJ+ccP2Eft8qdX7sawkIRu0Y4eD33nl5AX1fWh4yZRXAHa0diJ
	xtf9jKwnR9O51wT9yPKs25kKmm0Ym9Nc1WnmkYd5euK/RIRwr1nWxHB5018vQ5PnPMYfUbcXkcguy
	WziupYXg/e8D0xyqPtbSRcqVXqNtY1gEyT+tocZwXdwgad56hM1QmUaMd0kzNvFae844ES7sQELU7
	yz18rMEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSIHS-00000003Un2-0lR2;
	Tue, 23 Jan 2024 15:01:38 +0000
Date: Tue, 23 Jan 2024 15:01:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: Re: [PATCH v1 01/11] arm/pgtable: define PFN_PTE_SHIFT on arm and
 arm64
Message-ID: <Za_U0kYHGFkJdSss@casper.infradead.org>
References: <20240122194200.381241-1-david@redhat.com>
 <20240122194200.381241-2-david@redhat.com>
 <fdaeb9a5-d890-499a-92c8-d171df43ad01@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdaeb9a5-d890-499a-92c8-d171df43ad01@arm.com>

On Tue, Jan 23, 2024 at 10:34:21AM +0000, Ryan Roberts wrote:
> > +#define PFN_PTE_SHIFT		PAGE_SHIFT
> 
> I think this is buggy. And so is the arm64 implementation of set_ptes(). It
> works fine for 48-bit output address, but for 52-bit OAs, the high bits are not
> kept contigously, so if you happen to be setting a mapping for which the
> physical memory block straddles bit 48, this won't work.

I'd like to see the folio allocation that can straddle bit 48 ...

agreed, it's not workable _in general_, but specifically for a memory
allocation from a power-of-two allocator, you'd have to do a 49-bit
allocation (half a petabyte) to care.

