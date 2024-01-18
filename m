Return-Path: <linux-kernel+bounces-30235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E29831BEE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BCB285316
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C77A1E527;
	Thu, 18 Jan 2024 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="mOz2tg6b"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2074.outbound.protection.outlook.com [40.107.8.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC4039B;
	Thu, 18 Jan 2024 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705590096; cv=fail; b=T322AErdM5YhlmmbihmJuVLQiZOwmVX3PQLKhW0Lbw8580M9UYO5L3BbuflROEnHli1t9n3P2r0bZXuDqzvkxhIOS4R9HMz1aYK5VNfX4c4Jz3Q9zOBioHMVlYj3yRFKwovZOhywaV+MWQg/xbygNU7QD1ILFrNYcdN/sstHifQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705590096; c=relaxed/simple;
	bh=4HtGUIYWHi5XW9P6QpsQ5JUoEBMkTUkJpK92mCtE2XI=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:Date:Subject:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=MQ+3INi922RAZEvfUHVihgqOYSaH1w3Jbnz3ybDxw7nu4JSiGE4ZJb1nsYkVfObdZrzoPDY6B4az/4Pmekxa+tFGBnIU1nofwSBPIYuHLZgVdpw70cJpwgyuMHN/fQMHBgLZ5mAlYBlBhIgDtnK8yRsy19L5e72FtxIUpgbePrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=mOz2tg6b; arc=fail smtp.client-ip=40.107.8.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bywqv2pCDPKus3gpfHBdl9igNZOY+hCw7UU8txI+Mw5FyhKSaCobJIRxEkONDVTdfHAfDnORKeNbFwHfSL2/ZEudfV5P1Hd+n9ws0SukT0RTNYSQgSKloGBLoLghrYYj+MENObz088l3NrikH/tFLhQM1vGPmWCKH5zltIUqAhZLUA7JvrzcTX8mcM/wZjqaMLjdxJJPcV1ChZKaclzTYlMkSSoI7e7gAJSXHj9dhp9Q0UIrewdPRBsdFNgmmaWHxsmAbo7V2cbTJqka5YMUtcdj7RpFVNzT7j1GONcct3POGlrlBjm88F1k+uedJJoube4WybDPHw8OHHz/Fq0qGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSL13OySgps+fz6qHc7H95AzCwGqwCdrvTQ6XAjwsYU=;
 b=DhSJqzlUD0qPzuz7OLNtcNfU4k8GRVdLhYZsbxwYrtJGPB+j0bL+0+ZEi05ZyLoArp3l0Vwr3KJtfKjAwyveJluXnD9q+tcZy1AwRgaTQ3ChMacmyS9sZ9ZjOvADF2fbaMK7uSHcbbo624GSNEL1XDSvLq+yrAaEICkJVBTRyQzqB9jjJdU0RH1ounXSm+f1DcPckghM8pcMt0WDPsnhgXonhJt79N2bsBQHNzYWJCZl3cVK45R3RJ3/vJzqg6dMckUVL7bS+19+IvuwgvAzrnQ3fYSCvKFJLc6lM6GAOuMQUkd3jX02ct6RmVnb1TzIjl0jEu4CvyI41EZ845vWHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSL13OySgps+fz6qHc7H95AzCwGqwCdrvTQ6XAjwsYU=;
 b=mOz2tg6blVFMZ69L70ZPhxVVb5ITSEeu0qmg0I6hfIOMj7qrE8WIBlE3c8TqdOw2428awVMSqgHQ6vBrGr6vSjhl0sQqxZgaVisqR6R4fTNc2CTE+WE9fpPO7baaS8AtPhVhFCzmxL975lywSeLOY/QvVl+1IENlI/Fzj2fMVGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by PAXPR04MB8752.eurprd04.prod.outlook.com (2603:10a6:102:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 15:01:29 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::1ca2:718f:8566:763e]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::1ca2:718f:8566:763e%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 15:01:29 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 18 Jan 2024 16:01:10 +0100
Subject: [PATCH] ARM: dts: imx6qdl-hummingboard: Add rtc0 and rtc1 aliases
 to fix hctosys
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-imx6-hb-primary-rtc-v1-1-81b87935c557@solid-run.com>
X-B4-Tracking: v=1; b=H4sIADU9qWUC/x3MQQqAIBBA0avIrBtQkYquEi0sp5qFFWNEEd49a
 fkW/7+QSJgSdOoFoYsT71uBqRRMq98WQg7FYLV12pgWOd41riMewtHLg3JOqF0TXDOHmryHUh5
 CM9//tR9y/gBqbKWBZQAAAA==
To: Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 Jon Nettleton <jon@solid-run.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::21) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|PAXPR04MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: 22138f2f-75fc-49f5-df35-08dc183659ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HlOun0LN4dKnrqV1Opnh/sdPpkp5OU2ps0/0kD9NiHYACtKHrj++noZNEG/U9SW/Hv9LYdo+2Vg+W19e3lWUu4kvvmnPC56RWdEHhY9ZftKUGSgfadqizPczhIQhDFiVByeSaumpQIAsZZAY9Nk0rcqn4Z5FjrV8jy0VcrifLBdecZRTdiPfIN2Xvq8XeaOxacHEjXVB1JS+j6EiQX9cOAtWEWoqrPIMjidfJpOXdqakDjHdRNBvYx0Ke3D8jvUGqO4zM2ZzhCV9PD9HSdq/Eoav23+Ia/pTmGbaLXISMJFCe4lneaHnb9F8bWZrIYkkMA2z0/FCGOWYUCEATfakdm1XKvDM/lz+jTaXS39d9mDwCcp+jstwzHvD9jux2I3D88/O9vGaWggaa/VCsDTptANYV8LRsxclcdHt4zVYmPlgvpugYIdVSH9/xfdNZBy2zwozkz9QOXAfABcx31wYdYT1dUukXfSAXvWS9M3Yu+w6u/gPvibThlKWGEZbHLZUvbPgacvaziANROO/s+08PBraPn7jhQjLFtFz37VmqXOc/OQgsQvLeooSWT86K5q784aLH106/fcoeTk67rqt6L/4gqmwnMNSy1kBbGWtZLSoLluoMV9Ci2dvTS3AKK52mBPXu5BCnBfXNI3hB7pgIw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39840400004)(396003)(136003)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(8676002)(8936002)(5660300002)(4326008)(66946007)(7416002)(66556008)(316002)(66476007)(2906002)(107886003)(26005)(54906003)(2616005)(38350700005)(86362001)(36756003)(110136005)(6506007)(6512007)(6666004)(6486002)(478600001)(52116002)(41300700001)(38100700002)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0NHZ3grelVBT3R0SThMLzNwWkNONkVZNTZoN3Qwd09YakZSdjk2YnB6V0Mw?=
 =?utf-8?B?TkxqL3ZLVXFtR3VJOVY2T2VlNWs1VXMrZkczUmRNOFF5N2lESWl4Z09uZkFR?=
 =?utf-8?B?eTN2cVkyQ0NRb0JJR1FHNVhIKzNHcHJZcmdKallkdmxXbTR6bTBBQlFrUjE0?=
 =?utf-8?B?UnpvUXoxUHozSDBUZGFTVWtodlhZUWxoMXN5aHdjNGh3aWtnZzZScmxqYmp6?=
 =?utf-8?B?YjZNR0svdG1YbWgzUDEyQlJ6RTlhNFpMcUhLYkdTeGNFc1NmMzVVYlNJQy9M?=
 =?utf-8?B?VUw3L01udSsyYmNjTCt0Zlg0RzNDMzNxMjAzNnRzZGwxNVVFVmJKNGZDbTVK?=
 =?utf-8?B?WGcrLzVCbjNMaks5UFBiQnhrL0hYaEZCSzJIK01HOWI0Nm91U1daTXE0dnNE?=
 =?utf-8?B?UXZvbzNXbENKTkJsbm5iUmZRN0hodnhYOTRWMTRyQVJiS00rblhqNmUydXU0?=
 =?utf-8?B?VWMwS2pHeTVMWFpSbGtrcWdvd2JQT2FUcUs4cnVLdUZJRFhKWUpudHNGMWwv?=
 =?utf-8?B?eWdmRDBGVEtPMkNtQnhudVJ6RFg4YnRDQW5BeE1tZEI1QlBkbzY4REZja1Vo?=
 =?utf-8?B?dXlvdFlEL1B1NGZnRVV4aTZTOVM4MzZOd2YvWlg4TEJOQTI4THFOemZiMVNw?=
 =?utf-8?B?ZUdreW1VZ0Y3eFR5cDB2YStabFludURPTUdWQTAzZytjVlptcGw0QXh2SlJQ?=
 =?utf-8?B?bEdwdVNaT2ZKcHVmRUMvS3pJZUZSQWlWeStFd3Vja0ttWlJUT3dTZkpBb3ZW?=
 =?utf-8?B?Zmcra0dVNnJxVlpSMm40aEpldHcyYWRjenRzVTFvTUNmR2tmUGxxaVovelB3?=
 =?utf-8?B?MDQxQ2xFT1V5U2twWEYwa0J0SHkrMTk4SzFnWEc4RXVoT2piRWF3Z2tYWmJx?=
 =?utf-8?B?YjM4c2NPWlZoQ29VOGFkNEN5a2N6R3NHNTV2T2d2bmREb0UvOUN0SzBJdS9B?=
 =?utf-8?B?Wk1GYU9lLzd5T2ppMEM5eUF3NzVpa2RzSXZhRDdjMHI5NWJOZ3B6MVRSNTVD?=
 =?utf-8?B?Y1JRWGd4K3V6WGo3eFhJdkFDcE9EM081YTZBUWtKZTZBdmlXVW85aWU1OGVw?=
 =?utf-8?B?UngzM2kxK0RXY1VPdXRUUFVKdExFd3FJRTB2SThHN3BoSnFzYnp0SXNoanNB?=
 =?utf-8?B?My9Tbi9LUjZaZ2hyM0dHZ3BlMTNCTGJ0MWVIWUFPeEZjeGJhcWpQVmU4TWor?=
 =?utf-8?B?RVBVdVVrcHFkU2Rtd3ZPcFA3MEtIc3lodjd6dG1BRXNDN1hJZFhpdDFJT21y?=
 =?utf-8?B?SC9DMFRTRENHUUpHOURQVGYzbzc3OUZVTFZSVlYxanlPTXdHY09jUEJEZk9F?=
 =?utf-8?B?UUtZNlYwWWRJamxyOGF2eFYwRklwU0F3Y04xVE96VVZKWXpMZWxPNjhaWFIr?=
 =?utf-8?B?Wm1TVUtRaGQwT0Y5MkZEeG1CTE1DbkhQRldOSzN5WndDc1lRelk0UFNEWTE0?=
 =?utf-8?B?WUtwQTRqNzI2eDN2Q2tMYjlVTTNSRFUrNGplcW1NNG1TNmV6cWdqWjBhdXds?=
 =?utf-8?B?U2VUbTM1MHBoM2xFSWZrTk1LczFCTFBMeTJVaGtNSHhyY3hlK0d4Uk1CWG0w?=
 =?utf-8?B?TXNleEhVWWN4SkgvMHd3bkRSeWJzVzN4V3hldGZLSUw2RGg1eFFjV01GSkdh?=
 =?utf-8?B?OVZNUjQ4QlZMcGR4eXNDQU1HMTBnQ1c0NytYTjZ6OVJlUVdwMnpCazdTYlhN?=
 =?utf-8?B?Rys5ck9rdkFqMDZqNmJiVEZZa3hQM013RXVhN2RraDNtMmViZFdkS1J4YTI3?=
 =?utf-8?B?ZHVvNVdEVnRXcXNLei8xcHpMOWsxNm9UZUJ6Yk1mVWFjWGJFbnRtSWdtQmE4?=
 =?utf-8?B?MzlJNFBSbTN2dFlYT0Y4VDB1YXdOZTBYM1hNc0VYR2hqRWYxVFQrR3Z1Q3U3?=
 =?utf-8?B?REIxS3J4bStJUDlMTzY0Z2NoNXFINGV2THVrMlNzVE1PVzNYOHYwUEpjRHZD?=
 =?utf-8?B?dVRvZGJTeklJai9VK2RjeGxmWkxnbVRFaXZHaC96U01mZzNHY3hWTGhFNm5U?=
 =?utf-8?B?UHFHUW8zUFdWRGU0bTF4VG80Z1REZ01Xd1dIcTJVL3BXNDdUN3ZOTXliMkdu?=
 =?utf-8?B?Ykg0OVJCWGM0K3ZRbUVPbkl2cEpSb21XeXhwNEFBODRnNHFPWVJqdnBMMTNC?=
 =?utf-8?Q?DiZ/BtrZDwaSsgzRQ3VMZUTp4?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22138f2f-75fc-49f5-df35-08dc183659ef
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 15:01:29.7788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69XVKPZ0Xt5I9dHfS9ybRnHeldhpma1F4Y2Uf5air8qUi+IYWS4nZzCCkVvHNyra5eU/9guhVtYoX/W5dwcnmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8752

HummingBoard has two RTCs, first integrated within SoC that can be used to
wake up from sleep - and a second on the carrier board including back-up
battery which is intended for keeping time during power-off.

Add aliases for both, ensuring that the battery-backed clock is primary
rtc and used by default during boot for restoring system time.

Fixes keeping time across power-cycle observed on Debian,
which sets RTC_HCTOSYS_DEVICE="rtc0".

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard.dtsi  | 7 ++++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard2.dtsi | 5 +++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard.dtsi
index bfade7149080..a955c77cd499 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard.dtsi
@@ -41,6 +41,11 @@
 #include <dt-bindings/sound/fsl-imx-audmux.h>
 
 / {
+	aliases {
+		rtc0 = &carrier_rtc;
+		rtc1 = &snvs_rtc;
+	};
+
 	/* Will be filled by the bootloader */
 	memory@10000000 {
 		device_type = "memory";
@@ -187,7 +192,7 @@ &i2c1 {
 	status = "okay";
 
 	/* Pro baseboard model */
-	rtc@68 {
+	carrier_rtc: rtc@68 {
 		compatible = "nxp,pcf8523";
 		reg = <0x68>;
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard2.dtsi
index 0883ef99cded..e6017f9bf640 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard2.dtsi
@@ -41,6 +41,11 @@
 #include <dt-bindings/sound/fsl-imx-audmux.h>
 
 / {
+	aliases {
+		rtc0 = &pcf8523;
+		rtc1 = &snvs_rtc;
+	};
+
 	/* Will be filled by the bootloader */
 	memory@10000000 {
 		device_type = "memory";

---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240118-imx6-hb-primary-rtc-047d47fd6eaa

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


