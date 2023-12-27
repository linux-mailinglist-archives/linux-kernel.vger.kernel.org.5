Return-Path: <linux-kernel+bounces-12075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A11481EFAC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFEDB1F21D64
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84FD45958;
	Wed, 27 Dec 2023 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="mo8kuyQN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F4145945;
	Wed, 27 Dec 2023 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 9B3B4440F44;
	Wed, 27 Dec 2023 17:02:43 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1703689363;
	bh=vHknldfNxE6H031gNGXJeZaZPVKmHSiQjt/n9eWWmvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mo8kuyQN+AxfYfCNDNSuV7Xg9+Hh8qX3c8Ccb7hNdP1yl4uRh6Ays7AwF/oL0Wlnb
	 sFFQUfKuwK9waKPQYMFGGyU5MOuL49rj8n0iThLx3uWD7bWmfiY7fkOgTyd2ry9q4H
	 I2X6UQrFkZRkBtIO0Av1+6Bnpt1FuX136J2T/zU9e6NiwGPO9N+Ar02+IiMjckBYDP
	 lNDV/T3N3w7UXhPiHIP8UeaCfy7R6mNBgTQhndtuoWeld/Ku/vr+H2kcfwXKmge28Y
	 IUgg/NrAtre8xqij2GLQkalGCiD7vum2qsElzd84bvK8CE1IF3l1wdjA6CCLRhG7We
	 RyPND9l8Ga1bw==
From: Baruch Siach <baruch@tkos.co.il>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Baruch Siach <baruch@tkos.co.il>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>
Subject: [PATCH RFC 2/4] of: unittest: add test for of_dma_get_cpu_limits() 'min' param
Date: Wed, 27 Dec 2023 17:04:26 +0200
Message-ID: <9704923d06839d92f4ef6fb28523b0f47e154df4.1703683642.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703683642.git.baruch@tkos.co.il>
References: <cover.1703683642.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that of_dma_get_cpu_limits() sets this new parameter to the
expected result.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/of/unittest.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 21d273a05ba6..d3b2c6ca56cd 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -911,7 +911,7 @@ static void __init of_unittest_changeset(void)
 static void __init of_unittest_dma_get_cpu_limits(void)
 {
 	struct device_node *np;
-	phys_addr_t cpu_addr;
+	phys_addr_t cpu_addr_max, cpu_addr_min;
 
 	if (!IS_ENABLED(CONFIG_OF_ADDRESS))
 		return;
@@ -922,10 +922,13 @@ static void __init of_unittest_dma_get_cpu_limits(void)
 		return;
 	}
 
-	of_dma_get_cpu_limits(np, &cpu_addr, NULL);
-	unittest(cpu_addr == 0x4fffffff,
-		 "of_dma_get_cpu_limits: wrong CPU addr %pad (expecting %x)\n",
-		 &cpu_addr, 0x4fffffff);
+	of_dma_get_cpu_limits(np, &cpu_addr_max, &cpu_addr_min);
+	unittest(cpu_addr_max == 0x4fffffff,
+		 "of_dma_get_cpu_limits: wrong CPU max addr %pad (expecting %x)\n",
+		 &cpu_addr_max, 0x4fffffff);
+	unittest(cpu_addr_min == 0x40000000,
+		 "of_dma_get_cpu_limits: wrong CPU min addr %pad (expecting %x)\n",
+		 &cpu_addr_min, 0x40000000);
 }
 
 static void __init of_unittest_dma_ranges_one(const char *path,
-- 
2.43.0


