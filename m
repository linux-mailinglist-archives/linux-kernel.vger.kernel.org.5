Return-Path: <linux-kernel+bounces-124371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E11689165A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1CE3B2285F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1CE50A72;
	Fri, 29 Mar 2024 09:52:22 +0000 (UTC)
Received: from mx2.usergate.com (mx2.usergate.com [46.229.79.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF01B4F20C;
	Fri, 29 Mar 2024 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.229.79.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705942; cv=none; b=atq8sGCdxI1BWMLgRo1Uf80rzVKZR/T3poP8GFHDVPsawIg7ElbA+HN/sAkdRdNJJ8IA+G73OlSHtXk7q6OeelrsXHz4iC6qKIf6+1+M0MiA3KnwPA8FHah+ZXtTJu+Le4NSec51S6THsSMQBURGhXrc7XeVvuEVlsrzw6FCpPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705942; c=relaxed/simple;
	bh=nbsv75XQCiH2AvOR06HHv/kG/5nDx6VaDVmXGKqDVt4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HxtqKKxe1VSCQiCi+ONkzbH1zzg3O+r/QvdS43awbuACsLkbemsB+spO3pC9DjHFtDUsccOZxzU1XRBtq/Vnpk4I1gT9UA+pXPVBeeZPxpAxHvfW+lKx6EKcxEmDDklH20iYMdXOJwA4Q1kM0y8f1xRtZzX35ld758IuIqYmbaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usergate.com; spf=pass smtp.mailfrom=usergate.com; arc=none smtp.client-ip=46.229.79.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usergate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usergate.com
Received: from mail.usergate.com[192.168.90.36] by mx2.usergate.com with ESMTP id
	 BC4409493A1E471D95606304D683D4D4; Fri, 29 Mar 2024 16:51:58 +0700
From: Aleksandr Aprelkov <aaprelkov@usergate.com>
To: Will Deacon <will@kernel.org>
CC: Aleksandr Aprelkov <aaprelkov@usergate.com>,Robin Murphy <robin.murphy@arm.com>,Joerg Roedel <joro@8bytes.org>,Jason Gunthorpe <jgg@ziepe.ca>,Nicolin Chen <nicolinc@nvidia.com>,Michael Shavit <mshavit@google.com>,Lu Baolu <baolu.lu@linux.intel.com>,Marc Zyngier <maz@kernel.org>,<linux-arm-kernel@lists.infradead.org>,<iommu@lists.linux.dev>,<linux-kernel@vger.kernel.org>
Subject: [PATCH] iommu/arm-smmu-v3: Free MSIs in case of ENOMEM
Date: Fri, 29 Mar 2024 16:51:33 +0700
Message-ID: <20240329095133.576605-1-aaprelkov@usergate.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ESLSRV-EXCH-01.esafeline.com (192.168.90.36) To
 nsk02-mbx01.esafeline.com (10.10.1.35)
X-Message-Id: E2443D9AE363436E83C57DC670C39DEC
X-MailFileId: BB9C20720B464D518296C717F3B14E88

If devm_add_action() returns ENOMEM, then MSIs allocated but
not freed on teardown.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 166bdbd23161 ("iommu/arm-smmu: Add support for MSI on SMMUv3")
Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 41f93c3ab160..136d0cdce6a9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3402,7 +3402,12 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
 
 	/* Add callback to free MSIs on teardown */
-	devm_add_action(dev, arm_smmu_free_msis, dev);
+	ret = devm_add_action(dev, arm_smmu_free_msis, dev);
+	if (ret) {
+		dev_warn(dev, "failed to add free MSIs callback - falling back to wired irqs\n");
+		arm_smmu_free_msis(dev);
+		return;
+	}
 }
 
 static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
-- 
2.34.1


