Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8047D98E2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjJ0Mr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjJ0Mr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:47:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 956D9128
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:47:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54B281424;
        Fri, 27 Oct 2023 05:48:33 -0700 (PDT)
Received: from [10.57.70.251] (unknown [10.57.70.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B5DB3F738;
        Fri, 27 Oct 2023 05:47:45 -0700 (PDT)
Message-ID: <768f86f0-9b39-424a-abc4-95a9b252e42e@arm.com>
Date:   Fri, 27 Oct 2023 13:47:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>, Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
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
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com>
 <a7781f13-21ca-48c7-99c4-22beef0400f9@arm.com>
 <fcbe9179-dcd9-4bf8-b1d1-82201880527e@arm.com>
 <a2e11353-fad8-475c-a4d1-dc1de22dde11@redhat.com>
 <CAOUHufa9CyfRaMFXWtFWPG22Z9Zf9hZZWbZdTke6THimtbPzRQ@mail.gmail.com>
 <ce723223-9751-4d57-af2d-86d30b2dd16a@arm.com>
 <f83b6fcd-71d8-442f-87d9-f95dd2ab2344@redhat.com>
 <644b1519-b44f-4128-8e5e-52ee5e02b404@arm.com>
 <53afef72-69a1-4dd7-84d5-a41f5d2996c3@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <53afef72-69a1-4dd7-84d5-a41f5d2996c3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2023 13:29, David Hildenbrand wrote:
> On 27.10.23 14:27, Ryan Roberts wrote:
>> On 26/10/2023 16:19, David Hildenbrand wrote:
>>> [...]
>>>
>>>>>> Hi,
>>>>>>
>>>>>> I wanted to remind people in the THP cabal meeting, but that either
>>>>>> didn't happen or zoomed decided to not let me join :)
>>>>
>>>> I didn't make it yesterday either - was having to juggle child care.
>>>
>>> I think it didn't happen, or started quite late (>20 min).
>>>
>>>>
>>>>>>
>>>>>>>
>>>>>>> It's been a week since the mm alignment meeting discussion we had around
>>>>>>> prerequisites and the ABI. I haven't heard any further feedback on the ABI
>>>>>>> proposal, so I'm going to be optimistic and assume that nobody has found any
>>>>>>> fatal flaws in it :).
>>>>>>
>>>>>> After saying in the call probably 10 times that people should comment
>>>>>> here if there are reasonable alternatives worth discussing, call me
>>>>>> "optimistic" as well; but, it's only been a week and people might still
>>>>>> be thinking about this/
>>>>>>
>>>>>> There were two things discussed in the call:
>>>>>>
>>>>>> * Yu brought up "lists" so we can have priorities. As briefly discussed
>>>>>>      in the  call, this (a) might not be needed right now in an initial
>>>>>>      version;  (b) the kernel might be able to handle that (or many cases)
>>>>>>      automatically, TBD. Adding lists now would kind-of set the semantics
>>>>>>      of that interface in stone. As you describe below, the approach
>>>>>>      discussed here could easily be extended to cover priorities, if need
>>>>>>      be.
>>>>>
>>>>> I want to expand on this: the argument that "if you could allocate a
>>>>> higher order you should use it" is too simplistic. There are many
>>>>> reasons in addition to the one above that we want to "fall back" to
>>>>> higher orders, e.g., those higher orders are not on PCP or from the
>>>>> local node. When we consider the sequence of orders to try, user
>>>>> preference is just one of the parameters to the cost function. The
>>>>> bottom line is that I think we should all agree that there needs to be
>>>>> a cost function down the road, whatever it looks like. Otherwise I
>>>>> don't know how we can make "auto" happen.
>>>
>>> I agree that there needs to be a cost function, and as pagecache showed that's
>>> independent of initial enablement.
>>>
>>>>
>>>> I don't dispute that this sounds like it could be beneficial, but I see it as
>>>> research to happen further down the road (as you say), and we don't know what
>>>> that research might conclude. Also, I think the scope of this is bigger than
>>>> anonymous memory - you would also likely want to look at the policy for page
>>>> cache folio order too, since today that's based solely on readahead. So I
>>>> see it
>>>> as an optimization that is somewhat orthogonal to small-sized THP.
>>>
>>> Exactly my thoughts.
>>>
>>> The important thing is that we should plan ahead that we still have the option
>>> to let the admin configure if we cannot make this work automatically in the
>>> kernel.
>>>
>>> What we'll need, nobody knows. Maybe it's a per-size priority, maybe it's a
>>> single global toggle.
>>>
>>>>
>>>> The proposed interface does not imply any preference order - it only states
>>>> which sizes the user wants the kernel to select from, so I think there is lots
>>>> of freedom to change this down the track if the kernel wants to start using the
>>>> buddy allocator's state as a signal to make its decisions.
>>>
>>> Yes.
>>>
>>> [..]
>>>
>>>>>> Jup, same opinion here. But again, I'm very happy to hear other
>>>>>> alternatives and why they are better.
>>>>>
>>>>> I'm not against David's proposal but I want to hear a lot more about
>>>>> "lots of flexibility for growth" before I'm fully convinced.
>>>>
>>>> My point was that in an abstract sense, there are properties a user may wish to
>>>> apply individually to a size, which is catered for by having a per-size
>>>> directory into which we can add more files if/when requirements for new
>>>> per-size
>>>> properties arise. There are also properties that may be applied globally, for
>>>> which we have the top-level transparent_hugepage directory where properties can
>>>> be extended or added.
>>>
>>> Exactly, well said.
>>>
>>>>
>>>> For your case around tighter integration with the buddy allocator, I could
>>>> imagine a per-size file allowing the user to specify if the kernel should allow
>>>> splitting a higher order to make a THP of that size (I'm not suggesting
>>>> that's a
>>>> good idea, I'm just pointing out that this sort of thing is possible with the
>>>> interface). And we have discussed how the global enabled prpoerty could be
>>>> extended to support "auto" [1].
>>>>
>>>> But perhaps what we really need are lots more ideas for future directions for
>>>> small-sized THP to allow us to evaluate this interface more widely.
>>>
>>> David R. motivated a future size-aware setting of the defrag option. As
>>> discussed we might want something similar to shmem_enable. What will happen with
>>> khugepaged, nobody knows yet :)
>>>
>>> I could imagine exposing per-size boolean read-only properties like
>>> "native-hw-size" (PMD, cont-pte). But these things require much more thought.
>>
>> FWIW, the reason I opted for the "recommend" special case in the v5 posting was
>> because that felt like an easy thing to also add to the command line in future.
>> Having a separate file, native-hw-size, that the user has to read then enable
>> through another file is not very command-line friendly, if you want the
>> hw-preferred size(s) enabled from boot.
> 
> Jup. I strongly suspect distributions will just have their setup script to
> handle such things, though.

OK fair enough.

> 
>>
>> Maybe the wider observation is "how does the proposed interface translate to the
>> kernel command line if needed in future?".
> 
> I guess in the distant future, "auto" is what we want.

Looks like hugetlb solves this with a magic tuple, where hugepagesz sets the
"directory" for the following properties. So if we did need to support per-size
properties on the command line, we have president to follow:

  hugepagesz=X hugepages=Y

> 

