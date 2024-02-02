Return-Path: <linux-kernel+bounces-50109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7A684745C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03581C24DB5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB138148315;
	Fri,  2 Feb 2024 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="cenMswfU"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2130.outbound.protection.outlook.com [40.107.8.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF18F1474B5;
	Fri,  2 Feb 2024 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890258; cv=fail; b=nfWl2XpCB5r5+pNmpFOX1r9BYGHq8SfUE35tUtEtphg9/22DwoyuT62jjbRoDfJ7viHOISCCU1Ldi4VKDUmDA0GRa3whQiy7I5hueZZ+ficb1H8dg0Q/Zax7JcI5EjXKkiHX+aPcQu1PrlCqsPk9L6mShHfN3z6mJreaqcBDszU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890258; c=relaxed/simple;
	bh=hMIKYwARHFl28aOlzWwWn5CF0EjqFkk4UQThGPqCf1Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZHph6g/ZTf1ok+IuGjHV8uL7pMC7s//MZgBP0LaacVIW2MRgCbPolM001hGr+6Duq2ooBRWAgXMpDckzdx7IIPMjJj3rFjH83OsObMwJ3LRPz+FD21lcY/gs8GCn5ZagU4ajlmr6I1OXzmhV3qkEn6cltwyHbbEEJWv88cAmxE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=cenMswfU; arc=fail smtp.client-ip=40.107.8.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyMnyIzHU7xSXLUQCRFL/j/EGykAYCDrz7KSpJ8vlo6N2cn9tqHwJxfaLS7l1sEE5upKRQJolaYh26EXUtD7JQhkS9cz9Ku2ZNSSovV+x3hix3jcOliRvLMVxIXrrttaPnXsMSIUQazOEGhjI7sWCiDGSiDeRrTvVooiXfuyTpM5NufBzFi14ZU1MGAajqcKfoHNIPkm3PD7pjTbJMdic/nerCqinlVov7pkgUFlDL1183pShsbtRwmUqYj6ICaAN8dplMJxM1+iq6C+mFUz/W/96oumxxjnyGrhleqki+ff51PG/0zqHnfrFbKkvwtVkoCwZOoLy5XHYHyCkh4PqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDsVoQ8g3CQjqHclKbGCWLlS02/JOtQukIt6ZXijk5s=;
 b=lS8XuaxyOaSmJOPZ4D6tgf0DP89PF2L0a/eWu+eATjcr0mwwtU0bSBSw6GY/Y25ZIdR1jvFyosdLOrApUmufBFt5vVHhpApU+10DgvrdpRAloYlFrrMHMF/5qHX+TZzGiIrooPbWuNj8v4UCT5eX8DMf5mlzLlaTLturZw17PHhSDTWfqkgsIEF/I47cwwvaI9uqJUIJsn191S+ZFgGvBhy7WX0viAW6+XRreGcn7HDT3gLtiX3kNCbODQWLd8Fs5m/OXQyPtRHnsMEOqhzVHTDNS6JpFuTyUauzsR0hXbwiVbip3pT1BSwOl/oSnwA+f7f7MBoxVqpn1nEZM+MAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDsVoQ8g3CQjqHclKbGCWLlS02/JOtQukIt6ZXijk5s=;
 b=cenMswfUAnDDxlWBnj19m9QP4ZRkpHMoQ4sNVYKHD8pWOAUuZ4l3TF3+oe8eVYrvc30lNilnqK/nznta9zYJltaYgIvYt2j1XABMk45j6sruyiOoiCE1z7GM+JP/kCUJCN47qE7icFBpJj45c38M5HuCrGP7bvdkLZO2+afYWAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Fri, 2 Feb
 2024 16:10:53 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 16:10:53 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 02 Feb 2024 17:10:50 +0100
Subject: [PATCH v4 3/5] arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-add-am64-som-v4-3-5f8b12af5e71@solid-run.com>
References: <20240202-add-am64-som-v4-0-5f8b12af5e71@solid-run.com>
In-Reply-To: <20240202-add-am64-som-v4-0-5f8b12af5e71@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, Suman Anna <s-anna@ti.com>, 
 Grygorii Strashko <grygorii.strashko@ti.com>, 
 MD Danish Anwar <danishanwar@ti.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::16) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8eb5b9-0e95-43d8-bf70-08dc240987c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Piprq+/weoWhEJbtnT6gE0nmU2mor5KQKP45nCjOvnW58Yg/5n6Ikahbtugm+b7+s/vx/VId2ejOS1P0+ow47ZnvxoRmQ3aMXmjdTU6R3+0VgXSFyzy33oIynUiLlsZ/sn4VSpU19nYt1V1g2OypPzq8g6QvRiuDTY84ZQ1ldUk+NfFW67zQU6V+gyZ9VFgM02Xt6iR4VhIZ3ahKkrSTvmFtxn3NU7r3m8IMuNjAcbfGKPMaCBDe+WIcHambEn9vZ99ChV2ln1pyZTsSSvcoMYH7siwBpraqSsC6nC5M/YArPQRppobfhgyvJOz+N/894ZTr0JR/4sdNStrGHnXJfCPCo7Blv3keAqkeU59LXRCanvDA+qJRhwi2W1yBa0n4M3fvwwVBf9G9WqVVOHJpDk8o2pvAEkXdBcCSllCZRX1DQ32zRMkPQ9wVNfahLVj69ntMM9IRoZMdV9nCoKMl+NGixnvhpcd91eRPJLPaUZxIao6Rec6DX8TyetgZck9maQn8rIYKRuN3bJebTyx9ZYC9xXY9oWxEUGCoTkkF+wE7FwW6YptDojggzDESYV06BEy6HU5SN1hijNMvwkhtN20lUNlvuaU1Ht0EWLuBXbPhahYyI50RbVU6de5Wt5yi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39840400004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(5660300002)(7416002)(478600001)(6512007)(6486002)(6506007)(83380400001)(52116002)(86362001)(8676002)(4326008)(8936002)(66476007)(54906003)(66946007)(66556008)(110136005)(316002)(36756003)(38100700002)(41300700001)(26005)(2616005)(38350700005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlZRWVRRRXZVckZUL0NybHJjMUFVQ1lZV3BqK3JKT2pGMUVXeXNtV3ozV3E1?=
 =?utf-8?B?aERua2p4VGlXU29QL3FYVHo4Yi9oR0paeWVxMVFONTJhWFdiQzE3TmpYUXdm?=
 =?utf-8?B?ZlZUbDBmbE04aFZqeVloZmhpc3FDTXpReUJubGRseE5DY29VQ2Ira3N6bkxC?=
 =?utf-8?B?eVFwaTlBWnB2Y2FDdDNQN0s2NTNwQ3A1ZjhVQ2Nhb0x6R05CNUpuR29lRk9J?=
 =?utf-8?B?c3ZQcVJCcWM2OUdYS2FDdkY0dnlQVStyazlKOElIUzZEdHNCNVJzTDJBWVpo?=
 =?utf-8?B?S2hHbGZONVliWVlkcGlJbGhnc2RGVDU2TnN5aU1NQldpaDdIcVRrWWhuL2gr?=
 =?utf-8?B?bG5HWStUeTNhemcvYVI1WkxyRUNQN21QMStQbXBuTzRvaWdlSmNJZE9OYmNH?=
 =?utf-8?B?KytMMDJEMWhpdlhzOUtHRDVweVFlSFN0ajVkMEg1NDZtdnplSklBNXdpY2o1?=
 =?utf-8?B?MEhEMzAxeHRudEJyWDVpZkJKM3pMZjBTRzgvU0h6b2ZINElYMlc3K2c3WEhu?=
 =?utf-8?B?VXN5VzhMQ3MwY1AwNEY3VlE4MS9ya3loZEQyRkpXakVQRVB3NE1EcWFjWlBK?=
 =?utf-8?B?Q3hXdGcwOFNPMHRtRXdjdE50Z1Q4RzZXeEV4Tk9nU0xSMTU4bWFsRGhJSEtO?=
 =?utf-8?B?WVp5TmRzTHM3aEVmQjBXRlVBVmo5MzZXWm1VRk53ZWNpLy9qeHA3TmJldzFr?=
 =?utf-8?B?RmFISzlNUkVrWCtJUno1eTlMU3ByNk5BVkF2THhPUURvZktvN2htU0lkbmc3?=
 =?utf-8?B?M2VIaUNRc2xNb213aGY0dkZ6L1FWM3c1bWo3dm1rMk9ub0FDVW5BSkNHMk13?=
 =?utf-8?B?VklZa2g4QVcxZ0dYY3EraFE3SjlPcUVVdlpsb1BFTFVSOU1WNEliZEhNbmZn?=
 =?utf-8?B?ZkpuRjlFQU9YdUJxaWlsZUVMQ1UrS0RCeU1zZEJnUkg4L2hwQ3hLVkZOTkJD?=
 =?utf-8?B?TXEwZWpKd2RpdmZQZUsrOG9zYkxQR2gxVEhmWHc2TTZWTmF2d2swSVdlQytu?=
 =?utf-8?B?Sm94Z1d4MmJ3dEVUVW93VjBOV2tRb0xFN2l0U2RoL0pTN3pobzJEdG04VTV6?=
 =?utf-8?B?c3hIYVU5ZENpcldqeVErQjFUbW1vc2Zyb0NIZmFabzVoallWZnVHdnVQc2RO?=
 =?utf-8?B?bW91c2x3bjhLa0N2c3Vpa29GelBucW05eHVBeCs1RzcyemJ6bHloV0N3T0Js?=
 =?utf-8?B?UUN1Yi9CaFljU0NEU1NBdTcwWk1EWENKOWZ4Y29PWFJZWGdTTmlaQmdnL1NT?=
 =?utf-8?B?a1VUT3haMUREb0dpcXdpUDd4REhRMThIcTBLd0ZIV2RtTEwvZU91RlZKYVY0?=
 =?utf-8?B?Mi9iQ29menkzYm8zY3dlMEdCUnppSW9tTVVZclM5aDQvdFB4MHo0Nkc3M2JJ?=
 =?utf-8?B?aHpJWGxDWFZiMFg0R2pqMVFHWW0xYWloZVFaUnhmL1RGYUlOaG1WcWR0VGRZ?=
 =?utf-8?B?bDRWWUVrSDMweG9BTnppN2FJaG1hR1d5bVlBWGdIQlFNbTNSQWIrMDdZVnFp?=
 =?utf-8?B?OWNiekUwcGFDWlpHcG9mczgyWXlCNmN6Ykp4SlhFaFJPZ1loQWZDSWxrdHZE?=
 =?utf-8?B?UmVGNmlGTDV1OHFpRitJVTJ5aXFrZlFGS1UrelhKcmx5S0FFWHdXaFhjeThD?=
 =?utf-8?B?ajFWanN5TGJCcllNM21lTjFYUGFyWGljNWs2MjhuSHBqdE5uWUhCWnJGTjRZ?=
 =?utf-8?B?VXVuWjJnYVdOSE1yMEVFZUpzaXZpYkFmem8zMkFqaFg3NUFNWGU0MEJqQ0sw?=
 =?utf-8?B?bVJYdzVSRVd1MDh1SG5lVDgzaTJXSmNGQ3VpRnViSjZQNEI4Q2VRdzlzVnly?=
 =?utf-8?B?d1VxMTNNbEp0eW1ZVHpoUVNObkFxMnRQcHJuUHM0K25wcUV2WWJzVi9zRkIv?=
 =?utf-8?B?djJXUnN2UHk5Q0FiSVoxUWhwWVY1cS9jNFhxamxkWjhNVUx3RFVySXVYemRD?=
 =?utf-8?B?RWVCODBSbXRRZ2FHNGwvMkRpMFBZWGoyUHRpY2Z4aHRSL3ZOSlh6MEpSTWZs?=
 =?utf-8?B?dWlvT05GZEpFTWlIQW9URDNHcjdDZmY0NWFjbk5EdTI4elJ2b2hrR3dNeGIr?=
 =?utf-8?B?TmJXQkxjdC8vOEhkcnRKZUJCbjJFeXlkcG81dk5xa1JrOGhNd1BmcVhYVG1z?=
 =?utf-8?Q?sArUISIBNr9BxlfVZQaeiSE7t?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8eb5b9-0e95-43d8-bf70-08dc240987c4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 16:10:53.1779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjHU+Qknxk7k9uFGkh2SN3UUklRKFFKABeDu6PKCxYJvNp/zsdx8O/1/ljqKmUjFDOXkG3WhYgrFH/P8qs4gAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894

From: Suman Anna <s-anna@ti.com>

The ICSSG IP on AM64x SoCs have two Industrial Ethernet Peripherals (IEPs)
to manage/generate Industrial Ethernet functions such as time stamping.
Each IEP sub-module is sourced from an internal clock mux that can be
derived from either of the IP instance's ICSSG_IEP_GCLK or from another
internal ICSSG CORE_CLK mux. Add both the IEP nodes for both the ICSSG
instances. The IEP clock is currently configured to be derived
indirectly from the ICSSG_ICLK running at 250 MHz.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 0be642bc1b86..8130ee02a3d9 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1232,6 +1232,18 @@ icssg0_iepclk_mux: iepclk-mux@30 {
 			};
 		};
 
+		icssg0_iep0: iep@2e000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2e000 0x1000>;
+			clocks = <&icssg0_iepclk_mux>;
+		};
+
+		icssg0_iep1: iep@2f000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2f000 0x1000>;
+			clocks = <&icssg0_iepclk_mux>;
+		};
+
 		icssg0_mii_rt: mii-rt@32000 {
 			compatible = "ti,pruss-mii", "syscon";
 			reg = <0x32000 0x100>;
@@ -1373,6 +1385,18 @@ icssg1_iepclk_mux: iepclk-mux@30 {
 			};
 		};
 
+		icssg1_iep0: iep@2e000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2e000 0x1000>;
+			clocks = <&icssg1_iepclk_mux>;
+		};
+
+		icssg1_iep1: iep@2f000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2f000 0x1000>;
+			clocks = <&icssg1_iepclk_mux>;
+		};
+
 		icssg1_mii_rt: mii-rt@32000 {
 			compatible = "ti,pruss-mii", "syscon";
 			reg = <0x32000 0x100>;

-- 
2.35.3


