Return-Path: <linux-kernel+bounces-34687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8480838623
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222E21F2508C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDDE1854;
	Tue, 23 Jan 2024 03:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="MKAFpRQz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E+uH+U3j"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267C8139F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705981630; cv=none; b=kHU7FOdpUryO7pWlt6cMZx8DxP9OYsoLAuaeeIAIIowk9EwaahstG631cVDkpEuy79Qpc0tIRcplf7ES1sBzrw04M8zcX+OMz2PwJEczbMFdN2H4l8AlRx0oU+uoxR2D+yf5ljJ97pJ4Bm2BGJCIDbaHn4bxmO+zKggi+iVSTQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705981630; c=relaxed/simple;
	bh=8WeKfAJJdh73qrTR41NhYhBGB+4RtvowBQtQCm9rX+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rXeYqA4qKTvEuuUHPYEoc0TNCRS5Q8kygvCvZ/H1WzchFhILeVhOWeurSxb9dqYnGkX/5YCnXQIgGsrxzC+bPsvP42coD7u73H2pjOhKRTpCenJprgtNtIynbI+bhcQnqai/2sfYG0x+fhwgCmCMpLjOST93u4fwdO48twxqCS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=MKAFpRQz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E+uH+U3j; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 116055C00C3;
	Mon, 22 Jan 2024 22:47:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 22 Jan 2024 22:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm3; t=1705981627; x=
	1706068027; bh=XqJNwykVxovHJhKF3uvN/x6G6k4XWN03Y1NwhgTnc4I=; b=M
	KAFpRQzDH2UtE/NXJgtDZvOq+6OOT/ip1efW9lW3D8PtmbiKtSapMvWGtqHWicA/
	9GxTB0lv5fv3E+jExTa5ntWgwT/fXHcixb/KaePeKSYcb6/FeF8tuulzvXs38IuS
	jmenaMKkLqKUPIaK4qqkkFHYuYIEl0bJvpQq/4cWAru/cGNu9lnpvNigw261MR6P
	mc8dnJry36aE5RttCW4z53tC8s58b9Aw1WWYSBBijfiut75WTO+n8Y/r7ms/+WHb
	RfG+xGdRf9/KVZLE5CYJ+jBiU3JmB/jO4Cl19kCFi3izaN2w1Lp4DnkDN28joU9g
	3XBkDXEdRf4K5Osv7UWsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1705981627; x=1706068027; bh=X
	qJNwykVxovHJhKF3uvN/x6G6k4XWN03Y1NwhgTnc4I=; b=E+uH+U3jWeuWPyEv1
	60xIHct/3a9f/lZiO2HFhQ7H/fP3eG8ZIgx64sAC56nYA4utyYU2sV79M5r8Iht/
	qpN7aW025pPFursnnIC7oYTrooox5h+9+w+2zkzaPZglmvVCPEn3zvh4k2P8bY5x
	wYmtqbeThBSlLwirYmQJMKiPKXk4INv5NuhZxOzzdly/WmZVK0PuKOpLF8SciWnW
	GKZgFGpqzk9CPibIxMK8u0y8Evh+zsQ0HqCTvtVNV1EFpO3NR/avV8awzyKO951G
	igb81iUdp0sla6vRWIR9pv3CkYzdOILbjPrI+yjyiKCF0gMM2bRsnnW9TaG7MQAL
	T2RHw==
X-ME-Sender: <xms:ujavZSXrHLih1l_xVwD2rMnmX37Hxj9bUm-HrGrvv9eH27s4bYWs2w>
    <xme:ujavZel4pYPhYcXlwbjeYTLF3E4ok69ZOOZskhSc7KG3apAXsxKdRK3s1Nm5PqZnU
    lBsUuWo1S1-prNLtg>
X-ME-Received: <xmr:ujavZWYpQjTwPqafJJClSupQNma1-5blfFp3dgHVKGWky27HBX9dKyeQwK3SKosSixP4fxCCf84CSoQkbK5ypWDmSRpD_taS2P-2WOcuZ--5TdcTNTAoEru8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekjedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrgggtgfesthekredtredtjeenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepkefhle
    duhffhjedttdetudejtdeuieevueetuddtuedthffffffgueffhfegjeffnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghdpfhholhhiohhsrdhmmhdptghomhhprggtthhiohhnrd
    hmmhdpshhplhhithdrmhhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:ujavZZWwSJTrRqtQf9Ky_Xmyptp_6EWxGf2E2p-NsBEnfYo7wZl3Cg>
    <xmx:ujavZcnROK0EiVCP07y4ai97wTe2MdaCdgYfSWlZKV0QVNfGu7PdwA>
    <xmx:ujavZeeE3gE3OL3Sql6a46zK-cWcgBJE1v9Woxl-fOtM2XogfdlnJw>
    <xmx:uzavZbdtHhIpewVJ7Lv8V_ISsh4kn_XwkrnWC0oGhGVutzKoHdnhGw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 22:47:05 -0500 (EST)
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
Subject: [PATCH v2 0/3] Enable >0 order folio memory compaction
Date: Mon, 22 Jan 2024 22:46:32 -0500
Message-ID: <20240123034636.1095672-1-zi.yan@sent.com>
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
mm-everything-2024-01-18-22-21.

I am aware of that split free pages is necessary for folio
migration in compaction, since if >0 order free pages are never split
and no order-0 free page is scanned, compaction will end prematurely due
to migration returns -ENOMEM. Free page split becomes a must instead of
an optimization.

Some applications from vm-scalability show different performance trends
on default LRU and CONFIG_LRU_GEN from patch 1 (split folio during compaction),
to patch 2 (folio migration during compaction), to patch 3 (folio
migration during compaction with free page split). I am looking into it.

lkp ncompare results (with >5% delta) for default LRU and CONFIG_LRU_GEN are
shown at the bottom (on a 8-CPU (Intel Xeon E5-2650 v4 @ 2.20GHz) 16G VM).


Changelog
===

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
Now all free pages are kept in a MAX_ORDER+1 array of page lists based
on their order without post allocation process. When migrate_pages() asks for
a new page, one of the free pages, based on the requested page order, is
then processed and given out.


Feel free to give comments and ask questions.

Thanks.

[1] https://lore.kernel.org/linux-mm/20230912162815.440749-1-zi.yan@sent.com/
[2] https://lore.kernel.org/linux-mm/20231113170157.280181-1-zi.yan@sent.com/

vm-scalability results on CONFIG_LRU_GEN
===

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/small-allocs/vm-scalability

commit: 
  6.7.0-rc4+
  6.7.0-rc4-split-folio-in-compaction+
  6.7.0-rc4-folio-migration-in-compaction+
  6.7.0-rc4-folio-migration-free-page-split+

      6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration-i 6.7.0-rc4-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
   2024326           +35.5%    2743772 ± 41%    +364.0%    9392198 ± 35%     +31.0%    2651634        vm-scalability.throughput

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/small-allocs-mt/vm-scalability

commit: 
  6.7.0-rc4+
  6.7.0-rc4-split-folio-in-compaction+
  6.7.0-rc4-folio-migration-in-compaction+
  6.7.0-rc4-folio-migration-free-page-split+

      6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration-i 6.7.0-rc4-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
   1450189            +0.9%    1463418           +30.4%    1891610 ± 22%      +0.3%    1454100        vm-scalability.throughput

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalability

commit: 
  6.7.0-rc4+
  6.7.0-rc4-split-folio-in-compaction+
  6.7.0-rc4-folio-migration-in-compaction+
  6.7.0-rc4-folio-migration-free-page-split+

      6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration-i 6.7.0-rc4-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
  14428848 ± 27%     -51.7%    6963308 ± 73%     +13.5%   16372621           +11.2%   16046511        vm-scalability.throughput

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq/vm-scalability

commit: 
  6.7.0-rc4+
  6.7.0-rc4-split-folio-in-compaction+
  6.7.0-rc4-folio-migration-in-compaction+
  6.7.0-rc4-folio-migration-free-page-split+

      6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration-i 6.7.0-rc4-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
  13569502 ± 24%     -45.9%    7340064 ± 59%     +12.3%   15240531           +10.4%   14983705        vm-scalability.throughput

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq-mt/vm-scalability

commit: 
  6.7.0-rc4+
  6.7.0-rc4-split-folio-in-compaction+
  6.7.0-rc4-folio-migration-in-compaction+
  6.7.0-rc4-folio-migration-free-page-split+

      6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration-i 6.7.0-rc4-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
  13305823 ± 24%     -45.1%    7299664 ± 56%     +12.5%   14974725           +10.4%   14695963        vm-scalability.throughput

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/lru-file-readtwice/vm-scalability

commit: 
  6.7.0-rc4+
  6.7.0-rc4-split-folio-in-compaction+
  6.7.0-rc4-folio-migration-in-compaction+
  6.7.0-rc4-folio-migration-free-page-split+

      6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration-i 6.7.0-rc4-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
  13244376 ± 28%     +54.2%   20425838 ± 23%      -4.4%   12660113 ±  3%      -9.0%   12045809 ±  3%  vm-scalability.throughput

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/lru-file-mmap-read/vm-scalability

commit: 
  6.7.0-rc4+
  6.7.0-rc4-split-folio-in-compaction+
  6.7.0-rc4-folio-migration-in-compaction+
  6.7.0-rc4-folio-migration-free-page-split+

      6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration-i 6.7.0-rc4-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
   7021425 ± 11%     -20.9%    5556751 ± 19%     +14.8%    8057811 ±  3%      +9.4%    7678613 ±  4%  vm-scalability.throughput

=========================================================================================
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/256G/qemu-vm/msync/vm-scalability

commit: 
  6.7.0-rc4+
  6.7.0-rc4-split-folio-in-compaction+
  6.7.0-rc4-folio-migration-in-compaction+
  6.7.0-rc4-folio-migration-free-page-split+

      6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration-i 6.7.0-rc4-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
   1208994 ±137%    +263.5%    4394683 ± 49%     -49.4%     611204 ±  6%     -48.1%     627937 ± 13%  vm-scalability.throughput



vm-scalability results on default LRU (with -no-mglru suffix)
===

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/lru-file-readtwice/vm-scalability

commit: 
  6.7.0-rc4-no-mglru+
  6.7.0-rc4-split-folio-in-compaction-no-mglru+
  6.7.0-rc4-folio-migration-in-compaction-no-mglru+
  6.7.0-rc4-folio-migration-free-page-split-no-mglru+

6.7.0-rc4-no-mgl 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration-i 6.7.0-rc4-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
   8412072 ±  3%     +32.1%   11114537 ± 41%      +3.5%    8703491 ±  3%      +1.5%    8536343 ±  3%  vm-scalability.throughput

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/lru-file-mmap-read/vm-scalability

commit: 
  6.7.0-rc4-no-mglru+
  6.7.0-rc4-split-folio-in-compaction-no-mglru+
  6.7.0-rc4-folio-migration-in-compaction-no-mglru+
  6.7.0-rc4-folio-migration-free-page-split-no-mglru+

6.7.0-rc4-no-mgl 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration-i 6.7.0-rc4-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
   7095358           +10.8%    7863635 ± 16%      +5.5%    7484110            +1.5%    7200666 ±  4%  vm-scalability.throughput


Zi Yan (3):
  mm/compaction: enable compacting >0 order folios.
  mm/compaction: add support for >0 order folio memory compaction.
  mm/compaction: optimize >0 order folio compaction with free page
    split.

 mm/compaction.c | 218 ++++++++++++++++++++++++++++++++++--------------
 mm/internal.h   |   9 +-
 mm/page_alloc.c |   6 ++
 3 files changed, 169 insertions(+), 64 deletions(-)

-- 
2.43.0


