Return-Path: <linux-kernel+bounces-142513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8802F8A2CA2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A7C1F2263E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6FF54FB8;
	Fri, 12 Apr 2024 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DFqkmnV2"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF02352F70;
	Fri, 12 Apr 2024 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918376; cv=fail; b=S0RMxtJtrIflSHjQj+VHvgKy6sXz3AozYufvoknOWniZUuFOJsYv4Usa+5rCzpsWR6YTRZM8gpdvJSD3KQ30vzliqlEgIkK5bNIUUCsbIIaCqY1FUDk2IPiCTenJ1GwiOfIeiUVcIQeMMPszdD/JjpsTlo4rsWvvE4zMz3ZYLfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918376; c=relaxed/simple;
	bh=QIhq+ocueF1LeZvW5rQTLFzTlCPA8Qve1Wsc1/vPUhQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=U5Cu0kd2o7KvhiMP6RKh5kIXiuVPJtHn20c9i2rtsxyjsmUqWYoWyAL7A9cfBfI1G60F4c+qasHBdmldCbeU8uezi0uyUph2DcUhF8tVmM4ukpsmCXircizz596JjB6NEs1jO5wDzdXnxPeegArI50zzKy99YvJS9p2XlRArNlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DFqkmnV2; arc=fail smtp.client-ip=40.107.7.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkzjcNSyOuXV9ia1YXS3sQN/Fm2dMpEfwyQYXXta4YpK/PofdEYteotov4Cwwh53sv5WPehQN1x1nfUVpNLkRe9QrrsOJEeXSvF79o5iOHgcI1RueV9XaZ46TUCLi/nsQPG1xs6qVo6B8HR+bf5SejG7WsE3qcwgF7doalQrlwMEclAyIG1k0khdAX8D/z6fY/CQanL53O8vdef3X8IUgJMJvzTzSWR0iBGfJTYMx21yg3jdSOGQxnBqrie8gf3/xMNhLwUNevPVDAUIuDRNkX1IyFbGzhxRYkKKYrS3PireKUExjHPVxDMQWj/lR6ZW414Z++RRdsgd+KKM0ec8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMGmxAgESxq8nmoUSBxt1fXYHI5yhImMshqNAZOxHFo=;
 b=mexdeqNXsQ4WZ12H6ZUW5A6c3i4iM+K6kwHFRTrwitZ54PUOubz/kXaWqcAfaRWzpEAWgSWJSLl1/VJ8dbRI1EJ4rDQvmQ3u0wumBpYdTIawbv8AreNGRkgQO9zR/zzm53wlEE3YgnC0PiqG8J5PwBE2Fs5wpyh6fhlKJNqsM/q8jP9l+X11mnBo+4gL/BeSIErE4pRQs5xf5nA0S1GBvX6x65XYxNYP73GQz/yUpRfYJTmyzCLjkx5zuFnKpwt1bkQWB0MwuSEHyFaHCKz1xrdK43fBhnTU8VUtNKw/OW7val5avqVSNn1wE1QAMiDkWGWMSWC1keQ1AorOt9Hy9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMGmxAgESxq8nmoUSBxt1fXYHI5yhImMshqNAZOxHFo=;
 b=DFqkmnV2iI4gmSdmUE8j+UVBIDCLurBYsxYKzCQaq1YdD7x3u7d/vAtGxc3ten1aTvvkMZRSz3yJpQi1O+MBEl+EUTQrzGNr6QAXsMoe5ECQlgvirgUVRurBvDizz7+FIm1Op/WZOsINaWhZmr8veVDnE+U2bNshrSA90K8k8Ys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by PA4PR04MB7839.eurprd04.prod.outlook.com (2603:10a6:102:c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 10:39:30 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54%3]) with mapi id 15.20.7409.039; Fri, 12 Apr 2024
 10:39:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Apr 2024 18:47:09 +0800
Subject: [PATCH v3 3/6] firmware: arm_scmi: add initial support for i.MX
 BBM protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-imx95-bbm-misc-v2-v3-3-4380a4070980@nxp.com>
References: <20240412-imx95-bbm-misc-v2-v3-0-4380a4070980@nxp.com>
In-Reply-To: <20240412-imx95-bbm-misc-v2-v3-0-4380a4070980@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712918849; l=13198;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=WZBtUso1mE3eWFNA1twMIBVrsuhSBdnlpopJT1V6HAk=;
 b=VWqF9riEFNtd1okundJkNlY+t6exXm3cQcu50mD+QqpVu42kCG+bzZ7nezqvcyUi4OgvGG6cH
 uSrfJHILgj4D7KJIUUGGQyvZXzSNht78OpMXmMpxnj6lshNnu9MYEPW
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|PA4PR04MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd98dc1-2ecc-40d3-08af-08dc5adcd57b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1woqoi0HYVBszaXYxbISV5nPMtyASzeDokGUNvP+3YgxzoHanSQrmjpW0s9s3DjFYNkZ6YB2lFypVRQ9PshUUkvL+XmXZ1YfkeEG+CFVcB88OptfiBdxIbBSPVU3XVP9AXbKFf52AKMwNwAN2RYKLRyNYcbQDKugoRmOLksU9Ij5Lz7aC/Qf6CbY/Hp4sHcHIowVsEhtfxxDU1jV24fyYcLu65SB26Yq1m7Y1SvGnJnb1QuqARktli8Jgk/BFvf/taSSkXfRwJGil9A+Vk6FoWb4GZlKnla8m5XGyt06QZbQDYO0Mmvpt/G+GNLz8ZJf8k3Ag3jsPQpQouwxTMIQGI9DUGFKIniNNJ7bA063epDW68iExd9ZZ5pKSlq/Vhd68gYq1VegpZ5y/rDVdMsf4NIZ6V0TcLnMl9pEIUylN2RcgItsjo9P0ObLgZbxJlXcih2uCMRYqp348y2EJrUJx4zFKLdx8XGNCbB2ZIUoKSw1xSLzAgzZXgUOWOLSp7Ju+r3V7iKYj9jqw8MRFKzZ1DA+tHD7RTgvnLxq/GRMzE5bRm8xUkztVrFlFJFVrKTe/yQ/RfYqDHCXiGBwtnK4mpRyup/QQJ+oXi/hCuBmgdo1/ln7WZZEcqgU4AAnizAa+m+ZYR+B5KHjNQ7ROv6ZwaazAbHBvEkJJeStYAUQSD2+sOph1koiAsNK3DsXIuPb8wODOkGjBKzrUdd2/rWXn9qAQJDaoUtth2a8pqrPa6w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHkrOVQ2TCtqNGp6bWhEYXhpajlib1ByaUlBQkdLODd2Mm5DOVZLSUVUZlN5?=
 =?utf-8?B?U2ozUi8zM1lIaDB6S015VVR0eTdhNWZlb2tPbFdZTHZsWGo1dU9SbTQvM0lF?=
 =?utf-8?B?QjRIL3J1RlVGOEVMUFRrMXFLQ1Y1aXBYdllwRE8yTDJQYTJObzNzdElyNzdj?=
 =?utf-8?B?aWhtWjdKZWRTNTIwQ2RTcXZhcmxqU1BSby91QTRmTXViREs3dE1LQ0pFTDNG?=
 =?utf-8?B?WHVZbDJyL1c4S1BVZE8vbjR6SXZZczdvSERBdVNFTmZrTWdYT053OHZNNGJ0?=
 =?utf-8?B?S29lOGNvdHlUWVowdWdoYmxFZXBNTGtnNy9EdmxLL3FQM0pQanNsRkd0QU9w?=
 =?utf-8?B?YkI1bi93d29zcy9mSWVNcGh1SDZXMkNzOVR3MityaFhYSDdlNTl6aDVMaTBL?=
 =?utf-8?B?U0lwTGljbGFObWJKVE01N05iV2pMdnB4L3p3NGNiWVMvYUxZSUFTQmYxY0RI?=
 =?utf-8?B?NXFQclhoK05NV05IWWVHNi9jdm16c2VzVnBvdWloTllGeDJhYTBmQWZBQ2V6?=
 =?utf-8?B?aTEwcUVHWHNZVnlXa05iTGxnV3RycDhCaWY1akdjcS9iYWQ2M0RMMGFEVERw?=
 =?utf-8?B?c3JUSXpkbzFuQ0tyb0FmZ3J5NHlMRTIzbHFzYmVycFdhcnJsZFhqUkVlVFkv?=
 =?utf-8?B?RG5GdEV3Q2hFVTIySWlJRjQ4NHZXVmxpNnBPM2xyT3hEREUwdXRQT1RHOTBY?=
 =?utf-8?B?bkRwV3NZNkM3dDlLL3JKbUszdmR3ME5OY003akk3b2IzNXluUDlNQWdTS1Nm?=
 =?utf-8?B?TUVJMldHR05odFhVSTZ4clo1Y3pQTGZXSHVuQTIwSU8vYzZSc1BJN3F2NGxY?=
 =?utf-8?B?Y0M1WWl4MVdSNlkwTkw5a1VmUnQrSVhPMDZTMUtzcjhpWGdFc3BmQmdIUWhK?=
 =?utf-8?B?VW5HSmxrY2JnZWFMUzNFeUZmR0hLNDJHS0xmQXFTaDhuUWlzZ2oyeUdHMXJQ?=
 =?utf-8?B?djd6eXhCeTVnNmdZejhLRXN1NHl3RXE4c1hBQS9CeDNtcmJubWJXY2pkRWpV?=
 =?utf-8?B?cGoyZUlpTm1WWDNTWDN1Q1JvUmFQV2Zka3JVZmV6ckNJZHFpVjNzTmlOL0ZN?=
 =?utf-8?B?SkxTZHFBb0c2NWxjRSswRXlHck1LWHQrSE5OQnRIS25jeFhEaUVVK0ZQVXhr?=
 =?utf-8?B?OWxFMnBwT2s3WkpJaU9XQndDNEE0WndmUlA4UDN6QUJXM3Z1TFY2aEwza0I2?=
 =?utf-8?B?dWRhVDZuTmxyMVk4Z3BXMUlNOERCb2h2cjhRU0NmSzI0b0E2ZDFFSVlkSUN1?=
 =?utf-8?B?VHFWR05RSDRMSTI4V2dtRUlzS3pzWGNVVS9QQ3IwT1gzNFBaU2FnWkNhcjFt?=
 =?utf-8?B?Q1JMTlBQOG94UlpwR0lhN3k0Um51enk2Tm1yWXdUTGN1enVtc24xaTFYMWZ0?=
 =?utf-8?B?TzZ1Mm9tdUxTYUdRVEpWUmJRbkh6dTNQK2hBbWVXYkpjRFNkNFBNeDBIVjVR?=
 =?utf-8?B?WDQ1RDh2RVhTdkhuelNnN1N3bFQrWElMMEhuOEJPUU5ac2FiWTZ6S0dXNjFu?=
 =?utf-8?B?c2YxU0FsVW8vQWdpbDd6ZlJPc3dobzh4NUJBZDl0bC9nemQ4L0xObzV3NThK?=
 =?utf-8?B?MFNSUkxRNnpuT3Y2WnhFUzJocytET1BCR09zbmc1cUVoQjZHM2dTR2lLTmhp?=
 =?utf-8?B?NjM4UmZRUEw1ZUFLRk9yRTBVVE1LUVZ6MkR2ZHkxVkpTZldvL2N5am4vS1JW?=
 =?utf-8?B?R0RnbVpMcXU0clBvemZMdGtjUG5rTSt0TktuVi8xUVN3TmVwbTFJbnl6WHZj?=
 =?utf-8?B?MFgxdC9SQ3FrUStuSWJxZS9TcUsxNEcyc09tWUxLZkRJdEVZalVzK25lRkZS?=
 =?utf-8?B?Mjh3ODRKOFVvMUlOMUhoMW1pb0ZGMkVyWWdWdzVhUmV0SlRGa1JsWHI4RUs0?=
 =?utf-8?B?MWh4QnJOUmdQWGZuTllGYlh3elRIT3NzdEhSV3cxckpRUnVEU3VvV3RuMmFG?=
 =?utf-8?B?VzZjYnBFTW5qbnluODBSelRNc3Q0bk80RjkzR1RGcmt6V253SlJTMWV1SmpG?=
 =?utf-8?B?MXk5amFCZzUzM3IvRFVyVTRyMEhpUXF1UEhlZXVyRDUxdUQzSTVFbWJKZHd3?=
 =?utf-8?B?a05Qekk1UzN6djZMMkx5dU5WQlNYTTFwdGxpa3I3dm9teXlGSjdOSFg3Vmds?=
 =?utf-8?Q?0PRuli7PIhkj1ln0RmD5MIE2r?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd98dc1-2ecc-40d3-08af-08dc5adcd57b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 10:39:30.1978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cp5jBgEEyAKqQsK/Ep+8ElMB2VGeI5OcygoqZ863FYd617EcYVpvgWksyJDD9uTgP3/iBHRNPYAF4IOl7SP5eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7839

From: Peng Fan <peng.fan@nxp.com>

i.MX95 has a battery-backed module(BBM), which has persistent storage (GPR),
an RTC, and the ON/OFF button. The System Manager(SM) firmware use SCMI vendor
protocol(SCMI BBM) to let agent be able to use GPR, RTC and ON/OFF
button.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/Kconfig      |  10 +
 drivers/firmware/arm_scmi/Makefile     |   1 +
 drivers/firmware/arm_scmi/imx-sm-bbm.c | 378 +++++++++++++++++++++++++++++++++
 include/linux/scmi_imx_protocol.h      |  45 ++++
 4 files changed, 434 insertions(+)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index aa5842be19b2..56d11c9d9f47 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -181,3 +181,13 @@ config ARM_SCMI_POWER_CONTROL
 	  early shutdown/reboot SCMI requests.
 
 endmenu
+
+config IMX_SCMI_BBM_EXT
+	tristate "i.MX SCMI BBM EXTENSION"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	default y if ARCH_MXC
+	help
+	  This enables i.MX System BBM control logic which supports RTC
+	  and BUTTON.
+
+	  This driver can also be built as a module.
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index a7bc4796519c..327687acf857 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -11,6 +11,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
+scmi-protocols-$(CONFIG_IMX_SCMI_BBM_EXT) += imx-sm-bbm.o
 scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
diff --git a/drivers/firmware/arm_scmi/imx-sm-bbm.c b/drivers/firmware/arm_scmi/imx-sm-bbm.c
new file mode 100644
index 000000000000..7ee699cc4215
--- /dev/null
+++ b/drivers/firmware/arm_scmi/imx-sm-bbm.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) NXP BBM Protocol
+ *
+ * Copyright 2024 NXP
+ */
+
+#define pr_fmt(fmt) "SCMI Notifications BBM - " fmt
+
+#include <linux/bits.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
+
+#include "protocols.h"
+#include "notify.h"
+
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
+
+enum scmi_imx_bbm_protocol_cmd {
+	IMX_BBM_GPR_SET = 0x3,
+	IMX_BBM_GPR_GET = 0x4,
+	IMX_BBM_RTC_ATTRIBUTES = 0x5,
+	IMX_BBM_RTC_TIME_SET = 0x6,
+	IMX_BBM_RTC_TIME_GET = 0x7,
+	IMX_BBM_RTC_ALARM_SET = 0x8,
+	IMX_BBM_BUTTON_GET = 0x9,
+	IMX_BBM_RTC_NOTIFY = 0xA,
+	IMX_BBM_BUTTON_NOTIFY = 0xB,
+};
+
+#define GET_RTCS_NR(x)	le32_get_bits((x), GENMASK(23, 16))
+#define GET_GPRS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
+
+#define SCMI_IMX_BBM_NOTIFY_RTC_UPDATED		BIT(2)
+#define SCMI_IMX_BBM_NOTIFY_RTC_ROLLOVER	BIT(1)
+#define SCMI_IMX_BBM_NOTIFY_RTC_ALARM		BIT(0)
+
+#define SCMI_IMX_BBM_RTC_ALARM_ENABLE_FLAG	BIT(0)
+
+#define SCMI_IMX_BBM_NOTIFY_RTC_FLAG	\
+	(SCMI_IMX_BBM_NOTIFY_RTC_UPDATED | SCMI_IMX_BBM_NOTIFY_RTC_ROLLOVER | \
+	 SCMI_IMX_BBM_NOTIFY_RTC_ALARM)
+
+#define SCMI_IMX_BBM_EVENT_RTC_MASK		GENMASK(31, 24)
+
+struct scmi_imx_bbm_info {
+	u32 version;
+	int nr_rtc;
+	int nr_gpr;
+};
+
+struct scmi_msg_imx_bbm_protocol_attributes {
+	__le32 attributes;
+};
+
+struct scmi_imx_bbm_set_time {
+	__le32 id;
+	__le32 flags;
+	__le32 value_low;
+	__le32 value_high;
+};
+
+struct scmi_imx_bbm_get_time {
+	__le32 id;
+	__le32 flags;
+};
+
+struct scmi_imx_bbm_alarm_time {
+	__le32 id;
+	__le32 flags;
+	__le32 value_low;
+	__le32 value_high;
+};
+
+struct scmi_msg_imx_bbm_rtc_notify {
+	__le32 rtc_id;
+	__le32 flags;
+};
+
+struct scmi_msg_imx_bbm_button_notify {
+	__le32 flags;
+};
+
+struct scmi_imx_bbm_notify_payld {
+	__le32 flags;
+};
+
+static int scmi_imx_bbm_attributes_get(const struct scmi_protocol_handle *ph,
+				       struct scmi_imx_bbm_info *pi)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_imx_bbm_protocol_attributes *attr;
+
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0, sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr = t->rx.buf;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		pi->nr_rtc = GET_RTCS_NR(attr->attributes);
+		pi->nr_gpr = GET_GPRS_NR(attr->attributes);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_bbm_notify(const struct scmi_protocol_handle *ph,
+			       u32 src_id, int message_id, bool enable)
+{
+	int ret;
+	struct scmi_xfer *t;
+
+	if (message_id == IMX_BBM_RTC_NOTIFY) {
+		struct scmi_msg_imx_bbm_rtc_notify *rtc_notify;
+
+		ret = ph->xops->xfer_get_init(ph, message_id,
+					      sizeof(*rtc_notify), 0, &t);
+		if (ret)
+			return ret;
+
+		rtc_notify = t->tx.buf;
+		rtc_notify->rtc_id = cpu_to_le32(0);
+		rtc_notify->flags =
+			cpu_to_le32(enable ? SCMI_IMX_BBM_NOTIFY_RTC_FLAG : 0);
+	} else if (message_id == IMX_BBM_BUTTON_NOTIFY) {
+		struct scmi_msg_imx_bbm_button_notify *button_notify;
+
+		ret = ph->xops->xfer_get_init(ph, message_id,
+					      sizeof(*button_notify), 0, &t);
+		if (ret)
+			return ret;
+
+		button_notify = t->tx.buf;
+		button_notify->flags = cpu_to_le32(enable ? 1 : 0);
+	} else {
+		return -EINVAL;
+	}
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static enum scmi_imx_bbm_protocol_cmd evt_2_cmd[] = {
+	IMX_BBM_RTC_NOTIFY,
+	IMX_BBM_BUTTON_NOTIFY
+};
+
+static int scmi_imx_bbm_set_notify_enabled(const struct scmi_protocol_handle *ph,
+					   u8 evt_id, u32 src_id, bool enable)
+{
+	int ret, cmd_id;
+
+	if (evt_id >= ARRAY_SIZE(evt_2_cmd))
+		return -EINVAL;
+
+	cmd_id = evt_2_cmd[evt_id];
+	ret = scmi_imx_bbm_notify(ph, src_id, cmd_id, enable);
+	if (ret)
+		pr_debug("FAIL_ENABLED - evt[%X] dom[%d] - ret:%d\n",
+			 evt_id, src_id, ret);
+
+	return ret;
+}
+
+static void *scmi_imx_bbm_fill_custom_report(const struct scmi_protocol_handle *ph,
+					     u8 evt_id, ktime_t timestamp,
+					     const void *payld, size_t payld_sz,
+					     void *report, u32 *src_id)
+{
+	const struct scmi_imx_bbm_notify_payld *p = payld;
+	struct scmi_imx_bbm_notif_report *r = report;
+
+	if (sizeof(*p) != payld_sz)
+		return NULL;
+
+	if (evt_id == SCMI_EVENT_IMX_BBM_RTC) {
+		r->is_rtc = true;
+		r->is_button = false;
+		r->timestamp = timestamp;
+		r->rtc_id = le32_get_bits(p->flags, SCMI_IMX_BBM_EVENT_RTC_MASK);
+		r->rtc_evt = le32_get_bits(p->flags, SCMI_IMX_BBM_NOTIFY_RTC_FLAG);
+		dev_dbg(ph->dev, "RTC: %d evt: %x\n", r->rtc_id, r->rtc_evt);
+		*src_id = r->rtc_evt;
+	} else if (evt_id == SCMI_EVENT_IMX_BBM_BUTTON) {
+		r->is_rtc = false;
+		r->is_button = true;
+		r->timestamp = timestamp;
+		dev_dbg(ph->dev, "BBM Button\n");
+		*src_id = 0;
+	} else {
+		WARN_ON_ONCE(1);
+		return NULL;
+	}
+
+	return r;
+}
+
+static const struct scmi_event scmi_imx_bbm_events[] = {
+	{
+		.id = SCMI_EVENT_IMX_BBM_RTC,
+		.max_payld_sz = sizeof(struct scmi_imx_bbm_notify_payld),
+		.max_report_sz = sizeof(struct scmi_imx_bbm_notif_report),
+	},
+	{
+		.id = SCMI_EVENT_IMX_BBM_BUTTON,
+		.max_payld_sz = sizeof(struct scmi_imx_bbm_notify_payld),
+		.max_report_sz = sizeof(struct scmi_imx_bbm_notif_report),
+	},
+};
+
+static const struct scmi_event_ops scmi_imx_bbm_event_ops = {
+	.set_notify_enabled = scmi_imx_bbm_set_notify_enabled,
+	.fill_custom_report = scmi_imx_bbm_fill_custom_report,
+};
+
+static const struct scmi_protocol_events scmi_imx_bbm_protocol_events = {
+	.queue_sz = SCMI_PROTO_QUEUE_SZ,
+	.ops = &scmi_imx_bbm_event_ops,
+	.evts = scmi_imx_bbm_events,
+	.num_events = ARRAY_SIZE(scmi_imx_bbm_events),
+	.num_sources = 1,
+};
+
+static int scmi_imx_bbm_protocol_init(const struct scmi_protocol_handle *ph)
+{
+	u32 version;
+	int ret;
+	struct scmi_imx_bbm_info *binfo;
+
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
+
+	dev_info(ph->dev, "NXP SM BBM Version %d.%d\n",
+		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	binfo = devm_kzalloc(ph->dev, sizeof(*binfo), GFP_KERNEL);
+	if (!binfo)
+		return -ENOMEM;
+
+	ret = scmi_imx_bbm_attributes_get(ph, binfo);
+	if (ret)
+		return ret;
+
+	return ph->set_priv(ph, binfo, version);
+}
+
+static int scmi_imx_bbm_rtc_time_set(const struct scmi_protocol_handle *ph,
+				     u32 rtc_id, u64 sec)
+{
+	struct scmi_imx_bbm_info *pi = ph->get_priv(ph);
+	struct scmi_imx_bbm_set_time *cfg;
+	struct scmi_xfer *t;
+	int ret;
+
+	if (rtc_id >= pi->nr_rtc)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, IMX_BBM_RTC_TIME_SET, sizeof(*cfg), 0, &t);
+	if (ret)
+		return ret;
+
+	cfg = t->tx.buf;
+	cfg->id = cpu_to_le32(rtc_id);
+	cfg->flags = 0;
+	cfg->value_low = cpu_to_le32(lower_32_bits(sec));
+	cfg->value_high = cpu_to_le32(upper_32_bits(sec));
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_bbm_rtc_time_get(const struct scmi_protocol_handle *ph,
+				     u32 rtc_id, u64 *value)
+{
+	struct scmi_imx_bbm_info *pi = ph->get_priv(ph);
+	struct scmi_imx_bbm_get_time *cfg;
+	struct scmi_xfer *t;
+	int ret;
+
+	if (rtc_id >= pi->nr_rtc)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, IMX_BBM_RTC_TIME_GET, sizeof(*cfg),
+				      sizeof(u64), &t);
+	if (ret)
+		return ret;
+
+	cfg = t->tx.buf;
+	cfg->id = cpu_to_le32(rtc_id);
+	cfg->flags = 0;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret)
+		*value = get_unaligned_le64(t->rx.buf);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_bbm_rtc_alarm_set(const struct scmi_protocol_handle *ph,
+				      u32 rtc_id, u64 sec)
+{
+	struct scmi_imx_bbm_info *pi = ph->get_priv(ph);
+	struct scmi_imx_bbm_alarm_time *cfg;
+	struct scmi_xfer *t;
+	int ret;
+
+	if (rtc_id >= pi->nr_rtc)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, IMX_BBM_RTC_ALARM_SET, sizeof(*cfg), 0, &t);
+	if (ret)
+		return ret;
+
+	cfg = t->tx.buf;
+	cfg->id = cpu_to_le32(rtc_id);
+	cfg->flags = SCMI_IMX_BBM_RTC_ALARM_ENABLE_FLAG;
+	cfg->value_low = cpu_to_le32(lower_32_bits(sec));
+	cfg->value_high = cpu_to_le32(upper_32_bits(sec));
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_bbm_button_get(const struct scmi_protocol_handle *ph, u32 *state)
+{
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, IMX_BBM_BUTTON_GET, 0, sizeof(u32), &t);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret)
+		*state = get_unaligned_le32(t->rx.buf);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static const struct scmi_imx_bbm_proto_ops scmi_imx_bbm_proto_ops = {
+	.rtc_time_get = scmi_imx_bbm_rtc_time_get,
+	.rtc_time_set = scmi_imx_bbm_rtc_time_set,
+	.rtc_alarm_set = scmi_imx_bbm_rtc_alarm_set,
+	.button_get = scmi_imx_bbm_button_get,
+};
+
+static const struct scmi_protocol scmi_imx_bbm = {
+	.id = SCMI_PROTOCOL_IMX_BBM,
+	.owner = THIS_MODULE,
+	.instance_init = &scmi_imx_bbm_protocol_init,
+	.ops = &scmi_imx_bbm_proto_ops,
+	.events = &scmi_imx_bbm_protocol_events,
+	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
+};
+
+module_scmi_protocol(scmi_imx_bbm);
diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
new file mode 100644
index 000000000000..90ce011a4429
--- /dev/null
+++ b/include/linux/scmi_imx_protocol.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SCMI Message Protocol driver NXP extension header
+ *
+ * Copyright 2024 NXP.
+ */
+
+#ifndef _LINUX_SCMI_NXP_PROTOCOL_H
+#define _LINUX_SCMI_NXP_PROTOCOL_H
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/notifier.h>
+#include <linux/types.h>
+
+enum scmi_nxp_protocol {
+	SCMI_PROTOCOL_IMX_BBM = 0x81,
+};
+
+struct scmi_imx_bbm_proto_ops {
+	int (*rtc_time_set)(const struct scmi_protocol_handle *ph, u32 id,
+			    uint64_t sec);
+	int (*rtc_time_get)(const struct scmi_protocol_handle *ph, u32 id,
+			    u64 *val);
+	int (*rtc_alarm_set)(const struct scmi_protocol_handle *ph, u32 id,
+			     u64 sec);
+	int (*button_get)(const struct scmi_protocol_handle *ph, u32 *state);
+};
+
+enum scmi_nxp_notification_events {
+	SCMI_EVENT_IMX_BBM_RTC = 0x0,
+	SCMI_EVENT_IMX_BBM_BUTTON = 0x1,
+	SCMI_EVENT_IMX_MISC_CONTROL_DISABLED = 0x0,
+	SCMI_EVENT_IMX_MISC_CONTROL_FALLING_EDGE = 0x1,
+	SCMI_EVENT_IMX_MISC_CONTROL_RISING_EDGE = 0x2,
+};
+
+struct scmi_imx_bbm_notif_report {
+	bool			is_rtc;
+	bool			is_button;
+	ktime_t			timestamp;
+	unsigned int		rtc_id;
+	unsigned int		rtc_evt;
+};
+#endif

-- 
2.37.1


