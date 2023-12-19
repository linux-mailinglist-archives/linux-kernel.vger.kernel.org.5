Return-Path: <linux-kernel+bounces-4876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5979C818337
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0555B24033
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7500125B0;
	Tue, 19 Dec 2023 08:18:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8306912B69
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45EB31FB;
	Tue, 19 Dec 2023 00:19:07 -0800 (PST)
Received: from [10.57.75.230] (unknown [10.57.75.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3D2F3F738;
	Tue, 19 Dec 2023 00:18:18 -0800 (PST)
Message-ID: <a59a2314-82f3-4278-a4de-338d725bbd32@arm.com>
Date: Tue, 19 Dec 2023 08:18:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/16] mm: thp: Batch-collapse PMD with set_ptes()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Matthew Wilcox <willy@infradead.org>, Yu Zhao <yuzhao@google.com>,
 Mark Rutland <mark.rutland@arm.com>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, John Hubbard <jhubbard@nvidia.com>,
 Zi Yan <ziy@nvidia.com>, Barry Song <21cnbao@gmail.com>,
 Alistair Popple <apopple@nvidia.com>, Yang Shi <shy828301@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20231218105100.172635-1-ryan.roberts@arm.com>
 <20231218105100.172635-2-ryan.roberts@arm.com>
 <8ce9f79c-be2f-4fa2-b356-39436a1d108a@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <8ce9f79c-be2f-4fa2-b356-39436a1d108a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/12/2023 17:40, David Hildenbrand wrote:
> On 18.12.23 11:50, Ryan Roberts wrote:
>> Refactor __split_huge_pmd_locked() so that a present PMD can be
>> collapsed to PTEs in a single batch using set_ptes(). It also provides a
>> future opportunity to batch-add the folio to the rmap using David's new
>> batched rmap APIs.
> 
> I'd drop that sentence and rather just say "In the future, we might get rid of
> the remaining manual loop by using rmap batching.".

OK fair enough. Will fix for next version.

> 
>>
>> This should improve performance a little bit, but the real motivation is
>> to remove the need for the arm64 backend to have to fold the contpte
>> entries. Instead, since the ptes are set as a batch, the contpte blocks
>> can be initially set up pre-folded (once the arm64 contpte support is
>> added in the next few patches). This leads to noticeable performance
>> improvement during split.
>>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!


