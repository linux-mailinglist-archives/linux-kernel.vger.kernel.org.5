Return-Path: <linux-kernel+bounces-113168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B7A888200
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2E81C222A2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45049174ED0;
	Sun, 24 Mar 2024 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnBllwjm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8316817497A;
	Sun, 24 Mar 2024 22:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319970; cv=none; b=H6MzThCucqNWtAxpE1/4Emt1nIS+wcBljGBQM7bM4x79pJGv96WLaZJhLblnoqQfSZ2zLg6JQQ0HiLW1oI+JlS+4arN1J58B6g8f8SAfGcKKYSjxe3ZgwbH0F36vgAGRK1/1VSapx9/VQnk79oCncaq8Zi0kxZscMpfLzWQl4Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319970; c=relaxed/simple;
	bh=FwRUlJdf2CwufbTEJaPahXujuWP54HzSK35Xuao6dhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9kuf4dtlWrMcNB7lkvBRRnP/d3+mTPMeAmI1XtK3O5C+JmYPlrrIDNbi5BSuWhZrIJBkjyoJUFYAhAct9Yn+kBeczLV/u7/30eBEXKt/c6fRUblSasumJQiW7h39jze3scaaqaC+E1uKpZFv8Fe7Pm2znp1eeAKr6gZQwDA0AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnBllwjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895A3C433F1;
	Sun, 24 Mar 2024 22:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319970;
	bh=FwRUlJdf2CwufbTEJaPahXujuWP54HzSK35Xuao6dhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WnBllwjm8WtwWO6qyp+X7LRsAT/zecqsIuP+1yitih5coTmtljeAKxyPXPJQzRMIN
	 xsHIXsdHIh4W5boYiGZeeZGXg4LdiEPonJD4BzewNdDDD9LfMBOaMwfrbFVJXCGMau
	 XuEK1RcR3rCmFjVZNYRR+Cvw8IYAztui0sOZWNJDxWKZJ8spFjIZHXRIjauWuZIvVN
	 XRDMUtD4+kL9Oyl+WMFAzuow4fp0EFqpGnOId/jiJXPyL772OhVJOryj7+lQUSnhZG
	 8YjQ5IbABXVAboeUtEI/Wxh5RkQhNDfE70W8fZTMtzVnvkJ6+7vCvVR3kGvc5dEglZ
	 FccyYNY6O7DRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 277/715] iommu/arm-smmu-v3: Check that the RID domain is S1 in SVA
Date: Sun, 24 Mar 2024 18:27:36 -0400
Message-ID: <20240324223455.1342824-278-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 4a27fbdb2d844..2610e82c0ecd0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -364,7 +364,13 @@ static int __arm_smmu_sva_bind(struct device *dev, ioasid_t pasid,
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
 		return -ENODEV;
-- 
2.43.0


