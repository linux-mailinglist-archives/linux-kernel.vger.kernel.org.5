Return-Path: <linux-kernel+bounces-68504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E63857B57
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E781F218F8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68AA59B59;
	Fri, 16 Feb 2024 11:16:10 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA7A59B47;
	Fri, 16 Feb 2024 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082170; cv=none; b=pZOBSZ4gcWlE5LOVtjGtxa/ZHD0InsBDvjT2UHaKXt2pEIir/U82Lz4aqdTTN87dMjmIcD1aDuGJX9/82MPjV4s61lqyObBpQZV2Z0b0Dakf4/N3Aj25HC7b1/517IVf45nkkg5tGOCx2H/7vN0FiCyD/Wclv5vzE6GUY6NzKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082170; c=relaxed/simple;
	bh=9cQF1rIO8RSJzsP9my6CHgiO2RH8oNNFSgPkEebj1tw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CFoPGVN0hRn/lCQ+mEuG8k8zWQLZVfTqoyxOvloJoTl63xsT1KjZ4F3tcwhvOOUxjZW5Zl8vANe2hPUEa7pyO51dOOKLBGOhEJBglOb7VCzlfT6n9yFp+aTmUsjGux6f21oERyWwQV3PIGIp3yFlpEL8Hyy1fBtYXaNmdVlaSaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-14-65cf43f15fe6
From: Byungchul Park <byungchul@sk.com>
To: akpm@linux-foundation.org,
	ying.huang@intel.com,
	osalvador@suse.de,
	baolin.wang@linux.alibaba.com,
	hannes@cmpxchg.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	stable@vger.kernel.org
Subject: [PATCH] mm/vmscan: Fix a bug calling wakeup_kswapd() with a wrong zone index
Date: Fri, 16 Feb 2024 20:15:02 +0900
Message-Id: <20240216111502.79759-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpiluLIzCtJLcpLzFFi42LhesuzUPej8/lUgxcLBSzmrF/DZvF/7zFG
	i9WbfC0u75rDZnFvzX9WizPTiiwWbHzEaHFy1mQWBw6Pw2/eM3ss3vOSyWPTp0nsHidm/Gbx
	2PnQ0mPz6WqPz5vkAtijuGxSUnMyy1KL9O0SuDJ+zr/OVNAsUbF+gXADY7NIFyMnh4SAicS0
	u+vYYewVP3+xgNhsAuoSN278ZO5i5OIQEWhklPj0bAdYEbNAtsS9Gf1MILawQKhE59s7jCA2
	i4CqRPfaJlYQm1fAVGLxtEWsEEPlJVZvOMAMYX9klZg22xHClpQ4uOIGywRG7gWMDKsYhTLz
	ynITM3NM9DIq8zIr9JLzczcxAkNmWe2f6B2Mny4EH2IU4GBU4uE98OdsqhBrYllxZe4hRgkO
	ZiUR3km9Z1KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xp9K08REkhPLEnNTk0tSC2CyTJxcEo1
	MLJ3soR4FXO1zmN0ldR+J61Tzt8TnHTyKOvCtJ+dbx6FurFneNj0sjBNPXnqQYb5FbuW1mtR
	b1I3PKrw+PhgvUJ5nUyshNWpj7NvSvzPZ3r5oI5v7gPBD6cMKvIKIu5JX52d8l5t86J5xo/y
	LtyW415Y7WF0Y5/rXD3T7PeG2YtC5N58mKlWqMRSnJFoqMVcVJwIAJhkPsgVAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFJMWRmVeSWpSXmKPExsXC5WfdrPvR+XyqwaurTBZz1q9hs/i/9xij
	xepNvhaH555ktbi8aw6bxb01/1ktzkwrsliw8RGjxclZk1kcOD0Ov3nP7LF4z0smj02fJrF7
	nJjxm8Vj50NLj8UvPjB5bD5d7fF5k1wARxSXTUpqTmZZapG+XQJXxs/515kKmiUq1i8QbmBs
	Fuli5OSQEDCRWPHzFwuIzSagLnHjxk/mLkYuDhGBRkaJT892sIMkmAWyJe7N6GcCsYUFQiU6
	395hBLFZBFQlutc2sYLYvAKmEounLWKFGCovsXrDAeYJjBwLGBlWMYpk5pXlJmbmmOoVZ2dU
	5mVW6CXn525iBIbAsto/E3cwfrnsfohRgINRiYf3wJ+zqUKsiWXFlbmHGCU4mJVEeCf1nkkV
	4k1JrKxKLcqPLyrNSS0+xCjNwaIkzusVnpogJJCeWJKanZpakFoEk2Xi4JRqYNxk0mHso510
	I6HTz3nvcqFHMw26q07Uuh6/cGuvkdee8CNHHwbfrnwn2nyRqfTvIxnm/7fcncK/zjGpvn8g
	8OHE829eT353KSbeLu+r0CmJtLC2lvmfCrVk2VU5eqKn2J8Nm7a7dP8umRiFZMn1Knc3/9Or
	PVHJtodl9jmfSxuFJ9mZLboTcE+JpTgj0VCLuag4EQCvUs+P/QEAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

With numa balancing on, when a numa system is running where a numa node
doesn't have its local memory so it has no managed zones, the following
oops has been observed. It's because wakeup_kswapd() is called with a
wrong zone index, -1. Fixed it by checking the index before calling
wakeup_kswapd().

> BUG: unable to handle page fault for address: 00000000000033f3
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 2 PID: 895 Comm: masim Not tainted 6.6.0-dirty #255
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>    rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> RIP: 0010:wakeup_kswapd (./linux/mm/vmscan.c:7812)
> Code: (omitted)
> RSP: 0000:ffffc90004257d58 EFLAGS: 00010286
> RAX: ffffffffffffffff RBX: ffff88883fff0480 RCX: 0000000000000003
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88883fff0480
> RBP: ffffffffffffffff R08: ff0003ffffffffff R09: ffffffffffffffff
> R10: ffff888106c95540 R11: 0000000055555554 R12: 0000000000000003
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff88883fff0940
> FS:  00007fc4b8124740(0000) GS:ffff888827c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000033f3 CR3: 000000026cc08004 CR4: 0000000000770ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
> ? __die
> ? page_fault_oops
> ? __pte_offset_map_lock
> ? exc_page_fault
> ? asm_exc_page_fault
> ? wakeup_kswapd
> migrate_misplaced_page
> __handle_mm_fault
> handle_mm_fault
> do_user_addr_fault
> exc_page_fault
> asm_exc_page_fault
> RIP: 0033:0x55b897ba0808
> Code: (omitted)
> RSP: 002b:00007ffeefa821a0 EFLAGS: 00010287
> RAX: 000055b89983acd0 RBX: 00007ffeefa823f8 RCX: 000055b89983acd0
> RDX: 00007fc2f8122010 RSI: 0000000000020000 RDI: 000055b89983acd0
> RBP: 00007ffeefa821a0 R08: 0000000000000037 R09: 0000000000000075
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> R13: 00007ffeefa82410 R14: 000055b897ba5dd8 R15: 00007fc4b8340000
>  </TASK>

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reported-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Cc: stable@vger.kernel.org
Fixes: c574bbe917036 ("NUMA balancing: optimize page placement for memory tiering system")
---
 mm/migrate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index fbc8586ed735..51ee6865b0f6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2825,6 +2825,14 @@ static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
 			if (managed_zone(pgdat->node_zones + z))
 				break;
 		}
+
+		/*
+		 * If there are no managed zones, it should not proceed
+		 * further.
+		 */
+		if (z < 0)
+			return 0;
+
 		wakeup_kswapd(pgdat->node_zones + z, 0,
 			      folio_order(folio), ZONE_MOVABLE);
 		return 0;
-- 
2.17.1


