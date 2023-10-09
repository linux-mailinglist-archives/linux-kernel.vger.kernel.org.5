Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34717BD9CA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346319AbjJIL3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346331AbjJIL3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:29:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EAE2D60
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:28:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0DE41FB;
        Mon,  9 Oct 2023 04:29:36 -0700 (PDT)
Received: from [10.57.66.97] (unknown [10.57.66.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB4F03F762;
        Mon,  9 Oct 2023 04:28:52 -0700 (PDT)
Message-ID: <c603a458-21b5-4028-93c3-2b1bf8a12047@arm.com>
Date:   Mon, 9 Oct 2023 12:28:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
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
        Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2023 21:06, David Hildenbrand wrote:
> On 29.09.23 13:44, Ryan Roberts wrote:
>> Hi All,
> 
> Let me highlight some core decisions on the things discussed in the previous
> alignment meetings, and comment on them.
> 
>>
>> This is v6 of a series to implement variable order, large folios for anonymous
>> memory. (previously called "ANON_LARGE_FOLIO", "LARGE_ANON_FOLIO",
>> "FLEXIBLE_THP", but now exposed as an extension to THP; "small-order THP"). The
>> objective of this is to improve performance by allocating larger chunks of
>> memory during anonymous page faults:
> 
> Change number 1: Let's call these things THP.
> 
> Fine with me; I previously rooted for that but was told that end users could be
> confused. I think the important bit is that we don't mess up the stats, and when
> we talk about THP we default to "PMD-sized THP", unless we explicitly include
> the other ones.
> 
> 
> I dislike exposing "orders" to the users, I'm happy to be convinced why I am
> wrong and it is a good idea.
> 
> So maybe "Small THP"/"Small-sized THP" is better. Or "Medium-sized THP" -- as
> said, I think FreeBSD tends to call it "Medium-sized superpages". But what's
> small/medium/large is debatable. "Small" implies at least that it's smaller than
> what we used to know, which is a fact.
> 
> Can we also now use the terminology consistently? (e.g., "variable-order, large
> folios for anonymous memory" -> "Small-sized anonymous THP", you can just point
> at the previous patch set name in the cover letter)

Yes absolutely. FWIW, I was deliberately not changing the title of the patchset
so people could easily see it was an evolution of something posted before. But
if it's the norm to change the title as the patchset evolves, I'm very happy to
do that. And there are other places too, in commit logs that I can tidy up. I
will assume "PMD-sized THP", "small-sized THP" and "anonymous small-sized THP"
(that last one slightly different from what David suggested above - it means
"small-sized THP" can still be grepped) unless others object.

> 
>>
>> 1) Since SW (the kernel) is dealing with larger chunks of memory than base
>>     pages, there are efficiency savings to be had; fewer page faults, batched PTE
>>     and RMAP manipulation, reduced lru list, etc. In short, we reduce kernel
>>     overhead. This should benefit all architectures.
>> 2) Since we are now mapping physically contiguous chunks of memory, we can take
>>     advantage of HW TLB compression techniques. A reduction in TLB pressure
>>     speeds up kernel and user space. arm64 systems have 2 mechanisms to coalesce
>>     TLB entries; "the contiguous bit" (architectural) and HPA (uarch).
>>
>> The major change in this revision is the addition of sysfs controls to allow
>> this "small-order THP" to be enabled/disabled/configured independently of
>> PMD-order THP. The approach I've taken differs a bit from previous discussions;
>> instead of creating a whole new interface ("large_folio"), I'm extending THP. I
>> personally think this makes things clearer and more extensible. See [6] for
>> detailed rationale.
> 
> Change 2: sysfs interface.
> 
> If we call it THP, it shall go under "/sys/kernel/mm/transparent_hugepage/", I
> agree.
> 
> What we expose there and how, is TBD. Again, not a friend of "orders" and
> bitmaps at all. We can do better if we want to go down that path.
> 
> Maybe we should take a look at hugetlb, and how they added support for multiple
> sizes. What *might* make sense could be (depending on which values we actually
> support!)
> 
> 
> /sys/kernel/mm/transparent_hugepage/hugepages-64kB/
> /sys/kernel/mm/transparent_hugepage/hugepages-128kB/
> /sys/kernel/mm/transparent_hugepage/hugepages-256kB/
> /sys/kernel/mm/transparent_hugepage/hugepages-512kB/
> /sys/kernel/mm/transparent_hugepage/hugepages-1024kB/
> /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/
> 
> Each one would contain an "enabled" and "defrag" file. We want something minimal
> first? Start with the "enabled" option.
> 
> 
> enabled: always [global] madvise never
> 
> Initially, we would set it for PMD-sized THP to "global" and for everything else
> to "never".

My only reservation about this approach is the potential for a future need for a
"one setting applied across all sizes" class of control (e.g. "auto"). I think
we agreed in the previous meetings that chasing a solution for "auto" was a good
aspiration to have, so it would be good to have a place we we can insert that in
future. The main reason why I chose to expose the "anon_orders" control is
because it is possible to both enable/disable the various sizes as well as
specificy (e.g.) "auto", without creating redundancy. But I agree that ideally
we wouldn't expose orders to the user; I was attempting a compromise to simplify
the "auto" case.

A potential (though feels quite complex) solution to make auto work with your
proposal: Add "auto" as an option to the existing global enabled file, and to
all of your proposed new enabled files. But its only possible to *set* auto
through the global file. And when it is set, all of the size-specific enabled
files read-back "auto" too. Any any writes to the size-specific enabled files
are ignored (or remembered but not enacted) until the global enabled file is
changed away from auto.

But I'm not sure if adding a new option to the global enabled file might break
compat?

> 
> 
> 
> That sounds reasonable at least to me, and we would be using what we learned
> from THP (as John suggested).  That still gives reasonable flexibility without
> going too wild, and a better IMHO interface.
> 
> I understand Yu's point about ABI discussions and "0 knobs". I'm happy as long
> as we can have something that won't hurt us later and still be able to use this
> in distributions within a reasonable timeframe. Enabling/disabling individual
> sizes does not sound too restrictive to me. And we could always add an "auto"
> setting later and default to that with a new kconfig knob.
> 
> If someone wants to configure it, why not. Let's just prepare a way to to handle
> this "better" automatically in the future (if ever ...).
> 
> 
> Change 3: Stats
> 
>> /proc/meminfo:
>>   Introduce new "AnonHugePteMap" field, which reports the amount of
>>   memory (in KiB) mapped from large folios globally (similar to
>>   AnonHugePages field).
> 
> AnonHugePages is and remains "PMD-sized THP that is mapped using a PMD", I think
> we all agree on that. It should have been named "AnonPmdMapped" or
> "AnonHugePmdMapped", too bad, we can't change that.

Yes agreed. I did consider redefining "AnonHugePages" to cover PMD- and
PTE-mapped memory, then introduce both an "AnonHugePmdMapped" and
"AnonHugePteMapped", but I think that would likely break things. Its further
complicated because vmstats prints it in PMD-size units, so can't represent
PTE-mapped memory in that counter.

> 
> "AnonHugePteMap" better be "AnonHugePteMapped".

I agree, but I went with the shorter one because any longer and it would unalign
the value e.g:

    AnonHugePages:         0 kB
    AnonHugePteMapped:        0 kB
    ShmemPmdMapped:        0 kB
    Shared_Hugetlb:        0 kB

So would need to decide which is preferable, or come up with a shorter name.

> 
> But, I wonder if we want to expose this "PteMapped" to user space *at all*. Why
> should they care if it's PTE mapped? For PMD-sized THP it makes a bit of sense,
> because !PMD implied !performance, and one might have been able to troubleshoot
> that somehow. For PTE-mapped, it doesn't make much sense really, they are always
> PTE-mapped.

I disagree; I've been using it a lot to debug performance issues. It tells you
how much of your anon memory is allocated with large folios. And making that
percentage bigger improves performance; fewer page faults, and with a separate
contpte series on arm64, better use of the TLB. Reasons might include; poorly
aligned/too small VMAs, memory fragmentation preventing allocation, CoW, etc.

I would actually argue for adding similar counters for file-backed memory too
for the same reasons. (I actually posted an independent patch a while back that
did this for file- and anon- memory, bucketted by size. But I think the idea of
the bucketting was NAKed.

> 
> That also raises the question how you would account a PTE-mapped THP. The hole
> thing? Only the parts that are mapped? Let's better not go down that path.

The approach I've taken in this series is the simple one - account every page
that belongs to a large folio from when it is first mapped to last unmapped.
Yes, in this case, you might not actually be mapping the full thing
contigiously. But it gives a good indication.

I also considered accounting the whole folio only when all of its pages become
mapped (although not worrying about them all being contiguous). That's still
simple to implement for all counters except smaps. So went with the simplest
approach with the view that its "good enough".

> 
> That leaves the question why we would want to include them here at all in a
> special PTE-mapped way?
> 
> 
> Again, let's look at hugetlb: I prepared 1 GiB and one 2 MiB page.
> 
> HugePages_Total:       1
> HugePages_Free:        1
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> Hugepagesize:       2048 kB
> Hugetlb:         1050624 kB
> 
> -> Only the last one gives the sum, the other stats don't even mention the other
> ones. [how do we get their stats, if at all?]

There are some files in /sys/kernel/mm/hugepages/hugepages-XXkB and
/sys/devices/system/node/node*/hugepages/; nr_hugepages, free_hugepages,
surplus_hugepages. But this interface also constitutes the allocator, not just
stats, I think.

> 
> So maybe, we only want a summary of how many anon huge pages of any size are
> allocated (independent of the PTE vs. PMD mapping), 

Are you proposing (AnonHugePages + AnonHugePteMapped) here or something else? If
the former, then I don't really see the difference. We have to continue to
expose PMD-size (AnonHugePages). So either add PTE-only counter, and derive the
total, or add a total counter and derive PTE-only. I suspect I've misunderstood
your point.

> and some other source to
> eventually inspect how the different sizes behave.
> 
> But note that for non-PMD-sized file THP we don't even have special counters!
> ... so maybe we should also defer any such stats and come up with something
> uniform for all types of non-PMD-sized THP.

Indeed, I can see benefit in adding these for file THP - in fact I have a patch
that does exactly that to help my development work. I had envisaged that we
could add something like FileHugePteMapped, ShmemHugePteMapped that would follow
the same semantics as AnonHugePteMapped.

> 
> 
> Sane discussion applies to all other stats.
> 
> 
>>
>> Because we now have runtime enable/disable control, I've removed the compile
>> time Kconfig switch. It still defaults to runtime-disabled.
>>
>> NOTE: These changes should not be merged until the prerequisites are complete.
>> These are in progress and tracked at [7].
> 
> We should probably list them here, and classify which one we see as strict a
> requirement, which ones might be an optimization.


I'll need some help with clasifying them, so showing my working. Final list that
I would propose as strict requirements at bottom.

This is my list with status, as per response to Yu in other thread:

  - David is working on "shared vs exclusive mappings"
  - Zi Yan has posted an RFC for compaction
  - Yin Fengwei's mlock series is now in mm-stable
  - Yin Fengwei's madvise series is in 6.6
  - I've reworked and posted a series for deferred_split_folio; although I've
    deprioritied it because Yu said it wasn't really a pre-requisite.
  - numa balancing depends on David's "shared vs exclusive mappings" work
  - I've started looking at "large folios in swap cache" in the background,
    because I'm seeing some slow down with large folios, but we also agreed that
    wasn't a prerequisite

Although, since sending that, I've determined that when running kernel
compilation across high number of cores on arm64, the cost of splitting the
folios gets large due to needing to broadcast the extra TLBIs. So I think the
last point on that list may be a prerequisite after all. (I've been able to fix
this by adding support for allocating large folios in the swap file, and
avoiding the split - planning to send RFC this week).

There is also this set of things that you mentioned against "shared vs exclusive
mappings", which I'm not sure if you are planning to cover as part of your work
or if they are follow on things that will need to be done:

(1) Detecting shared folios, to not mess with them while they are shared.
    MADV_PAGEOUT, user-triggered page migration, NUMA hinting, khugepaged ...
    replace cases where folio_estimated_sharers() == 1 would currently be the
    best we can do (and in some cases, page_mapcount() == 1).

And I recently discovered that khugepaged doesn't collapse file-backed pages to
a PMD-size THP if they belong to a large folio, so I'm guessing it may also
suffer the same behaviour for anon memory. I'm not sure if that's what your
"khugepaged ..." comment refers to?

So taking all that and trying to put together a complete outstanding list for
strict requirements:

  - Shared vs Exclusive Mappings (DavidH)
      - user-triggered page migration
      - NUMA hinting/balancing
      - Enhance khugepaged to collapse to PMD-size from PTE-mapped large folios
  - Compaction of Large Folios (Zi Yan)
  - Swap out small-size THP without Split (Ryan Roberts)


> 
> 
> Now, these are just my thoughts, and I'm happy about other thoughts.

As always, thanks for taking the time - I really appreciate it.

Thanks,
Ryan


