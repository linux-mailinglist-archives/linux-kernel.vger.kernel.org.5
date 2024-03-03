Return-Path: <linux-kernel+bounces-89661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AA286F3CC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 07:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AA51F220C7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 06:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601C4A958;
	Sun,  3 Mar 2024 06:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jnh71ZnL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B9EA93A
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 06:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709446678; cv=none; b=C4i+qRWvGPD9NTGhdWUXsF0xMGsCBAuD5efV+b1e3EMSNJGe9sdnYRe1ngOdKs9DXRxe3wIJNkyJ5jcTcqdZVAUF7ikQvxmuCIOKBap+9n2pcIQCgqNXBRi9t7ULdcLlMkrsLGGbMZJwmxLlvXEe5AfT6pmwvx1o0OLYz9ZZ/6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709446678; c=relaxed/simple;
	bh=bDEK6c2BjoMhmUAk+RQsAlhDmAN/H7P6w4YunFmCdYI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KumGG7AyASLZdoCggldRxZ0opzVZKLzSrNO28eOp8ByeZQ6jEDUSeeXuZvXKd+65gqTuDX8MBnfGHDtOI4kzseiqIVJVRqGlpGDnk0yQTfmPRYpP9Z3iSwA8UE2ow4vN9eptDaWTX4X8jvLPE5CtATedTscMBt/ZKraBmDOIImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jnh71ZnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AB3C433C7;
	Sun,  3 Mar 2024 06:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709446678;
	bh=bDEK6c2BjoMhmUAk+RQsAlhDmAN/H7P6w4YunFmCdYI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Jnh71ZnLqC9WXN3z6qJc1CKgt7N3C//7qq9exzhPmlknaIdEn2eHqQCs/RQppJeEx
	 kZs6Iy/bADDiN+2S+0ayWEAuQeWUKZAVQUjRzFtLxhOpafXsq83uhpZJZsKQvfcXIo
	 OlCtVmUQf5CD+vF+A9PoL0h3TEYWNGZAVPkksB6cgFwUfOu9a/ShxhTEnnsobZIh0F
	 3wkDHTfqTKHYLz9z30eVS/lWQZzGMSdX7tZeEBp2MeDh64kcyMSE14JZp0+S34fB2A
	 CwGZwmuI32T3O+UC6MPw4rhPI7QeOIMCLymLmbOzC4OCTO9aDBFE8HFzc3ePOQCdqJ
	 mKe7UI7PvEBLQ==
X-Mailer: emacs 29.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Michal Hocko <mhocko@suse.com>, "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Donet Tom <donettom@linux.ibm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mel Gorman <mgorman@suse.de>,
	Ben Widawsky <ben.widawsky@intel.com>,
	Feng Tang <feng.tang@intel.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@surriel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 1/3] mm/mempolicy: Use the already fetched local variable
In-Reply-To: <ZdRq9EM1mDFXBiiO@tiehlicka>
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
 <20240218133851.22c22b55460e866a099be5ce@linux-foundation.org>
 <63a0f7c4-3c3f-4097-9a24-d1e3fc7b6030@linux.ibm.com>
 <20240219172130.82a16c1ebecbf8ba86a8987d@linux-foundation.org>
 <21f343fa-84a7-4539-91e2-6fc963dbfb62@kernel.org>
 <87frxnps8w.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <7097ff95-6077-4744-a770-b90d224c0c9b@kernel.org>
 <b599bfe5-1c4d-4750-b0d6-a086e1c8a34c@kernel.org>
 <8734tnppls.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZdRq9EM1mDFXBiiO@tiehlicka>
Date: Sun, 03 Mar 2024 11:47:47 +0530
Message-ID: <875xy3ltys.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michal Hocko <mhocko@suse.com> writes:

> On Tue 20-02-24 15:22:07, Huang, Ying wrote:
> [...]
>> This isn't an issue now, because mpol_misplaced() are always called with
>> PTL held.  And, we can still keep thiscpu local variable.
>
> yes, this is the case but it would be better if we made that assumption
> official by lockdep_assert_held
>

How about this folded into this patch?

2 files changed, 12 insertions(+), 4 deletions(-)
mm/memory.c    |  6 ++++--
mm/mempolicy.c | 10 ++++++++--

modified   mm/memory.c
@@ -4879,9 +4879,11 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-int numa_migrate_prep(struct folio *folio, struct vm_area_struct *vma,
+int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
 		      unsigned long addr, int page_nid, int *flags)
 {
+	struct vm_area_struct *vma = vmf->vma;
+
 	folio_get(folio);
 
 	/* Record the current PID acceesing VMA */
@@ -4893,7 +4895,7 @@ int numa_migrate_prep(struct folio *folio, struct vm_area_struct *vma,
 		*flags |= TNF_FAULT_LOCAL;
 	}
 
-	return mpol_misplaced(folio, vma, addr);
+	return mpol_misplaced(folio, vmf, addr);
 }
 
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
modified   mm/mempolicy.c
@@ -2495,18 +2495,24 @@ static inline bool mpol_preferred_should_numa_migrate(int exec_node, int folio_n
  * Return: NUMA_NO_NODE if the page is in a node that is valid for this
  * policy, or a suitable node ID to allocate a replacement folio from.
  */
-int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
+int mpol_misplaced(struct folio *folio, struct vm_fault *vmf,
 		   unsigned long addr)
 {
 	struct mempolicy *pol;
 	pgoff_t ilx;
 	struct zoneref *z;
 	int curnid = folio_nid(folio);
+	struct vm_area_struct *vma = vmf->vma;
 	int thiscpu = raw_smp_processor_id();
-	int thisnid = cpu_to_node(thiscpu);
+	int thisnid = numa_node_id();
 	int polnid = NUMA_NO_NODE;
 	int ret = NUMA_NO_NODE;
 
+	/*
+	 * Make sure ptl is held so that we don't preempt and we
+	 * have a stable smp processor id
+	 */
+	lockdep_assert_held(vmf->ptl);
 	pol = get_vma_policy(vma, addr, folio_order(folio), &ilx);
 	if (!(pol->flags & MPOL_F_MOF))
 		goto out;

[back]
 

