Return-Path: <linux-kernel+bounces-139825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 981738A0832
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B111F24897
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4537213CF99;
	Thu, 11 Apr 2024 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG3iMi2h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE9C13CAB3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816060; cv=none; b=O8jKn9I/G5A4yNhv+7UEOOfXLRxjA6e7HIxep+kcoWZ8qHLiamspZyI4Bah/rrO+Xee3jMLBNIMTKsagctm/D+rF/LUf3Yr3dfeTZFokuDo7j4xjShzf27qlDHlKTaVinjX4AoC8iZ0z0wovKiqxBwzQ1nH+3nVm8oeknx4KjF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816060; c=relaxed/simple;
	bh=Ti8omFOFkWyaGFVyRP2niT/Lsh/B9sgK71P36pfGxwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8JLFC/ReexoLeMp3vm8nem5H6i3vZu0tjBfFtuL5ej0iUorr6XoqAROwaSVL6SdX0ZR6xszx51/j5NEyoK4GGXx3Q91/XAyW3Q+lVXs419T1QbB77ki86dnYlxyuuUBNQ7HrMIILf2ZcgnnokyUC97BnFWzRpoHBJIREB8OP/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG3iMi2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA75DC43399;
	Thu, 11 Apr 2024 06:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712816060;
	bh=Ti8omFOFkWyaGFVyRP2niT/Lsh/B9sgK71P36pfGxwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RG3iMi2h+4rJwzgmeoyIiZZmtvBYfoMXgDfJJgFS9lv62v+NcgJ4l1yZGNF37CwLt
	 GLu7qoK1rTHy87WRBFLJeFfla6DXdLbnWVXmoHo+vutb25QVE7gpOvhH6sy4suZF7c
	 fx9Xgk/iQscsOVBNRzbjxgLRYzjBEOdqoJfSq8ukSDTLbzmYjo3LRgVcgpPrJWJWPQ
	 4NwI6Vo5VI+85LFXnMpvl8FG8Ku/0SSrkpA9NTN1372DphlJLHBWeaEp+JxGd2Ml/J
	 DYmWnmWPezuUFHIF1lxEuOA9TTvygMuWSBPT373PdQ/xEctBKLJkB1euNR1IV9NiWV
	 UCWIpZCc1917A==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zik.eidus@ravellosystems.com,
	willy@infradead.org,
	aarcange@redhat.com,
	hughd@google.com,
	chrisw@sous-sol.org,
	david@redhat.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	Izik Eidus <izik.eidus@ravellosystems.com>
Subject: [PATCH v5 02/10] mm/ksm: use folio in remove_rmap_item_from_tree
Date: Thu, 11 Apr 2024 14:17:03 +0800
Message-ID: <20240411061713.1847574-3-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411061713.1847574-1-alexs@kernel.org>
References: <20240411061713.1847574-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

To save 2 compound_head calls.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index ac126a4c245c..ef5c4b6d377c 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1006,16 +1006,16 @@ static void remove_rmap_item_from_tree(struct ksm_rmap_item *rmap_item)
 {
 	if (rmap_item->address & STABLE_FLAG) {
 		struct ksm_stable_node *stable_node;
-		struct page *page;
+		struct folio *folio;
 
 		stable_node = rmap_item->head;
-		page = get_ksm_page(stable_node, GET_KSM_PAGE_LOCK);
-		if (!page)
+		folio = ksm_get_folio(stable_node, GET_KSM_PAGE_LOCK);
+		if (!folio)
 			goto out;
 
 		hlist_del(&rmap_item->hlist);
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 
 		if (!hlist_empty(&stable_node->hlist))
 			ksm_pages_sharing--;
-- 
2.43.0


