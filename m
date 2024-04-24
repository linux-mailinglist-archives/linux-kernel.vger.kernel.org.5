Return-Path: <linux-kernel+bounces-157811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3091E8B1693
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CF91C243EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EC816F0E7;
	Wed, 24 Apr 2024 22:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GLOJ7n9M"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3883D16192C;
	Wed, 24 Apr 2024 22:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713999294; cv=none; b=G3IBqpnaHqh/ccUq4qIOi/n5n5fJgMSJxvpgsz5PcibV3MwPwmqPbVruknQj6gQt1VY5SyfOE9wq4k34eJrN+rXTYPZb3893BdLrtWhjAeWpultKG/ZovsIv545FUMrm8aqbjekb0Qpn0ZQMoGdc0VB5PQ0gSqLgjDOmmO3+gyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713999294; c=relaxed/simple;
	bh=T1ca1SK2WRVFnYrwkN6XvRdji6bMVu9U9aghprD8oY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIRE+EVNI1ynciTf8Goa1/j0ACFXvsGCJWaogEy9iCMTOcehTxD8Zv9GessxGwzULS63Yr3NR/qUgUl7pU1dngVP5ZpI3Pqar2G2x3wIHAQp7TsewQtdpqM0OTx8xXLddwiQEEnPmf9U8Tk8BRB9FQ8vEC6SbgCaE8Ro3ZDT9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GLOJ7n9M; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=muDeZ0tlWt27kuip/KmoQCU5uSua2F4Lkz04HVCl3SI=; b=GLOJ7n9MsnX8cT7Ol0Jq3B7oke
	XakDrBz62nFCW1+7tSom1DWnxTdrx9vfGaOdqMPsIZ3ASsJb27N+95zaDfI9JcOOHneo4BZzRhLfP
	23kOwiSO5Fm9sTN/ITMOdHhWZ9K9WlMoCGYyaAimCi2UjGE7sbQS808i1stHQBDY66QLmwe/Nvuii
	jQzyEow4oaq8dhWNg8SajN1NXgQTpBYs9ZhstehX7hnHSa9c3k73IhGttYUG9rOPirt9ejCJiCo4i
	Ft/vzmSmsCm85YZBlmV+Yx0Z0CiUcXMJ08/mdpkYv5gyGp5+4fSPGZzZjSoj6QXDk8Teij6FTM8xc
	Jz3b6GVg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzlVq-00000006HlX-16Z2;
	Wed, 24 Apr 2024 22:54:50 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org,
	ziy@nvidia.com,
	linux-mm@kvack.org
Cc: fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	hare@suse.de,
	john.g.garry@oracle.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH 2/2] mm/huge_memory: cap max length on debugfs file entry folio split
Date: Wed, 24 Apr 2024 15:54:49 -0700
Message-ID: <20240424225449.1498244-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424225449.1498244-1-mcgrof@kernel.org>
References: <20240424225449.1498244-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Don't allow to query beyond a mapped file's length. Since this is just
a debugfs interface allow userspace to be lazy and use a large value so
we can just use the entire file.

Without this we can end up wasting cycles looking for folios which
just don't exist for no good reason.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/huge_memory.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8386d24a163e..86a8c7b3b8dc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3535,7 +3535,7 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 	struct file *candidate;
 	struct address_space *mapping;
 	int ret = -EINVAL;
-	pgoff_t index;
+	pgoff_t index, fsize;
 	int nr_pages = 1;
 	unsigned long total = 0, split = 0;
 
@@ -3547,11 +3547,14 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 	if (IS_ERR(candidate))
 		goto out;
 
+	mapping = candidate->f_mapping;
+	fsize = i_size_read(mapping->host);
+	if (off_end > fsize)
+		off_end = fsize;
+
 	pr_debug("split file-backed THPs in file: %s, page offset: [0x%lx - 0x%lx]\n",
 		 file_path, off_start, off_end);
 
-	mapping = candidate->f_mapping;
-
 	for (index = off_start; index < off_end; index += nr_pages) {
 		struct folio *folio = filemap_get_folio(mapping, index);
 
-- 
2.43.0


