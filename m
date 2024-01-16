Return-Path: <linux-kernel+bounces-26733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FE182E5AD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51BEDB245FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBFA1DA2C;
	Tue, 16 Jan 2024 00:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfeePsLX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E82CCD2;
	Tue, 16 Jan 2024 00:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59077C433F1;
	Tue, 16 Jan 2024 00:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364678;
	bh=Xu5aDG6VKhjO7Qw88dpdP3PSA2esceo3TBRKh5OeS8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MfeePsLXILXMoH6tF8CXdXREd0zrBeutzTwZrE7SZJoJ67j4GHDVvE6leA0l6/x/w
	 55W0CFSp897+7HogDYyDuaKYQmj6+qzqnSlebPAMOcrluOwE8oV/75K+iuGpDDIFM2
	 RA93esGJ734iPkcukFzQpQDzk61YO0KbCmCwmVtcHR3uKDgs5YApnqSXGc3Z34E3pA
	 P54JAMAEoF0DwA9ewU1BdnsxQqn7xWZg6NCZnffi+JKA7Doj3MKuie4BdxGMy3Kq0T
	 7A/QFq/ci9c2J54z+mVAV1k0KYbf6rqFRGDwlkDjNkgdIkts8zHn8Wukgh9Hsugiso
	 U777iDmFED2bA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jia Jie Ho <jiajie.ho@starfivetech.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>,
	william.qiu@starfivetech.com,
	davem@davemloft.net,
	linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 11/19] crypto: starfive - Fix dev_err_probe return error
Date: Mon, 15 Jan 2024 19:23:46 -0500
Message-ID: <20240116002413.215163-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002413.215163-1-sashal@kernel.org>
References: <20240116002413.215163-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Jia Jie Ho <jiajie.ho@starfivetech.com>

[ Upstream commit 8517c34e87025b3f74f3c07813d493828f369598 ]

Current dev_err_probe will return 0 instead of proper error code if
driver failed to get irq number. Fix the return code.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/starfive/jh7110-cryp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/starfive/jh7110-cryp.c b/drivers/crypto/starfive/jh7110-cryp.c
index 08e974e0dd12..f6601f9d3aff 100644
--- a/drivers/crypto/starfive/jh7110-cryp.c
+++ b/drivers/crypto/starfive/jh7110-cryp.c
@@ -168,7 +168,7 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, irq, starfive_cryp_irq, 0, pdev->name,
 			       (void *)cryp);
 	if (ret)
-		return dev_err_probe(&pdev->dev, irq,
+		return dev_err_probe(&pdev->dev, ret,
 				     "Failed to register interrupt handler\n");
 
 	clk_prepare_enable(cryp->hclk);
-- 
2.43.0


