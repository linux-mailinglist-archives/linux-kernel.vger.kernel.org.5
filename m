Return-Path: <linux-kernel+bounces-25622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2234B82D3BA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1C81C20F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 04:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CD52566;
	Mon, 15 Jan 2024 04:53:07 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED65417D2;
	Mon, 15 Jan 2024 04:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-4a-65a4ba2da7c0
From: Honggyu Kim <honggyu.kim@sk.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	linmiaohe@huawei.com,
	lizhijian@cn.fujitsu.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [RFC PATCH 1/4] mm/vmscan: refactor reclaim_pages with reclaim_or_migrate_folios
Date: Mon, 15 Jan 2024 13:52:49 +0900
Message-ID: <20240115045253.1775-2-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240115045253.1775-1-honggyu.kim@sk.com>
References: <20240115045253.1775-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsXC9ZZnoa7uriWpButb9SzmrF/DZrHrRojF
	/73HGC2e/P/NanHiZiObRef3pSwWl3fNYbO4t+Y/q8WR9WdZLNbdArI2nz3DbLF4uZrFvo4H
	TBaHv75hsph8aQGbxYspZxgtTs6azGIx++g9dgchj/8HJzF7LD39hs1jQxOQaNl3i91jwaZS
	j5Yjb1k9Fu95yeSxaVUnm8emT5PYPU7M+M3isfOhpceLzTMZPXqb37F5fN4kF8AXxWWTkpqT
	WZZapG+XwJVx6+tKtoIL/BWzr/1lb2Bs4+1i5OSQEDCRONp2khXG3rFhHzuIzSagJnHl5SSm
	LkYODhEBB4lVXxW6GLk4mAXOMEs0915mAakRFoiUWPruESNIDYuAqsSMnYYgJq+AmcSnx7oQ
	EzUlHm//CTaRU8Bc4nX7G2YQWwiopHHtN7A4r4CgxMmZT8AmMgvISzRvnc0MskpCYBO7xJX+
	NYwQgyQlDq64wTKBkX8Wkp5ZSHoWMDKtYhTKzCvLTczMMdHLqMzLrNBLzs/dxAiMtWW1f6J3
	MH66EHyIUYCDUYmH98ffxalCrIllxZW5hxglOJiVRHgPPl+QKsSbklhZlVqUH19UmpNafIhR
	moNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoFxzjm2ozr/XHrjZwcu8P6dq1wfXP3/19HK
	g+UyPt/j61L9p9oL1vP9jr+b7b30tlO4zuympQEmWmtFp/J9fCdXmJhd43T8zIx5J+/2TmBZ
	cOX5F4uG1KLDZoXssXNLhDY8nZ286VLQ22UeRlxLo/Zreu4pD09qfTz7Yzsz77XkOSIfzA/3
	pnYrsRRnJBpqMRcVJwIAPKj9drECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LhmqGlp6u7a0mqwct2WYs569ewWey6EWLx
	f+8xRosn/3+zWpy42chm8fnZa2aLw3NPslp0fl/KYnF51xw2i3tr/rNaHFl/lsVi3S0ga/PZ
	M8wWi5erWezreMBkcfjrGyaLyZcWsFm8mHKG0eLkrMksFrOP3mN3EPH4f3ASs8fS02/YPDY0
	AYmWfbfYPRZsKvVoOfKW1WPxnpdMHptWdbJ5bPo0id3jxIzfLB47H1p6vNg8k9Gjt/kdm8e3
	2x4ei198YPL4vEkuQCCKyyYlNSezLLVI3y6BK+PW15VsBRf4K2Zf+8vewNjG28XIySEhYCKx
	Y8M+dhCbTUBN4srLSUxdjBwcIgIOEqu+KnQxcnEwC5xhlmjuvcwCUiMsECmx9N0jRpAaFgFV
	iRk7DUFMXgEziU+PdSEmako83v4TbCKngLnE6/Y3zCC2EFBJ49pvYHFeAUGJkzOfgE1kFpCX
	aN46m3kCI88sJKlZSFILGJlWMYpk5pXlJmbmmOoVZ2dU5mVW6CXn525iBMbSsto/E3cwfrns
	fohRgINRiYf3x9/FqUKsiWXFlbmHGCU4mJVEeA8+X5AqxJuSWFmVWpQfX1Sak1p8iFGag0VJ
	nNcrPDVBSCA9sSQ1OzW1ILUIJsvEwSnVwNgk876pYYaCp/mLZFetpBSjSN5vz6wvOFhpWQuy
	/unMPeHE4ly7TeJLUTmjPV/A0wTnXZNmn9M23stY9cK5MmFlwETt8EA7+/xD0gXzEnT9BK89
	7epl3bDQdP6t10p1DxnOvqs83RXN9m6qUfhy/Zev7QNcilnPxj0/32gQIp4geM/p7cfPSizF
	GYmGWsxFxYkAsorCzqECAAA=
X-CFilter-Loop: Reflected

Since we will introduce reclaim_pages like functions such as
demote_pages and promote_pages, the most of the code can be shared.

This is a preparation patch that introduces reclaim_or_migrate_folios()
to cover all the logics, but it provides a handler for the different
actions.

No functional changes applied.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
---
 mm/vmscan.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bba207f41b14..7ca2396ccc3b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2107,15 +2107,16 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 	return nr_reclaimed;
 }
 
-unsigned long reclaim_pages(struct list_head *folio_list)
+static unsigned long reclaim_or_migrate_folios(struct list_head *folio_list,
+		unsigned int (*handler)(struct list_head *, struct pglist_data *))
 {
 	int nid;
-	unsigned int nr_reclaimed = 0;
+	unsigned int nr_folios = 0;
 	LIST_HEAD(node_folio_list);
 	unsigned int noreclaim_flag;
 
 	if (list_empty(folio_list))
-		return nr_reclaimed;
+		return nr_folios;
 
 	noreclaim_flag = memalloc_noreclaim_save();
 
@@ -2129,15 +2130,20 @@ unsigned long reclaim_pages(struct list_head *folio_list)
 			continue;
 		}
 
-		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
+		nr_folios += handler(&node_folio_list, NODE_DATA(nid));
 		nid = folio_nid(lru_to_folio(folio_list));
 	} while (!list_empty(folio_list));
 
-	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
+	nr_folios += handler(&node_folio_list, NODE_DATA(nid));
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 
-	return nr_reclaimed;
+	return nr_folios;
+}
+
+unsigned long reclaim_pages(struct list_head *folio_list)
+{
+	return reclaim_or_migrate_folios(folio_list, reclaim_folio_list);
 }
 
 static unsigned long shrink_list(enum lru_list lru, unsigned long nr_to_scan,
-- 
2.34.1


