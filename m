Return-Path: <linux-kernel+bounces-102686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B7C87B5F0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB3E1C21625
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E190AA94D;
	Thu, 14 Mar 2024 00:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r0hduQlU"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9349D8C10
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 00:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710377682; cv=none; b=LZSOyMMiySgj9zd/4bJ5dIErKtFpQUgWVtaj/lsc8zD79Mbh3CsWNvnMpRmIPl072wp9RlSz6LTRwtUxWEVf2yr68pazsb5BlJ7ia8jgaApfrG+3ROronvBP23Xzhb+yXVsWmIW7Ln+LKjeYMwETqOAjRClf6OcrUMG3IZ2MW+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710377682; c=relaxed/simple;
	bh=5oQw0Jc4fccd2QAnymYMdxiP3SqsguZWdc+975ecfnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lx98MV2N/bCXMEciZatnt8gFafiG4MACBrDdPo4t6yMSPC2bR2LSDX8bEgigdZdny9vn6DBNxwtI+k9CiDQA6wqz8A8HlKognTtA3sDyTPL9Tmk4XESoNpQa9EheH15ca/sdobZ6ev1M9mLpxNnDaR6EpK/w6tZJXvpbWiOqlWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r0hduQlU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7afOyl7nv+Mi2FyolEBEsVPtXVCWDMinpJ3b7YCSncQ=; b=r0hduQlUY10mSUkoM9CAoK9lkY
	yTEkaLMR27xDBoYJKGbslC7WZIvQXb4tlMjx+hEm/VkTWjjgeaw6Dh4AS48tbKqqNwv/oVRFt/2ta
	8dWEbIaV4Z4BQuqcN1A+OoK/m5xwTbjJ5iqq9SObSEGbyZo4zlqplKXYlWI1k6bUDwY273nsRqykB
	7RehX2u5lZDO1JbzAel4LeqG3LjmL07vw/Wv0/tZJt/8kzLfBjKJ/LMnqg01l8UKJ6T+0I9TshIxN
	A/66N/n4PAoQQw/KTp/hDAZ79HtS9FuEf/NDkv/loDe+kcCcTMjQU8I492IF9burTzY94jLRQMWPH
	XhLuJErQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkZMj-0000000CQo2-0f9b;
	Thu, 14 Mar 2024 00:54:37 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org,
	jhubbard@nvidia.com,
	vbabka@suse.cz,
	mgorman@suse.de,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	dave@stgolabs.net,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH 1/3] mm/show_mem: simplify ifdef on si_meminfo_node()
Date: Wed, 13 Mar 2024 17:54:33 -0700
Message-ID: <20240314005436.2962962-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240314005436.2962962-1-mcgrof@kernel.org>
References: <20240314005436.2962962-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

There is an ifdef where the same exact values are used at
the end, so remove the else and keep the same values for both
conditions.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/show_mem.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index 8dcfafbd283c..529d2f9b6410 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -108,12 +108,9 @@ void si_meminfo_node(struct sysinfo *val, int nid)
 			free_highpages += zone_page_state(zone, NR_FREE_PAGES);
 		}
 	}
+#endif
 	val->totalhigh = managed_highpages;
 	val->freehigh = free_highpages;
-#else
-	val->totalhigh = managed_highpages;
-	val->freehigh = free_highpages;
-#endif
 	val->mem_unit = PAGE_SIZE;
 }
 #endif
-- 
2.43.0


