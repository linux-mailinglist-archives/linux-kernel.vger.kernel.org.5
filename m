Return-Path: <linux-kernel+bounces-117039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C0288A660
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C068F1F3BBA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0048615E818;
	Mon, 25 Mar 2024 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjoZ6FgV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E1615E80F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370762; cv=none; b=GydTdjOkr3ETaAfM5H+CPtioJSBhU3PwVcwPchZTwvm8vUfckD7kWlI2KQoxDcwyI9uv3aAFfdUG5d1n5dGn7yCAMmGlMVKScwd7ubzsaLzYw2TvxS5taeiA6OX6M9rRGrVmtd3cyM3aoKtJtl33zHtIYaQ92Vq+/gScJgnTl7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370762; c=relaxed/simple;
	bh=3EngGDxtSZrFY+NPFGnfYU0Kocquv/KpfYgYZYqOFCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EA0p7K4n0QcLkiWtmUvnknnx0L5nAOY9cRh67r/VyxxjMI5ZjYc9M8WnjznmUGwUUyZE2WTYS9cfEjTSNTJTrA9+au7ovAB6Ux15qkomYvgXaqTNP8u36yqn/eNwz5EP+8h+drU5oVsvjhUoAwqdDhnBuNmFnDNsYsbygTsrzqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjoZ6FgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFF3C43399;
	Mon, 25 Mar 2024 12:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711370761;
	bh=3EngGDxtSZrFY+NPFGnfYU0Kocquv/KpfYgYZYqOFCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QjoZ6FgVlpIls85bdewPna6oDmn2WQIkdvXxVa0PVuSTOfSnoi2GS67/7T2yzLGTU
	 pqP+ZuzwlR93nUViU+yT+7Bo1vkuR/mInu4r5dalOt34sGCZ9YT8pBFxsswAhrUScn
	 rL5f6uni+PSLCcHF3+sBGjcIr96ZecpdJaqpTwIBsEZo94tASOiWtA52AAQHG9ymA8
	 LQeACgbCBpU4vPjteVHgegKWJPmSOubP0Wr5v9+rVr00SleMoJB8IZu30VbCEFdf6y
	 pg5XBGAOTY31Ro0NURQi8DmQmS+ykXp+MXa0O55h72zSE68tY9uPF5QTHq+1A4Hbeu
	 5pXqw9a5deBMw==
From: alexs@kernel.org
To: Matthew Wilcox <willy@infradead.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Izik Eidus <izik.eidus@ravellosystems.com>,
	david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ryncsn@gmail.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH v3 06/14] mm/ksm: use ksm_get_folio in scan_get_next_rmap_item
Date: Mon, 25 Mar 2024 20:48:53 +0800
Message-ID: <20240325124904.398913-7-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325124904.398913-1-alexs@kernel.org>
References: <20240325124904.398913-1-alexs@kernel.org>
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
 mm/ksm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index aa80fbf3a8e0..95a487a21eed 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2611,14 +2611,14 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 		 */
 		if (!ksm_merge_across_nodes) {
 			struct ksm_stable_node *stable_node, *next;
-			struct page *page;
+			struct folio *folio;
 
 			list_for_each_entry_safe(stable_node, next,
 						 &migrate_nodes, list) {
-				page = get_ksm_page(stable_node,
-						    GET_KSM_PAGE_NOLOCK);
-				if (page)
-					put_page(page);
+				folio = ksm_get_folio(stable_node,
+						      GET_KSM_PAGE_NOLOCK);
+				if (folio)
+					folio_put(folio);
 				cond_resched();
 			}
 		}
-- 
2.43.0


