Return-Path: <linux-kernel+bounces-167656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E325F8BACD9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AC21C216DD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AF215357B;
	Fri,  3 May 2024 12:54:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852D714267
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740844; cv=none; b=Rs8fSCNEsQr7JzCH+4rRlfHjosH6eL35KAkcb90HWVDjivEOLND6VYL2jqIoObHXPDPjO+lobBh04859+Gi3BpIyhnJOEcuWZAUN6z27CbL3SHO2K+Q/v6sXCXnbG8H/msHiTMd+fzeqDGyMhvDe/mKChG/LObas5B6UzLbeIRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740844; c=relaxed/simple;
	bh=+6EYlFhVT+kjGVbBnNFDCmPqWr5uEiMz55mkta0KrdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/ii3Ax9ve3L2pt96W6cEwSO4iiVzKA2AuFlUuku3w1pKVwgwEJHJ+I5qn/fIF1scPEIl2lhM5kv4GYrBuOucdbZ+u5F9TnXf8cUc9ANEOWWqT8ksoWlS/GaEMPPg3dfkUN3s1Bj3yMN71KbIE39EAAQaNaxlSnQTIlUwySUs5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38B5F13D5;
	Fri,  3 May 2024 05:54:28 -0700 (PDT)
Received: from [10.57.67.51] (unknown [10.57.67.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EE3A3F73F;
	Fri,  3 May 2024 05:54:01 -0700 (PDT)
Message-ID: <345b3d66-9c18-4a25-8b1f-a84aafac5156@arm.com>
Date: Fri, 3 May 2024 13:53:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] arm64/mm: Enable userfaultfd write-protect
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Joey Gouly
 <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Shivansh Vij <shivanshvij@outlook.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240501145419.1390363-1-ryan.roberts@arm.com>
 <20240503120104.GA18156@willie-the-truck>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240503120104.GA18156@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/05/2024 13:01, Will Deacon wrote:
> Hi Ryan,
> 
> On Wed, May 01, 2024 at 03:54:16PM +0100, Ryan Roberts wrote:
>> This series adds uffd write-protect support for arm64.
>>
>> Previous attempts to add uffd-wp (and soft-dirty) have failed because of a
>> perceived lack of available PTE SW bits. However it actually turns out that
>> there are 2 available but they are hidden. PTE_PROT_NONE was previously
>> occupying a SW bit, but can be moved, freeing up the SW bit. Bit 63 is marked as
>> "IGNORED" in the Arm ARM, but it does not currently indicate "reserved for SW
>> use" like it does for the other SW bits. I've confirmed with the spec owner that
>> this is an oversight; the bit is intended to be reserved for SW use and the spec
>> will clarify this in a future update.
>>
>> So now we have two spare bits; patch 3 enables uffd-wp on arm64, using the SW
>> bit freed up by moving PTE_PROT_NONE. This leaves bit 63 spare for future use
>> (e.g. soft-dirty - see RFC at [3] - or some other usage).
> 
> Thanks, I think this series looks really good now.
> 
> From your discussion with Anshuman, it sounds like you're going to post
> a new version with the first patch split up so I'll wait for that.

Yep, I'll try to get that out this afternoon. Thanks!

> 
> Will


