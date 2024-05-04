Return-Path: <linux-kernel+bounces-168466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A798BB8E6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C731F21615
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0E817FE;
	Sat,  4 May 2024 00:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YTPSITgO"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2AA1AACC;
	Sat,  4 May 2024 00:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783307; cv=fail; b=QIGISLP1FDLJ+4R+8cbXnDiqevHfRTPD5n/hvtKdiKEVw1agxFz/OWZqFjHklndNNXvYb5v4k4Ld7YQwOfCiW+SII0Omcx8wHJJbzntaDcyIw9ipU6IkOaNzaRriEIKwEqaIzNH9X5+Q+05Lj394atphWAlBntmWl8GtVCek4Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783307; c=relaxed/simple;
	bh=ALKKAIPLFtEvvSEnwT7GaTl1G+mKLBFTKWPRdBXUeVk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=d6HTj8WILVLYCSyQA6iescVO0UA9/fgblsj0xcBosDmU+a3+A/LGk0wpzIgqAO2sNBEJbnh58iIHHLggZQvx9UWTUjBGrKXE7jWoNQp/Mq6ex8gQIBSLCAf0PyI5btmIv7JC0KZiubwSJ5vKS/BA65ZcTsl1p1k/m+VYRntYb2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YTPSITgO; arc=fail smtp.client-ip=40.107.105.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdXXZ+fqxUnZuecoBlyRWhPPrFbGqJLCUx7+sc8UIytdJX3TpVrsp8yDeFQ/W1fp2RgIO6wG3c0N0oEA4laKa0SkNSVRKYDKGBHoAXxLQAHpD5jrRFIuR4f5boyPO2ywhxkyW5T2vEIXNNhBBZ47mprICR8NLSxZj2oyT+DzivQ3PBB/6gtAX0+l+t7sAmqAEe/yj729NDePCqlNjXs/doAu8fAY1xJVeLwVQkujHcxgGhcF40KLYsUEoLcVGKI9+fb5/Ts19bVYox8H931b4GiXM/7NQsx/eswUFgOIS9TlAk0FImPqDaKCocwqdm9uXIWizk/JJoRbxvhfEG4Vuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd6H0t/yI/bSoUA0/9la81Hj7KLRUVbJaaIyMyJ4tb4=;
 b=Kz32p+dufuC2WnmpECJ6bAsPEIXovRKfKDQze2vzYYnzgAoSZxG/0LJ0IKq95GTn3b2yBQ32Do/WbuhqoAPpZ4Zj7ojpb2ZKoLnDya1yE5eL8qtVpL2KR+sMkVTvU4afXfTz1faaul95P7w/wT/BrA1VufHOZVwSvT4J7BXgjQXceNzPGlLuzqKvkmyzKE28Nlxyy/mK0FvHO9Kj0I38bM2Uu1B5/UqFKEUaT3sGMXriQ3VEOwfKPJDZPlLkdwbqIf12/pbKAc4OseK1fgNl+Q7ogm1ktIK2NjwM/eIYZfgnH8uJLtqBfxv5S4RbeJZjc5yGjkIVZLf+j1dtdUqX6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd6H0t/yI/bSoUA0/9la81Hj7KLRUVbJaaIyMyJ4tb4=;
 b=YTPSITgOd3akPj0oOnAfA/adnGYWU/jO/betVZMAttbHcYv2R+ZBpuvnfj9AdOn1hrD02XncqWyYpJ2lxxESBPhO/vBtTkx2d04aYDspuku/paUzuNgtfQ0Y69VxHKrLvPbDLlu9JFv3z0bAeeu4Wen1Acj7bmn5yEaeLCt1Weg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7726.eurprd04.prod.outlook.com (2603:10a6:102:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sat, 4 May
 2024 00:41:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 00:41:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 08:49:00 +0800
Subject: [PATCH 07/18] clk: imx: pll14xx: potential integer overflow
 eliminated by casting to u64
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240504-imx-clk-v1-7-f7915489d58d@nxp.com>
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
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Florin Pavelescu <florin.pavelescu@nxp.com>, 
 Viorel Suman <viorel.suman@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714783747; l=1012;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=2UdxVIeKUK80+gL9caamcVMcYBZoguh0p2StT5CJdjU=;
 b=mAWBjvNWQhykSMMFGDAo5tfYl/Ef1TVTWQ/b1pc2IojjxoOMZdo+qn6NZ8QaxHr9aXGVayd7v
 Q0i60dKL0cKDgxO5nNpxRvuLFOT4Q9f3lOZgdG0ldocHmY71YPh30+G
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
X-MS-Office365-Filtering-Correlation-Id: cf4feb8b-cbeb-4ead-615b-08dc6bd2f71a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|366007|1800799015|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SU5FZlVXUDg1VkdhcDlQOE9wcERZTDFZclMwRDlxSUhOTWd3UVBodFYyUUhs?=
 =?utf-8?B?c3BrdXM1aW9aZmpZWC9pYndPandXQU5RK2FTaHFXV0UySGJxcnE1UWovc3VQ?=
 =?utf-8?B?TU8wU1BleXBQcWFqaWJaR0twOENhWkRPK3ZJWGJ5ZTFwZUp5TG4rdS9aTkZ0?=
 =?utf-8?B?SFcrM004RVp1Y0lIUlNXMWlMbmtTWE9PekJNWVZEaloycmhKdThRN3lJdXB3?=
 =?utf-8?B?SDc4engzazVEVnBHYURTelBIWVFrWnlUYjAwZ1VJY3dIa0lId2kwblpvV2lQ?=
 =?utf-8?B?RnFTb0VheW42bHpEWlJpNFhNMGFRQjk4NkhQNHE4dys0RldMaTRBbjdnY0FK?=
 =?utf-8?B?d3p1ajRZd3EvUDRQZG9VNmkwV0RhSElBMkIrMy82MlNJT1M3VzBHaDQxTk5R?=
 =?utf-8?B?a0FwcVlaOVduY21ONnF5L3V5UW1nVGJkdmZncDRkcnVGcFlKUjY5VUZMT0p3?=
 =?utf-8?B?NlEySURRUHpIVEgxTHVKUzJOcmxmSXgvUjVOWk5BSmVCN2N4NGNYSm45cHVt?=
 =?utf-8?B?N3dkL1BCZGVFM2NEajh0V0ZoV2piRXl4ZUZLRmg1bHBYdXRTT1dYczgwWFdM?=
 =?utf-8?B?RVJ4MHI0aEZ3RXFKdllFY1U3cmZ5bjl3VE1ZeCtxaG93WC9pa1JQQkNlbVJO?=
 =?utf-8?B?ZXpsZXRvREptMjN5ZWEzdUpWTnlzT3p2emJ2elp5ZEVPTDBIb05MVkEyUlVn?=
 =?utf-8?B?cGc5cXllNGIzNEhvUHM4ZTFNUzFpa1p6TDdRb1g0U1ZMQjYvaHdzcGxBN0Mv?=
 =?utf-8?B?U21tTCtXVFZpSGk1bktZanZlS09ockdjbmFOUGRFV3RJTHFkb04yby9xYU1a?=
 =?utf-8?B?TmRhWmZrUjgzZWxLU3dBbWZ2L2FETkZydHFWU2RTejNJeERaWkFhakxBdklO?=
 =?utf-8?B?d1NPQkhZdnQ2aEJLS05BY1JLdDBkT2hnZWIzZG5UWXFqTnZEUDQ4Yk1uWjRC?=
 =?utf-8?B?MDRyeDVtbHQvZ2dMVExSeVdCUW5RV0FyWHo4MVpidU9vTWF1WDNIV0dDcGJG?=
 =?utf-8?B?QzJqdXJIVS9pUlFBRGx2Wm0rZldaK0h6c3plSjQvVktpbUdQS0FONjJabmE2?=
 =?utf-8?B?ZzY0MzdBak93eng4NXM1NnJKYmgrWEpYOVFrNFU0My9CVGNXdEZ5RThnM29L?=
 =?utf-8?B?bEJMZkNRRWR3SDBDZkVzaDRXeURzWWNGNDBqajloL00wZTVCdlFRbmZXd2Zm?=
 =?utf-8?B?NXA0SnlRY2dJTkhxdGxrajJzRmk4d0RkYnQvbEtzVjgrZEZRYVg4OXJMK1Bu?=
 =?utf-8?B?K2RuRmpFUktZd0grVkdPdkJwSUgwQ08vd2dHT0lZTG5Ea2J4OGlsY0ZYSTRF?=
 =?utf-8?B?Qjl4aGR5VW5UTXEveXh5dXNVajlYK0dpaHVpWVlaYmZ3Y1RmZTJaU1BIZUNq?=
 =?utf-8?B?dVJ3MHVZUkM5TllKdC9Ia0VXcG1mMS9jZFprN2JBR3NZeVB6Z3dnakFITnBW?=
 =?utf-8?B?OFBnWjlneERaQmdrLzYzRUR4aUxOS0dGa1BNRHVwbUhEdE1tcVU0RVc0aFgy?=
 =?utf-8?B?U2VuTHNrZjVoT2sxN3I5LzhLcFpSK05HOXZ1WTNlaDFvWTUxUVRWcTZWMVhU?=
 =?utf-8?B?V0w3TERUcVJNTDdtcUsyZGt3c09UdUVHc2VueU1QQmJ3VVp0a3lzQXJJdnNx?=
 =?utf-8?B?Z25OYmhEZ1VUVE9PRmxmTENjNUxRT1VXdHpzcWFCRE5Yc3Jrait4OTludEFs?=
 =?utf-8?B?aENkL0JwK2pLZGI1NWUySDRXb1I5RWZURm5xdEEwRktKVlc5ek5DU3VjMkpi?=
 =?utf-8?B?ZzFBeDNCNGxRVGJhQ2FST0VWK1dpWnNqTmFTS3h3c3M2T3FvZW5tUUxwb2w5?=
 =?utf-8?Q?wEeLajY6c9roudl71DHvTkUJkZLtDUVz25b60=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(366007)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWlENk9PcGJlUXVxUDgrNEZYaTBuc2I5amVHS2J3Z2tOTzdjY3RZQ1V3dGVE?=
 =?utf-8?B?QzdId01USXZERnQyaHhlRDArUGs4T3daZW1qTlZGOG9lUFd6V05obk1Ebk5q?=
 =?utf-8?B?MkRiSXZCbit1S2ZlcFFva3F1K3oxVkpTNFJTOHdRUUpiRjlrVzNNTkJzK3Nw?=
 =?utf-8?B?YWhxSnlzVHF1TzhOL3JHbGd6KzZoR0laV0JIVEZ6NmdxODEzdjJlMWtFVTN3?=
 =?utf-8?B?Y1BMTHdVeEVtaTc5TlRMYUg4Q3BlejhtSHBqR2lIZHVOdGJZWEV6UkU2MFZN?=
 =?utf-8?B?L3RQeTlwN1Y1ZG5UWXlPdTMxTFpYTUxiMmRSN2VoeTZMcndNSVV6VGJOando?=
 =?utf-8?B?bmdFOGVYRnhiSG9odzdaVjFVb2hZRVF0cXRxY3RqY2tpem9qOGljeWJMMTcr?=
 =?utf-8?B?c0F6RlZoTWp4N1VJRkZOUERBZlhlNXhtbGVpQmNuZzdSd01MdGxzYmZVcmpC?=
 =?utf-8?B?aGNQaTlVRlYvY3RxT01kMWRVZWpjZ2s4MjVOalBDVndyZldSL2g2RDBlYzdy?=
 =?utf-8?B?YjcwMmJHMmdzMW8zTDZ2N0Z6MkRjY1FOSGlXSWo3d1ZLbUZvQU1BeWUxcTJh?=
 =?utf-8?B?dDArNlBYQ0xmTlRNMDh4dEF4V1J4WFRIQ0FjeTNqc3NtaDRNK0tjSHNPZG95?=
 =?utf-8?B?WEErMG9MeXgwU1QzYzBaLytZcTNVVzFNWkI2azNVdXRjcDNVS3lRcU9DNE42?=
 =?utf-8?B?TlkyMVZ0WW0rSTQ1WnNjcTV0SzRlWTd5dEFEZWh3VHpWcERPelgrMWMxNitY?=
 =?utf-8?B?ZGpCZTlzRnRjd1RkZ0JNcVNMTGFHZmM4VG9FTnVLL1RZN1d1RkFZNFMzSGdM?=
 =?utf-8?B?aXl2Q2ovTlNaOS9udWlrbnVCNHNjWHVkS1g1WUxSa2pRTGhEZFJMSWNEQ0FX?=
 =?utf-8?B?Nmx4UEk5TEUrejdqNTBGZ1lrSXc0ZlJNeFZrRGJtV2hUa1Q2NWtoc0Z2ZFRW?=
 =?utf-8?B?RVNLYThMY1JZVVFCY0VYK0w3cTQ0cXNCRUdwb1ZMcWZWS0QwYTUzM2JYTUdm?=
 =?utf-8?B?cjhSQk9PeUJkS0VRUjlTKzRIaHpGRzdTV09IY21nTUc3YjFzbzJhS1pFdVV6?=
 =?utf-8?B?T1JoMWc4WEZSNjM0WnQ3RUlEbGNYVzJBZGowKzcwUitubmJ2NzhTM3BPSlNG?=
 =?utf-8?B?SDJPRmtXV0tyd253WXlxaVliNTZ2ekVpaFl3M25veFpLU0t2NG03c2pGU3JL?=
 =?utf-8?B?NjlaM2lGTHpJeDJCeWpVUStqRWhuZUtYL2R2bWtRT1Y2TmZVQmRTSTRXVTJy?=
 =?utf-8?B?WDdDdXVwWnBkYlJhZmhnQUlRMFRNTm1sQlEyU0F4VlJ3Q0tsS21QSkYvTW9u?=
 =?utf-8?B?Zk53TTRvajNwV3IzYjlUUFljN3FLbWUvRm5mQjFKOVg4bFFVZjhVTjVPUHln?=
 =?utf-8?B?aDc5bWVtRjBCSjIxK0xBMmNpclBKWjNFNUhCYXlHZkozenN0MVVHREc0U0RE?=
 =?utf-8?B?RWw3ZDJUendISS9nUlF2SHRLU3NRT3ozdFVHaUl2QUlJOTNrM3dHRCt4SUVX?=
 =?utf-8?B?Y203TXk5UlhzVS9zMmgyWnh0NTQvYnpKcWNFemFUdjFjQ2w3MmplMkNRSzA3?=
 =?utf-8?B?Q3l2b1FBYTZEL21Scnk0TTZEVkNqY0RYWEFVVUczeEtNNC9TVFR1QmIzY0NO?=
 =?utf-8?B?Y2NHMHlxN2taT0k5Q0FocktQVEpVc3JwRnVaSThYcmg2TGd1dUMydzhhSTRQ?=
 =?utf-8?B?TFBLN0cyM1ZJOUswV2lqd2dqVlp6MXV1ek5pKy9ZeU5XTHVjcDNyOXJTZTA0?=
 =?utf-8?B?WWhtdHA1dGpXYXJBRFBDbUhzK21Gbnk4VUdhUDNMcnFTeVNiakNNeGJpdmpP?=
 =?utf-8?B?SzVTZFRWSyt6NDZySlFVeTdsVFRKSU9JekZ2UTVoUngrZnZ2OUJMbXlIRXY5?=
 =?utf-8?B?N1E0dHdRenduWmF5a3hpWFY3SWRVdWdpbnJ1RGpBclUvWml2NEEyelFBS0xQ?=
 =?utf-8?B?KzQram9xa3NNNnVKTmkrS1BJTHQrTFl3a0s5WitCdU1yTC8vRFdTdklidTlX?=
 =?utf-8?B?M0ZjQnE0VTRXZE5oL2hjVGxoZnlXcnI0QzBEYS95QnFUSGQ5U016VFNIK1dQ?=
 =?utf-8?B?N0dvVmhKVllCa3VzOS94ZXlDWWtSZ3pWYXRrWTllcmVvVloyMlJlQTZoZzhI?=
 =?utf-8?Q?vPJ7vaAHkZJfcwEhFZor1bNf6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4feb8b-cbeb-4ead-615b-08dc6bd2f71a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 00:41:41.3516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+HsixEc4V9jtZdHKnMuJjLkDUP1W3YovuQgWleVt96+zD7bgI27hR1VCxTGxOLcxayfyr0jG04oji6FWsLAsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7726

From: Florin Pavelescu <florin.pavelescu@nxp.com>

Cast to u64, so that multiplications and additions will be done
in 64-bit arithmetic (and the results will also be 64-bit)
and the possibility of integer overflow is eliminated.

Fix Unintentional integer overflow reported by Coverity

Reviewed-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Florin Pavelescu <florin.pavelescu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pll14xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 6b2c849f8b71..78eedb1f4a79 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -118,7 +118,7 @@ static long pll14xx_calc_rate(struct clk_pll14xx *pll, int mdiv, int pdiv,
 	u64 fout = prate;
 
 	/* fout = (m * 65536 + k) * Fin / (p * 65536) / (1 << sdiv) */
-	fout *= (mdiv * 65536 + kdiv);
+	fout *= ((u64)mdiv * 65536 + (u64)kdiv);
 	pdiv *= 65536;
 
 	do_div(fout, pdiv << sdiv);

-- 
2.37.1


