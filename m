Return-Path: <linux-kernel+bounces-68536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D75857BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63AB31C226CF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A8977F19;
	Fri, 16 Feb 2024 11:41:06 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980C81E532
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083666; cv=none; b=VHJTt9rOojP1C2rs+7Q29snwUOOCp2B1Ze2ZAitGFa3sk5tOcLipx8HcQMbnA1UP8Lrw+ohxpPMk2ANL4e4LsdQF1f8PIN5ehes3oIFbVD0PdsGKYW8wCigIay2YemgcJKdtTwo/eYYtfxJcSNfQu8nBJ7/3fR4sWZ4X4/EZOQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083666; c=relaxed/simple;
	bh=1DTsuV0GohoVyTNm9GIav9horrUC6znhfC34fbIjuiQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DC4/gFyfDZdJfCar1O0UmMnRknDxuwG1pTrIjIM/hqWJ6GtVnMgVaLkWeFxeUlBLdEWv6aJ4cFxR6FiTbp7BhTzLnpUdI6oljHZlLFouU4oLumHIki4JoKXojccw/knpp22/4aKsW7dAdp70uSIKihc9aZ3jqmQM/xGd8I9cHuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-3c-65cf49c77cc0
From: Byungchul Park <byungchul@sk.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	akpm@linux-foundation.org
Subject: [PATCH v3] sched/numa, mm: do not promote folios to nodes not set N_MEMORY
Date: Fri, 16 Feb 2024 20:40:45 +0900
Message-Id: <20240216114045.24828-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsXC9ZZnke5xz/OpBg0/9S3mrF/DZnHp8VU2
	i+kvG1ksnk7Yymxxt38qi8XlXXPYLO6t+c9qMfndM0aLSwcWMFkc7z3AZLGv4wGTRceRb8wW
	W49+Z3fg9Vgzbw2jR8u+W+weCzaVemxeoeWx6dMkdo871/aweZyY8ZvF4/2+q2wem09Xe3ze
	JBfAFcVlk5Kak1mWWqRvl8CVMWHvEaaCezwVBw++YmxgnM/VxcjJISFgIrF4229GGHvVhT/s
	IDabgLrEjRs/mbsYuThEBN4wSnQuO8MGkmAWyJNo/d/HBGILCwRLnLx1kLWLkYODRUBVoqPf
	FSTMK2AqceRHHwvETHmJ1RsOgM2RENjAJnHw5jeoZZISB1fcYJnAyL2AkWEVo1BmXlluYmaO
	iV5GZV5mhV5yfu4mRmAYLqv9E72D8dOF4EOMAhyMSjy8B/6cTRViTSwrrsw9xCjBwawkwjup
	90yqEG9KYmVValF+fFFpTmrxIUZpDhYlcV6jb+UpQgLpiSWp2ampBalFMFkmDk6pBkaBradn
	6ahe5O42LZ5vGL7ZoUqJ8xZ7eWuxnGKrnkM282SBQ3c1EuMvv622czE7f/qa3uTD5cc4vY5F
	nBctfC7l9yRReoLB5QWByqly5e9bOns5lqtw6clUMa7V1Dp8d3mb/U47sQ/KVg8v3RQ4Ef6V
	uYj5xlG22qaHsz2iv/B2a7/rLn/6XomlOCPRUIu5qDgRAA88nK8/AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsXC5WfdrHvc83yqwcQmWYs569ewWVx6fJXN
	YvrLRhaLpxO2Mlvc7Z/KYnF47klWi8u75rBZ3Fvzn9Vi8rtnjBaXDixgsjjee4DJYl/HAyaL
	jiPfmC22Hv3O7sDnsWbeGkaPln232D0WbCr12LxCy2PTp0nsHneu7WHzODHjN4vH+31X2TwW
	v/jA5LH5dLXH501yAdxRXDYpqTmZZalF+nYJXBkT9h5hKrjHU3Hw4CvGBsb5XF2MnBwSAiYS
	qy78YQex2QTUJW7c+MncxcjFISLwhlGic9kZNpAEs0CeROv/PiYQW1ggWOLkrYOsXYwcHCwC
	qhId/a4gYV4BU4kjP/pYIGbKS6zecIB5AiPHAkaGVYwimXlluYmZOaZ6xdkZlXmZFXrJ+bmb
	GIFBtaz2z8QdjF8uux9iFOBgVOLhPfDnbKoQa2JZcWXuIUYJDmYlEd5JvWdShXhTEiurUovy
	44tKc1KLDzFKc7AoifN6hacmCAmkJ5akZqemFqQWwWSZODilGhgtotVPvXe8OW9DV/vaAqvd
	Zmf3cyYzZjBWd1xvDedvaVt8Infa7L1Nbhs8uQ7ePhgTkDVt3sW2NCkvn4UBkXVZK/Y3ZPn/
	mJPS+uPkpyO8i7ReRtcE9Cm8/Xor5PcN17VnFgd32kr7JpytE1tvyf2j9/iTzZpblnKER+zy
	4z6148zahU4+f3KUWIozEg21mIuKEwGVPcGaJgIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Changes from v2:
	1. Rewrite the comment in code and the commit message becasue it
	   turns out that this patch is not the real fix for the oops
	   descriped. The real fix goes in another patch below:

	   https://lore.kernel.org/lkml/20240216111502.79759-1-byungchul@sk.com/

Changes from v1:
	1. Trim the verbose oops in the commit message. (feedbacked by
	   Phil Auld)
	2. Rewrite a comment in code. (feedbacked by Phil Auld)

--->8---
From 150af2f78e19217a1d03e47e3ee5279684590fb4 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul@sk.com>
Date: Fri, 16 Feb 2024 20:18:10 +0900
Subject: [PATCH v3] sched/numa, mm: do not promote folios to nodes not set N_MEMORY

A numa node might not have its local memory but CPUs. Promoting a folio
to the node's local memory is nonsense. So avoid nodes not set N_MEMORY
from getting promoted.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/sched/fair.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63a2171..7ed9ef3c0134 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1828,6 +1828,13 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 	int dst_nid = cpu_to_node(dst_cpu);
 	int last_cpupid, this_cpupid;
 
+	/*
+	 * A node of dst_nid might not have its local memory. Promoting
+	 * a folio to the node is meaningless.
+	 */
+	if (!node_state(dst_nid, N_MEMORY))
+		return false;
+
 	/*
 	 * The pages in slow memory node should be migrated according
 	 * to hot/cold instead of private/shared.
-- 
2.17.1


