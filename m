Return-Path: <linux-kernel+bounces-110703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9B98862AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A821F22C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEE7136652;
	Thu, 21 Mar 2024 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="aJ9Gx1sp"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2098.outbound.protection.outlook.com [40.107.7.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624EC288AE;
	Thu, 21 Mar 2024 21:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711057645; cv=fail; b=GIW+EgKSmI4OCxVh2kRoa6zxxKrvvwP9ohd0hOHvQI6Pz0ywvjvgdr6xARqf3CMuL2uI5RtnN0qTzWXtAoD35Ly6pu0++Oqdy/05qH5t9cWZslucWn+x8VR5XUm4xLisRv5ZkMZ2SRp3mEW1Dasd3opwDExnG4JXHrsPoxjdYKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711057645; c=relaxed/simple;
	bh=+sCq4tr9ncJjAb14zyD3pcZBuARK6Pg0tYdiKkBaRp0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=mt2llHdjjp9/erL4XuOUA0i6qCl6rAcbxcbM0dgKg801LEmm4bzrPjrZ4eoPD6nF2ZJTrvd59raY7U6q67EEGq0egJr7D1Rs57kRV+H916y2HfqIrECwPbS08Ssj56PziRSxCk5/Bg/2ytvEmW+wLXTxcY6a6SSyNw8gZQZeig4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=aJ9Gx1sp; arc=fail smtp.client-ip=40.107.7.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcGSMf6WKjChqy2o/zJHBmTYhW2g0/8ttUyrqqyUvSLIqyyKPM2MATJ95QrTh4BzBq74FUjm3txxKGOHsGjWtH1fQCbR5c+5t+Y3NwHnuDPPwIfDJU8PuVY7+m4aipSiVdNaUBlHdZsZ3OApBoRoNlqubsgX1JS9f0sS/ySjw1yH3Y8jCptqQ2MxUsMMPOP63z06S6i+XyyGIhgyyyTqOlw+E2nZw7Afe5JJuHS1wulAFERMad/4hO6n1sX+tzslnRPPy6SjMw5SIRq37bLB1LBLmitFBbrfpkHHEL0cN0jxflp0FGAhlI4RlVNYSDCAP67990G6dmgeF2mqHdTkfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfGVDYpTvCxPh+rW5014ujt66PZOkNYe0C5fJjvx9TA=;
 b=e8onnNb0VLz6srPOuDnVOIu3goGGsnU1GZXcdqJje86fL8pCtHFMqQgK/bSXixW5KMtpgfID2kTXKaDSmZfFJUGnvmMq50ixhIxe+hLtu3iu2IxgBEQlqnAj29rYste50U5doCz8lvb2nCEG5NvK8YkqcdQEP4riRtTdK/kO13Iaw9yrDQiUmu6rOMuCuipVc1/Rq3ZsJBp6CIqSdwN8gkqZCVhMmzoEOJ2D/vrlZpJJ+BASYvQc156WkNgJBmrfDo2ZOimUm4EuwlHTfkBXHj+VuBiyPEOsX3gaI/vrez/hNjCNr6pRDGM7bgIJPmystMwCD+psvb7KH+s4ZZhmBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfGVDYpTvCxPh+rW5014ujt66PZOkNYe0C5fJjvx9TA=;
 b=aJ9Gx1spBd2bhtmMahGMmUQj5zow0EVyzQ7/cvgxfaPToqTDaEN9CL1T9o5i0gKZFX5fQZGPKum3cHLac6KOcF9DWe4M6On7dykdmPVswxF7Iyfevzy3agzcwBIui5XRDUPPHy5aPeJULP2sHj1pkyc0gx4nLNebwXsKEWJkep8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PA4PR04MB9413.eurprd04.prod.outlook.com (2603:10a6:102:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 21 Mar
 2024 21:47:19 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7386.031; Thu, 21 Mar 2024
 21:47:19 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH 0/2] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Date: Thu, 21 Mar 2024 22:47:10 +0100
Message-Id: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN6q/GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0ML3eQ8S0NjA93i/FxdCxOLVAuzxOQkg8RkJaCGgqLUtMwKsGHRsbW
 1AM6iMVZcAAAA
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR4P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::6) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|PA4PR04MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: 4566cc26-32ff-4f9b-6450-08dc49f07b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+i1WLsh3O2HkzNXBU2Na6MFLPzI0BRJNvMHLD+zhaNgQTpCN/e9jwHDP8n3hXdVztPK7XTKwMuXtd2k89QZttCQS2Pxx9Lj1jXJ9iUT0zj4kC3cRg+MGXxvJBB2NauhzNEQteV2XqYRIVlQmlG3hJ4YiNGmQMAGsMh6moHBfW5TlF4B5FJWgEmIrbOj8/jiVGQTxs0n4IjIqpgRUBC7b7c5X+HTC8UvxYn78A2zDD9OvNpmU6jfUyNqLgG3nUqVUKbj6FUfUGl/X5B+9Vo51zEe6LHSaZ284oqunlPDKyaElFYmjMyHGzlMP0dUODmf0EVC9SMhwY1ctp8x5PsZ3FG5m4dmFGvK5zcVCr+XUkaz2F/4omHWK09y2/XIFZkgMfQ4Oe8j8YL+fGizhX7ZNoFNwLKAwDkGxkS7W3F7xxfMQwHBiXzXLbXMvCoLhslDf+pbW9rn23wjgU3HNIzhDkvK8AiLasgdesb5iobdcxIDM3qEC4moVEAb8/f+N3rmtjwqkDh2akwN7klN0Gm8ZH1UNYSSRwuzu/7mybJFMYQYn78TPebXnm6F/lqMG+BNJzQbFKZIk/Oi5G8LfqGRDxuCpuCp8VVbOJiAWElrSBzTq03FYH40HepOU+3nYQL7UtlKBmhGeAOd0ROFZurE7WDIPZmvLN32j1p8lHFgLazsq19scru3SGJG5Y42qNnOIj6ynbKuaxzZS7VE2GwtkKA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0Z2UnB5b0d4Y3d3Zi90ZGhWM0ZMNitzREp1elA4Z2h5SDBzRkRMa0NLcUhm?=
 =?utf-8?B?QlhIcU5qTGFDcnBHaXAwNjVlNVdTemQzNkV2cXh4VDR1U1RYeVhlNlFGTEo3?=
 =?utf-8?B?aVI0UWVKbUJaUGdjSUFmYWgydUJBTld6OGNONGR3VzFhSTJMclUyb0Z5VE1Q?=
 =?utf-8?B?bkhleWJOWWVuQUR6TVllTml4eGVIRGZBTjEwdjdGWmpTeVFEL2JXWGdUZGE3?=
 =?utf-8?B?Lzh5aTdtQ25RSHQwVWFtZUJNODVuelB6Y0FBcHhmY1R3dC93eWFxdDFlSXpY?=
 =?utf-8?B?N3VkcCs2UzZEc0k2UkErYlRMS1QvV1lpU3NnNW1zMjhEcXZoMldXdXNKNi9W?=
 =?utf-8?B?K05DVE5Pc3lVSm96R0pCTVNYTlNDNkREWnlPWXFKdTE2WXFYTm40amVrOTJv?=
 =?utf-8?B?cVpsQ1NXSE4vczdFeVMwWEZyc1ZIeFhZcHFHMjUwSCtwL1dTZXpUVTdlUW1w?=
 =?utf-8?B?TFo0Z0dnWVBtcWhRdzhzeGhSUnpxMnVncTRZSUVIeUt0UkRDSzhxMlJHa0Z6?=
 =?utf-8?B?d0dqRDU3UFJReXZ4T2VQSzhPT2k5SkdIMXZ3M0ordmU4VytNMW16WUx4Z2Zk?=
 =?utf-8?B?eGt5c2VZa2x0U3VSUG5DUGtYVzFoZVR6TFBkSkFEOVRscWg3S1lpT01Vdm5M?=
 =?utf-8?B?UzdCZm0veGRDbGtlcFptMW5QUWx0anVqRUpyRU9pZDhNblRGSkRhK0JERTRQ?=
 =?utf-8?B?dXhXVC9uYzJHbmFRRHdJUmliL0hERmxzbG9TMEI0NGhtQTVZMWdSNmlNTHAr?=
 =?utf-8?B?QVVDa0R6TzRZWWptTHVObytLa3d0QjdEeFhaeHhuSXNUd3p2UkJ1a1lvLzZ2?=
 =?utf-8?B?eUlkVnZIQ3Q2Qnl4VlMvWnVpWG95M1lURGdWRFIvczJzbDMwNEtZY1lOTzlE?=
 =?utf-8?B?L1BVMmFJdUFrdzkrdlFJOFpmQTRlV1FHOGZpSkwvRldXZDdCa3Npc1VRL1px?=
 =?utf-8?B?YVBiaFZJaHVEOGovWS84eVV1dVk5ZWpJanozclFjdGhJYWdrMm53ZjJ0L3Uy?=
 =?utf-8?B?RDRYNFJuQzZXSGJmNnJxbmNHSkh4UUpIUm5jZ3NvZFBKL3c2RWE5TTVOelY5?=
 =?utf-8?B?UCs0SnJIalZubEZyL0h0RU5Fcnp6K0xxejFod3UwemVkWURBZGYwcHFxYUdI?=
 =?utf-8?B?c2prbUN4WTNtbU5rUHBSVWNEc3NERnJxcjFZa01MblBWaitaTUJTY0VwM3dY?=
 =?utf-8?B?ZGpRZHNnZnZDWGhIN05ZaGQyT2orY0s5cC93YnpMbnYvTTB5bGpHTkZDa250?=
 =?utf-8?B?NTdYei9aYm1iQUdUTk1tNUFMTjhaU2VpZEE1M2VZeHZocS9FYjc0bnJMMkdm?=
 =?utf-8?B?dHJmSFVhSXZNVVVxWUF5d1JTWFVLUUpUdGluK3QvWUYwWXZKZG5tMGxqSXg3?=
 =?utf-8?B?TitJNUJvcTJBdXcwT3ZhcHNaUVhrTXIwSTUrVmV4LzlGSlI5M0c1bEhZMHpD?=
 =?utf-8?B?NnRNQWFCZ2NsYU5GdWphUW94d0RCL2owRjAyNDdra2NmSTJKdlFMTjkra3hl?=
 =?utf-8?B?SmRMZXFsL2FSZ3Mra0FsTVFjSjBqTkU1RlNJbVd3ek5rV0h1TG9VUHNTdnk1?=
 =?utf-8?B?M3Z3bGFIcUVKdUF6aTE1ek1ES1dBNVNnaTdWQVdBOXI4WExPQk1zRExuQ3FS?=
 =?utf-8?B?VzhXK0dQays1dXUyS2tzUnJZUXlKYU9LKzY0Sk82Zk10dE5jc0NBYm83MWlB?=
 =?utf-8?B?THpDVTVkaGQ2SVY2ZlBlQkNrWnloM0NmclZuQjlvWDlGdTUzaEZNektyOXRC?=
 =?utf-8?B?dVg4eDdTWUQvM2xyand5M2Y1T2FSTU9idVZjZngrL2sxVzd3MHJoQjRZNVpy?=
 =?utf-8?B?SmpxQm9MMVh1eWYrSFFkNzZjb0lRWnNPMkJXTEFkMmY1RHVZbFpEZ3RIUjBI?=
 =?utf-8?B?V2hYSSs1U2xJN2F6WEVhQ25ia2l5WFY4ckdFcDB2SDFtMElkZE9pc1RlSFB1?=
 =?utf-8?B?MGtQRjdCU29XQlZTNlM2R3ZLb0NPcVlBYk9reFcvblduL2FYUWk2bWhrUE9N?=
 =?utf-8?B?NUtXRTgySkdVOHowSVozcWdVWDBIcWkyYVkxVzFBWkNGbGtlK0dZd3FnTlVq?=
 =?utf-8?B?bmN1a2IrTEFRa1BySTFGTWpDaVlmRW43UTZreE9rdVpCU2daY1B5RFNNZzRZ?=
 =?utf-8?Q?Qn29yzFqM2jSb33tXiMVyne0y?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4566cc26-32ff-4f9b-6450-08dc49f07b80
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 21:47:19.5086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HV6ZGe8dntr6IGMtivBt5JCDvTbgKKoq3RDTEBatqaZvsx9eTu3Z4vD5ROIE+nqCLKT1nAv+H1i7bEzwvUagUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9413

SolidRun CN9130 SoM is a mostly pin-comptible replacement for Armada 388
SoM used in Clearfog and Clearfog Pro boards.

1. Add new binding for compatible strings closely matching the original.

2. Add device-tree includes for SoM and carrier shared design.

3. Add device-tree for both Clearfog Base and Pro.

NOTICE IN CASE ANYBODY WANTS TO SELF-UPGRADE:
CN9130 SoM has a different footprint from Armada 388 SoM.
Components on the carrier board below the SoM may collide causing
damage, such as on Clearfog Base.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Josua Mayer (2):
      dt-bindings: arm64: marvell: add solidrun cn9130 clearfog boards
      arm64: dts: add description for solidrun cn9130 som and clearfog boards

 .../bindings/arm/marvell/armada-7k-8k.yaml         |  12 +
 arch/arm64/boot/dts/marvell/Makefile               |   2 +
 arch/arm64/boot/dts/marvell/cn9130-cf-base.dts     | 138 ++++++++++++
 arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts      | 249 +++++++++++++++++++++
 arch/arm64/boot/dts/marvell/cn9130-cf.dtsi         | 198 ++++++++++++++++
 arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi     | 160 +++++++++++++
 6 files changed, 759 insertions(+)
---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240318-cn9130-som-848e86acb0ac

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


