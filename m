Return-Path: <linux-kernel+bounces-167143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1F38BA4E7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46FE7B21F3D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE66F4F1;
	Fri,  3 May 2024 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="j4bS5zlY"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15154C8E9;
	Fri,  3 May 2024 01:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714699767; cv=fail; b=TiogFk4A+t0f1omjX9JVxl9tkpk2vAEH4DGxoA2s7wHmcnvwyl3sHWd8wiFoeWdPMqGQJYmnLSpZr2oVJZLr9CDtCyO9cqXyVDUHkjOwyMZeA4gAmTsPT/tZxYT0PZnIadPgNepMqi36xfviW+zlAkyMST0PbdNqmy4FjvJSURE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714699767; c=relaxed/simple;
	bh=ToByqXTd+J+wEHnl8dJh6EPJOj5HlphCVJZ5xJ2060k=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=M2N7nQNGAuMoHDmhWiuR8M5EJKmG8yva+hUAcUG9DzmK2K/F3P8feDLlUxHIAw8V2leqAcAMeC0jHCArmkCmYd3p6tfS4IYG0Wia8AAaxAJGVGrGOp0MvN1tH+LUIxvuDbLzw0EOKLDl2aDM22nvvfTR3DjW6djFkhD28R+uGzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=j4bS5zlY; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoTRrdTATZt3cfK/CTUoymIPOn1Pg0ETQ+7ZdtYJ+4WmNe7AI6lRhfoKPqtGa/5s5/fCVtSuUWtSi/rn8H5p/801f4Pq7/Vthf1w/qwZHHTIEXDPzx5aii3lLq8M572LLAAF3j2Qz4KfysOZ6qA/evzDHCvtkHhFn1zNt3QKTC+L0aZM/XDusQj/UcaKwIk7i4ciWPyphYvh56GcuF8XR+Ri1rNvcoSfp4LZecAqgb33Ha1Y2vplF96j8ZltOCZ5iHI6vGvjBkf92br/KV1OCPaQ6TnXubYVb10wcXzxNpMl1iVXunR03fpoTCeX7eKTPgAgtiRYaE9mTNlPHEOrHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GzeC7HjenPqQMt5aVdQSp7CbFRWMtvkczZ7J71L1u8=;
 b=JI1cjrsuAlA3JrgBcumGAiGMqIt2EYUmf74zBNXYwXk/AuM2I/PjTqfRsvNi5EDps3cAvvL1m651ck6ZNcw2iOA5/9HexJPpWJzG6o4cHRYYROkv0Dkv+EeYUR9qOtwgNFN4VPmbs0wQAju7ic1aUh67HdYOC0GVaCWkx5YbDddFEDPCkpXcCPapUzqsXi2uQ4ILtaQ8hO2K/26TybB8edBSXn/uXfD51tsgxXc2XM/mou5tysJcZuyxPmdfME0DL7gbwk2qXDdsCb8gGISXsc2ubTO2irDno36QU6fJlm4Yt4WNIiRa1PyKVz7FL1iI9fXjDCuub9rcUeWkCwxURw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GzeC7HjenPqQMt5aVdQSp7CbFRWMtvkczZ7J71L1u8=;
 b=j4bS5zlY3GY70buZVNocGj4b2GMLQsFtiTJIhkC0jKA+2yAkI/8IUto2WcRa1TpG36fo0N9VPs3E9WD6GdidpM2T6RN+W0dkLVYl/J1HtHYylJPAuRqJtlqRpUBcBm3Yq8aa2ArrhUbURYFMjZPt7GryhdZzPRwv1NbKpPAFJXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GV1PR04MB10275.eurprd04.prod.outlook.com (2603:10a6:150:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 01:29:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 01:29:21 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v4 0/3] arm64: dts: add i.MX95 and EVK board
Date: Fri, 03 May 2024 09:37:10 +0800
Message-Id: <20240503-imx95-dts-v3-v4-0-535ddc2bde73@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMY/NGYC/3WMwQrDIBAFfyXsuRaJ2mpP+Y+SQ03WZg/RoEEsw
 X+vzb3wLvNg5oCEkTDBozsgYqZEwTeQlw6m5eXfyGhuDD3vJZe9ZrQWo9i8J5YFs4jKOI5KGQt
 N2SI6KmfuOTZeKO0hfs56Fr/3T6iNs/tNCaOc1ta4wZftOoUVxlrrF5TVgMmmAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Peng Fan <peng.fan@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714700249; l=2153;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ToByqXTd+J+wEHnl8dJh6EPJOj5HlphCVJZ5xJ2060k=;
 b=9ZdVX9ZhBTfZ/zRRl7JqxY6oVATZhkkbMDNs5OUrOtu4bZhbJ21bGCVYgGsRnTRYRam2Yeh2e
 ZhePxYKAKIIAZy3h6CJgrUBhIgDVRyPZ6EdAAcWvj56BZwgHhRhLppr
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0226.apcprd06.prod.outlook.com
 (2603:1096:4:68::34) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GV1PR04MB10275:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c7ac38-019b-4a2d-0ac4-08dc6b1074e4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|7416005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sy9wejVlaHd6M0NvQnlMcDVDVmVpTXp2OUhsdWtlT2loeFovR1NEcmY0MGZq?=
 =?utf-8?B?bVJBTVNHanFJY0JmQ3ljdGlKY05QWTJzYncxckZvcjJJMHMyQ3JPQ2pUb3BI?=
 =?utf-8?B?L2h4L3ZLb2ppbTNNUEJMVUpTakpuOTF6M2VkcU5FM2kyOHVnTmJSMlBtazI2?=
 =?utf-8?B?ZFBZankzRVJ1a3Fqb0hEV2ZiVGJ3V2JVMUlMWTdUYk5jeDBmYzRrbFp3MzNM?=
 =?utf-8?B?QXhybm1vK1hSMnpjUlZQWG5zUVNzcDYzaVdrLzdQVFZ2alZleExzbWIwRytr?=
 =?utf-8?B?a01ORlVGV3hzd2NkVUI2Q3hhOGU4Y25CTFgySEZobjRoSTN0U0xRUUJSOTRE?=
 =?utf-8?B?R2pZQy9iSmw1MTlNQWZReVZ2anhNNERIWGdEeGJLemF2aFQwU1VFbGthMC8w?=
 =?utf-8?B?ZGtjcWdYb0JtNVdGd2ZkL2pDRE9FVTBnaGRSWUxuUjBjZXlwUGt4ZTRiL3BV?=
 =?utf-8?B?UzdLNnFEZGlleUljc1I0MjFQbW9vUHo0YXIrZnBvRjBDaEZpalNxZi9WRVZ6?=
 =?utf-8?B?aEZLZFRXUC9EWnM2eS9mbTIwa1FrbnhUSTNWSUxFZnBGYWQ4WTVXNm1sUjhP?=
 =?utf-8?B?a0xkbXA1aS9HSGFaMmRTc3NoaVhVVWwySXBqNWhqdDR1Vy9GeDhReXpselpq?=
 =?utf-8?B?RldadVRUQzgrN01TQnpTckNKY1NvM1haTDhwU29LbGlPQnBqQkFrOFBVNSth?=
 =?utf-8?B?VVNyaW1iMmQ3Qmk0OXpLb1FFempyTGJOVFFmWEhRdUxkRWV2b1dtVEVTZmZj?=
 =?utf-8?B?RThLMWVpMzRjZURSSDN2aFRpTTZxZXBVWGl4ZEViSXVPS1RVRjhxVkIwY29J?=
 =?utf-8?B?RCt4eit6TldPU2pRbHJuSy9zTWtweVprU2hVQjFINkVOd3hTUTVQTDFoa0V1?=
 =?utf-8?B?ZEdtUjBPRjB3TmJ5SXFUSnRWcTFJQ3dRYW1uZk1YWEhLcWhlYU8vek03dGhp?=
 =?utf-8?B?eEU1NGkrbm04cDlGMnJHekxmdktjS25RZmlmdm9UR2w1RWlacytOR1lqYmZm?=
 =?utf-8?B?b0JDdUh2dmRHTW5pOGpiT0FFK0V2WDAyMStFTHdqbG5LTTBPQUhTTjMvUXZq?=
 =?utf-8?B?eHR6TUhVamJLTzQ4QWgxcXBuRDBISFp1T1g1L2JkYWp4NEcxZFdxeDdRbUlr?=
 =?utf-8?B?eW9PTlVwSWg2QVNZNjZOMVNLazlnMDR4dGx0TTZUaGdXR09mV0FLMm5xZkpT?=
 =?utf-8?B?VFVNMHRxOExtMFYyb20xenBBcUFVTm1QVm02c2tyUXVsaG5XQjF1eGtSNmJQ?=
 =?utf-8?B?bVZKODhxbE1YdTFldTk0azJJM09hb2R1aW5samVqcnJnYlkxdUFQRFFDb3dS?=
 =?utf-8?B?MDYwbElNL3Fjc1VSUFNSZU5WdDY4UlJheDFPOUpHcXZOZTNEUkV4WlhYSnE4?=
 =?utf-8?B?NlpDdndNNElVcERTOWdZMXA3WVJabWJ3YnlUY2x3WkVEOHY5TGJ0eUlTeWQ4?=
 =?utf-8?B?ckdrVnoxSDQwYkhPZFhmclNVa0lLV0NQZ2w2TmhzMzNqdklSazV4ZnVXWW5E?=
 =?utf-8?B?ZkZjdm9kTDVsMWlNeTRmekc0ZUlwY09oeStnRCtQaU13WlZuNkpCUkxoK0ph?=
 =?utf-8?B?b29MRWd4akc0dlJDNzhHM1dLL01FVk5VRFY5WkRxSHpteE55UTA2K1I4WGVQ?=
 =?utf-8?B?K2xqTWNDMWhiMERSTU1uSzBwdDl5MnhNTmFMWGJXL2M0YUFudWZjTkJORUls?=
 =?utf-8?B?K0YvcnM2NkhtWi8rSGlWRG1SVExqOUI0ZGFYd0RRNXljUG16Tm1uV2ZiVCtu?=
 =?utf-8?B?QkxkN0Jld2g0NXlRcW5jMmY5YjdrT0d4R2tpVFMrcXZGTWl3WGR6ci9scDdz?=
 =?utf-8?B?QUF2SWE1NmZwYUMxenNnUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2syeDdEY1l4NTRhcHVKNE8yd3hjUUphY2RFRnJHYWw3SHoweEs0aFNNSitJ?=
 =?utf-8?B?elBiZENGRUZ1dkhadVBSQjAwdlpGSDRZdndPSG1vYlY3dTVodEh3Q2ZUMDdX?=
 =?utf-8?B?WEFRVXErdmpTL3dSaTY0S1ZxVHdTQ2NhSkQvMVZZZGdoMHJ1bDFRRFhzYlVv?=
 =?utf-8?B?eFFldFcrbUlhRHhhMmVhYTBtemJwSEpZM1NwbFh3aU9hbVh2L1YyVG85SnJq?=
 =?utf-8?B?b3VlVTVSbkMySWNoZFhwZG9HWEVvc2lBcjJtZ3N2Snp0M0xwUDYrdENYNERT?=
 =?utf-8?B?QUUvODlTK2huMnBRVkE3dVRMYldwQklON1F0RThsb3gxU1VQVUpjVDdIbW1L?=
 =?utf-8?B?ZnlaUnh0NnN4NEtqOUF6M3N1WGE0bk9lNVpuZ2kxVlVBeXl3R1lBREwrMDJa?=
 =?utf-8?B?Q3kweWhxbWFJRS9RWHM4SkJPRWFyRDEyTjBkSFRWY1d4RjZIOUQ4M1RJWWFK?=
 =?utf-8?B?dWh5OENFZ0VFLzdEd0QwQjFGU3RnV2NMTWRjTi80bUxkekh1dEVPVVJkeUhz?=
 =?utf-8?B?eTR3b296N1kzMDlzL3pZalR0QW1ob2VxelZhSFRVSW5DUE9kMWJ6SnlNYXV2?=
 =?utf-8?B?R1lSaHl4R3N6d0Y1eGFwUUNvbmhjTTBDVlladlhOTHpia29IbGx5c2hxWTJq?=
 =?utf-8?B?N1hEdVU1UmFQVW11ZjlXT2Qwc25LWWMzV2pJaGxvR3lYSGN4V2lCSEVrZWhG?=
 =?utf-8?B?RGtScTArWVRvWk52Ymc0L1NaejdxdXVhaHpzcnF0ODFHSmtRZjdFNWRMa0hK?=
 =?utf-8?B?OGNFcnQzZUFneWUyNWl5cDVtaUpscEw4TGpvaC9MbW5UYXF3RzQydlYydEU1?=
 =?utf-8?B?SkkwMC9KOXF4NWp3KzR2QVRPbTI1SzgrUFd0UE5XeUFjK3pTWGp4YUhpWEg0?=
 =?utf-8?B?Vzhyc3NVUHFIbVRLNU8wTSt3NnlFUFhJcldxTUlNQk9VdjhPZ2ZQQWppSUQx?=
 =?utf-8?B?ay8zdlNIUWxDMTlFM24zRFp4Z1gwaDlMZzlhZlA1SkxXM2tQNk5OdEY0MWNz?=
 =?utf-8?B?K2c4U1IrL2czNjU4OElxa2VYNjNDTUMxWEZWSnZDaVpVeGNRQjJFRCtaVEMr?=
 =?utf-8?B?RWlvUWw5S05vS1A5NlVTNDVwQVFmdjF6emc4a2EvTzFEb0x5NGwvdjRLT2Zp?=
 =?utf-8?B?MXk1RGpLUmtXUVhlNHNVRUpHd2tCYXdkL3g3eXJHeUllZUJlWUhaYWZNTThP?=
 =?utf-8?B?MFRKMjUrOFRVNGFZNE1CVGFUV0pXLzFFdVFmWmlDT1BTSkFUNXIzZHhCZFVR?=
 =?utf-8?B?UXFzUi95UkFrK1NINVV0WFk0NlJZVzdCNDJnVkk4dHdHb1pycU9pTHVxTUtH?=
 =?utf-8?B?dHFVVkNxYVd1UlVrVmMzU2JTMW95WDFCd2JpajNEa3QwVFpwZWVXOSt5am5P?=
 =?utf-8?B?blBHbDJDdnNLaGF3azVtL2VaNmlEWFFUY215WEhyd1RSNTJNbTFwVXJ1dDAv?=
 =?utf-8?B?SU5Hakl4WEJTa2tOTDBNa1lKWElSQUR2ZHh4Vzd2eWdmOUVBOFdHbDZtS1Vu?=
 =?utf-8?B?UHFMVkNlU3g1ZjlCZEJzSUpOb2J1MnZ0WGs2ZzZGVkFVenowemZ2SGs2eFFC?=
 =?utf-8?B?YkhzakpsYXcrbncxcGJhdCtTOTZjd2pBUHJLZHZJaUczeUpwRzZ6c1hBNVI0?=
 =?utf-8?B?cUFGZ2FiVUlFV29uWmpnd1RHYkZ4NDZIK2ZRL3NvUk9wZ3lINnBlbm50SENW?=
 =?utf-8?B?UDBTVDROWUs4cUVHckpDR1hlbXBUSHU5UmJOMWdhL3EyU0xlaDRhcjUvY2x5?=
 =?utf-8?B?QWIwd3N6OFdpVk1IQXl5Z3hvVDZCeUlvOXFMbUwvMVllMWh5S0d4aXQ1bG1w?=
 =?utf-8?B?MHhEdXRGbXZGZjV2dkRjbktEUjEyOUh4RkxHRVVOWHN5OS92V1FLNHBkaC9T?=
 =?utf-8?B?a3Y5dm9ZTW9sUjc0TkhZY2tSaVdpQkVZRU05ZVZnb1dKc1BNQnA2UGt4Mmta?=
 =?utf-8?B?T3Bra2d4VGlJK1BJOE8weWkvYVp3enhJM1g3M1B2aWFFUkdPOUwxWVBNNFdW?=
 =?utf-8?B?S0FmWndTdUVZOXdaNWJyTEVYdjRHRVd1d1kvSGVsVjR3STNNMDE5R2pYZ2FG?=
 =?utf-8?B?b0t5a1pYVmM2dFJMSVpxVmgxOGVWZW9VUEVlWGRrWkdpTmwwSThLWitUaUhs?=
 =?utf-8?Q?dNDS4YSRpGZDpssLm5LcHldIz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c7ac38-019b-4a2d-0ac4-08dc6b1074e4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 01:29:21.2502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZ5cI3RXYPOchMGjP7z9VVAjfqYHWDjpPFKgrMZFam/nWTNU/uWZy2AiL3yC8aQLOinaSJP+CNIO44oNIrtKGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10275

Add a minimal i.MX95 dtsi and EVK board dts.
i.MX95 has a M33 running SCMI firmware, but as of now, the scmi pinctrl
driver still not ready for i.MX95, so we count on bootloader to
configure the pinctrl for lpuart and sdhc and it boots well. After pinctrl
driver ready, we could move to use scmi pinctrl.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v4:
- Sort nodes by address
- Drop coresight nodes
- Align clock rates for SDHC1-3
- Drop wdog3 board specific property
- Link to v3: https://lore.kernel.org/r/20240428-imx95-dts-v3-v3-0-765395f88b9f@nxp.com

Changes in v3:
- Drop irqsteer node because binding not accepted
- Pass dtbs_check
- Link to v2: https://lore.kernel.org/r/20240226-imx95-dts-v2-0-00e36637b07e@nxp.com

Changes in v2:
- Addressed Rob and Krzysztof's comments, and fix dts_check issue
  To pass the dtbs_check, need apply:
  https://lore.kernel.org/all/20240226070910.3379108-1-peng.fan@oss.nxp.com/
  https://lore.kernel.org/all/20240226130243.3820915-1-peng.fan@oss.nxp.com/
  https://lore.kernel.org/all/20240226130516.3821803-1-peng.fan@oss.nxp.com/
  https://lore.kernel.org/all/20240226130826.3824251-1-peng.fan@oss.nxp.com/
  https://lore.kernel.org/all/20240219-imx-mailbox-v8-1-75535a87794e@nxp.com/

- Link to v1: https://lore.kernel.org/r/20240218-imx95-dts-v1-0-2959f89f2018@nxp.com

---
Peng Fan (3):
      dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
      arm64: dts: freescale: add i.MX95 basic dtsi
      arm64: dts: freescale: add i.MX95 19x19 EVK minimal board dts

 Documentation/devicetree/bindings/arm/fsl.yaml    |    6 +
 arch/arm64/boot/dts/freescale/Makefile            |    1 +
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts |  112 +++
 arch/arm64/boot/dts/freescale/imx95-clock.h       |  187 ++++
 arch/arm64/boot/dts/freescale/imx95-power.h       |   55 ++
 arch/arm64/boot/dts/freescale/imx95.dtsi          | 1049 +++++++++++++++++++++
 6 files changed, 1410 insertions(+)
---
base-commit: bb7a2467e6beef44a80a17d45ebf2931e7631083
change-id: 20240428-imx95-dts-v3-bee59f0e559b

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


