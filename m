Return-Path: <linux-kernel+bounces-161753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725BE8B50BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 572ECB20DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A248DDCB;
	Mon, 29 Apr 2024 05:31:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9B82F44
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714368676; cv=none; b=NTpoL0PLTdq4zjSHJz5TFahPhq55UAjFhEIfrVuX9AKP6iDN0HxJIM7lApYesWbSh4c60sRpKD4SdbsiWXyNt0WMdp4yfuIgBAWVS17Fd2lFZxR6BZhl7DQD8CJsQYsSw0qYPIl7D4kMu17dDhe7QoOfLramA7c84o5HTdiOFOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714368676; c=relaxed/simple;
	bh=LVXHe4zEDA5iVete0+mf/0ocv6UyPh4w1tK/wQ6Ws1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpGr9as/20pDv0Pt5Za9ja+Jcz3Pq6sLZg26G7gSq+GJDFkyhDk48rA8nxiNgn5A2vLCgs62Aq/c1QAAzSPkDSk2mh4uiAen98Y5GDwDH/2YjzDarJSCJxHE4qnEZym7mvnf3LOX/3nJNYxZa28/QZwlnvskl/3k1zFaFtRscbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CAD92F4;
	Sun, 28 Apr 2024 22:31:41 -0700 (PDT)
Received: from [10.162.42.72] (a077893.blr.arm.com [10.162.42.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 888473F793;
	Sun, 28 Apr 2024 22:31:11 -0700 (PDT)
Message-ID: <755b4f9e-437f-468f-a43e-c93742ac9828@arm.com>
Date: Mon, 29 Apr 2024 11:01:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
 <39d0236c-4297-4001-bc7e-f516bc674f7b@arm.com>
 <87df74b7-2352-4ad6-b9f9-baed9291cbed@arm.com>
 <80148272-208A-4306-A8EC-98C79BBBDCA0@nvidia.com>
 <D0E6B5DC-6206-408C-81D1-C9B0A85E1D0E@nvidia.com>
 <1734de6e-1bcd-492e-b07b-9ad712967e1d@nvidia.com>
 <6F2BB00A-DBCD-4482-B16E-B71A02847F0D@nvidia.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <6F2BB00A-DBCD-4482-B16E-B71A02847F0D@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/27/24 20:37, Zi Yan wrote:
> On 27 Apr 2024, at 0:25, John Hubbard wrote:
> 
>> On 4/26/24 7:53 AM, Zi Yan wrote:
>>
>> Hi Zi (and Ryan)!
>>
>>>>>>> lockless pgtable walker could see the migration entry pmd in this state
>>>>>>> and start interpretting the fields as if it were present, leading to
>>>>>>> BadThings (TM). GUP-fast appears to be one such lockless pgtable walker.
>>>>>> Could you please explain how bad things might happen ?
>>>>> See 2 places where pmdp_get_lockless() is called in gup.c, without the PTL.
>>>>> These could both return the swap pte for which pmd_mkinvalid() has been called.
>>>>> In both cases, this would lead to the pmd_present() check eroneously returning
>>>>> true, eventually causing incorrect interpretation of the pte fields. e.g.:
>>>>>
>>>>> gup_pmd_range()
>>>>>    pmd_t pmd = pmdp_get_lockless(pmdp);
>>>>>    gup_huge_pmd(pmd, ...)
>>>>>      page = nth_page(pmd_page(orig), (addr & ~PMD_MASK) >> PAGE_SHIFT);
>>>>>
>>>>> page is guff.
>>>>>
>>>>> Let me know what you think!
>>> Add JohnH to check GUP code.
>> Ryan is correct about this behavior.
>>
>> By the way, remember that gup is not the only lockless page table
>> walker: there is also the CPU hardware itself, which inconveniently
>> refuses to bother with taking page table locks. 🙂
>>
>> So if we have code that can make a non-present PTE appear to be present
>> to any of these page walkers, whether software or hardware, it's a
>> definitely Not Good and will lead directly to bugs.
> This issue does not bother hardware, because the PTE_VALID/PMD_SECT_VALID
> is always unset and hardware always sees this PMD as invalid. It is a pure
> software issue, since for THP splitting, we do not want hardware to access
> the page but still allow kernel to user pmd_page() to get the pfn, so
> pmd_present() returns true even if PTE_VALID/PMD_SECT_VALID is unset by
> setting and checking PMD_PRESENT_INVALID bit. pmd_mkinvalid() sets
> PMD_PRESENT_INVALID, turning a migration entry from !pmd_present() to
> pmd_present(), while it is always a invalid PMD to hardware.

Agreed, this is not a HW issue at all, MMU sees such an entry as invalid
even if pmd_present() returns true.

