Return-Path: <linux-kernel+bounces-129060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604B589642F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E221C22841
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890AB4AEE3;
	Wed,  3 Apr 2024 05:38:38 +0000 (UTC)
Received: from mx2.usergate.com (mx2.usergate.com [46.229.79.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BD0481B9;
	Wed,  3 Apr 2024 05:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.229.79.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712122718; cv=none; b=Be1zPWR4kOhI3qfGzQP6xWt7QHIpCqQ7roxfpbSKiYw2g6HjKx5MuojOwDXGUKZ3gMDU9q9G/99Whw4vqI37tCSUIH75JGUqdk1TxWH8W0lh0bncNwT0YOR9/7ZMlAk74ZluE5SfrjPPTLVa4Z9gNUJzqvwfHA4taL/wVU6vfww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712122718; c=relaxed/simple;
	bh=CcOvEUgR8chhkIdWxTxpLG3HR9fLkgvm9yVe5mo91c8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B/BeZ285LQKEYvF9W+LTcWiTbL/RZsoykAQ0ngkAXkTQYzAvUgXa8AnPZcJhrjVvpVGB20jbenwTnC35kjAcsvkXfSzreE5h1HXo4pifPlWvnWU1bKNfgIqtP2n+yimkke+BMiObLJSGcXuQzMzRaORqqQPmJutwsvQP2trTcaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usergate.com; spf=pass smtp.mailfrom=usergate.com; arc=none smtp.client-ip=46.229.79.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usergate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usergate.com
Received: from mail.usergate.com[192.168.90.36] by mx2.usergate.com with ESMTP id
	 A452EB77F704403199B0207900608AD4; Wed, 3 Apr 2024 12:38:16 +0700
From: Aleksandr Aprelkov <aaprelkov@usergate.com>
To: Will Deacon <will@kernel.org>
CC: Aleksandr Aprelkov <aaprelkov@usergate.com>,Robin Murphy <robin.murphy@arm.com>,Joerg Roedel <joro@8bytes.org>,Jason Gunthorpe <jgg@ziepe.ca>,Nicolin Chen <nicolinc@nvidia.com>,Michael Shavit <mshavit@google.com>,Lu Baolu <baolu.lu@linux.intel.com>,Marc Zyngier <maz@kernel.org>,<linux-arm-kernel@lists.infradead.org>,<iommu@lists.linux.dev>,<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] iommu/arm-smmu-v3: Free MSIs in case of ENOMEM
Date: Wed, 3 Apr 2024 12:37:59 +0700
Message-ID: <20240403053759.643164-1-aaprelkov@usergate.com>
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
X-Message-Id: 1272D41AA31D440C91BED49E08E93E6E
X-MailFileId: C27D6DCE0D394F88AD178F0EA783DDC3

If devm_add_action() returns ENOMEM, then MSIs allocated but
not freed on teardown.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 166bdbd23161 ("iommu/arm-smmu: Add support for MSI on SMMUv3")
Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>
---
v2: Use appropriate function for registration failure as 
Jonathan Cameron <Jonathan.Cameron@Huawei.com> suggested.

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 41f93c3ab160..8800af041e5f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3402,7 +3402,9 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
 
 	/* Add callback to free MSIs on teardown */
-	devm_add_action(dev, arm_smmu_free_msis, dev);
+	ret = devm_add_action_or_reset(dev, arm_smmu_free_msis, dev);
+	if (ret)
+		dev_warn(dev, "failed to add free MSIs callback - falling back to wired irqs\n");
 }
 
 static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
-- 
2.34.1


