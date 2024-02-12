Return-Path: <linux-kernel+bounces-61948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C10938518D8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D261F21CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12493D568;
	Mon, 12 Feb 2024 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FLTVyyKF"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1AE3D3A4;
	Mon, 12 Feb 2024 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754773; cv=fail; b=k20fO8tfW9E37IHIkE6qX3zzeQBlDIP3TVO9zBEgrOXbmqHsxWel00AJA48A5A+1PwSH3IHGXri2h7/w0Ct7fkMQQLG/XkuCU6Pb8t0MAo47X0oDnqdUAoO6f0IWLeXgEblDiPRU+rXFBA5KSCIuX8my13OzzOpx7MqZbAQuWCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754773; c=relaxed/simple;
	bh=mHut+6Z7GK4LUyPL5v1lGhnQZgR8R3h1UZy+qMslDkM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JSrF04+4o2RCL9eiD6Fi+gaRzFuwQLcDEfq3s7eZao0KSTJkBgdtfaf80qJiuVvOCiF+cy1Eh5VtL6JWyLcpw/7ye24PFy3vUOdeYP8yGhiwP39s8njVSeS2ZN3eIbirxS711by7dM4AFlmPyN/2BverNMKf8VSnSHi6DOLXv4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FLTVyyKF; arc=fail smtp.client-ip=40.107.6.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nW4edLQhPGTC9Jb+oADkk1lxSW6vMOAIoxmsggrbR+S1eNF+U+eOwzWWEKg5Pu30guyPsVYzZ7Riubvk1rMAMwqY36ztGdkwJUhUAewYfHUC2OviJd8lb5AyXaMrZW8LF054eOJBgxjNXVORRKMS9bBwridh4t+NdATdVALsq7idroZP3dCSEvyI1fCzJh5r0zdqZNj+73frgHHYLjEBrkpW+Ik7Sr0BsPuyBRVJyL8gOaxtnDMjyYNeQcoZbRr0dtLYf2UQ/tVYMK3bkfO9liUR/ic5gr90DSk20hPfcBxF1QPghAzlXjgr3FnF0Vd4EuPhF1rGxdO/eKbTpzVuug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycTA0bP259Iv1t89syfXIMsWI8A3L6dfhyC//SX7E0w=;
 b=abTK2CGh4kIOTGPXmHG4cwL4EiIdvSaJLpcWGyMz6w9l7G/6KKWl76l12IsbDuNUDy5YhmoiDFEbQAlDMEdOU2xqx0Q/F6LBR4T8XELgHccfRpojQe/9GUnt2gglKb74dxMyoUaXIF+F9J1K8gkEHzw2CACEfqe9+cwmNg1G3JW3sSsRWaiN1dR1ukKzDHRzK0hhPnbnkQhXwNsZ3obNR/7RRtDyirCNdMJK9vG5ZkLlguUHPUBK3X/3q9KlhYVDryh5USPGN04y7JJciOiu2Q6Wj8pyrzn6VVP6oqCb3VpgPTbqDG9FSYso4XedJtGWP6xYx1L4FC3fDl15iU3BBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycTA0bP259Iv1t89syfXIMsWI8A3L6dfhyC//SX7E0w=;
 b=FLTVyyKF0VVLbIOeqcGLd5YFnX3WJlG4Pfxu3pVmOEoDdsom8t85fuu6HgVcyUlEi4K1FU5h+YHjMc7vP/Yx7w1MWjfnBdjkVNgnSbp+7pUh2hSoB42JAE4C78USkyltA6Yk3F3kuPMTikK4K8cyV5KVhlXbDn2TOKt7NjVW5Q0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9049.eurprd04.prod.outlook.com (2603:10a6:10:2e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 16:19:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7270.025; Mon, 12 Feb 2024
 16:19:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 12 Feb 2024 11:19:07 -0500
Subject: [PATCH v2 1/2] dt-bindings: usb: dwc3: drop
 'snps,host-vbus-glitches-quirk'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-vbus-glitch-v2-1-d71b73a82de1@nxp.com>
References: <20240212-vbus-glitch-v2-0-d71b73a82de1@nxp.com>
In-Reply-To: <20240212-vbus-glitch-v2-0-d71b73a82de1@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707754764; l=1157;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mHut+6Z7GK4LUyPL5v1lGhnQZgR8R3h1UZy+qMslDkM=;
 b=YWxhApEV4qMh+Se7urbVCn+BskRMRCI2ZXc3dxR5tytMV+ZKCWq3LJ+QUIPES0eaeYX6c81pV
 DFA+UOfrOdJBzNzHgqs6z5J1mGokV5v+aXmT0Z1xFZW6T4MvoDzYb3t
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN4PR0501CA0001.namprd05.prod.outlook.com
 (2603:10b6:803:40::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: f6623a91-db2d-439a-c88b-08dc2be66319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ni0wZvOaPmn/Xz+u0PSBsEzankk+g5ZOVSxWEHuRfbiR9NwWY+VDvTMof7S9IXmOC56pvZOzsrdT/ZTgCQXAhWOT4VIVokM/fIaZngjEFWjzuow29U8yLHRNWYsOMaBaMhTy3uidQN87dyet35Eg/HvjJMhrtywI/wrN87c+bwZZEqDbzdN+XZRrI7s7Uin8K/AWBUBB+sLvAOSXNykfBOOmukoKSXgy8Bs3EQAOvpOvoHVD6qbteiRSUhPJDpoFCGkU7oTEUTHaDyc//Ts3vEPF3hYxVuNpK8FEcLaEBphd4GyjRsNvI2dWEIKx6POi7kKl1FxGq3YjDGeG5ochAEEsNIttxfavlYrXEP/nSJWPQ5PJOMIi07rCymGb4uEcaLePg3VnhZnSGKK0dJBzGH2PDadQVn7YSfFWqdTzbKaLhblV4XZieKA+XwIIyYHCIIhP+yOan0ABTmaOnzxPkk6Uk3irYFcwcfcESwYhgd+d+HZbPiU8MsxmY4QTf8aoybs4DQc+Vjy7hu11/d/OTQ2YwXe150ykepWAoKLv0bgrRI7AtCNefzcovWrhZTXNlbztW9uijd3/wLHo5pcx32Z6pLGkpmIGGvr6RPA6c32TfO/Zj0UYz5sWJuw1wtIq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(230273577357003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6512007)(478600001)(6486002)(41300700001)(8676002)(8936002)(4326008)(7416002)(5660300002)(2906002)(110136005)(38350700005)(66476007)(6506007)(6666004)(316002)(52116002)(66946007)(66556008)(83380400001)(2616005)(86362001)(26005)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2FsemNmQmRrV2VIdFMzSnE4Ynh6SDV3Qm9SU0VCa0NqaFcvSW4rUnk3RklT?=
 =?utf-8?B?ak1jdUIxbWhJNkRZblZhb3JJRnNMZC9ZM1d5TENmZy9mMHdqZVBOMHJMa1pt?=
 =?utf-8?B?c0loRGowTGtZTjZMQW1Rd0pnbTRmREVwemJBMEhwcGpzNlpPWkJXbnBVa0pD?=
 =?utf-8?B?MC9tQXh4NVQxZWl1NFYrMm90S29qZmpkVXdpaWJRemF0Y1QwNHYxWkkzckdm?=
 =?utf-8?B?U2NoUUNVTXdibzExWHZaRWJtcnBVcHBrSExScnhFRG1DWEVFY2tseXVnRVRl?=
 =?utf-8?B?a3J0Q2FDVCtTcU93cGlTQTl1b09uMm1FM2llUXloR01LZ0lwOUd6ZUtIeFJq?=
 =?utf-8?B?alhYSzFqUEF4c1FaWnZvbnpuNFNtUytXZ3JpOVdEZkIrK0lIYWFDUHhNNTBh?=
 =?utf-8?B?bVk0b29qS0dDSDQ0bVhkaHZvZjU4QU0xZGZxOGtuN0FzcFRia0lVUERJYk9h?=
 =?utf-8?B?OVhkS3ROQlpOK3pDUXc3Z2dDb2lVcjdZSStzZHZyNmhnRGlFT0xRdXVuem1a?=
 =?utf-8?B?RUpNby9TcnpHbTFXZnFpOURHSnZwTysvVTNvWC90MXF0NHhMRU1GZnd4Zldr?=
 =?utf-8?B?cG1NZVZ2OHR3YXA2aHNDV0tsNEZLb1lMR3FEaC9XczJ3QXN4Y0ZCd0V5cUdU?=
 =?utf-8?B?YVlNbHRpV3ByaE9wUnZwRVlTcTEzWUZMdTJTTzRtNXJqUmQ0cXJBMHlHeXlm?=
 =?utf-8?B?aUluQjhVTGpEMVZVeUFPNHo5UitQSVBvWC8zeHhxaWtjd0tnamdkc2FJTkRo?=
 =?utf-8?B?eUxOYzVmdndSMVVvOC9ndVZxRWovRW95YWxkVDhjWDB4Zm0ycjNCMkp2c2g2?=
 =?utf-8?B?QTJCc2pDS2Q2eWZMTFdHQ0d3ZVFXc3F5YVVJZ2Jld1JoWmhqVVRyT2piMG8r?=
 =?utf-8?B?cEpqT0lGd2NqSlJXNVB3N3dzNlNNankxOThXWVNvU1VWc0ZmVmhwQ3RvN0F5?=
 =?utf-8?B?MjdUWWp2TndHUkJVaEgyUkNRV3JtS0ZMQ0plcWpxYWlLV1RTQkFYSXVHZ2ti?=
 =?utf-8?B?SSthWkRZZit1L2t2eWRPQjJUS3lkNm9IMGlZOXAyeGNUVCtucDB3QjM5TXBk?=
 =?utf-8?B?d0RaN1F0dGpxU3hrTVhrdnYvOTlMZE9xOUNxeVh1RkxFQnFHWDUyYit6VURI?=
 =?utf-8?B?bkpBVVFiM1duNFR5aVA0SkM0ZmlmcjhDV3drM3BaREEyNm51Y2NxM1g1dmZE?=
 =?utf-8?B?czdDUkN4RXNqM1Z1bERlQVc2NGEySXhlR3cyc2ZENGxlT2VJRzZERGlZQlZz?=
 =?utf-8?B?OE1vUVNXR3h1aC95SUc2SngxMDJrV1FVVXRmNGJuKzhDeC9XQ1F1cm9aaDAv?=
 =?utf-8?B?NFZ5clBZeFBsb2lvZ1BpUURXbG5JTTd4aFMvZnNUU1BoWEZEZ2R1RE1SWHpx?=
 =?utf-8?B?dXVsVC8xOVQyTGcxd2YwTXgwVFB6cTZQQURGanFEQzVXbllXSlIzQS9tbUJl?=
 =?utf-8?B?NDFQeGxlZXhqOWRCZHhrM3dQQlpOMHl4TDJCU2pRV2FsVkpjeWE1WWJaVWpn?=
 =?utf-8?B?azZZanl6WGt2NHBLZjBsZXV2YVU0RUt3ZWhFYnJpVngwUGhNS1Y0VytIcTcw?=
 =?utf-8?B?dHZRc2RxRlRNMitjdHdNRnAwVlZHRysvWXJkZ1JBd0s4NFFzUWF2MnAxTkZV?=
 =?utf-8?B?VXJaeGxNUmVVTlVGTHNmeTdMZkhxbHJiYTlSUGxXNE50ZXdUTHorQ2xxRm0v?=
 =?utf-8?B?N25UcGN3ZjZJUXZJbWZMTWFVYjB2YlNPcEI4ZUFJTTMxSURKTlNhT0ttbEFD?=
 =?utf-8?B?NzJMbThDUHVTUGN6VC9pMlNZV1FYS0pzeTFTV1JmOXZIeUs4WjJldTNhVkov?=
 =?utf-8?B?L3hPYnNXaWNnSWsyaDRNOG1aY2FHVUN4dElWY2JhK0VFRnNXQmIwZUErUnNF?=
 =?utf-8?B?R2lrc2lpU3VXUlFyMGlRU0JMcFc4MjBXZURPa2hsdGxXNllTdmErNEd1MjFM?=
 =?utf-8?B?RVMydlFCMmhVTzYyaFMxTkJPWkRMelR5VEVIYjU5YXR2bWR1ZFVlOVZxZmU2?=
 =?utf-8?B?bGR4K1RnZWpCUEVWT1h5ZlJvMFFpUytkV1c1YkRic05FTEEyNitYbmZnN0dV?=
 =?utf-8?B?dXdCNytScnZoRSs5ZUNxM2Uvelhlc0tGVFMwRUxMNXo1QXRSTWVRTE0wNEpT?=
 =?utf-8?Q?riD0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6623a91-db2d-439a-c88b-08dc2be66319
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 16:19:28.5941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfynC3ST66XKeDQcDrh3MwO09sictSTa3VBxsGuX+3f4eRsVa3PbbKzrT7s4IpeHo5Bj31J8kkQPQrMr5R7m4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9049

Drop 'snps,host-vbus-glitches-quirk'. It is safer to keep vbus disabled
before handing over to xhci driver. Needn't this property to control enable
workaround. Apply workaround unconditional.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 8f5d250070c78..203a1eb66691f 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -273,13 +273,6 @@ properties:
       with an external supply.
     type: boolean
 
-  snps,host-vbus-glitches-quirk:
-    description:
-      When set, power off all Root Hub ports immediately after
-      setting host mode to avoid vbus (negative) glitch happen in later
-      xhci reset. And the vbus will back to 5V automatically when reset done.
-    type: boolean
-
   snps,is-utmi-l1-suspend:
     description:
       True when DWC3 asserts output signal utmi_l1_suspend_n, false when

-- 
2.34.1


