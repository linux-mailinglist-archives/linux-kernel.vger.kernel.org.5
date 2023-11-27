Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324107FA376
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjK0Ouu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjK0Our (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:50:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD5FA3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701096653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=73FvtKggjoyMfKbC/ZYzZT6bKl1Kg/bdJcdhd9AKrNs=;
        b=auwrZTu+cb0pd4Qv2iaaXJ3cTWYdbXk+JuHFvcu7CvqKs+4kuw1bW/dFw+yAzT+vWpSp+p
        tQuF0Aa4u15tInta+uiCtoAAlBDY9WuNbttZcWvyDZOpTcc0nJt8htxBeOnmcCFtUZRbtR
        agc4916oZyq3Hbtzz7GRV1zhzYvqFZE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-IeCNHBFxM9my8mWA9Stu-Q-1; Mon, 27 Nov 2023 09:50:51 -0500
X-MC-Unique: IeCNHBFxM9my8mWA9Stu-Q-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50ba80696b3so2287222e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:50:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701096649; x=1701701449;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73FvtKggjoyMfKbC/ZYzZT6bKl1Kg/bdJcdhd9AKrNs=;
        b=xIavopx3lEvY9lKfwbmsNhcLux2Ge5Zp66EMR8v2fn2qaRqREMe8oFYmhvS3WnnyWz
         xu/3PbV8NCtakpCy67EvldDpiQgugK3obUFIm01PTLIo9wDaBn0Vf4LmsVOyt+y3XqTL
         pSI/pi8c4LGVXEp//t/HGuEiYNK2yVngbiVS0Zpx8CEVGPV09byxwmXQnTC9mpf3jfVs
         w7AzvB+mrf8+aBx7zfwmnvugNCe9A/AfbYckdBpuPboffj3+AIlI/uL2zZ5XpBNW+OPN
         y3EHPhBNCQPR/P992J/wArfQvjpqexMxPzCXqokl7VCGJLenny7aFuT0yta6TBgMkQHG
         Enag==
X-Gm-Message-State: AOJu0YxcmD5y3VfYiqXS9/KXzr7ky5NlAtdH2i6ty67TEbQdkf4irD5a
        U8UUe8Awds0mYTjpym3bKqeg7Z/R7D0qVjUfh8e9RWl8bcHLxOReYgNvNFURncP1kLEQ5rqPZRc
        D6zqKpHDNVdeAKPq7nwohH192
X-Received: by 2002:ac2:4346:0:b0:50a:93f9:d09f with SMTP id o6-20020ac24346000000b0050a93f9d09fmr7046869lfl.62.1701096649546;
        Mon, 27 Nov 2023 06:50:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaEPDDSC6UEFhTnN/EmILYfQnxYUKO7/scqotzhaeDU1Eagj8lom90aNnSOn6VPZA6pZhdzA==
X-Received: by 2002:ac2:4346:0:b0:50a:93f9:d09f with SMTP id o6-20020ac24346000000b0050a93f9d09fmr7046841lfl.62.1701096649123;
        Mon, 27 Nov 2023 06:50:49 -0800 (PST)
Received: from ?IPV6:2003:cb:c745:2a00:d74a:a8c5:20b6:3ec3? (p200300cbc7452a00d74aa8c520b63ec3.dip0.t-ipconnect.de. [2003:cb:c745:2a00:d74a:a8c5:20b6:3ec3])
        by smtp.gmail.com with ESMTPSA id i16-20020a056512341000b00507cf5f9299sm1518485lfr.125.2023.11.27.06.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 06:50:48 -0800 (PST)
Message-ID: <13a2ce75-b1c0-4930-8911-36ded0b428a7@redhat.com>
Date:   Mon, 27 Nov 2023 15:50:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 10/10] selftests/mm/cow: Add tests for anonymous
 small-sized THP
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
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
 <20231122162950.3854897-11-ryan.roberts@arm.com>
 <8dd0f52c-d261-4541-930f-bd4e5921be5b@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8dd0f52c-d261-4541-930f-bd4e5921be5b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.11.23 15:02, Ryan Roberts wrote:
> On 22/11/2023 16:29, Ryan Roberts wrote:
>> Add tests similar to the existing PMD-sized THP tests, but which operate
>> on memory backed by (PTE-mapped) small-sized THP. This reuses all the
>> existing infrastructure. If the test suite detects that small-sized THP
>> is not supported by the kernel, the new tests are skipped.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   tools/testing/selftests/mm/cow.c | 71 +++++++++++++++++++++++++++++++-
>>   1 file changed, 70 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
>> index d03c453cfd5c..3efc395c7077 100644
>> --- a/tools/testing/selftests/mm/cow.c
>> +++ b/tools/testing/selftests/mm/cow.c
>> @@ -29,15 +29,49 @@
>>   #include "../../../../mm/gup_test.h"
>>   #include "../kselftest.h"
>>   #include "vm_util.h"
>> +#include "thp_settings.h"
>>
>>   static size_t pagesize;
>>   static int pagemap_fd;
>>   static size_t pmdsize;
>> +static int nr_thpsmallsizes;
>> +static size_t thpsmallsizes[20];
> 
> Off the back of some comments David made againt the previous patch [1], I'm
> proposing to rework this a bit so that ALL thp sizes are stored in this array,
> not just the non-PMD-sized sizes. This makes the changes overall a bit smaller
> and easier to understand, I think...
> 
>>   static int nr_hugetlbsizes;
>>   static size_t hugetlbsizes[10];
>>   static int gup_fd;
>>   static bool has_huge_zeropage;
>>
>> +static int sz2ord(size_t size)
>> +{
>> +	return __builtin_ctzll(size / pagesize);
>> +}
>> +
>> +static int detect_smallthp_sizes(size_t sizes[], int max)
> 
> This changes to detect_thp_sizes() and deposits all sizes in sizes[]

Just what I wanted to propose :) Makes it simpler by removing the 
"small" terminology and just detecting thp sizes.

-- 
Cheers,

David / dhildenb

