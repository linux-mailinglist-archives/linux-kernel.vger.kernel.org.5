Return-Path: <linux-kernel+bounces-136297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3227089D25A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A97284AFF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DCE763FC;
	Tue,  9 Apr 2024 06:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="X694B3Zv"
Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BAF7317D;
	Tue,  9 Apr 2024 06:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643940; cv=none; b=emD3kICU14vpJO9wkkYn9T1SGTuV8tPVczwL+nVDSgRMzcxNHPwgbO9U1nUC1y5iE9wUkMpCBKYQRCA1oHtfNwHUBaONVKDpSW1GV1ZHAkCDHk86yn8T0xk2elbTnC5P7D2BqGCrjmZGrbnL6KhbKSuiHKXEdQysD8kG8CpKbng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643940; c=relaxed/simple;
	bh=gBrssBZlXRFpb/uFLqMMzn9TEci+17z5aWBNXa2ngBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4fmaJjgQIaTGaNcpYfD/MAD5GtyBVLBG5wu3CxqqKkNab+KcaepG0t24h6rlMnrLg761sgmsnd272N20uMJJaHO2h1fSq29zOwwu3nTpdlSFd+/JpOp+K4MlD/YlcfDKe+fwgBfMu0ctH3v8GQl+WPnsmGKI1AnvOBlKR5MpZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=X694B3Zv; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id E92AA4402AF;
	Tue,  9 Apr 2024 09:17:43 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1712643464;
	bh=gBrssBZlXRFpb/uFLqMMzn9TEci+17z5aWBNXa2ngBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X694B3ZvoBbd8hdHi7EzW+8J3OhjQ3vGjltGuIcjUGUE2fwOJptEAEdfejjw64iAN
	 lijKzF39aagDuh+BBzePRq6AGkXS7wMIDboXTR/qyUZYG1iR9j9UE4FLbS4my6aExL
	 grP8xNQYjxSa+353MHFEkx5KeiJJyzng3Lgxngls4wOIpTyqxeAo3aYtRUotgD1s+b
	 RNnGfxtA9aNNWIO47r3iSmqxFw6TwBTMJsLU7SAtgqv66YixNdry2dmyQ981D42CIR
	 ZrkL6mcP1A3ER8fnpQtJ/cjZInpCjfyeUkRT4Puuvkm3pNUJm2LFMZoHx58lBg0eEA
	 IEQfxVkwMVY+g==
From: Baruch Siach <baruch@tkos.co.il>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Baruch Siach <baruch@tkos.co.il>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: [PATCH RFC v2 3/5] of: unittest: add test for of_dma_get_cpu_limits() 'min' param
Date: Tue,  9 Apr 2024 09:17:56 +0300
Message-ID: <945ff87c765a461d46f0033fbef422e97f9aede0.1712642324.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712642324.git.baruch@tkos.co.il>
References: <cover.1712642324.git.baruch@tkos.co.il>
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
index 2d632d4ec5b1..8fabb445a62a 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -924,7 +924,7 @@ static void __init of_unittest_changeset(void)
 static void __init of_unittest_dma_get_cpu_limits(void)
 {
 	struct device_node *np;
-	phys_addr_t cpu_addr;
+	phys_addr_t cpu_addr_max, cpu_addr_min;
 
 	if (!IS_ENABLED(CONFIG_OF_ADDRESS))
 		return;
@@ -935,10 +935,13 @@ static void __init of_unittest_dma_get_cpu_limits(void)
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


