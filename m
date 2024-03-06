Return-Path: <linux-kernel+bounces-93716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 504AF8733B8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058DC288C8C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4731B26E;
	Wed,  6 Mar 2024 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lcuPfCUS"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B2E5D47B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720020; cv=none; b=rVSkitqoGOjjWLE2bhGPzIznf0v4NHFmfoAOroH1BKqPmxnPa0S/1y2vnCupFuDJMZ99i30guDryK5dXSBOP7y1rzBdIB59IAF3Zla52jesujPs5aL8Viy3XwmdXHEwEHKocO4MF2UaVsNfKFL8YgL7Takmg1WwAfGkeyxHiH50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720020; c=relaxed/simple;
	bh=NXf7v8WQEC4MmnAE546WdDN9vTZ4XuEShSdN6L2dGPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hxvjEO0RJCtidmqIpiSgJj2/Z3Y6p7zGPnzTupF0BMvRd+L8SZtsQkL7PAwmfQ/8JQ9d49EUl/em2E5lWWnPQeSPXErIRc+/Pym4qGDS3OxQDsdo/H2mR9BKiUN0K/76fKM/g3VDAEpe800UFBEcUY++90TVbC4sI+dsqwqlGwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lcuPfCUS; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709720015; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=DQeaIWIzG4UFGq8YriB6Tvi2hZtfn1LOrLV4H0r7cXo=;
	b=lcuPfCUS4TACKM9cBdiiolmQbjaodHYCnh8WShj9wR5mGl0eSYwG5DrndToEimzvANykpLo5yG76UtAa8bfjQUPTuZni9886bHmabSAFceOWPGDqjsHUXqNGs4O0Uk3s2mi5XPcT0e/v91E35Y2pXgNaiReQNs/Q6XxUbEEc7Bk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W1xEj1F_1709720014;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W1xEj1F_1709720014)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 18:13:35 +0800
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
Subject: [PATCH v2 0/3] make the hugetlb migration strategy consistent
Date: Wed,  6 Mar 2024 18:13:25 +0800
Message-Id: <cover.1709719720.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

As discussed in previous thread [1], there is an inconsistency when handling
hugetlb migration. When handling the migration of freed hugetlb, it prevents
fallback to other NUMA nodes in alloc_and_dissolve_hugetlb_folio(). However,
when dealing with in-use hugetlb, it allows fallback to other NUMA nodes in
alloc_hugetlb_folio_nodemask(), which can break the per-node hugetlb pool
and might result in unexpected failures when node bound workloads doesn't get
what is asssumed available.

This patch set tries to make the hugetlb migration strategy more clear
and consistent. Please find details in each patch.

[1]
https://lore.kernel.org/all/6f26ce22d2fcd523418a085f2c588fe0776d46e7.1706794035.git.baolin.wang@linux.alibaba.com/

Changes from v1:
 - Add reviewed tag from Oscar.
 - Move the gfp_mask modification into a new helper called by
   alloc_migration_target().

Changes from RFC:
 - Move the gfp modification into alloc_migrate_hugetlb_folio().
 - Add more comments.

Baolin Wang (3):
  mm: record the migration reason for struct migration_target_control
  mm: hugetlb: make the hugetlb migration strategy consistent
  docs: hugetlbpage.rst: add hugetlb migration description

 Documentation/admin-guide/mm/hugetlbpage.rst |  7 ++++
 include/linux/hugetlb.h                      | 35 ++++++++++++++++++--
 mm/gup.c                                     |  1 +
 mm/hugetlb.c                                 | 14 ++++++--
 mm/internal.h                                |  1 +
 mm/memory-failure.c                          |  1 +
 mm/memory_hotplug.c                          |  1 +
 mm/mempolicy.c                               |  4 ++-
 mm/migrate.c                                 |  4 ++-
 mm/page_alloc.c                              |  1 +
 mm/vmscan.c                                  |  3 +-
 11 files changed, 65 insertions(+), 7 deletions(-)

-- 
2.39.3


