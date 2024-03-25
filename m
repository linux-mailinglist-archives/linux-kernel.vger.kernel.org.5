Return-Path: <linux-kernel+bounces-117047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD3288A668
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDAC1F39F03
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE9B161927;
	Mon, 25 Mar 2024 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4e1gCa0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED69161915
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370782; cv=none; b=EizvLf1OKFR1sW5EDekygIYio/CpFF1sm4no6JmCSZqngVQouCb7oymN5pWmzU+cdOO/JJ38N+MHcmBZSmRFuq0MRh++D83cmqtUSA1dhXSQVVQ4gKcNEsaVMNPHAp3puRgtn9z8qx0UprI/cMG6a+nysR9dqAcpOK9KZHC/nJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370782; c=relaxed/simple;
	bh=ZriKAGE58KVGgk3LtHqsYBhdOJzv7LI/X6J606D1xxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQAih6YkLXG6E+18PdHTVjPsmvdFhSEIVhIRsnUitj6sTnpNXyKdeP7rgWQhMN60gw0SL/krEW1LKYQv4tXk7tnAwUFN/gqWHeL73ea0+w0t9aV5uHBXOk5bTm7PJtiQK4ZIyDS1BQe4+i1URsWT8H7TKTDzcX0mq4Gne3FSm2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4e1gCa0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07108C43390;
	Mon, 25 Mar 2024 12:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711370782;
	bh=ZriKAGE58KVGgk3LtHqsYBhdOJzv7LI/X6J606D1xxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R4e1gCa0XXthXxDX1BVjSpCwAOrXN3yXEnOKgM7VQzdWV57yKkfcA6jTRuemNBpPk
	 cB15ux/wXrKv9yHhvUufFYr2882U4OjiVTCQGdfIigsmAadPt7KopB0roJ8VFftt8a
	 ui44vFdFuoIKw0rV7d8UOx42w2pV8KnpkkqT4L/pnhwDAT6g4KoPWYmZB8HemEl3hU
	 bkNVVJKYJ6yao6nAcZx3Z4aDvnCRwp/dX041t87HyEv3ahSuOCQwKWNtjXiz/IZKxf
	 F5ssZsBvG+eP5J/A2c32/8//4yXzJ6pe4Wgcr9nhm1SbFY4WMaTTMJVug1bcTPZTb4
	 EgwXN9kXAKISQ==
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
Subject: [PATCH v3 13/14] mm/ksm: use folio_set_stable_node in try_to_merge_one_page
Date: Mon, 25 Mar 2024 20:49:00 +0800
Message-ID: <20240325124904.398913-14-alexs@kernel.org>
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

Only single page could be reached where we set stable node after write
protect, so use folio converted func to replace page's.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
---
 mm/ksm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 15a78a9bab59..d7c4cc4a0cc1 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1518,7 +1518,7 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
 			 * PageAnon+anon_vma to PageKsm+NULL stable_node:
 			 * stable_tree_insert() will update stable_node.
 			 */
-			set_page_stable_node(page, NULL);
+			folio_set_stable_node(page_folio(page), NULL);
 			mark_page_accessed(page);
 			/*
 			 * Page reclaim just frees a clean page with no dirty
-- 
2.43.0


