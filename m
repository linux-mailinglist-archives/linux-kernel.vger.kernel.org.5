Return-Path: <linux-kernel+bounces-158212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 449D68B1D09
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4A51C21E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6A880056;
	Thu, 25 Apr 2024 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R7o/Cqyq"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121F937140
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714034974; cv=none; b=lCzr1CbRdkwJCFCGPHjwj0Zw14dJnB2sXNPhhlYg7UFN23jeBjc3mmOq9SF2wnXU5joSokBw/Mf9/wjoye7WRxOu5fYlBa2drK4BzU7Fv9ktdYn3/q5eWrDNnGYGXn0F1u7G27a3BR59b8EaO1JcF2KtrK23ZagdxmfaBq5ssb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714034974; c=relaxed/simple;
	bh=3QwlY60D7vsAS6W9QcOzZVEi4OJXJuv8/E7Z0/U9CTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ceONBhT7bV4QRjeZsb7vmW16DhMOKNq1IErOXXt9ybozXnGJKXpjg93em0548t+Iy2ny0jGWey1XXNESBsr0xkAeFTiWhf/bB8G/pnRDEHDaEXB4wGpaKkxpr5T1S0B/PQNWpkwDqG6BRp8B9PMP6I1HibIqtfkcKB0RFsM6+CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R7o/Cqyq; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714034963; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YDpodzBncW6h6zZsYAqxf1wk2Qcch7Z+PJ009Jm2JVA=;
	b=R7o/Cqyq0lNpSAtBex27/3BBfJQRcJR/2MZ4+iL/LqVH1SQoQxsHyDvNpEgztG3IO1Q5ZDHbbTDqgObulE6/czF3aV/+wzZlKReUdZfRRGrOlZohChI8zoTTdyG22ehDSnOrbnz8Fe0ez3M9/q5a6OlMzjJjsgsxNJzs4PAja+E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=llfl@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W5EoPNW_1714034961;
Received: from localhost(mailfrom:llfl@linux.alibaba.com fp:SMTPD_---0W5EoPNW_1714034961)
          by smtp.aliyun-inc.com;
          Thu, 25 Apr 2024 16:49:22 +0800
From: "Kun(llfl)" <llfl@linux.alibaba.com>
To: Joerg Roedel <joro@8bytes.org>,
	Vasant Hegde <vasant.hegde@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] iommu/amd: Fix memory leak in alloc_pci_segment()
Date: Thu, 25 Apr 2024 16:48:31 +0800
Message-ID: <92ff13341044a39953f0ba116cf7f9881488f8c8.1714034489.git.llfl@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the memory leak issue that occurs when resource allocation fails in
alloc_pci_segment(). The dev_table, alias_table, and rlookup_table were
introduced individually in commits 04230c119930, 99fc4ac3d297,
and eda797a27795, but they all fail to release allocated resources
when other allocations fail.

Fixes: 04230c119930 ("iommu/amd: Introduce per PCI segment device table")
Reported-by: Xuchun Shang <xuchun.shang@linux.alibaba.com>
Signed-off-by: Kun(llfl) <llfl@linux.alibaba.com>
---
 drivers/iommu/amd/init.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ac6754a85f35..4ce567f39473 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1642,13 +1642,22 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
 	if (alloc_dev_table(pci_seg))
-		return NULL;
+		goto alloc_dev_fail;
 	if (alloc_alias_table(pci_seg))
-		return NULL;
+		goto alloc_alias_fail;
 	if (alloc_rlookup_table(pci_seg))
-		return NULL;
+		goto alloc_rlookup_fail;
 
 	return pci_seg;
+
+alloc_rlookup_fail:
+	free_rlookup_table(pci_seg);
+alloc_alias_fail:
+	free_alias_table(pci_seg);
+alloc_dev_fail:
+	free_dev_table(pci_seg);
+	kfree(pci_seg);
+	return NULL;
 }
 
 static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id,
-- 
2.43.0


