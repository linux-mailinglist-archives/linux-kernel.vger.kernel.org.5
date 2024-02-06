Return-Path: <linux-kernel+bounces-54526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 702C884B04E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27AEC288264
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DED912B146;
	Tue,  6 Feb 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oHBD9nEY"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E2012BEA2
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209315; cv=none; b=hZBqlVZTMn0kgvsrEFuvfKGff9lJnYbbqU2Zo/xm3saqljqv99JhsVhKBf8SyOyP3ZwXjAGIefbm3Mvn3mu9MgWbRbNm5WUkZD6EWv/t91hZIkNf2ySyzYWpvwsDupvpSr9Yb8GnbeJke+/9h+aT3EqEMUDPN/esJ7udmerP9aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209315; c=relaxed/simple;
	bh=aT/CkiJIYu8ukwP0OeHxZgN3d9mcS6SutCMYSXztOEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GzC7gipuKv+VqBLht/1CyfCNNTpZHKELhnL/PTot8ROdu33/8L8n3hbB4i4l1YXOec5kt40YdMTjahenbMs0id9sW3z2HvNeerqvGeiuGorXTQSCIBF6kkdLnLLiaUmrrQBRQpofGauVv6DrI/IkFzCjrK7tjTg5YR43kQuo9LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oHBD9nEY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707209312;
	bh=aT/CkiJIYu8ukwP0OeHxZgN3d9mcS6SutCMYSXztOEw=;
	h=From:To:Cc:Subject:Date:From;
	b=oHBD9nEYlfXbX0kGB1OD8e3b3FDSusD5ao88V1k54bq/fP1UPoCh4WlCpEj0zDgKI
	 zzDGFy0VDBc4u2FVDOZNkAb/hY9p1xHkLvANakuW7xod4ZTVo/3XacBlPfmn5mXoCn
	 FyjpPLijwAyt/Tts6DGZ6ZsWAx9rx5lDlbJJqzC4U/qruMAvVvAMC161hO0LiREh/c
	 BMwO7r63QTTj4+rJMsnd9J+WeAPDpMkDg7neU1COnIL7aIU7o1pui4lp01LYjVqZ/A
	 hAOqHo2pUaS3loFPYmgb9VBSAD5w7S9UKnoV42sjTDStrz217I5cG2OpDdcS0eQ57Q
	 i1MUmVbSf+QqA==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B7C43378000E;
	Tue,  6 Feb 2024 08:48:29 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Gofman <pgofman@codeweavers.com>,
	usama.anjum@collabora.com,
	kernel@collabora.com,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <emmir@google.com>,
	Andrei Vagin <avagin@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/migrate: preserve exact soft-dirty state
Date: Tue,  6 Feb 2024 13:48:01 +0500
Message-ID: <20240206084838.34560-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Paul Gofman <pgofman@codeweavers.com>

pte_mkdirty() sets both _PAGE_DIRTY and _PAGE_SOFT_DIRTY bits. The
_PAGE_SOFT_DIRTY can get set even if it wasn't set on original page
before migration. This makes non-soft-dirty pages soft-dirty just
because of migration/compaction. Clear the _PAGE_SOFT_DIRTY flag if
it wasn't set on original page.

By definition of soft-dirty feature, there can be spurious soft-dirty
pages because of kernel's internal activity such as VMA merging or
migration/compaction. This patch is eliminating the spurious soft-dirty
pages because of migration/compaction.

Cc: Michał Mirosław <emmir@google.com>
Cc: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Paul Gofman <pgofman@codeweavers.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 mm/migrate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index cc9f2bcd73b4..05d6ca437321 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -211,14 +211,17 @@ static bool remove_migration_pte(struct folio *folio,
 		folio_get(folio);
 		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
 		old_pte = ptep_get(pvmw.pte);
-		if (pte_swp_soft_dirty(old_pte))
-			pte = pte_mksoft_dirty(pte);
 
 		entry = pte_to_swp_entry(old_pte);
 		if (!is_migration_entry_young(entry))
 			pte = pte_mkold(pte);
 		if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
 			pte = pte_mkdirty(pte);
+		if (pte_swp_soft_dirty(old_pte))
+			pte = pte_mksoft_dirty(pte);
+		else
+			pte = pte_clear_soft_dirty(pte);
+
 		if (is_writable_migration_entry(entry))
 			pte = pte_mkwrite(pte, vma);
 		else if (pte_swp_uffd_wp(old_pte))
-- 
2.42.0


