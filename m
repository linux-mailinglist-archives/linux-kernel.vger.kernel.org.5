Return-Path: <linux-kernel+bounces-24044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2FC82B5EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2922865E3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE23A57890;
	Thu, 11 Jan 2024 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="WZVfKSij"
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1541B5788A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id O1iWrSNLt6p30O1iXrV0h9; Thu, 11 Jan 2024 21:32:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705005120;
	bh=O2DYDashidxiDL9JfucZnb4Q1U6o1/c9c4N52fUOZ40=;
	h=From:To:Cc:Subject:Date;
	b=WZVfKSijE3zLkgf6h9UU5hqJimHJ1XnQOS4kF/Ve5HvnDkzSESmXeoKlmwJirdoi1
	 pEiPAS8bQ1ooXJUVzgWMTKwO8oX9/7lk32+kjESqsPjveyy9jdPvAQR6Vk+SqJykZx
	 ZA1Nusw+Keo9MNMfxDSHLolo36WneHMclOjRzW1ixeIWouWCWZe7UtdbyHV1d34zDU
	 dksFZvIFDEAaYENIFPzQGDxkbsbkT9B6sAi0AoQa2hEq2TRU1o6z4N4DukZB01KGjC
	 EgdcDvRc0im1eP8QmbljvFL+TuN4XJu7LHvwyrEHRbFkMlSAj68oUsMs4xF+BkB2+Q
	 pBCv46G2m95xw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 11 Jan 2024 21:32:00 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: imx: Remove usage of the deprecated ida_simple_xx() API
Date: Thu, 11 Jan 2024 21:31:55 +0100
Message-Id: <5807287732785d81b9c3ef9e6a25e4f3bc2e2159.1705005016.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/arm/mach-imx/mmdc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 444a7eaa320c..25893d109190 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -452,7 +452,7 @@ static int mmdc_pmu_init(struct mmdc_pmu *pmu_mmdc,
 		.active_events = 0,
 	};
 
-	pmu_mmdc->id = ida_simple_get(&mmdc_ida, 0, 0, GFP_KERNEL);
+	pmu_mmdc->id = ida_alloc(&mmdc_ida, GFP_KERNEL);
 
 	return pmu_mmdc->id;
 }
@@ -461,7 +461,7 @@ static void imx_mmdc_remove(struct platform_device *pdev)
 {
 	struct mmdc_pmu *pmu_mmdc = platform_get_drvdata(pdev);
 
-	ida_simple_remove(&mmdc_ida, pmu_mmdc->id);
+	ida_free(&mmdc_ida, pmu_mmdc->id);
 	cpuhp_state_remove_instance_nocalls(cpuhp_mmdc_state, &pmu_mmdc->node);
 	perf_pmu_unregister(&pmu_mmdc->pmu);
 	iounmap(pmu_mmdc->mmdc_base);
@@ -529,7 +529,7 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 	cpuhp_state_remove_instance_nocalls(cpuhp_mmdc_state, &pmu_mmdc->node);
 	hrtimer_cancel(&pmu_mmdc->hrtimer);
 pmu_release_id:
-	ida_simple_remove(&mmdc_ida, pmu_mmdc->id);
+	ida_free(&mmdc_ida, pmu_mmdc->id);
 pmu_free:
 	kfree(pmu_mmdc);
 	return ret;
-- 
2.34.1


