Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723987B6D40
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjJCPfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjJCPfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:35:34 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7A8AF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:35:31 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 608734000D;
        Tue,  3 Oct 2023 15:35:23 +0000 (UTC)
Message-ID: <24b6ec5c-cf71-9d01-d624-ffba2e25eaf8@ghiti.fr>
Date:   Tue, 3 Oct 2023 17:35:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH -fixes 2/2] riscv: Fix set_huge_pte_at() for NAPOT
 mappings when a swap entry is set
To:     Conor Dooley <conor@kernel.org>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230928151846.8229-1-alexghiti@rivosinc.com>
 <20230928151846.8229-3-alexghiti@rivosinc.com>
 <20230930-unnoticed-slacked-0bf5696cc265@spud>
 <96984fd2-2e3b-d861-5555-5b5a4e5c55d6@ghiti.fr>
 <20231002-unending-ether-1b9f73eb642c@spud>
Content-Language: en-US
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20231002-unending-ether-1b9f73eb642c@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Conor,

On 02/10/2023 15:11, Conor Dooley wrote:
> On Mon, Oct 02, 2023 at 09:18:52AM +0200, Alexandre Ghiti wrote:
>> Hi Conor,
>>
>> On 30/09/2023 11:14, Conor Dooley wrote:
>>> On Thu, Sep 28, 2023 at 05:18:46PM +0200, Alexandre Ghiti wrote:
>>>> We used to determine the number of page table entries to set for a NAPOT
>>>> hugepage by using the pte value which actually fails when the pte to set is
>>>> a swap entry.
>>>>
>>>> So take advantage of a recent fix for arm64 reported in [1] which
>>>> introduces the size of the mapping as an argument of set_huge_pte_at(): we
>>>> can then use this size to compute the number of page table entries to set
>>>> for a NAPOT region.
>>>>
>>>> Fixes: 82a1a1f3bfb6 ("riscv: mm: support Svnapot in hugetlb page")
>>>> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> Closes: https://lore.kernel.org/linux-arm-kernel/20230922115804.2043771-1-ryan.roberts@arm.com/ [1]
>>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>> Breaks the build. Your $subject marks this for -fixes, but this will not
>>> build there, as it relies on content that's not yet in that branch.
>>> AFAICT, you're going to have to resend this with akpm on CC, as the
>>> dependency is in his tree...
>>
>> I see, but I still don't understand why -fixes does not point to the latest
>> rcX instead of staying on rc1?
> It's up to Palmer what he does with his fixes branch, but two thoughts.
> Doing what you suggest would require rebasing things not yet sent to Linus
> every week and fast-forwarding when PRs are actually merged.
> IIRC, Palmer used to do something like the latter, but IIRC he got some
> complaints about that and switched to the current method.
> At the very least, you should point out dependencies like this, as I
> figure an individual patch could be applied on top of -rc4 and merged
> in. Both Palmer and I have submitted things for b4 to improve support for
> doing things exactly like this ;)
>
>> The patch which this series depends on just made it to rc4.
> However, if you do not mention what the deps for your patches are
> explicitly, how are people supposed to know? The reference to the
> dependency makes it look like a report for a similar problem that also
> applies to riscv, not a pre-requisite for the patch.


You're right, I saw the dependency being merged so I thought it would be 
ok but I should have mention it. I have just discussed with Palmer, and 
I'll +cc Andrew to see if he can take that in his tree.

Thanks!

Alex


>
> Thanks,
> Conor.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
