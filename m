Return-Path: <linux-kernel+bounces-157724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF11E8B1512
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29591C2387C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF2315698F;
	Wed, 24 Apr 2024 21:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="IsZyCOxu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iKH/4OFZ"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7B3745CB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713993038; cv=none; b=tYw7deVlk4j0y+tG9rjunuNu+akc1nZWw/h9qeN+wogI6ByRoHSggoA0c9pj/X1PzCHeA08BIjUst1C9rCbMen5vmqPLGcSMSXXIsqLQTIiUOQjwnaMIu5+nZDlUq6jY10iDPaBTMGqr7bzWbfORrj7trzXEYJS1KjRu0b+dAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713993038; c=relaxed/simple;
	bh=8YdfdSd5iOPEtRpSvYlPjstvzjwfPiKdAmYK/Egvfjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AsYO0aKo0iktn3mcth60HcvW4xOMdzpdBmO2FPikLzkUS0QVuoJ+j907s0QrOorKDpqaDxR4dMOVFe3GnaklmxgWiruapATMHUHiCt0HTCs0FD1qdKdSEPLOqC/IUtmH3sHkf7MNWdDyaIAf+lvtIiMX6GspUPvEq7NHu0v+ieg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=IsZyCOxu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iKH/4OFZ; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 38CA91C00138;
	Wed, 24 Apr 2024 17:10:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 24 Apr 2024 17:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1713993034; x=1714079434; bh=DNcr3ISM3z
	eCbWjs6xD/+8e+IXLwFKS7Mr3PFm4E1FE=; b=IsZyCOxuIpfFsk5m74SJCu8tgN
	+7B3k/EuxM6yFDk1dmDLxCrkqjx1tSVM0Fjks74eIPWH0X2lTnh2rCHGXaytj7CA
	hDVdboMCuazTzWsDe6TFZBUkVkpqyNiL/BYWteeJy4Y3N9jsDVF/fur0xwMGbU/h
	eGg1c2DpmkwL10xJIoItkGnfK6sEdBZ2fP1TCgi7w8a8v47Q8qPAwfqRITTlvcXq
	+jnquupDMmP8QHw99kdtRJgvkkDS+7yA6DBqmFtlArpfAfPawa4WIbf9nomXqsQs
	XSgyPmQy2AqeWIJZf4xN8/8q1p/Pm/noG4E3TkPqELSUPZX+YzOom9vgejRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1713993034; x=1714079434; bh=DNcr3ISM3zeCb
	Wjs6xD/+8e+IXLwFKS7Mr3PFm4E1FE=; b=iKH/4OFZZ/2H5crujtjTCVp/YhPCj
	ikXyqvR8lpN0jxmaDyeVpfadwDAJjKYhRGnr26jULLXZPBfJjFXfhBZKSVmInbaM
	9fMWfFrVtkCWP/xKcsZDPp0cCt0O3tFJLZvW/qwZBOVBYSzmJVzCEVRmtUnVRBTi
	Q0nCLl//YZYjZz/NS/iQpIbJPHkdjcn5SSBzu6IobN2CVtVEwa03I1wb0tuYqbZZ
	ujtcHOY+FKTWRSMevioi0m89xJtMm7bR1MeK0wnOxjeaYHqUvq25X0Za9+Meb5hF
	RTwtedvJdDCJ6Bn8pypWsDyso1TibFGrTTjEq9ZAvLOTYp2iblaaV/EDw==
X-ME-Sender: <xms:SnUpZgzSOnPJGbr5h8hmlKlZgPqdmmQnST7Q7jaxrQWxCzeqA9DZ3w>
    <xme:SnUpZkRTyDtJAvUVY5FJkqhLjska1RDBVcTK5Yq8CHaZletjdtpadwgrAyI6LamHI
    kHkHz17OdRNyytjdg>
X-ME-Received: <xmr:SnUpZiXkKiFVpg0A0oWlDBhN_LN3sdm3LakNop2VaQdCfU9yC_drEwKoVyhoF8pJ1yxUCoceaYdV2tbwgvRUw5PiWQLL-2zVV1jQ43fmCeaW2R6FI4AXtzj6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelhedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeffjeeuie
    efjedujedugfeitdefledtgfeufffhudelgfdtkeetkeefjeehkeehtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:SnUpZujNO1UlM1UW3_lXF2-HY8rQw3Olb9ZpFheYGHSI0ffE3ajEWA>
    <xmx:SnUpZiDgmEOCibeRjVyiIKnfJhzSpNPSOSWO0bi8Ac_r93aSE7WitA>
    <xmx:SnUpZvLJ2v9CIhYbzsllYeJbojxmxdd4M-JIPU9uW9oEKAwn2GSxcg>
    <xmx:SnUpZpD5TPvwGND5cI7gtZWsmcEHMvj51m5AcFGbvD6Q4pD5ZEmtAg>
    <xmx:SnUpZqs4AIYuvqa3HUQPJ7X0I8HhCb4pQ5QbZEjAiwaV53JfbRXv_G2C>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Apr 2024 17:10:33 -0400 (EDT)
From: Zi Yan <zi.yan@sent.com>
To: linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yang Shi <shy828301@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Barry Song <21cnbao@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/rmap: do not add fully unmapped large folio to deferred split list
Date: Wed, 24 Apr 2024 17:10:31 -0400
Message-ID: <20240424211031.475756-1-zi.yan@sent.com>
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
on the deferred split list, it will be skipped.

Commit 98046944a159 ("mm: huge_memory: add the missing
folio_test_pmd_mappable() for THP split statistics") tried to exclude
mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does not
fix everything. A fully unmapped PTE-mapped order-9 THP was also added to
deferred split list and counted as THP_DEFERRED_SPLIT_PAGE, since nr is
512 (non zero), level is RMAP_LEVEL_PTE, and inside deferred_split_folio()
the order-9 folio is folio_test_pmd_mappable(). However, this miscount
was present even earlier due to implementation, since PTEs are unmapped
individually and first PTE unmapping adds the THP into the deferred split
list.

With commit b06dc281aa99 ("mm/rmap: introduce
folio_remove_rmap_[pte|ptes|pmd]()"), kernel is able to unmap PTE-mapped
folios in one shot without causing the miscount, hence this patch.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/rmap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index a7913a454028..220ad8a83589 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		 * page of the folio is unmapped and at least one page
 		 * is still mapped.
 		 */
-		if (folio_test_large(folio) && folio_test_anon(folio))
-			if (level == RMAP_LEVEL_PTE || nr < nr_pmdmapped)
-				deferred_split_folio(folio);
+		if (folio_test_large(folio) && folio_test_anon(folio) &&
+		    list_empty(&folio->_deferred_list) &&
+		    ((level == RMAP_LEVEL_PTE && atomic_read(mapped)) ||
+		     (level == RMAP_LEVEL_PMD && nr < nr_pmdmapped)))
+			deferred_split_folio(folio);
 	}
 
 	/*

base-commit: 2541ee5668b019c486dd3e815114130e35c1495d
-- 
2.43.0


