Return-Path: <linux-kernel+bounces-124533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D599C891976
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64BEB1F245B1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611F0139D05;
	Fri, 29 Mar 2024 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMLPCsBi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832951487D5;
	Fri, 29 Mar 2024 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715322; cv=none; b=GPkJGlmt8OyC71Aaa9FUESnmvudERJihfxqKMRfI0DJQfIBM9ixQPJJUisAcWoMts18uSf+BzcZP6GvN1ZuIP002wT31uDS8XHiPcEdOCg9jWxOEWgebAaiG61GL7fj9/gzxMh73hTLgmqOPTg0OI4m/8wsYnVAOqRhuz93O6Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715322; c=relaxed/simple;
	bh=Gy/fCpdLTfmFkgTs9RjvmJNa3ujJqwIxDi6ILMKZabo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHQLorVvwscCnlUAdEA8354IPLZzD9aL09989u7mc1B9kolS7u7lJNAQYIdrvmcbrdNADwng+zxXQnN4/FzrVA9M2oVu57NwZls0MEs+G3vw1qhK9hOW/BKrIW4mlWplrardwRTu6WToAVBGbkezDHviNP+62jlVIK91w2GLi0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMLPCsBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB09BC433A6;
	Fri, 29 Mar 2024 12:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715322;
	bh=Gy/fCpdLTfmFkgTs9RjvmJNa3ujJqwIxDi6ILMKZabo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uMLPCsBiIf6Sj2e6aKUMWLPNxVAmQf9uL/B/eAmxZ1GDhrcFIy2PfTnnGcPm1MpKu
	 2NQzMmR7OooFGGf08UfBWSOsK43m8JH3jGXLM/93GQ5w4/vlnzJq3fte/Px1AWzxka
	 EPLW45xXdQHo+LGoRBBJh+0ZZa8schMtHTt0hRt0FGwMMOiYAzervssxKYsInGbPo5
	 PGpwZ2VNYV4Yutr2BE9jAHdJCUOTtPM3laDXFbmBlOgd6kpCQGXpndHhFdQTS+W4rn
	 oWHvrdAV01xX89d2mHlNDI+q/eb7l8MOqJX1x6BKE5cZgecCC/xiYBUYajNVPYf3Mi
	 X2S2envqNeMfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Moritz Fischer <moritzf@google.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	jgg@ziepe.ca,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.8 52/68] iommu/arm-smmu-v3: Hold arm_smmu_asid_lock during all of attach_dev
Date: Fri, 29 Mar 2024 08:25:48 -0400
Message-ID: <20240329122652.3082296-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 9f7c68911579bc15c57d227d021ccd253da2b635 ]

The BTM support wants to be able to change the ASID of any smmu_domain.
When it goes to do this it holds the arm_smmu_asid_lock and iterates over
the target domain's devices list.

During attach of a S1 domain we must ensure that the devices list and
CD are in sync, otherwise we could miss CD updates or a parallel CD update
could push an out of date CD.

This is pretty complicated, and almost works today because
arm_smmu_detach_dev() removes the master from the linked list before
working on the CD entries, preventing parallel update of the CD.

However, it does have an issue where the CD can remain programed while the
domain appears to be unattached. arm_smmu_share_asid() will then not clear
any CD entriess and install its own CD entry with the same ASID
concurrently. This creates a small race window where the IOMMU can see two
ASIDs pointing to different translations.

       CPU0                                   CPU1
arm_smmu_attach_dev()
   arm_smmu_detach_dev()
     spin_lock_irqsave(&smmu_domain->devices_lock, flags);
     list_del(&master->domain_head);
     spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);

				      arm_smmu_mmu_notifier_get()
				       arm_smmu_alloc_shared_cd()
					arm_smmu_share_asid():
                                          // Does nothing due to list_del above
					  arm_smmu_update_ctx_desc_devices()
					  arm_smmu_tlb_inv_asid()
				       arm_smmu_write_ctx_desc()
					 ** Now the ASID is in two CDs
					    with different translation

     arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, NULL);

Solve this by wrapping most of the attach flow in the
arm_smmu_asid_lock. This locks more than strictly needed to prepare for
the next patch which will reorganize the order of the linked list, STE and
CD changes.

Move arm_smmu_detach_dev() till after we have initialized the domain so
the lock can be held for less time.

Reviewed-by: Michael Shavit <mshavit@google.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Moritz Fischer <moritzf@google.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/5-v6-96275f25c39d+2d4-smmuv3_newapi_p1_jgg@nvidia.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 ++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0ffb1cf17e0b2..f3f2e47b6d488 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2398,8 +2398,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return -EBUSY;
 	}
 
-	arm_smmu_detach_dev(master);
-
 	mutex_lock(&smmu_domain->init_mutex);
 
 	if (!smmu_domain->smmu) {
@@ -2414,6 +2412,16 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Prevent arm_smmu_share_asid() from trying to change the ASID
+	 * of either the old or new domain while we are working on it.
+	 * This allows the STE and the smmu_domain->devices list to
+	 * be inconsistent during this routine.
+	 */
+	mutex_lock(&arm_smmu_asid_lock);
+
+	arm_smmu_detach_dev(master);
+
 	master->domain = smmu_domain;
 
 	/*
@@ -2439,13 +2447,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			}
 		}
 
-		/*
-		 * Prevent SVA from concurrently modifying the CD or writing to
-		 * the CD entry
-		 */
-		mutex_lock(&arm_smmu_asid_lock);
 		ret = arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, &smmu_domain->cd);
-		mutex_unlock(&arm_smmu_asid_lock);
 		if (ret) {
 			master->domain = NULL;
 			goto out_list_del;
@@ -2455,13 +2457,15 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	arm_smmu_install_ste_for_dev(master);
 
 	arm_smmu_enable_ats(master);
-	return 0;
+	goto out_unlock;
 
 out_list_del:
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_del(&master->domain_head);
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
+out_unlock:
+	mutex_unlock(&arm_smmu_asid_lock);
 	return ret;
 }
 
-- 
2.43.0


