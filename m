Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD3078DFE2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242800AbjH3TUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243238AbjH3K2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:28:13 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C88C0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:27:45 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401f503b529so2284905e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693391264; x=1693996064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RCcJI/XBAURtymMp8+JEIoJu+kdAE47YPWJFfv/6wUE=;
        b=JeyJWy7alrW8KSusz4SxmXeakit5Fb0CBkeNuXlF4SU/wRXZYqNXzCpz9vuF7ACvJ9
         qU7C1uXhIYkmPhV7qNArymO+MdJe/YLzSmHg8wKkn16GFMHmE6iicepFYGpCUN20U13Q
         33t+A7FXw0NtBsvsQgNzBiAOSEWBe499m5Qkkragq13EQ7EwQufYuLpJKOpK6cmh8uYs
         4EE9tWYiPGBUl73k5PpZ4k3CcrBJVpyHwJex8hUen99CmY8i3JOTvxLiowutATKtYs2U
         RjXyCvaVXq+tzmJjjjMnwcnnXA6OgRDmBz2S15rMWha5t7q+5YaKQ4Z9RrXDzeaPeDGH
         q1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693391264; x=1693996064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCcJI/XBAURtymMp8+JEIoJu+kdAE47YPWJFfv/6wUE=;
        b=R2UqEbDLX3xUrP9JnDGEvUoEePXuNHn3qaId0XcznloeI2wXNVYcdq7THjlnR+8+4N
         iOKtWT3CBsvvxJavXdgfMvBZaFC+32wxhF7U/MNuJ8VSWKPtJTS2Y7Ng9cy8Tks/Pscr
         BqKHshwa6whdPGFQ8Lmg0AezpSXS/EZduMJvYzSDnWxxXEsVaJvEXVCHM9y6B6EdEDqL
         gKyvh6QyPul6E8dFJ+1Hniw2qE+sMjL9aUlNiWogKvCvYSFrQD1eVvos46jCQhOKZ1yC
         joj4zeG/FlQW8E2/nfHqNsbRZfsTMcMkTP1rC0bDIG8D1VquovIADl2rdn+AXGppCiF4
         QmFQ==
X-Gm-Message-State: AOJu0Yw+fooogHkGZbaEAzl0iixuZ8UQ8VjRqG9ny6ycdAl6La3ZTbRD
        uwOTxzdLA1FUqdZcHiqh/0+mrQ==
X-Google-Smtp-Source: AGHT+IEYjjd9P67gZXCIXw5Iz2P1HdlDip97YL3UJ8sR7ysJqjWDtT6YKwgJDOnUBVB76xMPDLt7lQ==
X-Received: by 2002:a05:600c:2108:b0:3fd:3006:410b with SMTP id u8-20020a05600c210800b003fd3006410bmr1574444wml.34.1693391264419;
        Wed, 30 Aug 2023 03:27:44 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b5c7:0:7a7d:3dd8:1d8:b0bc? ([2a02:6b6a:b5c7:0:7a7d:3dd8:1d8:b0bc])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b0031ae2a7adb5sm16044922wrt.85.2023.08.30.03.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 03:27:43 -0700 (PDT)
Message-ID: <a5ec4389-e7c1-2af5-2a47-495bdcac149c@bytedance.com>
Date:   Wed, 30 Aug 2023 11:27:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [v3 4/4] mm: hugetlb: Skip initialization of
 gigantic tail struct pages if freed by HVO
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com, mgorman@techsingularity.net,
        akpm@linux-foundation.org
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
 <20230825111836.1715308-5-usama.arif@bytedance.com>
 <486CFF93-3BB1-44CD-B0A0-A47F560F2CAE@linux.dev>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <486CFF93-3BB1-44CD-B0A0-A47F560F2CAE@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/08/2023 12:33, Muchun Song wrote:
> 
> 
>> On Aug 25, 2023, at 19:18, Usama Arif <usama.arif@bytedance.com> wrote:
>>
>> The new boot flow when it comes to initialization of gigantic pages
>> is as follows:
>> - At boot time, for a gigantic page during __alloc_bootmem_hugepage,
>> the region after the first struct page is marked as noinit.
>> - This results in only the first struct page to be
>> initialized in reserve_bootmem_region. As the tail struct pages are
>> not initialized at this point, there can be a significant saving
>> in boot time if HVO succeeds later on.
>> - Later on in the boot, HVO is attempted. If its successful, only the first
>> HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct pages
>> after the head struct page are initialized. If it is not successful,
>> then all of the tail struct pages are initialized.
>>
>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> 
> This edition is simpler than before ever, thanks for your work.
> 
> There is premise that other subsystems do not access vmemmap pages
> before the initialization of vmemmap pages associated withe HugeTLB
> pages allocated from bootmem for your optimization. However, IIUC, the
> compacting path could access arbitrary struct page when memory fails
> to be allocated via buddy allocator. So we should make sure that
> those struct pages are not referenced in this routine. And I know
> if CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, it will encounter
> the same issue, but I don't find any code to prevent this from
> happening. I need more time to confirm this, if someone already knows,
> please let me know, thanks. So I think HugeTLB should adopt the similar
> way to prevent this.
> 
> Thanks.
> 

Thanks for the reviews.

So if I understand it correctly, the uninitialized pages due to the 
optimization in this patch and due to DEFERRED_STRUCT_PAGE_INIT should 
be treated in the same way during compaction. I see that in 
isolate_freepages during compaction there is a check to see if PageBuddy 
flag is set and also there are calls like __pageblock_pfn_to_page to 
check if the pageblock is valid.

But if the struct page is uninitialized then they would contain random 
data and these checks could pass if certain bits were set?

Compaction is done on free list. I think the uninitialized struct pages 
atleast from DEFERRED_STRUCT_PAGE_INIT would be part of freelist, so I 
think their pfn would be considered for compaction.

Could someone more familiar with DEFERRED_STRUCT_PAGE_INIT and 
compaction confirm how the uninitialized struct pages are handled when 
compaction happens? Thanks!

Usama
