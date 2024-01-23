Return-Path: <linux-kernel+bounces-35672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFD3839507
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF72B293D7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C9E86154;
	Tue, 23 Jan 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z4imqtNS"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E168005D;
	Tue, 23 Jan 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027830; cv=none; b=OMRVzw+bxBwWh/X9Oj2Oq3p6gp5+uW1KSz896DMBH9tP8H1A4+FJ3O46SM+QaIQDg10+Ut28QzZ8HoBRC52KDFiwJekEwRxRFR0eys/3GTc5AFqbnZB4SPh8ctZ8qhQMjmLbrU1IzTtzzeGkq6V4I/tcwbNOL2vQuLE6tOP754o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027830; c=relaxed/simple;
	bh=HqyDbZstUWJOaMyZ4TiG/oEUrlUvngFXfqf5DbMzNi0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJCghWFqF33X0A00TtI0mfSidHCQVHESKOkowL6VA5nNa2cxV5hqf6811YkEGoDsK04WXOJY0mJM/QWyTHGtgOQvadecwD+B7KuDWCCWFTkY5JQqSxSK8o2ZKKT/kOqJ+nxTXsQ3KUXUDP3IE9hh9lS8UPHy3YXXqsl69+QiEpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Z4imqtNS; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGb0s0094139;
	Tue, 23 Jan 2024 10:37:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027820;
	bh=kVXImxDJPM4A7YrQnUDOEbJIk29vaGvEJQGgWRehcUA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Z4imqtNSh7hFg4AmEfTGwNX1/h8bMgvjZZEjwc3EiKeniyaKolR/dqfW4j+KgEkaA
	 tGx+/pafkNm1MkAdG8xrLFrsmXSDbUD6uIrHRzuFYTFpks6l1rKQ8kQPDwjrVnh8/Z
	 1VQn9ht3Vh6taqfgNbMC2WHP2vcLFJcdT88FTem0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGb0IK034013
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:37:00 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:36:59 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:36:59 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGars4123403;
	Tue, 23 Jan 2024 10:36:59 -0600
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>,
        Support Opensource
	<support.opensource@diasemi.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?=
	<pali@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 16/21] power: supply: da9150: Use devm_iio_channel_get() helper
Date: Tue, 23 Jan 2024 10:36:48 -0600
Message-ID: <20240123163653.384385-17-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123163653.384385-1-afd@ti.com>
References: <20240123163653.384385-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use the device lifecycle managed get function. This helps prevent
mistakes like releasing out of order in cleanup functions and
forgetting to release on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/supply/da9150-charger.c | 57 +++++++--------------------
 1 file changed, 14 insertions(+), 43 deletions(-)

diff --git a/drivers/power/supply/da9150-charger.c b/drivers/power/supply/da9150-charger.c
index 37db9e4ed7f30..77e2d42382e45 100644
--- a/drivers/power/supply/da9150-charger.c
+++ b/drivers/power/supply/da9150-charger.c
@@ -521,36 +521,26 @@ static int da9150_charger_probe(struct platform_device *pdev)
 	charger->dev = dev;
 
 	/* Acquire ADC channels */
-	charger->ibus_chan = iio_channel_get(dev, "CHAN_IBUS");
-	if (IS_ERR(charger->ibus_chan)) {
-		ret = PTR_ERR(charger->ibus_chan);
-		goto ibus_chan_fail;
-	}
+	charger->ibus_chan = devm_iio_channel_get(dev, "CHAN_IBUS");
+	if (IS_ERR(charger->ibus_chan))
+		return PTR_ERR(charger->ibus_chan);
 
-	charger->vbus_chan = iio_channel_get(dev, "CHAN_VBUS");
-	if (IS_ERR(charger->vbus_chan)) {
-		ret = PTR_ERR(charger->vbus_chan);
-		goto vbus_chan_fail;
-	}
+	charger->vbus_chan = devm_iio_channel_get(dev, "CHAN_VBUS");
+	if (IS_ERR(charger->vbus_chan))
+		return PTR_ERR(charger->vbus_chan);
 
-	charger->tjunc_chan = iio_channel_get(dev, "CHAN_TJUNC");
-	if (IS_ERR(charger->tjunc_chan)) {
-		ret = PTR_ERR(charger->tjunc_chan);
-		goto tjunc_chan_fail;
-	}
+	charger->tjunc_chan = devm_iio_channel_get(dev, "CHAN_TJUNC");
+	if (IS_ERR(charger->tjunc_chan))
+		return PTR_ERR(charger->tjunc_chan);
 
-	charger->vbat_chan = iio_channel_get(dev, "CHAN_VBAT");
-	if (IS_ERR(charger->vbat_chan)) {
-		ret = PTR_ERR(charger->vbat_chan);
-		goto vbat_chan_fail;
-	}
+	charger->vbat_chan = devm_iio_channel_get(dev, "CHAN_VBAT");
+	if (IS_ERR(charger->vbat_chan))
+		return PTR_ERR(charger->vbat_chan);
 
 	/* Register power supplies */
 	charger->usb = power_supply_register(dev, &usb_desc, NULL);
-	if (IS_ERR(charger->usb)) {
-		ret = PTR_ERR(charger->usb);
-		goto usb_fail;
-	}
+	if (IS_ERR(charger->usb))
+		return PTR_ERR(charger->usb);
 
 	charger->battery = power_supply_register(dev, &battery_desc, NULL);
 	if (IS_ERR(charger->battery)) {
@@ -619,19 +609,6 @@ static int da9150_charger_probe(struct platform_device *pdev)
 battery_fail:
 	power_supply_unregister(charger->usb);
 
-usb_fail:
-	iio_channel_release(charger->vbat_chan);
-
-vbat_chan_fail:
-	iio_channel_release(charger->tjunc_chan);
-
-tjunc_chan_fail:
-	iio_channel_release(charger->vbus_chan);
-
-vbus_chan_fail:
-	iio_channel_release(charger->ibus_chan);
-
-ibus_chan_fail:
 	return ret;
 }
 
@@ -659,12 +636,6 @@ static void da9150_charger_remove(struct platform_device *pdev)
 
 	power_supply_unregister(charger->battery);
 	power_supply_unregister(charger->usb);
-
-	/* Release ADC channels */
-	iio_channel_release(charger->ibus_chan);
-	iio_channel_release(charger->vbus_chan);
-	iio_channel_release(charger->tjunc_chan);
-	iio_channel_release(charger->vbat_chan);
 }
 
 static struct platform_driver da9150_charger_driver = {
-- 
2.39.2


