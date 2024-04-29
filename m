Return-Path: <linux-kernel+bounces-163113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 366678B65E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683CB1C214F6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F418D194C7E;
	Mon, 29 Apr 2024 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTjkOLRZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DF01465AE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430699; cv=none; b=GxMDa2X2Z9xF43oYLiPQtPfDAiRvIjefVJsWly3MX5NJissHS2OV999e7V+AK9FeptAmh+Kyhq8ow/pFMZ+i7xzL03Ni0TCX3tOBTlESJZN4D86KzqEqti4qDD5O1g8jna9bJcsMB8IJOGXYWO+0+4MpurpeQzVkrbIzfhtwIDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430699; c=relaxed/simple;
	bh=c5R6Q+jjynMcjdwz6qj4TecKkTHs1L5RszRXGVX69qM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gtwRX5HWvco0SB9J5suwieQ4Z1s3mbAiZ4KHrPQmQ9YnJYrgXK7BMuLXjOVhylRhRtZXaGGMAqH4WTkBig6Lo4UbEVOMle/8P0hQ+gfEdGo5fSKKFtMv6g/4YhF9493wQLmCoM6+HsHp5MokR4fy/T8JZ9x92TLQfYFQ9MxQd0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTjkOLRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15BBC4AF1D;
	Mon, 29 Apr 2024 22:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714430699;
	bh=c5R6Q+jjynMcjdwz6qj4TecKkTHs1L5RszRXGVX69qM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JTjkOLRZE9RqeCYWNPbhtB3eMRNA1PWdYKagaygW3idDe5DF9DoUFJlKXawa1JTc7
	 FXrLTXWf1G5A4F6yyy7KeJSlzNz4sRCP3ri+aXxImbHD7+fxJ4QULrRGovvhbbB22y
	 IoPHoE8GkyPAIekuzdETf1v6rweXYfpDa3g2ZtsDelCZCaWUQcZp9CzEPa9ZEEjIQ8
	 VARWTl2bWuYKJiHNVmIEnZwE2T0i2038cRvt7hIAQDIajci0r/UACkxR5HE5IAguPz
	 GDxxFNCaFeHaJNGWszvbnwZN2khwABDsWrqnAZT4K+bOf98Vbw9C/VQiIcHNHeKgwQ
	 Dg/OtCgjYSG2Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mm/vmscan: remove ignore_references argument of reclaim_folio_list()
Date: Mon, 29 Apr 2024 15:44:51 -0700
Message-Id: <20240429224451.67081-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240429224451.67081-1-sj@kernel.org>
References: <20240429224451.67081-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All reclaim_folio_list() callers are passing 'true' for
'ignore_references' parameter.  In other words, the parameter is not
really being used.  Simplify the code by removing the parameter.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/vmscan.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index fc9dd9a24739..6981a71c8ef0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2126,8 +2126,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 }
 
 static unsigned int reclaim_folio_list(struct list_head *folio_list,
-				      struct pglist_data *pgdat,
-				      bool ignore_references)
+				      struct pglist_data *pgdat)
 {
 	struct reclaim_stat dummy_stat;
 	unsigned int nr_reclaimed;
@@ -2140,7 +2139,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 		.no_demotion = 1,
 	};
 
-	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, ignore_references);
+	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, true);
 	while (!list_empty(folio_list)) {
 		folio = lru_to_folio(folio_list);
 		list_del(&folio->lru);
@@ -2172,12 +2171,11 @@ unsigned long reclaim_pages(struct list_head *folio_list)
 			continue;
 		}
 
-		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid),
-						   true);
+		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
 		nid = folio_nid(lru_to_folio(folio_list));
 	} while (!list_empty(folio_list));
 
-	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid), true);
+	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 
-- 
2.39.2


