Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95E2770761
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjHDR6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjHDR55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:57:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F9F4C05
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691171825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SvrjTDcs8djDadP7h1Zm3W5QUjzYJ5c3VH4x+NLfDfU=;
        b=U5eLHbsiAM3rQ8ZSO0jdwKU9zZ6JU/fVfP0ycYa5XsDxXVPx/J5tpbtjQzcgIX5RP9VYCi
        MDfevjY5KWb16d25Kwf0OERHpbV85gbsv78bkNlPAZnQR3Q845Va4RYjbbioyyhuY/OXaF
        MXPZ4TMF9nLagx1A+MIzrCj9lnbx37I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-xz78VJgeOfmdQnFqjp5GwA-1; Fri, 04 Aug 2023 13:56:47 -0400
X-MC-Unique: xz78VJgeOfmdQnFqjp5GwA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-317b30fedb0so1229881f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 10:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691171790; x=1691776590;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SvrjTDcs8djDadP7h1Zm3W5QUjzYJ5c3VH4x+NLfDfU=;
        b=Ueziq4fjX3olYRFwH0xYTusp180+n58//dlnfENgS4xOccMgla0WByF9+gEsZQwTYI
         /4WF01T/QtYtfaGSyJjT7YHv87uBc43rfDTWFygqBhUWcK2bJR/+wbg4urePnb6Ig4iz
         SYFc5fVVxoovJRqnKTEHpK2xBqzrk/I8VbpxjNZEssMOf6qpIxD9lzURqauzzpE07usQ
         j3ici0amrCArbZ9Ors9pigG09WTVAr9FQoQgQ4JchOj4D2flx3UE0xspoFOQvG/tP4C8
         DKV9K1OyRRqAfGpxQuKBTi2uywm4bS0vB4141+AhTbJFu+SOdPjN+Nw1hbZ9EaigPeOp
         yU4g==
X-Gm-Message-State: AOJu0YyD9tu7IhAhOCNfz/PxEyOUrJw9i0ZbYN61+5orNdOxXULcngAF
        w9wEO4pbQvjD7WH0IgWLw+PpGJgf0NXgmG2ac8My1qojy2WVrDjT8OZcaC8UqxAjzuNb54DrsqQ
        BOfGiy91khbJb7cnH0WExjwNJ
X-Received: by 2002:a5d:6844:0:b0:313:eaf5:515 with SMTP id o4-20020a5d6844000000b00313eaf50515mr1604581wrw.6.1691171790520;
        Fri, 04 Aug 2023 10:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3eXsxv8k5tyLwX8sSg2B1xCMehT/x7CzauR+iGPFIENNB/npkytR7rq7w+vcRW+JFx9Ra1A==
X-Received: by 2002:a5d:6844:0:b0:313:eaf5:515 with SMTP id o4-20020a5d6844000000b00313eaf50515mr1604569wrw.6.1691171790149;
        Fri, 04 Aug 2023 10:56:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2d:8e00:a20e:59bc:3c13:4806? (p200300d82f2d8e00a20e59bc3c134806.dip0.t-ipconnect.de. [2003:d8:2f2d:8e00:a20e:59bc:3c13:4806])
        by smtp.gmail.com with ESMTPSA id y6-20020a05600c364600b003fe2a40d287sm2942118wmq.1.2023.08.04.10.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 10:56:29 -0700 (PDT)
Message-ID: <859496c5-3971-0b65-c297-d29083719a75@redhat.com>
Date:   Fri, 4 Aug 2023 19:56:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20230803143208.383663-1-david@redhat.com>
 <20230803143208.383663-7-david@redhat.com> <ZMv6cZH2PdyeTmw1@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 6/7] selftest/mm: ksm_functional_tests: test in
 mmap_and_merge_range() if anything got merged
In-Reply-To: <ZMv6cZH2PdyeTmw1@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.23 21:05, Peter Xu wrote:
> On Thu, Aug 03, 2023 at 04:32:07PM +0200, David Hildenbrand wrote:
>> Let's extend mmap_and_merge_range() to test if anything in the current
>> process was merged. range_maps_duplicates() is too unreliable for that
>> use case, so instead look at KSM stats.
>>
>> Trigger a complete unmerge first, to cleanup the stable tree and
>> stabilize accounting of merged pages.
>>
>> Note that we're using /proc/self/ksm_merging_pages instead of
>> /proc/self/ksm_stat, because that one is available in more existing
>> kernels.
>>
>> If /proc/self/ksm_merging_pages can't be opened, we can't perform any
>> checks and simply skip them.
>>
>> We have to special-case the shared zeropage for now. But the only user
>> -- test_unmerge_zero_pages() -- performs its own merge checks.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 

Hi Peter,

thanks for the review!

> Acked-by: Peter Xu <peterx@redhat.com>
> 
> One nitpick:
> 
>> ---
>>   .../selftests/mm/ksm_functional_tests.c       | 47 +++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
>> index 0de9d33cd565..cb63b600cb4f 100644
>> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
>> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
>> @@ -30,6 +30,7 @@
>>   static int ksm_fd;
>>   static int ksm_full_scans_fd;
>>   static int proc_self_ksm_stat_fd;
>> +static int proc_self_ksm_merging_pages_fd;
>>   static int ksm_use_zero_pages_fd;
>>   static int pagemap_fd;
>>   static size_t pagesize;
>> @@ -88,6 +89,22 @@ static long get_my_ksm_zero_pages(void)
>>   	return my_ksm_zero_pages;
>>   }
>>   
>> +static long get_my_merging_pages(void)
>> +{
>> +	char buf[10];
>> +	ssize_t ret;
>> +
>> +	if (proc_self_ksm_merging_pages_fd < 0)
>> +		return proc_self_ksm_merging_pages_fd;
> 
> Better do the fds check all in main(), e.g. not all callers below considers
> negative values, so -1 can pass "if (get_my_merging_pages())" etc.

The two existing callers should be handling it correctly:

if (get_my_merging_pages() > 0)
	-> fail

if (val && !get_my_merging_pages()
	-> fail

Both will pass on negative values, unless I am missing something.

I tried to keep the test working also on older kernels where 
ksm_merging_pages does not exist yet (it's ~1 year old).


Anyhow, if you think it's better to make the test fail on these setups, 
I can change it.

-- 
Cheers,

David / dhildenb

