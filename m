Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A36B7F74E5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345158AbjKXN0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjKXN0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:26:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C4C10E3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=R2cPgW4KJcq3wCSFt6Qoz0dJLwsPQPMvOqw5KRQXfeg=;
        b=LvrMA9QHHxp1uC1i+GwoG9ut5itaT/ApluTdGQ6lZQU+rzPzs24Dm5MWl5Vek+Svt6M8td
        9QZfskSzLbBWcOfI+EZdeaMmROLIjdVdJ8FpIAuot30BLQnB+FQ7gz0y/nQM3HdwFiej6k
        OfWWXhmE/A0bxhn469vt4x59NF5c1DA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-sCWUogGWO5qdI9gTmaE-_g-1; Fri, 24 Nov 2023 08:26:32 -0500
X-MC-Unique: sCWUogGWO5qdI9gTmaE-_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5187A185A780;
        Fri, 24 Nov 2023 13:26:31 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 961902166B2A;
        Fri, 24 Nov 2023 13:26:27 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH WIP v1 00/20] mm: precise "mapped shared" vs. "mapped exclusively" detection for PTE-mapped THP / partially-mappable folios
Date:   Fri, 24 Nov 2023 14:26:05 +0100
Message-ID: <20231124132626.235350-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Are you interested in some made-up math, new locking primitives and
slightly unpleasant performance numbers on first sight? :)

Great, you've come to the right place! As an added bonus, we'll be messing
with Copy-On-Write and mapcounts, which we all love, of course.

This is the current state of a project to see if we can find a way to
efficiently and precisely tell whether a PTE-mapped THP is _currently_
mapped by a single process in its page tables, or if multiple processes
are involved; similar to how we are able to do it for small folios very
efficiently.

Now that I am a bit more confident that the math and the locking is
correct, and I roughly know what the added cost will be, here is the
current state as WIP. Still, expect to find serious flaws :P

The additional tracking is performed for all THPs, whereby the biggest
benefit is currently for anonymous THP because of added Copy-on-Write
reuse support after fork.

I'm sure some people will dislike involving mapcounts -- please don't eat
me alive because I used the m-word ;). But, we're already using mapcounts
for that purpose, and I don't really see us not relying on the mapcount
for that or even getting rid of them. Having that said, one has to be very
careful when working with the mapcount(s), because the semantics can be
weird and misleading.

IMHO, we should further work on removing most manual usage of the mapcounts
and instead hide them in properly documented functions that spell out the
semantics: like folio_mapped_shared() does in this series.

Further, this series prepares for removing the subpage mapcounts. So
long-term less mapcounts is good, right?! :)

Even if the additional "rmap ID" tracking does not hold up to its
promises, there is some interesting stuff in here that might come in handy.

The first next steps should be to implement+include more rmap batching and
the per-folio mapcount, which will be valuable indepenent of all the other
stuff. In the meantime the other stuff can mature and we can make up our
mind if we want it, and if so, for which folios.

Needless to say, this is WIP, and not a request to merge this now.

1. Overview
===========

Can we find a way to precisely and efficiently tell whether a PTE-mapped
THP -- more generally, called partially-mappable folio" here --
is _currently_ "mapped exclusively" or "mapped shared" into page tables?

Usually that means: is one process mapping this folio or are multiple
processes involved? "Special" are KSM pages and pagecache folios that are
mapped multiple times into the same process, and we'll happily "simplify"
for such pagecache folios just like we do for small folios. Well, and
s/process/MM/, because processes can share the "struct mm_struct".

It is worth stressing that we only focus on _current_ page table
mappings; a folio might _currently_ be mapped exclusively" but is not
actually exclusive (e.g., pagecache, swapcache, ...): other processes are
currently not actively using it and maybe never will.

All use cases that need _guarantees_ about "exclusive ownership" instead of
just "currently exclusively mapped" for correctness can use the precise
"mapped shared vs. mapped exclusively" as a building block.

While that "mapped shared vs mapped exclusively" information is easily
available for small folios (mapcount == 1 vs. mapcount != 1),
partially-mappable folios are more problematic. Each individual
(PTE/PMD/...) mapping accounts towards the total mapcount of the folio and
needs to increment the refcount: one mapping, one reference.

For example, a PTE-mapped PMD-sized THP on x86_64 has "refcount == 512"
and "mapcount == 512". That scheme is very simple, scalable and safe; and
is able to handle partial remapping, partial unmapping, multiple page
tables, ...very efficiently.

But that also implies that mapcount != 1" is not expressive for these
large folios to conclude "mapped shared".

2. Motivation
=============

The most important use case for a precise "mapped shared vs. mapped
exclusively" primitive is currently Copy-On-Write (COW) of PTE-mapped THP:
when we get a write fault after fork(), we may reuse any part of the
THP if that THP is completely exclusive to that process. One way of
implementing such a logic is: are all references from page table mappings,
and do all page table mappings belong to this process?

But "mapped shared vs. mapped exclusively" is also valuable to have for
other large folios: Some system calls / machinery don't want to mess with
folios that are currently not exclusive to a process: for example, we don't
want users to swapout, split or migrate folios that are also actively used
by other processes. Similarly, automatic mechanisms like NUMA balancing and
khugepaged want to detect active sharing of folios efficiently.

To be more specific, this work was motivated by the following factors:

(a) Partially-mappable folios are getting more important; especially
    with THPs that cannot be mapped by PMDs; here, we
    always get PTE-mapped THP. So PTE-mapped THPs are no longer a corner
    case.
(b) We want to reuse PTE-mapped anonymous THPs after fork() to improve
    performance; for now, we always copy and never reuse. With small-sized
    anonymous THP on the horizon, this will become very relevant.
(c) There is currently no universal way to tell whether a PTE-mapped THP
    is "mapped exclusively" or "mapped shared"; not even the subpage
    mapcounts can help with that.
(d) We want to fully support THPs that are mapped into multiple page tables
    in the same process: examples include mremap(), future support for
    THP sizes larger than a PMD, and THPs that cross leaf page tables due
    virtual start addresses [pagecache folios already/at some point?];
    we want this problem to be solved once and for all.
(e) In the context of memdesc, there is interest in removing the
    subpage mapcount; so whatever we build is ideally independent of
    that and further helps towards removing it.
(f) folio_mapcount() gets slower the larger the folio is and we want to
    speed that up; more generally, we don't want to scan the memmap of
    folios like folio_mapcount() currently does.

There have been a lot of ideas on how to deal with that over the past
year(s) that all didn't really materialize: some are too expensive, turn
imprecise quickly, or make the code more complicated and fragile.

Examples include having a mapcount for the #VMAs a large folio is mapped
into, a mapcount for the #leaf page tables a large folio is mapped into,
scanning page tables, scanning the memmap, walking the rmap ...

3. Basic Idea
=============

The idea is to not make the semantics of the mapcount of large folios
to be different from the mapcount of small folios.

Instead, the idea is use the folio mapcount + some additional tracking+math
to detect if a single MM is mapping (parts of) a large folio, or if
multiple MMs are involved.

It achieves that by plugging into the existing rmap page (un)mapping logic,
without any new hooks or page table / rmap scanning.

Imagine that we have a total mapcount (folio->_total_mapcount) and an
"rmap value" (folio->_rmap_val) per large folio, and assigned each MM a
unique rmap ID (mm->mm_rmap_id).

Whenever we would map/unmap parts of the large folio, we would
increment/decrement the total mapcount of the folio:

  folio->_total_mapcount +=/-= 1;

and add/remove the MM rmap ID to/from a folio's rmap value:

  folio->_rmap_val +=/-= mm->mm_rmap_id;

So when we would want to test if a single given MM currently exclusively
maps the folio, would:

  folio_mapcount() * mm->mm_rmap_id == folio->_rmap_val

be sufficient to identify mapped exclusively"?

No, for two main reasons:
  (1) Concurrent (un)mapping might trick us into making a wrong decision.
  (2) folio->_rmap_val might be the sum of rmap IDs from other MMs.

Well, and integer overflows, that kind-of fall into (2).

To sort out (1), we need some locking scheme -- such as a spinlock or a
seqcount -- to detect concurrent updates and be able to read values that
are consistent.

To sort out (2), we need special numbers as rmap IDs that have the
guarantee that:

  folio_mapcount() * mm->mm_rmap_id == folio->_rmap_val

is true if and only if the folio is "mapped exclusively"; well, at least as
long as we consider a folio not obviously" shared.

For example, if:

  folio_mapcount() > folio_nr_pages()

is true, we know that the folios is "obviously mapped shared" and we don't
even have to look at the rmap values.

Turns out that such numbers exist, but they can grow large fairly
quickly. More details in the respective patch.

I have a proof draft that these numbers actually get the job done. I
suspect this has been proven already a million times. Anyhow, I can send
that draft to anybody interested in it as long as it is in draft mode.

How many such numbers do we need? Well, at least as many as we have
possible processes ... so let's go for 16M: 16*1024*1024.

However, with large folios (large P), supporting 16M numbers end up not
fitting into 64bit. To not mess with 128bit/256bit/512bit math, and to be
able to perform atomic updates of the rmap values, we have to use multiple
64bit values instead; we use our simple MM rmap ID to generate multiple
"sub-IDs" that fit into 64bit values, whereby our sub-IDs are generated
as described above.

The number of rmap values we have to store in the folio, depending on the
folio size and when supporting 16M rmap IDs:

 * == order-2:  1x 64bit rmap values
 * <= order-5:  2x 64bit rmap values
 * <= order-9:  3x 64bit rmap values
 * <= order-10: 4x 64bit rmap values
 * <= order-12: 5x 64bit rmap values
 * <= order-15: 6x 64bit rmap values
 * <= order-21: 8x 64bit rmap values [not implemented]
 * <= order-30: 12x 64bit rmap values [not implemented]

On most architectures, including x86-64, we should currently never
require more than 3 values. On arm64 with 64k pagesize, we'd need 6 values
for handling 512 MiB THP that are order-13 IIRC.

4. Detailed Approach
====================

Tracking infrastructure:

(1) Add a per-folio mapcount to large folios, so we can read/write it
    atomically and efficiently: folio->_total_mapcount. For now, it
    coexists with the subpage mapcounts.
(2) Assign each MM a unique rmap ID < 16M: mm->mm_rmap_id.
(3) Derive 1..X magic sub-ID[X] from that rmap ID, X depending on the
    folio size.
(4) Define 1..X folio->_rmap_valX, X depending on the folio size.

While (1) is required in any case when we want to make folio_mapcount()
faster and remove the subpage mapcounts, it already helps to improve
detecting "mapped shared" in more cases by converting
folio_estimated_sharers() to folio_mapped_shared().

Tracking on the writer side -- (un)mapping parts of a folio:

(1) Add/remove the per-MM sub-IDs to/from the respective rmap values
    when incrementing/decrementing the total mapcount: when (un)mapping
    parts of the folio.
(2) Add a locking scheme (atomic seqcount) to allow for concurrent
    updates of the mapcount+values (atomic values), while allowing
    readers to detect concurrent updates to retry seqcount-style.
(3) Optimize the locking scheme for the common case of having a single
    exclusive writer ("no concurrent (un)mapping"), to reduce the number
    of atomic RMW operations.

This make it possible to detect "certainly mapped shared" vs.
"certainly mapped exclusively" to implement a precise
folio_mapped_shared() function and COW reuse after fork().

Approach on the reader side:

(1) Only look at the mapcount+rmap values if the folio is not obviously
    shared; folio_mapcount() > folio_nr_pages() implies "mapped
    shared".
(2) For all X, if folio->rmap_val[X] == folio_mapcount() * sub-ID[X] of a
    given MM, the folio is mapped exclusively", otherwise it's mapped
    shared".
(3) Use the atomic seqcount, to catch concurrent (un)mapping that
    leaves the counters in an intermediate state and (conditionally)
    retry seqcount-style.

In some cases, we might simply want to stop early if there is concurrent
(un)mapping happening, and indicate "maybe mapped shared".

5. Atomic operations ...
========================

In the rmap code, we used to require at most 2 atomic RMW operations when
(un)mapping parts of a THP: updating the subpage mapcount and
(conditionally) updating folio->nr_pages_mapped (add-return-relaxed).

To manage the total mapcount, we need 1 additional atomic RMW operation
(add).

To manage the folio->_rmap_valX, we need:
* 2 atomic RMW operations for the atomic seqcount
* 1..6 atomic RMW operation for the folio->_rmap_valX

So, in total, an additional 4..9 atomic RMW operations. Hm.

There are three things to consider and optimize:

(1) When batching rmap operations (fork, unmap, ...), we'll only have
    to perform these operations once per batch -- in contrast to the
    subpage mapcount updates. This series batches rmap operations for
    PTE-remapping a PMD-mapped THP, which ends up performing better
    than the current state even with additional tracking.
(2) In the common case, we don't have concurrent (un)mapping. So if we
    are exclusively holding the atomic seqcount, we can avoid atomic
    RMW operations for updating the total mapcount and the rmap values.
    This series implements that "exclusive atomic seqcount" optimization.
(3) In the future, we might be able to get rid of the subpage mapcount
    and folio->nr_pages_mapped. This series also updates
    these values under the atomic seqcount, and makes them similarly use
    the "exclusive atomic seqcount" optimization.

Apparently, on some hardware (AMD EPYC) atomic additions seem to be
just as fast as doing ordinary additions. On such hardware, (2) is not
required. More on that below.

Reducing the number of additions/atomics further will require using
128bit/256bit/ integer math.

6. Patch Organization
=====================

Patch #1 to #3 add the "total mapcount" to large folios and convert
folio_estimated_sharers() to folio_mapped_shared() and improve it.

Patch #4 to #7 prepare for rmap ID tracking, and implement the
atomic seqcount + rmap ID tracking. rmap ID tracking is implemented using
4/5/6 rmap values using lookup tables for subids. The atomic seqcount
is only used when adjusting the the total mapcount and the rmap values.

Patch #8 to #10 further improve folio_mapped_shared() based on rmap IDs
and implement COW reuse of PTE-mapped anon THP.

Patch #11 adds support for 1/2/3 rmap values by pre-calculating the subids
and storing them in the MM struct.

Patch #12 to #14 implement batching of rmap operations when PTE-remapping
a PMD-mapped anon THP.

Patch #15 just adds some sanity checks.

Patch #16 to #17 implement the "exclusive atomic seqcount" optimization, to
optimize for "no concurrent (un)mapping" of the same folio.

Patch #18 implements an interesting optimization for the atomic seqcount.

Patch #19 to #20 use the per-folio atomic seqcount not only to protect the
total mapcount and the rmap values, but also the other mapcounts.

7. Performance
==============

The added tracking is noticeable. This series adds the tracking for all
partially-mappable folios (i.e., anon, pagecache, shmem), but I focus on
benchmarks on the anon 2 MiB THP for now.

I focus on the extreme case of all PTE-mapped THP", with no concurrent
(un)mapping of the same folio -- micro benchmarks -- and with heavy
concurrent (un)mapping of the same folio -- vm-scalability benchmarks.

There are certainly many more benchmarks to run at some point, these
should give a good indication of what the problematic areas are and
how the optimizations perform.

x86_64 benchmarks only, so we only trigger the "3/4 rmap values" case.

7.1 Environment
---------------

I run the benchmarks on an 2-socket Intel(R) Xeon(R) Silver 4210R and
a 2-socket AMD EPYC 7313. Turbo and SMT disabled on both systems,
performance governor enabled on the Intel CPU.

Code stages that are tested:

 * baseline" : v6.7-rc1
 * mapcount" : after patch #3  (total mapcount + folio_mapped_shared())
 * rmap-id"  : after patch #10 (rmap_id tracking + COW reuse)
 * 123       : after patch #11 (support for 1, 2, 3 values)
 * batch     : after patch #14 (rmap batching in __split_huge_pmd_locked())
 * exclusive : after patch #17 (exclusive atomic seqcount)
 * nocmpxchg : after patch #18 (use add-return instead of cmpxchg)
 * all       : after patch #20 (all mapcount mods under rmap seqcount)

7.2 Micro benchmark
-------------------

Allocate 1 GiB of (2 MiB) THP. Then, perform an action and measure the
time it takes to perform that action only.

(1) remap: Trigger PTE-remapping each PMD-mapped THP using mprotect() on a
    single subpage of each THP.
(2) munmap: Trigger PTE-mapping as in (2). Measure munmap() of the 1 GiB.
(3) fork: Trigger PTE-mapping as in (2). Measure fork().
(4) cow: fork() a child and leave it alive. Measure memset() on the 1 GiB.
(5) cow-byte: fork() a child and leave it alive. Measure writing a single
    byte to each page in the whole 1 GiB.
(6) cow-reuse: Same as (5), but don't leave the child alive.
(7) cow-reuse-byte: Same as (6), but don't leave the child alive.
(8) pte-dontneed: Trigger MADV_DONTNEED on each subpage.

The tables only show the % change in runtime compared to the baseline.

_Negative is good_ (less runtime).

Results on Intel(R) Xeon(R) Silver 4210R CPU with 10 cores and 2 sockets
(20 cores):

          |  (1)  |  (2)  |  (3)  |  (4) |  (5) |   (6)  |   (7)  |  (8)  |
--------------------------------------------------------------------------
mapcount  | 13.4% |  0.3% | 14.2% | 0.5% | 0.2% |  -0.2% |  -0.4% |  2.8% |
rmap-id   |123.7% | 48.8% |105.9% | 3.0% | 3.2% | -30.0% | -64.2% | 14.8% |
123       |108.7% | 42.1% | 93.3% | 1.7% | 2.7% | -30.0% | -64.3% | 12.9% |
batch     | -8.1% | 41.4% | 95.5% | 1.5% | 2.2% | -29.7% | -64.2% |  5.7% |
exclusive | -8.8% | 15.1% | 40.5% | 1.1% | 0.9% | -29.6% | -64.0% |  1.1% |
nocmpxchg |-10.4% | 12.6% | 46.4% | 0.9% | 1.4% | -30.0% | -64.3% |  0.8% |
all       |-34.8% |  1.0% | 27.8% | 0.7% | 0.4% | -30.0% | -63.9% | -0.5% |

Results on AMD EPYC 7313 16-Core Processor and 2 sockets (32 cores):

          |  (1)  |  (2)  |  (3)  |  (4) |  (5) |   (6)  |   (7)  |  (8)  |
--------------------------------------------------------------------------
mapcount  | 24.3% |  1.8% | 25.9% | 1.5% | 2.6% |   1.4% |   1.9% |  4.5% |
rmap-id   | 55.4% | 12.5% | 27.9% | 2.6% | 4.3% | -50.4% | -60.9% |  6.3% |
123       | 45.6% |  6.3% | 30.4% | 2.9% | 4.1% | -51.1% | -60.5% |  6.7% |
batch     | -9.6% |  7.2% | 31.5% | 2.1% | 3.0% | -51.1% | -60.7% |  4.0% |
exclusive |-10.8% | 14.0% | 48.4% | 0.5% | 2.3% | -51.4% | -61.0% |  5.0% |
nocmpxchg |-11.3% | 25.9% | 55.7% | 2.0% | 3.3% | -50.9% | -60.2% |  3.4% |
all       |-21.8% | 16.1% | 43.0% | 3.2% | 4.8% | -50.2% | -60.8% |  5.8% |


Discussion:
* rmap batching can do magic, as shown in (1).
* (2) and (3) perform mostly only refcount+mapcount operations, which is
  why the additional tracking negatively affects performance. For both,
  we can batch rmap operations.
* For (4) and (5) the additional overhead is smallish; one way to
  optimize is COW'ing more on pagefault, to essentially batch rmap
  operations.
* The COW-reuse optimization in (6) and (7) is obvious.
* (8) cannot really be optimized by rmap batching: we cannot discard more
  than what we are told to, at least when it comes to anonymous folios.
* AMD EPYC doesn't benefit from the "exclusive atomic seqcount"
  optimization in most cases, and it can actually be counter-productive. We
  should just disable that optimization at runtime when we detect CPUs
  that can handle atomic RMW operations that efficiently.
* There are some (reproducible) unexplainable performance differences that
  don't make too much sense: for example, why is "nocmpxchg" on Intel
  *slower* for fork? Why do the numbers on Intel for (7) differ slightly?
  I suspect code size/layout changes are responsible: especially fork()
  seems to be sensitive to each added instruction.

In summary, the "really bad" cases -- fork() and unmap() can be improved
by rmap batching. On Intel, only fork() really remains "sub-optimal",
everything else is quite acceptable.

On AMD EPYC, we want to disable the exclusive optimization(s), although
weirdly, in some cases they help, in others they don't. That needs
further investigation. I'd still say that with "batch" state, the result
are acceptable, and only fork+unmap primarily needs some love.

7.3 VM scalability
------------------

Running case-anon-cow-seq and case-anon-cow-rand with one instance on
each core, with an effective 1 GiB area that each instance has to COW.
The benchmark measures memory throughput.

These benchmarks will repeatedly PTE-remap each THP in the child process,
to then COW each single page, triggering repeatedly concurrent (un)mapping
of pages of the same folios from all cores. The sequential case is
probably the worst case we can possibly trigger concurrently and
repeatedly.

The tables only show the % change in throughput compared to the baseline.

_Positive is good_ (more throughput).

Results on Intel(R) Xeon(R) Silver 4210R CPU with 10 cores and 2 sockets
(20 cores):

          |   seq  |   rand  |
------------------------------
mapcount  |  -8.2% |  -0.1%  |
rmap-id   | -16.2% |  -0.3%  |
123       | -12.3% |  -0.3%  |
batch     |  -8.3% |  -0.4%  |
exclusive |  -7.1% |   0.4%  |
nocmpxchg |  -6.6% |  -0.3%  |
all       |  -5.6% |  -0.3%  |


Results on AMD EPYC 7313 16-Core Processor and 2 sockets (32 cores):

          |   seq  |   rand  |
------------------------------
mapcount  |  -2.1% |  -0.1%  |
rmap-id   | -10.4% |  -0.1%  |
123       | -10.8% |  -0.7%  |
batch     |  -3.8% |  -0.1%  |
exclusive |  -4.2% |   0.0%  |
nocmpxchg |  -4.6% |   0.0%  |
all       |  -4.5% |  -0.5%  |


Discussion:
* In the random access case, the performance change is minimal and
  negligible.
* It's interesting how much "harm" the total mapcount alone creates in
  the sequential case.
* For AMD EPYC, the sweet spot is once again without any exclusive
  optimizations; these optimizations don't really help in any way.
* AMD EPYC can deal with concurrent atomics much more efficiently.
* For Intel, all optimizations also seem to help towards optimizing the
  "heavy concurrent (un)mapping" case. So we still seem to hit quite some
  "exclusive" cases -- and shared writers waiting for the exclusive writer
  do not seem to get really affected by that.
* Again, the rmap batching when PTE-remapping the PMD on the first write
  fault is obvious in the sequential case.

In summary, in the more common "less-concurrent" randomized case, the
performance change is negligible. In the highly concurrent numbers are
not as bad as I originally thought, quite the opposite. Note that AMD
EPYC performs much better with 32 cores compared to the Intel CPU with 20
cores.

With higher core count, the impact will surely get worse, but it's
questionable how relevant these benchmarks then still are: if you have
all cores repeatedly (un)mapping parts of the same folio, probably your
application is doing something wrong.

8. TODOs
========

 * Batch rmap operations during fork(), unmap, migration, ...
 * More testing and bench-marking.
 * I'm sure there are reasonable micro-optimizations.
 * Maybe remove some rmap value variants (is 5 really required?)
 * Atomic seqcount documentation / tests / MAINTAINER.
 * Detect whether the "exclusive atomic seqcount holder" optimization is
   actually beneficial for the current hardware ... somehow .. and
   conditionally enable it. Or rather: conditionally disable it.

9. Ideas
========

 * Use rmap ID tracking only for selected folios (e.g., anon), selected
   folio sizes, etc.
 * We could not do the rmap ID tracking for pages that are essentially
   always considered shared (executables, shared libraries, ...) by marking
   them as "always assumed mapped shared".
 * Once we detect heavy contention -- many concurrent writers -- we could
   stop the rmap ID tracking and mark the folio as "always assumed
   mapped shared".
 * Using 128bit/256bit/512bit atomics might help.
 * If a sub-ID is 0, we could just optimize out the atomic RMW operation.
   This would primarily help for smallish rmap IDs.
 * Does spreading folio->_rmap_valX across more cachelines help to reduce
   contention? Some early experiments indicate: no. Maybe squeezing the
   data into less cachelines helps [but that's hard]?
 * Does pre-calculating the sub-IDs (e.g., either in the MM or in a pcpu
   variable) help? Some early experiments indicate: no.
 * We could not do the rmap ID tracking for “entire mappings” and never
   look at the rmap ID values once we have any “entire” mapping. But that
   only applies to PMD-sized THP.
 * Finding ways of merging the total mapcount with the seqcount, or
   avoiding the seqcount completely.
 * Put everything into mm/rmap.c instead of mm/rmap_id.c ?

10. Q/A
=======

Q: But aren't we consuming a lot of memmap space?
A: Not really. Excluding the atomic seqcount, we need 8 byte for order-2,
   16 byte order-5 and 32 byte for order-10. The subpage mapcounts alone
   are 16 bytes for order-2, 128 byte for order-5 and 4096 bytes for
   order-10.

Q: Do we really need the atomic seqcount?
A: At least for anonymous THP, it's currently an integral part to
   stabilize the refcount vs. mapcount and precisely detect "certainly
   exclusive". In general, without the atomic seqcount there could be cases
   where we could be tricked into wrongly concluding "mapped shared" or
   "mapped exclusively", even when re-reading the total mapcount or the
   rmap values.

Q: What about 32bit?
A: We would only want to use 32bit atomics. With 64k rmap IDs we could
   support order-15 folios with a maximum of 8x 32bit rmap values.

Q: What about RT?
A: If we disable the "exclusive" path for the atomic seqcount, we wouldn't
   have to spin on the writer's side. But we'd still have to disable
   preemption. For now, THPs are incompatible with RT either way,

Q: What about using a bit spinlock + ordinary seqcount instead of the
   atomic seqcount?
A: Bit spinlocks are unfair and frowned upon, and it increases complexity.
   Some early experiments indicated that the performance hit during the
   vm-scalability benchmarks is much more extreme.

11. Conclusion
==============

It was to be expected that additional tracking comes with a price. That
price can be heavily reduced by (a) batching rmap operations and by (b)
optimizing for "no concurrent (un)mapping". Some of these optimizations
result in a net performance improvement, even with the additional tracking
in place.

This series batches only some RMAP operations: fork, umap/zap, migration
can similarly benefit from rmap batching independent of this approach.

There are cases where we cannot batch rmap operations, but these are
rather rare and the performance penalty is IMHO acceptable: the assumption
is that the majority of operations will operate on complete folios. COW is
certainly currently one exception worth spelling out, and it can only be
batched by COW'ing more.

HW with expensive atomic RMW operations can heavily benefit from the
optimizations; for HW with extremely fast atomic RMW operations (e.g., AMD
EPYC) -- where an atomic add seems to be just as fast as an ordinary add
-- the "no concurrent (un)mapping" result in a slowdown in most cases,
because likely "more instructions" and "more conditionals" end up resulting
in slower code.

On such HW where atomics don't dominate the costs, we'd want to disable
any "no concurrent (un)mapping" optimizations. However, such HW can handle
the additional tracking already itself much more efficiently, at least
in the "concurrent" case. The "no concurrency" case is harder to optimize.

In general: replacing per-subpage tracking by global per-folio tracking
will inherently result in cacheline contention: we already do have such
contention on the per-folio refcount.

One interesting thing to investigate is how smallish large folios behave
even after batching rmap operations: we cannot batch that much but still
have to manage the seqcount etc. Further, the performance on other
architectures/platforms/more cores will be interesting to evaluate.

[I'll note that the basic approach can be abstracted and reused in other
context, whenever multiple entities are involved, whereby each entity can
hold multiple references to an object, and we want to detect if the object
references are from a single entity, or from multiple entities.]

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Ying Huang <ying.huang@intel.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>

David Hildenbrand (20):
  mm/rmap: factor out adding folio range into __folio_add_rmap_range()
  mm: add a total mapcount for large folios
  mm: convert folio_estimated_sharers() to folio_mapped_shared() and
    improve it
  mm/rmap: pass dst_vma to page_try_dup_anon_rmap() and
    page_dup_file_rmap()
  mm/rmap: abstract total mapcount operations for partially-mappable
    folios
  atomic_seqcount: new (raw) seqcount variant to support concurrent
    writers
  mm/rmap_id: track if one ore multiple MMs map a partially-mappable
    folio
  mm: pass MM to folio_mapped_shared()
  mm: improve folio_mapped_shared() for partially-mappable folios using
    rmap IDs
  mm/memory: COW reuse support for PTE-mapped THP with rmap IDs
  mm/rmap_id: support for 1, 2 and 3 values by manual calculation
  mm/rmap: introduce folio_add_anon_rmap_range()
  mm/huge_memory: batch rmap operations in __split_huge_pmd_locked()
  mm/huge_memory: avoid folio_refcount() < folio_mapcount() in
    __split_huge_pmd_locked()
  mm/rmap_id: verify precalculated subids with CONFIG_DEBUG_VM
  atomic_seqcount: support a single exclusive writer in the absence of
    other writers
  mm/rmap_id: reduce atomic RMW operations when we are the exclusive
    writer
  atomic_seqcount: use atomic add-return instead of atomic cmpxchg on
    64bit
  mm/rmap: factor out removing folio range into
    __folio_remove_rmap_range()
  mm/rmap: perform all mapcount operations of large folios under the
    rmap seqcount

 Documentation/mm/transhuge.rst  |  12 +-
 include/linux/atomic_seqcount.h | 262 +++++++++++++++
 include/linux/mm.h              | 118 +++++--
 include/linux/mm_types.h        |  66 +++-
 include/linux/rmap.h            | 309 +++++++++++++++++-
 kernel/fork.c                   |  32 ++
 lib/Kconfig.debug               |  11 +
 mm/Kconfig                      |  21 ++
 mm/Makefile                     |   1 +
 mm/debug.c                      |   4 +-
 mm/huge_memory.c                |  47 ++-
 mm/hugetlb.c                    |  13 +-
 mm/init-mm.c                    |   4 +
 mm/internal.h                   |  10 +-
 mm/madvise.c                    |   6 +-
 mm/memory.c                     |  97 +++++-
 mm/mempolicy.c                  |  24 +-
 mm/migrate.c                    |   4 +-
 mm/page_alloc.c                 |  13 +
 mm/rmap.c                       | 370 +++++++++++++--------
 mm/rmap_id.c                    | 561 ++++++++++++++++++++++++++++++++
 21 files changed, 1745 insertions(+), 240 deletions(-)
 create mode 100644 include/linux/atomic_seqcount.h
 create mode 100644 mm/rmap_id.c


base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.41.0

