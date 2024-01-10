Return-Path: <linux-kernel+bounces-22723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD85D82A222
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1081C21909
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DEC4F208;
	Wed, 10 Jan 2024 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Ev5cfX5o"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5276C2AE87;
	Wed, 10 Jan 2024 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id ACE85120019;
	Wed, 10 Jan 2024 23:12:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru ACE85120019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1704917546;
	bh=ZsEVEKBfXgYOp70GvXu8cfrdsdoWzBIzHkZd6g+E03o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Ev5cfX5oNuTHckqSCunuiKGIBPdCYP/9L50pG8Ndo27B+Jp3jBlgXK3l04/aFM1fd
	 2qxsJLPw0ZjOtyQb8JQkYNqnhUs4KAYwNpa80uWPKo9uJteEKNHRdDDevuXboqCdkR
	 JGoDxOkkfQQiN8oiId9KTXHhYqoEVAdGHbAivFxWtpTJ9Ndyy0P8qrq1xG+qorlz+h
	 JnG5bJOgr7+8tpdMTwpWufuk7LUd30Aiowu8eY4sJXt+zWLc+ubsIzAFPBhcVOL+1B
	 gF8CFz75Xp88z/PNYu5xcyx19SWHn+vXvgRDTxQb/UCv/nhxEqjPqH1Da7H9/CoOFA
	 geeJw/fZMiwfA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 10 Jan 2024 23:12:26 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 23:12:26 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <narmstrong@baylibre.com>, <neil.armstrong@linaro.org>,
	<clabbe@baylibre.com>, <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<artin.blumenstingl@googlemail.com>
CC: <linux-crypto@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kernel@salutedevices.com>, Alexey
 Romanov <avromanov@salutedevices.com>, Jan Dakinevich
	<yvdakinevich@salutedevices.com>
Subject: [PATCH v1 02/24] drivers: crypto: meson: make CLK controller optional
Date: Wed, 10 Jan 2024 23:11:18 +0300
Message-ID: <20240110201216.18016-3-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110201216.18016-1-avromanov@salutedevices.com>
References: <20240110201216.18016-1-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182544 [Jan 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/10 17:01:00 #23071477
X-KSMG-AntiVirus-Status: Clean, skipped

Not all Amlogic SoC's uses CLK controller.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Signed-off-by: Jan Dakinevich <yvdakinevich@salutedevices.com>
---
 drivers/crypto/amlogic/amlogic-gxl-core.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index a5df061f9890..e5f504fb477e 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -248,16 +248,10 @@ static int meson_crypto_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Cannot request MMIO err=%d\n", err);
 		return err;
 	}
-	mc->busclk = devm_clk_get(&pdev->dev, "blkmv");
+	mc->busclk = devm_clk_get_optional_enabled(&pdev->dev, "blkmv");
 	if (IS_ERR(mc->busclk)) {
 		err = PTR_ERR(mc->busclk);
-		dev_err(&pdev->dev, "Cannot get core clock err=%d\n", err);
-		return err;
-	}
-
-	err = clk_prepare_enable(mc->busclk);
-	if (err != 0) {
-		dev_err(&pdev->dev, "Cannot prepare_enable busclk\n");
+		dev_err(&pdev->dev, "Cannot get and enable core clock err=%d\n", err);
 		return err;
 	}
 
@@ -279,7 +273,6 @@ static int meson_crypto_probe(struct platform_device *pdev)
 	meson_unregister_algs(mc);
 error_flow:
 	meson_free_chanlist(mc, mc->flow_cnt - 1);
-	clk_disable_unprepare(mc->busclk);
 	return err;
 }
 
@@ -295,7 +288,6 @@ static int meson_crypto_remove(struct platform_device *pdev)
 
 	meson_free_chanlist(mc, mc->flow_cnt - 1);
 
-	clk_disable_unprepare(mc->busclk);
 	return 0;
 }
 
-- 
2.30.1


