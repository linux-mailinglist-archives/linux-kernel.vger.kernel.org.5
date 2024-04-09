Return-Path: <linux-kernel+bounces-136559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D6289D585
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830781F22822
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C4085C66;
	Tue,  9 Apr 2024 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gic+mMF2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E30685953
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654731; cv=none; b=szMh0vxSnlES14cKdcpl+PIQdI47YxiR4lwKrh82tGY6cs2CblvJDLcoS/n/Dke5a3k0mRY2Xo1Z4sLsMOQ7PmIkfM0+pjXQwbZRXxB1XDZUMqZN0f7PiViqFgSeHIxfhlsfDLjwTtheVqubenmgJzoK/u+kQU8VilRMvItJAvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654731; c=relaxed/simple;
	bh=dJ5DRDYCIT+gow/J5pRXi3ey1ZJ/tDnBvGy0lEgeqkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edWmum+Fxcs1N93Pa0YaxVx9zjSmjcXAR3u6CdR27ZoeqW/hOXoFLW04yQnbNTX3o1qaHLah6rJCnaK/0mrP1yHmh+C3tCkGpxtbCBwfKlpkEHJUx5ChYPIBoK/K5hcZarP+X7LktvQJkUTM9K1CCYxJvoah5Id9Qr7wiSSbE8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gic+mMF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B23C433F1;
	Tue,  9 Apr 2024 09:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712654730;
	bh=dJ5DRDYCIT+gow/J5pRXi3ey1ZJ/tDnBvGy0lEgeqkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gic+mMF2M3oHglqJidfptsSOTIB5WDDSmFo1b/2IAIsAgt8Oz447ET1mybxFY1INy
	 BgMffSGcxZEVDBTTmnHAZjUoxh3ayyAO9oI5fOFrMQIfWYjbl1kbAUnVI3tgxFAA1t
	 WX6cYtXy20umo9u/uX+OznEJ9GemIxIa3Z1iYuqiNvdEQpTVsR0UbaCYphrDbKI2+k
	 HCvjTjAm2AEyo67B3Vrn9+TIOQ6OXfMPFuEwHROErNbWDFkU7d6feG8hxPQ45Y5gti
	 H8yg8goUkxXPDhDblpLIV2sIpGyk3ZceEplmGuo4cF1SvDwiALUVKeZYYN2/DUah6u
	 aHaCRd7rZJIlQ==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	Izik Eidus <izik.eidus@ravellosystems.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Chris Wright <chrisw@sous-sol.org>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 6/9] mm/ksm: use ksm_get_folio in scan_get_next_rmap_item
Date: Tue,  9 Apr 2024 17:28:21 +0800
Message-ID: <20240409092826.1733637-7-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240409092826.1733637-1-alexs@kernel.org>
References: <20240409092826.1733637-1-alexs@kernel.org>
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
Reviewed-by: David Hildenbrand <david@redhat.com>
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


