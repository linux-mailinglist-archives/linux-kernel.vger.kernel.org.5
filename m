Return-Path: <linux-kernel+bounces-81579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9614E8677D1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882921C22BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29F012BF3F;
	Mon, 26 Feb 2024 14:06:19 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583CA12A14A;
	Mon, 26 Feb 2024 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956379; cv=none; b=IUGh9nU5qUeOmLHsYRjPdAE01R6O4/PP3nOehDM+/3gj7jLt2ItN+eOQKndGER6eFeHW77N/EMngRlTW84Wau9JX9fPzRErHErkUm4GHxb9x53pvwxBGdpb6Y8nyfXHXYQgI6f1QJih1vXRoDRx5qeBOWbMP0u0a/lExEybsD3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956379; c=relaxed/simple;
	bh=Ig1CU3NKL8/cdJN+rmc1e4GaDBcrnBkfyq6QFF/1g7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8/0gnVdoWeg0h9p1ISwsgvd9dgak9cN0Xb2W9lgxjTbt+TcNWFktgr2tp1p4g6i1Kxj1DX13BD/VvODzQH+CkE4euCmUkniVa8zK0P6eYkyuYqmb5tTXYgSoSAbGATefGajivRjKeZKmvWPzH5D0DBIWFf+AwhIJkPnAR1mDIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-5d-65dc9ad5f17d
From: Honggyu Kim <honggyu.kim@sk.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	lizhijian@cn.fujitsu.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com
Subject: [PATCH v2 1/7] mm/damon: refactor DAMOS_PAGEOUT with migration_mode
Date: Mon, 26 Feb 2024 23:05:47 +0900
Message-ID: <20240226140555.1615-2-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240226140555.1615-1-honggyu.kim@sk.com>
References: <20240226140555.1615-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsXC9ZZnoe61WXdSDRb+ZbSY2GNgMWf9GjaL
	XTdCLP7vPcZo8eT/b1aLEzcb2Sw6vy9lsbi8aw6bxb01/1ktjqw/y2Kx7haQtfnsGWaLxcvV
	LPZ1PGCyOPz1DZPF5EsL2CxeTDnDaHFy1mQWi9lH77E7CHv8PziJ2WPp6TdsHhuagMTOWXfZ
	PVr23WL3WLCp1KPlyFtWj8V7XjJ5bFrVyeax6dMkdo8TM36zeOx8aOnxYvNMRo/e5ndsHp83
	yQXwR3HZpKTmZJalFunbJXBlzGnYwFzQwlsx78catgbGK1xdjJwcEgImEjfmPmXqYuQAsxdv
	1QIJswmoSVx5OQksLCLgILHqq0IXIxcHs0ADi8SPz5dYQGqEBXwk1v67wQ5iswioSvzaNB8s
	zitgJvHoWC8jxHhNicfbf4LVcAqYS/w/3M4GMlMIqObobWaIckGJkzOfgLUyC8hLNG+dzQyy
	S0LgFLvE3yvrWSHmSEocXHGDZQIj/ywkPbOQ9CxgZFrFKJSZV5abmJljopdRmZdZoZecn7uJ
	ERh9y2r/RO9g/HQh+BCjAAejEg+vQ+2dVCHWxLLiytxDjBIczEoivOEyN1OFeFMSK6tSi/Lj
	i0pzUosPMUpzsCiJ8xp9K08REkhPLEnNTk0tSC2CyTJxcEo1MDK+N4yt27RA9+y/ac7bG3rd
	Dz+yUDrannj3QV6ted70+a3f/ZKifvgU12UsuB/YVTyxslSkL/lnqMwXP1sPWSGeB3JTFtmG
	3z7qLOWYNm9R24NJbss36+yscjzc+K1eUO+lQNXsWZ2JgQd3xe8zfeywek10WvC1nbd1tSsZ
	rr5e/Ffj2KdFS5RYijMSDbWYi4oTAbUWVdi6AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsXCNUNLT/fqrDupBo0HdSwm9hhYzFm/hs1i
	140Qi/97jzFaPPn/m9XixM1GNovPz14zW3Q++c5ocXjuSVaLzu9LWSwu75rDZnFvzX9WiyPr
	z7JYrLsFZG0+e4bZYvFyNYtD156zWuzreMBkcfjrGyaLyZcWsFm8mHKG0eLkrMksFrOP3mN3
	EPf4f3ASs8fS02/YPDY0AYmds+6ye7Tsu8XusWBTqUfLkbesHov3vGTy2LSqk81j06dJ7B4n
	Zvxm8dj50NLjxeaZjB69ze/YPL7d9vBY/OIDU4BgFJdNSmpOZllqkb5dAlfGnIYNzAUtvBXz
	fqxha2C8wtXFyMEhIWAisXirVhcjJwebgJrElZeTmEDCIgIOEqu+KnQxcnEwCzSwSPz4fIkF
	pEZYwEdi7b8b7CA2i4CqxK9N88HivAJmEo+O9TKC2BICmhKPt/8Eq+EUMJf4f7idDWSmEFDN
	0dvMEOWCEidnPgFrZRaQl2jeOpt5AiPPLCSpWUhSCxiZVjGKZOaV5SZm5pjqFWdnVOZlVugl
	5+duYgRG2rLaPxN3MH657H6IUYCDUYmH16H2TqoQa2JZcWXuIUYJDmYlEd5wmZupQrwpiZVV
	qUX58UWlOanFhxilOViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYxhHAuf6dzr6NtyNJy7
	13qtTeBhUWmln4dEykuTjp9kPrPYvdXukZi588M8jvz/Okuuvs5e+U/k4+zt36xcRG4WSjyW
	j2Gbe+7GhJ35d3/qb7q6TXVr2Mlrj62Yb2bkL4n3/jzrYsN99qW/1PO3W39Rl/abUabYKMh2
	/GZw+UrX89m3ys78F+1XYinOSDTUYi4qTgQATejUCbACAAA=
X-CFilter-Loop: Reflected

This is a preparation patch that introduces migration modes.

The damon_pa_pageout is renamed to damon_pa_migrate and it receives an
extra argument for migration_mode.

No functional changes applied.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
---
 mm/damon/paddr.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 081e2a325778..277a1c4d833c 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -224,7 +224,12 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 	return false;
 }
 
-static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
+enum migration_mode {
+	MIG_PAGEOUT,
+};
+
+static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
+				      enum migration_mode mm)
 {
 	unsigned long addr, applied;
 	LIST_HEAD(folio_list);
@@ -249,7 +254,14 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 put_folio:
 		folio_put(folio);
 	}
-	applied = reclaim_pages(&folio_list);
+	switch (mm) {
+	case MIG_PAGEOUT:
+		applied = reclaim_pages(&folio_list);
+		break;
+	default:
+		/* Unexpected migration mode. */
+		return 0;
+	}
 	cond_resched();
 	return applied * PAGE_SIZE;
 }
@@ -297,7 +309,7 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 {
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
-		return damon_pa_pageout(r, scheme);
+		return damon_pa_migrate(r, scheme, MIG_PAGEOUT);
 	case DAMOS_LRU_PRIO:
 		return damon_pa_mark_accessed(r, scheme);
 	case DAMOS_LRU_DEPRIO:
-- 
2.34.1


