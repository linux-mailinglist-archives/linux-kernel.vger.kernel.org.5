Return-Path: <linux-kernel+bounces-111142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D5E88684F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BAB283446
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947D73F8C2;
	Fri, 22 Mar 2024 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAcwg2U9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAAE3E49C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096509; cv=none; b=HGCPXePCAJswK4qKRViNfuvavfP/YQym/T7+nAPSKG0TNqCx5vj3XEtswfmGr6HURzilqSaPkMl+LHmsYIxGZa3C5uNxy0dr51Y1Paw1NhqkpZSLnJ3/WlEV7k6078b1/6SsY/cMED58kWkFooGjo4W1XsM3EiQ2i+o9jtjMK2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096509; c=relaxed/simple;
	bh=ZriKAGE58KVGgk3LtHqsYBhdOJzv7LI/X6J606D1xxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amGCau8IYuNXm1CpHCENjGYtzl99bQISG8uFCNZwe+7aTxBXWoSPpL1AUKSzoGc6DXSWyWTTbHJ0s5BIZoNnmibr3vE/QxpgLjoNoZDjs6I6bV10dc0Cku22h2KPhlO1UTsZ2x94nVEa2ziSIC5xLDTNX7aPsLv6K3dTmxQ6z9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAcwg2U9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484F1C43399;
	Fri, 22 Mar 2024 08:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711096509;
	bh=ZriKAGE58KVGgk3LtHqsYBhdOJzv7LI/X6J606D1xxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iAcwg2U9TA5i2WgtDkxRMvKzkar2T0ss4NV9QTixbCGq/vdCNstF1KB7VAtunrssD
	 roMaD4WVS54iqRVPCPq+8eu/D56fmO+XQtn/NRSeXhJuc2PfZCkA/BLwhnS5EZdZy7
	 y1acuH42/rzI5sikMvS+UcpS+RP522841XB3DOjkzB+uGxSBmrjUq+InQ67lNY75c2
	 v2AOGRLtDpSo45fcsKX+d5T7ViAUoXym1Jh4dNGUDI51D7Y9GcF3fNZvf/bPUPFI5K
	 sS9y+mlzPqzI3051GE6T8aiyK68i5He/zcTKNaQfSGI9ORdzAnckSHwGeYYok2i8Fr
	 X08VhSxlTW+Sg==
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
Subject: [PATCH v2 13/14] mm/ksm: use folio_set_stable_node in try_to_merge_one_page
Date: Fri, 22 Mar 2024 16:37:00 +0800
Message-ID: <20240322083703.232364-14-alexs@kernel.org>
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


