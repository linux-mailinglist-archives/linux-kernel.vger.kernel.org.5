Return-Path: <linux-kernel+bounces-111131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F742886843
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0502832C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55310200AE;
	Fri, 22 Mar 2024 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaBhc3oW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9914C1CAA9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096477; cv=none; b=Ud8+2DRwvGrq9tnb0pj39vKIFx9rcoGWZS25uMH0ISb0yA9Y/IwNPs/WWdIZyV5OQ0fVGhiOdcrstNDOKZ63pY6lJYBQioeY8ECE4VRCAKAi6NuwW1TAv9uo1AOpJuMdp/prPwvbNuJUeHO2QppMfshRT4hUvSZC2Y5xkGj+YeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096477; c=relaxed/simple;
	bh=u2CpON+ylVsyq590GuxgPX8aACtNcQ54tsZFdjhyaWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfiFO3fakYSj8x5p5z87/fPbpwJ5MzmpAyv/GafkgeAsNGNJVbazt+8KZ82UQJyqRswhAji58UltSVvv97479s7toIjMGpDPNkVfokFcWCr3+0g7QeWPW6DvwVPHS0icQY4iOYneRJ2FMSo/ADBoe4QIbzLH/BpaQAyP5mxkdyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaBhc3oW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E41C433C7;
	Fri, 22 Mar 2024 08:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711096477;
	bh=u2CpON+ylVsyq590GuxgPX8aACtNcQ54tsZFdjhyaWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AaBhc3oW54M2fVP4zko3bI7wwqPbKFrZpITxoE8zMB09nSGioEQ8ciGrhyoNVw9dl
	 5YrCQpT1pseBVwA33cgDlGFOx4FQlanhgK2UjNScC+SZBglLPfDqK1UofWxdr47roq
	 6GMyA8MaGGHVqiCCLVMQRL+VqScXIDmuLZrG9NMJ66kWpS40p0Zaj/cm+2GbhOMhTu
	 e0ethnI0isP9gkZHmiQAYCHBVOZaM2T/frovkexYNf6fSyJbKzLJGhv/JOGivKU3Zb
	 RCqpiaOpNDTHCBh4+Tx8KnVwnrqI1pqgWU499eH8OT7ssfyiP0MU1lfCoLJ1RBaMHz
	 M4RaK8HjY2+1A==
From: alexs@kernel.org
To: Matthew Wilcox <willy@infradead.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Izik Eidus <izik.eidus@ravellosystems.com>,
	david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH v2 02/14] mm/ksm: use folio in remove_rmap_item_from_tree
Date: Fri, 22 Mar 2024 16:36:49 +0800
Message-ID: <20240322083703.232364-3-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322083703.232364-1-alexs@kernel.org>
References: <20240322083703.232364-1-alexs@kernel.org>
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
---
 mm/ksm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index ac080235b002..ea3dabf71e47 100644
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


