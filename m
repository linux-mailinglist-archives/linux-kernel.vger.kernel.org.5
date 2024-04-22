Return-Path: <linux-kernel+bounces-152818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C18E58AC4B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 268BCB214F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED834AEE0;
	Mon, 22 Apr 2024 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pXaD6oHa"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDFE482FE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769385; cv=none; b=ldKHOSvSKQKrRV9htfTeC1jEhneVfHjIkXUiC40wRaltq7Aea/fR5wq7D6ynkOdavMJgn/n0v4PbCMIjCs75jAMWAqSW+foj8gTsr9wyF2r6RzgtgXFrJKowhmBRom04mOWCGXP7S+XEy0jPsUlir8J4DEia9udPD3unTTruZfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769385; c=relaxed/simple;
	bh=Igv+soIxm8VlLHoVz15y7f//HTc0E/HeAkBEGILFQM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MrqFeuzW2YVwDeavBicj9DV2jPk3km5vJQh7YvCtTb6CUa89o6AzXKPQQI5vvhBAUmFdOoQDLB2UJoyTEw7Vb0Onon0XKfiMI4reYWSUAnFDFg/J1ACn/viCKTqnkyfqwi4KQtSQYZ5o43pSG9RFqcboLvWNADoMEi2nMu6AqKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pXaD6oHa; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713769377; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=EzoH5/TP5PtYl4wtjV6rpqRZK0tNrBnQaBo2IsOMKmA=;
	b=pXaD6oHafPyNRdOFmU6L6BUWJucQO4gyxKeSQlEFBQlQZYRpt70ysI9JdxKTrbIf1NrstIMNbQUmCm6FEq3FyX32kIzA5wmzgwXdQ+ribbo2YBTUKLOIC3z5etW+54gj7EAwIrd8h55X6QG8UBLFuEh4axh0z/BtMzVCxLzvf+Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W5.T-Xb_1713769374;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5.T-Xb_1713769374)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 15:02:55 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/5] add mTHP support for anonymous share pages
Date: Mon, 22 Apr 2024 15:02:38 +0800
Message-Id: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Anonymous pages have already been supported for multi-size (mTHP) allocation
through commit 19eaf44954df, that can allow THP to be configured through the
sysfs interface located at '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.

However, the anonymous shared pages will ignore the anonymous mTHP rule
configured through the sysfs interface, and can only use the PMD-mapped
THP, that is not reasonable. Many implement anonymous page sharing through
mmap(MAP_SHARED | MAP_ANONYMOUS), especially in database usage scenarios,
therefore, users expect to apply an unified mTHP strategy for anonymous pages,
also including the anonymous shared pages, in order to enjoy the benefits of
mTHP. For example, lower latency than PMD-mapped THP, smaller memory bloat
than PMD-mapped THP, contiguous PTEs on ARM architecture to reduce TLB miss etc.

The primary strategy is that, the use of huge pages for anonymous shared pages
still follows the global control determined by the mount option "huge=" parameter
or the sysfs interface at '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
The utilization of mTHP is allowed only when the global 'huge' switch is enabled.
Subsequently, the mTHP sysfs interface (/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled)
is checked to determine the mTHP size that can be used for large folio allocation
for these anonymous shared pages.

TODO:
 - More testing and provide some performance data.
 - Need more discussion about the large folio allocation strategy for a 'regular
file' operation created by memfd_create(), for example using ftruncate(fd) to specify
the 'file' size, which need to follow the anonymous mTHP rule too?
 - Do not split the large folio when share memory swap out.
 - Can swap in a large folio for share memory.

Baolin Wang (5):
  mm: memory: extend finish_fault() to support large folio
  mm: shmem: add an 'order' parameter for shmem_alloc_hugefolio()
  mm: shmem: add THP validation for PMD-mapped THP related statistics
  mm: shmem: add mTHP support for anonymous share pages
  mm: shmem: add anonymous share mTHP counters

 include/linux/huge_mm.h |   4 +-
 mm/huge_memory.c        |   8 ++-
 mm/memory.c             |  25 +++++++---
 mm/shmem.c              | 107 ++++++++++++++++++++++++++++++----------
 4 files changed, 108 insertions(+), 36 deletions(-)

-- 
2.39.3


