Return-Path: <linux-kernel+bounces-157801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A608B166B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BFE5B21A76
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6809D16E87B;
	Wed, 24 Apr 2024 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="WcN84l6Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QS77Cz/3"
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49782142E6F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998781; cv=none; b=Cej+jJXbUJPAlBg7oRANLxp+aeFLRoASuog43IiMsJTdZQyYpabDud90Tgp/I3OV0/2JhQ1wiYtvkTZK+4d4DT7Ekp902XLmbhOdK6NXHlb/q7bmgzGHBI4jSQG/987FD/DVydd1C+j4Sg4WMlJuJ1GIzRNXUJtsJ3mAMZHI1z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998781; c=relaxed/simple;
	bh=PWMEcifnbOBNb9cFqvl7nyAKQSwJWVOg4tHQ66KBVo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kKGEc8xMYWAuDYKqRq4vP7QDtgc9+9ehcciwg6QfyrPH6TlWbRy3paMsy4FpmVDmg/aED/DatMtKiJ5fSObgj9ztxLswcSDmcmxO2RL4av69E1RW6JLmRHG+oyxIcaXNqPkh8jgUhpABDEjtBaWaj6LV1W3hRe5EvfYD4j7rm+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=WcN84l6Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QS77Cz/3; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 747171C000B1;
	Wed, 24 Apr 2024 18:46:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 24 Apr 2024 18:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1713998776; x=1714085176; bh=qiywAs5hIZ
	VDAA1bE5nB42rMvHU8KwAHDhD7k65/QJg=; b=WcN84l6Qu8p3lJjAlR3XpsLG0Z
	nilPUeXyqxmJrVGYgtueVwL3KvtMWjVow+wydOkwq1Y/qSbOgqza8d00Qh2TFRUw
	CqmqkZUwCkjGSmFWiuH9X226gVJuiVQ7qyzqakiy/Jt8mRwo2PcwMgJHNcLGmdAI
	U13Bh8+VEOOIZME2pikyPa//RB9KgoUjfP+b9HtzL0OtJMhuZGf6Sk47bffB84xw
	bz3EHcQvBq89PWQNg0I0PrVwggAfGLokZZzvQ2SBMgb4CsAWvqnHnKbau5LVJGMm
	zJ33DETgVtV5AeDpJjUEl+D7wHbEY2pnDsP92u9Edp7JzrzmN02GYh3Cs9qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1713998776; x=1714085176; bh=qiywAs5hIZVDA
	A1bE5nB42rMvHU8KwAHDhD7k65/QJg=; b=QS77Cz/3d2JacPLVmzr7R7fTijrMu
	uBAe86oC+7GUW1D6p3IarpZ41hTvufb+funKYbeQ33cqO7XFSCHZgpinrCcqltrq
	tm66kvrGaIqY8TBmTIh0AkTk8FRKmFJrIfbHMARUNe24OF4wfS2SOJO5nS9bz8xY
	S8C10MIl/qxYa44Xe/zBJy8wTVnGmPPGEHLAqDPzLc8IbIvwpf4OMNVbxkjqAUW/
	fodTu1oA+vI1nRbP9C12LdZ+xqS+EkVvy0Fh4TyEMH6J8StETSEBy6oABR1zAp8/
	wtS40UwpQ4yPZd7zgDR2deJ3U6kXqmUqgtGzef/umvZgevBBIfYE36WhQ==
X-ME-Sender: <xms:uIspZihuk9LY-BjwG9jI_ZWAXCTNnbAfkqNkw_-G949xy0ZCQHxY_A>
    <xme:uIspZjDzk6J0fcl4LbXCO1CcdMh9ZAMfLYlL5XWT8ee_UJeqMi6djPwF7h5z6S7_P
    WKcUmBuhWE92Urd3g>
X-ME-Received: <xmr:uIspZqEDHO2OhRMPreLjxk-kT7s1LcxkIiZNtM2fi5Xhf5vK0Dej92riYJXVu7WXus-HWLLW9OaiyuCcRbDMCElKHXtQbocQoBmQQ3lsk-BW9vZS5rF11hdU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeliedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeffjeeuie
    efjedujedugfeitdefledtgfeufffhudelgfdtkeetkeefjeehkeehtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:uIspZrSdf1sBxzkXPnDIAFeepjQUcpOdLJHT4Cr5ZppKCOSPKRc1hw>
    <xmx:uIspZvyhOVO54ihQovbaXOCzH4v5RWpoUwbB8A3-Uw4eJPQAf8pHVQ>
    <xmx:uIspZp78SJQJViHIRqkPCbMjJTUWnZfG5-F_LApWOH7AM_7V5kcluA>
    <xmx:uIspZswUTw522nAv0avpiLy_D7JWYC21_FALagNuZW0QqN4wQp9mSw>
    <xmx:uIspZkqrfAvKSOUwAJxEkRt3lYhSQijts-nHE3g_zJwVpzbHLAcJ4f9r>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Apr 2024 18:46:16 -0400 (EDT)
From: Zi Yan <zi.yan@sent.com>
To: linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yang Shi <shy828301@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Barry Song <21cnbao@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Lance Yang <ioworker0@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm/rmap: do not add fully unmapped large folio to deferred split list
Date: Wed, 24 Apr 2024 18:46:14 -0400
Message-ID: <20240424224614.477221-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

In __folio_remove_rmap(), a large folio is added to deferred split list
if any page in a folio loses its final mapping. It is possible that
the folio is unmapped fully, but it is unnecessary to add the folio
to deferred split list at all. Fix it by checking folio->_nr_pages_mapped
before adding a folio to deferred split list. If the folio is already
on the deferred split list, it will be skipped. This issue applies to
both PTE-mapped THP and mTHP.

Commit 98046944a159 ("mm: huge_memory: add the missing
folio_test_pmd_mappable() for THP split statistics") tried to exclude
mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does not
fix the above issue. A fully unmapped PTE-mapped order-9 THP was still
added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
deferred_split_folio() the order-9 folio is folio_test_pmd_mappable().
However, this miscount was present even earlier due to implementation,
since PTEs are unmapped individually and first PTE unmapping adds the THP
into the deferred split list.

With commit b06dc281aa99 ("mm/rmap: introduce
folio_remove_rmap_[pte|ptes|pmd]()"), kernel is able to unmap PTE-mapped
folios in one shot without causing the miscount, hence this patch.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
---
 mm/rmap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index a7913a454028..2809348add7b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1553,9 +1553,10 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		 * page of the folio is unmapped and at least one page
 		 * is still mapped.
 		 */
-		if (folio_test_large(folio) && folio_test_anon(folio))
-			if (level == RMAP_LEVEL_PTE || nr < nr_pmdmapped)
-				deferred_split_folio(folio);
+		if (folio_test_large(folio) && folio_test_anon(folio) &&
+		    ((level == RMAP_LEVEL_PTE && atomic_read(mapped)) ||
+		     (level == RMAP_LEVEL_PMD && nr < nr_pmdmapped)))
+			deferred_split_folio(folio);
 	}
 
 	/*

base-commit: 2541ee5668b019c486dd3e815114130e35c1495d
-- 
2.43.0


