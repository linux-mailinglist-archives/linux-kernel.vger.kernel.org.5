Return-Path: <linux-kernel+bounces-114214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A77888F99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16400B2DCC6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D7325119A;
	Sun, 24 Mar 2024 23:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwhW9kXR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191FA13793C;
	Sun, 24 Mar 2024 23:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321554; cv=none; b=rIRRGhxWrIu1vmzpis6N5JtwmnTgWDHk1hDlcZIUmha3/0VRUPfgwZJxG/M5pGgaJUBBMRX7SW4LsUtmIM3ugTHIGx40HvxbVC0ELPKZMG86RNoMHDN0hSZvnh0L+lIIb8oar0Z5i0lyjW9jMI3VR8yRlA0Z+Lif1W8Wn46YPJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321554; c=relaxed/simple;
	bh=mqDHnKF4JwaqvMbLj6PvJjzjGLsRXI6R6B2MXr+ey/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O25/3o94rHPYzspOv2d0pUG634nDEIVtK2Y0oZUvPH1JCm+F057eH0b05LOUPXJRdyL2+jH5scPFsZedy96prqBiLfZjaqVQf77HQ5HKax2iIBzHJpaS6gXVGyNBaB1F7V9TIqwCl1c0TbuHarv3O4rkzl+s+yAHkJ8p4jiEynY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwhW9kXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297E4C43390;
	Sun, 24 Mar 2024 23:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321553;
	bh=mqDHnKF4JwaqvMbLj6PvJjzjGLsRXI6R6B2MXr+ey/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cwhW9kXR/1oPJfOiqqV3mmtG9j+PjcwFEnEjHbApFsOSKm+m3XPLQzkxfSvhVMnMa
	 FhMS0XWkiJPLaMvFb/MhS/e5Gz8Q63sMBJtsqHRt5OZIt2sncWKbRboME2O6xW6DhC
	 sfGtP/b/Iia6wz3B36TGTadQSe8j910I4VPGKz58nQEGENuDN/oDzd+mOT1s3PFG/g
	 yqmEmgbqXtzBXYj9uGwkT2dmXqEHMf0rApWnlqDSv/s7Dqi34mEoxtWpFwa0QZIxxX
	 tlOp+HTJbaZN+9XAFDv0Qt9DVt8LHZGKtwHgGdapM9/czfR7MvuOkGHH+gNthUpEUE
	 16ORbLg/LioIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 281/638] iommu/arm-smmu-v3: Check that the RID domain is S1 in SVA
Date: Sun, 24 Mar 2024 18:55:18 -0400
Message-ID: <20240324230116.1348576-282-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit ae91f6552c301e5e8569667e9d5440d5f75a90c4 ]

The SVA code only works if the RID domain is a S1 domain and has already
installed the cdtable.

Originally the check for this was in arm_smmu_sva_bind() but when the op
was removed the test didn't get copied over to the new
arm_smmu_sva_set_dev_pasid().

Without the test wrong usage usually will hit a WARN_ON() in
arm_smmu_write_ctx_desc() due to a missing ctx table.

However, the next patches wil change things so that an IDENTITY domain is
not a struct arm_smmu_domain and this will get into memory corruption if
the struct is wrongly casted.

Fail in arm_smmu_sva_set_dev_pasid() if the STE does not have a S1, which
is a proxy for the STE having a pointer to the CD table. Write it in a way
that will be compatible with the next patches.

Fixes: 386fa64fd52b ("arm-smmu-v3/sva: Add SVA domain support")
Reported-by: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Closes: https://lore.kernel.org/linux-iommu/2a828e481416405fb3a4cceb9e075a59@huawei.com/
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/11-v6-96275f25c39d+2d4-smmuv3_newapi_p1_jgg@nvidia.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 8a16cd3ef487c..cc33e8297b8d0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -352,7 +352,13 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	struct arm_smmu_bond *bond;
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_domain *smmu_domain;
+
+	if (!(domain->type & __IOMMU_DOMAIN_PAGING))
+		return -ENODEV;
+	smmu_domain = to_smmu_domain(domain);
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return -ENODEV;
 
 	if (!master || !master->sva_enabled)
 		return ERR_PTR(-ENODEV);
-- 
2.43.0


