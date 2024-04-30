Return-Path: <linux-kernel+bounces-164021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B398B773E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A01286D90
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F8617167F;
	Tue, 30 Apr 2024 13:34:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E9512D776
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484052; cv=none; b=FA3+WWM9ET+cUlZjdsHLCMSXDNMItsLKrJ+4pmUzyGw64cfVMynI0I17I8BtaNbnUcz0T68FPKo+RfqLYz5KdxN/VegvDxfHLPVFsnP7G/eqIsgbCuNCyvayj8mSubYiRZzIP5+T31PuEFPCdpN+4s6P3SVpk/55DnR1HoBbr7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484052; c=relaxed/simple;
	bh=OsYliPdbKS2RCt5sTywXCV7rvL0tdlr+8mSnbVv/184=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Am74au0VXd7450EW+bez+kNIdXnAMb4kwS3AuvQpTuJ4Q3/ldvIQmJRN5nVMvrVmvK98w95uZHvoKfsPcRq1ZQBznSMZUWCOrE1DYK5F8tz9lF8diDodzEQGjsMj43X2WhgBQPNmvxer01XpU6nRsjxHBclXv5GLktZnpLzIihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B50552F4;
	Tue, 30 Apr 2024 06:34:36 -0700 (PDT)
Received: from [10.1.38.140] (XHFQ2J9959.cambridge.arm.com [10.1.38.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3F393F793;
	Tue, 30 Apr 2024 06:34:08 -0700 (PDT)
Message-ID: <3a1669be-2cf4-486c-901a-3350cf7ffd25@arm.com>
Date: Tue, 30 Apr 2024 14:34:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64/mm: Refactor PMD_PRESENT_INVALID and
 PTE_PROT_NONE bits
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Shivansh Vij <shivanshvij@outlook.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240429140208.238056-1-ryan.roberts@arm.com>
 <20240429140208.238056-2-ryan.roberts@arm.com> <Zi_IzrfIcqWxt7cE@arm.com>
 <839d6975-ce12-4fc9-aa3b-8ec5787bf577@arm.com> <ZjDR0EIjLr9F2dWn@arm.com>
 <8cf74e5f-e6a5-465e-83b4-205233c78005@arm.com> <ZjDyCg2LkFEXRS6k@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZjDyCg2LkFEXRS6k@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/04/2024 14:28, Catalin Marinas wrote:
> On Tue, Apr 30, 2024 at 12:35:49PM +0100, Ryan Roberts wrote:
>> There is still one problem I need to resolve; During this work I discovered that
>> core-mm can call pmd_mkinvalid() for swap pmds. On arm64 this will turn the swap
>> pmd into a present pmd, and BadThings can happen in GUP-fast (and any other
>> lockless SW table walkers). My original fix modified core-mm to only call
>> pmd_mkinvalid() for present pmds. But discussion over there has shown that arm64
>> is the only arch that cannot handle this. So I've been convinced that it's
>> probably more robust to make arm64 handle it gracefully and add tests to
>> debug_vm_pgtable.c to check for this. Patch incoming shortly, but it will cause
>> a conflict with this series. So I'll send a v2 of this once that fix is accepted.
> 
> Sounds fine. I can queue the arm64 pmd_mkinvalid() fix for 6.9 and you
> can base this series on top. But I have a preference for this patchset
> to sit in -next for a bit anyway, so it might be 6.11 material.

Yeah that works for me. I just sent the pmd_mkinvalid() fix.


