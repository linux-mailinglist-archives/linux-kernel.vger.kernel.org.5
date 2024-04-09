Return-Path: <linux-kernel+bounces-136556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E745889D581
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2439B1C22DA7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E4782C88;
	Tue,  9 Apr 2024 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHW5B7MG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB2D823A2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654723; cv=none; b=YUzzZIwqpnOdqjjeaADePbVarVtcm0U6//wu0p3uAgqO7FOXqqkkryFOzQFo0HAeljjBkPnlK0AuHhhPsaRBxoKqQPayb0/nWtO3zta04f5jicxgaLhxKZoZGEaa80+oYLCd2A/EKPNjEk7GRhA0kABYShtCQrHCcmSFeEtswEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654723; c=relaxed/simple;
	bh=h5mTUeVzSSO40P/dqunWDfKwvbrZ6ROf/OJsSV/+/Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AufyjW2xudqykNrEPzre+ISQvOq5CBDRpMzNo2zQRtzVMYL1eVGAKwnUCh+5Y/HLUpqQYZ0+KyHtgkkFKvhUdUPcyoYwO0VhmZArH7a9kUGRwPngA9EeOMEloQKvK3qWfqjAkwdFwUrQ1SXkj8ZbqPNjD5grf/3AfsBJSBGBJY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHW5B7MG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66ADAC433B2;
	Tue,  9 Apr 2024 09:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712654722;
	bh=h5mTUeVzSSO40P/dqunWDfKwvbrZ6ROf/OJsSV/+/Tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHW5B7MG3rTIH2E0eZCzzevv5RY2jP8XktDsl8WLKbwItLlisGdKj492muL5NV4mm
	 av+RdTMeEMaMoDsAGubCuRkp+hARu4OGfmFTc85AP7jc7sAxULjkUcM7mdviojnabW
	 1H9tHT4Y8NVSSOFaPSkMeCychOjudYI9JrQaQ3D6p9Q5kdA3d7F2Jw0WxPEVL771VY
	 CIJC3gE5IJ3yIRUl1QFORzLz2EPuU1CDn00wT4HkyOjJ3kdBDjeOyZ8OPD/tcw9G9I
	 JZWAIQHvQRvw/67Tmt0tYZYZtispL4c2DpDAYtoivh92pGDWgK0hFcj8zklPe3q91p
	 IPnjllxt9U90w==
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
Subject: [PATCH v4 3/9] mm/ksm: add folio_set_stable_node
Date: Tue,  9 Apr 2024 17:28:18 +0800
Message-ID: <20240409092826.1733637-4-alexs@kernel.org>
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

Turn set_page_stable_node() into a wrapper folio_set_stable_node, and then
use it to replace the former. we will merge them together after all
place converted to folio.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index ea3dabf71e47..c9b7c5701f22 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1109,6 +1109,12 @@ static inline void set_page_stable_node(struct page *page,
 	page->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
 }
 
+static inline void folio_set_stable_node(struct folio *folio,
+					 struct ksm_stable_node *stable_node)
+{
+	set_page_stable_node(&folio->page, stable_node);
+}
+
 #ifdef CONFIG_SYSFS
 /*
  * Only called through the sysfs control interface:
@@ -3241,7 +3247,7 @@ void folio_migrate_ksm(struct folio *newfolio, struct folio *folio)
 		 * has gone stale (or that folio_test_swapcache has been cleared).
 		 */
 		smp_wmb();
-		set_page_stable_node(&folio->page, NULL);
+		folio_set_stable_node(folio, NULL);
 	}
 }
 #endif /* CONFIG_MIGRATION */
-- 
2.43.0


