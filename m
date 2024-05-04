Return-Path: <linux-kernel+bounces-168471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32F18BB8F0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E051C2288F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5DE21362;
	Sat,  4 May 2024 00:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kqSZFlQ6"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46223182D2;
	Sat,  4 May 2024 00:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783332; cv=fail; b=Jtpzq/TWWjEcCRhbeWdcKiI65c8tsmhgaCwQQrt8LbPaud93mF3gOzaDae1g4UBH/9yhP2EJ6+bXS/3sDKjVGmCZc8OlbvvkGmynSAIYn4jDwYUFl32VqI6+lyBzDyZGALtr3e8dDTO3TBjBFvSW9zDOYZHUyQIUXf/pFdyZq2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783332; c=relaxed/simple;
	bh=dNAJjUOvWj4gorUyU/vJ5YGaC6ol01WXuVkktew2KDo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=V30SzU7Rr2LROJ/U73UBpHmZCLmAHPUW8nHAfd7yPYQ6N8dp28V7HCK6jWi2EOLezwF/WVH26TKmT+d0HRqrUHpoVMh4oQXMOhIzg5mr+xtTYNW6GvgiOL8YAe6J7oYKPC4jSwDHP6i8ZNxeRIUKunhDKCylqsPcMGBU5FCYq48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kqSZFlQ6; arc=fail smtp.client-ip=40.107.241.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iu+GG6jjhro0U/xLW4uZBKa5i1d38LKg5CdMa8htDU/tE8OyBGQM6GUU+wjvGkaRaQav2AKIlwPfMOOf9YhpTrcxSfD77Hg61WSAMui3+s/0FVIZkiBaIb9OJBS+aKtNr3mWA19O9fbIm6VsPSgjk3zhqJ/AN7ajZWrYcCC4Jfm86bKHT7VypjV90bz0kXh03UXIoeJpyDgw2bNl1ovXWOTYe8Ue0iKXUHFlNB1truXNmoztmJGvkR6aZZ9FuZduj7SMhOrQPq/2KFG4oPmMR7m+oYQPjKNOfTjINS1p4xzZfZtQ9yUBQETbyhKxs9JeGpLse8G+36gJjW/xhuUWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxYqLlXJwDglTN2OhR5UoatELjnUAf5TIH6f/O5wCko=;
 b=Ia1tau/g/VQ55FlzOCM+bE0bKvl3fvG/PyNiv7O1Qg5hPr78A9JcVuZmaD/7NHpRtIj9T5lsnIjyFcocMGVDH+0mX80PDOWowKW3p4eH/t7OiIinjT6+0k5Jqnrb7er9ORCCdTZ1JeVI9s+WW3YJV4VS44Z6R0IqyZE/wUhe7M7QOPLCkROPKkNDEuEDbZyYGvdV0PJIdPCK0Ib8yETltTk57oNZxRXqUaFa3IZ9DpXVsotpjiG+JruvtjPWmnzuYbooEumP7IIiBD5MPxW1JcbICpkA4mHpdXZf5K38HhsMFZo06LXIvDLRy+KEaVD8qG25u88XhenQRn1NaPh7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxYqLlXJwDglTN2OhR5UoatELjnUAf5TIH6f/O5wCko=;
 b=kqSZFlQ6nUMGdiJPQEpITknden7rMSMSU1Dj0Hb6xwuXSYEgI/QdlqsOjHYYVMoT/CEg7JJWNmKLVnS/hR0+amo4R4JH7+clKvTzT72Icr5XB7CDLvz4rUl/4cBzVOf9O+pkbZ1y3fFFhX/LrSgc+sT6NC2ouOyVtwUeYQsCdvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7726.eurprd04.prod.outlook.com (2603:10a6:102:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sat, 4 May
 2024 00:42:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 00:42:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 08:49:05 +0800
Subject: [PATCH 12/18] clk: imx: imx8mn: add sai7_ipg_clk clock settings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240504-imx-clk-v1-12-f7915489d58d@nxp.com>
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
 Adrian Alonso <adrian.alonso@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714783747; l=1071;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=WifVIscFAtMHZ5cUN2mG03VXL3S/wRmq7jI1v73ZwVg=;
 b=5FvM5/JTalpS4unY5OrfETZS34BRxaMB8xQ6pyddDQnNiMLCb2DpTiTuaoqk7Abjf6Hql9AfW
 KKeYrqoZ0CcBrcGIDGoGR5Vi9E0Fbtc+eCE7BeaQ6HtFuS7dmVnCJoN
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
X-MS-Office365-Filtering-Correlation-Id: e8147b7b-fa52-4384-37f9-08dc6bd30742
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|366007|1800799015|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0N5Vzh4YnZ1NVlLcFZNMkJySGZNb3RuTVpuNzFXaHl4MnhqRkk3OXlyZUNJ?=
 =?utf-8?B?T1NhV3BCaWRFYjBQRWMzcFQ5RlpQamE1STc1TU55TXpRVThIek9saHZlWjdO?=
 =?utf-8?B?b2puejN1QzlMSE41K3pZUXJXRzd3UmpxMEg4R0tmRkVwUGRpMTFNOFhSQU40?=
 =?utf-8?B?KzVGV0VCZGlEWEZCWXVPWUtVUmthSnFhM1plMUV4R1Exb2E1U01WbXpuSG8w?=
 =?utf-8?B?VFVqR3NDQ2tVSTZFa3ZOelhtWitEREFzMWdsRk5aa1Y2bytrL3UyK3g1dk1S?=
 =?utf-8?B?Tmh5MVlRRnJ5b3VYVnJwRHd5aFR4MUkzNUtoTFQ2L1hsZXoxSWowakYveGhD?=
 =?utf-8?B?NEl5TnFqTDgvckVDMVpLWW9HcEkwQzlnTjgrRnAxRnlOTnRxR0R1MnBPTUd1?=
 =?utf-8?B?SGwwb0V1R1ZnL0sxRVF0OFA5R0lUV3pSUnB3UTIyUC9NUjZ0OU1zYkxBUEVP?=
 =?utf-8?B?YlNQb1RwS2ttcHBtWEVrcGRoNUV1UXBjdkE2cWI5UTIzS2xGam1EcGpLNzJP?=
 =?utf-8?B?aCtlQ25ZRXhQWUZobnY0clRvR0VFMEFvVllHdDUyZXRxUVlmTHhCOGlxV2ZB?=
 =?utf-8?B?K1NrNmZOQWZiWEViK01DNW5kSE9sdEtUeHVteFFxVVdPbU5WdVN0eW9TczZ3?=
 =?utf-8?B?ZUpkRGZmZVpBY0p1ck0vN0U4bS8rR1gxZkxpNmFZSXdQUzcrQXNQQTYyYndI?=
 =?utf-8?B?dUVDckJlcUozVzVxTmhwbkNjU2xMV25YQTRpZkNhR0dOdlA5SXpkRGJPc2I3?=
 =?utf-8?B?NzB2dnFGOFNDK0N0NlljN2x3eEhwTXBkeHpScVJlbmlmaFlOTmZRdWl0QTBL?=
 =?utf-8?B?QjBVN01tMk5xSFpDenl3NmVUQS9WNWtZazI5djdJUzFRYTh4OVFwQmEvN0x0?=
 =?utf-8?B?Zk81dzdOV2JVNlp2NzcrRzB5cXQzVFhGWDhDT3hhZHRUWnpyWHlEa1NCemRH?=
 =?utf-8?B?STUrU0N1M1A2MUw1ZjF1cXd3TnhkVXZsTXRvZERXbUJPc3hidTRKaDh5WTBz?=
 =?utf-8?B?MDNYUVJLS3dqNGlUOGdoRjUvWGlIRE9JMlJzOHkwRmxsVENFcEJMK2pyMy9V?=
 =?utf-8?B?Q1YyZjM5TzYvY28vS2FwK0l5S1NzZWdVMm05cDhEMjhrTWViTk5IejJhZUdt?=
 =?utf-8?B?VmFiLzcrQlVrTnI5TDUvVW1NMGhoRGo3QVE1YVErdTJTNHZBQUpnM3RHZ0tJ?=
 =?utf-8?B?UTg4QjFCYlg0a0JoSXJvRzhUZnd1eExlUFUxWHJmOG0renFhTlZpOHhwLzF2?=
 =?utf-8?B?dkYvdERwTksrUFlobm5WRVllZzFzZ1hkN0FRWEhaVERveXVyOTlDbTFweUhR?=
 =?utf-8?B?NCtDRzN6ckRrWFVXaEh3cm1iUUpFM0VUYndiNXVMSnhXQ1hBNTI5WjFjNDhJ?=
 =?utf-8?B?c056TUp1MVp6ZWlnWUg2S2JyUlBPMEc5dHZZK0ZLWHlLUHdVdk11aHNWTzNV?=
 =?utf-8?B?N2R3N1cwa2ZOcDdqZG8reUQ1ZzJzWFdUb0tqR0phR29uQ0VFdXFHSFlyUWZE?=
 =?utf-8?B?SEZFRk9DbHNjSmkzOEhNZEVDTnVML3YxdnRxa2hNS2lRMUYreHY2SXU1MGYx?=
 =?utf-8?B?TmZlcjRaOHFYei93ZkZmK1d2WExMdVpJRVJSQlpFWDZFRE5NR0ZxV3NVdWlH?=
 =?utf-8?B?YjZST0J1a0FxcUxKdURhMVRBY2RYMVVQQXBjZGF1M0VDRU1IQzNFdG9sVDl5?=
 =?utf-8?B?U3d2WktoOGFHNUFGZHJNemVVSHFQTVJhSG1JZnVGa21STHZJY1BNdllwNGI3?=
 =?utf-8?B?NmNJQWQvKzAxRitBWGQ5K09TV2dwSS9FMHdYdnoyMnMwMXA0RlUrR3AvbUZa?=
 =?utf-8?Q?Hqk4i/RtZmKf1utceEr6nDt0wH50qeEWqbThE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(366007)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QStSa3prQkxKaHJ5emZWbUZQb1FmQytBNFJWbk5mNWpYWlFMYTVhQzY0NENU?=
 =?utf-8?B?aXZ5Y2J2R1lvL3dnTVcwS3NNNGxxNnQ4eVMyWW5qL05oTTY5Q2txaXAzUWJn?=
 =?utf-8?B?czhqZExlNWptVmhhZmsxbDF6dVVWK0cwOHhBVndHR2MwWmplcklXR3B0aTd6?=
 =?utf-8?B?U244bWMrQnJZMFhTUDFkUzBtbjlDdlhTOS85dEpyWkViS294anhCenNGNEF6?=
 =?utf-8?B?cXF2WDh3amhuM0N0eEtteUxCQVRBT1c2NlZCdmx1STR3d0cyUUZlczd6RjBL?=
 =?utf-8?B?Qi83Zm1kV2lTNXN3Z05tN3RWamk5aXVVNVJ0SXdteXRGR3dXUVlqQnB5NUhy?=
 =?utf-8?B?bVhoV3diWU5EMjFVMlZoZHVVN0N5aFZrM0J5QmlJQ3UrUVBBbGsvV1lLUEo2?=
 =?utf-8?B?eUhLTVcxSkpQcENMQTFJMEVLbXg2VEg4c21qSDN1eGFaaHNQQWpDSUlqRUVN?=
 =?utf-8?B?WVlITG5Fb2RDWW5VS2QxWnFQYVNOY0F1azJxRlQ0dDRWUVE0eTByY0pQRHlM?=
 =?utf-8?B?VGd4WHhBVUZGVDl6NGZjSjBZUnJldTFZRXhtTFA0WTNLdW90RjBpQzhkbldM?=
 =?utf-8?B?a1RycUdXaGpTSEx0a1JDVnR6SnB5NHN4T2Z0M1FGL3RIMkI3YkZtNTQ0dE1M?=
 =?utf-8?B?VWVYZHB0ODNhS3RIZ3M3MVVFM2RZY1VEVkNTbytVMVRveENTT3Y3L0FBbnRo?=
 =?utf-8?B?KzRPUFE1OE11VFVVN1ArMmVXNlppVlhrdEpvY3hxZE4yRTUzMnpVVzl2bFlY?=
 =?utf-8?B?NEFzWCtWM2gxUUxRYVZkSHdYWHdSakZ3Z0dJcFFyRkpzYnYrZzA3WWVSbEpG?=
 =?utf-8?B?eGdUSkRKVjNKMEZHa09rNmhRSEpXQ0FLdlJWVHFUR3RKNE9oaEtpcWxOQUhy?=
 =?utf-8?B?MnpSMHRaZFZtSmdtRGFsbU14TjBaM05QSEU4UStzaFZOcjFmcEl6dTJ5MHY4?=
 =?utf-8?B?Q0FBcVIxdVFvZU5ya05PZUlVQ3o5NEZQSC9lOWEvenBtcVk4dDNuNnJqRlZQ?=
 =?utf-8?B?YjRTdEp1VjdUNFBjVThURFByTUVncW5ZN0hlejFaNTBPN2xaRVZyS1QxaElI?=
 =?utf-8?B?Q29GN00wZnNqaGNoTDd5RmlvSjJRV2Q0c3U4cGY1QlVPNzZkbEpua0Jmc1Y2?=
 =?utf-8?B?bDFBdGd4UVltbXhkVkxYSVh1bFR4UzlGbW9hNXQwN21yYzNZMTFpZjExY09Z?=
 =?utf-8?B?T0N5anljd2ZtSEtpTlduM0lnd2lkSnVJMXVYeHp6OTBhckRnQnRzMDArMHJZ?=
 =?utf-8?B?QWRNaEM2clBtTjZqTWw1YzhpRFdDdzF5eTZlTGlsQiswVytHc2U3NVI3SEti?=
 =?utf-8?B?cTdNb3pUUlpzTTIwV2VaMHNEZ1F0bjlHcTFGVzl0Q085cmMvckZKTnJHcUtk?=
 =?utf-8?B?WCtrdUlVUzZEbTl4dHZBL0prakhma05kZXR5V21JSGpRaGFrZkZ0elRZRkM3?=
 =?utf-8?B?M3lENllCUFdSbjVyOW1JMm02ZlN3NklpSnVLK0NuWjI0ZjRUcC9OM2JOZXZl?=
 =?utf-8?B?cmlQY285bko5dzZWYWFyKzlDbUlrVVI3SVRad1M0WU5IenRHdHFQamlLT2pP?=
 =?utf-8?B?YmFlRGltdVdrRm1PNWl1ZnphY2pUb0RaK3I1UG9rM0xGT0VMS0dZd3FhSmlR?=
 =?utf-8?B?STFTeWcxc2dyenZjUElUYTFtOFh0Yi9MVlFWUHpoc1dXcXBVaTVIbXBKbGFP?=
 =?utf-8?B?RmF2bW9OZG5yN2h5SCt4MHE1QStjNnFEajZ0TCtYSmJONEE4Vm5OMzdFOXNj?=
 =?utf-8?B?TjNoQjdpT2VVNFplYitNV0JCQ3VIaFhzSzhNcG9YR1paUTNhRklqdGd4R0Rq?=
 =?utf-8?B?Zi9yOUhaWVhvSzJyRDNTTlpYQ01TVFozV1MvQnJ0cndkK1crL0tSZVp0QTVh?=
 =?utf-8?B?UHlSUEVUcHgxd256QnRuS0lyZkFzaWRhSzRtaG5uaFhmOG5hUE45Tm5PdEUy?=
 =?utf-8?B?UVp6Q0dvZ2RWenpTWjY0U3ltMG42TWMrK2t4M3ptclQ0L1dzYy93MlpmbUNm?=
 =?utf-8?B?bHAxL3JhaEI3dGh5RVNESDFoUU1yakhleEJ4b3R0ZkcrY1haaGhXc2wwWlFQ?=
 =?utf-8?B?NUk3U1pvNEV5UEY1WEJEZ3JIVmRJVjBYOUtCRjhTQVY4aEw3SHlpM2xsell2?=
 =?utf-8?Q?qorhXyBFGaW1ELv0VXe0pqwD3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8147b7b-fa52-4384-37f9-08dc6bd30742
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 00:42:08.4482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgU4kX8Si7zYME7fZLznUZUdNApnTOepqYDa5F1s4i+1QGG1utqJ1qPvBSNpCkk3HJPFlJr18/rRGN57Jccb4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7726

From: Adrian Alonso <adrian.alonso@nxp.com>

Add IMX8MN_CLK_SAI7_IPG clock entry.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Adrian Alonso <adrian.alonso@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 4bd1ed11353b..ab77e148e70c 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -583,6 +583,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_CLK_SDMA2_ROOT] = imx_clk_hw_gate4("sdma2_clk", "ipg_audio_root", base + 0x43b0, 0);
 	hws[IMX8MN_CLK_SDMA3_ROOT] = imx_clk_hw_gate4("sdma3_clk", "ipg_audio_root", base + 0x45f0, 0);
 	hws[IMX8MN_CLK_SAI7_ROOT] = imx_clk_hw_gate2_shared2("sai7_root_clk", "sai7", base + 0x4650, 0, &share_count_sai7);
+	hws[IMX8MN_CLK_SAI7_IPG] = imx_clk_hw_gate2_shared2("sai7_ipg_clk", "ipg_audio_root", base + 0x4650, 0, &share_count_sai7);
 
 	hws[IMX8MN_CLK_GPT_3M] = imx_clk_hw_fixed_factor("gpt_3m", "osc_24m", 1, 8);
 

-- 
2.37.1


