Return-Path: <linux-kernel+bounces-83354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A1B86946A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F98E2934B9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57888145B0C;
	Tue, 27 Feb 2024 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i3R9bWJt"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862601420A6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041962; cv=none; b=DROcn0oUVdUzm0cIhDYShct/P36vURNviLqtPqTM7GX8Rq48sfssUTZWWgmiqRVMJHi9zJIs8iXUo3xlyGJRUbl7v7sg56/jpOOoUcLCIxyCpjDNoN8et6dpl2W2QEg+9voR0ZHnwbNXr4GE0LxEHno6hAgdcG4VWHugDN+iXH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041962; c=relaxed/simple;
	bh=MzCC0AE/rUvpEAo4tb5cVZ7cGsewHKgZszzxyYlWgms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mm6ZPQUvEYWEJ7T9IXqE567dVnRCipA6ACoCMHuEqgvT3NPhRb2zP6XLDUetsTUPKjZTElYOwM3qPcCXAg3ZQNrePvxr1RvMmzXDb69CmMd0zlbh02XTkJbtvNSEVNdVkUNQXbYRWxmjfIchXvVrQwm9CP3DFa+MUxYI38fw2BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i3R9bWJt; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709041958; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jQS6ixAjVk0AC8cKYwTBDAm2HkLKEDsUdifzfOmBcs0=;
	b=i3R9bWJt363GKWx5GJRWr6i7VTUoUN3mS7947TEsH0hIcPK9mpi1+rMe+1g2owwUwln/HU+E6tUx4cawEmaXKdIRCNoLh0rkLpUPx8UyCcJaDbTe3bEqJXJkY075nXPZqJzsj3GBiw8iLlmJXH9q9l2GzFLDDFezrn+NrbmgHMs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W1MvL.r_1709041957;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W1MvL.r_1709041957)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 21:52:37 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	linmiaohe@huawei.com,
	naoya.horiguchi@nec.com,
	mhocko@kernel.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] docs: hugetlbpage.rst: add hugetlb migration description
Date: Tue, 27 Feb 2024 21:52:27 +0800
Message-Id: <574e5bfbaa2b6930aad4a64e1c3da25c4ee5c9ee.1709041586.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1709041586.git.baolin.wang@linux.alibaba.com>
References: <cover.1709041586.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some description of the hugetlb migration strategy.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 Documentation/admin-guide/mm/hugetlbpage.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index e4d4b4a8dc97..f34a0d798d5b 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -376,6 +376,13 @@ Note that the number of overcommit and reserve pages remain global quantities,
 as we don't know until fault time, when the faulting task's mempolicy is
 applied, from which node the huge page allocation will be attempted.
 
+The hugetlb may be migrated between the per-node hugepages pool in the following
+scenarios: memory offline, memory failure, longterm pinning, syscalls(mbind,
+migrate_pages and move_pages), alloc_contig_range() and alloc_contig_pages().
+Now only memory offline, memory failure and syscalls allow fallbacking to allocate
+a new hugetlb on a different node if the current node is unable to allocate during
+hugetlb migration, that means these 3 cases can break the per-node hugepages pool.
+
 .. _using_huge_pages:
 
 Using Huge Pages
-- 
2.39.3


