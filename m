Return-Path: <linux-kernel+bounces-73512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D3985C3A4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56CB3282993
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A99127B60;
	Tue, 20 Feb 2024 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="kHa+Dpg4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tbyb1Euf"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A9E77F13
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453960; cv=none; b=QlHdQoLEYNephFMuz94/T4Rxeb0c/QTts+b2uVlrOTLJ0OoDYb2IVvHhuKQnNyqgoLiMmiuCEDcE+eJFXBzdrka7xE9CHrazcRfJfz7JluqFu5kqmWkVADNSXfRFZSs3GusKRwroturkxkdgK5hv/fyEcjVxfNDHcCvkwHWjftI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453960; c=relaxed/simple;
	bh=9FcraHn2cUuK2kIvzHlvXsoEQRPWIFIM5vXwcEoq62U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eQBXxgG37+ydNAw6FJ54+oUeFZW0q4QGAKTFxr141wb9+HaOENXqZC7mucJ+L0b0Z59qP/AEZKqeRpgXRXVh4NVHtrI/R5dVzkjpAlV9mFJXXN/L8WL4G9CD1muLyoMxgUAf6NQDDVdBoHSP7wXzhM1i3dZPhaMv+ob/wV9JCtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=kHa+Dpg4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tbyb1Euf; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 2EFBB3200488;
	Tue, 20 Feb 2024 13:32:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 20 Feb 2024 13:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm1; t=1708453954; x=
	1708540354; bh=Huf2bIOm7lsuCQDjyWbxODs2ph/fcWRD5qUueHOel5g=; b=k
	Ha+Dpg43cCHTveu54ci/blOWmZJ9zKbY/qeleedTafIET2wz1zK+cxvYlXsiLuVn
	19s7QpYyQBiSjGYzizsfdtYkBesuh5qHs7BIJNJmDfU5X9iX2SlNw99B2Rf6pO9F
	x4sIwTYwHDbMzOXX/lHUmd9+tCfKVwWz4HnF+CNE/rNYFenPskq9lXlxe9jOdonI
	oTssDHjG07lF3p12Bhhagx/WzcJlTzyKXDSiyDCHosFKO1wG7c0kqw6kIdwDLMWo
	1yUAP/VGktZG+QSDA3I887DXYVHqxm1e8Nvvrhz6acfhlxbW6RcNBFeeTUQd38Jp
	5HN6VF5iPmeC+4sq7iX3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1708453954; x=1708540354; bh=H
	uf2bIOm7lsuCQDjyWbxODs2ph/fcWRD5qUueHOel5g=; b=Tbyb1EufPiYaez1JD
	6GOMZnYHyldztueL8kSGwP8xRvRj6tZFabxPH7AbUYt2TfWlrgi10JXGOg0bxcmd
	XdoD10USn09f7/aKnmv5XYjGkhWeOrlef+wI3an1ODahKYVsb4ZlbNObWwvX+7te
	ZwQ1D8qKlfPqRK5MEWiS2RNz7CI1CWgBAX/AgQAOr4yVB/OcNjtiRVen11JG4Heh
	90HQwjO0NoY3Ve9cmf1dNW6ktIAYvm8tUTu5IfN5m1KukUaVlPKQ4YeDoilrsCh9
	p5l4PV+N+8Xez69+AIx/gqcc9KDQ+PWBzaMedSjrhX1UYgu5Xbu3rPKo0AAvudHI
	kTDwg==
X-ME-Sender: <xms:QPDUZebpc3zY5FTNaJJM3rtu1RBQ5oMDENdHJwssOpuK4tl8J0I6rA>
    <xme:QPDUZRZXfX2IAQAjqAWwSuThGUrbx1x0r0GSz4mbZC6E9XaJn2wONyIi9SxgpydSy
    OAqijc97F94jNa9Lw>
X-ME-Received: <xmr:QPDUZY8wRF4n-RUuZOOqfUqTTdWV0NiWBPNollBtspi79HCuiFPdZJnRreb4i56vzJuu7Jug3gRV8s47vMzAsTslgemTW0jvl3X49x3NwtGKBKzwJlHtwI4f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrgggtgfesthekredtredtjeenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepkefhle
    duhffhjedttdetudejtdeuieevueetuddtuedthffffffgueffhfegjeffnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghdpfhholhhiohhsrdhmmhdptghomhhprggtthhiohhnrd
    hmmhdpshhplhhithdrmhhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:QPDUZQqTYHHK1y2UXwWW3jZJykWU_yFEzssg9Q7SppI5p-7fcLQzyg>
    <xmx:QPDUZZpbtX_FjG_RUL72k1t8r8w4-AGEytCV03_eUsuFCH5gIoyCDg>
    <xmx:QPDUZeT4Ys9Bumo7NqEe-wvrvJHYACHk0VEasU4J3H_i1xsa5CZMIA>
    <xmx:QvDUZeieOGtisJVtlJqD7ik5pPCa2GMD1TcpbC-kPnZz59WOk1LpBw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 13:32:31 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Yin, Fengwei" <fengwei.yin@intel.com>,
	Yu Zhao <yuzhao@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rohan Puri <rohan.puri15@gmail.com>,
	Mcgrof Chamberlain <mcgrof@kernel.org>,
	Adam Manzanares <a.manzanares@samsung.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v7 0/4] Enable >0 order folio memory compaction
Date: Tue, 20 Feb 2024 13:32:16 -0500
Message-ID: <20240220183220.1451315-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

Hi all,

This patchset enables >0 order folio memory compaction, which is one of
the prerequisitions for large folio support[1]. It is on top of
mm-everything-2024-02-20-04-19 (with V6 removed).

I am aware of that split free pages is necessary for folio
migration in compaction, since if >0 order free pages are never split
and no order-0 free page is scanned, compaction will end prematurely due
to migration returns -ENOMEM. Free page split becomes a must instead of
an optimization.

lkp ncompare results (on a 8-CPU (Intel Xeon E5-2650 v4 @2.20GHz) 16G VM)
for default LRU (-no-mglru) and CONFIG_LRU_GEN are shown at the bottom,
copied from V3[4].
In sum, most of vm-scalability applications do not see performance
change, and the others see ~4% to ~26% performance boost under default LRU
and ~2% to ~6% performance boost under CONFIG_LRU_GEN.


Changelog
===

From V6 [7]:
1. Properly commented skip_isolation_on_order() (per David Hildenbrand).

2. Fixed folio_test_large() check (per David Hildenbrand).

3. Used is_via_compact_memory() instead of order == -1 check (per David
Hildenbrand).


From V5 [6]:
1. Removed unused parameter in prepare_free_pages() and used it instead
of my old prepare_free_pages_fpi_none() (per Vlastimil Babka).

2. Removed unnecessary INIT_LIST_HEAD() in compaction_free()
(per Vlastimil Babka).

3. Fixed cc->nr_migratepages update in compaction_free()
(per Vlastimil Babka).


From V4 [5]:
1. Refactored code in compaction_alloc() in Patch 3 (per Yu Zhao).


From V3 [4]:
1. Restructured isolate_migratepages_block() to minimize PageHuge() use
in Patch 1 (per Vlastimil Babka).

2. Used folio_put_testzero() instead of folio_set_count() to properly
handle free pages in compaction_free() (per Vlastimil Babka).

3. Simplified code to use struct list_head instead of a new struct page_list
(per Vlastimil Babka).

4. Restructured compaction_alloc() code to reduce indentation and
increase readability (per Vlastimil Babka).


From V2 [3]:
1. Added missing free page count in fast isolation path. This fixed the
weird performance outcome.


From V1 [2]:
1. Used folio_test_large() instead of folio_order() > 0. (per Matthew
Wilcox)

2. Fixed code rebase error. (per Baolin Wang)

3. Used list_split_init() instead of list_split(). (per Ryan Boberts)

4. Added free_pages_prepare_fpi_none() to avoid duplicate free page code
in compaction_free().

5. Dropped source page order sorting patch.


From RFC [1]:
1. Enabled >0 order folio compaction in the first patch by splitting all
to-be-migrated folios. (per Huang, Ying)

2. Stopped isolating compound pages with order greater than cc->order
to avoid wasting effort, since cc->order gives a hint that no free pages
with order greater than it exist, thus migrating the compound pages will fail.
(per Baolin Wang)

3. Retained the folio check within lru lock. (per Baolin Wang)

4. Made isolate_freepages_block() generate order-sorted multi lists.
(per Johannes Weiner)

Overview
===

To support >0 order folio compaction, the patchset changes how free pages used
for migration are kept during compaction. Free pages used to be split into
order-0 pages that are post allocation processed (i.e., PageBuddy flag cleared,
page order stored in page->private is zeroed, and page reference is set to 1).
Now all free pages are kept in a NR_PAGE_ORDER array of page lists based
on their order without post allocation process. When migrate_pages() asks for
a new page, one of the free pages, based on the requested page order, is
then processed and given out. And THP <2MB would need this feature.


Feel free to give comments and ask questions.

Thanks.

[1] https://lore.kernel.org/linux-mm/f8d47176-03a8-99bf-a813-b5942830fd73@arm.com/
[2] https://lore.kernel.org/linux-mm/20231113170157.280181-1-zi.yan@sent.com/
[3] https://lore.kernel.org/linux-mm/20240123034636.1095672-1-zi.yan@sent.com/
[4] https://lore.kernel.org/linux-mm/20240202161554.565023-1-zi.yan@sent.com/
[5] https://lore.kernel.org/linux-mm/20240212163510.859822-1-zi.yan@sent.com/
[6] https://lore.kernel.org/linux-mm/20240214220420.1229173-1-zi.yan@sent.com/
[7] https://lore.kernel.org/linux-mm/20240216170432.1268753-1-zi.yan@sent.com/



vm-scalability results on CONFIG_LRU_GEN
===

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalability

commit: 
  6.8.0-rc1-mm-everything-2024-01-29-07-19+
  6.8.0-rc1-split-folio-in-compaction+
  6.8.0-rc1-folio-migration-in-compaction+
  6.8.0-rc1-folio-migration-free-page-split+

6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i 6.8.0-rc1-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
  15107616            +3.2%   15590339            +1.3%   15297619            +3.0%   15567998        vm-scalability.throughput

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq/vm-scalability

commit: 
  6.8.0-rc1-mm-everything-2024-01-29-07-19+
  6.8.0-rc1-split-folio-in-compaction+
  6.8.0-rc1-folio-migration-in-compaction+
  6.8.0-rc1-folio-migration-free-page-split+

6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i 6.8.0-rc1-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
  12611785            +1.8%   12832919            +0.9%   12724223            +1.6%   12812682        vm-scalability.throughput


=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/lru-file-readtwice/vm-scalability

commit: 
  6.8.0-rc1-mm-everything-2024-01-29-07-19+
  6.8.0-rc1-split-folio-in-compaction+
  6.8.0-rc1-folio-migration-in-compaction+
  6.8.0-rc1-folio-migration-free-page-split+

6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i 6.8.0-rc1-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
   9833393            +5.7%   10390190            +3.0%   10126606            +5.9%   10408804        vm-scalability.throughput

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/lru-file-mmap-read/vm-scalability

commit: 
  6.8.0-rc1-mm-everything-2024-01-29-07-19+
  6.8.0-rc1-split-folio-in-compaction+
  6.8.0-rc1-folio-migration-in-compaction+
  6.8.0-rc1-folio-migration-free-page-split+

6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i 6.8.0-rc1-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
   7034709 ±  3%      +2.9%    7241429            +3.2%    7256680 ±  2%      +3.9%    7308375        vm-scalability.throughput



vm-scalability results on default LRU (with -no-mglru suffix)
===

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalability

commit: 
  6.8.0-rc1-mm-everything-2024-01-29-07-19-no-mglru+
  6.8.0-rc1-split-folio-in-compaction-no-mglru+
  6.8.0-rc1-folio-migration-in-compaction-no-mglru+
  6.8.0-rc1-folio-migration-free-page-split-no-mglru+

6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i 6.8.0-rc1-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
  14401491            +3.7%   14940270            +2.4%   14748626            +4.0%   14975716        vm-scalability.throughput

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq/vm-scalability

commit: 
  6.8.0-rc1-mm-everything-2024-01-29-07-19-no-mglru+
  6.8.0-rc1-split-folio-in-compaction-no-mglru+
  6.8.0-rc1-folio-migration-in-compaction-no-mglru+
  6.8.0-rc1-folio-migration-free-page-split-no-mglru+

6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i 6.8.0-rc1-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
  11407497            +5.1%   11989632            -0.5%   11349272            +4.8%   11957423        vm-scalability.throughput

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq-mt/vm-scalability

commit: 
  6.8.0-rc1-mm-everything-2024-01-29-07-19-no-mglru+
  6.8.0-rc1-split-folio-in-compaction-no-mglru+
  6.8.0-rc1-folio-migration-in-compaction-no-mglru+
  6.8.0-rc1-folio-migration-free-page-split-no-mglru+

6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i 6.8.0-rc1-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
  11348474            +3.3%   11719453            -1.2%   11208759            +3.7%   11771926        vm-scalability.throughput

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/lru-file-readtwice/vm-scalability

commit: 
  6.8.0-rc1-mm-everything-2024-01-29-07-19-no-mglru+
  6.8.0-rc1-split-folio-in-compaction-no-mglru+
  6.8.0-rc1-folio-migration-in-compaction-no-mglru+
  6.8.0-rc1-folio-migration-free-page-split-no-mglru+

6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i 6.8.0-rc1-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
   8065614 ±  3%      +7.7%    8686626 ±  2%      +5.0%    8467577 ±  4%     +11.8%    9016077 ±  2%  vm-scalability.throughput

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/lru-file-mmap-read/vm-scalability

commit: 
  6.8.0-rc1-mm-everything-2024-01-29-07-19-no-mglru+
  6.8.0-rc1-split-folio-in-compaction-no-mglru+
  6.8.0-rc1-folio-migration-in-compaction-no-mglru+
  6.8.0-rc1-folio-migration-free-page-split-no-mglru+

6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i 6.8.0-rc1-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
   6438422 ±  2%     +27.5%    8206734 ±  2%     +10.6%    7118390           +26.2%    8127192 ±  4%  vm-scalability.throughput

Zi Yan (4):
  mm/page_alloc: remove unused fpi_flags in free_pages_prepare()
  mm/compaction: enable compacting >0 order folios.
  mm/compaction: add support for >0 order folio memory compaction.
  mm/compaction: optimize >0 order folio compaction with free page
    split.

 mm/compaction.c | 260 ++++++++++++++++++++++++++++++++----------------
 mm/internal.h   |   4 +-
 mm/page_alloc.c |  12 +--
 3 files changed, 186 insertions(+), 90 deletions(-)

-- 
2.43.0


