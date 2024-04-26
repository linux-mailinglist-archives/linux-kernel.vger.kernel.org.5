Return-Path: <linux-kernel+bounces-160179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 085828B3A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B519D287D93
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EC0148313;
	Fri, 26 Apr 2024 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hc21nnLK"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B88A146016
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142711; cv=none; b=r7pDMfd1wuDNAQqg1GeiK3w9ejvG+RexkZvKg9qmwXT0jRWHs0r7PpmJx0Gbuu4iwMJACjs6vKL0vmgs5qcevVsRcRvQO0Tddptod9Hwpu4YvV9blYegqIdTA7XdIaAR5LIzgdrfVqHcYaFTYe4sy7pRlNWxScTIszeDqB0vs6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142711; c=relaxed/simple;
	bh=v4fL2+yWfwhhIaV16KWtSLzraYDvLVna8wTgjNalvkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oa8D9EIxFMhSZO3xU91OTVNiP9q5lUPgjYUb0/w2eJYOARGUeqdVPm1U1ZQpMYwXPEsy0GQgdsikYG5jRQVlT3tNE38yFB+6FewUVQ7ED1Vr5kTzBvX3tkw9xb+Lskpy7rHOotHnbRAAtWMTvJ+EKkryWaLk2kJg/SCou4I0gAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hc21nnLK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=o7qI+oHpjf5yEmGWpYFrF9RlIktcdn3SLb9+EApTOWc=; b=hc21nnLKTaS/q3yIYyF6Vjl6qN
	qgj47dlUDUKMu8LeYDfZS4FOXx0YIafZ8N8AeA4WrulGwM01v67I9oL+aZ+FGNQXLWjRMToW9ha6y
	rQhqlwqQe4dfyIrWmE7HYS4qOMlPFF0X1R9Q2S7k6JO6D2+qNccN/eoeLKAuOgFTeJMvne2HTn8AB
	BKo8ZzbxCpk2EmdV8n6DbGeNqSRYzl9QQ0l3U8PNV9fa0YyucQbarv9ovcNXWCaqheh5ILbQpuhPS
	/3T5XpPnF4fbHGrj8HlqZS9RVF84QKUHjHFBhjFNTfCdwMmglocimUzHk9pBKNJq0Sg891L+q0adz
	6jXW4mmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0Mp2-00000005Pky-0EQm;
	Fri, 26 Apr 2024 14:45:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH 0/4] Improve anon_vma scalability for anon VMAs
Date: Fri, 26 Apr 2024 15:44:59 +0100
Message-ID: <20240426144506.1290619-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a 3x throughput improvement reported by Intel's kernel test
robot: https://lore.kernel.org/all/202404261055.c5e24608-oliver.sang@intel.com/

This is from delaying taking the mmap_lock for page faults until we
actually need the mmap_lock in order to assign an anon_vma to the vma.
It cleans up the page fault path a little by making the anon fault
handler more similar to the file fault handler.

Matthew Wilcox (Oracle) (4):
  mm: Assert the mmap_lock is held in __anon_vma_prepare()
  mm: Delay the check for a NULL anon_vma
  mm: Fix some minor per-VMA lock issues in userfaultfd
  mm: Optimise vmf_anon_prepare() for VMAs without an anon_vma

 mm/huge_memory.c |  6 ++++--
 mm/memory.c      | 42 +++++++++++++++++++++++++++---------------
 mm/rmap.c        |  3 +--
 mm/userfaultfd.c | 20 +++++++++-----------
 4 files changed, 41 insertions(+), 30 deletions(-)

-- 
2.43.0


