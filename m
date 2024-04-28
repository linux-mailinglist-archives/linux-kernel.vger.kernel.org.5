Return-Path: <linux-kernel+bounces-161414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4628B4BAD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08EEA282154
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821F16BB4E;
	Sun, 28 Apr 2024 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DqTCcPZn"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9E46A8BA;
	Sun, 28 Apr 2024 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714306478; cv=fail; b=MWqzW61Op33qw3XUTWwoNMIq78f8wCYUXuBSemmEptw9Yk5eV7DBkQH0ywkotlOOp3qR0NUzQuzGLJ+XcYSADRwFt9Cw7zQ/RmbeDvd4eEgYQ7FtYmE4Y7UkMMuPxtRMLV0aB3lpo9Gv/DgzBVBI3tW41b+y4PZr3cUW0TGs5lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714306478; c=relaxed/simple;
	bh=xDHthho3clLMwVkgJtffn/O2I4fbcl26gyOATRJQtI4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LpaSm3KMJ0etxGO0r3IHdZU2TlB6FwhQmLBoU+RwJuXqLBg5Rs4K338US8Nw9EDC9mUcbdlBn1tvUuETtxJadG30IsDrDgIITtc8OeY5PttbyF6CMENbbpYs4apu2TVKiARANoHJoLQ1Kuuwr/uvceyAe96F5DsEEW2cLtb25W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DqTCcPZn; arc=fail smtp.client-ip=40.107.6.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+asS0/lCa5r+Q6EraUwdnubJ7c7fVKMbtJ38lANufIzpfX/rQZdAAWaAJNVx87NOsTlFEDKfbfdUmbBmrV4ygy68Ji0Cbi3Lh/wuvW2TQyzZKFiVtZrb7qWlahxdhekmOti1vtlSlQzCwU9Mtn1w4t8C6Fu91VPsgCb12wHsxDFU1fptCSu5zryek3E+RJS+zpbbfhwkPm4dTejjnEmnASM8qzLVICBA/UtjjfgKbtmp9sFTVblbe8OZk19p6drhG8Z3lucB33hg0CiukpKqDkzBlrdtEMqw4+hR2SLYSRMnHcY52akHrsS5+jSWMwQYT9k+L3Kg0H9Jd8oZ/xMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3LuyELaiSC0sVNX2XPvkzFPVBktsV4F8YpUGnJ4zDs=;
 b=M+qT96rF0khmvlIFY+Z1vjX7YItlQ8Renm0zJUph+/4TH0u/vFWvLlPi18fS0GCW1cR6nAHQuHJBIviZRX2oZglEkJzAPQCSa7vCJpI6NZoln5dE1wjPfI0RkssHe/AaEnZ9MVcd9MPrS82FaBsotlw3VytH3H1LoyOGZt1C64oxt/6cHA552EDAVxGYqnppfx+m1ZYcPa6FAP+xHuDmbi4b3gvPyexsovX7N02EOkOHgDWqA4OyIJ7DgBqKAouv5kf/8GrB5560aG/wH2yoQiM4Hq/34l3cVjhMSGl/1nMk5z5ZRtg0Ryk6BqUNnetrLwUdYB4KdxCmDoCPemrX9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3LuyELaiSC0sVNX2XPvkzFPVBktsV4F8YpUGnJ4zDs=;
 b=DqTCcPZn2htJ6UZpLqDcRewpxI0yKrkXiXXKtG4chhDFWtpE7e6dQw28AD/4WO+ZDHRgK10Xuc5w9954JfHRHwkLEX29j6vA7PvrEiNidQirMWsALy4sTzPKRZojs2FeRcducY0TQcjWh9AzVqiR2/Xw3zNoQ3z9vHZtVJWZxVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7018.eurprd04.prod.outlook.com (2603:10a6:10:121::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 12:14:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 12:14:34 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 28 Apr 2024 20:22:19 +0800
Subject: [PATCH v3 1/3] dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-imx95-dts-v3-v3-1-765395f88b9f@nxp.com>
References: <20240428-imx95-dts-v3-v3-0-765395f88b9f@nxp.com>
In-Reply-To: <20240428-imx95-dts-v3-v3-0-765395f88b9f@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714306959; l=938;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=hxkVlQeaJgJhLHSlZ83jW3veqMTWVj/bEjw+HMyTvrY=;
 b=+PkTKoznoyBQqW+NxfcpHtcNox55396zloHrQZ7GubGyMQJBQI+EMhxBH3w5p93tyrCaunvWv
 uO6+8g2OTUwCAO7sKDfgtOws5xiaT/fASXJQ5+8pvdw4cP1znkMQChm
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ce1366-8a87-4489-1064-08dc677cc3d5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2tYTGhVOGZSYjd1QnE2THB3L2FZTTdmUnBhQVNid0NhQ0JlcWExREFsK1o4?=
 =?utf-8?B?RlMvRVlpdnMyWTVKODllcVlZV1ZsdHZJU0RSdDZXZFhrQm01bTVCQjMybWgz?=
 =?utf-8?B?bncwOFlZL0RzZUNmbWwyRlZmbXJ2RzRDaDhJVld4VjFZYTFqVFpqdWE3UHFU?=
 =?utf-8?B?bm56eFhzS3dnT0FtOU9pRzVSUldQMTJBZEp2VDk4dlcycUorakdtVVZacG5i?=
 =?utf-8?B?NkY5V01KQXc2UytYYzQ4RlVMWUU5SFo4NzF1a3VUaTQ5YXdCenBRMi9mM0Rw?=
 =?utf-8?B?cnFVL3BJdlkwK1o5RTVld3loUy9WTktSUTNKZjF1eDdUa2FzKzUrMDhKVVJj?=
 =?utf-8?B?bUtvbXR5UE5IZGo5NzFwbG9pMW43enMxd3Z4T1YzVTVNblVzL0lncEtkL0t1?=
 =?utf-8?B?T1d1UmpLeXZkdTM2VWRuVVZRcWpYelJzMXZuYjlmK1J6eFc4MEZnbTR2cEdJ?=
 =?utf-8?B?N2liYTJadHVqNUVzK3BOeEYvVXdHU1RZVVNSN0NxRzJ0TGtEUlRDMi8yZER4?=
 =?utf-8?B?aGFacnZoQWZ5YW1BbjdreXZMVHVCU3d6RHBDQlVyUy8zcktkK1lGNzZwQUMz?=
 =?utf-8?B?UUN6K3ZJajFuSjBjTUU4YzhLemxCSVdaV1JvL2l3QzZjeWFEM1RkNmZhYjVk?=
 =?utf-8?B?cVdJUm5NaDh3NEthWnAzaVVFVDV1RnE2QkdEVFhRY2psbytTL2M0K0luMzRR?=
 =?utf-8?B?TWZmdkY2QnVhclFEZ1JrV05zeGY0L1dEZkY4ZXNDS09rdkJmcWhUTEN1TVB6?=
 =?utf-8?B?dTlQQVZWcVdIaEFsMm9ScW9xUUZqSm5DM1R3UGhxY00rZWxHUVpKQmlUdnZV?=
 =?utf-8?B?cjBLZUdXU2NScExXQys5UWpHcHc2MVVUV3Q5NWdFT0FOZUlWMXR2TXhscXNG?=
 =?utf-8?B?Q0xsRnYrSHAvL21nWjdJSkUzeWF5QWo1b0NHRUEzV0kzZHlaYUJrR04rcVA1?=
 =?utf-8?B?N3c1b2ovYWZjdmd6ZUl0Mmo0SkY1SEtYZExyVlF3aFpmL0d2ai9LYmZiWGZM?=
 =?utf-8?B?M05GR0FVSTYvZWVzUDVSOUZGR096aE4zUCt5YURPNURYSVJwNlRaQTIxcUZt?=
 =?utf-8?B?QmJXaFdPNnd5YVkzRG14bGZZdU51VVRwcnMvZ2VXZHJxTXVJZGwvbUVZbWQ1?=
 =?utf-8?B?dlBFV1o3T1djZ1NEWmRmRGQ4cFhFU1IvVW1BNVkxZWJXMEd6TThSemVCUlZh?=
 =?utf-8?B?QlRCUmpHdDZwclVmM2IybFQ4ZmxWQTVQRGpVMFZQdmpmSFN4L3BNVU9Dck1G?=
 =?utf-8?B?T3ZEaTh2K0xVOFExMXVCdVhIZ0hNczM1VEN0TTZYSTNJdjJxL05vdkNCRS9v?=
 =?utf-8?B?Qk9iVy9wMmlPd0cyN3hHTzhCb2lIRXFuSmJvQWU2MUpTUENuSTVtbTJMNjBK?=
 =?utf-8?B?SXpiZmVTaU5HVDhTVVIvcUF6eHdUelhMUGxNblp2ZjBGcUM3QlJnTFcwTWx4?=
 =?utf-8?B?SlFISU4vZ2pKdkdiZWs5dzhSMDVXUnJRbll1U1F1MEY0dHpYdmxlcXc2encw?=
 =?utf-8?B?dWN6RHdJWFhId3JobjdyZUl4bXRCWk1FMnE3bkpaRDJZOXg4dzhpYVZVQTJ1?=
 =?utf-8?B?RjZqZnEwT2J5dDlkUWNlOERUWURCTC9BcFAzc0ZxKzhNNWhGL05ZejNYZzdh?=
 =?utf-8?B?eDMyc2RqN2g5VVVsZDFDN3I3eGc4TTAwbyt5RFdUbldCMlNGMlJDTFAyOS9W?=
 =?utf-8?B?d1JKOHV0bDVlV2NzZUZSdjNuS3lNdGlCUDBQcDlielk4ZGwrRUVUdjBoTTYv?=
 =?utf-8?B?RldtcnJFZERnTGFaUzN5N3BYYVpPSndLb1ZMV3c3SmxKWC8zbCs0RTh0d2Ev?=
 =?utf-8?B?RHNRRGMrRDhTV2l6WHozZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjFJbDI3T0NhOW5XZ1piUjFxUHdHSlE1U3J0SWJpaFY2ams2VHl3cndNd0My?=
 =?utf-8?B?TERsQ2Y1K0E0MGRNRy85dVQva01GRE5VWFUzMHlHMnYzY3V6dVZ6UkpFNldN?=
 =?utf-8?B?V21Tc1VTMVZyR2J5Q0V4cW9yV0QzSEl5L1ZpcmV4VmFwL05MNU54WlE1RHdV?=
 =?utf-8?B?QW9LVGZyNUZhaWJrUWc1KzVVWGZPZTc4MThsS0phYXAzUGE0UlZmTnpzN1NI?=
 =?utf-8?B?R2N1dm1lc2R4K0VoV2tsQ29WMTVrYVJ2WTRURmUzd01hQkF1SHhpZEllaXMz?=
 =?utf-8?B?OEVBa2cvcWlXYUVScGFSdFhGTnBaWnk3eEpNUVU5NFpZMk9BeTVHSHJKWkhR?=
 =?utf-8?B?VGFjV0RidktocFlrUW5FOE55MUw5cmZjV21EZzVmaHNsa3JrN0NVUWpHU25V?=
 =?utf-8?B?eHR0a21yZjZjMWxNNkwxcmF3RHZONkNsaFJFbE5yMXdYbks4Mkd4czI4Uzh0?=
 =?utf-8?B?NmV4UUxXZGV3K0lqVmg1aS9DMDdDd2g4N1AwYWRqRklCdmdhb04zTnhyNGFr?=
 =?utf-8?B?ZDdEUnNKbTFYRTBGRGs5R1VBdGFTUTc1MzlvWFZqdzJSeEE1ZU9DUVhGRmtO?=
 =?utf-8?B?RElYejZlQ3M0dzVvMHpyVWFPS3pnTUtnNDl4SlpEdmxvTitXR2dUL3piWElC?=
 =?utf-8?B?RFJJa2I5TFAvNzNtMFFSSDkrdHlDOWdGS2s4b0R0a04xaWxaZDVxUnZ2c0dv?=
 =?utf-8?B?UTJKb2JFSU5sMi9kRnV1ZFpGaXRiK080S2ZZRmhvT1pUOS91M1B1c2N6a3NW?=
 =?utf-8?B?dEVqSnhaa0dyc0NOTUhWN0FmUnRIN1dVRjJoWmRQamU5R0QrQjlrMnptREgy?=
 =?utf-8?B?a3B6SnpjYmlnNDNKa0FIeDN5V1BPOEpsWElMRENXeEFqTUo2TlB6bkU4SWR6?=
 =?utf-8?B?ek5aT1B3UGdjTEtIbFkwWU9LZi9RNjFtdGIwUTZSSE1QaG02YWVYNEFaUm1Z?=
 =?utf-8?B?dTNSVi9KOU5sZ2JwUmdCNEtZTk5qWHptQk82MFdiQk5vSVBCbzlVckRVZmJu?=
 =?utf-8?B?REFYdlh6M0dKZi9ML2ZXSG04ZU00dHR1NkJFNzJpT0RrMEk4MUcrUVJKR2Nr?=
 =?utf-8?B?czIrUFJ2dUQvSW5RaWF0K2xtbk5pdU1xY05TVXZmUlJEZzdIa0NZMm9aaUNM?=
 =?utf-8?B?NzRaTS9icXVONWUzL1ZKSnMxS1VKQSs0MUtRVG5UcUFhR2Erdzh2SDZ1cFRH?=
 =?utf-8?B?SExBclRGSlNSQTlQSkdLZWY2dGkvV2FFSEpzZkdIdHRvU2tLRmZ0UXlXYUFK?=
 =?utf-8?B?Y0hrdUo0QzJ6Nm9oWEtUdTd4V1ZTNnpkMkJaaW82akl0ZTVMcS96cVR3Q2J5?=
 =?utf-8?B?a3VBTVdXUGljbzZPYVRqQzQ1ZGk4Z0Vuc1dPM21SMnhvQ29kU3c0N2xxYlVy?=
 =?utf-8?B?NklMd1lNaTROanVBNktWY1IzclBZWnFNblBvQmh4emlvNWxsTTRlcHlacFlY?=
 =?utf-8?B?VS9NcGpnUmxkY2NvVk00aU8vQUZSWmV3S2NOcm5kOGUxbTZzL3M2YSt6dlJZ?=
 =?utf-8?B?WFJmS3BmWGhkT3RsTEpLeXA4VVdUK3NZOWpsazJ2ckFyZ0lBaExCTkc1LzRy?=
 =?utf-8?B?MURMMi9mYklCMFJPczJ5Tll2Q2s2djFEUjFSYitya2lHcFk1bkljRmQweFFI?=
 =?utf-8?B?TDI5TkFFOUFxdDBGQUFNN0JSaHpvWlB6bWlxckxyUDNBdkk4WXpmK2Mrc1Rn?=
 =?utf-8?B?WXZYcmFMTmQ5ODFydkFtTU1SdUk4clFHc1luYU9HWGtxMDY2YUk5dWlEQjJS?=
 =?utf-8?B?Mm02TWNXNTFHbVkyTXF5V25mWHpDNGhxVitFdGxCU05QcU91a24wblBJbVVQ?=
 =?utf-8?B?Z0FjN3pOYmJJbXp0NzVPL28yZEt0c0ZHRG5ZOGFmeTFwK0FoWlF3aUlrUjR3?=
 =?utf-8?B?SFd0VWRZbVhndVFtKzFzUjVhZElXMEh5NXVGaXY0Rmp4NWp1NXAxajZvODlO?=
 =?utf-8?B?TmxsRmNtY2Y1QU1kOUI5ZCtWYnhnWnhObzRGdzh3cFhKOTRzY216L1RlK2lt?=
 =?utf-8?B?VkJpcFlrTjZVLzVHVGVtQW1LRTA3UGxhWk1JQmhuSm45QWUzZStuUEdOR0Y1?=
 =?utf-8?B?VHJndHlSZDNpeFVxa2NLNlM5MEF4bGQyeDhvRHREcEo4cVBaejVwTzhTRnhx?=
 =?utf-8?Q?Oj2HGxpImlo2PD2guJSqFYXRR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ce1366-8a87-4489-1064-08dc677cc3d5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 12:14:34.0475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2K3P4nCGYC5ZZXhcHCGaArlYRAqtNsXRMOK+OXCAj0gnC6WRy0r5uHmKYBqF6wef0Bn/u9VpqzftRTHYCdJgkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7018

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


