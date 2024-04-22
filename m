Return-Path: <linux-kernel+bounces-152879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C066C8AC5A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D961C21D02
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5DB4C637;
	Mon, 22 Apr 2024 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QirCeQFD"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B3482CA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771234; cv=none; b=Kpblalot8NyYPKR96FS7/Wp8EpNq421AIQXasPif0l3Ol/iDFWE68KJwEZmqC2JNt6YPDAPIl2m13hAjivluHf0TSzjzs3t6IfgjqS5vFfA5Bc7PQGztcGshggkyIfHv7wMe2H9zEZkwl6l8xQnf3jVe6HBW4GS3vFIdLveKXqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771234; c=relaxed/simple;
	bh=iWuB0RdSEzha+PU1EP3ps4JUMpjZFDkuLXvZjc/GL7I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S9UjDDOvj/z656IsCRDkCemPO43y4zf+LGxMe8L5DnaXyDHqKhl/PPAms1+FwvcDW8jBFNg35hccuI0cJ9ToXgCZoZiy6I9JO2KVCbri7oXULHRpvYFibPv6b/3l2NPj2p3fZi4KhYe00Ji7xn056Ye0YfTjy/HAShouBsM9Dhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QirCeQFD; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713771229; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Gb6VfdI9ZtJOoS4VLbD0sYNhLEGRO2lSjQ242TZ/9Wc=;
	b=QirCeQFDlf9/uN6atLIOIp4+1oeOVuV1AUrMeHTGG3DH0ae8ZA36rfBI0MjyeqS4vCv4As+vlSEqzzGQ+zhrIsmAk45oVleOUxwYwHm1KRTuwUHIjNhWvR3nO5oqPHlc4+PxP37xYXPeaM/aFG/EhSsyanV2CD7qk9wjeUQewr4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W5.Hkrf_1713771228;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5.Hkrf_1713771228)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 15:33:48 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	ioworker0@gmail.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: huge_memory: add the missing folio_test_pmd_mappable() for THP split statistics
Date: Mon, 22 Apr 2024 15:33:43 +0800
Message-Id: <b99f8cb14bc85fdb6ab43721d1331cb5ebed2581.1713771041.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the mTHP can also be split or added into the deferred list, so add
folio_test_pmd_mappable() validation for PMD mapped THP, to avoid confusion
with PMD mapped THP related statistics.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
Changes from v1:
 - Add acked tag from David.
 - Check the THP earlier in case the folio is split per Lance.
---
 mm/huge_memory.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 716d29c21b6e..a9789ca823bc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2994,6 +2994,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
+	bool is_thp = folio_test_pmd_mappable(folio);
 	int extra_pins, ret;
 	pgoff_t end;
 	bool is_hzp;
@@ -3172,7 +3173,8 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		i_mmap_unlock_read(mapping);
 out:
 	xas_destroy(&xas);
-	count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
+	if (is_thp)
+		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
 	return ret;
 }
 
@@ -3234,7 +3236,8 @@ void deferred_split_folio(struct folio *folio)
 
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	if (list_empty(&folio->_deferred_list)) {
-		count_vm_event(THP_DEFERRED_SPLIT_PAGE);
+		if (folio_test_pmd_mappable(folio))
+			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
 		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
 		ds_queue->split_queue_len++;
 #ifdef CONFIG_MEMCG
-- 
2.39.3


