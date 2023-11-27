Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F8F7FA254
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjK0ORz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjK0ORa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:17:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94D272112
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:11:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0B182F4;
        Mon, 27 Nov 2023 06:12:44 -0800 (PST)
Received: from [10.57.73.191] (unknown [10.57.73.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D4BD3F6C4;
        Mon, 27 Nov 2023 06:11:54 -0800 (PST)
Message-ID: <f3008ba2-82c2-47e3-9153-139a9442123b@arm.com>
Date:   Mon, 27 Nov 2023 14:11:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 09/10] selftests/mm/cow: Generalize
 do_run_with_thp() helper
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <20231122162950.3854897-10-ryan.roberts@arm.com>
 <ead82cbe-19c9-43ce-9f28-7ced118b130a@redhat.com>
 <15c288aa-feab-4d3a-af33-b87481eaffe3@arm.com>
 <1ebb9a53-63ee-430c-ba65-8e48eff6d25c@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <1ebb9a53-63ee-430c-ba65-8e48eff6d25c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2023 13:59, David Hildenbrand wrote:
>>>
>>>> +    pmdsize = read_pmd_pagesize();
>>>> +    if (pmdsize)
>>>> +        ksft_print_msg("[INFO] detected PMD-mapped THP size: %zu KiB\n",
>>>
>>> Maybe simply: "detected PMD size". Zes, we read it via the THP interface, but
>>> that shouldn't matter much.
>>
>> Err, just want to clarify what you are suggesting. With the current patch you
>> will see something like:
> 
> Not with this patch, but with the other ones, yes :)

Yep, we are on the same page (folio)...

> 
>>
>> [INFO] detected PMD-mapped THP size: 2048 KiB
>> [INFO] detected small-sized THP size: 64 KiB
>> [INFO] detected small-sized THP size: 128 KiB
>> ...
>> [INFO] detected small-sized THP size: 1024 KiB
>>
>>
>> Are you suggesting something like this:
>>
>> [INFO] detected PMD size: 2048 KiB
>> [INFO] detected THP size: 64 KiB
>> [INFO] detected THP size: 128 KiB
>> ...
>> [INFO] detected THP size: 2048 KiB
>>
> 
> Yes. If you'd detect that 2M is actually disabled, you could still log the PMD
> size only.

Note that in the final patch, where I test the other THP sizes, I'm not
detecting which sizes the sysadmin has enabled, I'm detecting the set of sizes
that can be enabled, then explicitly enabling the size (exclusively) when I test
it. So there is no chance of reading PMD size but not having 2M THP. Minor point
though.

> 
> So for this patch only as a preparation
> 
> [INFO] detected PMD size: 2048 KiB
> [INFO] detected THP size: 2048 KiB
> 
> Just a thought.

Yep this is exactly how I've just reworked it.

