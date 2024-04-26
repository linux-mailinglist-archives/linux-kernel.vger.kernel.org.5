Return-Path: <linux-kernel+bounces-160183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD618B3A50
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6631C24577
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887DC149C72;
	Fri, 26 Apr 2024 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RyyF7zdw"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7214883E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142723; cv=none; b=EELZERC8sDLuQsyGJ1rhNCIWFPRlyQp26IOT62eOpoHgc8rWbjqcuxGsMdWh1frknriip+HMqjsOHxDJS+gG3mZDrBFOQsltH2VBe6nimS8Rf9xo/ZfHAU8dxF99/WgEtVvDCBnpklMDnmTK6zzF+s3H0uAY0Ovg1lB3xgKDuPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142723; c=relaxed/simple;
	bh=xqXVvOrZ5ltRDA3pAq+U7GnRoZ6AOoUCgQ+NjYr6YuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9IhwDde11WPJ5l4SB6p5U4E0/9l6PAZTw/h4TWv5qIXhby1bNy6bsyjC2cJDf8e0Rby7kg8qiq5GfQuZif5Gz3bEMO/5rdtA98QIUvWXt10da2GN9O7KmPi94WNInzVqY5I+09FkaVkWMqyL0jrpRgVIkaN2mli5bxNHO4RiMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RyyF7zdw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=WfdYXkl3VmeSNFl8CeYkQkRSot5hSq2wAYXQXVO2q28=; b=RyyF7zdwWk9nDa97+eyubbdcGh
	/w28kPOhTqJkoKMGtwC13r+m64VxEWsAi8TiLuVDtxQS2gSkWj39hwiAkuY0x1wxCTh45vs8B9FTn
	sD30juuwToyG9roIfdS9dV8KS47Mv8h4eldpZC0MIv0XWa+zSjDgFtCb0N0CH3m5CjLA6W/+Ermsv
	vCRso3N6rfSCVH2Va/m/EBte6Z/aKqUBvmbYVHj936Hjj3wYAuJc77vTg2oam8yNVg16gv4t17js7
	4OfTtjSbHss3Gw2WztfJrsDnkdMN5ObcpwwKZPNiMEVbnV6Pcu+aigMm//iKd9fRHCaGg13oL7Du/
	/4x72pfw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0Mp2-00000005Pl0-0bLw;
	Fri, 26 Apr 2024 14:45:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH 1/4] mm: Assert the mmap_lock is held in __anon_vma_prepare()
Date: Fri, 26 Apr 2024 15:45:00 +0100
Message-ID: <20240426144506.1290619-2-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426144506.1290619-1-willy@infradead.org>
References: <20240426144506.1290619-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the comment into an assertion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/rmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 2608c40dffad..619d4d65d99b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -182,8 +182,6 @@ static void anon_vma_chain_link(struct vm_area_struct *vma,
  * for the new allocation. At the same time, we do not want
  * to do any locking for the common case of already having
  * an anon_vma.
- *
- * This must be called with the mmap_lock held for reading.
  */
 int __anon_vma_prepare(struct vm_area_struct *vma)
 {
@@ -191,6 +189,7 @@ int __anon_vma_prepare(struct vm_area_struct *vma)
 	struct anon_vma *anon_vma, *allocated;
 	struct anon_vma_chain *avc;
 
+	mmap_assert_locked(mm);
 	might_sleep();
 
 	avc = anon_vma_chain_alloc(GFP_KERNEL);
-- 
2.43.0


