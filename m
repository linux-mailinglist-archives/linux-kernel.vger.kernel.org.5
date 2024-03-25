Return-Path: <linux-kernel+bounces-117036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7963988A65B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305A11F39F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E02E15D5DE;
	Mon, 25 Mar 2024 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Whi5pHJZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65106EB69
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370753; cv=none; b=Z0eBFUtJoQgnWfqM122FEH2cAO1ybpd66VDXT3BMhbmvri79O4rp9FSIKkx7K2ZGLq42jUdvQHqpOFtsxDuYZ8AVpZ63A5m9LBltfsm8oH/0IgIRIg10W+t08KKZ59MxoZ7ptCs6rX0SRGVwdTEkaQyQYy6SpcYwS3shYOymFek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370753; c=relaxed/simple;
	bh=JrD4352jMaYHyAz8IW4Sk3DaQV9z/B+p1XK/ErSE0cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfJ9BmGrgLM6upAPtnjY9kstxgo6nS6XpECeTEb01Q4uInGFZYM8/VCtnYDgm/NZd58vQR/CeasAWR9fDupURoDqFf9dB3qmCc6wgEBsaQLzUOT8deIN8QNP7IxlFVcTl6P0Xo8B20pUO8z+Hrhihl8fDeS2C0YFO5Td1zY5Sbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Whi5pHJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05091C433C7;
	Mon, 25 Mar 2024 12:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711370753;
	bh=JrD4352jMaYHyAz8IW4Sk3DaQV9z/B+p1XK/ErSE0cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Whi5pHJZTUlUd6zeuH0lUbmTWwy8sj968vK2RQbExjSv4J927iQXRAax2+zqP3+8Z
	 syH0Miydew3n+dIqfFQbEdodShg6okCztcVT1q/0589fuGXcfUyzduK6ZLpruSDHQG
	 3ZJJAaqW+jGIx0FmJUNVsuUy8O+V183kQWq9ZI5P+NnBZUHq4iLWx8Si409N3S33xo
	 uUtJvUSWMGqZ0Dn4M3kn9lOThpHWghQ3aPLhvV11Zk1dkPmeiEWNNzvj1Zp9e2UbXj
	 ga9Fu+iazyMERJXJ+ZWG4V/8cwEH/THIP5vbAm67Aj1t2p2C3InwRy3kCtGkNu6HGD
	 i24BIgprJ7qvw==
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
Subject: [PATCH v3 03/14] mm/ksm: add folio_set_stable_node
Date: Mon, 25 Mar 2024 20:48:50 +0800
Message-ID: <20240325124904.398913-4-alexs@kernel.org>
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


