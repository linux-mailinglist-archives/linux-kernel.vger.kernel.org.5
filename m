Return-Path: <linux-kernel+bounces-83353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DD7869469
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E2C293456
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADD514535A;
	Tue, 27 Feb 2024 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jzWotuxS"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8599614533F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041962; cv=none; b=oLDgHFT0m+LbzAZ7sq7875wtHIeZuvM4OTtU6tE/W5KBRXiFjrOxkS6tSbtwb+zAlisgw6JKiPCvtgJ0P23mGu1+kIT8OvwspcP01GcAJe15gvHUiycN0ky3wYnIDy/d/wwCzkmUwlJ9w7RCM6BMl6Vd4wjzRT+36AYglxi3y/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041962; c=relaxed/simple;
	bh=ol6nZIle/gqZ34O9IH4KNTI6HGrZN9jTR3PGGNdqnkI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bns1XgRqr+Hqqi3QuUFQfTc9D0qZ4d/OQ44pwegfeaT2V64rEXNbRUvekJTZOQCdY2jsoxAopBmkKOJdim0MMp1YapKPRHgQU8hOuzjtKDx0M0gYsg1rz8f/asagWWOyVPuNd4Xf+qHPNaccB6VM3Xzw2C31wr80GIQr8ePjAWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jzWotuxS; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709041955; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=rl4Xu+8sGh9GZeUqgSZds1fp/asJZH2dvkyuvxgK4lE=;
	b=jzWotuxSQu2Ga+ORiRtwE2Ym9nfW0mECQ3EqjrJB6wfoyDyqs9dVzR4S/bQJard/ZCFZyJJxC/0db/WSQQzB6z+sIIPt6W/EEOe89FBDYyxpyrppBS4QjtAudWGhB5ppl9M9Yf5jNKwGIa4VylMBIfx4c7QGrg53b9o6spTyfZQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W1N-RDq_1709041953;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W1N-RDq_1709041953)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 21:52:34 +0800
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
Subject: [PATCH 0/3] make the hugetlb migration strategy consistent
Date: Tue, 27 Feb 2024 21:52:24 +0800
Message-Id: <cover.1709041586.git.baolin.wang@linux.alibaba.com>
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

Changes from RFC:
 - Move the gfp modification into alloc_migrate_hugetlb_folio().
 - Add more comments.

Baolin Wang (3):
  mm: record the migration reason for struct migration_target_control
  mm: hugetlb: make the hugetlb migration strategy consistent
  docs: hugetlbpage.rst: add hugetlb migration description

 Documentation/admin-guide/mm/hugetlbpage.rst |  7 ++++
 include/linux/hugetlb.h                      |  4 +-
 mm/gup.c                                     |  1 +
 mm/hugetlb.c                                 | 39 ++++++++++++++++++--
 mm/internal.h                                |  1 +
 mm/memory-failure.c                          |  1 +
 mm/memory_hotplug.c                          |  1 +
 mm/mempolicy.c                               |  3 +-
 mm/migrate.c                                 |  3 +-
 mm/page_alloc.c                              |  1 +
 mm/vmscan.c                                  |  3 +-
 11 files changed, 55 insertions(+), 9 deletions(-)

-- 
2.39.3


