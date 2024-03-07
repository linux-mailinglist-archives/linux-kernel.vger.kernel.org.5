Return-Path: <linux-kernel+bounces-95497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E32A8874E59
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF771C23905
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9426912AAE1;
	Thu,  7 Mar 2024 11:54:46 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AB012AACD;
	Thu,  7 Mar 2024 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812486; cv=none; b=MYGvfN+WHKhx/RZEPcgNDSxJzKeNsfKsqYAYU157oWmjbRiM/ORbi0e/2q0j960B1xnP3lffoHYWiNh7FO7iDG+/Wv8jkmhYW5qfArQmEniw3xWbd4d2wJAefRowgZMJ1AH91ZMy6mLGwfDmKJW0AebJN3LSUdNBS+A4n9WwqMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812486; c=relaxed/simple;
	bh=13cS6Nuah65OqbqxRUTX2dJdY+0xSptj5QDvZLT3Ric=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dXQUNXZH6vtb7XB7BBn9CE1kJiOIppXRPrU52rQDlTs/1kDJNO6DOxg0KhFeqqHN0JnBLCMspzpjo2FhRyoEPc/54KnEA8zY7ch8vWhxwMjWKMvepD3sQpjtgOUprrwt5ZptqtRrczOqIgYkhZS0b712xUrpHjMJHoidnVdeudQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Tr72Z4LcNzwPH3;
	Thu,  7 Mar 2024 19:52:22 +0800 (CST)
Received: from dggpemd200004.china.huawei.com (unknown [7.185.36.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 43500140134;
	Thu,  7 Mar 2024 19:54:41 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemd200004.china.huawei.com
 (7.185.36.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Thu, 7 Mar
 2024 19:54:40 +0800
From: Liu Shixin <liushixin2@huawei.com>
To: Matthew Wilcox <willy@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Sasha Levin <sashal@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<stable@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH stable-5.10] mm/memory-failure: fix an incorrect use of tail pages
Date: Thu, 7 Mar 2024 20:48:41 +0800
Message-ID: <20240307124841.2838010-1-liushixin2@huawei.com>
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

When backport commit c79c5a0a00a9 to 5.10-stable, there is a mistake change.
The head page instead of tail page should be passed to try_to_unmap(),
otherwise unmap will failed as follows.

 Memory failure: 0x121c10: failed to unmap page (mapcount=1)
 Memory failure: 0x121c10: recovery action for unmapping failed page: Ignored

Fixes: 70168fdc743b ("mm/memory-failure: check the mapcount of the precise page")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f320ff02cc19..dba2936292cf 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1075,7 +1075,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 				unmap_success = false;
 			}
 		} else {
-			unmap_success = try_to_unmap(p, ttu);
+			unmap_success = try_to_unmap(hpage, ttu);
 		}
 	}
 	if (!unmap_success)
-- 
2.25.1


