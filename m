Return-Path: <linux-kernel+bounces-71534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6374385A6CF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C36728398D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA3C39ADF;
	Mon, 19 Feb 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="UYksGwUw"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2102.outbound.protection.outlook.com [40.107.22.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF86381DE;
	Mon, 19 Feb 2024 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355030; cv=fail; b=dNAQ9xYrxFfSB7B+/iS5mnsL6rbMIZsrw3yE7ZCu5iwobuidrpICgf68I70OGhYo+DdHS05MQ7PhJ8p71E0OlswuJERHEB3FihruE61r6rr6ITOi+quaCLKtMf+VE5leWwLPbpLar2OBupvMj+KLwNrarVEhMA/I9tAuutxX18s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355030; c=relaxed/simple;
	bh=P9I98g47R3D1oEI2ydMCrskMKyCELD+CNhii4Zes7xo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=p4G3ujq1hfC3yLPg8AYDkxoorcPmsFo0Rx+wRX/YK2w8elAUjcCdX8aMjSXPzetyu5WeMfy4XWRgndfOmuam741wjQHzD8qusjeEkGE5/GRCSJ1DcO2Dq47OZ6hNMsSDZ91tkMVtH0bmi3b9SHMAElKJV/vH1yFrFx8e+YIbTFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=UYksGwUw; arc=fail smtp.client-ip=40.107.22.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nC4/ei9bxTeXj2tsNtmUzkx6yzZa+NsGp4Ygutnn8hQzsU29PIOl6eOh2dmXmyg1aOHH1EWNt+RpkHjB25RNQb1SvFhgLpG3cnFKTR/YpNBNYQ+354RheM2bVh3fghmOpVq6hNOWrkXlg3acwcXdpBChWqNOf1zDNf4/roUMRVLIon8jlAn43a0GdtZ35NBdTEabxzb/HdQO0GSGCa68X3t5klrdD7QHGESapzqociWwu79TLclD3zfyuPp8hxM0rj8o5qYySm6n6eJc9iOnOBoe0IrGrZEffExiuCnYxftZJtRtAf/A0JbsmOwRKu73islTeSL3xCcyjjG+EYnVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfPS2lRGdbZjmZYgpFzRBxBvjVvEdGtlPClZeNFE1lA=;
 b=C451VIAF6hr5pXNNC6j5eVUxQUbDVTGN9yex+suQWwiyq5vg2ZbCIxTWlgOp+X3q0rNk2+rD5HwG43NtANp2KXvC+iS3PzLoHs2YLgMpMOduxtMBUqwzixhRoNsUFASSeSahrKwr3dGqtHD9XnVMe9wKAcZnzJgOKqQp/NlUaAk1UhWjqkCld2/eB3hkH5JYuk6gWwownKW8aiD2rZ7UI4LlpyHk7HxwiSLNtEzpyO7j62OW+b35RHjJIr15OtOLzXyW/cigx3l8l2dtUqHbC3FnWZbmsrAbo4RD9jXIul4su6aAR359V9XKzMY8ytvrHmcTsX0mtxLVTMVoX0sKaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfPS2lRGdbZjmZYgpFzRBxBvjVvEdGtlPClZeNFE1lA=;
 b=UYksGwUwxA8GtfZG9u5rKXTgIgX3xE7tOKqDDYqSD827aFPShJUdeLC6OV4WwLO2m3EpXsnjNJpdzBhbP7inFZ3skitELNodencIaxFWLaJqK+P6mzE0hZCnEfjXHWs8tYzc8SF9+qbc1nYUusIMFO962hDGPwmpnzXPMOH3vXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB9PR04MB8431.eurprd04.prod.outlook.com (2603:10a6:10:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Mon, 19 Feb
 2024 15:03:44 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 15:03:44 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 19 Feb 2024 16:03:01 +0100
Subject: [PATCH v7 2/4] arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-add-am64-som-v7-2-0e6e95b0a05d@solid-run.com>
References: <20240219-add-am64-som-v7-0-0e6e95b0a05d@solid-run.com>
In-Reply-To: <20240219-add-am64-som-v7-0-0e6e95b0a05d@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 Suman Anna <s-anna@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, 
 MD Danish Anwar <danishanwar@ti.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DB9PR04MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: aa1de987-ca63-4567-ca27-08dc315bf78a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y9rMSLjioZYiwqE32Kdm2w7zDLXRzfUUf5QmTZtXuRf2a2PFQntqwN4RcarJMQLGNh/6DHOTZp9hm/dfhS+NlhvELrpmARJFRdVJR5GG5Fe765hwP17bGogEcYXiQ1R9hPGPXy7B1vDPMQj5e6aMhUQ4ZmJSkJUf4CoUk0Zusuy5UnT80C4PglIG76eUJkGpWEKChdokXdme+H6eMJ8TyJpuAzyDZF3e1HaRU/BaBFqUiztFoVVUNtBQRcD7JW64MX3KuE2iFXnsghqSk9DCuMy7W4wIcRjSQt0pKaIr3v/j15mGpAA030+lthMBHNUHonzCA+9DiAZnlmlGer1LOKDBwEqIBrK8vjHSU0Itl/EVO9Lqt+Q7WVOdBCMhJoReNcGOkQ+nJwQ4R33m9VxM3K17ffOTBLdU5Mb6iV7ME6W7Q6xg2iFUL4hZ9co1sTyLUeKqYUET4uad1Apbj042R0ya6BvVOCfSDFB8eUiDODU8tWrWrW06ef9d4LDztrfYEywmMfh9/Vz/V/Lt/+qhMdRgpfylhAVroRy3578/L9XzA4OHfgt9DgUXZrCSI7srXVneS9XXhJSqUZnFF4CpOMlJsApLNhBMHJUpi41WO7ds3dRSZWaol6246eQSsPN0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGlWUUdva2hocDdFNlFDTzAzUFNSQ2JIUitUS2R5YjZCTzVDRWRRaUc1Ti9y?=
 =?utf-8?B?OHFPWWhqS3VMRnNWQ3JZV3J0VG95b2trUnltWmordEFkcFpubG0xWmJoeGpG?=
 =?utf-8?B?UFBMa2Yxa1dRNUJXV2lDaDdYZTErYUZsdUpudndSYXA2RVVDV21GcmZsTVJY?=
 =?utf-8?B?bk1SU0xLdWlWd0hjd28ydlB4MW5aMWd3VGVyb05lTG92azJQUHF3NEJHUkJu?=
 =?utf-8?B?UTBhSUtKeE9OQzZPTno3TkY3RTZUenh2dGFGQk02d0U4V0hVT1NhQXRYMG1V?=
 =?utf-8?B?TGJra1lyUEltZGNGVmlqS09oR05ubDhTaVBFdzkvZXdTcm1qN3k3QnNOUEtj?=
 =?utf-8?B?MWhheFpVc21QTUZWcmpoV2lRejJtZkZSUXJXUWs4UnpkbTlEQVdqK2V0emph?=
 =?utf-8?B?ZGZ6MmdqNVdZL3dHbXdTd2ZSa0RCbTdTaisrVHdITlR0TnNrQUljOVNrTnhJ?=
 =?utf-8?B?WjVpQ2NyQkZnbUhrT3I0cWJIZzZ0VHV1TDNzK09jYS9CZWsvQUJHVjRDNDlE?=
 =?utf-8?B?ak9iUEJxWEhwcVR1TmNIYXZCS3JnMVBsdzMrUFVlNHJkNlk4NllyYnYwZ3Y3?=
 =?utf-8?B?T29ESVZJWk5qMUk0eVBMSFgwaWFVVlE3TWp0SGdEMFpOQkFFcXllOFY0OU9j?=
 =?utf-8?B?WkxnTlU4d2paWUNlOUVxTld3TzluQld4MW5Zc1piMXMrUXMvUWJlZVUvUHZK?=
 =?utf-8?B?b0tibzZlb05PS2pBcXJsUTl5bjBjaUUxc0xiQzNkajJ1K3h5ME9kZlgzKzZJ?=
 =?utf-8?B?eWZiOUlWbVQyc0xmZUhqYTBkSHVjaURySVlLalRBWDF3VUZWeDhkSlpoZTFD?=
 =?utf-8?B?TGMvQ2F1Ym5NUGxRZW9zQnhNSFVJb0NsbkNnY2VsOGxaa3d3eHorS3Q5cTMx?=
 =?utf-8?B?ZGRVZnZZS0FwZjdqYXJTZ1hRcCsvdnFxM29zZG92ZVlmSkd6K0FRSDlRK3dk?=
 =?utf-8?B?Q2Z4R05GdjA2ZTNiY3h0YUJKVEl2dzQxK1FGclhNTitqQVVGb0tHTGJ1dzI3?=
 =?utf-8?B?Y1c4Y0hDU1lBSG43QlMvSktvY1gvZCs5SXlMUDgyOWNKa0dVWU4wQTRyMndl?=
 =?utf-8?B?NzcvOWFkOG1NS1VReWh3bExJeVlzK0NXWXFncG9BZXRnODBoQm9yYlRzOTlB?=
 =?utf-8?B?aWFLVnRlWlQ3aWdxTXc0NWpRM1hxVXUzR3l6ekFkdytkN3JSM0pLd2gxQXp6?=
 =?utf-8?B?R01MdHZCaS95NmxMcSs5ZzF5aVhIUGV4ZjlXYVFWS3BOK3NpMEpjeW9lekZq?=
 =?utf-8?B?NmRaL2piazJVOTEzMjJ5S0hITXJ6aDV1T0svekorVE5GL0hhZVFiN2liUGk4?=
 =?utf-8?B?MGxPVVM0eUlxMTQreUhqL3ZpaENocFI4WmkwNUh2YWlpNmxsUXREcnVwNWxE?=
 =?utf-8?B?RENUNStnNDlmcHBYUmM3ZFl1M05iY2VmYXI4NWE4NHZzTmJ5SVNNK0VuYkdu?=
 =?utf-8?B?STk3VlI0cHM2UVJrTDA5U3lnM0ZzNnZmSGxhbWEwb3Z0MEd1R1pGMXQzSENi?=
 =?utf-8?B?Z29Gc01SVGFUYndXWXBDZXVDaXV1bTAzRG5mZUo1OG5ySmdCNFM2aEpvNlJ4?=
 =?utf-8?B?VkVlWEUrM1dFNmpQTGV4bi9QUEpKRWtucUVsNjNmTXU5OFVxSWFoVFo5Tm9T?=
 =?utf-8?B?T0RlMXlTbXJ4VDMvOWo1bVNRMmROZDY4QUI0NjQ2blQ2aC9PcjhGWWFxdS9S?=
 =?utf-8?B?ZnF2NDRCc1dFVVFvcmxuTS9yM1lZbm9VM0xJbStOY1dkY3VGenZZUnBYWnIx?=
 =?utf-8?B?di9Ta3hQK25TdHBsZStPN0pVWkNhdm1tcFJvWVlRR2lYM1Zoc1p4bDRKYVg1?=
 =?utf-8?B?aGV3ZEU3Rlo2VXBreU4rTTY1eFY3N051VHNUT0pJVUw4Vnp4NmVoOU0yWFV1?=
 =?utf-8?B?eU9ZSlBzK3BsWDJ2UnNLV2NrWDhkTjIrZS9tVXhzbWpGSWNMNkpzb2tjS1pS?=
 =?utf-8?B?eFdVU1Jtcnhqc3phc2lyWUxNcHEwWHViS1lIK1kvY2svOHFHbzNsU0RnNkl6?=
 =?utf-8?B?TUxnN29hWHI0aUpQUjBYNE10YWFidHVMYzNyQnFod3pFSU5XRWRNNUM5Ymw1?=
 =?utf-8?B?emt5Y285ODBvemJobkpGTk5QaGtoU0J5UmZ3Rk01cDJzbTk1THkvd1RPakN0?=
 =?utf-8?Q?nXWws2VbGjE6TR7L96cRgAFh6?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1de987-ca63-4567-ca27-08dc315bf78a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 15:03:44.5260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2r3fCrEu10LgxJoCRzpEOvjtgKVnEGB+QzVlXi8LMvS4wM0rfSnaMd6JWpWgsgVBNNqGygKNf9dA5JhFcczuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8431

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
index e348114f42e0..9d2dad8ae8df 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1244,6 +1244,18 @@ icssg0_iepclk_mux: iepclk-mux@30 {
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
@@ -1385,6 +1397,18 @@ icssg1_iepclk_mux: iepclk-mux@30 {
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


