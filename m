Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5137654FA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjG0N3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjG0N3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:29:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CB32726
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690464534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wbhdfKdpjjTeU2vnbyQYy8PlRea3cn9Yeu82XaRTHfU=;
        b=XUnm8sCO6/1cf4is2pUKTrZGxz2qugGK3yHhc9J5VrdCMcrF9t28enzAaGuECQ2isT+/Gr
        NMVbiJwU5KeR7nKeo8T2JRHEEXtw8dy/hPUiRYZbXFrV+2R4FORDAzsq6xC6C6hl2KYs+P
        YDAW1e/LmyTzHAk1cfb4T1k4KCsznxo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-8ONRAzsRM5C8N0pm_fTWhQ-1; Thu, 27 Jul 2023 09:28:52 -0400
X-MC-Unique: 8ONRAzsRM5C8N0pm_fTWhQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b70bfc97e4so9225291fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690464531; x=1691069331;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbhdfKdpjjTeU2vnbyQYy8PlRea3cn9Yeu82XaRTHfU=;
        b=mBXnvdVheGCRNWa82Z71F9u4/YtiBPIDcY4uWXaf+uH7M0mRfn6suTOZehJsXovdZo
         y+Qv3m9tRdcXhOG2iWW0z7Eo6MTdDEPxthenI9kRteaT6qq/KSGwWH2fXmLk5WNJfVPj
         8WoX9O7HIFtdGI11jvTIUu2tRoFcR2aSJotYdWad8F9hO9oOvJc9IyxAjr8n/CSFZc2U
         goVTVUaXR4NTmxhl631zaD2XfZSA+Aul8qswzR2Nh1aPga/67b3OOrwityue0a/2RReU
         lw7HTJsqP+h/AX0ANEbkWAK5qwqrYZKGQhCW8+RCDkYq/HBNrexiKOx7t8j2Kg19G5iu
         DJ0A==
X-Gm-Message-State: ABy/qLaG+nNKalYGz1+5CL46cSPyc0nEfvcl+JnlW+hDP3uL5tZgAJFA
        mGJ7oBRzNzcIaWEuxG0uPLAv/d54nDUEmrkefQiYUVTArXqYwSg4q1TMC4qPXI8U77C8zuWXiqX
        zXbvX0sK+7TepSeVz8dF8tmB3
X-Received: by 2002:a2e:8181:0:b0:2b6:a7dd:e22 with SMTP id e1-20020a2e8181000000b002b6a7dd0e22mr1815730ljg.48.1690464530935;
        Thu, 27 Jul 2023 06:28:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEXr3A2S68VJWSnXoBV5s3jxQ7+gtNtauH5rriWdxVquRYU1ew5G1anWxTI4nzDXCLWRGcslg==
X-Received: by 2002:a2e:8181:0:b0:2b6:a7dd:e22 with SMTP id e1-20020a2e8181000000b002b6a7dd0e22mr1815705ljg.48.1690464530412;
        Thu, 27 Jul 2023 06:28:50 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003fc3b03e41esm6982284wmf.1.2023.07.27.06.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 06:28:49 -0700 (PDT)
Message-ID: <f49c2a51-4dd8-784b-57fa-34fb397db2b7@redhat.com>
Date:   Thu, 27 Jul 2023 15:28:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     liubo <liubo254@huawei.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hughd@google.com, willy@infradead.org
References: <20230726073409.631838-1-liubo254@huawei.com>
 <CADFyXm5nkgZjVMj3iJhqQnyA1AOmqZ-AKdaWyUD=UvZsOEOcPg@mail.gmail.com>
 <ZMJt+VWzIG4GAjeb@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] smaps: Fix the abnormal memory statistics obtained
 through /proc/pid/smaps
In-Reply-To: <ZMJt+VWzIG4GAjeb@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Therefore, when obtaining pages through the follow_trans_huge_pmd
>>> interface, add the FOLL_FORCE flag to count the pages corresponding to
>>> PROTNONE to solve the above problem.
>>>
>>
>> We really want to avoid the usage of FOLL_FORCE, and ideally limit it
>> to ptrace only.
> 
> Fundamentally when removing FOLL_NUMA we did already assumed !FORCE is
> FOLL_NUMA.  It means to me after the removal it's not possible to say in a
> gup walker that "it's not FORCEd, but I don't want to trigger NUMA but just
> get the page".
> 
> Is that what we want?  Shall we document that in FOLL_FORCE if we intended
> to enforce numa balancing as long as !FORCE?

That was the idea, yes. I could have sworn we had that at least in some 
patch description.

Back then, I played with special-casing on gup_can_follow_protnone() on 
FOLL_GET | FOLL_PIN. But it's all just best guesses.

Can always be added if deemed necessary and worth it.

Here, it's simply an abuse of that GUP function that I wasn't aware of 
-- otherwise I'd have removed that before hand.

> 
>>
>>> Signed-off-by: liubo <liubo254@huawei.com>
>>> Fixes: 474098edac26 ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()")
>>> ---
>>>   fs/proc/task_mmu.c | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>> index c1e6531cb02a..ed08f9b869e2 100644
>>> --- a/fs/proc/task_mmu.c
>>> +++ b/fs/proc/task_mmu.c
>>> @@ -571,8 +571,10 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>>>          bool migration = false;
>>>
>>>          if (pmd_present(*pmd)) {
>>> -               /* FOLL_DUMP will return -EFAULT on huge zero page */
>>> -               page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
>>> +               /* FOLL_DUMP will return -EFAULT on huge zero page
>>> +                * FOLL_FORCE follow a PROT_NONE mapped page
>>> +                */
>>> +               page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP | FOLL_FORCE);
>>>          } else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
>>>                  swp_entry_t entry = pmd_to_swp_entry(*pmd);
>>
>> Might do as an easy fix. But we really should get rid of that
>> absolutely disgusting usage of follow_trans_huge_pmd().
>>
>> We don't need 99% of what follow_trans_huge_pmd() does here.
>>
>> Would the following also fix your issue?
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 507cd4e59d07..fc744964816e 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -587,8 +587,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>>          bool migration = false;
>>
>>          if (pmd_present(*pmd)) {
>> -               /* FOLL_DUMP will return -EFAULT on huge zero page */
>> -               page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
>> +               page = vm_normal_page_pmd(vma, addr, *pmd);
>>          } else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
>>                  swp_entry_t entry = pmd_to_swp_entry(*pmd);
>>
>> It also skips the shared zeropage and pmd_devmap(),
>>
>> Otherwise, a simple pmd_page(*pmd) + is_huge_zero_pmd(*pmd) check will do, but I
>> suspect vm_normal_page_pmd() might be what we actually want to have here.
>>
>> Because smaps_pte_entry() properly checks for vm_normal_page().
> 
> There're indeed some very trivial detail in vm_normal_page_pmd() that's
> different, but maybe not so relevant.  E.g.,
> 
> 	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
> 		return -ENOMEM;

Note that we're not even passing FOLL_GET | FOLL_PIN. Because we're not 
actually doing GUP. So the refcount is not that relevant.

> 
> 	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
> 		return -EREMOTEIO;
> 
> I'm not sure whether the p2pdma page would matter in any form here.  E.g.,
> whether it can be mapped privately.

Good point, but I don't think that people messing with GUP even imagined 
that we would call that function from a !GUP place.

This was wrong from the very start. If we're not in GUP, we shouldn't 
call GUP functions.

-- 
Cheers,

David / dhildenb

