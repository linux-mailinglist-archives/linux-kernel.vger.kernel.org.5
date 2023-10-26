Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C3F7D856C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345378AbjJZPAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjJZPAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:00:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 722761AB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:00:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 580512F4;
        Thu, 26 Oct 2023 08:01:15 -0700 (PDT)
Received: from [10.1.36.151] (XHFQ2J9959.cambridge.arm.com [10.1.36.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 649033F64C;
        Thu, 26 Oct 2023 08:00:32 -0700 (PDT)
Message-ID: <ca11d0f7-bc4c-4f05-89e8-690da2169fda@arm.com>
Date:   Thu, 26 Oct 2023 16:00:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes 0/2] Fix set_huge_pte_at()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20230928151846.8229-1-alexghiti@rivosinc.com>
 <305b4dec-c99d-3cee-4563-8d7dcbae9384@ghiti.fr>
 <20231003090443.67a2e2692b68211e05b53248@linux-foundation.org>
 <CAHVXubi5C0hBaXx5tqVHZAJSd1zvHRqoxUEkk9ZbmZ5mq2=mAw@mail.gmail.com>
 <20231026071300.e12dab3be1edd26007db85ee@linux-foundation.org>
 <32d9627c-821a-48f0-b430-0532a47b8699@ghiti.fr>
 <36aa1ec7-df13-4741-be09-c53a05f3d591@arm.com>
 <20231026075415.47c0a032906b604de08ed39b@linux-foundation.org>
Content-Language: en-GB
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231026075415.47c0a032906b604de08ed39b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2023 15:54, Andrew Morton wrote:
> On Thu, 26 Oct 2023 15:30:44 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>>>>> Those fixes finally did not make it to 6.6, I was hoping for them to
>>>>> land in -rc6 or -rc7: for the future, what should have I done to avoid
>>>>> that?
>>>> They're merged in Linus's tree.
>>>>
>>>> 6f1bace9a9fb arm64: hugetlb: fix set_huge_pte_at() to work with all swap entries
>>>> 935d4f0c6dc8 mm: hugetlb: add huge page size param to set_huge_pte_at()
>>>
>>>
>>> Oops, sorry, I missed them this morning!
>>
>> Those two patches that Andrew highlights are the fix I did for arm64. Weren't
>> you referring to the corresponding patches you did for riscv, Alex?
> 
> These are in mainline:
> 
> 1de195dd0e05 riscv: fix set_huge_pte_at() for NAPOT mappings when a swap entry is set
> 117b1bb0cbc7 riscv: handle VM_FAULT_[HWPOISON|HWPOISON_LARGE] faults instead of panicking

Ahh, great - I think they were probably the ones Alex was talking about.

> 
> I'm not sure what happened to your "riscv: hugetlb: convert
> set_huge_pte_at() to take vma" - perhaps it was updated.

I modified the approach for v2 (pass size param instead of vma) and it got
squashed into 935d4f0c6dc8 mm: hugetlb: add huge page size param to
set_huge_pte_at(), which is in.

