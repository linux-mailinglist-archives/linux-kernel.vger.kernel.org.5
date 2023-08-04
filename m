Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E173576FB3D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjHDHe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbjHDHeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462EE4EEA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 00:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691134313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7tYJnT3cxc/kGIS3sYAfOL4993DmXFImA53mCH0lAYI=;
        b=iBZtkKj1hQGjzDBO6/RiYA3/WluBRldixXDERI5BhDpecfyTLVSa7nAtP0gSnPi9Coha+D
        A/PRyuD7a7yUKmJM37mwG91j0loaNvWR9twA4LWq4mOaMKtKPZGyq/V2vB57rkgdvTzaFe
        P90yuWJShx3TYNeuVCbhCM3IvhpGAog=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-jPxz93qDONytfWkDcteWmg-1; Fri, 04 Aug 2023 03:31:52 -0400
X-MC-Unique: jPxz93qDONytfWkDcteWmg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9b1a21b93so20873601fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 00:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691134311; x=1691739111;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tYJnT3cxc/kGIS3sYAfOL4993DmXFImA53mCH0lAYI=;
        b=AfOFbAC9VHG10WNHyvXxOwAli9Y2YYDJhg3ohyiD4HnaX3wVjOYHGWcYqlRbV3OadQ
         MZtiHwV8zR43+IL6zBtZYEpptGzA+DTeH1miSw7UebTeyqfJHd3L8UC55uUh5zxP+Uh0
         D/zXIByYotBPCOweXJZLL51TjtUiqzpcWd7Q2Ezio1ASN0cZF5vCALaXhqs/RyknURTu
         gMIHSGuZQD6eA6VBBHLiPGZlmF3Gx5P+L8Uvgb8tmiX2jiz+H4T2nEDGAstcOpYdackM
         FcEHQvwojeQC1veUd4bXWd6XK2m25+hzgflsiaiRELVzAHBS78+l3RuClsD6aERuM1a1
         K7qg==
X-Gm-Message-State: AOJu0YxHk4m3N825n97sCdFaWHoBi4iXAwo2zkzJMXOO8GI+bysFqwDW
        q2p6r3IdGrCl3gmgG7Hf20MlSPjXWeEcn5YacYJknNRCD9KR5NvpUQwskcWbIw3dNSAj3rQbZ8I
        6NiQy4BUmv2XvHdgDjmsSTzOw
X-Received: by 2002:a2e:889a:0:b0:2b9:da28:c508 with SMTP id k26-20020a2e889a000000b002b9da28c508mr814603lji.31.1691134310795;
        Fri, 04 Aug 2023 00:31:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcAu4SAakWypTmqUgc+Mi9ppkRcA8Zxzf9LXO0fzlK64shZVoEjCinM64oEX/iNnRxYtwlrg==
X-Received: by 2002:a2e:889a:0:b0:2b9:da28:c508 with SMTP id k26-20020a2e889a000000b002b9da28c508mr814576lji.31.1691134310302;
        Fri, 04 Aug 2023 00:31:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c724:5900:10b9:2373:11c6:216c? (p200300cbc724590010b9237311c6216c.dip0.t-ipconnect.de. [2003:cb:c724:5900:10b9:2373:11c6:216c])
        by smtp.gmail.com with ESMTPSA id v20-20020a7bcb54000000b003fbfef555d2sm5996401wmj.23.2023.08.04.00.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 00:31:49 -0700 (PDT)
Message-ID: <75996f6b-63fe-4878-c19d-bf35ee2ad20b@redhat.com>
Date:   Fri, 4 Aug 2023 09:31:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] don't use mapcount() to check large folio sharing
Content-Language: en-US
To:     "Yin, Fengwei" <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org,
        vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
        minchan@kernel.org, shy828301@gmail.com,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
 <3bbfde16-ced1-dca8-6a3f-da893e045bc5@arm.com>
 <56c8f4f9-b54b-b0bb-250c-ec8643accfc7@intel.com>
 <3541d2de-5cf8-2f84-8153-277e2bfc0101@arm.com>
 <5f98748a-97ca-6426-1e24-a5675da75381@intel.com>
 <a590da86-0c42-7d46-d320-c661a59a46c1@arm.com>
 <837ba176-c97f-f81b-c044-eb6aa3d88bb7@intel.com>
 <CAOUHufY9EQ70Pn-n2zVa9=Gm3-WHxxphp7VHia4qv9x2domdbg@mail.gmail.com>
 <40d49276-fae9-e538-61cf-64bb79233bc3@intel.com>
 <CAOUHufbcAJWUoVuCYtaDZKdcw+JPWVV0EiB=JcDvz1Jt_Au2Tw@mail.gmail.com>
 <45457815-66c4-029f-42f9-6c377e4eb1e3@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <45457815-66c4-029f-42f9-6c377e4eb1e3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.23 02:17, Yin, Fengwei wrote:
> 
> 
> On 8/4/2023 7:38 AM, Yu Zhao wrote:
>> On Thu, Aug 3, 2023 at 5:27 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>
>>>
>>>
>>> On 8/4/2023 4:46 AM, Yu Zhao wrote:
>>>> On Wed, Aug 2, 2023 at 6:56 AM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>>
>>>>> "
>>>>>
>>>>> On 8/2/2023 8:49 PM, Ryan Roberts wrote:
>>>>>> On 02/08/2023 13:42, Yin, Fengwei wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 8/2/2023 8:40 PM, Ryan Roberts wrote:
>>>>>>>> On 02/08/2023 13:35, Yin, Fengwei wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 8/2/2023 6:27 PM, Ryan Roberts wrote:
>>>>>>>>>> On 28/07/2023 17:13, Yin Fengwei wrote:
>>>>>>>>>>> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
>>>>>>>>>>> folio_mapcount() is used to check whether the folio is shared. But it's
>>>>>>>>>>> not correct as folio_mapcount() returns total mapcount of large folio.
>>>>>>>>>>>
>>>>>>>>>>> Use folio_estimated_sharers() here as the estimated number is enough.
>>>>>>>>>>>
>>>>>>>>>>> Yin Fengwei (2):
>>>>>>>>>>>    madvise: don't use mapcount() against large folio for sharing check
>>>>>>>>>>>    madvise: don't use mapcount() against large folio for sharing check
>>>>>>>>>>>
>>>>>>>>>>>   mm/huge_memory.c | 2 +-
>>>>>>>>>>>   mm/madvise.c     | 6 +++---
>>>>>>>>>>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> As a set of fixes, I agree this is definitely an improvement, so:
>>>>>>>>>>
>>>>>>>>>> Reviewed-By: Ryan Roberts
>>>>>>>>> Thanks.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> But I have a couple of comments around further improvements;
>>>>>>>>>>
>>>>>>>>>> Once we have the scheme that David is working on to be able to provide precise
>>>>>>>>>> exclusive vs shared info, we will probably want to move to that. Although that
>>>>>>>>>> scheme will need access to the mm_struct of a process known to be mapping the
>>>>>>>>>> folio. We have that info, but its not passed to folio_estimated_sharers() so we
>>>>>>>>>> can't just reimplement folio_estimated_sharers() - we will need to rework these
>>>>>>>>>> call sites again.
>>>>>>>>> Yes. This could be extra work. Maybe should delay till David's work is done.
>>>>>>>>
>>>>>>>> What you have is definitely an improvement over what was there before. And is
>>>>>>>> probably the best we can do without David's scheme. So I wouldn't delay this.
>>>>>>>> Just pointing out that we will be able to make it even better later on (if
>>>>>>>> David's stuff goes in).
>>>>>>> Yes. I agree that we should wait for David's work ready and do fix based on that.
>>>>>>
>>>>>> I was suggesting the opposite - not waiting. Then we can do separate improvement
>>>>>> later.
>>>>> Let's wait for David's work ready.
>>>>
>>>> Waiting is fine as long as we don't miss the next merge window -- we
>>>> don't want these two bugs to get into another release. Also I think we
>>>> should cc stable, since as David mentioned, they have been causing
>>>> selftest failures.
>>>
>>> Stable was CCed.
>>
>> Need to add the "Cc: stable@vger.kernel.org" tag:
>> Documentation/process/stable-kernel-rules.rst
> OK. Thanks for clarification. I totally mis-understanded this. :).
> 
> I'd like to wait for answer from Andrew whether these patches are suitable
> for stable (I suppose you think so) branch.

Note that the COW test does not fail -- it skips -- but the behavir changed:

$ ./cow
# [INFO] detected THP size: 2048 KiB
# [INFO] detected hugetlb page size: 2048 KiB
# [INFO] detected hugetlb page size: 1048576 KiB
# [INFO] huge zeropage is enabled
TAP version 13
1..190
# [INFO] Anonymous memory tests in private mappings
# [RUN] Basic COW after fork() ... with base page
ok 1 No leak from parent into child
# [RUN] Basic COW after fork() ... with swapped out base page
ok 2 No leak from parent into child
# [RUN] Basic COW after fork() ... with THP
ok 3 No leak from parent into child
# [RUN] Basic COW after fork() ... with swapped-out THP
ok 4 No leak from parent into child
# [RUN] Basic COW after fork() ... with PTE-mapped THP
ok 5 No leak from parent into child
# [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# [RUN] Basic COW after fork() ... with single PTE of THP
ok 7 No leak from parent into child
# [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
ok 8 No leak from parent into child
# [RUN] Basic COW after fork() ... with partially mremap()'ed THP
ok 9 No leak from parent into child
# [RUN] Basic COW after fork() ... with partially shared THP
ok 10 No leak from parent into child
...

Observe how patch #6 skips because the MADV_PAGEOUT was not effective (which might have happened due to other reasons as well, thus no failure).

The code that broke it is

commit 07e8c82b5eff8ef34b74210eacb8d9c4a2886b82
Author: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Date:   Wed Dec 21 10:08:46 2022 -0800

     madvise: convert madvise_cold_or_pageout_pte_range() to use folios
     
     This change removes a number of calls to compound_head(), and saves
     1729 bytes of kernel text.
     
     Link: https://lkml.kernel.org/r/20221221180848.20774-3-vishal.moola@gmail.com
     Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
     Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
     Cc: SeongJae Park <sj@kernel.org>
     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>


Ever since v6.3.

The simplest way to fix it would be to revert the page_mapcount() -> folio_mapcount(),
conversion.


Probably all that is information worth having in the patch description.

-- 
Cheers,

David / dhildenb

