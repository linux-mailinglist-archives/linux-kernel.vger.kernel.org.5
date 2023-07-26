Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02206762EFA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjGZIAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjGZH7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AA35593
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690357824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SXtdvsYorh2jLmkQgOQxjjs6N6GWZk4UdbudzqwlXs0=;
        b=J3sNuhuO7Vdr6mjuwKhUIqPZL1Z80Afk3nUPWg2QB9BJ3deB/r0i6uHxC35W50X3bWv0YV
        MbfJk056y0wLnPp3SfCAB3ayk5aWTxqgywOU5BeWWBd1qGQys+cOAUcZnvckg0AfnVnBpG
        m/Irg4Gc+Qkpm3ika7lmZJWrddBXVHI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-V-zhca3SO5S53yqUyZr9LQ-1; Wed, 26 Jul 2023 03:50:22 -0400
X-MC-Unique: V-zhca3SO5S53yqUyZr9LQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fc00d7d62cso38676875e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690357821; x=1690962621;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXtdvsYorh2jLmkQgOQxjjs6N6GWZk4UdbudzqwlXs0=;
        b=WAr0PyQVSrOxB9zuTzzXCLws6mYx0lom5clHQfu/ztQhADnxA8SG1M6mCkoawDXB4+
         zg+jlksaE7GnI0lwgqyUODS+k1svwOia+Fos9A8ky0hkI25ULB9fnaNvJOwXToCHHcHx
         tPF4Z3UV75ZIBDpYbIrBhq0qTla7NuXFlWH2V9PdZj6Uf2gge/n2g2ia7UAWCb2YCSQW
         T9qshsonhVhZYwtiOZFiQMLfs+SY5ufnmjZRk+ngZZOMtWNmbtAFIUs/8CsHpgb8LO16
         TXU3txDnSBlP2u3eGPngCmSQxoTb/12Tk5YM9GaWiRY3AjzwcCoIdLIeoNGKs4Ia8yUr
         J8Og==
X-Gm-Message-State: ABy/qLbQSSM8R46NPlJWvY865m9oXdQGhOaNqMaib36Uy66MVIaJ8FOc
        YVoVTMOzU2rDMYmoXfEAZ8EdNAodSFlsM+i3oBtzv9gfo440ledV4G/jFhfAzeuJjPeIW4aqa35
        wbP6xMpblNIemQKGYlRDUNW0+
X-Received: by 2002:a7b:c4d5:0:b0:3fd:2e89:31bd with SMTP id g21-20020a7bc4d5000000b003fd2e8931bdmr799974wmk.14.1690357821344;
        Wed, 26 Jul 2023 00:50:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE4S4B0waCmCbeErLjqmp5GKGPjgUCuHGr4eplSbJ3PIIdk1LdvZMPPowpzjgQp6MomB5Vm7A==
X-Received: by 2002:a7b:c4d5:0:b0:3fd:2e89:31bd with SMTP id g21-20020a7bc4d5000000b003fd2e8931bdmr799954wmk.14.1690357820938;
        Wed, 26 Jul 2023 00:50:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:f600:a519:c50:799b:f1e3? (p200300cbc705f600a5190c50799bf1e3.dip0.t-ipconnect.de. [2003:cb:c705:f600:a519:c50:799b:f1e3])
        by smtp.gmail.com with ESMTPSA id s23-20020a7bc397000000b003fba6a0c881sm1189152wmj.43.2023.07.26.00.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 00:50:20 -0700 (PDT)
Message-ID: <a8775e0b-a206-3ec8-7499-a3c3cfd782e2@redhat.com>
Date:   Wed, 26 Jul 2023 09:50:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     mawupeng <mawupeng1@huawei.com>, anshuman.khandual@arm.com,
        will@kernel.org
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        sudaraja@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com
References: <20230717115150.1806954-1-mawupeng1@huawei.com>
 <20230721103628.GA12601@willie-the-truck>
 <35a0dad6-4f3b-f2c3-f835-b13c1e899f8d@huawei.com>
 <c49c5f19-99d3-0a1f-88c6-03f60587b38c@arm.com>
 <732e0db0-eb41-6c58-85b7-46257b4ba0b7@redhat.com>
 <3149f5f8-7878-dfe1-5745-870fddcc1108@huawei.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH] arm64: mm: Fix kernel page tables incorrectly deleted
 during memory removal
In-Reply-To: <3149f5f8-7878-dfe1-5745-870fddcc1108@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.23 08:20, mawupeng wrote:
> 
> 
> On 2023/7/24 14:11, David Hildenbrand wrote:
>> On 24.07.23 07:54, Anshuman Khandual wrote:
>>>
>>>
>>> On 7/24/23 06:55, mawupeng wrote:
>>>>
>>>> On 2023/7/21 18:36, Will Deacon wrote:
>>>>> On Mon, Jul 17, 2023 at 07:51:50PM +0800, Wupeng Ma wrote:
>>>>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>>>>
>>>>>> During our test, we found that kernel page table may be unexpectedly
>>>>>> cleared with rodata off. The root cause is that the kernel page is
>>>>>> initialized with pud size(1G block mapping) while offline is memory
>>>>>> block size(MIN_MEMORY_BLOCK_SIZE 128M), eg, if 2G memory is hot-added,
>>>>>> when offline a memory block, the call trace is shown below,
>>
>> Is someone adding memory in 2 GiB granularity and then removing parts of it in 128 MiB granularity? That would be against what we support using the add_memory() / offline_and_remove_memory() API and that driver should be fixed instead.
> 
> Yes, this kind of situation.
> 
> The problem occurs in the following scenarios:
> 1. use mem=xxG to reserve memory.
> 2. add_momory to online memory.
> 3. offline part of the memroy via offline_and_remove_memory.
> 
> During my research, ACPI memory removal use memory_subsys_offline to offline memory section and
> this will not delete page table entry which do not trigger this kind of problem.
> 
> So I understand what you are talking about.
> 1. 3rd-party driver shouldn't use add_memory/offline_and_remove_memory to online/offline memory.
>     If it have to use, this can be achieved by driver.
> 2. memory_subsys_offline is perfered to do such thing.

No, my point is that

1) If you use add_memory() and offline_and_remove_memory() in the *same
    granularity* it has to be working, otherwise it has to be fixed.

2) If you use add_memory() and offline_and_remove_memory() in different
    granularity (especially, add_memory() in bigger granularity) , then
    change your code to do add_memory() in the same granularity.


If you run into 1), then we populated a PUD for boot memory that also 
covers yet unpopulated physical memory ranges that are later populated 
by add_memory(). If that's the case, then we can either fix it by

a) Not doing that. Use PMD tables instead for that piece of memory.

b) Detecting that that PUD still covers memory and refusing to remove
    that PUD.

c) Rejecting to hotadd memory in this situation at that location. We
    have mhp_get_pluggable_range() -> arch_get_mappable_range() to kind-
    of handle something like that.

-- 
Cheers,

David / dhildenb

