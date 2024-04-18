Return-Path: <linux-kernel+bounces-150670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C27668AA2B1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB4C1C212A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0C817F36B;
	Thu, 18 Apr 2024 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b="f9mXujrn"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2096.outbound.protection.outlook.com [40.92.49.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A9F1EA74;
	Thu, 18 Apr 2024 19:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.49.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713468384; cv=fail; b=Lsiud632uGPhynrbkO/doiszG1TCCthusDGlIIh/U7rv8bK5d+rGkzK2NPCN0EQGwTJ14woLqS6at7xM+55mszYcdb14Ai3MjJ49y3o1verNGERoYrJZ4sCiQ8Y1lqETLfcgpx9Rwu4fdEcmqUrmaV+EE2jwGXm/AZ6J/8LhstM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713468384; c=relaxed/simple;
	bh=xF+qmHv0WeCn5dP4yJjwI0JKijafRqi24s5JsxrEqOg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dRs62+6QXbmPshziE1bt4/V2vCuguQECPK2Xze0QYIQGdaBQbQ671PGzg1cHwUspIs+9AM+tcIxUxOS/EaQu0xu6sTfQjN/oI/6wf25DJK+eDLO6EtEdr8ZlQNmJbT+LOCE0sbPDac4tC7AnFrBQHhNPJ+ggcUezbBB9xIfYr5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl; spf=pass smtp.mailfrom=live.nl; dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b=f9mXujrn; arc=fail smtp.client-ip=40.92.49.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWVCS2Gzv2qbw+kWdBOB536POl0YWDPbKc8KPsiYTeeqOme0lDcOjZ05BRZxLS5HKFD2faPJFeOWQDOdMSOz10CgCBsHLJZ6G1bxhLbeZ/q63iYwY25bdiKBZxwVKqoe3uYfFBNtYJpfVMnpnSffI6G4eu7wiT/HaohdI9Yb3pcnfrGOR5ButUomlHEXXpnvjZDnhE9DqErwnOMSeHnN88aBg/Pr57tEBwam8S0JBsN5KB8PxJJ9g3W7JMGSLrPNisczZUz2YTdFppimOwilg04T92GQsxOYHJ+yjb078XP/G81Hlld0uKBUFIXsL7vfsP1l0E5d5UzhXyao2Wcecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBvcj55h1U2bNNLqD+rejW+HJwxvv3oQ8Wne4mZ/z5E=;
 b=LtrQ4+GtPzEqFXbuWnpK/8jTUUPCelteusHx1vfYzMEuAWH04LmtNWkbvDkXxMY/ruHCAblOX7Wt3KqCo3GD+/E0PDXSxOOOCqFMGbKF3qPrXsplywMMitvyo3CM9XRwHUAX8LbTx84NhK1J3XD4VD2sZiLbMEafWavpdM8P/s6SO1KvTClE3qbcaLh729Z0wEsnbqM5swOeHQwrbJX0rvhc8L6msOcPCAj6XKsPlG/FXePgqnfNaf8mfBid/+wXoRrrnpKqa/XvhIHV8MW0e+MRwkU0zNJLt/O6ROLlXzZEHhuO6kuxWpyo8V283sS0NNTJDn2ZpYSz7ALSiyp/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.NL; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBvcj55h1U2bNNLqD+rejW+HJwxvv3oQ8Wne4mZ/z5E=;
 b=f9mXujrnduQ0EMlRUIFjMIa8eIx6vvREkQVXAQaOmKQyNVR/vFJXX/QgjYhfcfeQXVuDoRFfv/1zkkdU5dkIHTJMt4FcywRvTkqdAudWmyXuA8a3NbqwdNFtU74G/lDtEOJoCqvlpEUboPxUxwkVexQcNZwP2nGDcompxGbBRLa0ATrNbWnNGpSaKjKMHM4KvojOpLHLi+vB1gt2FQOmArVhtspTallj88XYJFkd0cDofpZdIaYal8pQhRL6V8do4dhXgTgufzCgey3vMquTjFCU4ugzzAmz9WoQzhvLYc5sxD2sclA7DCKm8EPaLnHAUyAHjJ6Ua4irBS00RJ/TOA==
Received: from DB7PR09MB2684.eurprd09.prod.outlook.com (2603:10a6:10:4d::14)
 by PA2PR09MB7014.eurprd09.prod.outlook.com (2603:10a6:102:406::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 19:26:20 +0000
Received: from DB7PR09MB2684.eurprd09.prod.outlook.com
 ([fe80::b1cf:c248:d141:19e9]) by DB7PR09MB2684.eurprd09.prod.outlook.com
 ([fe80::b1cf:c248:d141:19e9%4]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 19:26:13 +0000
From: Paul Geurts <paul_geurts@live.nl>
To: mgreer@animalcreek.com,
	krzk@kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Geurts <paul_geurts@live.nl>
Subject: [PATCH v2] NFC: trf7970a: disable all regulators on removal
Date: Thu, 18 Apr 2024 21:25:38 +0200
Message-ID:
 <DB7PR09MB26847A4EBF88D9EDFEB1DA0F950E2@DB7PR09MB2684.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [UbqrPdS+bZuXMCVm575ZqH+mNFlvgbxyjnJEdZPEzK4M8PHCWBKxWAeR7UT+iLED]
X-ClientProxiedBy: AM0PR03CA0102.eurprd03.prod.outlook.com
 (2603:10a6:208:69::43) To DB7PR09MB2684.eurprd09.prod.outlook.com
 (2603:10a6:10:4d::14)
X-Microsoft-Original-Message-ID: <20240418192537.2520-1-paul_geurts@live.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR09MB2684:EE_|PA2PR09MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f36bb1-520a-4bf0-e445-08dc5fdd68af
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TEF1WnB6xPE7f4ZMopsdsfz4TbOdIp/3c7z/FPRs8XVeRHRUV4VCZnydpbG+LzLLjwZiZbf5GSCMXf+CrKn7j/MiWpZvj5tdGFkJfZh1Zf0INIyjRGfl7prdR2iyRdbmtW+Rt6gxe9Svial/NkEuoDI8JdX5GKzWPlEt9Khr7I4SzwMgxd1Rd4TccPviwc4XH+1zhqCMCpImqFXOcFN2IxRG6qIrHTgpb+7iq2vnlHgbpNwcH0wakUXR4/Q0lgcgW0zf1BitnzdaJVeTqYZaVG9nA/J3dLYTHvY2jTs4w1tlsPv7Gzda4WeRpAQJanSFD60hU+Bhu+/lhCvJKOj98qqTLTE4GPocjcFBnyRxwmQ2KNbq10Sf8ChVZ5WO3BMsQ05VEsrzJigepRVDaigElgG+cx2OsasAhObH2uzHVp17DPk9rVxmDC1Ht7TXPiru8sP/xU+TYOw3tGy0Cz2LnR/aNLaMETwEwi/kc+HFnyDNgQp8HcMIijSUYSoh64EGi0JChlcXWfI6Bqv33z9LOvQAiKkH2L+GHMEVFOqDp1VdOf73gFIas0G8keVK+L5MKApSl467HLhi8K6dBfQtvOjwu2VkwN6yvb+6b89F3+5m3d1qG3zWlP/ljCaGUi4I
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZskxeuYEy0NiR0iSjyc+bSl5hNofVCBCfmIqUJBiKxE3YOjgMFpwXz8dJ3ZA?=
 =?us-ascii?Q?lLULF2H61OjHJQrpZ6md7xICWVSFA7fgogqWxQN5EZNTTRl+zDBcwlF58n6Z?=
 =?us-ascii?Q?4LRKn907FP35OQ7a1QD1G1Y9f/GQbHgP5VM+ugJUuJPHI2XRjG6oHMn5SetE?=
 =?us-ascii?Q?YBH4qiqsyQOT3H04LO6JLM+Xl/GRJUATYWIAEpsZCAK1ooq3wKpA3QYE+Sm1?=
 =?us-ascii?Q?GZbCruBPe76/hsMMlB3eW+vME/blLpHaGSkLbiSTeKZaxSbCoS5AkBcJE8Tq?=
 =?us-ascii?Q?ewr18JUNbpY8PlBse6TKlPyGHUVd/nNvptjhgF8taN2IP/O2j0N41FMF7LGR?=
 =?us-ascii?Q?RV7X0XxhSZTk1UTAWJaXebhZ/N9Y16/Q8cqgJ+GKK2iFAJFAcE1b6JzcbEqg?=
 =?us-ascii?Q?kx16imxJA25sXoHyR2ccQ5VpjHOG6iDX+Hbt72rTZ3H+U/HW4+UvbEaSLPDe?=
 =?us-ascii?Q?WjnHkWRjaA0MDdwh7dG+d134RIet6TxuIZvVHNc063fGI5loxjxyP3m8FSkr?=
 =?us-ascii?Q?Tl8uTAbQE6AsD05+GxN4rXQpi5gz8ndWPwn/68HOZMphzqqQd/C2xodZfUz3?=
 =?us-ascii?Q?I5cyaF7Z9+1thnBd9Lpvm59CoNMnoqyl8Tu9Mai3CuGCgnA1zXju9wlShJZ3?=
 =?us-ascii?Q?/7qo5mMPjU0MVttyJniMuDZIEgy3pxCUwK+96Wvqe1lb1kh4pQv4YoxCs/vT?=
 =?us-ascii?Q?BBSPGQFivgPyjziRiwr7GnpUeBmX7aDniHlCr4dDq5A9Pxnu+Zg3oEpQbiO1?=
 =?us-ascii?Q?Gs4a1XVuMmd25ErSgcj/sx2Kp1/TuYFuL9LzY6TQ/uC88jrpwqRvPUO5ZOof?=
 =?us-ascii?Q?rV49E7+OPdQJ+MgrpuTO1d3OSNeDpzKb12Y3SwM2gx+RdELbOkEaRaC5dhGP?=
 =?us-ascii?Q?xF4DqRq7YbLj7C+nxWzsKBeEVun0m6ZpCSXWjR2oDucz4EQcw5akwgJViMq7?=
 =?us-ascii?Q?2pSA62sly66/y5ttRnfqCv49OvcAEWYfiwmXg4onr/pZWwARIxYBuO8Zpd1j?=
 =?us-ascii?Q?2cAWuo+onZ+Ma54XVqRl2VRA7uJJ1IdvQoFeSLG0eqX/q2s5dd5PGY8mknCO?=
 =?us-ascii?Q?Y4/3q1ZfpXyVS/BYMyK1xRpULJ1zrYZ4ceShdqEHv9q7hIHjfIQx0aGJfprK?=
 =?us-ascii?Q?a+Z8sVIPzukXWzhs4z3MWownE3Pux987eWLSLPm/xPka0FkIV1Ilr++1hOM2?=
 =?us-ascii?Q?TGJDPyq8VJQGTbaY/rZcif9iYp3wCf/bKJS6j4jTlaaB0e0Ng/zJU1UL+0yU?=
 =?us-ascii?Q?+scKJjPwfwD8dTVj0Nkgx9POF7fh3/uVuQLYcXZj0/+BwBtwggJn64AFIUO5?=
 =?us-ascii?Q?Nss=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f36bb1-520a-4bf0-e445-08dc5fdd68af
X-MS-Exchange-CrossTenant-AuthSource: DB7PR09MB2684.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 19:26:13.1956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7014

During module probe, regulator 'vin' and 'vdd-io' are used and enabled,
but the vdd-io regulator overwrites the 'vin' regulator pointer. During
remove, only the vdd-io is disabled, as the vin regulator pointer is not
available anymore. When regulator_put() is called during resource
cleanup a kernel warning is given, as the regulator is still enabled.

Store the two regulators in separate pointers and disable both the
regulators on module remove.

Fixes: 49d22c70aaf0 ("NFC: trf7970a: Add device tree option of 1.8 Volt IO voltage")
Signed-off-by: Paul Geurts <paul_geurts@live.nl>
---
V1 -> V2: Removed blank line between Fixes and Signed-off-by tag

 drivers/nfc/trf7970a.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 7eb17f46a815..9e1a34e23af2 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -424,7 +424,8 @@ struct trf7970a {
 	enum trf7970a_state		state;
 	struct device			*dev;
 	struct spi_device		*spi;
-	struct regulator		*regulator;
+	struct regulator		*vin_regulator;
+	struct regulator		*vddio_regulator;
 	struct nfc_digital_dev		*ddev;
 	u32				quirks;
 	bool				is_initiator;
@@ -1883,7 +1884,7 @@ static int trf7970a_power_up(struct trf7970a *trf)
 	if (trf->state != TRF7970A_ST_PWR_OFF)
 		return 0;
 
-	ret = regulator_enable(trf->regulator);
+	ret = regulator_enable(trf->vin_regulator);
 	if (ret) {
 		dev_err(trf->dev, "%s - Can't enable VIN: %d\n", __func__, ret);
 		return ret;
@@ -1926,7 +1927,7 @@ static int trf7970a_power_down(struct trf7970a *trf)
 	if (trf->en2_gpiod && !(trf->quirks & TRF7970A_QUIRK_EN2_MUST_STAY_LOW))
 		gpiod_set_value_cansleep(trf->en2_gpiod, 0);
 
-	ret = regulator_disable(trf->regulator);
+	ret = regulator_disable(trf->vin_regulator);
 	if (ret)
 		dev_err(trf->dev, "%s - Can't disable VIN: %d\n", __func__,
 			ret);
@@ -2065,37 +2066,37 @@ static int trf7970a_probe(struct spi_device *spi)
 	mutex_init(&trf->lock);
 	INIT_DELAYED_WORK(&trf->timeout_work, trf7970a_timeout_work_handler);
 
-	trf->regulator = devm_regulator_get(&spi->dev, "vin");
-	if (IS_ERR(trf->regulator)) {
-		ret = PTR_ERR(trf->regulator);
+	trf->vin_regulator = devm_regulator_get(&spi->dev, "vin");
+	if (IS_ERR(trf->vin_regulator)) {
+		ret = PTR_ERR(trf->vin_regulator);
 		dev_err(trf->dev, "Can't get VIN regulator: %d\n", ret);
 		goto err_destroy_lock;
 	}
 
-	ret = regulator_enable(trf->regulator);
+	ret = regulator_enable(trf->vin_regulator);
 	if (ret) {
 		dev_err(trf->dev, "Can't enable VIN: %d\n", ret);
 		goto err_destroy_lock;
 	}
 
-	uvolts = regulator_get_voltage(trf->regulator);
+	uvolts = regulator_get_voltage(trf->vin_regulator);
 	if (uvolts > 4000000)
 		trf->chip_status_ctrl = TRF7970A_CHIP_STATUS_VRS5_3;
 
-	trf->regulator = devm_regulator_get(&spi->dev, "vdd-io");
-	if (IS_ERR(trf->regulator)) {
-		ret = PTR_ERR(trf->regulator);
+	trf->vddio_regulator = devm_regulator_get(&spi->dev, "vdd-io");
+	if (IS_ERR(trf->vddio_regulator)) {
+		ret = PTR_ERR(trf->vddio_regulator);
 		dev_err(trf->dev, "Can't get VDD_IO regulator: %d\n", ret);
-		goto err_destroy_lock;
+		goto err_disable_vin_regulator;
 	}
 
-	ret = regulator_enable(trf->regulator);
+	ret = regulator_enable(trf->vddio_regulator);
 	if (ret) {
 		dev_err(trf->dev, "Can't enable VDD_IO: %d\n", ret);
-		goto err_destroy_lock;
+		goto err_disable_vin_regulator;
 	}
 
-	if (regulator_get_voltage(trf->regulator) == 1800000) {
+	if (regulator_get_voltage(trf->vddio_regulator) == 1800000) {
 		trf->io_ctrl = TRF7970A_REG_IO_CTRL_IO_LOW;
 		dev_dbg(trf->dev, "trf7970a config vdd_io to 1.8V\n");
 	}
@@ -2108,7 +2109,7 @@ static int trf7970a_probe(struct spi_device *spi)
 	if (!trf->ddev) {
 		dev_err(trf->dev, "Can't allocate NFC digital device\n");
 		ret = -ENOMEM;
-		goto err_disable_regulator;
+		goto err_disable_vddio_regulator;
 	}
 
 	nfc_digital_set_parent_dev(trf->ddev, trf->dev);
@@ -2137,8 +2138,10 @@ static int trf7970a_probe(struct spi_device *spi)
 	trf7970a_shutdown(trf);
 err_free_ddev:
 	nfc_digital_free_device(trf->ddev);
-err_disable_regulator:
-	regulator_disable(trf->regulator);
+err_disable_vddio_regulator:
+	regulator_disable(trf->vddio_regulator);
+err_disable_vin_regulator:
+	regulator_disable(trf->vin_regulator);
 err_destroy_lock:
 	mutex_destroy(&trf->lock);
 	return ret;
@@ -2157,7 +2160,8 @@ static void trf7970a_remove(struct spi_device *spi)
 	nfc_digital_unregister_device(trf->ddev);
 	nfc_digital_free_device(trf->ddev);
 
-	regulator_disable(trf->regulator);
+	regulator_disable(trf->vddio_regulator);
+	regulator_disable(trf->vin_regulator);
 
 	mutex_destroy(&trf->lock);
 }
-- 
2.39.2


