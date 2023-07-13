Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B50A752058
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjGMLqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjGMLqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:46:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FDBB4;
        Thu, 13 Jul 2023 04:46:44 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R1t8R3SfQzVjcT;
        Thu, 13 Jul 2023 19:45:27 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 19:46:40 +0800
Message-ID: <699d421a-b8cf-a338-5736-acc25f671c57@huawei.com>
Date:   Thu, 13 Jul 2023 19:46:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH rfc -next 00/10] mm: convert to generic VMA lock-based
 page fault
Content-Language: en-US
To:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        <surenb@google.com>
CC:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <linux-s390@vger.kernel.org>
References: <20230713095155.189443-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230713095155.189443-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this one...

On 2023/7/13 17:51, Kefeng Wang wrote:
> Add a generic VMA lock-based page fault handler in mm core, and convert
> architectures to use it, which eliminate architectures's duplicated codes.
> 
> With it, we can avoid multiple changes in architectures's code if we
> add new feature or bugfix.
> 
> This fixes riscv missing change about commit 38b3aec8e8d2 "mm: drop per-VMA
> lock when returning VM_FAULT_RETRY or VM_FAULT_COMPLETED", and in the end,
> we enable this feature on ARM32/Loongarch too.
> 
> This is based on next-20230713, only built test(no loongarch compiler,
> so except loongarch).
> 
> Kefeng Wang (10):
>    mm: add a generic VMA lock-based page fault handler
>    x86: mm: use try_vma_locked_page_fault()
>    arm64: mm: use try_vma_locked_page_fault()
>    s390: mm: use try_vma_locked_page_fault()
>    powerpc: mm: use try_vma_locked_page_fault()
>    riscv: mm: use try_vma_locked_page_fault()
>    ARM: mm: try VMA lock-based page fault handling first
>    loongarch: mm: cleanup __do_page_fault()
>    loongarch: mm: add access_error() helper
>    loongarch: mm: try VMA lock-based page fault handling first
> 
>   arch/arm/Kconfig          |  1 +
>   arch/arm/mm/fault.c       | 15 ++++++-
>   arch/arm64/mm/fault.c     | 28 +++---------
>   arch/loongarch/Kconfig    |  1 +
>   arch/loongarch/mm/fault.c | 92 ++++++++++++++++++++++++---------------
>   arch/powerpc/mm/fault.c   | 54 ++++++++++-------------
>   arch/riscv/mm/fault.c     | 38 +++++++---------
>   arch/s390/mm/fault.c      | 23 +++-------
>   arch/x86/mm/fault.c       | 39 +++++++----------
>   include/linux/mm.h        | 28 ++++++++++++
>   mm/memory.c               | 42 ++++++++++++++++++
>   11 files changed, 206 insertions(+), 155 deletions(-)
> 
