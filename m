Return-Path: <linux-kernel+bounces-60820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2108509E3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82891F21C6C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CD15D48E;
	Sun, 11 Feb 2024 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="GhnlCmup"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2122.outbound.protection.outlook.com [40.107.15.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3C5C8FB;
	Sun, 11 Feb 2024 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707664088; cv=fail; b=AGVn6c64ZcqjTMypJR7fKZrKwQTIBOla89K6s2AXAfW0byAtQjPH6j8vu95hajBh3cLi8dHKRantt+Ez3PsJ7qYH0SmETDwGYic9tz3In8qIrNq6fO8iRcAKU9cf/3QnSbw/K1YF+swa7yQQzEuvmgovTuXE7UcQ6ErC2cVIZXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707664088; c=relaxed/simple;
	bh=92ZVXW4YC6ZPcqYAGAxQaXNVAjywr2YsXrwp1M2QIBQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UkJyJckVGmzYkUFe1Kem1/pFNkoqaQ+xN3RYAJPkBYwZvxC4dVMx+lVekwuQ0McgS5eeejzfPaIhDI2JMT/MYmzo1Z4op5RdN4lE8rcu7HeWDX2guhLkcbaQT1x/+z9ibSRxH2twNI9iv6sQztrwraMYnYrxWTfkagOpl7pGfWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=GhnlCmup; arc=fail smtp.client-ip=40.107.15.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmosyrB8K6qDq+50S0sZvRbymSgoWYLIAYFVXwsaZeklJtXIGE0pU+50/cvuDhzxDAWfnqV074UY7zu62m2moybKvCLVhLn7/maoh3yHlHGdpmNfh1SqyhnCHNf0BD4OWsJ92nfnjMaH4pWWRADI6GxFo+6f6crTakVLOprorFiobIW3+bEV/aiblPZOSfOJ7speQQgK/aoIutt9nKU41p4jmukVkcnZas5CLLnbigtz7I7p4ekY2HldlkNfWNZAhPsRej2E5JYDE1zxtSooBC26EyZcX+d27m5nfMt2g3xCT5LRgq7iBV2jfuClCAhzJjIASDzBiLbk4nVcLUpbiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAVYcajPH+cQj7PkDwcqf/iS4zG1WdQUnJL/lsNg9N0=;
 b=YPHWeRyjRpHiW6KHT1TvrmI8oG4bfH1bYxrAdv3A3VmftSdLPLruKoPugvfAjuKn5JaIwMPOqE6b4tyWJlbm6dFvc4ugoQmMf8WX7af/ArOXq0ctTnUP7P+sQHuM1aXB/l4HcfpYxrVKsQiF1FtbcE/W9Hh7FewujnJ3IWOli4arXb5hZ4vM2AAO/iyMvpS0wnsZhdKZ4qMyIWipufVEVK7lvQJ188dKzzn3K7+6BFTsqBgw8PQl9La7vTBi1hv82cDUHhfWpNQ0IbkwG+uBJUt4s7GbNwkJ6RvplsC0zSUpzxs92gpmnvvqnlGTS5AwhHSqXaR2qG7K9eOvcHFCpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAVYcajPH+cQj7PkDwcqf/iS4zG1WdQUnJL/lsNg9N0=;
 b=GhnlCmuptVqnt7UA69CYmGLJrVPezwQj4HMB2Z0CXSDLEqc1xhqhDM5hTUPwRFNH+UV6pgU8aUE6avNBrVlir3oi4IR0CdlS6aDnmIMKaY1K2b5L1zWKI5rB/crxb7d74uvX1hF+VMF/e0XAQgtzg/BxE72H7u41t3GRRWerJxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB8725.eurprd04.prod.outlook.com (2603:10a6:10:2dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Sun, 11 Feb
 2024 15:08:00 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.039; Sun, 11 Feb 2024
 15:08:00 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 11 Feb 2024 16:08:00 +0100
Subject: [PATCH v5 5/5] arm64: dts: ti: hummingboard-t: add overlays for
 m.2 pci-e and usb-3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240211-add-am64-som-v5-5-790ed7121249@solid-run.com>
References: <20240211-add-am64-som-v5-0-790ed7121249@solid-run.com>
In-Reply-To: <20240211-add-am64-som-v5-0-790ed7121249@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::19) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DU2PR04MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb83a50-5f82-4503-e70a-08dc2b133ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lyfZVyWxW1u0EgnZWZRlqBOOrXjlSQxC+FdMYQhyMt5PPWExMICJUrsX5eOcovpPfzhj8ODoaU2KJSFO1srqVKmk7Y27jIDPnezCFw8xJ/XS/DgXtDLihNofTx5qgZqbxyR9Rs2spoNiBbAHjeUjBZJreio/vF8jhAHBF5DE6gJSW7cNAS5+qhBlXZ4g5+MeQGXQKNpwNwnCYy4p2FF+N1dX6zhsIpWBk7vVkvgnnULQoBAQ38KI5kNGhOUGO6cFsEq7GftU+zAs/Zj9OKLv3zKpujr5JTA2hm82MsKdp6+9SA+f4pihwl3uKs9YhrsTe0GyywReDBXanwejnb63mmaB2DTC+uNZSYx1wPdM6/6sCzF7ncTaPa1HU/2HcNvD66b2kwze1V6YrvgFdK5RWuTGBPoG0wB/rhnjyGLDoyBGYSU1I6LRiwToIJqAw1RtJ2RZk59lRLb1sAJTeQ3FCKDFi2PhsAkux1cMiatm7Y3Jg+R2OZEXq/LjnC34QmZC5rfqgLe+o3DMroIPeRmTzA7zAQpH55C9iOTgOIpwOguyUb67um0wcXZdJ0Q9eoE3TrTBJ651mwUg/jXprpZmhDeHZe1GZioFlKrhLa7SW8PK/eND+9u+j6W/0jeB+NVP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(41300700001)(2616005)(316002)(36756003)(6512007)(6486002)(66476007)(66946007)(8676002)(54906003)(478600001)(52116002)(6506007)(66556008)(38350700005)(4326008)(8936002)(86362001)(107886003)(38100700002)(110136005)(26005)(5660300002)(2906002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THhYSXprUmw0R2VrVjIrUG8rU1hiZDRVaFJnTWg5K3dYd3dsTlRkZU0vbUZm?=
 =?utf-8?B?K2xxbVZqazJsRHZoWmt0bkNnZWRsOTNJdGdHNXd2TDNIdXpOeU96TlFyTHJo?=
 =?utf-8?B?Z25JNERRZTNMNkFvdVhzVFJVcFRZTkVVQVdObTc3YU1lVE5hOHJNYlU1Wlc2?=
 =?utf-8?B?M1BmZ2dPUTJhK3R3WjJTK1FNc2xCdjFQaFh3YVAydnN0NkdBbFFHNjFYVXhu?=
 =?utf-8?B?WXlnUmZKRmtpaWp1YkxQL29CdXRLVXZMVGRvVU5tQ2RQSzZKbUlCTDFuQkh2?=
 =?utf-8?B?U200ajlpQTh5RGJyNzAweTNYTkc2bFhzSXJCZ2Z6K1cwSEVaVlJtNWdKOENN?=
 =?utf-8?B?ZGFlYjU5ZHh6dXA4am1jWDcvRko0WDdWUkN6RHU4VEpSbGZGZUwzOUtWNlky?=
 =?utf-8?B?Yk1pTGxPTHlrMXdldGwzOUxLSmZPazR4Y3ZNcEJlZmt0WlVpaVZrSjlJZUNh?=
 =?utf-8?B?Ui9ZS0w4a0NnVDkwRkdWNzNwRlhGaEtVbzRrTUhZdnJGcnlOaUpmSC8raXFR?=
 =?utf-8?B?UUpYemY5bjNaNHNCdE94aG1hVkk3QlpOZ2JPUStsT1lwOUY0ZUp3ZTVIMGZX?=
 =?utf-8?B?QTZkRlAyOTlBeDZaWTFoUUdla2JreklUV29ka0QwTkdDVjFwbjZWcWlyYmdJ?=
 =?utf-8?B?V2ZZNUdRUmdhVXBqUDBJOStzQXQ2N3JwdWRkZ0NFQi9ac3piMWErOGxWNnpT?=
 =?utf-8?B?Qm5iVVY5aHJvTFRYeFVLeHpxYXVrRXJoT0NDREliNG53M0ROaC9MQm85MGdn?=
 =?utf-8?B?cjByVnB1dXNUeTQvM2svUlRiMFFRRzlueGIxVmZZMG8vK2xCU1JLdFNBK3cx?=
 =?utf-8?B?YlNBVVlSRGpETVBHYzcvelBPK0pyc1J5RjZSeGgyN0g5Z0lTbWtEYTdaM0VY?=
 =?utf-8?B?dkh4aFl6TlBUWXZTcnY5NnIyRmVOWWNaZzVwYjZjM25YTHNrK0hRVm9NdHcw?=
 =?utf-8?B?K0JkZS9NUmVmZTV2K2JLK3ZFN0JBK1NsWStMSGZQOVA1V29XaU9LNEtoMzNN?=
 =?utf-8?B?YndiNTFKelk0c0NVTldUeVFTcWRGZGc3QjlxYUdXNE1vTDJQVURaRFpKUC81?=
 =?utf-8?B?OE8rK2tjZEJhOTNucDYyZ3BsQ20yL1NHUUZSV3NtclZuTEpicFcwSk5aWWpN?=
 =?utf-8?B?V3FsYVQwS05kL1hSWjc3MkZwM1NSdWY3K1R0RThEQzkzb0ZDVzU5VlZlVFpZ?=
 =?utf-8?B?L0J4V0dqOVFzYWxYbnBzSjVnSWYxczN0R2Q0UHh2Q3BrU1lIbXB5M1pMdCs1?=
 =?utf-8?B?cnpmOVNIN2xsRzNQR1BXSzIvYTl4bDdldWhVbXg0aWNhQ2dvRXNIc09ja0tt?=
 =?utf-8?B?TXJwdUVsSlhkcmVqcmxHdTV5dE55eDgvbWpRTkxEQXRUUWhWQ1AzeGx3NmND?=
 =?utf-8?B?ZkZkQkZhZlE5Vm1JV1Rub20yd2h0bFhka3NOTHpGeWZyMXNkUFY2SVdZRnIy?=
 =?utf-8?B?WlRBMVFkOEgvbVFOWkxUa3BjVFdqNmxEREZSMmg1SXd1YkJKNEJITVJLMytQ?=
 =?utf-8?B?SUsvempmelgyaXBhNmFzQmR2WVZ6WDFwUm83OVdxZE5oOG5nazQ1ai9aWlJ1?=
 =?utf-8?B?dUFkSDM4bTBJR2VhTVhsQUx0bGpyY2U1YjJobzU3czluWGY4d2V3L3ZOcXF2?=
 =?utf-8?B?WWQ5S2g1M1ZMNmlVM2RvZ2E4b1VxMWc2VmlCcWpuZk5WK3NKcmtna0M2TWp3?=
 =?utf-8?B?eERjS0tXanZoZHFWRkZPU2tEKzhPd1dnNlcyRWNNamdQWDB4QkhSNHFMc3cy?=
 =?utf-8?B?MEVQMW9NQTJkZzAycit5WVk0dzV0RG9WN2NFRWlpb21YUm8wZ25BaW5NRFRO?=
 =?utf-8?B?VTBuOHhPM0xlcWpxektwT3pyWGhFTnRrelN5MkFjMzhEd1AzVHpBbHBydGc1?=
 =?utf-8?B?eS9iWFNHaHFNa0U3NFF1dnpvbFZmRmpoRTh0THo3MnpXMm5ZUU4zSzVtL3pE?=
 =?utf-8?B?T2dVOUpCZWNyWHN1NGhTYjFVcC9SY09jS3FXUmVMTnhoeXNMb2xPeThrUkxN?=
 =?utf-8?B?ZHVaRmppSGI3QkN6SWszSE1DZHNBdHVaeldXRW5EY1pBOXBQQnVBeENJV3RR?=
 =?utf-8?B?RmJsZU5MbWtFbjJDd2VKRTEzdzV1RWk5S3g3Vy9Rb3lDZ3pRWTkwZXYxUGVD?=
 =?utf-8?Q?gyy3BYbfFKDJEfs4Oqdo+Gzxk?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb83a50-5f82-4503-e70a-08dc2b133ced
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 15:08:00.6943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yp97c3lFsUKabWCXVnVRree9zmnOMiYe4Xb2/Yp2lIk6Je6RitoL91aQjaGKPr66yGBz/NzhYCZ1fiACLai1CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8725

HummingBoard-T features two M.2 connectors labeled "M1" and "M2".
The single SerDes lane of the SoC can be routed to either M1 pci-e
signals, or M2 usb-3 signals by a gpio-controlled mux.

Add overlays for each configuration.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/ti/Makefile                    |  6 +++
 .../boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso  | 45 ++++++++++++++++++++++
 .../boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso  | 44 +++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 041c3b71155e..ace72b4b85b0 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -31,8 +31,14 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
 
 # Boards with AM64x SoC
+k3-am642-hummingboard-t-pcie-dtbs := \
+	k3-am642-hummingboard-t.dtb k3-am642-hummingboard-t-pcie.dtbo
+k3-am642-hummingboard-t-usb3-dtbs := \
+	k3-am642-hummingboard-t.dtb k3-am642-hummingboard-t-usb3.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-pcie.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-usb3.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso
new file mode 100644
index 000000000000..fd3f8d00c56a
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
+ *
+ * Overlay for SolidRun AM642 HummingBoard-T to enable PCI-E.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
+
+#include "k3-serdes.h"
+
+&pcie0_rc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_pins_default>;
+	reset-gpios = <&main_gpio1 15 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes0_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <1>;
+	status = "okay";
+};
+
+&serdes0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	serdes0_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <1>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		#phy-cells = <0>;
+		resets = <&serdes_wiz0 1>;
+	};
+};
+
+&serdes_ln_ctrl {
+	idle-states = <AM64_SERDES0_LANE0_PCIE0>;
+};
+
+&serdes_mux {
+	idle-state = <1>;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso
new file mode 100644
index 000000000000..ffcc3bd3c7bc
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
+ *
+ * Overlay for SolidRun AM642 HummingBoard-T to enable USB-3.1.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/phy/phy.h>
+
+#include "k3-serdes.h"
+
+&serdes0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	serdes0_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <1>;
+		cdns,phy-type = <PHY_TYPE_USB3>;
+		#phy-cells = <0>;
+		resets = <&serdes_wiz0 1>;
+	};
+};
+
+&serdes_ln_ctrl {
+	idle-states = <AM64_SERDES0_LANE0_USB>;
+};
+
+&serdes_mux {
+	idle-state = <0>;
+};
+
+&usbss0 {
+	/delete-property/ ti,usb2-only;
+};
+
+&usb0 {
+	maximum-speed = "super-speed";
+	phys = <&serdes0_link>;
+	phy-names = "cdns3,usb3-phy";
+};

-- 
2.35.3


