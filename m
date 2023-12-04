Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9441C802E84
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjLDJ1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjLDJ1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:27:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F3BBD8;
        Mon,  4 Dec 2023 01:27:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 702AA1650;
        Mon,  4 Dec 2023 01:28:38 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A46113F6C4;
        Mon,  4 Dec 2023 01:27:47 -0800 (PST)
Message-ID: <744be4e0-48e0-4c77-825c-711386dd205f@arm.com>
Date:   Mon, 4 Dec 2023 09:27:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Content-Language: en-GB
To:     Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
References: <20231121171643.3719880-1-surenb@google.com>
 <20231121171643.3719880-6-surenb@google.com>
 <b3c882d2-0135-430c-8179-784f78be0902@arm.com>
 <a41c759f-78d8-44ed-b708-1bb737a8e6c1@redhat.com>
 <cb3d3b12-abf3-4eda-8d9a-944684d05505@arm.com>
 <ccdb1080-7a2e-4f98-a4e8-e864fa2db299@redhat.com>
 <CAJuCfpHS63bXkRGE1_G4z-2fDe72BeLka8t5ioSg2OXjbUrHXg@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAJuCfpHS63bXkRGE1_G4z-2fDe72BeLka8t5ioSg2OXjbUrHXg@mail.gmail.com>
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

On 04/12/2023 04:09, Suren Baghdasaryan wrote:
> On Sat, Dec 2, 2023 at 2:11 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 02.12.23 09:04, Ryan Roberts wrote:
>>> On 01/12/2023 20:47, David Hildenbrand wrote:
>>>> On 01.12.23 10:29, Ryan Roberts wrote:
>>>>> On 21/11/2023 17:16, Suren Baghdasaryan wrote:
>>>>>> Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
>>>>>> into destination buffer while checking the contents of both after
>>>>>> the move. After the operation the content of the destination buffer
>>>>>> should match the original source buffer's content while the source
>>>>>> buffer should be zeroed. Separate tests are designed for PMD aligned and
>>>>>> unaligned cases because they utilize different code paths in the kernel.
>>>>>>
>>>>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>>>>> ---
>>>>>>    tools/testing/selftests/mm/uffd-common.c     |  24 +++
>>>>>>    tools/testing/selftests/mm/uffd-common.h     |   1 +
>>>>>>    tools/testing/selftests/mm/uffd-unit-tests.c | 189 +++++++++++++++++++
>>>>>>    3 files changed, 214 insertions(+)
>>>>>>
>>>>>> diff --git a/tools/testing/selftests/mm/uffd-common.c
>>>>>> b/tools/testing/selftests/mm/uffd-common.c
>>>>>> index fb3bbc77fd00..b0ac0ec2356d 100644
>>>>>> --- a/tools/testing/selftests/mm/uffd-common.c
>>>>>> +++ b/tools/testing/selftests/mm/uffd-common.c
>>>>>> @@ -631,6 +631,30 @@ int copy_page(int ufd, unsigned long offset, bool wp)
>>>>>>        return __copy_page(ufd, offset, false, wp);
>>>>>>    }
>>>>>>    +int move_page(int ufd, unsigned long offset, unsigned long len)
>>>>>> +{
>>>>>> +    struct uffdio_move uffdio_move;
>>>>>> +
>>>>>> +    if (offset + len > nr_pages * page_size)
>>>>>> +        err("unexpected offset %lu and length %lu\n", offset, len);
>>>>>> +    uffdio_move.dst = (unsigned long) area_dst + offset;
>>>>>> +    uffdio_move.src = (unsigned long) area_src + offset;
>>>>>> +    uffdio_move.len = len;
>>>>>> +    uffdio_move.mode = UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
>>>>>> +    uffdio_move.move = 0;
>>>>>> +    if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
>>>>>> +        /* real retval in uffdio_move.move */
>>>>>> +        if (uffdio_move.move != -EEXIST)
>>>>>> +            err("UFFDIO_MOVE error: %"PRId64,
>>>>>> +                (int64_t)uffdio_move.move);
>>>>>
>>>>> Hi Suren,
>>>>>
>>>>> FYI this error is triggering in mm-unstable (715b67adf4c8):
>>>>>
>>>>> Testing move-pmd on anon... ERROR: UFFDIO_MOVE error: -16 (errno=16,
>>>>> @uffd-common.c:648)
>>>>>
>>>>> I'm running in a VM on Apple M2 (arm64). I haven't debugged any further, but
>>>>> happy to go deeper if you can direct.
>>>>
>>>> Does it trigger reliably? Which pagesize is that kernel using?
>>>
>>> Yep, although very occasionally it fails with EAGAIN. 4K kernel; see other email
>>> for full config.
>>>
>>>>
>>>> I can spot that uffd_move_pmd_test()/uffd_move_pmd_handle_fault() uses
>>>> default_huge_page_size(), which reads the default hugetlb size.
>>>
>>> My kernel command line is explicitly seting the default huge page size to 2M.
>>>
>>
>> Okay, so that likely won't affect it.
>>
>> I can only guess that it has to do with the alignment of the virtual
>> area we are testing with, and that we do seem to get more odd patterns
>> on arm64.
>>
>> uffd_move_test_common() is a bit more elaborate, but if we aligned the
>> src+start area up, surely "step_count" cannot be left unmodified?
>>
>> So assuming we get either an unaligned source or an unaligned dst from
>> mmap(), I am not convinced that we won't be moving areas that are not
>> necessarily fully backed by PMDs and maybe don't even fall into the VMA
>> of interest?
>>
>> Not sure if that could trigger the THP splitting issue, though.
>>
>> But I just quickly scanned that test setup, could be I am missing
>> something. It might make sense to just print the mmap'ed range and the
>> actual ranges we are trying to move. Maybe something "obvious" can be
>> observed.
> 
> I was able to reproduce the issue on an Android device and after
> implementing David's suggestions to split the large folio and after
> replacing default_huge_page_size() with read_pmd_pagesize(), the
> move-pmd test started working for me. Ryan, could you please apply
> attached patches (over mm-unstable) and try the test again?

Yep, all fixed with those patches!


> Thanks,
> Suren.
> 
>>
>> --
>> Cheers,
>>
>> David / dhildenb
>>

