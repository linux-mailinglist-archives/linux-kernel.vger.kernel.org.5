Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AD6806B4E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377396AbjLFKIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377380AbjLFKIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:08:24 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFDED62;
        Wed,  6 Dec 2023 02:08:26 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7AB216000A;
        Wed,  6 Dec 2023 10:08:21 +0000 (UTC)
Message-ID: <f259088f-a590-454e-b322-397e63071155@ghiti.fr>
Date:   Wed, 6 Dec 2023 11:08:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] riscv: Enable percpu page first chunk allocator
Content-Language: en-US
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
References: <20231110140721.114235-1-alexghiti@rivosinc.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20231110140721.114235-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On 10/11/2023 15:07, Alexandre Ghiti wrote:
> While working with pcpu variables, I noticed that riscv did not support
> first chunk allocation in the vmalloc area which may be needed as a fallback
> in case of a sparse NUMA configuration.
>
> patch 1 starts by introducing a new function flush_cache_vmap_early() which
> is needed since a new vmalloc mapping is established and directly accessed:
> on riscv, this would likely fail in case of a reordered access or if the
> uarch caches invalid entries in TLB.
>
> patch 2 simply enables the page percpu first chunk allocator in riscv.
>
> Alexandre Ghiti (2):
>    mm: Introduce flush_cache_vmap_early() and its riscv implementation
>    riscv: Enable pcpu page first chunk allocator
>
>   arch/riscv/Kconfig                  | 2 ++
>   arch/riscv/include/asm/cacheflush.h | 3 ++-
>   arch/riscv/include/asm/tlbflush.h   | 2 ++
>   arch/riscv/mm/kasan_init.c          | 8 ++++++++
>   arch/riscv/mm/tlbflush.c            | 5 +++++
>   include/asm-generic/cacheflush.h    | 6 ++++++
>   mm/percpu.c                         | 8 +-------
>   7 files changed, 26 insertions(+), 8 deletions(-)
>

Any feedback regarding this?

Thanks,

Alex

