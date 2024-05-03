Return-Path: <linux-kernel+bounces-167146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1208BA4ED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A2C1C21D6F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C8B18B14;
	Fri,  3 May 2024 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lgA0NLpZ"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3707DF5B;
	Fri,  3 May 2024 01:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714699779; cv=fail; b=JmTgixJzpXb8gt4pMvsTZBe6CGmAfI+P22zo72vRc65ZdWyOksOA8UXFVIk93JrmzVV9IUmOFXVwOCy3LWdh7pgqsiVH5GQa58VeV5gLMWQIzXeDwkRlmqr4ydxxbKXZFcQIIhsWwEUFukrZuGBOsm3Ttt+bz0IjkgOSgtWVF+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714699779; c=relaxed/simple;
	bh=dTjN1WFk4By9ZCcKL4ZtoSayD7CnXsWMhaHHi9F87BE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ws6d1onHGZjPnf9eT2Jfbofg0XHVWElCGJdWMAY+Lfw6RNwtFf7Irpgs6S6BuU1Hyl5OM5aNCUdnKNnhMB16KV6fhNQ4mjIg5QWrzypEkY3x9Qneqy9GSYz5FEu1LtXhEmbnHgpH8iIdsDCfxopYomuXMJP1XDbrN7XFhUU4UF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lgA0NLpZ; arc=fail smtp.client-ip=40.107.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=np4djYoOVPaPSVQpM6QG7piwkbY6xwhnPcg7BnPb1w+RcQfYvRXq5kv66H+/L3i/kQEMqSCSgNuV9IqwmOtuJTrc6CXpj7+fH9yvTHKJ9X3YHPTn0tQMurVMlAg9LjtgX9lHcajC2pRtlmZl0v/Oe/BUeqKy4yWr1EcPNzKzp93Tvvec+YoA+NzLn7VxLLA0HzYalXKhWzF9uFCkfHuXkUPReAuG4gj+UBjIPw36ZjRuC0p6N/9ln2hcO4PzN0agZJzU7msJ+2qStGW79+UnAYWSfmtc59sn4I2BgWkWlpIZE17h1IxMzlwzySRr8Eny9v0gs5biVitzqcTY8bXrbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPmw2Nxs9SYBykp/6Qc6N6Wqap2sC7UsXsn4FJzr3V4=;
 b=LZ78Xq8VicsuOEEgfKJCWrcvF3xOm6sWjvqK3LzpSVv0JbblkdOoP+85O1feM48+1DZziHLufQdzk2DrKUHqvO8ZyRHZHrE+uzVCTGkbPsR2OrnKaeq0n691EoDnKh8DhLN0aK1KmJorU6j+TgCXxk0O2u1MBdP8QYQoAJdWT1hExqDu+e0AzWp7X407SvdoHaRIxmEYCYgK8Ayjgt0NwXujSofOSHa02bDkqQKbcxcOfFCG20sxVOuj9uEXXZH3otERIx8cy2pw09uuWNJFQt4KHohSetnZ2ttyh+NptKU8AOO/vDJOOqoeGbKq59mjnSAl2xURppLPsxmdrxQHZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPmw2Nxs9SYBykp/6Qc6N6Wqap2sC7UsXsn4FJzr3V4=;
 b=lgA0NLpZpVibSdT2EitByvxSyoOOsg+y3hircpGAHqmlsT1CKK3XwCEvwCCScDnTdP0PQCid5ekF63TD1OniPyK+cUZTXyOQJnD25jrMQ00qghVEiGWU3aeyQeOB9Scv3HxyiK12vRJU+/vwGQAvY/WSBD7JvzcmCgwSxg89RtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GV1PR04MB10275.eurprd04.prod.outlook.com (2603:10a6:150:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 01:29:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 01:29:35 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 03 May 2024 09:37:13 +0800
Subject: [PATCH v4 3/3] arm64: dts: freescale: add i.MX95 19x19 EVK minimal
 board dts
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-imx95-dts-v3-v4-3-535ddc2bde73@nxp.com>
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
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714700249; l=3535;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=LUBPuU1Db9CdIbBw3CYiMl43CuzQTfQe/9+anld/Z8A=;
 b=OmmrJwXlyrtBAhQHT8P6YPADNoUx+xx4caZxrKvnvmlbuQoFzgB0uOLW0aB5Rqv9uAUmmMyAq
 KIuqJaMaYzpDtJhqROeKgwREMtzqju0CtiGLz1Yh9Ix9fAT4752c1N/
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
X-MS-Office365-Filtering-Correlation-Id: c3ed73c8-b16b-4758-5c98-08dc6b107dc1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|7416005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTdlUkRiNDdSOFNsckVzc05TY0FYUitjU2hTUnN3N2tqc3k4TjdlMmNraUtE?=
 =?utf-8?B?Q2pZS1BUaFJFSXUzTnFEaG8xTzVsb200WlZ1SXJ2emJFRUlydnJOYU4rM2Vm?=
 =?utf-8?B?Y0c3Njc0clVXNjZmVU0yNHlCTUZPZFpkYksvNmJIc2NlTDUxc2d0UTVCMk9v?=
 =?utf-8?B?VkUzZ1JIdjhLMVhIMmtyWGFleVlNRjdQYWlKM25Ha1piWldWNytWUmNXbXp3?=
 =?utf-8?B?cEM3VE9wQjJOL0lFMGFoOWlTc3FGMFBsRUVrL2ZWK1JxdCtENUpmdE5IWmxJ?=
 =?utf-8?B?cWxNNUJ3UlNPWnNVRDVsUDlOY3ZLeVFRbm5Eb3lLTm9DMXN5eWE3YjdydnRF?=
 =?utf-8?B?c1QyZmQvQ29ndlJWODErOUtWZFd2Vksvejd0RW9MRXhJSWdoL3Zqdk1TUzRW?=
 =?utf-8?B?MzNvbERXVnlKb091OTdmWVdIRnRHUUZGYXVtRC9tMThCZXhHQkZac0d6ZUFH?=
 =?utf-8?B?aVQ2UHNienRwREpZVDNocU5SempyMVJJYU45Z2NRMWM5WU1QRDl1MG8rNDQ5?=
 =?utf-8?B?OTZ4R05peWxsdlRPS25WMWVNSGdVK04rVVBHSXc3OUNQeld0ekhNQzdtRGJw?=
 =?utf-8?B?N3NhK1BpSG1SV2tPVVkzejVGWWJwUnlNeU8xUGJkb0kvSXM2WWt1b1hlZ1RY?=
 =?utf-8?B?cW92MlUwaUl0TWl4bUVrV1VsRUFrVmxGZHdSMmpIaXpNRDBob29tNXZvdG40?=
 =?utf-8?B?TUlCMC8xV0NYSng5S2VOS1NrMVF3eGx5T3dTM3pzeHFrMm9kTVE3a04vZDZP?=
 =?utf-8?B?OTF4Y3VETENhVHlEOCtEb2xQQ3hZbGZaTHQxblQ2d2JVZEVGRTkrSnM3Wmtj?=
 =?utf-8?B?Z1AvTUdSUEF5eGY3ZEREaVNlZE1ZWDFRNEFpdUVNbU84UWRRYTlrWG5Kenpo?=
 =?utf-8?B?SXVueUJUTzdkMUNzRlFoRGRzMDU3UVRqRlJtM3V1RkdVaGY0TFdNa1lzYTNn?=
 =?utf-8?B?VzJFVzhUc0hWYlRqVkxtN2N1WjJzWVN3ZTdsbmpFY3RaaUlUZ2llOWdVa0Q5?=
 =?utf-8?B?SVV6TWpyWFlyZGVjN0kycFNSamJDS1dveFdraHpXS0ljUXRBZnI0bFBHV0lB?=
 =?utf-8?B?QjFjR1FRdEM2L1RkWjBPdG9NTlpEUkFuV080dDAvWlpwUGFpYW90S0pVTlFQ?=
 =?utf-8?B?TkRlYmdkblF6RXlxdGwvSUFQRlIwMm16Q3I3SmFrYmhmd1FWM0dmNGhIYS9T?=
 =?utf-8?B?MlBNUEYyakJVUFJQTGNTWUFKYkwxVktmQld6VWlUQW5vazJmdlFRVDBkd1dn?=
 =?utf-8?B?QytFNHo1UHAzMms3ZGo1eVZ4bkFheWszVEZlQmtGQm5WS0R4TFhsaUErVE55?=
 =?utf-8?B?aENaOWtlck16cHg5Z1ZwdXByeEZDRVhUYzJuS1RlWlc1cU0vemxQMld6WXNV?=
 =?utf-8?B?Ukdnck1wYTZXMlNMZnJCazhSMWdSSlNpRVN5OFFzRzBqemV6VVNLU0tsYThO?=
 =?utf-8?B?TVMxQW5SMSs5ZlJ4ZXRabG85U3Jub0xtZkZ1cUgxRHd1NlBydzhPbytweFVs?=
 =?utf-8?B?dmtqVmsyQ2lycEJxUzRHQ1ZaRGVsK1JYbzU2VFk0aityOVlRVXRXRHBUdG9Q?=
 =?utf-8?B?bHZ4akFOdWorUHV3QkRwU1A1QWtPcnIxTi9JTVZ3eGU3VXExSWRhM3IvRDUv?=
 =?utf-8?B?MmhwWXA2NGtkWFRYSlhjZzVFKzZWVDZSQTg0dG5KOUJkNzJFbjRRazZPd2ht?=
 =?utf-8?B?czlHR1VBTldZZGZ0K1kzUmg3M0NlV2QvN3lDa005bm1DM1pZTkN5a1NDQmVi?=
 =?utf-8?B?NVF1UEtGYlJGSmUrQjNwbXc5QWxCZWlPYmNmTTc1dmtmUmFGT0IvK1pmSXdj?=
 =?utf-8?B?b01LUFNPSno2NCtmYVdRUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWRkM002eGRlUDFjdW5ySHZVYU9mMHdVaTY1UTBYRFZ1dzZCelFUaHZsS0FK?=
 =?utf-8?B?V3dkeGE1R20rVUxvNWVkRngrWEVGdzgwU21rUCtwNjA0ZDBYNXI2cFVxcDV2?=
 =?utf-8?B?aUc2Mys0a3FhbTM3WVBJVnV5S3VReENzTDU4djZPSzJpNjVDMjlGcWlLYUxW?=
 =?utf-8?B?VzhLbUZwVVVwOUhZTC85R1E4dWhOb3drTUFXZSsyQm5DRzNPZk5HZitreEtC?=
 =?utf-8?B?WWovaCs1T1FjOW1NMFpTbk1yTUx6ZE5CSjFEUjg0YWpjeWxFNTdKYXE1bXNS?=
 =?utf-8?B?MUcwUkZMSnJhM2VTdmhPV1ZUVkpKbzMrQlRmVGFnQ3N2Sm9IbGNNV00zTWs1?=
 =?utf-8?B?MEF6aGl2cUhZdjBaRElaVG16elZHT0JTQW1KR0ZkY1NmN3RPMGpsSFR4bEdj?=
 =?utf-8?B?MTBKVytvaGJUbnFGZ0laR2dFbDVyREZWSUo3RU15TmhUTS8veGx6RGFobVQ0?=
 =?utf-8?B?SE1wa1pEVHFQUWpPSkRyVUpKTWpLOFBVK0pyMGduOVdEUDBqWkdxV0RIMFVB?=
 =?utf-8?B?ZkNlNHJScGVNVGIzdHpvN0pOeHhRY2UwS1F4ckFKMVNoRm1XRCtDMnFnZ3RN?=
 =?utf-8?B?cC96aktaaDE5L0VUL1NUNE9DNFBqWFh3d1BIUzRQb29EdzY1NVlEbXN3eUgv?=
 =?utf-8?B?OUduazRxa2oyZC9URWUwaE11SVJ4R2xjelgwRTlwV2gxS2dzUy8wWGsva1R1?=
 =?utf-8?B?VjlmUndibzFuVkR3QWZUYVI0S1R4aFc1NWpRZjNDWGNkbVFONCtCTWhuWTZB?=
 =?utf-8?B?RDVVVkhKU0RXTE80T1R2dnQwaWVwWFpMaGh1Q2xtUmZsekxBVzlML0RKWGtD?=
 =?utf-8?B?ODB2NUo3UWFpb2FTR0FvOW4vMXE3aHUvdHdQYW5YQW9OUmRlWHdYZHp1UjBa?=
 =?utf-8?B?ZnNaK2FJNE1ITWZWN2kreUljN0hDZWV2TmJpanhlMDRRMmMxUTdvUFg2eU9T?=
 =?utf-8?B?ZmViYkhOZ3d3eGs0WmI0S05IbHQvOTI3d05qVmZNcHFueFNTZk44NFN4T2hi?=
 =?utf-8?B?dWpVSXdoMnhCSksrSFpmSk45SUF0bkpOOWhaWTVkMVppbWFKd3hycjUrOHdV?=
 =?utf-8?B?UnlRZ0tId3hzUG1tMmhJTGZBVVM3RHFTNFYzREFuMktoc3pVQ0NXK3grWUpF?=
 =?utf-8?B?VVcvd1NWWHJwMWFkQUovRnphU3ZlQWdxc0gwRGdmMEJkUXVuTXFBbThPR2pz?=
 =?utf-8?B?ZDgyM2VnNC9udE5FUGFPZVJ5cFlpalNuWlVaWWd4RnZBanNic3ZpaktkNFBy?=
 =?utf-8?B?NXR2Mis0MU1CMlFCcG1QQjVubHRFYmtoUVgwTEg4VGVPYldCTzlPSVAwMnFo?=
 =?utf-8?B?cUtoREY5L0J1aVA0YkZEMUNDZmdTV2hCVjNSM3RTanp3cW9zS3I2QWxzcENq?=
 =?utf-8?B?KzZpd0FxUmNxWVpHbVgvL3RrQm9QSnlnNk9lM1lYdXlrVEljQkxiS2xCTG9E?=
 =?utf-8?B?b0lxR0I2K0NXa2kxTGRVMlFXNW8zMDczWWd2TlA3OUlKRzVuOEVFSGNFa1V2?=
 =?utf-8?B?L095TnpscVUyZUpjUDR0c01VVGs3OUYzSUpLclZ1allQSHYwcTRnZjlYaUhZ?=
 =?utf-8?B?aTJlcXpZQUZ3N09rNGY1TnpsY0MvWkI3OHEzbkR2L0tQNFRrRnd3akJQWTV1?=
 =?utf-8?B?NytWUzRGaGVMd1FQQVpreitsN0dtMmFhdXVjWjdvR1h2bktBNzdGSjh0VDZz?=
 =?utf-8?B?RFE5d25OVjR5aE12QkIyTDMrYmZSTDUxUmhEY2N5NDF0UjdPQVpGdk1jbm5j?=
 =?utf-8?B?bTFQc3ZUUGl3UnIzWTB3NFR4alBIdmJIdGZoMVY5Q0RtUDBGenNiK2tjVm5I?=
 =?utf-8?B?VXUxMmxKb2ozTzVkYnhORU5nZWdrb0ZkOG1DejdjQjlBMlQzdWEzOXF4Y3NX?=
 =?utf-8?B?aGRVdlgvSHVwR3o0OUp5b2VVNVZRNCtRTmlFTkoyeVZ6KzJvVnE1eVlNeHZI?=
 =?utf-8?B?YkMrd0N3V3p4MXQxemFoeWtVcXI3V1RPb3d4SXB1TTZ6SEVDWWV4Nkl0OUNN?=
 =?utf-8?B?c09sVWxId2FHbm10NmRJZkd4eFhxMG4yUjhibnpjNUt6N240Ylh4aWh5eXRo?=
 =?utf-8?B?d1YwcW9Zd3BLamRCaklaM09saFNWNGlBSzNHdnFMaTB2OTNwSExMck1Ic1Fv?=
 =?utf-8?Q?mqee1GcCaw8jW9R1miOgJjozI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ed73c8-b16b-4758-5c98-08dc6b107dc1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 01:29:35.4113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHPCXpzOGgi2BITlbgO2DqU7H66rQarsn6de+DwbusBhhbBUY0L85XDKjKYCvYkdjMontXyVGPKx82OKlyh+Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10275

From: Peng Fan <peng.fan@nxp.com>

Add a minimal dts for i.MX95 19x19 EVK board:
 - lpuart1 as console
 - sdhc1/2 as storage

As of now, because scmi pinctrl support not ready, so count on
bootloader to set the pinctrl.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 112 ++++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index bd443c2bc5a4..057e23fde780 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -236,6 +236,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
 
 imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
 imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
new file mode 100644
index 000000000000..7e7271b0c545
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 NXP
+ */
+
+/dts-v1/;
+
+#include "imx95.dtsi"
+
+/ {
+	model = "NXP i.MX95 19X19 board";
+	compatible = "fsl,imx95-19x19-evk", "fsl,imx95";
+
+	aliases {
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		gpio4 = &gpio5;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		i2c3 = &lpi2c4;
+		i2c4 = &lpi2c5;
+		i2c5 = &lpi2c6;
+		i2c6 = &lpi2c7;
+		i2c7 = &lpi2c8;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		mmc2 = &usdhc3;
+		serial0 = &lpuart1;
+		serial1 = &lpuart2;
+		serial2 = &lpuart3;
+		serial3 = &lpuart4;
+		serial4 = &lpuart5;
+		serial5 = &lpuart6;
+		serial6 = &lpuart7;
+		serial7 = &lpuart8;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux_cma: linux,cma {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0 0x80000000 0 0x7F000000>;
+			size = <0 0x3c000000>;
+			linux,cma-default;
+			reusable;
+		};
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "+V1.8_SW";
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3_SW";
+	};
+
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "vref_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+};
+
+&lpuart1 {
+	/* console */
+	status = "okay";
+};
+
+&mu7 {
+	status = "okay";
+};
+
+&usdhc1 {
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&usdhc2 {
+	non-removable;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&wdog3 {
+	fsl,ext-reset-output;
+	status = "okay";
+};

-- 
2.37.1


