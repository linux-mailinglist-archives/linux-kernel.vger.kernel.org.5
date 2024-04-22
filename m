Return-Path: <linux-kernel+bounces-152822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1068D8AC4B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ADC1B21444
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7F74AEE5;
	Mon, 22 Apr 2024 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NY06ytDd"
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EDD4E1D2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769400; cv=none; b=VqXRYSe7XMwMHBjwSb0DyWVYys6B1XFCO7hh7D/CQ9g9D/VnBsCMiLjC3j0aNhX+M8eOG28BrujsvCMaPPIiDFZEgXhfPkz5T7TYXTKE+s/ZBBJo918E3rgm37D1wh8Df3VgpPwnKUhcyd538vNKRDNl9ewU79ozRzrDZOweoh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769400; c=relaxed/simple;
	bh=ItrSE0/IiQfbtdgPm+4vgP6ZkRS2znwH+LvZWGKpYXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FXmeoi3wE57oTF5MZ/IbwNjRhBhs1Ap6SAIcFJAHTrwdsgB9wowsp18eCwwo36zJwCqDgPMP3Oh/XwooorZZ2c5+wTgGwIdcNfKJR8W2tN3GbzMk0/PmtoCBSVSYFCML37cgrEqjyMN6Eu68flcLCoc0jVoFRgK6PpJAhe1ZyxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NY06ytDd; arc=none smtp.client-ip=47.90.199.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713769384; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wvGbdG/PyCf+R85lbGysoGrudwoqTXGK9KleQ+1X+Xo=;
	b=NY06ytDd1TwKFWdcj4xVMFXRlMTqSaQnGa4qKsjTBdRmK+SdrU7+03BVecy6yt3e3p3kw2//FrXrAAZxzS90keLr1mMw5L29u4gF8HLLJmx64pKvV+eqaxxFtkvRdlGYGtm9mEBUT6mGF/OkHk7EKbq7VOJmZBIpmIzNgtyJ9K4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W5-amM8_1713769381;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5-amM8_1713769381)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 15:03:02 +0800
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
Subject: [RFC PATCH 5/5] mm: shmem: add anonymous share mTHP counters
Date: Mon, 22 Apr 2024 15:02:43 +0800
Message-Id: <05d0096e4ec3e572d1d52d33a31a661321ac1551.1713755580.git.baolin.wang@linux.alibaba.com>
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

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/huge_mm.h | 2 ++
 mm/huge_memory.c        | 4 ++++
 mm/shmem.c              | 5 ++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 26b6fa98d8ac..67b9c1acad31 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -270,6 +270,8 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_SWPOUT,
 	MTHP_STAT_ANON_SWPOUT_FALLBACK,
 	MTHP_STAT_ANON_SWPIN_REFAULT,
+	MTHP_STAT_SHMEM_ANON_ALLOC,
+	MTHP_STAT_SHMEM_ANON_ALLOC_FALLBACK,
 	__MTHP_STAT_COUNT
 };
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9e52c0db7580..dc15240c1ab3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -557,6 +557,8 @@ DEFINE_MTHP_STAT_ATTR(anon_alloc_fallback, MTHP_STAT_ANON_ALLOC_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
 DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_swpin_refault, MTHP_STAT_ANON_SWPIN_REFAULT);
+DEFINE_MTHP_STAT_ATTR(shmem_anon_alloc, MTHP_STAT_SHMEM_ANON_ALLOC);
+DEFINE_MTHP_STAT_ATTR(shmem_anon_alloc_fallback, MTHP_STAT_SHMEM_ANON_ALLOC_FALLBACK);
 
 static struct attribute *stats_attrs[] = {
 	&anon_alloc_attr.attr,
@@ -564,6 +566,8 @@ static struct attribute *stats_attrs[] = {
 	&anon_swpout_attr.attr,
 	&anon_swpout_fallback_attr.attr,
 	&anon_swpin_refault_attr.attr,
+	&shmem_anon_alloc_attr.attr,
+	&shmem_anon_alloc_fallback_attr.attr,
 	NULL,
 };
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 8b009e7040b2..4a0aa75ab29c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1706,11 +1706,14 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 			pages = 1 << order;
 			index = round_down(index, pages);
 			folio = shmem_alloc_hugefolio(gfp, info, index, order);
-			if (folio)
+			if (folio) {
+				count_mthp_stat(order, MTHP_STAT_SHMEM_ANON_ALLOC);
 				goto allocated;
+			}
 
 			if (pages == HPAGE_PMD_NR)
 				count_vm_event(THP_FILE_FALLBACK);
+			count_mthp_stat(order, MTHP_STAT_SHMEM_ANON_ALLOC_FALLBACK);
 			order = next_order(&orders, order);
 		}
 	} else {
-- 
2.39.3


