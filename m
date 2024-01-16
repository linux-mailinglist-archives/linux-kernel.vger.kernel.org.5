Return-Path: <linux-kernel+bounces-26729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D68982E5A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9071F2401D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8D21D551;
	Tue, 16 Jan 2024 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka7LQ/lf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99041D53D;
	Tue, 16 Jan 2024 00:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4CBC433C7;
	Tue, 16 Jan 2024 00:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364672;
	bh=1/jfaulafBo8iXr07XveIUg6jnz8lgY0whQgdlchiiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ka7LQ/lfZVuVWzxNxfTvQhdJXKjC5pa3qo7aXnSqhZNPiV5hO1xRbMMpA7KL06JIN
	 D/Ry7OzcGLSJ2BL2bThTQlwnlalmrrriFVnPURWUkWTGml8wMIJd0V2x0XKQJFEHFX
	 3ae8aC2lBifOtpQKbvM6gm9BDECpsDUMGbWLg6ubR9aJg+OsCazcdkWxHGgQS3DNPV
	 SquF9ONaLcZbkKInsX/k8bScMR/YGqyogYJL6SKdONJOwjaaO6VQzDtqrICuWGWliI
	 UHzN4O68WrJzYUZfa54AMYk1D7K59mSudKetlETMrmocSeV4IYI9AnNIXYv8aZJh2A
	 jtF+DNOcQtLGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jia Jie Ho <jiajie.ho@starfivetech.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>,
	olivia@selenic.com,
	linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/19] hwrng: starfive - Fix dev_err_probe return error
Date: Mon, 15 Jan 2024 19:23:42 -0500
Message-ID: <20240116002413.215163-7-sashal@kernel.org>
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

[ Upstream commit 2d37b3649c412b3bcecfea932cb677f7a5775b15 ]

Current dev_err_probe will return 0 instead of proper error code if
driver failed to get irq number. Fix the return err code.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202311160649.3GhKCfhd-lkp@intel.com/
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/jh7110-trng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/jh7110-trng.c b/drivers/char/hw_random/jh7110-trng.c
index 38474d48a25e..b1f94e3c0c6a 100644
--- a/drivers/char/hw_random/jh7110-trng.c
+++ b/drivers/char/hw_random/jh7110-trng.c
@@ -300,7 +300,7 @@ static int starfive_trng_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, irq, starfive_trng_irq, 0, pdev->name,
 			       (void *)trng);
 	if (ret)
-		return dev_err_probe(&pdev->dev, irq,
+		return dev_err_probe(&pdev->dev, ret,
 				     "Failed to register interrupt handler\n");
 
 	trng->hclk = devm_clk_get(&pdev->dev, "hclk");
-- 
2.43.0


