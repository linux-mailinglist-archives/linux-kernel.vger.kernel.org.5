Return-Path: <linux-kernel+bounces-168477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787228BB8FD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B211F21CDB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B3B36120;
	Sat,  4 May 2024 00:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Wi+r8wpg"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061.outbound.protection.outlook.com [40.107.105.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F692E851;
	Sat,  4 May 2024 00:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783365; cv=fail; b=RNa91iLIgL/yDJLuXGb6XaxRKcJEHaXRjWLIJ44a6pIA7cj/uKWTtHduEQR77spcX9SQIJP9nWPjizvXFxLzWlOgpYYsT8WF75q8q6CFv1DHb60QoQO1MvkXXwaYpGV6iB5tXC0Tfa7433tWz7KoDeFref9a7WZl174S1CAApZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783365; c=relaxed/simple;
	bh=LIgsjKhvPsQ/Wke1XoRmOQwn3YqqnKKetqjIr+h1Gx8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=q4aZp21yR25pV/FxcRCEMw9Qq+UGmfOxab4QvdxeateUGiOmbF8tRMr7uEeuPP7lxg6w0KMLqI0toNu6hFnCHDLZgAbQXrUUrUcz9LKQLnyoH2vH2qkjkavuBvD3FClEJw1ca4ZTSOORsGAw6zPuORyf03kpYodcjbBLxoh/XLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Wi+r8wpg; arc=fail smtp.client-ip=40.107.105.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeDPgVInByo1Kt1omSGcmVDy3feVfm8uwnA3uVmUaDiBpymlePwQD31evVj19FIN/gLEGi9kRW9CHsRuK70f4AFl79auVqUTABL47++QFFrK+Y96KMG8DTp86Mlih1lnpCaTAeg4kIiBQW6AlODm5xu8Gaz59p/V2p36lA/wdLuiMnuBf3+DOcPH7KIBYYe7OniNrSIOjfElBRPufF7d8LWeBiOqHlfap0o11X9fjPgc8o6F1K4SnnMh4bo1HI3rZ0a7SAvyqzBntRG/nnQSI32sgsxJj1W/iOOOJKPTP5oRvyP8zcKMUuEV4A3df+LSMSS9XiVz1j52VjYaJaDIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Xbc0TOfAlS9LPLGccHITUNQDuUBFJQrLHuLiwGMTuY=;
 b=NN8bnQYlj8CI1LK8+W5ewv0tvKHGpKvWzzjEZxeuDjFP2jn8iNFDgWoQolyrrB7GTGNpp32wHOwuYNqQyn0NNC4Ow2eA8s6OEZin/oK+APT2CyTYUaUmOnSMtrfJdpXiMMbRH+SmQYOhWXwmDlhX0gjj0khT5xzbCyKyo6xmL3YKx/6Oxkk/IcxErqzIU/Jmd+MSRorH/MFHdI+ZkUnJGK7rGJMtiKu8nTyggbtqcpeGfMnOM1rcOC5YhalxTNXy1Z1Vmo7QSEwEvbgf0GoWHwj8zT7qo5Sekll5KzLKjbKJVauiXx3MfBC9w37QghdqL2r48mEjKJIEh8HGtx98+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Xbc0TOfAlS9LPLGccHITUNQDuUBFJQrLHuLiwGMTuY=;
 b=Wi+r8wpgP74N/JgpyYbmyNtIDt0/fZ6yGhUgfayxVoYA5dcSkLY1YT4tN/ICQrG8P/+x/oAFCDaGNUgW5zyCxkSYHc5m16BurpgyhssBnhOJ92vhF14qWutKoq9AmuuzAsDwOnVjzQjRZcptsJ1c3L8SYmBagSu687mbowUlklU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7726.eurprd04.prod.outlook.com (2603:10a6:102:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sat, 4 May
 2024 00:42:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 00:42:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 08:49:11 +0800
Subject: [PATCH 18/18] clk: imx: fracn-gppll: update rate table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240504-imx-clk-v1-18-f7915489d58d@nxp.com>
References: <20240504-imx-clk-v1-0-f7915489d58d@nxp.com>
In-Reply-To: <20240504-imx-clk-v1-0-f7915489d58d@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714783747; l=1217;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=fgOtqAw+FraHuW4UTB8xhgz6F79BoqMSj9Ycinx3ytQ=;
 b=f3yGykR8lw1s2EBBnPv8EP31A12zCQmkBmhkVnqJuXsunIHjVrGOIcT5vibeKJdYfDptNSjKy
 viFxsPCZd+dAmQlcb34HIczuA05kIbDFNlj9YSPM94Z4er2mq6mSmWN
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ddcd43-5408-4e08-9417-08dc6bd31aa1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|366007|1800799015|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlNDdFEzUFQ0ZHdBaWd5dEJ4emZ6NlJSUlcvaGo4UHBjWVAvM2VaZDVPRW56?=
 =?utf-8?B?UVI1NG80QmNCT2pTeE9ua3NWUE4ya3ZRQmxHWUh4NTRkcFdMMjVza2dWZm5I?=
 =?utf-8?B?TWtDUjI5V2dRMUVaakdRWVdLMmwrZHB4RXE5b24xRWdMaWM1dU1XaEpEb2V4?=
 =?utf-8?B?OFFtRzdDSCs0WG5wN0NtTTNST0xUdnNrQmVzK2hxODlmSTgyY0crZjNUcGh2?=
 =?utf-8?B?Q0VjN2lBRkhzeHpockJ3enc4QlFNdDVSMUhsRlFXNjVqVjZ0SHhiZ3ZRU3BE?=
 =?utf-8?B?TkFhbFhiaWxWV3dvaUhxRkttalpFQXpSSXR2TW5oUFZOV2VKRXBvMWZMN244?=
 =?utf-8?B?RXpCWjZZVy9LOUtwTUEvdGlyMlJldllueURWc0FINFBRMU5SQkFhdGFiTlFW?=
 =?utf-8?B?ZktOYjBsdlB1QVhXaXJ0R0hJNU9wSU5zeWFNLzMwbmtWeGdzNDg5T0s2SDVF?=
 =?utf-8?B?WXNzdnRvYmh3L2lWZUlsTlE5NDFhRDZQQU9Zdkh4dVd2S1huek5rVnhKN3pl?=
 =?utf-8?B?REJnMGMwS3BaUGNJN3g5ekFyWkppK3ZVN2dtWExrUlFYV2hFZ2NZQUd4TzV2?=
 =?utf-8?B?SW9ERWFYM0F4SXFSaExna0Z6eCtydkpldUh2YklGakdwUEZkNE1tbEN4MC9J?=
 =?utf-8?B?RXczbFdIdDZORHFQaGIzam5xS2NjU3ZvOW9EMnFGKytJMStVejB3cjRMelFS?=
 =?utf-8?B?a1lrL3ZCRm9kY0RRVThoWTlmV2M2elY2Y2dKVG5ZLzNNV3VHRTFheGFXVitt?=
 =?utf-8?B?THBKejUwZGdrRkxPVDhRTkxsOHp4SDZ1R0tVNzNQM0g5RWlMSXdSeFFQTmdI?=
 =?utf-8?B?M2xVN2loTjg1Wk5hN0hWdFYxajBYcWFlaXMxVmFXTkFDVnlCNGlrTEtQSVJJ?=
 =?utf-8?B?T242bDllU0M1SFhRZm1rSk5QRjBtY0g3UU01Q08vK2VSVTFrcnBhcm5qZGc2?=
 =?utf-8?B?RFN1OTFCVExlcGl0ZVA0N1V6ZnkzdkFhakUvejR3em5KMDZIaE1oNklPMUdF?=
 =?utf-8?B?eHJVMU9vNUsvdExzN2RkU1R1MFhMcFQyWjczaTZqdmZWa1pUVGJqNDI4OGVj?=
 =?utf-8?B?amg5Y2xGaDJFMm5nQXpqNlFxYVBSZGJXZmdITElQU2F5eUFuKzhKaDl0bkJK?=
 =?utf-8?B?UUNVTkVSblp5VmRIMFhrSW9MM0wybDdwUnRjY2Zyakl5LzhoNkRGRkhpNkVT?=
 =?utf-8?B?MXVIT1NiR1d1d0xGSm9iU3lteGlDK09ISmpmaUErY0hKRE1nQjJ0YjdsSkZI?=
 =?utf-8?B?cmgzc2ZudDlRek1hZlNEaUNha0NPbC9nQ1ZiYmFNejFkUldIN29kVXN0RVAy?=
 =?utf-8?B?amY0QkpOeGdxTzlaZ3JuemVFZFFFMCtFM28yUStzWHUrQ29xTTVFVHpRdGQ4?=
 =?utf-8?B?TGZJK1lBYUhyeFdTdFpJU3MrRmxqaXNsdGJkeEZVQUhFMVhCUEovYUxHbEc5?=
 =?utf-8?B?WXQ5cnl4YXdDRC9nUi9yODlKRnoxbUNuMHhWOVR3UW1tNmRlNDJpeldWOGdY?=
 =?utf-8?B?YjRGQmFMMmJFdDYwazhxTWpXaUxGVGNOc3Bra2liVC9FY1AwWmlYaGNNdTQy?=
 =?utf-8?B?MGdmSktWTkowL0Y0WGxMbEFyeFpNcER2Q0x2VFFNSG5VeWNnMjRMOU9ZeFp3?=
 =?utf-8?B?NmRIOWZ3UEpFWTJrYnVYSzFvb1RkdDNFbHRMNW02eVFGTnBHUHlKMFBNb3hY?=
 =?utf-8?B?SmloOHRWY2ZEUGtya3AwQ0s3a2ZpMmxWMXU0R1hUbnM0cEdXZVRpSnIxdDBS?=
 =?utf-8?B?TnI0KzF1cnVKUUtUdkwvSHpVa29NK3dVQzVOdU9DbWx2WForQjlKNnJYZjQ5?=
 =?utf-8?Q?Q1zP2Mytdb29l3l7HbedNI9me1JdEuUnqY3wA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(366007)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTBCbUpUUHozeDR5bUVlM25PMFBod090UmtnQkRTVUFCMGc3UU9QMVFKdFRm?=
 =?utf-8?B?NWkzZmpPVU56Qjd1NmVpTTgrYkNVR1lnSC9xeGlVQnUzYlZrdzRBcTNwN0xV?=
 =?utf-8?B?WVRTRVNhZVlIL3l0eTlFYS9KTjNSWmdyZ3RDcXM5NTVKNitCWGR3TFUrSWo2?=
 =?utf-8?B?REtIWW83WG51RkxPa1RQcEhod3ZWTS9DM3JsNG5vVytXZWdGT25wR3FyL2hS?=
 =?utf-8?B?VFR6UVVGUURva3hGdEEwVXNlY3g1cUNHSUpwNTFVeHlRS2dGRXQ0MmowVmsz?=
 =?utf-8?B?NHRlekp3allaQW5QTHJhSHVma0NncktWRldZZm9lNEtFU0cwYlVNcjlET3k2?=
 =?utf-8?B?NW5PK2RHdGY4a3JJRUlEN3J0bEFpMmlMTXZaS01uNHcrQ1krRTdnNmhKQnI1?=
 =?utf-8?B?NWZ2bmFWYjNON3J0WUU0RFpRSTNRUlVyZi9oQU1HdlBnbHhzZU9HbU1INkJG?=
 =?utf-8?B?THo3UVNFRkVkeUUrdUlMUS9RQWlhb281UFZ4dzZ1UXdMVVQ0dUhDTncrdHo2?=
 =?utf-8?B?aFRHMW5iZ2dYRDFtWnlDRXBjWHRQdVRZVmNnY1VDMmRUYTZPT2ptR25JOVov?=
 =?utf-8?B?WEpFY3F6NkdjYjFTMkpKeXRJWDJIOUE4clBWcWl3QjRseE4xMFlWUWc1QTNi?=
 =?utf-8?B?ZzgyT1hhV1YwM0hWQm9ocld4cUpIcDFOYmF0TFROdS9OWjZiTmVNMU9iV0Rt?=
 =?utf-8?B?MmdiSHZWWFpTSHZjVXV0SEhxcDFML2dGS3NYUHhRU3hkT1cxbXRYRzMydWYz?=
 =?utf-8?B?RUVXSHU2N2xVOXFlU2REVDhLbFFlVGtYMllWR200VkxGaWs0UW9iazltTzNC?=
 =?utf-8?B?eC9Yb3pWRjE3S0M4R1pTZGZaaW0wOTlFMlNnUWdXRjlLT0I1TlJRMVpDSUFF?=
 =?utf-8?B?RWdBT2U5UEdIamxOeWpTaUlGNS8rMEJJeXpqR24zS04zMGh4bUJ5V3A1U0Y4?=
 =?utf-8?B?NU4ycVRVQnEwY3V2a0ZQTEZHbVF3b3hYd0ttUTRvRGhtQTdxNllpR2l2RktV?=
 =?utf-8?B?K084QTdaRnBKTzAreVJlcWtWbmNDZng3Wnl2WWdGRy96SkE4WDd4eVR0SUZy?=
 =?utf-8?B?dHhSUi9Sb04zZkJGU3FWb08vc01mNGFTVEluY0ZYc3FTc3ZMcDREcjdHZk01?=
 =?utf-8?B?bk9YaWM1YVQ3OUtwd1N1Z2k5azFoY2xzcGxKL0VYZDNBNkx4R1UxSmkwMWRR?=
 =?utf-8?B?M0t2WnNhMFZpNVYvcVFhSVhicXFoZXRHZm4rTEZQQVFLanBRKzBQTW02MVBN?=
 =?utf-8?B?ekNmL3RKRGVqaW1scGFYRlkwUHlUcDBKczRaRmdtOGllZXdPcFAyT1FSR0h1?=
 =?utf-8?B?bWFSaWZzdlcrRnhZNTBzZlJDWXdEbVZ1VGk2cklTT0ltY2lTd2ZobUhjcGtD?=
 =?utf-8?B?aVNKYXRsZ3NEb3dqWTEwRXVmSTdJV0IrT3pmN1hKSFl3WXV1OEhOUDRRZGxE?=
 =?utf-8?B?K0w4RHlMWnc0N25GWGFoWklBajJWRDZiNTY4UDNyRlNnUnVWUVhHOTM1NDM3?=
 =?utf-8?B?UWlacWw0ejhOclFBT0sxTFBQMDdISGtYeURDRGVXbGx2enpycXhMbzBEcHRB?=
 =?utf-8?B?UGJzWlJMWStaOGNjRG5Qa3J2UEdWSWRGbmFHWk5PNTV0OFRYWnZVWFBNMXFj?=
 =?utf-8?B?UlZMWXRKTFV2aUxrbC9VTzQ5QUpYL3d5djIxWlJSZ1lKYVZOZkZaN0JOZnFh?=
 =?utf-8?B?c1p0Tkk4a043OHAvc2phMlNjVzBFa0hlMWZkYzhVOXp0ZDhLZHRlQWRDYUhi?=
 =?utf-8?B?TmtpcU1NSkZCbXA3SXF1dmR4YzIwUUNiblJPd0YzdlBZR0JpWUtLM1lNQjl3?=
 =?utf-8?B?ZUhvR1RNbnRCWW5mNEk3Mm9BQ0IxNDZFRHpvSVRHZ2JqYk5ISXRTclQ1cjNz?=
 =?utf-8?B?S3B6NVZGeWlxeTBCbDZxZHQ1SmZxQkNjQlA4eFg3V1ZyK0tkbFpzYmE5K2lU?=
 =?utf-8?B?dG5Qcm4welVsaUVwRVJJSVFkeVQyZmZlZ201dTRDUU1wWk5pZW9zUGcvY3RQ?=
 =?utf-8?B?K0d1Zi9teXJuNkNPNzdVU0NZU0VwMCtxRGROMzg2SDVRRjQyalBmY1lXTWRn?=
 =?utf-8?B?a2ZtMnJGTFQ2c0cwbGdLZlJJV3p5Njc5KzNnMjhKTE1rNlQ0RG0ybXk2OWI0?=
 =?utf-8?Q?IlXIhqbiOMkHb3LFCISl2/O+u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ddcd43-5408-4e08-9417-08dc6bd31aa1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 00:42:40.9554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DM6XiuhqumYWH6ZPt8e2kmI2SUEqkDHPwURiQ9drq1XiAm8pe52VNXlX/HeVECfQJJ7/uG5ZLD4PakJIOLVxeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7726

From: Peng Fan <peng.fan@nxp.com>

- Add 1039.5MHz clock for video PLL to fulfill the LVDS display
  148.5MHz * 7 requirement
- Add 800MHz clock for ARM PLL

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 1becba2b62d0..591e0364ee5c 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -78,6 +78,7 @@ struct clk_fracn_gppll {
  * The Fvco should be in range 2.5Ghz to 5Ghz
  */
 static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
+	PLL_FRACN_GP(1039500000U, 173, 25, 100, 1, 4),
 	PLL_FRACN_GP(650000000U, 162, 50, 100, 0, 6),
 	PLL_FRACN_GP(594000000U, 198, 0, 1, 0, 8),
 	PLL_FRACN_GP(560000000U, 140, 0, 1, 0, 6),
@@ -106,6 +107,7 @@ static const struct imx_fracn_gppll_rate_table int_tbl[] = {
 	PLL_FRACN_GP_INTEGER(1700000000U, 141, 1, 2),
 	PLL_FRACN_GP_INTEGER(1400000000U, 175, 1, 3),
 	PLL_FRACN_GP_INTEGER(900000000U, 150, 1, 4),
+	PLL_FRACN_GP_INTEGER(800000000U, 200, 1, 6),
 };
 
 struct imx_fracn_gppll_clk imx_fracn_gppll_integer = {

-- 
2.37.1


