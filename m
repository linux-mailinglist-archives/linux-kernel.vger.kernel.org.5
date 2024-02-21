Return-Path: <linux-kernel+bounces-74400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E420885D385
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41FD1C2134B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE5D3DB8C;
	Wed, 21 Feb 2024 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tbf261B3"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385563D556
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507692; cv=none; b=I45oBCvl+XBPXOHK/Vv9n4xd6GwCOC5OB9fv+I4/4fqPTIl11NUZKweSlETKygE+RECljTXSae7p9aO2NRwm3f6yssGivnFHp0AtFJ77Kx8RzaSb5suIe5c9y2XirOF5x9c9nUKAyqhv2fD3OcsJP6zi1tBr/b+bl+Lv3raiqw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507692; c=relaxed/simple;
	bh=x2riKMYmISimOeooDuvtdgn5hEARkXgRbBvuG4j/oVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K5njrrUZFu41YuUz+xE7cC411/Y/93OgTuPToE9ZWjvWgq9A+pPuRCo19TTc0+AqzbdMkexDWx5b6JMBbv5pLZnB3/8r2S9dfUUsfvkgQqJcG6EUEMWsjSSa92RTnFYmqTp+tMSREalNU5MsX1Sy3E4WZDkq0eqxfpI8tx2H6ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tbf261B3; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708507687; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=m3nqGI/fMVZjL40459w/MnS9DkbLdhc8HEWPtY+H0PM=;
	b=tbf261B3zP1aJ8GoO26ZLScrCldl7dzZMaMeJlr4A0bIl/eqetArzNNTiOsFE+fOf/P1yNqrhbc01ou4qQRZMWJoVnjJ3soxij/rRObHr6LyXu5wk8ViEdZ/Bm1Q1GVHnL3JyQopwO4VLGTofhfHTP+Uxm8md5XHJXiDpx/ZCk0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W0zShrU_1708507686;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W0zShrU_1708507686)
          by smtp.aliyun-inc.com;
          Wed, 21 Feb 2024 17:28:06 +0800
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
Subject: [RFC PATCH 3/3] docs: hugetlbpage.rst: add hugetlb migration description
Date: Wed, 21 Feb 2024 17:27:55 +0800
Message-Id: <75b80937a84bd98211cea0607707bfdee8cb5873.1708507022.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1708507022.git.baolin.wang@linux.alibaba.com>
References: <cover.1708507022.git.baolin.wang@linux.alibaba.com>
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
index e4d4b4a8dc97..68d7bc2165c9 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -376,6 +376,13 @@ Note that the number of overcommit and reserve pages remain global quantities,
 as we don't know until fault time, when the faulting task's mempolicy is
 applied, from which node the huge page allocation will be attempted.
 
+The hugetlb may be migrated between the per-node hugepages pool in the following
+scenarios: memory offline, memory failure, longterm pinning, syscalls(mbind,
+migrate_pages, move_pages), alloc_contig_range() and alloc_contig_pages(). Now
+only memory offline, memory failure and syscalls allow fallback to allocate a
+new hugetlb on a different node if the current node is unable to allocate during
+hugetlb migration, that means these 3 cases can break the per-node hugepages pool.
+
 .. _using_huge_pages:
 
 Using Huge Pages
-- 
2.39.3


