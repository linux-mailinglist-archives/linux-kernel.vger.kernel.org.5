Return-Path: <linux-kernel+bounces-82171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4302868031
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DBE228EF86
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03C412FB0A;
	Mon, 26 Feb 2024 18:57:24 +0000 (UTC)
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C3812E1D5;
	Mon, 26 Feb 2024 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973844; cv=none; b=Iimw4w8ccvKu68rrTDYtfGrh7BiKUv9EXRZ2qF1JOwRPn9f62xhRbTdjAwKkwF5cBiuZEPzYA+YE0mt+6Nux+GO6ufH0/4nOp591rmJWbdy22Qm4YPscoRtr0gPx8YLysFmWrg9uBL8Jx9jH4/hAfBaQuzFiVeylDMdka1xRM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973844; c=relaxed/simple;
	bh=XGFGDL2vkSkevkpwiN9gnwJy3m/FJ2fKnkPaSRjeF+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EUHpc8MHXtcwTxd9gT6oK2scsiBhY54B2jl0p7x1LLhNI1d+0eJ+SgQKr3RtNJHm3k1QErueisKuMH4asih9jG4KKRzxgRgZIXGXrH8GAuOa7WBkVwi/GgfCz0/zbtAp/fcwlSMyLXqMNUPceak6/tnWBO/kwCVO7J36QPR1Y5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from dslb-188-097-209-155.188.097.pools.vodafone-ip.de ([188.97.209.155] helo=martin-debian-2.paytec.ch)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1reg9h-001h3u-19;
	Mon, 26 Feb 2024 19:56:49 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] hwrng: hisi - use dev_err_probe
Date: Mon, 26 Feb 2024 19:57:00 +0100
Message-Id: <20240226185700.39411-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace dev_err + return with dev_err_probe.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/hisi-rng.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/hw_random/hisi-rng.c b/drivers/char/hw_random/hisi-rng.c
index b6f27566e0ba..4e501d5c121f 100644
--- a/drivers/char/hw_random/hisi-rng.c
+++ b/drivers/char/hw_random/hisi-rng.c
@@ -89,10 +89,8 @@ static int hisi_rng_probe(struct platform_device *pdev)
 	rng->rng.read = hisi_rng_read;
 
 	ret = devm_hwrng_register(&pdev->dev, &rng->rng);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register hwrng\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to register hwrng\n");
 
 	return 0;
 }
-- 
2.39.2


