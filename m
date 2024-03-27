Return-Path: <linux-kernel+bounces-120349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA04E88D61B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67B34B230CC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C961772F;
	Wed, 27 Mar 2024 05:55:03 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822E53DAC1A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 05:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711518903; cv=none; b=YGYQvH5kuRS2RdweLgNqk4MfOt8SbacRzcDdC2cZnxnJt3o97OA1lsIxU5saLfS5bzuBJcctRGWr2OpK/yjisHhVNp0wkO/GHf5ZEwmyU0UkmHuULfeNndQ84FQtaRlNchRlyCUB2DPuWyEFMmfTEt5Y1aqjOoH55A8DL2dBmtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711518903; c=relaxed/simple;
	bh=B2CqDLd7xqrIJ617xnnhv9Mb/WLtBFyjPuqNfaf3xvY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AOflz9qeCeumP9/nFMmW0fEJ6tqCpPmZTOduJgN92PInyg/qvwaCaRfF2o1sAkFnwzISvweR0r7F1K2Ii8wup2C3pKtgj/l/osTDDi8N7hNzVfHVaoy6N1z978nfPizFbuCnJNo1m1Ze9WtX2Vfaqg8wgaiQ50FQMsN0cQjamnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 42R5sBOs055570;
	Wed, 27 Mar 2024 13:54:11 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4V4G645Sjwz2Klktn;
	Wed, 27 Mar 2024 13:52:28 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 27 Mar 2024 13:54:09 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox
	<willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH] mm: fix unproperly folio_put by changing API in read_pages
Date: Wed, 27 Mar 2024 13:54:06 +0800
Message-ID: <20240327055406.1339636-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 42R5sBOs055570

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

According to the comments of readahead_page[3], the refcnt which
represents page cache dropped in [1] makes sense for two reasons, '1.
The folio is going to do IO and is locked until IO done;2. The refcnt
will be added back when found again from the page cache and then serve
for PTE or vfs' while it doesn't make sense in [2] as the refcnt of
page cache will be dropped in filemap_remove_folio.

  read_pages()
  {
    aops->readahead
    {
[1]
        folio = readahead_folio();
    }
..
[2]
    while (folio = readahead_folio())
        filemap_remove_folio(folio);
  }

[3]
 * Context: The page is locked and has an elevated refcount.  The caller
 * should decreases the refcount once the page has been submitted for I/O
 * and unlock the page once all I/O to that page has completed.
 * Return: A pointer to the next page, or %NULL if we are done.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/readahead.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 130c0e7df99f..657736200a92 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -163,7 +163,7 @@ static void read_pages(struct readahead_control *rac)
 		 * may be used to size the next readahead, so make sure
 		 * they accurately reflect what happened.
 		 */
-		while ((folio = readahead_folio(rac)) != NULL) {
+		while ((folio = __readahead_folio(rac)) != NULL) {
 			unsigned long nr = folio_nr_pages(folio);
 
 			folio_get(folio);
-- 
2.25.1


