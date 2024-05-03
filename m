Return-Path: <linux-kernel+bounces-168372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD648BB7A9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AEC51F25382
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DD812E1C8;
	Fri,  3 May 2024 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="O7fQEBAh"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2133.outbound.protection.outlook.com [40.107.101.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240DA127E37;
	Fri,  3 May 2024 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775775; cv=fail; b=T9JHGHqsQz0DBWRWk5iiOYRsX/aoNtHf4/r6A0Pakao3uemLJLOGVeWM7Q8BP5dzmOQlKAjiWcyRj1EG27rhc6L9gFkXOIBv7T/RdwzLapkupQ1mbxpHXjFlMsxLwpWQLT+x3IUSlJQ4qnLjd8PdeiIfsss+u0YXrEECZiV3tJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775775; c=relaxed/simple;
	bh=kEmdIGOF+hQ7w8aOSI9G+Qd8MrBscwqlzQVmDM0jFeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YBb5u5k2nin9Ts/eWQE86vRJGcGPinSKeu5jm43CWSOrBEqXcKcsGWA6tkRJDyEhOv/WyWJjpEunYpFtc4G4YQXyY1R5cBwsq200Inw9nENtE2fUypN96chM6J7bABExluZRuvKxq2GGyERCisuTTbq6jWwHmRy7/XnVB4wlaHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=O7fQEBAh; arc=fail smtp.client-ip=40.107.101.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJScZeVpIqacH+vY04r5uo91wAd4+kUgsx5xbl6uwXa+ITPRt+bWjdoN+gSml2v/YMYGiIYXfR/buiB4EWYcYTOUv961+vYR2NLN7nkot0+sMxDBoRGjlKZUWbjZXvSdEWVZMkf5NxFvgUsGbX+30YWxV5oX/dUc1CFr6Nvwo8M0IUByJNuTEDLz9j68p+WXha/zzHs7SoyoxsJs4jjsuNYN1mAru57PFwXn4N3vtj5trMFHGymHlJ+tc9d8IfD9Bi+zgzu3ZDgTKqCvb55A/alHqdqRN2kb39xqickktzuCr0t4H+ve8hlACWCVX1dr8SG+PDwJhAWS8Gj8OBkdxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRIpdyYQQ83Ocqd4fLpJJf/d+BkIHGJFv/HGlqg9Eg4=;
 b=R2qMyN5VjBsNfNT8dL4cUuND3zwHrkO8z25OYyNKCxIe4G2C8nwSKfzNdcY17XmHKFNI4jJ16TIz2yGS+IgmALZOt8w8HGG5fqqT26OrVJXCi6zJru8/mE/pAdfWvZD8Cdhqbxsnhqiw0GtpTIr4+IX8dAEMkOessI8uXslvdE4RHDFh0mIM8IQlWrm5iOGGVJSAk7nssBsjvaJc6yLgDHQ+jn5J569BlMQ+0MtF5s627L1PU1G+kl/zRo4MOFMABOyalU3QxcHo2M7dxsOd+T1RrtB/i5lUIWqGpgQsrEE/3uuXlJAzxOOzENlhow3eSS6GGQe+IH/9chYvY2t4cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRIpdyYQQ83Ocqd4fLpJJf/d+BkIHGJFv/HGlqg9Eg4=;
 b=O7fQEBAhozYy+rlUr2bZgr0lfbpgbSZwCtV180v/BP9Kt0CikXbtzKxydSHZCd0MXb13g2yErlPfh5pHIdf51Lt+ZOxFhb4oH42oS6NHx6jB2QVu1OnukR5UkXCr6LhgdN4E8jx6he0nCtxvWcGvsKYzzTZb5flyy48foMs3gBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by PH7PR22MB3616.namprd22.prod.outlook.com (2603:10b6:510:1d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 22:36:09 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 22:36:09 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH 2/2] arm64: dts: ti: am642-phyboard-electra: Add overlay to enable PCIe
Date: Fri,  3 May 2024 15:35:52 -0700
Message-Id: <20240503223552.2168847-3-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240503223552.2168847-1-nmorrisson@phytec.com>
References: <20240503223552.2168847-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0056.namprd04.prod.outlook.com
 (2603:10b6:610:77::31) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|PH7PR22MB3616:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2a95e6-3de4-4747-fc7f-08dc6bc16dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|376005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MLBzFieORZzRZtFBOi0o5pwth/8j0fx2KXnjUGEcsxhpFJc74rxxj+c2P4XF?=
 =?us-ascii?Q?ruj0PHHeUlsWREv+GtQkCk1UFAAkowsEAwSuaysW5PZED8rY7LkJ+lmB3XDz?=
 =?us-ascii?Q?JF6FXddnRp0PrPwKn3pI5no/NC/D1Jxpwfhr+f0t+ne89gAOL8+zGCGHktsj?=
 =?us-ascii?Q?e7VSGVESkHlE3ncuVGhY1TzfXsORObnXkNzO0yiD0lmOps/rY2Fw0Ikpe5+U?=
 =?us-ascii?Q?EtoZzxfEr24ls+0L3TIVg7xLelDybOeG08MHpNxzlineVac5kC7WJqyUr9UT?=
 =?us-ascii?Q?5N/12Y8AIQMVbNPjslamDHid7KBwflHZiUJLVi5+ca6c/IAw2wdMYVl8IpIs?=
 =?us-ascii?Q?pB4D/BfiM+LYptjpMNl2MQFuoYBnWiXq8bH7NbQruGk05wpofdbg/vVRhl+O?=
 =?us-ascii?Q?/GBpgULVnxY6sIF7oq0kHyrWuGvXZShdIN+PTqLixh/WWRDDUTtTwYqpKKn5?=
 =?us-ascii?Q?JI3dB0ZDiHsaPl6mHoL4Lgd6h0aIgFVj540ebJmmkfYy5nuVSSUuLK98rQHP?=
 =?us-ascii?Q?V5p7M5eFj1HhXBlPz4wLyKIqBfInvP4cEO+1MgTemIIF6dc9/c5qn6UmH2gQ?=
 =?us-ascii?Q?uoTpnYITObPaSs6oLzIJc2V4elp5YzMCRhHreYR3rcI3svAqYzpMc2vfrFAC?=
 =?us-ascii?Q?R8cSDGPwtpu02IqrDzerDyx02T2do+Nsx25lnNHsqOOKs/dO5vPF/OE+bd/m?=
 =?us-ascii?Q?Bc3SwwwrizxUk9VuY4GUG6LIn+jYsNrtEI8yinBhi6S0atuuB0hTE4jSMCZn?=
 =?us-ascii?Q?aqgS1/gl7BY8JDm1/G2WCz4DrAqXLVv3e9cJ42ZCfgWGyLhdaIDVVA4zxhXr?=
 =?us-ascii?Q?dpFpIUIq8wySEP0CezDxJN01T2RJgWyTQKxKxmujxBaYPB28WGnGjY6oehO/?=
 =?us-ascii?Q?lbmdy9Iu5RiMTD14tln2Q+tjAxmtcoNZYTxngbrsgcTua5AVWz/+qUxdKIeg?=
 =?us-ascii?Q?7KSR3ze3vgsmuZ+55wcMSe52Bx5d/+VHT2kEDF6QmsLce2Lefm9D9heFmm17?=
 =?us-ascii?Q?KLS2NHI7jcYkFXWsmtqt88grM3btJg+8/bQV9QXdfeVcfwOcsxNpSg6TA+hq?=
 =?us-ascii?Q?+eieQ00RxYmBbOFZRgf3/nRY9qeQjnu3uFupAAm6qYEFUsS+FxeR+MRKSGSW?=
 =?us-ascii?Q?wFPbpKCzvjbuZ1p6HDMdGtY8QWswJUo/NVlaCu/eSdvO+DLJ+M/TyKOGRe8v?=
 =?us-ascii?Q?uo7VN7nkerAzbh+3ea+TM5zhXuJ/EKLNYeY4fsJtDQw5g7+Zx7qOGWLLVpWr?=
 =?us-ascii?Q?pBX2JBAvsk8woowZFIVD/icrsIJt2e7M5xrQfN+Iyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gCg0RjEmdJCbQnyPOloZxCgUurDDHq6Xjrww4BPKxh3W+92fGCyk0OSgY1hK?=
 =?us-ascii?Q?aEStJUhLBSloHmrkP2ZGn+dEJMV2pvR6fU2PoIl0lnoN33qiT3YX/938d8AM?=
 =?us-ascii?Q?ET0SQI8ux8ETORTxQDP5DKAUvDQ/oHJPfnaTVhoI9CjHq65AfeuA7MqHbmSb?=
 =?us-ascii?Q?7vBFjKdOxnwcOaGmZUQObu8TYcDsNv4bLwVQWQgCXIo8TfBn2gSnCbaNwDZL?=
 =?us-ascii?Q?pM+d5P1/pa3plN4X9X/9PZDZYQzc0fC0EqkOIJBo0rvaGs+CRktcl6oMXZIZ?=
 =?us-ascii?Q?IEOmpXtnQA4ww6NeArsU55qLmGgobU3xlvYtNre9uBiyIIqOnVL7nNdyLn9K?=
 =?us-ascii?Q?xj/bzg4fjEIvqkAZ5v29Fsep2tSQjVH4OH/DY2lpdC7vk4hWidnXOurfdWzx?=
 =?us-ascii?Q?M0RijA2xZuKQgDEpnyEX5LLgtlkZWqMN7RvJfvTU0KB2x2/QkfgVeRsZxhRF?=
 =?us-ascii?Q?BLlPNQjf26m2BQCTr46fnjwzxe0l4CvRCz6SAUpoGFYzjZj3ttyvRK+QWAfB?=
 =?us-ascii?Q?lpjvpQJ/wkl3fmD83VSQsxO3ZCQ1+4x0/rsn/mt4Kti0Vfd2531Z/OumoxpK?=
 =?us-ascii?Q?QAkRZ3d/iXjVw5eqflpoyUv+8zLj910JMDg4JFxi5mK0xutWefMPXSldNd65?=
 =?us-ascii?Q?gDdCEo1atcSBSuOJ8gdIb35afiokK/+eCqC0Sey5uWzTKAUR4n4ZxVxqZlvj?=
 =?us-ascii?Q?i3kaejVkUYlmEnmIl1mHOS06fP5DZWgcR4rJabx7ELq8aWNNg78lfV0picyk?=
 =?us-ascii?Q?plSdsf6gJvdHMKtpU0ndIztLJjVSYlnQk5cw7eqOak+RlJ2TiQbvRFQbsxi1?=
 =?us-ascii?Q?/LLYJRB/LG3gP6jcKhsocjTb/8LarVe44vWm8RdFgxO7hX2M6H7rWm8eGig0?=
 =?us-ascii?Q?kofw+5D+EuXmprZlRa5jf/dEj6XYDhQJ5QjETiaiqsviEzRh7DE8oPnl5RNd?=
 =?us-ascii?Q?+GZzSscnNVNjv6rRfTvAign4kOl/q/wCahhXCIoqiMuR4VW/6w9RIojyLQO6?=
 =?us-ascii?Q?hwXl7z6SfBTWHimczNQiiwLScb3+3cHuo5l07PadnVLiUi5TZDuCQgRCJrCt?=
 =?us-ascii?Q?ZHq2xXUjv5g9c9Ir1etVvZwz1TPBs7QY+fPC3pgSeo+tvjHyCovGekYQusKP?=
 =?us-ascii?Q?26U0fzbsJKbdBcifm9R7M+iQsjN3EBno2sfRR1PKSIFY3ASeOupoTHV3PvcF?=
 =?us-ascii?Q?9VLW/z87IFyzacisuJCZNpRPP0u6stRqURfWv7/nbvay5Nz1zIHabO7Wl912?=
 =?us-ascii?Q?9UMx88m5w8RMQmOu6lDPTsDZXcxnsd0Q4dxf+QJpZdeR2YM0fiRhGVaRzDZZ?=
 =?us-ascii?Q?I4treszJbaFUclvM0wum16dxWZ0OC60GypTzxcul5Prb2OQjSA87j1vlCOUU?=
 =?us-ascii?Q?mqwCIbwywQixddbgkcTly3qjpjz305UrwkJZq0Dkb2VQRsdi/8zKyMRlqjm6?=
 =?us-ascii?Q?8zgAdDQdOSUPRU1IPH9gl5n3Et0LNWQ9H1iIwdmYnXmyesHo9Dk9+8ZOHebI?=
 =?us-ascii?Q?a9Ck6+65brbU6/pTjXW7FYdR4ELPWXF86PgbwQzman+rH0Dx0fke2tPojSJY?=
 =?us-ascii?Q?KE2pgyBYYhgBuOUvOKZIOhFzxOP3syPo0HIyhnUR?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2a95e6-3de4-4747-fc7f-08dc6bc16dab
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 22:36:09.3821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKL8YcoKOqKPYgZHTNWrCFUB3S4PaDIxYyCqAcQ68SDqHjWHFfn5+mUZW0GxkwUSiiq726U5fyEe5KXKrW2dvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB3616

Add an overlay to enable PCIe on the am642-phyboard-electra. This
will disable USB3 and restrict us to USB2.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  3 +
 .../k3-am642-phyboard-electra-pcie-usb2.dtso  | 88 +++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 9a722c2473fb..6a38ce2603af 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -48,6 +48,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-pcie.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-usb3.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-pcie-usb2.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
@@ -131,6 +132,8 @@ k3-am62p5-sk-csi2-tevi-ov5640-dtbs := k3-am62p5-sk.dtb \
 	k3-am62x-sk-csi2-tevi-ov5640.dtbo
 k3-am642-evm-icssg1-dualemac-dtbs := \
 	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
+k3-am642-phyboard-electra-pcie-usb2.dtbs := \
+	k3-am642-phyboard-electra-rdk.dtb k3-am642-phyboard-electra-pcie-usb2.dtbo
 k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
 	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
 k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso
new file mode 100644
index 000000000000..03fc81a6018f
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * DT overlay for PCIe support (limits USB to 2.0/high-speed)
+ *
+ * Copyright (C) 2021 PHYTEC America, LLC - https://www.phytec.com
+ * Author: Matt McKee <mmckee@phytec.com>
+ *
+ * Copyright (C) 2024 PHYTEC America, LLC - https://www.phytec.com
+ * Author: Nathan Morrisson <nmorrisson@phytec.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-cadence.h>
+
+#include "k3-pinctrl.h"
+#include "k3-serdes.h"
+
+&{/} {
+	pcie_refclk0: pcie-refclk0 {
+		compatible = "gpio-gate-clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_usb_sel_pins_default>;
+		clocks = <&serdes_refclk>;
+		#clock-cells = <0>;
+		enable-gpios =  <&main_gpio1 7 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+};
+
+&main_pmx0 {
+	pcie_usb_sel_pins_default: pcie-usb-sel-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x017c, PIN_OUTPUT, 7)	/* (T1) PRG0_PRU0_GPO7.GPIO1_7 */
+		>;
+	};
+
+	pcie_pins_default: pcie-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0098, PIN_OUTPUT, 7)	/* (W19) GPMC0_WAIT0.GPIO0_37 */
+		>;
+	};
+};
+
+&pcie0_rc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins_default>;
+	reset-gpios = <&main_gpio0 37 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes0_pcie_usb_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <1>;
+	status = "okay";
+};
+
+&serdes0_pcie_usb_link {
+	cdns,phy-type = <PHY_TYPE_PCIE>;
+};
+
+&serdes_ln_ctrl {
+	idle-states = <AM64_SERDES0_LANE0_PCIE0>;
+};
+
+&serdes0 {
+	assigned-clock-parents = <&pcie_refclk0>, <&pcie_refclk0>, <&pcie_refclk0>;
+};
+
+&serdes_refclk {
+	clock-frequency = <100000000>;
+};
+
+/*
+ * Assign pcie_refclk0 to serdes_wiz0 as ext_ref_clk.
+ * This makes sure that the clock generator gets enabled at the right time.
+ */
+&serdes_wiz0 {
+	clocks = <&k3_clks 162 0>, <&k3_clks 162 1>, <&pcie_refclk0>;
+};
+
+&usbss0 {
+	ti,usb2-only;
+};
+
+&usb0 {
+	maximum-speed = "high-speed";
+};
-- 
2.25.1


