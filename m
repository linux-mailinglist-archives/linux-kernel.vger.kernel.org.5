Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F33E7D800B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjJZJxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZJxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:53:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2119B9D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 02:53:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31BB42F4;
        Thu, 26 Oct 2023 02:54:10 -0700 (PDT)
Received: from [10.1.36.151] (XHFQ2J9959.cambridge.arm.com [10.1.36.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30DF83F738;
        Thu, 26 Oct 2023 02:53:26 -0700 (PDT)
Message-ID: <ce723223-9751-4d57-af2d-86d30b2dd16a@arm.com>
Date:   Thu, 26 Oct 2023 10:53:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
Content-Language: en-GB
To:     Yu Zhao <yuzhao@google.com>, David Hildenbrand <david@redhat.com>
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
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufa9CyfRaMFXWtFWPG22Z9Zf9hZZWbZdTke6THimtbPzRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 20:11, Yu Zhao wrote:
> On Wed, Oct 25, 2023 at 12:47 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 25.10.23 18:24, Ryan Roberts wrote:
>>> On 20/10/2023 13:33, Ryan Roberts wrote:
>>>> On 06/10/2023 21:06, David Hildenbrand wrote:
>>>>> On 29.09.23 13:44, Ryan Roberts wrote:
>>>>>> Hi All,
>>>>>
>>>>
>>>> [...]
>>>>
>>>>>> NOTE: These changes should not be merged until the prerequisites are complete.
>>>>>> These are in progress and tracked at [7].
>>>>>
>>>>> We should probably list them here, and classify which one we see as strict a
>>>>> requirement, which ones might be an optimization.
>>>>>
>>>>
>>>> Bringing back the discussion of prerequistes to this thread following the
>>>> discussion at the mm-alignment meeting on Wednesday.
>>>>
>>>> Slides, updated following discussion to reflect all the agreed items that are
>>>> prerequisites and enhancements, are at [1].
>>>>
>>>> I've taken a closer look at the situation with khugepaged, and can confirm that
>>>> it does correctly collapse anon small-sized THP into PMD-sized THP. I did notice
>>>> though, that one of the khugepaged selftests (collapse_max_ptes_none) fails when
>>>> small-sized THP is enabled+always. So I've fixed that test up and will add the
>>>> patch to the next version of my series.
>>>>
>>>> So I believe the khugepaged prerequisite can be marked as done.
>>>>
>>>> [1]
>>>> https://drive.google.com/file/d/1GnfYFpr7_c1kA41liRUW5YtCb8Cj18Ud/view?usp=sharing&resourcekey=0-U1Mj3-RhLD1JV6EThpyPyA
>>>
>>> Hi All,
>>
>> Hi,
>>
>> I wanted to remind people in the THP cabal meeting, but that either
>> didn't happen or zoomed decided to not let me join :)

I didn't make it yesterday either - was having to juggle child care.

>>
>>>
>>> It's been a week since the mm alignment meeting discussion we had around
>>> prerequisites and the ABI. I haven't heard any further feedback on the ABI
>>> proposal, so I'm going to be optimistic and assume that nobody has found any
>>> fatal flaws in it :).
>>
>> After saying in the call probably 10 times that people should comment
>> here if there are reasonable alternatives worth discussing, call me
>> "optimistic" as well; but, it's only been a week and people might still
>> be thinking about this/
>>
>> There were two things discussed in the call:
>>
>> * Yu brought up "lists" so we can have priorities. As briefly discussed
>>    in the  call, this (a) might not be needed right now in an initial
>>    version;  (b) the kernel might be able to handle that (or many cases)
>>    automatically, TBD. Adding lists now would kind-of set the semantics
>>    of that interface in stone. As you describe below, the approach
>>    discussed here could easily be extended to cover priorities, if need
>>    be.
> 
> I want to expand on this: the argument that "if you could allocate a
> higher order you should use it" is too simplistic. There are many
> reasons in addition to the one above that we want to "fall back" to
> higher orders, e.g., those higher orders are not on PCP or from the
> local node. When we consider the sequence of orders to try, user
> preference is just one of the parameters to the cost function. The
> bottom line is that I think we should all agree that there needs to be
> a cost function down the road, whatever it looks like. Otherwise I
> don't know how we can make "auto" happen.

I don't dispute that this sounds like it could be beneficial, but I see it as
research to happen further down the road (as you say), and we don't know what
that research might conclude. Also, I think the scope of this is bigger than
anonymous memory - you would also likely want to look at the policy for page
cache folio order too, since today that's based solely on readahead. So I see it
as an optimization that is somewhat orthogonal to small-sized THP.

The proposed interface does not imply any preference order - it only states
which sizes the user wants the kernel to select from, so I think there is lots
of freedom to change this down the track if the kernel wants to start using the
buddy allocator's state as a signal to make its decisions.

> 
>> * Hugh raised the point that "bitmap of orders" could be replaced by
>>    "added THP sizes", which really is "bitmap of orders" shifted to the
>>    left. To configure 2 MiB +  64Kib, one would get "2097152 + 65536" =
>>    "2162688" or in KiB "2112". Hm.
> 
> I'm not a big fan of the "bitmap of orders" approach, because it
> doesn't address my concern above.
> 
>> Both approaches would require single-option files like "enable_always",
>> "enable_madvise" ... which I don't particularly like, but who am I to judge.
>>
>>
>>>
>>> Certainly, I think it held up to the potential future policies that Yu Zhou
>>> cited on the call - the possibility of preferring a smaller size over a bigger
>>> one, if the smaller size can be allocated without splitting a contiguous block.
>>> I think the suggestion of adding a per-size priority file would solve it. And in
>>> general because we have a per-size directory, that gives us lots of flexibility
>>> for growth.
>>
>> Jup, same opinion here. But again, I'm very happy to hear other
>> alternatives and why they are better.
> 
> I'm not against David's proposal but I want to hear a lot more about
> "lots of flexibility for growth" before I'm fully convinced. 

My point was that in an abstract sense, there are properties a user may wish to
apply individually to a size, which is catered for by having a per-size
directory into which we can add more files if/when requirements for new per-size
properties arise. There are also properties that may be applied globally, for
which we have the top-level transparent_hugepage directory where properties can
be extended or added.

For your case around tighter integration with the buddy allocator, I could
imagine a per-size file allowing the user to specify if the kernel should allow
splitting a higher order to make a THP of that size (I'm not suggesting that's a
good idea, I'm just pointing out that this sort of thing is possible with the
interface). And we have discussed how the global enabled prpoerty could be
extended to support "auto" [1].

But perhaps what we really need are lots more ideas for future directions for
small-sized THP to allow us to evaluate this interface more widely.

> Why do I
> need more convincing? When I brought up that we need to consider the
> priority of each order and the potential need to fall back to higher
> orders during the meeting, I got the impression people were surprised
> why we want to fall back to higher orders. TBH, I was surprised too
> that this possibility was never considered. I missed today's THP
> meeting too but I'll join next time and if anyone has more ideas on
> this, we can spend some time discussing it, especially on how LAF
> should cooperate with the page allocator to make better decisions.

[1]
https://lore.kernel.org/linux-mm/99f8294b-b4e5-424f-d761-24a70a82cc1a@redhat.com/

Thanks,
Ryan

