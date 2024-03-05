Return-Path: <linux-kernel+bounces-91979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B72871954
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855531C22551
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7CD5491D;
	Tue,  5 Mar 2024 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pC6Tygwp"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C49548EC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630109; cv=none; b=qn30cDVyM52b59+WVEkWR33Gz7cdq2kD5IRNNIJ3V/AsWRfjGfP92qdW6DfvP+r9X0izmp7PL+CraJuGljstiHAofEs/VQysYcY9as/nuBLmu58ey3ddT0ZqGBt9LNaRj30tDD022s8UpMZLhztRDhFu+03D0OpRJqE5I+XGhyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630109; c=relaxed/simple;
	bh=vbWOdiHcdkQkV5e3GR/xwQMpFev6VmOPwAPsQakVBAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qH2j5JHV811J+SO0w2Qxk5KOsFqzfGdE/eOpHjd9KFTeq4fjm+RJD5s1z7yD9qXao1s2rhR9Rae1Rg6zJIBBhYymLMl4JV3TRKCt3+1EzG5C+KgnXTCsf3HbmzUWDtxJF4x9ffn3M0qczrXxqXNxwTd2lGVY5Nz6vf73O+DCHek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pC6Tygwp; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709630099; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lShtNtGrB8mCBzJiVbOL4WhuapIFOn1RsN9gwurF4Ig=;
	b=pC6TygwpE7M24aVCDrQ6uwV4q1PAL7MujzrSLHZGIJb6PPYrYUebj75+0kIt4LVSP1ih0lYjWzDo13RIH7UEUJ7RzDGDvbRXOiKJtQ6LmYbeu7kJ/l9LcgfASx0WOirwnSm2IY2Ny4L0Qs9obFY8DwRCg6nAxazeXx3DE3qxfVo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W1tgGhK_1709630097;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1tgGhK_1709630097)
          by smtp.aliyun-inc.com;
          Tue, 05 Mar 2024 17:14:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 5/6] erofs: convert z_erofs_submissionqueue_endio() to folios
Date: Tue,  5 Mar 2024 17:14:47 +0800
Message-Id: <20240305091448.1384242-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240305091448.1384242-1-hsiangkao@linux.alibaba.com>
References: <20240305091448.1384242-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use bio_for_each_folio() to iterate over each folio in the bio and
there is no large folios for now.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d78cc54a96f5..63990c8192f2 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1566,19 +1566,19 @@ static void z_erofs_submissionqueue_endio(struct bio *bio)
 {
 	struct z_erofs_decompressqueue *q = bio->bi_private;
 	blk_status_t err = bio->bi_status;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	struct folio_iter fi;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
+	bio_for_each_folio_all(fi, bio) {
+		struct folio *folio = fi.folio;
 
-		DBG_BUGON(PageUptodate(page));
-		DBG_BUGON(z_erofs_page_is_invalidated(page));
-		if (erofs_page_is_managed(EROFS_SB(q->sb), page)) {
-			if (!err)
-				SetPageUptodate(page);
-			unlock_page(page);
-		}
+		DBG_BUGON(folio_test_uptodate(folio));
+		DBG_BUGON(z_erofs_page_is_invalidated(&folio->page));
+		if (!erofs_page_is_managed(EROFS_SB(q->sb), &folio->page))
+			continue;
+
+		if (!err)
+			folio_mark_uptodate(folio);
+		folio_unlock(folio);
 	}
 	if (err)
 		q->eio = true;
-- 
2.39.3


