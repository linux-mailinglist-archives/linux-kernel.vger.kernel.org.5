Return-Path: <linux-kernel+bounces-108554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47A7880C26
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D431B230DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A428839AC7;
	Wed, 20 Mar 2024 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcdYDTwN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2A838F9A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920273; cv=none; b=APqxT1A0LaSOZPiCzqIWxcOOpQ/EHl7INMtuMjwfLnkZ49c8bg/iuifbEdsojUsPz46c5wL7kPdS3/ub98fcjlNAjam0m0reGR6KbHAlJOmAexf5UmEoIP/MX6C6redn7B9Hrqm4y83Eqm4XnOK5V7rzdpsnE9l9W9Tn4aSpVuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920273; c=relaxed/simple;
	bh=4seeVX6AVPqZd4ygjF/loS0RJCIz9ENpBZHyDB1ONgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWuKf8GHyaRBiemWrulrYAqTMFq/Fiw9tZ1NqiHz8oPr4UAVMXosdBhGyiXwKtyrr4YxLoENMnJTJadClxI87tA6bWM1Z7uXD5dwJK/UNiown3vheVGcJ/qkozKirldMm2oAQ38bKgcrbYQtOslTLLnRnUgCYg2Ldpjldst1wy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcdYDTwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783FCC433C7;
	Wed, 20 Mar 2024 07:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710920272;
	bh=4seeVX6AVPqZd4ygjF/loS0RJCIz9ENpBZHyDB1ONgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gcdYDTwNpPfOraYNtauQXzItCR4li8hYgUl6TNOp70HPLvjFG2OMzp63eiaHDkVJ4
	 lAQiNnL/FmDu2tGeykqradjGyyPa/riMOWFVA50dZoE5tjUOTyTWCivB0NUf4ZrLoA
	 fXk6NuuqeTNyJVVuuLSoY8a7zoorFJ5HM06+E122HCv7C62/d67TiJISYDBBqXDASw
	 MyCoEdgzJzMC+EVEbqI/DyO6j+yzlTpQeGAoyL3VrfpBmRCXr9VJmd7L4M3Yb+ZcXW
	 NTgWZ7emrvaOYBFaEKJBAgDvaiqJPYAimCIhBECxGHQ31uddId4Ou16GQwAim0Vl+N
	 vt2YiIJwwpK0w==
From: alexs@kernel.org
To: Izik Eidus <izik.eidus@ravellosystems.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Chris Wright <chrisw@sous-sol.org>,
	kasong@tencent.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
	linux-kernel@vger.kernel.org (open list)
Cc: linux-kernel@vger.kernel.org,
	"Alex Shi (tencent)" <alexs@kernel.org>
Subject: [PATCH 05/11] mm/ksm: use a folio in scan_get_next_rmap_item func
Date: Wed, 20 Mar 2024 15:40:41 +0800
Message-ID: <20240320074049.4130552-6-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240320074049.4130552-1-alexs@kernel.org>
References: <20240320074049.4130552-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

Save a compound calls.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
---
 mm/ksm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index f57817ef75bf..165a3e4162bf 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2597,14 +2597,14 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 		 */
 		if (!ksm_merge_across_nodes) {
 			struct ksm_stable_node *stable_node, *next;
-			struct page *page;
+			struct folio *folio;
 
 			list_for_each_entry_safe(stable_node, next,
 						 &migrate_nodes, list) {
-				page = get_ksm_page(stable_node,
+				folio = get_ksm_page(stable_node,
 						    GET_KSM_PAGE_NOLOCK);
-				if (page)
-					put_page(page);
+				if (folio)
+					folio_put(folio);
 				cond_resched();
 			}
 		}
-- 
2.43.0


