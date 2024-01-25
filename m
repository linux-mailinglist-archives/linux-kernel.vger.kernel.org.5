Return-Path: <linux-kernel+bounces-38321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E586883BDCB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A221F32767
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F131CABC;
	Thu, 25 Jan 2024 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Q8mlGxyQ"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2056.outbound.protection.outlook.com [40.92.18.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252721C2BD;
	Thu, 25 Jan 2024 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176008; cv=fail; b=gtRSrwi9l3fTLcX+k9C1ffD9l7pHOEO21UWb7k4Uzp9HbtwuHg2807lxHbly4z3n5H9nUEshsjDOJQBp6B2o+eSM2HqFFtdFcjvmPmnxvrcOhwqWnrrakOsOJf5QOfo8xbYYS7P5gTiW6fK2QVzEMxziOm1Zb5hkH1zA97N6KrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176008; c=relaxed/simple;
	bh=HlLCro1Wh9M/pCzJJKbSZt7Yb8ROM9ngwIVBYlHfC5s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=df5uSmU9Pzg6+tCbhIFgIq8rV1cvns0ZE6vCij0R+fSfucRYZnW8+eSbVGwkQIQGL8EJk9+w8WYLwKzh987LLScpYuC6CXd+yQSxbb3Yqa64ReNLH5GeQr8cJzm6/tSJQvAfjUBrGu1Rm5DFw3aCS1DCfPHgCEIXphoIvJAnI80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Q8mlGxyQ; arc=fail smtp.client-ip=40.92.18.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bvk8aElI8DAJ/9YfyAePxfhMYimyKG+qJWHXhSANkQ0TCyEGfdLat+UzXYqmur7heWiDKmWON+RhvZ18a7OuWO+xeQMK74MjoMs5Kop1v2hJYujo+FF3pxVUxAdtZvUIPdfmwpK2Ptk9QiI+cLVvEiMUCd8U/TX+vG6YGrhIZtdiki7ueytPDdXw21fOhjbiQ5C0Jismjgko/gohkmEUEo4TJJ1AXoJL/qH6uPppNtIuGBB3L2Gf+/6kl5FA7Y4REOvFmU5mBSTy1WewKE5KYnfIn7EXaojxPYlg1j05QlO1XGu0ZkxRXKcUHtTwG6XJe0WREcd3QHxyLkytMkA0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Avc4btygBTB+P1+tw/KX4T/5yEf8onn4TVe/YGVWt/I=;
 b=G/5uWFwEle5xjP1qQz7xmVoSzFNCxxwt8YGAQJFRdaVIH9JPVQ61+F9Ibrm+/N0rF0YN7uJPiEk4QncSc7atGzSwhTpnwEyys556Fu7UQVyQn9pggUdWNgCfV/tg7t/nBv0T0n9TsiF9sp+Z0WpwoboQR9LtrYRILFbqLoNqcAmOFaJ8TzMWdJwsfPvjs+c+pXB/O+C8B9oPacONCs0/LzVR9lpVq3s4AHCPd9GO/fTOY4SaBY08lwlySInAS/V8ESkeBHVVReTzm2Yj0Jms8rRCFZ/A7gCqHbP2U9ISPIcD/0jIT2qQscMBASJU4e2O+iANX0clXOOEcqaC8T6XEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Avc4btygBTB+P1+tw/KX4T/5yEf8onn4TVe/YGVWt/I=;
 b=Q8mlGxyQAqkCZEBSuTIbVu55uXcVm8i3mgXemjpKCPSsia4LpEgZ+IoXMOkcPlRs29th7qv9nVYWDTftTAcZ9pW3I5yNs54rrfosTuepvcs2h2OxGSge/VGe5Q4lkf+pyQRpwp8QZ0eGEZaGTqqXiCcdbPpt0KcTyFD2sYWMelByHraOKwqUAEz328u2WTu2fd1c+n1qbqb1Fnx9osqCL0Jt1wv8v4Kz6BfisRgcvLMgBpXmSP170iUWtNPwETlecauoTPDC+/ySU38vPrtyS5DrV/8ZJnCLvNA8iEJLeDRjYnYgmGyWGzQRACLlUFpngJwnBps0ynr3E0AUTrUCRg==
Received: from DM6PR20MB2316.namprd20.prod.outlook.com (2603:10b6:5:1a8::28)
 by SA1PR20MB4275.namprd20.prod.outlook.com (2603:10b6:806:22b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Thu, 25 Jan
 2024 09:46:45 +0000
Received: from DM6PR20MB2316.namprd20.prod.outlook.com
 ([fe80::eada:a454:b624:1459]) by DM6PR20MB2316.namprd20.prod.outlook.com
 ([fe80::eada:a454:b624:1459%4]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 09:46:45 +0000
From: AnnanLiu <annan.liu.xdu@outlook.com>
To: chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	AnnanLiu <annan.liu.xdu@outlook.com>
Subject: [PATCH v2] riscv: dts: sophgo: add watchdog dt node for CV1800
Date: Thu, 25 Jan 2024 17:46:40 +0800
Message-ID:
 <DM6PR20MB2316366FC9ADCBC7B6E9C289AB7A2@DM6PR20MB2316.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [e5aC/WTf166EcgBX8qr4a3cFpuCmKYgmF/UgcVmntEY=]
X-ClientProxiedBy: TYCP286CA0184.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::7) To DM6PR20MB2316.namprd20.prod.outlook.com
 (2603:10b6:5:1a8::28)
X-Microsoft-Original-Message-ID:
 <20240125094640.27279-1-annan.liu.xdu@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR20MB2316:EE_|SA1PR20MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: f7eaf245-101d-4c68-9b4b-08dc1d8a8abd
X-MS-Exchange-SLBlob-MailProps:
	vuaKsetfIZnl7OK+GjNZx76AODbk0dt+BycfSlgr8O/XM3p3VNRsLb8oFufI6jvM+53xjvnaIbpNinm6Q5aOuk0Egwub/95tgBIIPJe0QQ9nm9ulqEhrJevbxUf/9B+Mz8Eia38AKaZuEv4FfTgGYI2eMCMYEwik/deHNxWt/v0l1rQp0s60PWb8dR/wAKBXQoHqdPLjFDiKIy/ISzarF8hU9KiInqJwQ1IkexfuouV8IF4bZ33g5/SJ+TUhYcjgp9oO9eONNW7rC1U+cigEQX4hE0g9DsYqEb0v89L5EVrJqOM81a9G4BYZ81xH/esHJba0LJTnMdP7cWIb1s5Gu2MMRgR+BhnuZl0+7aeZ2dmOqNmKI4/8qNRJTR5WHTv23nllcCp09HBIL/sBOAWhP+gw9XnsQ+rszPdhIm9+boSIGS9PNWh0urjwy0iu+8jUkrDtY7oBXIWdoHn6HYN3zz+d6axYur2E03KgTE1/iguYEFhqgTJTrcUXyffKZGL/9X0p4nurO0WYqqbgkaplGUOOx9nPHNMQzjzqNDJ4GBAKr/Pt0R8955GMaMrxiUwpNtb8+J4Wh1FC9NfY7rlJMeSF09uvLBx9LCvV1XSgrH1gYnfNJmFSwSaIx4PSBeK9L+PkhETguidJ/6bSWFzdj0NBmn4EUgB1N+2E4nF6qaJXki3yjpNfwZsxIk6QdDI1nPlL+9qfLhFuC+d+CiY1am0vDfOYSiQnE3evc7cxtQ2oLdhTMDtYCLE8aehlxhFQZLiBn4tGOQxdiBtkH/cvXqebILrxKZvwtfTKOdi4qg9gr35PqKqQNUSZB4+U/9gR
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a6NmWcUbKT1kaS6JgSq99iyg4foyhGdP/PqySUPQY0WstBvy8R2LwcYqkvk3+Euf/VLYbxzKw4CDV58wmiyWVdFRHgrYooRP3gFKwuipyKWtWK05KcFrPjoVKbHmGleTAbjPf4KXJYYCP7x88agFZwIVm/qeEopZ5a5DHEeNylTqPJX7R74mqbAnQRqu5WH+FBeLU/YgOsJtWKNXUqJu3JTniMkcVV7l7aCbNJyaA1/g7WIt32wMBxoITWFBqzR6M6c3RW8ZTJZS+mMK1KanILpoIqjGklkDSnO8ByMsVHq6VktRKiuyOF2RULd1feoX8lZJQaQUchYOw+lRBVfl+xAZeWfLSm3za4k32PuLpJ8nI7tymf1jOZKlwafNbX5uD1tgAUshseK+wS4qvBU66jLW4GBCV3Rm1rjf70Y+qzIEPMpli9caV48RMaeBf+b58WTo1WO0MjFkYiCd0gt1vfrLgsVA4zjrIelMHH+pKnloNEmG8UeSADCwAxSWYd45hUxjkx9/RgNh6jEOJpntjyYGmvMXxQVoTjHA9m4KX9k/vQ7d1VsXrLpY3jRGSS0UfsnimSUDzN2rz+wONlayPfAmZk1QoBNCkHV52mP9vcgeCKQnWLRQ5FnXcrX66cfmVmhymXUwPMyOO11bJ3+nBiLOWMLQHaBg3B2Ak7Om4tU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fuhc0yirIiix+XT5tDwNuhC/ukJgA+Q2+A/3Vcp+kzHgCi9ABj+yB1RcXwwg?=
 =?us-ascii?Q?Hz7czmo/HjNx6n9tld9uDaprEVMrx/7HarJXDwhS8oe9rzzqwNAU0SAX1MEL?=
 =?us-ascii?Q?3/zokcc1iXqrGeelxcGfWxp9PUshHhHu18CwxPSnX+5m3a4bbUJZ/gpAk3tJ?=
 =?us-ascii?Q?Sq11MDLsuuWAu9vL5E900ELV4SKCgGwEigJEOLY9czRMNvhZsOvZnPinPT+3?=
 =?us-ascii?Q?9hP82Ez4XPWoNR6qxUc5A9dOlIB0xF2aE8JM/bvQk4cPferzfCrBsRIKSoNk?=
 =?us-ascii?Q?7g4wWWnCRh9ABnnxrZ2QG70v/13TtzoSbVF/h+m7/ZfB1dy/cJWGa2S45tHw?=
 =?us-ascii?Q?O0Ro1Sm4eVSQbfxnffDuPyl5HTcIeK7GuKMLEUivcN0luc9sCa4HKUzIOXza?=
 =?us-ascii?Q?GrXmHQRYn6S7Ii1+3bKARY6ulsmtagtO3CYoYxZo+ErpuqI33XFkbQTKjHqD?=
 =?us-ascii?Q?1e28WUZ5gw6B1eiHkRSoYW0a0ZtaRGLgGT+iWERWm5wDuIXwLEAbrz+t/g0e?=
 =?us-ascii?Q?0Bvl7zwq9co/RdwBo7mfbSWM07q60mxF+ZbhrGsxbK3+32ugIJL6OBToZXtG?=
 =?us-ascii?Q?UMBYh4bQ/KeGJJRyb9S+9EgkZ29D/twah92ksbAN72nOP8SB+ZczY78YOGSO?=
 =?us-ascii?Q?KuSoJttWVx8n6zR4KA6SfIQU+4DPRQCXbKOdYQMQFwbR9QSteRFFMqb3C/NN?=
 =?us-ascii?Q?BaLOOms8Xkvl4vlOwc5KNJ18Hmj+hx9vsllEBH+7Xkzriba3by5H/LMI1yXO?=
 =?us-ascii?Q?RUHWdbukwmGuOub1E8XJrzk+2sbniPkpeJVWfvkXk9TGOVqs/QptTN5sykog?=
 =?us-ascii?Q?STobcR652Wr21e5N3uNXKiyJFhpluFMosFLHZn8cyIcbN6swH9gDjX8rc+UV?=
 =?us-ascii?Q?VGRTmhSnuO786HxLVzsYG1jObMWhVIIzvOPYI53H2vyRxp1f/A1Ue/4OGeNb?=
 =?us-ascii?Q?m59SbahWw5nyP+97JCDGTT0prOgbkgvntzE2Nxl9KsmLkBc82eg7wlAU9PDX?=
 =?us-ascii?Q?03EPkAY3m1UvT+/lMliKoixnhM9HubuY47q6hqHZe0pHFxeIGEuL8xxB+B64?=
 =?us-ascii?Q?ECQQSRa+3WmfId+AZCMo/1JUAldkAQpSDRwArlZ67er/xmAXDMG+E8u6u7m3?=
 =?us-ascii?Q?FZC8FoC+po389Gz///prv0irtBY3wbdbKVATnUuMO/nnMtpXhrBwMxC2ISst?=
 =?us-ascii?Q?DM46H5+/G9kDimvkmzyLGS706Fw3kzLgLjH6X+NqxpXRF6ufNy3yZ0T/lPw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7eaf245-101d-4c68-9b4b-08dc1d8a8abd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR20MB2316.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 09:46:45.1290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB4275

Add the watchdog device tree node to cv1800 SoC.

Signed-off-by: AnnanLiu <annan.liu.xdu@outlook.com>
---
This patch depends on the clk driver and reset driver.
Clk driver link:
https://lore.kernel.org/all/IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1PR20MB4953.namprd20.prod.outlook.com/
Reset driver link:
https://lore.kernel.org/all/20231113005503.2423-1-jszhang@kernel.org/

Changes since v1:
- Change the name of the watchdog from watchdog0 to watchdog.
- Change the status of watchdog.
v1 link:
https://lore.kernel.org/all/DM6PR20MB23160B8499CC2BFDAE6FCACDAB9EA@DM6PR20MB2316.namprd20.prod.outlook.com/


 arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts |  4 ++++
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi          | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
index 3af9e34b3bc7..75469161bfff 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
+++ b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
@@ -36,3 +36,7 @@ &osc {
 &uart0 {
 	status = "okay";
 };
+
+&watchdog {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index aec6401a467b..03ca32cd37b6 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ * Copyright (C) 2024 Annan Liu <annan.liu.xdu@outlook.com>
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -103,6 +104,21 @@ uart4: serial@41c0000 {
 			status = "disabled";
 		};
 
+		watchdog: watchdog@3010000{
+			compatible = "snps,dw-wdt";
+			reg = <0x3010000 0x100>;
+			interrupts = <58 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pclk>;
+			resets = <&rst RST_WDT>;
+			status = "disabled";
+		};
+
+		pclk: pclk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <25000000>;
+		};
+
 		plic: interrupt-controller@70000000 {
 			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
 			reg = <0x70000000 0x4000000>;
-- 
2.34.1


