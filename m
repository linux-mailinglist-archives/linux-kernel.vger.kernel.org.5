Return-Path: <linux-kernel+bounces-90182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 840F786FB70
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA2E2820A5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5999C1755E;
	Mon,  4 Mar 2024 08:15:25 +0000 (UTC)
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A3116436
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540124; cv=none; b=vAI+IP/XDWHaMytzWMhe757uRQiUo65Kuv3hh2s4qiTXoYEqx4tFRkYuyNjj8GmIE8MXEPuj5DcR8vJai2zRGoMcxJEnTqnbGX9hAHa3bw6RJJQdKH/K52IqXKcy4v5o0d+KzJYA4QjKDmCtFEjC6qpcN8ZSW3uiAH2OCPMz21M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540124; c=relaxed/simple;
	bh=VJWSqHQPMivBeqfzMOvO9PGJPKuYFI58V0eb5OjVzjo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jdABDJgPhK1zm/arESnPx18iGthnh0KpLLZDsTXTsYKmSUgdO42mIZto24+jslaUgKnhOwIcMR0KmpIsh8u1ZEiIiE7LqHcJ3TN6H21tK8HVVA81CEJNE1ZtihN36CHbiWRWHhFiZZkx9oR1doqNahegfl1Jl8AfF6tC+RnzJuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1709540111-086e2316ee06760001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id JjMqnPvHCH8Gl0M9 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 04 Mar 2024 16:15:11 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Mar
 2024 16:15:10 +0800
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Mar
 2024 16:15:08 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <TonyWWang-oc@zhaoxin.com>,
	<YeeLi@zhaoxin.com>, <LeoLiu@zhaoxin.com>, leoliu-oc <leoliu-oc@zhaoxin.com>
Subject: [PATCH] iommu/dma: Fix not fully traversing iova reservations issue
Date: Mon, 4 Mar 2024 16:15:07 +0800
X-ASG-Orig-Subj: [PATCH] iommu/dma: Fix not fully traversing iova reservations issue
Message-ID: <20240304081507.63221-1-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1709540111
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1537
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.121644
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: leoliu-oc <leoliu-oc@zhaoxin.com>

For multiple devices in the same iommu group, sorted later device (based
on Bus:Dev.Func) have the RMRR.

Sorted earlier device (without RMRR) initialized the iova domain causing
the sorted later device goto done_unlock.

Then, the sorted later device (with RMRR) cannot execute the
iova_reserve_iommu_regions to reserve the RMRR in the group's iova domain,
and other devices (in the same group) alloc iova in RMRR are permitted.

DMA iova addresses conflict with RMRR in this case.

Goto iova_reserve_iommu_regions could avoid the problem (make sure all
devices of the same group execute reserve iova)

Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
---
 drivers/iommu/dma-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 50ccc4f1ef81..2b6c6bf4bccf 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -709,7 +709,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 		}
 
 		ret = 0;
-		goto done_unlock;
+		goto iova_reserve;
 	}
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
@@ -724,6 +724,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	    (!device_iommu_capable(dev, IOMMU_CAP_DEFERRED_FLUSH) || iommu_dma_init_fq(domain)))
 		domain->type = IOMMU_DOMAIN_DMA;
 
+iova_reserve:
 	ret = iova_reserve_iommu_regions(dev, domain);
 
 done_unlock:
-- 
2.34.1


