Return-Path: <linux-kernel+bounces-7113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B8B81A1CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C504E1F2391A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99873DB9B;
	Wed, 20 Dec 2023 15:05:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43483E477
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 095B41FB;
	Wed, 20 Dec 2023 07:05:55 -0800 (PST)
Received: from [10.57.75.247] (unknown [10.57.75.247])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93AB03F64C;
	Wed, 20 Dec 2023 07:05:06 -0800 (PST)
Message-ID: <396cae5d-70e4-449f-af6c-2348b720d3a3@arm.com>
Date: Wed, 20 Dec 2023 15:05:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/16] mm: Batch-copy PTE ranges during fork()
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
 <be8b5181-be2c-4800-ba53-c65a6c3ed803@redhat.com>
 <dd227e51-c4b2-420b-a92a-65da85ab4018@arm.com>
 <7c0236ad-01f3-437f-8b04-125d69e90dc0@redhat.com>
 <9a58b1a2-2c13-4fa0-8ffa-2b3d9655f1b6@arm.com>
 <28968568-f920-47ac-b6fd-87528ffd8f77@redhat.com>
 <10b0b562-c1c0-4a66-9aeb-a6bff5c218f6@arm.com>
 <8f8023cb-3c31-4ead-a9e6-03a10e9490c6@redhat.com>
 <da16a7e5-76dd-4150-9ade-54b0d227a1e1@arm.com>
 <699cb1db-51eb-460e-9ceb-1ce08ca03050@redhat.com>
 <da29a4c6-61f6-4203-9c82-9ce6e1c32552@arm.com>
 <2a8c5b6c-f5ae-43b2-99aa-6d10e79b76e1@redhat.com>
 <ade26f27-03af-4ad7-ad81-38b482f7572c@arm.com>
 <3194b8a5-3f72-4d9e-a267-fbdad32ad864@redhat.com>
 <f2f420cf-678d-466d-ac30-bc8251f16632@arm.com>
 <9f99a3ca-051e-4b1b-81e9-8456d8e422ad@redhat.com>
 <c1913fa2-d313-4f05-a649-da69b6d31d2a@arm.com>
 <c244707c-8c0c-4593-ab45-d8f165dbc5ee@redhat.com>
 <ba6a5c11-34fb-40ca-b24a-f51a207464f2@arm.com>
 <5fcbf405-7e62-4b38-acc4-a9dd8cc91214@redhat.com>
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <5fcbf405-7e62-4b38-acc4-a9dd8cc91214@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/12/2023 14:00, David Hildenbrand wrote:
> [...]
> 
>>>>
>>>
>>> gcc version 13.2.1 20231011 (Red Hat 13.2.1-4) (GCC)
>>>
>>>  From Fedora 38. So "a bit" newer :P
>>>
>>
>> I'll retry with newer toolchain.
>>
>> FWIW, with the code fix and the original compiler:
>>
>> Fork, order-0, Apple M2:
>> | kernel                |   mean_rel |   std_rel |
>> |:----------------------|-----------:|----------:|
>> | mm-unstable           |       0.0% |      0.8% |
>> | hugetlb-rmap-cleanups |       1.3% |      2.0% |
>> | fork-batching         |       4.3% |      1.0% |
>>
>> Fork, order-9, Apple M2:
>> | kernel                |   mean_rel |   std_rel |
>> |:----------------------|-----------:|----------:|
>> | mm-unstable           |       0.0% |      0.8% |
>> | hugetlb-rmap-cleanups |       0.9% |      0.9% |
>> | fork-batching         |     -37.3% |      1.0% |
>>
>> Fork, order-0, Ampere Altra:
>> | kernel                |   mean_rel |   std_rel |
>> |:----------------------|-----------:|----------:|
>> | mm-unstable           |       0.0% |      0.7% |
>> | hugetlb-rmap-cleanups |       3.2% |      0.7% |
>> | fork-batching         |       5.5% |      1.1% |
>>
>> Fork, order-9, Ampere Altra:
>> | kernel                |   mean_rel |   std_rel |
>> |:----------------------|-----------:|----------:|
>> | mm-unstable           |       0.0% |      0.1% |
>> | hugetlb-rmap-cleanups |       0.5% |      0.1% |
>> | fork-batching         |     -10.4% |      0.1% |
>>
> 
> I just gave it another quick benchmark run on that Intel system.
> 
> hugetlb-rmap-cleanups -> fork-batching
> 
> order-0: 0.014114 -> 0.013848
> 
> -1.9%
> 
> order-9: 0.014262 -> 0.009410
> 
> -34%
> 
> Note that I disable SMT and turbo, and pin the test to one CPU, to make the
> results as stable as possible. My kernel config has anything related to
> debugging disabled.
> 

And with gcc 13.2 on arm64:

Fork, order-0, Apple M2 VM:
| kernel                |   mean_rel |   std_rel |
|:----------------------|-----------:|----------:|
| mm-unstable           |       0.0% |      1.5% |
| hugetlb-rmap-cleanups |      -3.3% |      1.1% |
| fork-batching         |      -3.6% |      1.4% |

Fork, order-9, Apple M2 VM:
| kernel                |   mean_rel |   std_rel |
|:----------------------|-----------:|----------:|
| mm-unstable           |       0.0% |      1.8% |
| hugetlb-rmap-cleanups |      -5.8% |      1.3% |
| fork-batching         |     -38.1% |      2.3% |

Fork, order-0, Ampere Altra:
| kernel                |   mean_rel |   std_rel |
|:----------------------|-----------:|----------:|
| mm-unstable           |       0.0% |      1.3% |
| hugetlb-rmap-cleanups |      -0.1% |      0.4% |
| fork-batching         |      -0.4% |      0.5% |

Fork, order-9, Ampere Altra:
| kernel                |   mean_rel |   std_rel |
|:----------------------|-----------:|----------:|
| mm-unstable           |       0.0% |      0.1% |
| hugetlb-rmap-cleanups |      -0.1% |      0.1% |
| fork-batching         |     -13.9% |      0.1% |


So all looking good. Compiler was the issue. Sorry for the noise.

So please go ahead with you rmap v2 stuff, and I'll wait for you to post the
fork and zap batching patches properly, then rebase my arm64 contpte stuff on
top and remeasure everything.

Thanks,
Ryan


