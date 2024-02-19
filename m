Return-Path: <linux-kernel+bounces-70702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DA1859B54
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5531F2179A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD4AC158;
	Mon, 19 Feb 2024 04:19:40 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D290C2DB
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708316379; cv=none; b=diDrE/VTMNi9ZqDYicVKl8Jcr/Fs+QGMu46mmGcaSbBqC7OIOPQsd96kbFD6G5xqhwKzMZotBuk3MwB9n4JEZTNx6m+bElELt//9ZJG2Imh8IQzQQqOer9DhExbyLKCLe4i23bCaNO18Qejn45VNKePcZFK6bJAY6AETr9K6sWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708316379; c=relaxed/simple;
	bh=SuZdcutDjABnDGb72wlWOMoVWuxKROYe75I7iYPvAXo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=gSNkmYS8lqUhtoVkyDzqZA2lZpytkZ3blT0RdOIMFmo3dYIZkwQSo5qgXRRRhG1PigIXEzmf17cq9klzDaiGYs2y0ydtIyH9vgPnQcXna1SxEolIHop8ttd+Fd25Ro3GB010CBk3IG7xAbsZ7iexc8aQ5Q2ptS9XFDhIEzK+Flk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-51-65d2d6d3d8fa
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
Subject: [PATCH v4] sched/numa, mm: do not try to migrate memory to memoryless nodes
Date: Mon, 19 Feb 2024 13:19:20 +0900
Message-Id: <20240219041920.1183-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsXC9ZZnke7la5dSDa59E7aYs34Nm8Wlx1fZ
	LKa/bGSxeDphK7PF3f6pLBaXd81hs7i35j+rxeR3zxgtLh1YwGRxvPcAk8W+jgdMFh1HvjFb
	bD36nd2B12PNvDWMHi37brF7LNhU6rF5hZbHpk+T2D3uXNvD5nFixm8Wj/f7rrJ5bD5d7fF5
	k1wAVxSXTUpqTmZZapG+XQJXxsbns1gKNvBWnJz4mamB8RlXFyMnh4SAicSSjX+YYOwfS46z
	g9hsAuoSN278ZO5i5OIQEXjDKNG57AwbSIJZIE+i9X8fWIOwQIjE0oYpLCA2i4CqxObDvWA1
	vECDHt88wwwxVF5i9YYDYIMkBFawSaw/tZYRIiEpcXDFDZYJjNwLGBlWMQpl5pXlJmbmmOhl
	VOZlVugl5+duYgQG4rLaP9E7GD9dCD7EKMDBqMTDmyFyKVWINbGsuDL3EKMEB7OSCK9704VU
	Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYyN8W8+PtA3
	dJ34wfiSmBhLs9oGmRr9XuOHJ30PfXpQ2MHqPr+8zOR57j7jm8aTZk53OuE2gSng08G9GpI2
	Nyc5iawyy83ufO5tqXRs1fk4zSlR52P+BUs2rb30uFG399/ntb+znsbtP2kYc2u9msd9oU0H
	34q8vpzjfL+r43U179VCaxYtsR4lluKMREMt5qLiRACJFy+iQAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCLMWRmVeSWpSXmKPExsXC5WfdrHv52qVUg8nfmSzmrF/DZnHp8VU2
	i+kvG1ksnk7Yymxxt38qi8XhuSdZLS7vmsNmcW/Nf1aLye+eMVpcOrCAyeJ47wEmi30dD5gs
	Oo58Y7bYevQ7uwOfx5p5axg9WvbdYvdYsKnUY/MKLY9Nnyaxe9y5tofN48SM3ywe7/ddZfNY
	/OIDk8fm09UenzfJBXBHcdmkpOZklqUW6dslcGVsfD6LpWADb8XJiZ+ZGhifcXUxcnJICJhI
	/FhynB3EZhNQl7hx4ydzFyMXh4jAG0aJzmVn2EASzAJ5Eq3/+5hAbGGBEImlDVNYQGwWAVWJ
	zYd7wWp4gQY9vnmGGWKovMTqDQeYJzByLGBkWMUokplXlpuYmWOqV5ydUZmXWaGXnJ+7iREY
	Vstq/0zcwfjlsvshRgEORiUe3gyRS6lCrIllxZW5hxglOJiVRHjdmy6kCvGmJFZWpRblxxeV
	5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKAX1ooH//0o3/OT42DI85mRJMFCN/
	Kr28E7rpUw+v83wOH/1vL94vdFFMnlF7a2fLJbZ0zoj7p95mlj8zLC53+s3xU93mfXzsJy3l
	HQX3ZXRTjoVMkxF1Zj52KyMpYPeXje7B8/5rHJ6+j2dezqsekTLzlCKWigzDE03+Jk2mbptm
	/BLSEGw6o8RSnJFoqMVcVJwIAClsoz0nAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Changes from v3:
	1. Rewrite the comment in code and the commit message to make it
	   more clear. (feedbacked by Oscar Salvador)
	2. Add "Reviewed-by: Oscar Salvador <osalvador@suse.de>"

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
From 98f5d472c08e3ed5b9b6543290d392a2e50fcf3c Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul@sk.com>
Date: Mon, 19 Feb 2024 13:10:47 +0900
Subject: [PATCH v4] sched/numa, mm: do not try to migrate memory to memoryless nodes

Memoryless nodes do not have any memory to migrate to, so stop trying
it.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 kernel/sched/fair.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63a2171..3e3b44ae72d1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1828,6 +1828,12 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 	int dst_nid = cpu_to_node(dst_cpu);
 	int last_cpupid, this_cpupid;
 
+	/*
+	 * Cannot migrate to memoryless nodes.
+	 */
+	if (!node_state(dst_nid, N_MEMORY))
+		return false;
+
 	/*
 	 * The pages in slow memory node should be migrated according
 	 * to hot/cold instead of private/shared.
-- 
2.17.1


