Return-Path: <linux-kernel+bounces-90565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B34870141
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320241F232B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951613D0C8;
	Mon,  4 Mar 2024 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="USsmf+ae"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0631D53F;
	Mon,  4 Mar 2024 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555445; cv=none; b=gHpsyJ5wlY6nvSBSkWeN8kBYS3tibt+UB3jsfhWn7bDOUF2CcMiH8numtdLFy/uGfNSiIREslA1SfMp8SdiGlktnchV+N61Nv51ll35UxIQiCnGkhWmu+Fjj6btLK4BCj8RLe9eSu8mPwwybCoTBmK0375AGLIMGJCjlKJ8oCoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555445; c=relaxed/simple;
	bh=FeBZR3SGL2Om8m5Kdr9xfsj804J10OkYTMQW2JZj7VE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f4L0zkxRz8U6lcNcVk4YMlSS5If7pR8M/woV9msX1og7rp76+RSF8VjrHnF1e2rMz0IBXutEM0qBi1YQC1Uidb+1AakqfQfkbLzRvwpnR+Anot0uAMHXli4H7K1wFRbqWs5ej8neldF/ygpKaDS+EcKnW2Av6XY4RI5a8hDgGLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=USsmf+ae; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 14559100002;
	Mon,  4 Mar 2024 15:22:19 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1709554939; bh=YbTF9cKWyBV3OLPeCxcCiIlnH5+s0eWfsFAU6u80XD8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=USsmf+aeiLQI1maKyJZCHhC3uyVMfHOojULGaFWYvhPTEoegbnXGOiaA+Wt+ckXQ8
	 tsnL6RA1DUE7YrfOXx0ZPF30wRf+jNS4DyWPA4M/cIYXkc/ds9EA6GKlbzRCS30opr
	 2ygKtaj6qi0qFya1KmnN20qfMsBDifLnRCZq2DVTsfEhwfSg8jzjwKYrnHsvCdyI0H
	 PDD1E+nDLSTkp/rcc6nWYJBBnwhh3sRYf6+r2uSYXf4/RPQKopiFO8Ke8gMr51bYgH
	 61D7azudCxIcFVJ45f2xvoUyHiqAzDIqqIjaV6aOd3a4Qsp93JLDTBwOF95RDxvAdH
	 m1XXng71rCzfQ==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Mon,  4 Mar 2024 15:21:17 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 4 Mar 2024
 15:20:56 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Corentin Labbe <clabbe@baylibre.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
	Heiko Stuebner <heiko@sntech.de>, <linux-crypto@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] crypto: rockchip/rk3288 - Add dereference of NULL pointer check
Date: Mon, 4 Mar 2024 15:20:31 +0300
Message-ID: <20240304122031.25325-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183922 [Mar 04 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 8 0.3.8 4a99897b35b48c45ee5c877607d26a2d9f419920, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;mx1.t-argos.ru.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/04 09:16:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/03/04 08:11:00 #23960386
X-KSMG-AntiVirus-Status: Clean, skipped

In rk_crypto_probe() crypto_engine_alloc_init() is assigned to
crypto_info->engine and there is a dereference of it in
clk_mt2712_top_init_early() which could lead to a NULL pointer
dereference on failure of crypto_engine_alloc_init().

Fix this bug by adding a check of crypto_info->engine.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 57d67c6e8219 ("crypto: rockchip - rework by using crypto_engine")

Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/crypto/rockchip/rk3288_crypto.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index 70edf40bc523..88cea1e36afa 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -371,6 +371,10 @@ static int rk_crypto_probe(struct platform_device *pdev)
 	}
 
 	crypto_info->engine = crypto_engine_alloc_init(&pdev->dev, true);
+	if (!crypto_info->engine) {
+		dev_err(&pdev->dev, "memory allocation failed.\n");
+		goto err_crypto;
+	}
 	crypto_engine_start(crypto_info->engine);
 	init_completion(&crypto_info->complete);
 
-- 
2.30.2


