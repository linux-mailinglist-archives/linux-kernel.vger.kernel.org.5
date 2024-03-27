Return-Path: <linux-kernel+bounces-121464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6D388E838
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027F52C50C9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE7913CF9B;
	Wed, 27 Mar 2024 14:46:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533BB13CC52
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550760; cv=none; b=efK6StkfzNUecVM1gkEXPOMfXUCCXKlUGZDg2+ReHV/XtRRowG+A3YcVlHTw/pHg8yz22FxMlHV4MUYRKu355QoDQASEF5wnq7FmNAUFPKkm/j2MG5vEguZ22nuQJ+xR5qwxfDVxIXAH/4NLJ2Xs0dmIbr8fTQQBn5B16lx8Nfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550760; c=relaxed/simple;
	bh=urpLNOZKLvQ6EE4+hSYH0zcDJ4lwak85uzQzCqjptrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uHXJuk43PRGt4Cftr2s7sQ5NDuA/+zmQ6MgGYJYKkZN0qnGE6QWF2zKNaVwQVl3XazeE89aFOaWajIquh1mDKGi+qJEsJ19wUMf1wTMZpndfdrOamRqMJNnrL9l/nE+vzOnSjcBVrdBl1+U2QiT53bLlnF5psQFFIDApjxCGeoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BD601595;
	Wed, 27 Mar 2024 07:46:33 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 066593F64C;
	Wed, 27 Mar 2024 07:45:56 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Gao Xiang <xiang@kernel.org>,
	Yu Zhao <yuzhao@google.com>,
	Yang Shi <shy828301@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	Chris Li <chrisl@kernel.org>,
	Lance Yang <ioworker0@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v5 5/6] mm: vmscan: Avoid split during shrink_folio_list()
Date: Wed, 27 Mar 2024 14:45:36 +0000
Message-Id: <20240327144537.4165578-6-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240327144537.4165578-1-ryan.roberts@arm.com>
References: <20240327144537.4165578-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that swap supports storing all mTHP sizes, avoid splitting large
folios before swap-out. This benefits performance of the swap-out path
by eliding split_folio_to_list(), which is expensive, and also sets us
up for swapping in large folios in a future series.

If the folio is partially mapped, we continue to split it since we want
to avoid the extra IO overhead and storage of writing out pages
uneccessarily.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/vmscan.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 00adaf1cb2c3..293120fe54f3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1223,11 +1223,12 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					if (!can_split_folio(folio, NULL))
 						goto activate_locked;
 					/*
-					 * Split folios without a PMD map right
-					 * away. Chances are some or all of the
-					 * tail pages can be freed without IO.
+					 * Split partially mapped folios right
+					 * away. We can free the unmapped pages
+					 * without IO.
 					 */
-					if (!folio_entire_mapcount(folio) &&
+					if (data_race(!list_empty(
+						&folio->_deferred_list)) &&
 					    split_folio_to_list(folio,
 								folio_list))
 						goto activate_locked;
-- 
2.25.1


