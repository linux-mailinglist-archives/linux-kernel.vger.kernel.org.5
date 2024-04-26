Return-Path: <linux-kernel+bounces-160635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BAE8B407B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743AF1C22004
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BC72554B;
	Fri, 26 Apr 2024 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2nYt7mW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08338224D2;
	Fri, 26 Apr 2024 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161182; cv=none; b=G209bQELee74JbQ4ihPXRuqpZ6KdqtsxJM1Wz+wlhdKy3Il3naYnEXV9K1gVX7GxpjDZFDG79zIMyhAYBF0paQW0RyF56kD518qHY5B8IyoUscIIP5bocEizMSvAYYb9H9U7bSCGKmCUs26PU3x+XJ/ZmJIYCi9MMGpRG5MUkEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161182; c=relaxed/simple;
	bh=2SdOrYSwPaCcW6lpCEqRPan9kbnzKrEsfc9vQDQS2P4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pCNJuDHum9+pbM0tTf1ls08f2gcEzuAHshU19mLUqQCyjOfICoQjG1Zv9NQ31SH9nemRbzJlUPzZwGNEZfUdj2yjYR0AW/hStNWlId+K5W6d2ESuYfbUv6YFifRK9bSCRQyKGRXOj3jdu2Tee1Cvzj5/fuMxk+2JRkyEe6LN0Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2nYt7mW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FFEC32783;
	Fri, 26 Apr 2024 19:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714161181;
	bh=2SdOrYSwPaCcW6lpCEqRPan9kbnzKrEsfc9vQDQS2P4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2nYt7mWd13qgtKTEmdZ8bbPoMfYI4/cOsKLqW337FVMFVnXLzHas4Q3U7I8sR9Z9
	 acTnbyUuez7gsIQG1uH7YW6DXA+S5rVfeQ0tGBhTrPDECy5NqITSc0RYvKJiY1Sv2C
	 CZUHHD8wpa421gUwEDHr6tOiBdbKORfwX5bL5imLi41RJ28KPLcRXdkDMfa1lROS64
	 gl2TbHvNv0P4Kq5NxFRbFiWfbHqm290wByZkMtJ7kN3GDgDsoIiQCf4ozaCuxsRysr
	 YFNOXfG/yUIi63M0aNql8e5LePHrLd+73bb0cs3r9r1pkB6A6DeYp8JyfcYSDlUJjW
	 e78umN2Oi8T7A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH 2/7] mm/damon/paddr: implement damon_folio_mkold()
Date: Fri, 26 Apr 2024 12:52:41 -0700
Message-Id: <20240426195247.100306-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240426195247.100306-1-sj@kernel.org>
References: <20240426195247.100306-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_pa_mkold() receives physical address, get the folio covering the
address, and makes the folio as old.  A following commit will reuse the
internal logic for marking a given folio as old.  To avoid duplication
of the code, split the internal logic.  Also, change the rmap walker
function's name from __damon_pa_mkold() to damon_folio_mkold_one(),
following the change of the caller's name and the naming rule that more
commonly used by other rmap walkers.

Signed-off-by: SeongJae Park <sj@kernel.org>
Tested-by: Honggyu Kim <honggyu.kim@sk.com>
---
 mm/damon/paddr.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 25c3ba2a9eaf4..310b803c62779 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -16,8 +16,8 @@
 #include "../internal.h"
 #include "ops-common.h"
 
-static bool __damon_pa_mkold(struct folio *folio, struct vm_area_struct *vma,
-		unsigned long addr, void *arg)
+static bool damon_folio_mkold_one(struct folio *folio,
+		struct vm_area_struct *vma, unsigned long addr, void *arg)
 {
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
 
@@ -31,33 +31,38 @@ static bool __damon_pa_mkold(struct folio *folio, struct vm_area_struct *vma,
 	return true;
 }
 
-static void damon_pa_mkold(unsigned long paddr)
+static void damon_folio_mkold(struct folio *folio)
 {
-	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	struct rmap_walk_control rwc = {
-		.rmap_one = __damon_pa_mkold,
+		.rmap_one = damon_folio_mkold_one,
 		.anon_lock = folio_lock_anon_vma_read,
 	};
 	bool need_lock;
 
-	if (!folio)
-		return;
-
 	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
 		folio_set_idle(folio);
-		goto out;
+		return;
 	}
 
 	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
 	if (need_lock && !folio_trylock(folio))
-		goto out;
+		return;
 
 	rmap_walk(folio, &rwc);
 
 	if (need_lock)
 		folio_unlock(folio);
 
-out:
+}
+
+static void damon_pa_mkold(unsigned long paddr)
+{
+	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
+
+	if (!folio)
+		return;
+
+	damon_folio_mkold(folio);
 	folio_put(folio);
 }
 
-- 
2.39.2


