Return-Path: <linux-kernel+bounces-99531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CA08789A7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0118B210DA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E87E5677A;
	Mon, 11 Mar 2024 20:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="td2zp50G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ECD433CC;
	Mon, 11 Mar 2024 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189958; cv=none; b=SNJw6Hl3vCxLgp1oM/stjZklXquZ6vItYe9OiZrZzMCQY+xFPw0mANKY+MMjzgHFWGVr7d+UDpKjVEO8OhN/cfKclYTI4acdsTPdRSIXf1jUe7pdPcM96N0kKroZV2SVYPdjqJytGUTsoiMjqxbIpRHWkyWMvzP+xOp/KJuPQnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189958; c=relaxed/simple;
	bh=UuuVmb738blr2pB61tpIDxHO3PUHT5WkafuK2N/sEFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jVm69r6t1oLUIxWY5R5QidempGGFznBEwo06/T43lNvrkxpY1ATS7UeGOumMKlyPmMEVLlWyr11/65zTGnAmuJm7iQLjxUzEpYFdOw+0ex1F6XUp0o4gN+zjFYAzDj4xaW59v1a41UVXnzKYphPKY7LcsDzJ1CMDFhhGmj54gQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=td2zp50G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71566C433F1;
	Mon, 11 Mar 2024 20:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710189958;
	bh=UuuVmb738blr2pB61tpIDxHO3PUHT5WkafuK2N/sEFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=td2zp50GqM3oHJlnxChlumu1/94uTMfKJnHQqsPeNz16+H1HzcBmhqMqLCxRnMiFT
	 Y6uES8HIJjl+SwTjfzxxHWYm+HL7Z3FRMMt8SbJ9+lErFtA6V6qmidyHFf/O1V3gPa
	 orY1Iuv9SnlsA0OQmdzQMplsz01BPPxSnwAYPYfxwwBz9IRoHNmVTJxQ6dT1g+Bpj/
	 Mb9LP01sZNLXrNR4tN0kff+1oELPmWRnlNUDDrlBJc+JG4mFHKCS6+OQ6l5d0PfAln
	 GJtW1BE+HA8yuyegskWeYCXue0tYoSL4okBtkLcYd9TO1WiASR7WDg5ifi0C/Yigm1
	 fEFGgsi50HezQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/4] mm/damon/paddr: implement damon_folio_young()
Date: Mon, 11 Mar 2024 13:45:42 -0700
Message-Id: <20240311204545.47097-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311204545.47097-1-sj@kernel.org>
References: <20240311204545.47097-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_pa_young() receives physical address, get the folio covering the
address, and show if the folio is accessed since the last check.  Split
the internal logic for checking access to the given folio, for future
reuse of the logic from code that already got the folio of the address
of the question.  Also, change the rmap walker function's name from
__damon_pa_young() to damon_folio_young_one(), for consistent naming.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5e6dc312072c..25c3ba2a9eaf 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -79,8 +79,8 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 	}
 }
 
-static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
-		unsigned long addr, void *arg)
+static bool damon_folio_young_one(struct folio *folio,
+		struct vm_area_struct *vma, unsigned long addr, void *arg)
 {
 	bool *accessed = arg;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
@@ -111,38 +111,44 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 	return *accessed == false;
 }
 
-static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
+static bool damon_folio_young(struct folio *folio)
 {
-	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	bool accessed = false;
 	struct rmap_walk_control rwc = {
 		.arg = &accessed,
-		.rmap_one = __damon_pa_young,
+		.rmap_one = damon_folio_young_one,
 		.anon_lock = folio_lock_anon_vma_read,
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


