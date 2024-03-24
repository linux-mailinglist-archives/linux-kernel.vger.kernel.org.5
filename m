Return-Path: <linux-kernel+bounces-113756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7389888E76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF6F1F31A31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3B914B067;
	Sun, 24 Mar 2024 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqmmXN+h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30E81E065D;
	Sun, 24 Mar 2024 22:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320763; cv=none; b=aUjn1F9bWkJjmBG+UoGdZLpw4Q4BxTv205KBXL44Fz6SF4wxBUrsqz5HSNQo9ek2BLRwJbWUuHYE0JDCmV5s9H5uz3FcSG9I8E8rVm9FLmvGFpqGVoU/DJMhvDu9KRVm/ksclWUU92ug+kqN2sE8Aukyxl20KBZ3a6TGMfpdKnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320763; c=relaxed/simple;
	bh=FwRUlJdf2CwufbTEJaPahXujuWP54HzSK35Xuao6dhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtTgyt10MTobZiDyLSlfXlL1Ge0EKSHHG6nazyV2JTYOkS04d557JyOZhyDUQMRyFvf93RNHE5JyL+W+uKVaAvhq/n2Ep2iGth3zF1A2ZYR7+lVfjcHJ86oTLDz8dEbOziCLrtmWPmlvXFWjd4otu5QmG1ubl8IfysT8HH1ZlqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqmmXN+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E14C433F1;
	Sun, 24 Mar 2024 22:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320762;
	bh=FwRUlJdf2CwufbTEJaPahXujuWP54HzSK35Xuao6dhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NqmmXN+hCf66Tpu45HAUgWsve5ZD6dEsoIJha0Qxyl1NeB3UdWa1j35sytKtRvhAG
	 fY2uu2O/uq1XHorh4rWfsu3vKTBm018XmP/++fDidevrCJR/KPi/s/Soy+g8m4EJiS
	 cQ5QsJ9WaZewex33c2ZoY9OphSNZ39sKvzkLzmLnYPpurtpJYfbv9xVpuD+HlxBeaF
	 7dfTyvbM6eJk7NuoyUpUHptOPOd9Q+0AEVYYdHfa+4LUUxO9Klx/wdKrIWgWHdHId5
	 x1DFq440VJKrQMFdkpSE6gdnPodZFGduF7EliVZM+24Z8rNzHRX2I7VVs84Fgf/bQg
	 b4JaFt4Uk/6BQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 326/713] iommu/arm-smmu-v3: Check that the RID domain is S1 in SVA
Date: Sun, 24 Mar 2024 18:40:52 -0400
Message-ID: <20240324224720.1345309-327-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


