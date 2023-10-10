Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC317BF8F8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjJJKr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJJKrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:47:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 576FA9E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 03:47:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE8991FB;
        Tue, 10 Oct 2023 03:48:02 -0700 (PDT)
Received: from [10.1.30.177] (XHFQ2J9959.cambridge.arm.com [10.1.30.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9165E3F762;
        Tue, 10 Oct 2023 03:47:19 -0700 (PDT)
Message-ID: <15a52c3d-9584-449b-8228-1335e0753b04@arm.com>
Date:   Tue, 10 Oct 2023 11:47:18 +0100
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
 <c603a458-21b5-4028-93c3-2b1bf8a12047@arm.com>
 <99f8294b-b4e5-424f-d761-24a70a82cc1a@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <99f8294b-b4e5-424f-d761-24a70a82cc1a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2023 17:22, David Hildenbrand wrote:
> [...]
> 
>>>
>>> I dislike exposing "orders" to the users, I'm happy to be convinced why I am
>>> wrong and it is a good idea.
>>>
>>> So maybe "Small THP"/"Small-sized THP" is better. Or "Medium-sized THP" -- as
>>> said, I think FreeBSD tends to call it "Medium-sized superpages". But what's
>>> small/medium/large is debatable. "Small" implies at least that it's smaller than
>>> what we used to know, which is a fact.
>>>
>>> Can we also now use the terminology consistently? (e.g., "variable-order, large
>>> folios for anonymous memory" -> "Small-sized anonymous THP", you can just point
>>> at the previous patch set name in the cover letter)
>>
>> Yes absolutely. FWIW, I was deliberately not changing the title of the patchset
>> so people could easily see it was an evolution of something posted before. But
>> if it's the norm to change the title as the patchset evolves, I'm very happy to
>> do that. And there are other places too, in commit logs that I can tidy up. I
>> will assume "PMD-sized THP", "small-sized THP" and "anonymous small-sized THP"
>> (that last one slightly different from what David suggested above - it means
>> "small-sized THP" can still be grepped) unless others object.
> 
> Absolutely fine with me. Hoping other people will object when I talk nonsense or
> my suggestions don't make any sense.
> 
> Or even better, propose something better :)
> 
>>
>>>
>>>>
>>>> 1) Since SW (the kernel) is dealing with larger chunks of memory than base
>>>>      pages, there are efficiency savings to be had; fewer page faults,
>>>> batched PTE
>>>>      and RMAP manipulation, reduced lru list, etc. In short, we reduce kernel
>>>>      overhead. This should benefit all architectures.
>>>> 2) Since we are now mapping physically contiguous chunks of memory, we can take
>>>>      advantage of HW TLB compression techniques. A reduction in TLB pressure
>>>>      speeds up kernel and user space. arm64 systems have 2 mechanisms to
>>>> coalesce
>>>>      TLB entries; "the contiguous bit" (architectural) and HPA (uarch).
>>>>
>>>> The major change in this revision is the addition of sysfs controls to allow
>>>> this "small-order THP" to be enabled/disabled/configured independently of
>>>> PMD-order THP. The approach I've taken differs a bit from previous discussions;
>>>> instead of creating a whole new interface ("large_folio"), I'm extending THP. I
>>>> personally think this makes things clearer and more extensible. See [6] for
>>>> detailed rationale.
>>>
>>> Change 2: sysfs interface.
>>>
>>> If we call it THP, it shall go under "/sys/kernel/mm/transparent_hugepage/", I
>>> agree.
>>>
>>> What we expose there and how, is TBD. Again, not a friend of "orders" and
>>> bitmaps at all. We can do better if we want to go down that path.
>>>
>>> Maybe we should take a look at hugetlb, and how they added support for multiple
>>> sizes. What *might* make sense could be (depending on which values we actually
>>> support!)
>>>
>>>
>>> /sys/kernel/mm/transparent_hugepage/hugepages-64kB/
>>> /sys/kernel/mm/transparent_hugepage/hugepages-128kB/
>>> /sys/kernel/mm/transparent_hugepage/hugepages-256kB/
>>> /sys/kernel/mm/transparent_hugepage/hugepages-512kB/
>>> /sys/kernel/mm/transparent_hugepage/hugepages-1024kB/
>>> /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/
>>>
>>> Each one would contain an "enabled" and "defrag" file. We want something minimal
>>> first? Start with the "enabled" option.
>>>
>>>
>>> enabled: always [global] madvise never
>>>
>>> Initially, we would set it for PMD-sized THP to "global" and for everything else
>>> to "never".
>>
>> My only reservation about this approach is the potential for a future need for a
>> "one setting applied across all sizes" class of control (e.g. "auto"). I think
>> we agreed in the previous meetings that chasing a solution for "auto" was a good
>> aspiration to have, so it would be good to have a place we we can insert that in
>> future. The main reason why I chose to expose the "anon_orders" control is
>> because it is possible to both enable/disable the various sizes as well as
>> specificy (e.g.) "auto", without creating redundancy. But I agree that ideally
>> we wouldn't expose orders to the user; I was attempting a compromise to simplify
>> the "auto" case.
>>
>> A potential (though feels quite complex) solution to make auto work with your
>> proposal: Add "auto" as an option to the existing global enabled file, and to
>> all of your proposed new enabled files. But its only possible to *set* auto
>> through the global file. And when it is set, all of the size-specific enabled
>> files read-back "auto" too. Any any writes to the size-specific enabled files
>> are ignored (or remembered but not enacted) until the global enabled file is
>> changed away from auto.
> 
> Yes, I think there are various ways forward regarding that. Or to enable "auto"
> mode only once all are "auto", and as soon as one is not "auto", just disable
> it. A simple
> 
> echo "auto" > /sys/kernel/mm/transparent_hugepage/hugepages-*/enabled

I'm not really a fan, because this implies that you have a period where "auto"
is reported for a size, but its not really in "auto" mode yet.

> 
> Would do to enable it. Or, have them all be "global" and have a global "auto"
> mode as you raised.
> 
> echo "global" > /sys/kernel/mm/transparent_hugepage/hugepages-*/enabled
> echo "auto" > /sys/kernel/mm/transparent_hugepage/enabled
> 

Again, this isn't atomic either. I tend to prefer my proposal because it
switches atomically - there are no weird intermediate states. Anyway, I guess
the important point is we have demonstrated that your proposed interface could
be extended to support "auto" in future, should we need it.

>>
>> But I'm not sure if adding a new option to the global enabled file might break
>> compat?
> 
> I think we used to extend the "defrag" option, see
> 
> commit 21440d7eb9044001b7fdb71d0163689f60a0f2a1
> Author: David Rientjes <rientjes@google.com>
> Date:   Wed Feb 22 15:45:49 2017 -0800
> 
>     mm, thp: add new defer+madvise defrag option
> 
> 
> So I suspect we could extend that one in a similar way.
> 
> But again, this is just the thing that came to mind when thinking about how to:
> a) avoid orders
> b) make it configurable and future-proof
> c) make it look a bit consistent with other interfaces (hugetlb and
>    existing thp)
> d) still prepare for an auto mode that we want in the future
> 
> I'm happy to hear other ideas.
> 
>>
>>>
>>>
>>>
>>> That sounds reasonable at least to me, and we would be using what we learned
>>> from THP (as John suggested).  That still gives reasonable flexibility without
>>> going too wild, and a better IMHO interface.
>>>
>>> I understand Yu's point about ABI discussions and "0 knobs". I'm happy as long
>>> as we can have something that won't hurt us later and still be able to use this
>>> in distributions within a reasonable timeframe. Enabling/disabling individual
>>> sizes does not sound too restrictive to me. And we could always add an "auto"
>>> setting later and default to that with a new kconfig knob.
>>>
>>> If someone wants to configure it, why not. Let's just prepare a way to to handle
>>> this "better" automatically in the future (if ever ...).
>>>
>>>
>>> Change 3: Stats
>>>
>>>> /proc/meminfo:
>>>>     Introduce new "AnonHugePteMap" field, which reports the amount of
>>>>     memory (in KiB) mapped from large folios globally (similar to
>>>>     AnonHugePages field).
>>>
>>> AnonHugePages is and remains "PMD-sized THP that is mapped using a PMD", I think
>>> we all agree on that. It should have been named "AnonPmdMapped" or
>>> "AnonHugePmdMapped", too bad, we can't change that.
>>
>> Yes agreed. I did consider redefining "AnonHugePages" to cover PMD- and
>> PTE-mapped memory, then introduce both an "AnonHugePmdMapped" and
>> "AnonHugePteMapped", but I think that would likely break things. Its further
>> complicated because vmstats prints it in PMD-size units, so can't represent
>> PTE-mapped memory in that counter.
> 
> :/
> 
>>
>>>
>>> "AnonHugePteMap" better be "AnonHugePteMapped".
>>
>> I agree, but I went with the shorter one because any longer and it would unalign
>> the value e.g:
>>
>>      AnonHugePages:         0 kB
>>      AnonHugePteMapped:        0 kB
>>      ShmemPmdMapped:        0 kB
>>      Shared_Hugetlb:        0 kB
>>
> 
> Can't that be handled? We surely have long stuff in there:
> 
> HardwareCorrupted:     0 kB
> AnonHugePages:         0 kB
> ShmemHugePages:  1081344 kB
> ShmemPmdMapped:        0 kB
> 
> HardwareCorrupted has same length as AnonHugePteMapped

HardwareCorrupted is special cased and has a field length of 5, so the largest
value you can represent before it gets pushed out is ~97MB. I imagine that's
plenty for HardwareCorrupted, but unlikely enough for AnonHugePteMapped. The
standard field size is 8, which provides for ~95GB before becoming unaligned.

> 
> But I'm not convinced about "AnonHugePteMapped" yet :)

OK

> 
>> So would need to decide which is preferable, or come up with a shorter name.
>>
>>>
>>> But, I wonder if we want to expose this "PteMapped" to user space *at all*. Why
>>> should they care if it's PTE mapped? For PMD-sized THP it makes a bit of sense,
>>> because !PMD implied !performance, and one might have been able to troubleshoot
>>> that somehow. For PTE-mapped, it doesn't make much sense really, they are always
>>> PTE-mapped.
>>
>> I disagree; I've been using it a lot to debug performance issues. It tells you
>> how much of your anon memory is allocated with large folios. And making that
>> percentage bigger improves performance; fewer page faults, and with a separate
>> contpte series on arm64, better use of the TLB. Reasons might include; poorly
>> aligned/too small VMAs, memory fragmentation preventing allocation, CoW, etc.
> 
> Just because a small-sized THP is PTE-mapped doesn't tell you anything, really.
> What you want to know is if it is "completely" and "consecutively" mapped such
> that the HW can actually benefit from it -- if HW even supports it. So
> "PTE-mapped THP" is just part of the story. And that's where it gets tricky I
> think.
> 
> I agree that it's good for debugging, but then maybe it should a) live somewhere
> else (debugfs, bucketing below) and b) be consistent with other THPs, meaning we
> also want similar stats somewhere.
> 
> One idea would be to expose such stats in a R/O fashion like "nr_allocated" or
> "nr_hugepages" in /sys/kernel/mm/transparent_hugepage/hugepages-64kB/ and
> friends. Of course, maybe tagging them with "anon" prefix.

I see your point, but I don't completely agree with it all. That said, given
your conclusion at the bottom, perhaps we should park the discussion about the
accounting for a separate series in future? Then we can focus on the ABI?

> 
>>
>> I would actually argue for adding similar counters for file-backed memory too
>> for the same reasons. (I actually posted an independent patch a while back that
>> did this for file- and anon- memory, bucketted by size. But I think the idea of
>> the bucketting was NAKed.
> For debugging, I *think* it might be valuable to see how many THP of each size
> are allocated. Tracking exactly "how is it mapped" is not easy to achieve as we
> learned. PMD-mapped was easy, but also requires us to keep doing that tracking
> for all eternity ...
> 
> Do you have a pointer to the patch set? Did it try to squeeze it into
> /proc/meminfo?

I was actually only working on smaps/smaps_rollup, which has been my main tool
for debugging. patches at [1].

[1] https://lore.kernel.org/linux-mm/20230613160950.3554675-1-ryan.roberts@arm.com/

> 
>>
>>>
>>> That also raises the question how you would account a PTE-mapped THP. The hole
>>> thing? Only the parts that are mapped? Let's better not go down that path.
>>
>> The approach I've taken in this series is the simple one - account every page
>> that belongs to a large folio from when it is first mapped to last unmapped.
>> Yes, in this case, you might not actually be mapping the full thing
>> contigiously. But it gives a good indication.
>>
>> I also considered accounting the whole folio only when all of its pages become
>> mapped (although not worrying about them all being contiguous). That's still
>> simple to implement for all counters except smaps. So went with the simplest
>> approach with the view that its "good enough".
> 
> If you take a look at "ShmemHugePages" and "FileHugePages", there we actually
> track them when they get allocated+freed, which is much easier than tracking
> when/how they are (un)mapped. But it's only done for PMD-sized THP for now.
> 
>>
>>>
>>> That leaves the question why we would want to include them here at all in a
>>> special PTE-mapped way?
>>>
>>>
>>> Again, let's look at hugetlb: I prepared 1 GiB and one 2 MiB page.
>>>
>>> HugePages_Total:       1
>>> HugePages_Free:        1
>>> HugePages_Rsvd:        0
>>> HugePages_Surp:        0
>>> Hugepagesize:       2048 kB
>>> Hugetlb:         1050624 kB
>>>
>>> -> Only the last one gives the sum, the other stats don't even mention the other
>>> ones. [how do we get their stats, if at all?]
>>
>> There are some files in /sys/kernel/mm/hugepages/hugepages-XXkB and
>> /sys/devices/system/node/node*/hugepages/; nr_hugepages, free_hugepages,
>> surplus_hugepages. But this interface also constitutes the allocator, not just
>> stats, I think.
> 
> Ah, I missed that we expose free vs. reserved vs. surpluse ... there as well; I
> thought we would only have "nr_hugepages".
> 
>>
>>>
>>> So maybe, we only want a summary of how many anon huge pages of any size are
>>> allocated (independent of the PTE vs. PMD mapping),
>>
>> Are you proposing (AnonHugePages + AnonHugePteMapped) here or something else? If
>> the former, then I don't really see the difference. We have to continue to
>> expose PMD-size (AnonHugePages). So either add PTE-only counter, and derive the
>> total, or add a total counter and derive PTE-only. I suspect I've misunderstood
>> your point.
> 
> I don't think we should go down the "PteMapped" path. Probably we want
> "bucketing" stats as you said, and maybe a global one that just combines
> everything (any THP). But naming will be difficult.
> 
>>
>>> and some other source to
>>> eventually inspect how the different sizes behave.
>>>
>>> But note that for non-PMD-sized file THP we don't even have special counters!
>>> ... so maybe we should also defer any such stats and come up with something
>>> uniform for all types of non-PMD-sized THP.
>>
>> Indeed, I can see benefit in adding these for file THP - in fact I have a patch
>> that does exactly that to help my development work. I had envisaged that we
>> could add something like FileHugePteMapped, ShmemHugePteMapped that would follow
>> the same semantics as AnonHugePteMapped.
> 
> Again, maybe we can find something that does not involve the "PteMapped"
> terminology and just gives us a big total of "allocated" THP. For detailed stats
> for debugging, maybe we can just use a different interface then.
> 
>>
>>>
>>>
>>> Sane discussion applies to all other stats.
>>>
>>>
>>>>
>>>> Because we now have runtime enable/disable control, I've removed the compile
>>>> time Kconfig switch. It still defaults to runtime-disabled.
>>>>
>>>> NOTE: These changes should not be merged until the prerequisites are complete.
>>>> These are in progress and tracked at [7].
>>>
>>> We should probably list them here, and classify which one we see as strict a
>>> requirement, which ones might be an optimization.
>>
>>
>> I'll need some help with clasifying them, so showing my working. Final list that
>> I would propose as strict requirements at bottom.
>>
>> This is my list with status, as per response to Yu in other thread:
>>
>>    - David is working on "shared vs exclusive mappings"
> 
> Probably "COW reuse support" is a separate item, although my approach would
> cover that.

Yeah that's the in the original thread as (2), but I thought we were all agreed
that is not a prerequisite so didn't bring it over here.

> 
> The question is, if the estimate we're using in most code for now would at least
> be sufficient to merge it. The estimate is easily wrong, but we do have that
> issue with PTE-mapped THP already.

Well as I understand it, at least the NUMA balancing code and khugepaged are
ignoring all folios > order-0. That's probably ok for the occasional PTE-mapped
THP, but I assume it becomes untenable if large folios are the norm. Perhaps we
can modify those paths to work with the current estimators in order to remove
your work from the critical path - is that what you are getting at?

> 
> But that argument probably applies to most things here: the difference is that
> PTE-mapped THP are not the default, that's why nobody really cared.
> 
> [I'm playing with an almost-lockless scheme right now and hope I have something
> running soonish -- as you know, I got distracted]
> 
>>    - Zi Yan has posted an RFC for compaction
>>    - Yin Fengwei's mlock series is now in mm-stable
>>    - Yin Fengwei's madvise series is in 6.6
>>    - I've reworked and posted a series for deferred_split_folio; although I've
>>      deprioritied it because Yu said it wasn't really a pre-requisite.
>>    - numa balancing depends on David's "shared vs exclusive mappings" work
>>    - I've started looking at "large folios in swap cache" in the background,
>>      because I'm seeing some slow down with large folios, but we also agreed that
>>      wasn't a prerequisite
>>
> 
> Probably it would be good to talk about the items and how we would classify them
> in a meeting.

Perhaps we can get a slot in Matthew's meeting tomorrow?

> 
> 
>> Although, since sending that, I've determined that when running kernel
>> compilation across high number of cores on arm64, the cost of splitting the
>> folios gets large due to needing to broadcast the extra TLBIs. So I think the
>> last point on that list may be a prerequisite after all. (I've been able to fix
>> this by adding support for allocating large folios in the swap file, and
>> avoiding the split - planning to send RFC this week).
>>
>> There is also this set of things that you mentioned against "shared vs exclusive
>> mappings", which I'm not sure if you are planning to cover as part of your work
>> or if they are follow on things that will need to be done:
>>
>> (1) Detecting shared folios, to not mess with them while they are shared.
>>      MADV_PAGEOUT, user-triggered page migration, NUMA hinting, khugepaged ...
>>      replace cases where folio_estimated_sharers() == 1 would currently be the
>>      best we can do (and in some cases, page_mapcount() == 1).
>>
>> And I recently discovered that khugepaged doesn't collapse file-backed pages to
>> a PMD-size THP if they belong to a large folio, so I'm guessing it may also
>> suffer the same behaviour for anon memory. I'm not sure if that's what your
>> "khugepaged ..." comment refers to?
> 
> Yes. But I did not look into all the details yet.
> 
> "kuhepaged" collapse support to small-sized THP is probably also a very imporant
> item, although it might be less relevant than for PMD -- and I consider it
> future work. See below.

Yes I agree that it's definitely future work. Nothing regresses from today's
performance if you don't have that.

> 
>>
>> So taking all that and trying to put together a complete outstanding list for
>> strict requirements:
>>
>>    - Shared vs Exclusive Mappings (DavidH)
>>        - user-triggered page migration
>>        - NUMA hinting/balancing
>>        - Enhance khugepaged to collapse to PMD-size from PTE-mapped large folios
>>    - Compaction of Large Folios (Zi Yan)
>>    - Swap out small-size THP without Split (Ryan Roberts)
> 
> ^ that's going to be tough, I can promise. And the only way to live without that
> would be khugepaged support. (because that's how it's all working for PMD-sized
> THP after all!)

Are you referring specifically to the "swap out" line there? If so, it wasn't my
plan that we would *swap in* large folios - only swap them *out* as large folios
to avoid the cost of splitting. Then when they come back in, the come in as
single pages, just like PMD-sized THP, if I've understood things correctly. I
have a patch working and showing the perf improvement as a result. I'm planning
to post an RFC today, hopefully.

I don't see the swap-in side as a problem for the initial patch set. OK, they
come in as single pages, so you lost the potential TLB benefits. But that's no
worse than today's performance so not a regression. And the ratio of SW savings
on THP allocation to HW savings from the TLB is very different for small-sized
THP; much more of the benefit comes from the SW and that's still there.

> 
> Once a PMD-sized THP was swapped out and evicted, it will always come back in
> order-0 folios. khugeged will re-collapse into PMD-sized chunks. If we could do
> that for PTE-sized THP as well ...

Yes, sure, but that's a future improvement, not a requirement to prevent
regression vs today, right?

> 
>>
>>
>>>
>>>
>>> Now, these are just my thoughts, and I'm happy about other thoughts.
>>
>> As always, thanks for taking the time - I really appreciate it.
> 
> Sure. Hoping others can comment.
> 
> My gut feeling is that it's best to focus on getting the sysfs interface
> right+future proof and handling the stats independently. While being a good
> debug mechanism, I wouldn't consider these stats a requirement: we don't have
> them for file/shmem small-sized thp so far as well.
> 
> So maybe really better to handle the stats in meminfo and friends separately.
> 

I'd be very happy with that approach if others are bought in.

Thanks,
Ryan



