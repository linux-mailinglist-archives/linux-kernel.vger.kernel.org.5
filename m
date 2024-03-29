Return-Path: <linux-kernel+bounces-124218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 745DE8913F9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 164C7B23AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844183D54B;
	Fri, 29 Mar 2024 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fTOUGTCQ"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153823D0AD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711695586; cv=none; b=pzgFsI5MDU6B7aLjAQKkYH5+K2YEU7y/Avveq8cZxmJksHgB6JF61TAFMaMTjxDUyXMuevI0YICzbzIdBKy+uv6ZyupyfoIrqWGaX4nadVwrlt2VaIxHkJNauMpWIyepNITyd/SGS1LJlLGkhLznKeZHROWmx7Y7GOCuQdOPTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711695586; c=relaxed/simple;
	bh=MlvTnEko9J0D72PKDus8a0pEMZiiHf0b5YcP7UzLbdE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gyPIvqX+DzwU1xpF9ituWUG956fSYBacPBLAck5P9FjSNyDe4criwHPhbXl9Z3YtR98VLhNBtAunX+Y6R5NXaI7MCMXYpxAwCNEZ9+bN/Dci/5PheHN6pvSZ9F+brWlrGvL33ERNqKSXpvPGD5Pg0AqMxUbIPaySyL2Fd1zRr84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fTOUGTCQ; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711695583; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+X5dDvewMP3Tm1C12o/ZlZF+7bV0b6t6gUSDEC10khs=;
	b=fTOUGTCQE3bN2OB3zN8m2guHWxFqAN6EHQJulzemav+T4I5/vtEnHISWBOylp7KYYBBuclBpmZxTl4KUnMq4fCsAxdJEcg4hkH26JJSHB/+3LeI1OzRXGP57CShIQ6F0pJBePplyfvoVEg2Hsr/LYLkpodaYVGS279GyjL0NQ3E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W3Vft4F_1711695582;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W3Vft4F_1711695582)
          by smtp.aliyun-inc.com;
          Fri, 29 Mar 2024 14:59:42 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: huge_memory: add the missing folio_test_pmd_mappable() for THP split statistics
Date: Fri, 29 Mar 2024 14:59:33 +0800
Message-Id: <a5341defeef27c9ac7b85c97f030f93e4368bbc1.1711694852.git.baolin.wang@linux.alibaba.com>
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
---
 mm/huge_memory.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1683de78c313..3ca9282a0dc9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3109,7 +3109,8 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		i_mmap_unlock_read(mapping);
 out:
 	xas_destroy(&xas);
-	count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
+	if (folio_test_pmd_mappable(folio))
+		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
 	return ret;
 }
 
@@ -3171,7 +3172,8 @@ void deferred_split_folio(struct folio *folio)
 
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


