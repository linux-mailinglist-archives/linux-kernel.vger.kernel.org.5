Return-Path: <linux-kernel+bounces-111132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCED886844
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B021C21F8E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE03222331;
	Fri, 22 Mar 2024 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZsUV3DT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7C9210E9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096480; cv=none; b=jXb2HuPt1lfQGRcN3yalseA7iW/3RYp8yxxDBw5UoDXcOb5zca9z79h263AhDvWM3FOnioew2gLg6lY6KN7ITgHO5LzzGBfixhskBYidDz4atJ1gmk2Wbt9MLXiZT7pnM3r4Na68DgYbWUmJYlyUtiDxVyZD0Iaw6B3lRO6bdcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096480; c=relaxed/simple;
	bh=JrD4352jMaYHyAz8IW4Sk3DaQV9z/B+p1XK/ErSE0cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxfIdZrsTbbJFVpFIb1gU9rH0vfHbhTlZI8DLJDvXuY71jynt2QJdD4moMNO+jmMMbLscxSGr+jRlUFTtngGTvmbNTZ0grI/RQhsqrIHPTTWTzj6r07/gekPgY8r23gxyn29xfQF5MX+STkqc3yF7zTNK4aOf3i9hZW7lhcfkVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZsUV3DT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D24C433C7;
	Fri, 22 Mar 2024 08:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711096480;
	bh=JrD4352jMaYHyAz8IW4Sk3DaQV9z/B+p1XK/ErSE0cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oZsUV3DTdJGLOu3ArzMd4oBovBPkSTl3ExBe2TyrGm2/jsGBl0k10Tvb00FSPq3S6
	 HrYImJ0RI3HDEKE7ufsczVtoViNfJEwZN9YIkae2ZLk6e3LzCTFevFL5JDTvjrfEi2
	 1Krww+MAEQwxg1AHgGsJp/Ixwx4wJqSIL3gSdw6vxRe5OKsZC9Q1IKRshBGsMmOMOI
	 CEvi84IPNAKHdOC78TlZvwbMIAMRx/CYz+BIm3cTd59Td9FnlatulZGWWUAh0h/2Zo
	 QrPXJLuUfcwuY1AVKIhMNeokjf9qdt96JM8SbuxOL/2KIkf6uHch3y3hWX9UK8wv3P
	 OYqn8jLHP5OCQ==
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
Subject: [PATCH v2 03/14] mm/ksm: add folio_set_stable_node
Date: Fri, 22 Mar 2024 16:36:50 +0800
Message-ID: <20240322083703.232364-4-alexs@kernel.org>
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

Turn set_page_stable_node() into a wrapper folio_set_stable_node, and then
use it to replace the former. we will merge them together after all
place converted to folio.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
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


