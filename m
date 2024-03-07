Return-Path: <linux-kernel+bounces-95500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A27874E66
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA68F1C235FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C837B1292F2;
	Thu,  7 Mar 2024 11:57:36 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3BE83CBB;
	Thu,  7 Mar 2024 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812656; cv=none; b=TFiiM6KgT1awwfzdQzezJAUWdQENKbqLInfQBEiGqnZz5u+18sJepME8DEObNA+FNvqfzNmd+7OZPxojBfFV9WlKySMbPK81XbuuRq56jTkw9SBNR1x6ljD5ZaJqcNFBrey1Hjk15YlCUTtkx6223nskrK5ySqDDGNwQPejkM6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812656; c=relaxed/simple;
	bh=IJzK0lL+HEy35FuIvy8l6UaUj1238JQWdpdC7XIA37s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VdW4wTc8+Sn8HtkzL/6XGEBPGY6orEdfJ08nBh69OQBOMBXC3DSdhM77ib3nVp6Pktj/HmV8NpoE2D7tP/0yacStv1M6Tz/ugj42712dWizYcicqsjdLjEns5GFZ5Op4pfs34KFOfvUa4OXgz+gb0zF+jPX+Z5+3u3RSD1XmJlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Tr75t0pjwzwPFH;
	Thu,  7 Mar 2024 19:55:14 +0800 (CST)
Received: from dggpemd200004.china.huawei.com (unknown [7.185.36.141])
	by mail.maildlp.com (Postfix) with ESMTPS id BED06140134;
	Thu,  7 Mar 2024 19:57:32 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemd200004.china.huawei.com
 (7.185.36.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Thu, 7 Mar
 2024 19:57:32 +0800
From: Liu Shixin <liushixin2@huawei.com>
To: Matthew Wilcox <willy@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Sasha Levin <sashal@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<stable@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH stable-4.19] mm/memory-failure: fix an incorrect use of tail pages
Date: Thu, 7 Mar 2024 20:51:50 +0800
Message-ID: <20240307125150.2849068-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd200004.china.huawei.com (7.185.36.141)

When backport commit c79c5a0a00a9 to 4.19-stable, there is a mistake change.
The head page instead of tail page should be passed to try_to_unmap(),
otherwise unmap will failed as follows.

 Memory failure: 0x121c10: failed to unmap page (mapcount=1)
 Memory failure: 0x121c10: recovery action for unmapping failed page: Ignored

Fixes: c6f50413f2aa ("mm/memory-failure: check the mapcount of the precise page")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c971d5e11f93..5fce5df0fe35 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1033,7 +1033,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	if (kill)
 		collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
 
-	unmap_success = try_to_unmap(p, ttu);
+	unmap_success = try_to_unmap(hpage, ttu);
 	if (!unmap_success)
 		pr_err("Memory failure: %#lx: failed to unmap page (mapcount=%d)\n",
 		       pfn, page_mapcount(p));
-- 
2.25.1


