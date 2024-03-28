Return-Path: <linux-kernel+bounces-123108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5B1890243
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF8B292606
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E25512CDBF;
	Thu, 28 Mar 2024 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Feg8jvTX"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937AD12EBC7;
	Thu, 28 Mar 2024 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637530; cv=fail; b=S6oTfaO/mgoQBo4N/BuT0ZCe6Z18lodA8+Mpgq41TF7irKtw8bcKJ7dFo5VyJE1elunTzdbd4UIGhZUgR4ksxGd4c7MrPpuP7LOm7wKmUDYxLe2T4jhUYoqv79pX3iSPJ8Kl9/dVs/5KYHN2Keuqc3pcsxqKYjemJMl4PR6obUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637530; c=relaxed/simple;
	bh=5AQAE5dWJbXSqcy+ov29FdUsFdWZq+xuhOXEYciHU4c=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=UlL3H18kJ5ARGUAc2J0uTOPChEC/hAqn/ubk5rG7mEniOaQoVFCeZJSyVXF2UlfbrT4jlIvWctrj/BouHTxLtR7SzM/HoEzQBQr6mmkXC8jJDBnkqJWc192/OQqyncHFOUvIG8KdAFccGR4iVXP0vl/JWSn/jqSd/jbagroOuYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Feg8jvTX; arc=fail smtp.client-ip=40.107.7.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRxNnnFCPk8RDnaF9mysv1l/0B2JhvNkx00AAX5dNW8wwGMb9sIYTr7lJNc05IDSOKhiNYD7uTLFVEFEvVaWUa1rPdwGKw7adQ8FYdQird1+H+09S6CyBLvew8wut8RSE6BsDmLlvzvt8SCgTSn/8R32RM9h/5nPkl58jiyQOtdnY+yn++9aNtLzDukLOSrUuTFFDuuzoikYzTuVrHHkma91ocHki6K8kO3WKsG4byaEV88NB3Ki61vVW2BVhiPNlMiiM9FcHxpdPd5VZ7GXH/S6T1mZl/8B8jNZke/4CmkJMRDkfvTP4WEJ3KQKs7CXd8FB+q2Ht2l6DQ5pfOrFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvENGwJP2gMBFra8Km4XlKJNg5mfEvWuvadotCz1KUM=;
 b=kXTY0WxxT7GlEGn9CmxzsUJDxpZ/ncPfUkCFyan3DtNz0NOoVS9G1tebT8RqN7CyMaC3lSVCTr0zZxtJGR0K4Qw1bwlujBnf1LVvGDeRsD7o92U404c8FkEy5m+zweP9EIVEQnhpndjhLL9vdvTSxeuMNRXsXqAOaamHs6EfD0LDg5/Nkq5SS5DsEqMb/XkRW2twmEc6BApJNN/6ol2sXrYHTfa9yr/Yq1qKr8wDt2Vq9L9v1jbhGN4KJinCl2pHf4jiFrkzArko5oStUc8K5/LdgkDP0+9MN/iLVdugR/Hg7gnbvWgBkDAkcz51xAxGKJ1GGq8Q3MU+3AIxSItZ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvENGwJP2gMBFra8Km4XlKJNg5mfEvWuvadotCz1KUM=;
 b=Feg8jvTXdjLsGvE+WmLu+8kmQ74Z9KrMRTsWKqX1/wIqnI5sd/HrTGqHdLaY0sDh8jniYpre/ZqIHpoXshiAt1mMwW6s6bnqhIGEmhfmfMGCci9NvBmClAYCF5BRZyQD7Vik2TQXQo/xrmjEOmOoG4z5jbXVlUujNdHEuuJWPr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8880.eurprd04.prod.outlook.com (2603:10a6:102:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 14:52:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 14:52:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v8 0/5] arm64: dts: imx8qxp add asrc and sai
Date: Thu, 28 Mar 2024 10:51:32 -0400
Message-Id: <20240328-asrc_8qxp-v8-0-801cd6bb5be2@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPSDBWYC/23Oz07EIBAG8FfZcBYz/BvonnwPYwwF6nKwrWCam
 k3f3elehMTjMPP7+O6sppJTZdfLnZW05ZqXmQb3dGHh5uePxHOkmUmQGqS03NcS3t3XvnJpvEf
 rlNMwMbpfS5ry/sh6faP5luv3Un4e0Zs8X/9L2SQHbqQYQ7BpFAFe5n19DssnOzM21TrXOkUu6
 mgGZaaovO+d/nMKTOs0uYBiHBxoNIPonWld19Oc/40KlaUVutg7bF3XE8klcBNG2iQYemcbJzp
 nyYEIyUjU3mLT8ziOX3Rsy8q4AQAA
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711637518; l=4470;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5AQAE5dWJbXSqcy+ov29FdUsFdWZq+xuhOXEYciHU4c=;
 b=ade1vPh3soiyDwgXquGscQSxzdV56lwGSIOwg/46hLR+ZAtyw86gT4hRqTMZJdg0ED/sxJ1CS
 oIUjQtESEpCAH1L+nlKXfH/FfUq3jK+a4QvkSN8Oocl0tKdVFcNoWf1
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0087.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f6a07f-b3d2-43f6-9049-08dc4f36a0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NCmk9qHtwEcbDYRzEV+C8MT83fsW9CSCGUcvDXbUVQ7MQdi99xn+f2CDxVHzFScleA4xVs6j7PKrb5Hv6FqK6Cmgb6qss9BhGMGIVtP4VD9OzJeOoX+eJH6TAwonTaHihXay11Yh3x+Ry56k2sLyk3kCbBAFvFLygTFNTYJuBuwyg8VqlAPtJtLE9jlzt5I5hL+L01az9jShgBgPv850Qci1YzzCUEy9ba2RlWcpWzNtZaLCEFNU9h2VtTTd4kExbQ5GFHgW70NxgJlu5uvf9D5vj3lUi45j9PccvprufoV0RQ+omi8mMobdTeHLcICYRJaK9gDf93Q8YpBbvnveVOYfJzRpvNKwfB6ZVwijyfjIsi/q425N1BwmzuHg6ETrORn25RQ754z62+a+u/ldm1Vg3pnDT3b/shqMN7OaAIxCFuOuTiK8CcRrYXl/zfJ+HdHrm6BHDNNHmf0cEorA14poos10EuqNe0cQgxqYfS8Wgum3kCVDG0+poE0BHXGCcE1WJLMcEJrxzfGIexrAf4tb3VyZhoiF+4kdQvmKluSpvI8mCoE2oo9bYk450AuJakjLB7LHmHBRiZIGPO0+aGyYI9XuboFUTlW2ldyBH87IAVNyu/4nkEtG8i6Mzd4eFnQG5ez9FnrCnZ4cdWMeOGyai9dDGTQsxWG3fmX8Y7TCUmPABSosh6peY4GX76Er
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(52116005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vy9qWlFSSkZIM1lGbHNxRjJYSXllVlVrcWdrVml0U3BLdnd5RkZJZ1pkM2NY?=
 =?utf-8?B?ZmkvWnFnSHVVYkIzTjJNci94aC9GVjdpekplT3ZKSnJLMXhPZy9MQVFVRCtF?=
 =?utf-8?B?ZHFGUWROcGVxSlQzUGtPUEtmczN6SlViYzZ2Sy9DeWdiK3haK21oZ0hkM1ZS?=
 =?utf-8?B?eHFKRHZYRE1ITFh4TlZGdUpQcjNOQkZITUJNK2FEa29sU1VLNks2bDg1N1RO?=
 =?utf-8?B?QTVHSmp2cUpvaTc5UTV5cHdwZjQ1eTI1aFh6UVBoZU9xWTVJWWJwc2c5MnFS?=
 =?utf-8?B?VGljVHdnRU01QlhrUHl4Ly9tZEtmdXJFR1F0cytoYjN3QTdNc3RFSzNZMTda?=
 =?utf-8?B?QlZZQ2VMWUlCd2doWjhaNHh5OGpPei9vZmdtWVIra2Y5bFc1dXV0QmswQ2lt?=
 =?utf-8?B?U3JsV3JtTmtCWDd4ejV2QTQ3Qm9aNkJrWkloZXR1NGdlUkFSRkpHRlhNc2lK?=
 =?utf-8?B?VlJLcDN2WmRBVmszUHZGNUxSODNiK1ltejNaWmNQOFVHcWV3b0IxZW1yWFNW?=
 =?utf-8?B?RXpLaytEYmJjOG1sMVhqVHpKS1dQK2VYekloaXZ3ZjNQZzlOOCt6MVk1NXZz?=
 =?utf-8?B?UWwwU1J1UDdudVczV1lvYzNkLzJVdEJERkhvSHRSYXdJbW9ZQW5kNXdGL2E1?=
 =?utf-8?B?NEhMajhxb2c0bjZ1SVRJNElzUFlSdXpTZkRVeTZCa3hGZW9xSzJnYWt5dWVV?=
 =?utf-8?B?N3JhSXBYdXJtdWxqT0lMUXdLT281SmE5TzFoWHUwMmFDME1wejIycHY5cTVx?=
 =?utf-8?B?c2dGYzBZVEd6NGlTNVdUUnhDUXlycTg2WkpXVThWVnAzOS81ZHByY3Bjbml4?=
 =?utf-8?B?SnRIOTY3dU9maXIvSVRabTUzVHU3WkFQNDJBUmFzK1VZeFJRdXF2TGpIYXRl?=
 =?utf-8?B?azZDK2pTaUNFUG8zL1lIZ0FoMEVIczRaMTRpcG01Yi9NZllLdFQ5aUVrbGNm?=
 =?utf-8?B?S3RJWXRDM05xUzFGQVpQSUNVaHFldE50VkRkbm1SWSsvSjBGa2lHUlErakFI?=
 =?utf-8?B?c2w3cVNSVzJ6QUJNOUxFVUpDcnVNcXUwYmdHR0k1UWEvamJBQWk3VUwyOFY0?=
 =?utf-8?B?YzdSSDZsamV1K2JBRjAxTmU1c3pzNS9zL2ZGRHQvQVF5Q052VXV1OHBHci9Z?=
 =?utf-8?B?TlpiUUx6eVVFUXZKejlNYitkYXBFTDU5STd6TFpLQVZFejFNUzJHWEpyM0JJ?=
 =?utf-8?B?WjYrNzZRSTYzTlc1UGRZTmJtTUF1SXBUZDdsT0ZnUklycU1WMjZEUFl4RXB6?=
 =?utf-8?B?OTVZY1I5Y3EvQTMzN3ZyczlLeHpwWEdYWWFxcm8rQnhUdXp1WnNsaytTWHBK?=
 =?utf-8?B?TCtpQlBkMStXZzFIMVNQQW52WEtOcmY2MkpjZkhmejlSMkJ4aTRIYVI4VWZk?=
 =?utf-8?B?Z3NuT2JKdWxwV3NOQXk0ME8wbys3Y0NXVUo4THNOZitOdklaMGFPZFhxbnZS?=
 =?utf-8?B?STZRdHJoa081NWFhL2F0bHhuS0lLT1p6Q2xhNW1xSDRPdEdscWRTN3M0UmpL?=
 =?utf-8?B?RWdaSFV0V240enRvQlZyK2lhdE9Ic0p6THdCUGhDSkRXNForK1p2dzJTcmpE?=
 =?utf-8?B?b2xLcGRBSzRrRnNWcmFkS2JZL01DUE80K1ZuQlVSR1VsYTlXZitsbCtwWERs?=
 =?utf-8?B?c2l0VUJpSFhQL3hUT3FpQUJ3dDkraWFtNmxvWEtiYUhkZWF3eDBqaWx1b21h?=
 =?utf-8?B?M3I0a2RsU2w1ZU9GTTl6NzhYL2hXV0ZPTnF4TmZrdGNDZ1FjMGl5Q3RlRUl0?=
 =?utf-8?B?UGt1UlBJRE0wRlkweUpIQlRFcHYzR0syNFJSWDRpcGM0ZGZUZTF4S01oekY3?=
 =?utf-8?B?anhlZlExdXRSL3o5bVQyVmFkc3VhamJkM3NMR2pNUE9pQjJ2T1VGUDNlT0p5?=
 =?utf-8?B?MmpSRzJLU3gxRE9JTVlrcWkzM1JacFE0WGFUcUlWMFcybWEzY1pYbjJyeC9C?=
 =?utf-8?B?bys2TDVXb2I0UDB2U0F1elJsMXlJZkhuVzlaaWNYYzlMU2xpWVQxQlMwV0RN?=
 =?utf-8?B?anRwL1dsd25XakR0Nk1kUU52NG9LK2VxUXpWcThHL2xBUS9sb0dNcVR3bmNr?=
 =?utf-8?B?Q3NzLytCTHBWTUZwNnNkM0Eydm44R1Q4d2dJc0ZaMFZXdzVGODAvVWtXeDBM?=
 =?utf-8?Q?/45KOp6675K4Nv7DtSvSuKT1d?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f6a07f-b3d2-43f6-9049-08dc4f36a0ec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 14:52:02.7582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hl2htKe2JWNe6jiFU/NMGyvXFhpkVqEtqKLNw1HYfkdj3Ffkq3Zqd5Xso57ZQVOkNC0Ie983mkmdpXV8wGWn5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8880

Update binding doc to avoid warning.
Change from v1 to v2
- Fixed dts DTB_CHECK warning

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v8:
binding:
- Add rob's review tag

dts:
- Add fixed patch to fix sai0 lpcg index
- Update other node lpcg index
- Remove extra space after =
- Link to v7: https://lore.kernel.org/r/20240318-asrc_8qxp-v7-0-01ce5264a761@nxp.com

Changes in v7:
- Using rob method for dma-names
- Drop conor acked tag form dma-names and interrupt patches
- Fixed warning for interrupts
- Pass dt_bindng check

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,sai.yaml
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/sound/fsl,sai.example.dts
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK Documentation/devicetree/bindings/sound/fsl,sai.example.dtb

 make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,spdif.yaml
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/sound/fsl,spdif.example.dts
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK Documentation/devicetree/bindings/sound/fsl,spdif.example.dtb

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx-asrc.yaml
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/sound/fsl,imx-asrc.example.dts
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK Documentation/devicetree/bindings/sound/fsl,imx-asrc.example.dtb

- Pass DTB_CHECK, below warning exist because binding doc still be txt.

from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: /bus@59000000/amix@59840000: failed to match any schema with compatible: ['fsl,imx8qm-audmix']

- Link to v6: https://lore.kernel.org/r/20240308-asrc_8qxp-v6-0-e08f6d030e09@nxp.com

Changes in v6:
- Add interrupt description in binding doc according to rob suggestion
- Link to v5: https://lore.kernel.org/r/20240307-asrc_8qxp-v5-0-db363740368d@nxp.com

Changes in v5:
- using rob's suggest logic after fix maxItems.
- sort dts nodes.
- remove spdif1. Add later when do 8qm upstream
- Link to v4: https://lore.kernel.org/r/20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com

Changes in v4:
Combine comments' from v2 and v3. I hope I address everythings.

- Krzysztof's comments
  - add reson about why change

- rob's comments
  using rob's suggest logic to restrict interrupt number
  but for dma-names, still need use oneOf to cover 3 case
  - [rx, tx]
  - [rx]
  - [tx]

  oneOf
    - items:
        - tx
        - rx
    - enums: [rx, tx]

- Conor's comments
  - add power-domains required for imx8qxp and imx8qm
  - remove dmas descript, not allow use index to get dma-channel. Current
no user using this method.

- Link to v3: https://lore.kernel.org/r/20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com

Changes in v3:
- Fixed dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/fsl,spdif.example.dtb: spdif@2004000: interrupts: [[0, 52, 4]] is too short
	from schema $id: http://devicetree.org/schemas/sound/fsl,spdif.yaml#

- Link to v2: https://lore.kernel.org/r/20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com

---
Frank Li (5):
      ASoC: dt-bindings: fsl,imx-asrc/spdif: Add power-domains property
      ASoC: dt-bindings: fsl,imx-asrc: update max interrupt numbers
      ASoC: dt-bindings: fsl-sai: allow only one dma-names
      arm64: dts: imx8: fix audio lpcg index
      arm64: dts: imx8qxp: add asrc[0,1], esai0, spdif0 and sai[4,5]

 .../devicetree/bindings/sound/fsl,imx-asrc.yaml    |  14 +
 .../devicetree/bindings/sound/fsl,sai.yaml         |   6 +-
 .../devicetree/bindings/sound/fsl,spdif.yaml       |  35 ++-
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi   | 285 ++++++++++++++++++++-
 4 files changed, 327 insertions(+), 13 deletions(-)
---
base-commit: 8552c902efe7ef670b6961fb8885b67961aeb629
change-id: 20240227-asrc_8qxp-25aa6783840f

Best regards,
---
Frank Li <Frank.Li@nxp.com>


