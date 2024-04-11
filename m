Return-Path: <linux-kernel+bounces-140431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3568A1457
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AE3DB22C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142EE14B093;
	Thu, 11 Apr 2024 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Hs5mLXPZ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2095.outbound.protection.outlook.com [40.92.21.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6CB13DDD6;
	Thu, 11 Apr 2024 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838080; cv=fail; b=XwRSUdrFpZ0ArHiih5Fg4mVVbQCAMN8TrlHEkhagjrOi2YJ4VJh54T+RHE6ffdnZoiEVfue1svkWIsNEwG8keYQA6WXP8as/hh31ASRfUY/xp/i7tUMOwqXHc7Tcc4K9Uzh4+qJixpht4G87zsisYIP52fW5JzxM592wT6HVKlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838080; c=relaxed/simple;
	bh=xvioZmuaZvgXi2QcGpYLDx96ibDulVrNwlvJIeH/Ux0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=guZl0RB207oi4aNSR9LEIB754RUVpAKTOzXT4glV6Y8WDi4MBYBjfIzQ1tQMt9fazfKik+N5kIqT0mx/3xfFtInOk2x9DU3gesBKw/Cb+bn/pLjdnaBF64VcouC10ZRKt4M905OyfffgnWJbANph9Iw7BAMOivGH4jNCBZCWuVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Hs5mLXPZ; arc=fail smtp.client-ip=40.92.21.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjjKZWXX5A4Y89nz0ZcoADg9AwDNz962JcvHN9d8fy7fYl9QiTWSo5ImHXw8A5nFr8dYNsKCJFXBIuU5wCP/E96a2g1TdEcjfM+4l+v3dJ5LCy3zuWR6l3pCB/TDMJiUxSAqhMTgcm7XmaX5M1XaCjEO1Yn6+mXy0HhKyLF9rAc0cWkdE1bsG6KGwJGsL7jj1bYrSerEL0FFg37uMyWX122LNa6P4+qUFYp/EMEmmJ+ztEIFUa2KE+/F8ayDY0Va9ye8OQGSCas/7pKx0EToBUKti0xmRcsFVFOfir0WBh+mHlTr7+keJ+y5zTNPnK2x38qI2uXfH6pqdIW8O2XdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhKpUZevkYPltCISaDvXBPMAxwJx6OomIJ1ckJTeX98=;
 b=g27SutoJZvMEvTKJSdtE4wMyiUPM35UTiAYmxClOxms3W9ZR0ottZNZTu+TXWH9YRfs4SQSbnrVu8rKQ84SUl7NIQ0sSiR0j0u0Mem5fQQ2mAR13kdotO91F0kZ5KRaeoatzw0nK8sruCF5mKNuhDE7r52UG4MBWoV+OyHUpHKCYNkpOiowACudSUHjb/yNr+yleCta28vTUMK9g/xmOKL1tTJYKw5cZDwMFzFtQ+nlBJybJxSv2HPu6Y/7KH2vaVReRCVgX7d1npwmeaQEKsHP2fD/jlPbcEn9mLWhHG8OTkVgdWt2nvQNk76Fu97An+lvg03oFIVBKCwU0VxY0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhKpUZevkYPltCISaDvXBPMAxwJx6OomIJ1ckJTeX98=;
 b=Hs5mLXPZUGaYoDcCPCj1ABVWqpTGxGRp5q5xy4pofpiv2Ug3ay55B5grQ4lXSR4VDf9rNZ4FsJclqTt6+csQAqZatefmEx7YwxFy/uQoh2fVkKUty7nXd+woXgbapl/Zp2/8qvoGBAyZCIBB8/3abdl4z5OZVa9Fx1vEzw3AZQICpJnQOdP5o6WlL+gAxntuPHrNiBS/CbhHoErMWM+UFfzheKwjI3Y8DV0ScMTf5TnriOOPqoUbrVVKVaTT75sNGpQp1Ju7F/YsGCQUvlNkCYarQWeFwAQ/0tLtleQBTbLIbEq2Xz1Z6DWFJOyIVuV+eB9smnaMPmQ9fqx5O+/SYw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA1PR20MB6245.namprd20.prod.outlook.com (2603:10b6:208:3f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 12:21:16 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 12:21:16 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: sophgo: use real clock for sdhci
Date: Thu, 11 Apr 2024 20:21:35 +0800
Message-ID:
 <IA1PR20MB4953CA5D46EA8913B130D502BB052@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Hjz5IfWffUx3hxm4nKiDE1XoRhgcmDzWsQ/YzfUSQQI=]
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240411122136.793528-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA1PR20MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bfb4f37-466a-4655-7a94-08dc5a21e295
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6fRphPAZkDOXKiJlf+rSXUByCx+8qhstiUj7tIcA51KpS2vy+RYr2SJtTaMKCoFvvpiBx1+ho1eJ9f1IMrjVvh20KY2k7vU6fWeVtpHAhEvlEMmTTAOGbZZkyMV7RMGCxzj3UjULp1UgePoYHN9SIOGfFTivKyELTj+vdj08VrjLu1q8XM3Uyz1Rvhn4+wQIyTdxX7uK7rsBcfe7VTmL5GojqIvjgXGHynhg7355Gpl9D4wIw/RY/2iHdSg98SRYPYwY1K5i2Py3mSZ7fhxSSeVo5L9TuZqrvLmMX/Wie3E55DyAwYMwHW9uisQXZZz29Pib0mc3ajl/+BoDO3yNl3IoTPkJ0V1/wAgTy4/OEu5FMMRYpXOQ42KhpULqjL7Ts7AAkV80/zP7Y3QBHf0C/r2tU9QhvmTlkaQBsPX/jVWy3+IHhhaXsTs9LM5cFcpPuWVZ0TuIfWEyaK6AkDxJc7VvEpBMEZHTt2m6pdpHpf5z1/3DQQA3yipvXRynlCJvB/oUArUgYC9WoA5wD7DkW52sczRErfm3xXK//glJ46tn+OT5mLxZHmt1G5CnfpFzBKr5G1ShwDwwqrh/UBANLlFe9kW/RXanAro9GggBFxUm5ZIcTN7fa8aqYSXCjhU0fc3QfVHzU8x3yLuAcUng6N4BFHpoMJUREDSJg84IAyJ4dMkjC+VXG32OtYjbxOt1XU0pI2qXbBWqW2sTd8in1ilSS77cF9IBDWMrerclRrqMtXcj4Sr+eZilhZtwQ+dOv8=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BUseaETwBXt4yH0QYxsnIBdb1KFCh07Dudlhk08WxHDHuk0DFyQGaJ/+m3pDp+4JtCKe+NfVhYUO8jAkOIx+QqIp2zvOnSZmZpcZ1ILZEXZk/n+BO0aQoRGeMCJNu7W2MCfylSGGawEmSCo4Rhx/nTHS5ThoL9jYh394NFnMq8PGNn+ovQVwbrKyB/HNfr3I57WzzkQthgSVkJMmWKGneo91LiNAlDzBz7z0+V0DaCPFC6SsKp5WIF9JmIUw/uutWHH+XfL2g7NbZ2TVcatz16b1kx9aNMA1RmWPccxJay1Ek5tAuw3yqhaSwIz2EZEGo/TnVgwiDXwWFqZUEd8GSX7TrtgZKEBXuy5QPPMGxlwiZ1WA8g60tra1H8+roArifUxlr2tt8Oc5Jz1XqEhMJh5IlqWwLvO7BHVGXH3QFLcqBmRyXdFv7vFCZpIfVI0iAYhvVyKUgYVnNMaUZ9d+s0hb9EsE/y2DQIu6n5/PDd4mAYwBpEM+6SZX1ShruNA3wzgiWPq6LKxL5YAOUlaRhx8T8OuHIZCb4b0m+ZcRPHc7Rq3Ly9xWJGZyDEeyglKXOJnClFcgChGdbpEs/Ksvqy9HOI4M6m8rwb71qrQK2ja0eRYpjRlHcw5NOhcDzbpa
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TZiTJe5zTyd/KiMOZkHmSIZPHJ/EaDNrw2cdT2AJLNSYu8oxHm5nLwtKTtX/?=
 =?us-ascii?Q?KyXIIQEKLCnFXBw2nntBKYMoKn1xqN7he/UVuUUi4MiwQpvVLJTsmOJ62EPp?=
 =?us-ascii?Q?SINiNc1x8BQFbNrhLPHi4cXabRXk7RoQ1eMoq2P83U2L03EmSgi5w7RSxigC?=
 =?us-ascii?Q?dkIpJHoMonGpazfRI3ycVEV74/IldOLMxFVhNn8fDHeeZG9gPdMeVYvgxVSO?=
 =?us-ascii?Q?DZfX9/a84GI+/dhmFdRpvj41D9dllTQQz2/shhwB3lM5SYNVaYqYa7luR4kq?=
 =?us-ascii?Q?cEyJwWnpnJdcCoLCJWNu1sjxqR6qk4GD5HbMkuQlXlZXVtkvNtrwLseR+VTf?=
 =?us-ascii?Q?lLeRSYSIGVNoUB5FEc3szAuhS/gYLH+2c28N5+szmcTrOoKoO99gALAh6OqF?=
 =?us-ascii?Q?9L4NLtirBOWfT4pT2155MWPKqmHJXZ1lXVwd90jOvsvvmjMJrsHIA2stVtHI?=
 =?us-ascii?Q?E9tO56GEq58joBTNwSlGk/WgPRgr1Ki51hPAy0sISe1blq74OTpZimp1pjrN?=
 =?us-ascii?Q?BBDFNssNa1+5/bm28VjL9NDgvzif/atPcWMV5SE+3HQccdc1QYuuhoFxKwV1?=
 =?us-ascii?Q?hVfIWpQT4AUzxgeZUBdChJ6yrXWEFutZT1t8IcAYWLebwVmfFPX5K9q1Mi33?=
 =?us-ascii?Q?HRi/IF4jNiTnfcGgfkK8E1sg9Wzy2kmTTVe7qIDSzr9XIXgtJu3OE5Q1wXCo?=
 =?us-ascii?Q?2KmgrnnwDW7X/g/TCeMSQYORmw3WsJBIoPFRVliwKi8uV0XrmhhWYY6g+yxo?=
 =?us-ascii?Q?9VDCaDpXb7f3NPDHFjFfRQEj0+cOGGk6MwxzmTUMp57oJon3wmSQeg9YobX4?=
 =?us-ascii?Q?DJ6shP8wCtkqQPuE4GQFWp9yZFEhhSL9RZnOtNkF0HTBMGATyQUgXOstL9h8?=
 =?us-ascii?Q?TnRPt2SeakABwW3gxqH+RKKLRn5xWMFgJrA1wOiGBjgUbqfT5zze6bGo0T0V?=
 =?us-ascii?Q?rJP3T8/EwBcZOkUfpJgf6angsWOvM3+syUGf/I7ZnprPAZjcCVFqhchTto5B?=
 =?us-ascii?Q?PD1ua7t8a/BbWRVCHaEW0hWWCySZ/JAHAY2h0z9CR5CcBgKonsdprN0O8oxB?=
 =?us-ascii?Q?MbOU+WaDN3+I0Tzk/wfo/Kt06fsaGNdCwvuSI2kigqPlWE38ld6Jxi57Vw41?=
 =?us-ascii?Q?R4V3WhqCZk1NnfmG9A2x39qyHYGto91dkv19cUsb8GAdIhQ0lzc/xVrE3QnS?=
 =?us-ascii?Q?YvIoV/FIZAIHGWtzWi5zwtLOuoiuApAnJnmut9gtfInZDapzAIenBUvZ/V9R?=
 =?us-ascii?Q?+/BRgYI4hiMXkvzZ57M6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfb4f37-466a-4655-7a94-08dc5a21e295
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 12:21:16.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB6245

As the clk patch is merged, Use real clocks for sdhci0.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 75d0c57f4ffb..891932ae470f 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -47,13 +47,6 @@ osc: oscillator {
 		#clock-cells = <0>;
 	};

-	sdhci_clk: sdhci-clock {
-		compatible = "fixed-clock";
-		clock-frequency = <375000000>;
-		clock-output-names = "sdhci_clk";
-		#clock-cells = <0>;
-	};
-
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -298,8 +291,9 @@ sdhci0: mmc@4310000 {
 			compatible = "sophgo,cv1800b-dwcmshc";
 			reg = <0x4310000 0x1000>;
 			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&sdhci_clk>;
-			clock-names = "core";
+			clocks = <&clk CLK_AXI4_SD0>,
+				 <&clk CLK_SD0>;
+			clock-names = "core", "bus";
 			status = "disabled";
 		};

--
2.44.0


