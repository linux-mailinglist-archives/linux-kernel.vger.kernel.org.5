Return-Path: <linux-kernel+bounces-6746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62669819CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1FC288635
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BEA20B01;
	Wed, 20 Dec 2023 10:30:51 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B25210F5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 10:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3BKATt6H069490;
	Wed, 20 Dec 2023 18:29:55 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Sw8mD0818z2QJrHp;
	Wed, 20 Dec 2023 18:23:39 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 20 Dec 2023 18:29:53 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox
	<willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [RFC PATCH 1/1] mm: mark folio accessed in minor fault
Date: Wed, 20 Dec 2023 18:29:48 +0800
Message-ID: <20231220102948.1963798-1-zhaoyang.huang@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 3BKATt6H069490

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Inactive mapped folio will be promoted to active only when it is
scanned in shrink_inactive_list, while the vfs folio will do this
immidiatly when it is accessed. These will introduce two affections:

1. NR_ACTIVE_FILE is not accurate as expected.
2. Low reclaiming efficiency caused by dummy nactive folio which should
   be kept as earlier as shrink_active_list.

I would like to suggest mark the folio be accessed in minor fault to
solve this situation.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/filemap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index f0a15ce1bd1b..b1ee6ce716c2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3273,6 +3273,11 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 */
 	folio = filemap_get_folio(mapping, index);
 	if (likely(!IS_ERR(folio))) {
+		/*
+		 * try to promote inactive folio here when it is accessed
+		 * as minor fault
+		 */
+		folio_mark_accessed(folio);
 		/*
 		 * We found the page, so try async readahead before waiting for
 		 * the lock.
-- 
2.25.1


