Return-Path: <linux-kernel+bounces-129349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1AF8968E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F441F24DD5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDBB67A15;
	Wed,  3 Apr 2024 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dwX1D1Aw"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C97A44C8C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133565; cv=none; b=KnJvf2GEMi7U6gH0n5jg0YDM+GgA97bT5yr6gQK4JoHudMpTwOdtpMbBH/yoWYylRgEUPftJaE3byKLF+DLD2hzI5IS/UES9LoXi0YRP+w2Jth2b+jCdfIn1icvVk7K4dHW4No0nUPBIBu2WLRrr7znqwpHpdew1j+6jULwV1FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133565; c=relaxed/simple;
	bh=s4zowk5FDHZhrtl6SwdsvDgYGksJJs1ua8krFDh1+cc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MS1VKYHviFg3zad0Nnk8vi8Dd47YVA8TAl08qj3DYnegQaEoiccyoBfg4BqqRlInCtBeDA4qjm7IMP0qFtsOQm/CraXwUo13aJ8OU4g3JKUJ8x4HXgMwHi0krShSfJN3d47AXULStz9kbep74X577Mx7KaLILI83ZP4Sa/dW5AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dwX1D1Aw; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712133560; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vye0y79PlRt04GkvkiqfdvGYaxiubkuCi3SqjHc32s4=;
	b=dwX1D1AwxoYeWXRjD2HJrGzkep2ow8eTo/8sF49sAKSxRkvOUPz9Whv4tbnVVmZwOe7vVRTzAmZd6Gp3YEG5/tIfb72ei2SiJbuLss2Vy2fdz+B+kVnsGYbMnjrRNQcZPnmQH6pF6GT7rh4L5F9gQe3MVqjDVwGnZkgLVBTryNw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W3rA0.M_1712133558;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W3rA0.M_1712133558)
          by smtp.aliyun-inc.com;
          Wed, 03 Apr 2024 16:39:19 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	mgorman@techsingularity.net,
	wangkefeng.wang@huawei.com,
	jhubbard@nvidia.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] support multi-size THP numa balancing
Date: Wed,  3 Apr 2024 16:39:08 +0800
Message-Id: <cover.1712132950.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset tries to support mTHP numa balancing, as a simple solution
to start, the NUMA balancing algorithm for mTHP will follow the THP strategy
as the basic support. Please find details in each patch.

Changes from v2:
 - Add reviewed tag from Huang, Ying.
 - Reuse numa_rebuild_single_mapping() to remove duplicate code per Kefeng Wang.
 - Remove an unnecessary vma_wants_manual_pte_write_upgrad() per Huang, Ying.

Changes from v1:
 - Fix the issue where the end address might exceed the range of the
folio size, suggested by Huang, Ying.
 - Simplify the folio validation.
 - Add pte_modify() before checking pte writable.
 - Update the performance data.

Changes from RFC v2:
 - Follow the THP algorithm per Huang, Ying.

Changes from RFC v1:
 - Add some preformance data per Huang, Ying.
 - Allow mTHP scanning per David Hildenbrand.
 - Avoid sharing mapping for numa balancing to avoid false sharing.
 - Add more commit message.

Baolin Wang (2):
  mm: factor out the numa mapping rebuilding into a new helper
  mm: support multi-size THP numa balancing

 mm/memory.c   | 76 +++++++++++++++++++++++++++++++++++++++++----------
 mm/mprotect.c |  3 +-
 2 files changed, 63 insertions(+), 16 deletions(-)

-- 
2.39.3


