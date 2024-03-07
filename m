Return-Path: <linux-kernel+bounces-94897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 302C0874673
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4EE4B2203F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A90101CA;
	Thu,  7 Mar 2024 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEsAH8mQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9807DE555;
	Thu,  7 Mar 2024 03:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709780420; cv=none; b=UhhkLQpyDkLMvoCN+av4eYFGU14UqunkVcff13PWJrHlJnIGYl1hhHsbKS2Ap5dSY2C70UDIWgucoNyYZQTywBg5smMUj0EQtKJoJYlrn2HetwzHUjnUxJ236iXzKM/3p9rnDHlxAurAMcrGprQPJUXWW2vKuul17P9UuZz7jcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709780420; c=relaxed/simple;
	bh=0eBYRMuRF3ohUK1LpjNQClNe+yHwQ6lEwKTScu0clBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nDUTzxSKeY0IyW5qe4w5S6TsGD7euAJvX1skcN0SMLlYgRmMC7+qZgqo+B68FOiiqV/Ks+t6baKHnlUyWxAlVJjS4K/aB8zJQjfoH9LhV0mLCttcbwG7sgQ4AFN/4vXfhUh2tTUfYiltc3+m1pOWPTn4sysjK9IQ8fopUsIOw8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEsAH8mQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DD0C43399;
	Thu,  7 Mar 2024 03:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709780420;
	bh=0eBYRMuRF3ohUK1LpjNQClNe+yHwQ6lEwKTScu0clBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SEsAH8mQ0+MJ9898A1IG2SQIvaIy0pUH8KdiOgj6Z61nklkkDbv+he/qFjFiJ0lI/
	 OrhEf2N80oOQpHKx/HJLFeyiiy38u5gHHpIhVWyGlKVUjrPVamcW3hYTrv/kXdES1a
	 zs1s9szWp0LKHT1qi9u4/Ew0lSvG5ixmO1AAw2yHctf0QyEv8poK6Sp3rHyvGhN4mz
	 lLKFkrBvCu3F0hhxuSvHt5/OGxd8MfRmOmV7oo1af7NugjdAZi3l9liSAfR/Vvs2kY
	 ekTXh7f9xZMv5Z30FdHKya4JPNfZ6fcptOoyKT8ua7rmkesYAcdM5r7I4pS8EIKsdc
	 9KFnL4DWWQ4xQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] mm/damon/paddr: implement damon_folio_young()
Date: Wed,  6 Mar 2024 19:00:12 -0800
Message-Id: <20240307030013.47041-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307030013.47041-1-sj@kernel.org>
References: <20240307030013.47041-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_pa_young() receives physical address, get the folio covering the
address, and return if the folio is accessed since the last check.
Split the internal logic for checking access to given folio, for future
reuse of the logic from code that already got the folio of the address
of the question.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5e6dc312072c..deee0fdf2e5b 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -111,9 +111,8 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 	return *accessed == false;
 }
 
-static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
+static bool damon_folio_young(struct folio *folio)
 {
-	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	bool accessed = false;
 	struct rmap_walk_control rwc = {
 		.arg = &accessed,
@@ -122,27 +121,34 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 	};
 	bool need_lock;
 
-	if (!folio)
-		return false;
-
 	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
 		if (folio_test_idle(folio))
-			accessed = false;
+			return false;
 		else
-			accessed = true;
-		goto out;
+			return true;
 	}
 
 	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
 	if (need_lock && !folio_trylock(folio))
-		goto out;
+		return false;
 
 	rmap_walk(folio, &rwc);
 
 	if (need_lock)
 		folio_unlock(folio);
 
-out:
+	return accessed;
+}
+
+static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
+{
+	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
+	bool accessed;
+
+	if (!folio)
+		return false;
+
+	accessed = damon_folio_young(folio);
 	*folio_sz = folio_size(folio);
 	folio_put(folio);
 	return accessed;
-- 
2.39.2


