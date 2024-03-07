Return-Path: <linux-kernel+bounces-95499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B6E874E62
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCC51F23598
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43931292F1;
	Thu,  7 Mar 2024 11:56:50 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5E112838A;
	Thu,  7 Mar 2024 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812610; cv=none; b=mGCqCB/2E9NVAlpUqvAvMkFgYihjuJfpJw7xsFlADQS/cKSK/MFb7Ne8Z+ebbqAM3TT98FJvt3OpvnBbBXj/DaxESMlKLtT1dXMXgJxqBfkoWzWj4rdRW+B8NtYGpsoCQO+CIpLUB7Lk+S9XqMHdekMw64ZzB2BlQzLXCdd61+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812610; c=relaxed/simple;
	bh=GzBkR5wUrIJZ2SFamcQUXYDvjXuy7pBgkL4X6DG3brU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ayVYRATsxmubWBeNPU8k+QeIk10Jjir2osjqa1qfcJv46sv6FNY3SkWjA5j1DFzwAkyjWqjwtge03qhGbFGFQebBZByLku5FGrSRD77e8o3FJTObyUux/m74DGnt8droTyt/HCcGRCsA9oAgsEle7RX/m8PfGGm0JJ9G58Up64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tr75d5bqHz1xqC4;
	Thu,  7 Mar 2024 19:55:01 +0800 (CST)
Received: from dggpemd200004.china.huawei.com (unknown [7.185.36.141])
	by mail.maildlp.com (Postfix) with ESMTPS id A00401A016C;
	Thu,  7 Mar 2024 19:56:40 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemd200004.china.huawei.com
 (7.185.36.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Thu, 7 Mar
 2024 19:56:39 +0800
From: Liu Shixin <liushixin2@huawei.com>
To: Matthew Wilcox <willy@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Sasha Levin <sashal@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<stable@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH stable-5.4] mm/memory-failure: fix an incorrect use of tail pages
Date: Thu, 7 Mar 2024 20:50:53 +0800
Message-ID: <20240307125053.2847205-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd200004.china.huawei.com (7.185.36.141)

When backport commit c79c5a0a00a9 to 5.4-stable, there is a mistake change.
The head page instead of tail page should be passed to try_to_unmap(),
otherwise unmap will failed as follows.

 Memory failure: 0x121c10: failed to unmap page (mapcount=1)
 Memory failure: 0x121c10: recovery action for unmapping failed page: Ignored

Fixes: 85015a96bc24 ("mm/memory-failure: check the mapcount of the precise page")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c6453f9ffd4d..0e7566c25939 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1030,7 +1030,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	if (kill)
 		collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
 
-	unmap_success = try_to_unmap(p, ttu);
+	unmap_success = try_to_unmap(hpage, ttu);
 	if (!unmap_success)
 		pr_err("Memory failure: %#lx: failed to unmap page (mapcount=%d)\n",
 		       pfn, page_mapcount(p));
-- 
2.25.1


