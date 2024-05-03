Return-Path: <linux-kernel+bounces-167144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9CA8BA4E9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F741F23282
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3267013FF9;
	Fri,  3 May 2024 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GmA5oCZn"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32833FC11;
	Fri,  3 May 2024 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714699771; cv=fail; b=ijLQ9QJU+Gtg+TnrdORcX+GV7aznTOfRZ9yyUQK7JUBzkZVzJVYim+2lInL73aaBpNn4vKxTvEsEvprWkXs+NbLGS/JobF1boGrTQ+6c+uSt+8oIwe8dVEfCfkNhauYFBpc1WiZVtzr4nHhCtNWPqhz8CvZs+fbAEy8jOfkfK6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714699771; c=relaxed/simple;
	bh=xDHthho3clLMwVkgJtffn/O2I4fbcl26gyOATRJQtI4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YD9b6C09xprAaD3RXRJOi1bRT9JDB3e5DI1j+x1wHzfjPIOm4Ym1GRxrf3sxMIoNNJH8fScmdtNE1mv8uOnWZr4oFSUctARD6tmFHSOlYvZPtkF91eWacYGeVIMBHAsS38qq4GcY1F1yehuyljr/2MDCwCbJdR69KMbXZQ7+B0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GmA5oCZn; arc=fail smtp.client-ip=40.107.20.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgYVBecdsxeJgMvdm/Tlyk9IK0u//1MAd6x0zT+TY/8nd0dXnB1zdfhtPVXUuanHc6pWya7m76L6v+so27PhEkq+0vZSdIkTkai6APeBC1X0j5O6dLbpItpnu/9RBOlAxUOQNFdEJxuc+AWU24YB5uuPqygsEwGFvVgiIOWMRupA2nl5mHERWcC4b/6Ygy6G5TYcz59ZjNUFCBzX32fYhzj4zqQc963E9RTrq2J/mOIYDUjFWfueJ4ZdQwqK3yjEhX+lraZcCdTwg4UyhiYEbgCafKx/qzuW8+EdrTqSmkkGPKyZrwBQXqCszSe6TdvS72QcfxgUvBzsd8WMajrS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3LuyELaiSC0sVNX2XPvkzFPVBktsV4F8YpUGnJ4zDs=;
 b=Ub8R4cKyehfkc22knarkSHyH/JYWFaPx980l+dnkgtvJDuMdGNH2iZciF4d7l2RCLwrJfq56yDAMh1OuVA5llvlxU6IpBN/Vi5ovVQ7ni7SEPF1raXW5whgvE7CFJkgP1ShOpjh38AHdQTGs8SlkkFGQLCffrgnBu47jo9fhYxF3CeXKnNfS9v+7jYQOyrsB9hkhrebEeSWMBdnaHI5I4ge8EAG1WsQG4MlC8v9OsOu9hcjNtLpf5k+2Bfc8/uwCaujhqFBsdLzPKEEk2VqzAMKiIgBzJ5Ad0ZrBweWN0mfJKOqj8ML/4U9SO+SBJwqqW8dukOy5iYrECryrxAJkwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3LuyELaiSC0sVNX2XPvkzFPVBktsV4F8YpUGnJ4zDs=;
 b=GmA5oCZnu9DqHkZRZ8a237vqT5vVmAMQWZ2YrQo763I+4oxbBTRB0hP1Tzl8UKK+aJ6PEAhiniADmicLpJm8oYQg0KJW04hyGj9KaTB4Q9v9NrXDnPvkBcxz7ClfO3D1hDzBeXaxPEOG0XbAbZ9pfDjYsphIcxwAYhvWNdqfVCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GV1PR04MB10275.eurprd04.prod.outlook.com (2603:10a6:150:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 01:29:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 01:29:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 03 May 2024 09:37:11 +0800
Subject: [PATCH v4 1/3] dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-imx95-dts-v3-v4-1-535ddc2bde73@nxp.com>
References: <20240503-imx95-dts-v3-v4-0-535ddc2bde73@nxp.com>
In-Reply-To: <20240503-imx95-dts-v3-v4-0-535ddc2bde73@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714700249; l=938;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=hxkVlQeaJgJhLHSlZ83jW3veqMTWVj/bEjw+HMyTvrY=;
 b=+/QNrRGcNan/H/u0BcVR+bCKw6XWTlPP84iazpVnMN/ihb2dTYkKRjP2g7+EpAs6U6oj0GTeP
 rx/+qw+SKEPBjRyEw/Uy1AlgYwCaQ2tf9awYiZD/BAuIKTyyMtVOTaf
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
X-MS-Office365-Filtering-Correlation-Id: 78013f48-9500-401f-5f19-08dc6b107849
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|7416005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmNmWVFpZG9HZE1rOXBZRVdpVGVPSlpHQktVSUdDQy9FL21oWGgwMHpUWmJY?=
 =?utf-8?B?NytSaXFka0ZqTDBJRElaMlF1VlIxQXg0QVVjS0RhN1gycWhSdHNUemtOUHM0?=
 =?utf-8?B?RGxUOUtTNzhLNUdrdUR6cDlEMGFOcStyL0dSbXJnTDZ4ckVaaWsxcnloUXhm?=
 =?utf-8?B?YUZUdjBDek8rR1Q1TS95ODFLRjByQS9kTjhDMzVUME1uOWEwQ3VqcWZTN0E3?=
 =?utf-8?B?MG5LK2l3OEhVQjQ4NEhuYmxHNmtmdm16REUyd0tNQzJJR2FsU3J0TXlnRXlj?=
 =?utf-8?B?UTRzbWx6VitIZWtNQitPTHRtUjQ2VlF6TkFWOEg3SEsyN3F1RHRGaXU3MVIr?=
 =?utf-8?B?Rk00Zng0VVlwZml5YjJuM0lZVnVLRVE2S3VzUkJEUGt3Ryt0a0VMODRrd0gw?=
 =?utf-8?B?Tk01cml4R0Zyb2RrOW9UeDZLd3VVZVY1TjcwR3RJT2trYTc0RjBERzIwSlVi?=
 =?utf-8?B?N284THE4T2UwQ2tPTDVFdkNrdHZkY0dKd3FReVR4Z2tyYWovWTV6Q0xTUkVa?=
 =?utf-8?B?YjJDMHR4N2YvZTZ4N0h4aFlUOWxMRlF5aFplVmQ1bWhoYlF0bHQzbXJ4c09K?=
 =?utf-8?B?VFdGeVpWSDdqSk5KanRqdkMya1UvcWZHSWE3Q3RUOTlldUJVcFJxQ3hhVDlt?=
 =?utf-8?B?L2NlbDF6WnBaTzI2S3hHNVljbUxPbEtWQWg1Q3pBTlJhWFBkRHJJeC9UOHdF?=
 =?utf-8?B?cERGbENkeGFPdytjS2FHSnlCeFczdlBRSFFEVDhSSkJJY0txOWxsZDhKZDVZ?=
 =?utf-8?B?c2lKVXF3L204TnNqeHNQelEyWEdKdlpJN09IUEMzTVpEUnJxMkt4UDV6aXp3?=
 =?utf-8?B?NXZiaE1RTm5uUHhRM0VCVUxCUWNCcjM0WUFwaXJZYUpxMFZlVk9yM2kxbzFN?=
 =?utf-8?B?L0VUcWNBWURGZFJXQmNYV3k0bjBqMU44Y2xZWlpGRnNHZkYvRXpEQmo0TU8y?=
 =?utf-8?B?VGtIaG0rb0tWVFVibUhtNjFoVm1KNU9SNlFaaDRkNTl2MG5hYi8xSk56b25L?=
 =?utf-8?B?ME40TzdoMlZvRDV3SGxQL2RodnJjWXFhdHZ2UlBCV2NrbU5RRmVVNkhvZTFq?=
 =?utf-8?B?eDhzN21aR2crcy9ma09RV0FSSHg5NEVmL2FtYUJINDlXWkNXanErT2VDVHY4?=
 =?utf-8?B?ZW8zQ05wZ3JwQzZva3Eyb2dWcEkwZDQvNEo5WElPNlZscjhoSitLNWNXOGUw?=
 =?utf-8?B?VVIyRTFwOWFFdUQvM3VPNFMzbEcwOHdsRUpOLzkyc2FIOXlDWkZNbENUM29B?=
 =?utf-8?B?WWFMMlAyMUptb0dsejJlQ1ZMVStaQThmNDFFbm1BdHpkT3RQUDQwT1hpampx?=
 =?utf-8?B?MEI1KzRIcUh5TGFUWFExVEpoQUxoTmpEN0RDdVBHcy9kd3lUMys2UmJmdkwy?=
 =?utf-8?B?MTZBMkdiNXRiNjBNa0RCdkQ4ZUdiZDJVKzZTejB2UG45K25tZjJtUmZGL1hT?=
 =?utf-8?B?R3dmU3VvSzVOOUpTYkNvUEowMEVlK3RvZE1HTzNBdjBReGtGM0hxaU54bEha?=
 =?utf-8?B?OHZuNDk3bjd3UzNlaXBnanYvMm5Sby9Ub0VxMnFqZUJCV3BUSUdraHh5MWto?=
 =?utf-8?B?ME1yNDRSNmZuei9mNjVwTVZaYUVpM2tHNDNoVmFMNjdnaEFyWHprdmVsT1Z5?=
 =?utf-8?B?SExpcFIxZldYamxneUJuTnVjNndnTEowQnc2cWltdTJkWFJOYUQ0dVVSbzFv?=
 =?utf-8?B?WlhoQWxkNlFKU1Fyb1F0ZXlDdlFaYVIxQUxzL1E3cktheFNkejRKMGZKcXRy?=
 =?utf-8?B?eVAxY0VPbnJwOGl3a2ZCdFhvSW1adU9pU0VpVWovUkpOdkQ2VjlncGtjaXNY?=
 =?utf-8?B?YWlSN25NNjUwUmxNc1BQQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm1tTnFaeXRIa3E2b1lJK0lVWXZLN3lSRUxwZXJDWHpXY25CK2VOaFVjUm00?=
 =?utf-8?B?QldHNFUyVEsrOEdQYXhFUE0zdmhVejdBWDVHYjN3ZFA2bTc0OTh2SG9scU5s?=
 =?utf-8?B?MmZrc0d4U3VSVkNldmRBS0NRMStLNzBJZElsMTNOZXRCSUZ6WkRsOXA3M1Vv?=
 =?utf-8?B?WTJMQkxvNi9VUGdLaGUvOS9BcE5tdTJCZ2lEQ0c2dUgvUGR1RjdlY3NIRFp2?=
 =?utf-8?B?S0JQVW9kbzJUUzMyL0J1RDk4MFA2TUp5T3BpYTY4cXk5VVJidC8zK05NdlNP?=
 =?utf-8?B?Wk5YbmU5Vk8xdXNwdjFGcVg2U3pHQ1Y3TStrRmttWkxMU3lUQUZvWFZJU1dQ?=
 =?utf-8?B?MXVpUkg4OEZZS1JBbFNLMmJpSEN3TzBnb01LOFJkOUxmNTVjYThkbHhlMmtZ?=
 =?utf-8?B?ZDhnZEpXdk94YWVvMFhZTms2ZkpiUTlNYzRPWElINkdhOXVZU1FVV1hFT21L?=
 =?utf-8?B?QitmdzlJTmxLTk5XK3AwKzVrU21lc3pNenFvcUFLOTlhZ1FGZ3gwWURFbHBi?=
 =?utf-8?B?UE1mZ2p5VzZCQkFxUlJNV0lhSW92NjJZRjZiVnZmZWsxQW5BUHhJZmtjWlJG?=
 =?utf-8?B?V0ZDd09Sb3IwajlmUHh4TW91Nm1RVEx4OHZ5alNEUS90OXpBTmRyK2p3eVJ0?=
 =?utf-8?B?Nm5SdDJza3ZReVNzMlMydG1mMWRtZ0NoSFQ2OFlWcDZyYktEUll1OU9FeXFZ?=
 =?utf-8?B?RUNtc2lrRkpVRVo2djc3UG84VGRDbGdUa2wvdWZtQWhxSlNRY3I2MnZEZWov?=
 =?utf-8?B?bTVkVDM2MS9MbFloK2lrcEY4Njh6SG5LbDRUOXM0RFhqNm5LL0NzcTQwaGlV?=
 =?utf-8?B?c2t2S01LVXlNb1g3KytDejh1YlR5clZZMDFZK01UZTYzeUlCdkt0VlJQY2k2?=
 =?utf-8?B?WGNVSU9LZEtiS3czeUF0MlVyMXFMQlhLM1A0NUUreWVMZUVldzl6RFJxUXlZ?=
 =?utf-8?B?T09Ba0RVRUpHcTluQ3dNaXhKd290amV1K29TdzFSaXRxeGhMd0o0M1lCdk5O?=
 =?utf-8?B?RGhvcmExNlovZEMwM3Y0UU1oNGdib1F1WmxrTk53NEQxZk5UWmpoWXY3VlZw?=
 =?utf-8?B?TytHb0FyNXZRQ0YySFdiTDl5QzFqYTdnd1gvaFA3MXdtUmNhT0E4RTVleG84?=
 =?utf-8?B?K0NJaUlqdTQvdnNsRWtJdDloRzkyZkcrQTM2akw5dSt1YjBlSjRaT241d0xa?=
 =?utf-8?B?MWlQSzRuS3F5Zk9PV0ppcU5DRXF4dkdoVkV2Zm9RcU40aU1LY0ZaaU15alIy?=
 =?utf-8?B?NGtnRXRWMkJWL2NxNjdHSENHSW8yNjJSeDE0dzZkYWdkbnNGS0padWhYaUVj?=
 =?utf-8?B?NU5RSWtvRUFrVktPVEIzSkw5OU5LVTNKTFdHdXArVnJHcHRQejVzcnplT09F?=
 =?utf-8?B?MCttY1hTcWt0bHByRmxOUVlmVDhUVUgxdXFQWjdWTnVDV05WNWFzMUJtcDll?=
 =?utf-8?B?NlMrdkdLSElhaW1SdjJMY3RpWWt1SHdFVlJ4bWRqVHdMdldIbE85ckhEQldh?=
 =?utf-8?B?RkRiQzdxY1E0Y3VFZHZCeUtoM3lyTE1QV3c4Vys1QnAxaHVvR2piNmw1cGRI?=
 =?utf-8?B?emluckswV0xReEo3YXAwQ1FpdHpPWTdHelBQb0ZMdlJ3RlN0cUtCTEtIOXdv?=
 =?utf-8?B?VDNMcVppNGI0SmZqSnJ1LzhxR1BUaDR6a0hYblVrSGcrbFdnRi9INEdLdnlP?=
 =?utf-8?B?NWhVNVU2aFVzN0s5YzAxWVYvVUFCUGNmNG5EcHh3Q0dTK3dhQTJmeThnMTZR?=
 =?utf-8?B?ZFY3b2lKdzBmNlIwcGxRQXZHRk9namxvZVgzMmZzbldqZWpwU1RrNHVTOXBr?=
 =?utf-8?B?elBWNFBxUEJaQ0dDbFlyYW00N1lTUDUwUzZHK1ZiOE11QTBWbWFkWGpGWlI1?=
 =?utf-8?B?eGRHaEY4eFFaUjB0cGx4M3hpY3lpek1PV09RYzlLaVIyOTJia2JUU29MZ0wz?=
 =?utf-8?B?VjI2b2N5UWd3YlVSVFhIeHMydWRyVDI1S2FJanYxekhqaXdOK3RVR1pxczJG?=
 =?utf-8?B?K0tKU1VoTFRDS3grZ0hLcW55VkRib2ZGVFdGWk5LT2F3ZGV4N2dHQlNMTVgx?=
 =?utf-8?B?Q2xrSm9VeWpJU1hzQ0VZbmd2VUVyOUVBaGJvZTZBZkFreG5OQjlkR1o3RkVD?=
 =?utf-8?Q?oHb4zT2DdJEIxZrTffhknUC8k?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78013f48-9500-401f-5f19-08dc6b107849
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 01:29:26.2415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //pCiyfm6g/x585jSawH1c3msif91G2BbfGBeAHAs/H+QgMhUbs6xlOEjQIkXS/ljBOOmp79J8XeZZm/5e+UhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10275

From: Peng Fan <peng.fan@nxp.com>

Add DT compatible string for NXP i.MX95 19x19 EVK board.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6d185d09cb6a..5c9014087c17 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1275,6 +1275,12 @@ properties:
               - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
           - const: fsl,imx93
 
+      - description: i.MX95 based Boards
+        items:
+          - enum:
+              - fsl,imx95-19x19-evk       # i.MX95 19x19 EVK Board
+          - const: fsl,imx95
+
       - description: i.MXRT1050 based Boards
         items:
           - enum:

-- 
2.37.1


