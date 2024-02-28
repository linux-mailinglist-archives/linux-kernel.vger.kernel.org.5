Return-Path: <linux-kernel+bounces-84390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67AD86A651
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3E4FB23923
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56B223CB;
	Wed, 28 Feb 2024 01:55:27 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859B71CA98
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709085327; cv=none; b=ndk0LNRv84ShH03nIxEMdPZJKtqqWxKIgLjaNlRXUxRbWXWmVEpIxLCLhELK42obJ+LMVLVUO/XLr36LsZa/MrlhbmVec0vUII5Sf3wEhgeKAAo647Q/Xy4sOzchtz5syscQw0wM6UqfIsl/xCP8Npeyc2lRViosKJOuCXnG8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709085327; c=relaxed/simple;
	bh=gWX6eid25B21mSNcHkDXJMfEPHC+VA3OlleXqUIRNtk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cjCkDIQzqZ1Lb51ys9J5ucqlOROlPn+iR20Zwc+hQMgUBtemHDBhqnql3K/WmUD+R4j6BGpgqFpjvnzFn1ni/yYnvVlbRPoRSk+F1XCxkTXfRpMPnpZ3WmLPKz1Eju/hmcBHtbVU8x52ywSH8hEDl9OPosHmoJPrUGFxvjENew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-61-65de927f07d1
From: Byungchul Park <byungchul@sk.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	hannes@cmpxchg.org
Subject: [PATCH] mm/vmscan: simplify the calculation of fractions for SCAN_FRACT
Date: Wed, 28 Feb 2024 10:55:00 +0900
Message-Id: <20240228015500.52452-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEJMWRmVeSWpSXmKPExsXC9ZZnoW79pHupBo9OCljMWb+GzWL1Jl+L
	y7vmsFncW/Of1YHF4/Cb98wemz5NYvc4MeM3i8fnTXIBLFFcNimpOZllqUX6dglcGfPXdzMX
	zOCvOPu1m72BcRJPFyMnh4SAicTP1UfYYOzmvjnMIDabgLrEjRs/wWwRAVmJqX/Ps4DYzALp
	EpcbloPFhQUCJE6sucUOYrMIqErsudTMCGLzCphKHF35mAViprzE6g0HmCHsvawSk7+qQNiS
	EgdX3GCZwMi9gJFhFaNQZl5ZbmJmjoleRmVeZoVecn7uJkagz5fV/onewfjpQvAhRgEORiUe
	3gt37qYKsSaWFVfmHmKU4GBWEuGVEQQK8aYkVlalFuXHF5XmpBYfYpTmYFES5zX6Vp4iJJCe
	WJKanZpakFoEk2Xi4JRqYAwu5Z/65Hzo/jydvg3RClPvKz1/13JlbWnkFCkxGeWs8NUl8086
	V2Xc3qnNqFF8aso9z1dpFpoXdWVm+5gvjDFXL+E1vZ4rZ/sxX9AkT2Cq3PSjogq71wqHN9Ws
	2ND5a529ceDhk5WTA/66Z77MU1r2Z3PC+5d9urHm/I91m1r7TrTGmCzIV2Ipzkg01GIuKk4E
	AAi0dVH1AQAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJMWRmVeSWpSXmKPExsXC5WfdrFs/6V6qwaOrnBZz1q9hs1i9ydfi
	8NyTrBaXd81hs7i35j+rA6vH4TfvmT02fZrE7nFixm8Wj8UvPjB5fN4kF8AaxWWTkpqTWZZa
	pG+XwJUxf303c8EM/oqzX7vZGxgn8XQxcnJICJhINPfNYQax2QTUJW7c+AlmiwjISkz9e54F
	xGYWSJe43LAcLC4sECBxYs0tdhCbRUBVYs+lZkYQm1fAVOLoyscsEDPlJVZvOMA8gZFjASPD
	KkaRzLyy3MTMHFO94uyMyrzMCr3k/NxNjEAfLqv9M3EH45fL7ocYBTgYlXh4L965myrEmlhW
	XJl7iFGCg1lJhFdGECjEm5JYWZValB9fVJqTWnyIUZqDRUmc1ys8NUFIID2xJDU7NbUgtQgm
	y8TBKdXAmLP43r6tf7Nj5J5XzVj3ds9chYrNaZkuUiUNcUdWnpt1vqz72c6zr99/UNhYdodl
	ihT3tO9Xrha8UkldwROir5z3YM+Js0dD+Liuiu0/0fM+uun3O9MtVw3+m587mHv927Rfy7l2
	1q9Kq7QXSa0/c8TVwuWZ/43DxgdWhFVuPDLVSuADs/CR9UeVWIozEg21mIuKEwHr9n3w3QEA
	AA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The current way to calculate fractions for SACN_FRACT is little readable
and more complicated than it should be.  It also performs unnecessary
division and adjustment to avoid zero operands.  Prune away by
multiplying the fractions by 'anon_cost * file_cost / (3 * total_cost)':

where:
   total_cost = sc->anon_cost + sc->file_cost
   anon_cost = total_cost + sc->anon_cost
   file_cost = total_cost + sc->file_cost

before:
   fraction[0] = swappiness * 3 * total_cost / anon_cost
   fraction[1] = (200 - swappiness) * 3 * total_cost / file_cost

after:
   fraction[0] = swappiness * file_cost
   fraction[1] = (200 - swappiness) * anon_cost

Worth noting that this patch doesn't change the formula.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/vmscan.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4657440854db..7b33fcc1cbdc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2339,7 +2339,6 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	u64 fraction[ANON_AND_FILE];
 	u64 denominator = 0;	/* gcc */
 	enum scan_balance scan_balance;
-	unsigned long ap, fp;
 	enum lru_list lru;
 
 	/*
@@ -2416,17 +2415,10 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	total_cost = sc->anon_cost + sc->file_cost;
 	anon_cost = total_cost + sc->anon_cost;
 	file_cost = total_cost + sc->file_cost;
-	total_cost = anon_cost + file_cost;
 
-	ap = swappiness * (total_cost + 1);
-	ap /= anon_cost + 1;
-
-	fp = (200 - swappiness) * (total_cost + 1);
-	fp /= file_cost + 1;
-
-	fraction[0] = ap;
-	fraction[1] = fp;
-	denominator = ap + fp;
+	fraction[0] = swappiness * file_cost;
+	fraction[1] = (200 - swappiness) * anon_cost;
+	denominator = fraction[0] + fraction[1];
 out:
 	for_each_evictable_lru(lru) {
 		int file = is_file_lru(lru);
-- 
2.17.1


