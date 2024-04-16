Return-Path: <linux-kernel+bounces-146842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC678A6BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8BE81F2287B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90C612BF2E;
	Tue, 16 Apr 2024 13:00:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEEF129A7C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272456; cv=none; b=FBRTBF+s7hJrdNyrKY2lyqsZHlSvpEA1+FfnJrCAQvaaeOoRCf5TwCqwT6CLK+OmzsPQNmFVvMlRglg2gkQ8zyjD8OjXS4LPMXLMGOns2O5hU2PJcFcjcrKuZGTkMtGA9m8GlTtiF/eK3vUWqdPJED7BfbVlx+4obK0Wyu/BGK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272456; c=relaxed/simple;
	bh=NkGV98SReVJjvmjh1PYxOXJR9XBB7H++66yf+9P/yFM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iTeuPQuQVoNpz6KQOrDV+FTSB5+7u0Yfa8driRKUiDA0dveA1jcdvrLad6772Ei/abQrCScSQfIaiP6SKbRlTtBnt+GYLiU3vJq9XbiN1bxHwmh4oTHberI7dU5FHYxJcrE4lwyUG3iEuQUlYyDR+yT8/e6N/LITpptQAISmKnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E43E339;
	Tue, 16 Apr 2024 06:01:19 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D217E3F738;
	Tue, 16 Apr 2024 06:00:49 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: ewagner12@gmail.com,
	suravee.suthikulpanit@amd.com,
	vashegde@amd.com,
	jgg@ziepe.ca,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: [PATCH] iommu: Fix def_domain_type interaction with untrusted devices
Date: Tue, 16 Apr 2024 14:00:43 +0100
Message-Id: <fa14583e94cbf540b60a6be94b41bb24d0037e75.1713272443.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, an untrusted device forcing IOMMU_DOMAIN_DMA always took
precedence over whatever a driver's def_domain_type may have wanted to
say. This was intentionally handled in core code since 3 years prior,
to avoid drivers poking at the details of what is essentially a policy
between the PCI core and the IOMMU core. Now, though, we go to the
length of evaluating both constraints to check for any conflict, and if
so throw our toys out of the pram and refuse to handle the device at
all. Regardless of any intent, in practice this leaves the device, and
potentially the rest of its group or even the whole IOMMU, in a largely
undetermined state, which at worst may render the whole system unusable.
Unfortunately it turns out that this is a realistic situation to run
into by connecting a PASID-capable device (e.g. a GPU) to an AMD-based
laptop via a Thunderbolt expansion box, since the AMD IOMMU driver needs
an identity default domain for PASIDs to be usable, and thus sets a
def_domain_type override based on PASID capability.

In general, restoring the old behaviour of forcing translation will not
make that device's operation any more broken than leaving it potentially
blocked or subject to the rest of a group's translations would, nor will
it be any less safe than leaving it potentially bypassed or subject to
the rest of a group's translations would, so do that, and let eGPUs work
again.

Reported-by: Eric Wagner <ewagner12@gmail.com>
Link: https://lore.kernel.org/linux-iommu/CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com
Fixes: 59ddce4418da ("iommu: Reorganize iommu_get_default_domain_type() to respect def_domain_type()")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 996e79dc582d..90dbea14d4d6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1772,9 +1772,8 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 		if (driver_type && driver_type != IOMMU_DOMAIN_DMA) {
 			dev_err_ratelimited(
 				untrusted,
-				"Device is not trusted, but driver is overriding group %u to %s, refusing to probe.\n",
+				"IOMMU_DOMAIN_DMA for untrusted device overrides driver request of %s for group %u, expect issues...\n",
 				group->id, iommu_domain_type_str(driver_type));
-			return -1;
 		}
 		driver_type = IOMMU_DOMAIN_DMA;
 	}
-- 
2.39.2.101.g768bb238c484.dirty


