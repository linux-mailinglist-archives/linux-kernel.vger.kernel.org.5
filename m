Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE70A7EDDAA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbjKPJfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKPJfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:35:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A97CE1A3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:35:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3AA61595;
        Thu, 16 Nov 2023 01:35:46 -0800 (PST)
Received: from [10.1.35.163] (XHFQ2J9959.cambridge.arm.com [10.1.35.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B91443F6C4;
        Thu, 16 Nov 2023 01:34:57 -0800 (PST)
Message-ID: <a485f4af-8196-4b25-9f15-25aebe390904@arm.com>
Date:   Thu, 16 Nov 2023 09:34:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231115163018.1303287-2-ryan.roberts@arm.com>
 <20231115133743.674690dc78041768b79fadd9@linux-foundation.org>
Content-Language: en-GB
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231115133743.674690dc78041768b79fadd9@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2023 21:37, Andrew Morton wrote:
> On Wed, 15 Nov 2023 16:30:05 +0000 Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> However, the primary motivation for this change is to reduce the number
>> of tlb maintenance operations that the arm64 backend has to perform
>> during fork
> 
> Do you have a feeling for how much performance improved due to this? 

The commit log for patch 13 (the one which implements ptep_set_wrprotects() for
armt64) has performance numbers for a fork() microbenchmark with/without the
optimization:

---8<---

I see huge performance regression when PTE_CONT support was added, then
the regression is mostly fixed with the addition of this change. The
following shows regression relative to before PTE_CONT was enabled
(bigger negative value is bigger regression):

|   cpus |   before opt |   after opt |
|-------:|-------------:|------------:|
|      1 |       -10.4% |       -5.2% |
|      8 |       -15.4% |       -3.5% |
|     16 |       -38.7% |       -3.7% |
|     24 |       -57.0% |       -4.4% |
|     32 |       -65.8% |       -5.4% |

---8<---

Note that's running on Ampere Altra, where TLBI tends to have high cost.

> 
> Are there other architectures which might similarly benefit?  By
> implementing ptep_set_wrprotects(), it appears.  If so, what sort of
> gains might they see?

The rationale for this is to reduce expense for arm64 to manage
contpte-mappings. If other architectures support contpte-mappings then they
could benefit from this API for the same reasons that arm64 benefits. I have a
vague understanding that riscv has a similar concept to the arm64's contiguous
bit, so perhaps they are a future candidate. But I'm not familiar with the
details of the riscv feature so couldn't say whether they would be likely to see
the same level of perf improvement as arm64.

Thanks,
Ryan


