Return-Path: <linux-kernel+bounces-139829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB938A0836
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B4A282F02
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD1A13D8AE;
	Thu, 11 Apr 2024 06:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrF2rdtE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F51613D887
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816071; cv=none; b=nAj7PwlkjQxUnS02nqvB4NF9hVMCjEqJjMCEwPyYg5TRePUIBfcYZhpZeC7e6ELGCKHx15NoNEpfPunNOkI9a8FJMf2goJIzOIfvmKv8L3kdw6sdJ+YCWV6hoGroNnT39Gbde4utH1/V4FoNHhmRnVOlfbUQNEDQuH5ptVqrEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816071; c=relaxed/simple;
	bh=AGS71Z17Hu5djhgaE9FvKpI+lMFnYwLUHMLt7uG9UW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RG3QL+/9Yd8ZdAoDM7hUs8TCwERKNOmQ/5mX7P4mDcQeYWXn0wmDq6NXsFbXAy8H0bxOpyHUoFTYcYZXKE/oaY2lqEearFBFNgnxDwXCla4pgrjD8ezS4Wd2S/xF27KdcZOxCqTdsHTSvdBwDPvOgDXd9N5w9zj8xpSMCfHmmUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrF2rdtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED760C4166A;
	Thu, 11 Apr 2024 06:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712816071;
	bh=AGS71Z17Hu5djhgaE9FvKpI+lMFnYwLUHMLt7uG9UW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qrF2rdtEXCaBbJxjV8S9drLU01OLf5ihIeBBhb8Xl/1R3u2e1+jNFOQHsgdzdnX/c
	 /9dnAtjbA06xzJ7rdG4i6UHkCzg4bXFPhC5813GaUDWCrEDUDslsnKoU5MDzlxVJhe
	 bQCIBihwPd2Yf6WqwLk7a/krz164Iyqhl7cguWbc+gN2CSIdqycaiZ3uvV4syIwWR+
	 OXLmzBAXdeJ7ihn/uRbrBCamUfBPTBOKUJhPH4u9x3jsuvLltT9DtBOtQqh6LWg+y1
	 SRxVpNTshHI8KEdoIV06pJfSrWMH/GZw+buDUlIu4gRdDDu7bDH4uAd9mjSAUmXkgq
	 x2DLn4gkEPyOg==
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
Subject: [PATCH v5 06/10] mm/ksm: use ksm_get_folio in scan_get_next_rmap_item
Date: Thu, 11 Apr 2024 14:17:07 +0800
Message-ID: <20240411061713.1847574-7-alexs@kernel.org>
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

Save a compound calls.

Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 654400f993fc..b127d39c9af0 100644
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


