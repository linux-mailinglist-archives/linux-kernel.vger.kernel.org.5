Return-Path: <linux-kernel+bounces-149915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 278438A97D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2C31F22B52
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AB815F311;
	Thu, 18 Apr 2024 10:50:53 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8908315D5D6;
	Thu, 18 Apr 2024 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437453; cv=none; b=QGyxnTToKFR2eeolnE3K32DU9EgL2RwiFyY9B70AcOgZDO8eEzFngFgcpw+bwpvjlh03sgpABVcm1OXH4uhcpYvpOmgUgik/S35zSa4N9WxvWcm20kEw2E4S6e+hLBlIB242gR9AIgULZMd1O6ABV14moqdUOoO3L+eZ7Z7MVi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437453; c=relaxed/simple;
	bh=sFnCyAezPJqAAlu3qDvF7erthkLHTCeXNJjaVGL6Y6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P4KUe+jB7e1iYMhVE6r15LHVDEO38jOujcmbhfaCegVQnZpkyMll3/E0t1l01MQCs8/6LGPL42d7XoqRbjsQFadTr+X0/9B6j5VuEE87unYhMHfrqMP3XnZjLDQ4PoF3CsUW4d2Yhhy1OMBnaxSgYEMXP9hRsbHvDmPL1NmDbG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz7t1713437422tf4erle
X-QQ-Originating-IP: 8Uo1IzsnJjkMtFnQKv4tK4eu5qWHRps1RVeUcu6KYfo=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Apr 2024 18:50:21 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: 0tC8hUyuo8W3jtPfm2nDYNIoEZJeXZ+DSrT8f8H7Vtwa2JQHxfseOnUkiCuXP
	3OWD6gSevSTDh+hTCHBCyO8/fGBcn8DXpsfqUaMxriCcYQ7TvbDFyvKH3HhgT3ybmWXFoIa
	kj2Vx2tqN+yChMwPQve2Ytm9q+cXzdLNGsv1B5KqgGy/yyQIGmgw+2zp0/3BtiFeaYNb2BL
	H+pYf5yVkbOn2T8q35rh7ME+E1gLHAh8eWCfHGPAfq/HV5dgqPbFaWYnm9RASFQ4Q2u96mM
	X5m2x6+FdDeJ8er45CNf2Tmz5xyEc7is8SOH2SCGhZak662gtJrnN8Ocu5ieZfhWacrdMRG
	DWImbQTFgngA48Eiy5J7bda9KhFxDsLJrJBccV+0wt4MVvQGp2I6XhMT6fmAdehtUA46m+X
	ST/dzd5YvJ4=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14906161043048154958
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH 4/5] sparc/pci_msi: Remove on-stack cpumask var
Date: Thu, 18 Apr 2024 18:49:48 +0800
Message-Id: <20240418104949.3606645-5-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240418104949.3606645-1-dawei.li@shingroup.cn>
References: <20240418104949.3606645-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

@cpumask of irq_set_affinity() is read-only and free of change, drop
unneeded cpumask var.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 arch/sparc/kernel/pci_msi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/pci_msi.c b/arch/sparc/kernel/pci_msi.c
index fc7402948b7b..acb2f83a1d5c 100644
--- a/arch/sparc/kernel/pci_msi.c
+++ b/arch/sparc/kernel/pci_msi.c
@@ -287,10 +287,7 @@ static int bringup_one_msi_queue(struct pci_pbm_info *pbm,
 
 	nid = pbm->numa_node;
 	if (nid != -1) {
-		cpumask_t numa_mask;
-
-		cpumask_copy(&numa_mask, cpumask_of_node(nid));
-		irq_set_affinity(irq, &numa_mask);
+		irq_set_affinity(irq, cpumask_of_node(nid));
 	}
 	err = request_irq(irq, sparc64_msiq_interrupt, 0,
 			  "MSIQ",
-- 
2.27.0


