Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66B77B6D5D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjJCPnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjJCPnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:43:22 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC2E95
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:43:18 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 24B891BF207;
        Tue,  3 Oct 2023 15:43:10 +0000 (UTC)
Message-ID: <305b4dec-c99d-3cee-4563-8d7dcbae9384@ghiti.fr>
Date:   Tue, 3 Oct 2023 17:43:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH -fixes 0/2] Fix set_huge_pte_at()
Content-Language: en-US
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230928151846.8229-1-alexghiti@rivosinc.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230928151846.8229-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc Andrew: Would  you mind taking this patchset in your tree for the 
next rc? This patchset depends on a previous fix for arm64 that you 
merged in rc4 which is not in the riscv -fixes branch yet.

I saw with Palmer and he should ack this shortly.

If I can do anything else to help, let me know.

Thanks,

Alex

On 28/09/2023 17:18, Alexandre Ghiti wrote:
> A recent report [1] from Ryan for arm64 revealed that we do not handle
> swap entries when setting a hugepage backed by a NAPOT region (the
> contpte riscv equivalent).
>
> As explained in [1], the issue was discovered by a new test in kselftest
> which uses poison entries, but the symptoms are different from arm64 though:
>
> - the riscv kernel bugs because we do not handle VM_FAULT_HWPOISON*,
>    this is fixed by patch 1,
> - after that, the test passes because the first pte_napot() fails (the
>    poison entry does not have the N bit set), and then we only set the
>    first page table entry covering the NAPOT hugepage, which is enough
>    for hugetlb_fault() to correctly raise a VM_FAULT_HWPOISON wherever we
>    write in this mapping since only this first page table entry is
>    checked
>    (see https://elixir.bootlin.com/linux/v6.6-rc3/source/mm/hugetlb.c#L6071).
>    But this seems fragile so patch 2 sets all page table entries of a
>    NAPOT mapping.
>
> [1]: https://lore.kernel.org/linux-arm-kernel/20230922115804.2043771-1-ryan.roberts@arm.com/
>
>
> Alexandre Ghiti (2):
>    riscv: Handle VM_FAULT_[HWPOISON|HWPOISON_LARGE] faults instead of
>      panicking
>    riscv: Fix set_huge_pte_at() for NAPOT mappings when a swap entry is
>      set
>
>   arch/riscv/mm/fault.c       |  2 +-
>   arch/riscv/mm/hugetlbpage.c | 19 +++++++++++++------
>   2 files changed, 14 insertions(+), 7 deletions(-)
>
