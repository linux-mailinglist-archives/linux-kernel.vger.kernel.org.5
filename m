Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D60D803162
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjLDLUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLDLUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:20:00 -0500
X-Greylist: delayed 1118 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 03:20:06 PST
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F1E9C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:20:06 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4SkLMB6mdVz9v9n;
        Mon,  4 Dec 2023 12:01:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ah1pQUPZomkE; Mon,  4 Dec 2023 12:01:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4SkLMB5yz0z9v73;
        Mon,  4 Dec 2023 12:01:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BB67E8B770;
        Mon,  4 Dec 2023 12:01:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ugshGxlMuVrf; Mon,  4 Dec 2023 12:01:26 +0100 (CET)
Received: from [172.25.230.108] (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 021778B763;
        Mon,  4 Dec 2023 12:01:25 +0100 (CET)
Message-ID: <0d8c1623-8ab5-4d60-9989-1a7f712f40cd@csgroup.eu>
Date:   Mon, 4 Dec 2023 12:01:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
Content-Language: fr-FR
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ryan Roberts <ryan.roberts@arm.com>
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
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20231115133743.674690dc78041768b79fadd9@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 15/11/2023 à 22:37, Andrew Morton a écrit :
> On Wed, 15 Nov 2023 16:30:05 +0000 Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> However, the primary motivation for this change is to reduce the number
>> of tlb maintenance operations that the arm64 backend has to perform
>> during fork
> 
> Do you have a feeling for how much performance improved due to this?
> 
> Are there other architectures which might similarly benefit?  By
> implementing ptep_set_wrprotects(), it appears.  If so, what sort of
> gains might they see?
> 

I think powerpc 8xx would benefit.

We have 16k hugepages which are implemented with 4 identical PTE which 
have the _PAGE_SPS bit set. _PAGE_SPS says it is a 16k page.

We have 512k hugepages which are implemented with 128 identical PTE 
which have _PAGE_HUGE bit set. _PAGE_HUGE tells it is a 512k page.

FWIW, PMD size is 4M and there is no 4M page size so no way to implement 
leaf PMD huge pages.

Christophe
