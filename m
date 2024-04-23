Return-Path: <linux-kernel+bounces-154735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC4B8AE050
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C35F281610
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949AF55C2A;
	Tue, 23 Apr 2024 08:52:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB40647F51
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862360; cv=none; b=IbD6hNAb4sRD6Xtf7NSGssNajF4DredSePXd+6hWG/Oo9eOCLhIvjhhsxJS2uXXHK37hpPU7UXH1Y9xIFKh2A9WDjY8bQ93YbvK2EHABTyBuX3USb3oeHbf+PQ469KDVscjvWgRGQicdJqDrsmhCbuhdGEmhlbWA44qnpWJyx+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862360; c=relaxed/simple;
	bh=zxOCmS5J8uz9+rq2BSY913ZBzR6qv+twFJc4XwSkjzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AciCjehWbrGEX3xctQxx/S4DfLg8U0gyUIv9hEfP3l+JYh7fXSSv68UV1Q8n18lMhpYxo6EOXYfZKTCahN4Qai6wgQFFqUNc5knQEVENJ9bC6rngC7dgjbl7t3k/8k2zTuFdNyzrm5QlOicjFTAAId+vNjTrNMYsVzBi0EtzTz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A3D3339;
	Tue, 23 Apr 2024 01:53:06 -0700 (PDT)
Received: from [10.57.74.127] (unknown [10.57.74.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84B663F64C;
	Tue, 23 Apr 2024 01:52:36 -0700 (PDT)
Message-ID: <23a2e491-f4e2-4ab0-859c-8637ffb3d21e@arm.com>
Date: Tue, 23 Apr 2024 09:52:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Merge arm64/riscv hugetlbfs contpte support
Content-Language: en-GB
To: Alexandre Ghiti <alex@ghiti.fr>, Will Deacon <will@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>
Cc: alexghiti@rivosinc.com, Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
 akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mm@kvack.org
References: <CAHVXubiH64beFuB_GHSq5BKCus=O_+bqYTCwWQ+=2Q-F=T=ctQ@mail.gmail.com>
 <mhng-911ba065-e6c8-4d42-978c-e47897bcb493@palmer-ri-x1c9a>
 <20240419110306.GA2972@willie-the-truck>
 <f6488073-b93f-4945-9d30-1ceb548d6bb4@ghiti.fr>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <f6488073-b93f-4945-9d30-1ceb548d6bb4@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/04/2024 09:50, Alexandre Ghiti wrote:
> Hi,
> 
> On 19/04/2024 13:03, Will Deacon wrote:
>> On Thu, Apr 18, 2024 at 03:11:56PM -0700, Palmer Dabbelt wrote:
>>> On Fri, 01 Mar 2024 03:29:18 PST (-0800), alexghiti@rivosinc.com wrote:
>>>> On Fri, Mar 1, 2024 at 11:45 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>> I confess I haven't looked at the patches yet, but this cover letter raises a
>>>>> few quesions for me. I'll aim to look at the actual patches in due course.
>>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>>>
>>> in case someone wants to pick them up via a generic tree.  I'm happy to take
>>> them via the RISC-V tree if folk want, no rush on my end I'm just scrubbing
>>> through old stuff.
>> I'd definitely like to take the arm64 parts via the arm64 tree (on a
>> shared branch), as it's a non-trivial amount of mm code which may end up
>> conflicting. I'd also like to see Ryan's Ack on the changes before these
>> end up in -next.
>>
>> Will
> 
> 
> The rebase on top of the contpte mTHP support changed quite a few things, I have
> something working and will send it soon, so no need to review this patchset.

Sorry this fell off my desk. CC me on the next version and I'll take a look.

> 
> Thanks,
> 
> Alex
> 
> 
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv


