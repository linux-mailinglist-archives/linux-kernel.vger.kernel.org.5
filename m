Return-Path: <linux-kernel+bounces-152819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ECB8AC4B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498D81C20DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6F54CB4E;
	Mon, 22 Apr 2024 07:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="goBv34hw"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2019495F0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769388; cv=none; b=XNGUCUv/Rgf9EQ3LZu1JjoZZjF9JcN0CxYZpf+tTnbxTyOhP1be/JzPdeE31CUK62HyzQHVtQZAaYybYG1I4iJTfk0sQzU3OwUFCPS6atFackVE8UGdGUtW6UVctbcsZDYIsmRL1jwleYe4BkjVeGTo+8d5L5q5FZkZJqMTyOdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769388; c=relaxed/simple;
	bh=lv5PqU5g2qQjCdgqUVI5mkhEGLV73xIpYwqgswJR48g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PAaWkZpz6bwAgWmBc47wJkI1Td5/La+0OOd99W+rk9ZeF7KL9j41AgmFrJyUfMk6oAds+b0VEncPKFfWcvK4Rdthc/foIb8y9R/UtxG9ekJftYTb/ihAE+2D3QacZFibicOim3CB0Bd/MFwOvAuBOec2w00LYlWvzGx7gQCemlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=goBv34hw; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713769381; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0SsdcViQ2lxDH4gZYEPPhvXdWD/avqV+Env2Q3pLz7o=;
	b=goBv34hww93Jw8e3t4O4G8/ufkQgeZVJPNDOb3rqoX9XQhrlJAT2O4fZRs9/hlu+FvA1+/mfSnm9tSQr/+tOEHwv1iSKQnBjA66Az/Hv1YLNMWKnQJ1nm6mp9L/LikHGKe32xORmnNg/TCsFSFgoV3UYW3hAY0yMJGjNLb/yA0c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W5-amKe_1713769378;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5-amKe_1713769378)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 15:02:59 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/5] mm: shmem: add THP validation for PMD-mapped THP related statistics
Date: Mon, 22 Apr 2024 15:02:41 +0800
Message-Id: <4107dcc957f3b62a37c83e30ca22305c373ef149.1713755580.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to extend support for mTHP, add THP validation for PMD-mapped THP
related statistics to avoid statistical confusion.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 893c88efc45f..b4afda71a3f0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1662,7 +1662,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
 			return ERR_PTR(-E2BIG);
 
 		folio = shmem_alloc_hugefolio(gfp, info, index, order);
-		if (!folio)
+		if (!folio && pages == HPAGE_PMD_NR)
 			count_vm_event(THP_FILE_FALLBACK);
 	} else {
 		pages = 1;
@@ -1680,7 +1680,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
 		if (xa_find(&mapping->i_pages, &index,
 				index + pages - 1, XA_PRESENT)) {
 			error = -EEXIST;
-		} else if (huge) {
+		} else if (pages == HPAGE_PMD_NR) {
 			count_vm_event(THP_FILE_FALLBACK);
 			count_vm_event(THP_FILE_FALLBACK_CHARGE);
 		}
@@ -2046,7 +2046,8 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		folio = shmem_alloc_and_add_folio(huge_gfp,
 				inode, index, fault_mm, true);
 		if (!IS_ERR(folio)) {
-			count_vm_event(THP_FILE_ALLOC);
+			if (folio_test_pmd_mappable(folio))
+				count_vm_event(THP_FILE_ALLOC);
 			goto alloced;
 		}
 		if (PTR_ERR(folio) == -EEXIST)
-- 
2.39.3


