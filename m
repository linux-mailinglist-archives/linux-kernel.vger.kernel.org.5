Return-Path: <linux-kernel+bounces-35530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E1E839288
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5C51F285E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E755FEF9;
	Tue, 23 Jan 2024 15:22:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB6B5FDD2;
	Tue, 23 Jan 2024 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023330; cv=none; b=fIVtExs6aj0vOPDHzfBpfN/l8rZT/+8jCr9FQC2hfMHva2CUvyqtdnyBAtSkrzFF5SNF74K1C9zNsJH2d7DOWyF+1Zrx3OEB7X0De/v7sDHBCeE+bme3dygj7K5j/xqcFODJn8utuCat6dCKsBJUOQmPVShPCgc7LzkD/uxsJ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023330; c=relaxed/simple;
	bh=B8rajI02soiPeZIE95pKcfT09vwUGJ8c8WQVfwcI9hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UuS7RelIXT7lcAZ0guOrdG4Icq+klLn6pGw58cZdpmzF6Y6TANLCCpSn7PmWskGM8aFV5VIuwOZrPDwjJRqU07OG7OGrCn5ISsDi6T3YC33VgQfG/2gztu9GC7wAMx7sWuwEsYq8VOi0SdmInGTkYVt1O5tj9z2+Cq9kUEODvxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 985121FB;
	Tue, 23 Jan 2024 07:22:51 -0800 (PST)
Received: from [10.57.77.165] (unknown [10.57.77.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AB543F5A1;
	Tue, 23 Jan 2024 07:22:01 -0800 (PST)
Message-ID: <90a9b1e5-9203-4baf-a69a-69b4f9ad73d5@arm.com>
Date: Tue, 23 Jan 2024 15:22:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/11] arm/pgtable: define PFN_PTE_SHIFT on arm and
 arm64
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
References: <20240122194200.381241-1-david@redhat.com>
 <20240122194200.381241-2-david@redhat.com>
 <fdaeb9a5-d890-499a-92c8-d171df43ad01@arm.com>
 <Za_U0kYHGFkJdSss@casper.infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Za_U0kYHGFkJdSss@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/2024 15:01, Matthew Wilcox wrote:
> On Tue, Jan 23, 2024 at 10:34:21AM +0000, Ryan Roberts wrote:
>>> +#define PFN_PTE_SHIFT		PAGE_SHIFT
>>
>> I think this is buggy. And so is the arm64 implementation of set_ptes(). It
>> works fine for 48-bit output address, but for 52-bit OAs, the high bits are not
>> kept contigously, so if you happen to be setting a mapping for which the
>> physical memory block straddles bit 48, this won't work.
> 
> I'd like to see the folio allocation that can straddle bit 48 ...
> 
> agreed, it's not workable _in general_, but specifically for a memory
> allocation from a power-of-two allocator, you'd have to do a 49-bit
> allocation (half a petabyte) to care.

Hmm good point. So its a hypothetical bug, not an actual bug. Personally I'm
still inclined to "fix" it. Although its going to cost a few more instructions.
Shout if you disagree.

