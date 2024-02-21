Return-Path: <linux-kernel+bounces-74402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB67C85D389
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF401F237A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EF13EA68;
	Wed, 21 Feb 2024 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iP6DBYRf"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68D23D995
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507694; cv=none; b=p8bXm41CZrGg8wSdxWBL4y5679y/Y3Lvd8bQUhhZSkrShntnOW7jg8dyqAe95mO84TqsbdXRVca860KVNa1lERxAXn8B4IgS8qxwe87GvjXOOBWInHWli8cS5IYXL1UiNILkhoMVaCiGtr6LSUXtFZFjLKTCIR87TBNfiPwFrfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507694; c=relaxed/simple;
	bh=xGOSTdXDYUi+SjIBZYAGjzSV7++NmcYSboolnpaIb6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NCnWG7Vh395Xx/iMER4M3MUMFz0/Jp7l+tF+uSbB+CM0B1RtgxwW6v5Wgl7eEYWKPbVpVnEinSeZ531DFg7Hi/UYlIcmQ9YsGBbnd+zXPN2YDFnB7X5TinfpvZMcPNkXcR4/ENf96TuIYFQgdVwXmzXz7vS1/XjL7L0gIRNxTkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iP6DBYRf; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708507684; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=R/jDsBhNjN3BwyEA1BOhHb8+crI49fZWr9saM6bffNI=;
	b=iP6DBYRfHSg1l+PmxlHF3+SSdn3JZBG+7VApp8GGkLd1rj2W9PpGpZZrT2E9AhOzrKbPUq/4iDxtaW+h7qJeuOMGxqcu/6uAun7vUij+8QPnK4lRJydUkdgHzr3lOhndL7lJgWa0/WFU4evMlGtWLc4mm6H2V0we3MWovOTF8Og=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W0zUu5Y_1708507682;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W0zUu5Y_1708507682)
          by smtp.aliyun-inc.com;
          Wed, 21 Feb 2024 17:28:03 +0800
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
Subject: [RFC PATCH 0/3] make the hugetlb migration strategy consistent
Date: Wed, 21 Feb 2024 17:27:52 +0800
Message-Id: <cover.1708507022.git.baolin.wang@linux.alibaba.com>
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

[1] https://lore.kernel.org/all/6f26ce22d2fcd523418a085f2c588fe0776d46e7.1706794035.git.baolin.wang@linux.alibaba.com/

Baolin Wang (3):
  mm: record the migration reason for struct migration_target_control
  mm: hugetlb: make the hugetlb migration strategy consistent
  docs: hugetlbpage.rst: add hugetlb migration description

 Documentation/admin-guide/mm/hugetlbpage.rst |  7 +++++
 include/linux/hugetlb.h                      |  4 +--
 mm/gup.c                                     |  1 +
 mm/hugetlb.c                                 | 28 ++++++++++++++++++--
 mm/internal.h                                |  1 +
 mm/memory-failure.c                          |  1 +
 mm/memory_hotplug.c                          |  1 +
 mm/mempolicy.c                               |  3 ++-
 mm/migrate.c                                 |  3 ++-
 mm/page_alloc.c                              |  1 +
 mm/vmscan.c                                  |  3 ++-
 11 files changed, 46 insertions(+), 7 deletions(-)

-- 
2.39.3


