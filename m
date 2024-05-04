Return-Path: <linux-kernel+bounces-168468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6C98BB8EA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AF10B23771
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAD51D54B;
	Sat,  4 May 2024 00:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="djnwQsXm"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2068.outbound.protection.outlook.com [40.107.105.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1F81CD06;
	Sat,  4 May 2024 00:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783316; cv=fail; b=TbmPFhZktPqMBErxAny/DZft8OsGRG8JvX3NatMIm7aAMTOCCGYDn+cPM9dsvdQtVbgWEJHCpcG39by+2zgrxEwfJFF/yGoscQuVyhLKL2bReAC3FO5vzbrax7aFBk0QXIs44LNV8YsQXHUqy3w6oq1dBpFEwhkRMxEx7yLn6YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783316; c=relaxed/simple;
	bh=nvSam4mK3om9TVz6wuJK2Z7DSK/o6N1d+PGOO/OShvI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Tdzd241b+MY7Z9gY1fpspHekNqUPV64TU4alikQq6pyatoNc2EJatmU3VF53XJuZ0wdzBGiNyFfcN63RQeSOhPqO8U5dhFRSQtjPeqIkLuEOf0RNl9IwieLn+dLpsCXcTFxYr30WEG+BTBMB6TGvh/tGscBZ9GParT1awrjTcPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=djnwQsXm; arc=fail smtp.client-ip=40.107.105.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdZYAsPoD379OCnoBb+7thc3ocbLRgCSzbptp+46EesaY8BsQgPix+nT1Jeu2Ym+maQdR7DO7JZH03z5uRYbE7t/nvjSewlIeQA2z1fK8LTNqWeeslqEygCCMaHcdUBSmKNKV3sLyv13Boc0T7kS1k6dUNnCLj2gUrrFRpzDeJtoUMRwcBXJQQoCeMjMexlu7G7ACnZMmgcozuzP3+YXrnMZBuW7+M9myC7Hn+IkNPZ6ExZgsZ+olF/DRWMEi9T+uus5GP5AU4lRpADajhGFRmkd9Z5Trd8SA3Knwm5rcJfgxEjafcsuvtKORkkwBQDdGWOSXFC5XzhOI4hpXuwijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usPxMF+abDDxGyg9lU1ffDPQeliZbPP71G7yzsYJVQ8=;
 b=AojNDDFqkUUiFDIuFzXW8sa1pUgQLqXDccn0Y81GH6rgCp4jWSJgG1+RhaoyyPRQAsTiR8Inn0wo8cJymUON56Lqd6OCsMMxa7AL/dItyGBgPX0rs6Dc44lQ+rjc4sbwoYoShJk6Bt1sxao1Bm0iU5fUAjTxcsdbUxBrsjUeLhkvsyGXCVr6O7a6a3VOUNC/IsaXcj2a10iiBZ+1IuXyXZmc2GeK4LuLlIAu4DQIh1v4tysEl7+MvrV38yukPjkyatkLSY2uTVb9eYZfAySeWrjRHQPWj0coE5kYZc9qLlUme/m0iBKa/ygLiSUYxEGrg6e9n4KwJLxnLYHWuH1dRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usPxMF+abDDxGyg9lU1ffDPQeliZbPP71G7yzsYJVQ8=;
 b=djnwQsXmK3yMxfGmk5cV1MYb5Z1sQYzE4q04a/Z7OvfdKwmq4KI0X5XtMp2+DmD2fObagRCGKEaAKoIRB9Z+glfLMUKbN2p3bwx7HiqzV9sVVHWOaOqtvMIorMAjxipWT4MfDSQH0I4yse84PstVtliIe+kFgIM7uZ6o0pi0GGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7726.eurprd04.prod.outlook.com (2603:10a6:102:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sat, 4 May
 2024 00:41:52 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 00:41:52 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 08:49:02 +0800
Subject: [PATCH 09/18] clk: imx: imx8mp: fix clock tree update of TF-A
 managed clocks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240504-imx-clk-v1-9-f7915489d58d@nxp.com>
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
 Zhipeng Wang <zhipeng.wang_1@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714783747; l=2375;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=a0EXy0fZ6h4g3hX/vQwYN1ZZTioQoMQK+mQT/+3QweE=;
 b=cMlJUB156F9beg5nUjxo/uGnlDbQZ1s+/8nImzkSPOwP5jegx89MxV40aaCbVsENH3jPABTIi
 fvdlMnw6A+pB/1KppU9/zXDXFy88Zm67rriI5Kt/rqja1h4s13akB7y
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
X-MS-Office365-Filtering-Correlation-Id: 8ab0e199-599c-4d59-de91-08dc6bd2fdac
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|366007|1800799015|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEJabHdUZk5jR0JHd1VKZzZtR3pEQVdYNm15VDhhWlhzUmhJb2EvaFRmWGlC?=
 =?utf-8?B?N0hyN2ViQ0pJZzd1NU5lampYYi94bTh5VU80VlY4V0g4c2t2a2NMaEV0ZTZK?=
 =?utf-8?B?b0dYQWpZQnRGTiswaFFjR2U3RWorTkdkaEtpOWdLL0ZNM2xGZk1OTUpsTnFR?=
 =?utf-8?B?WncxVHR1WDhJSjY3MUY5OFUrL2VidGxxeU5TTlM5Yk1NZ05xVGpyNUoxOTJQ?=
 =?utf-8?B?QmVFNVVSTVlDQmZzb3hXK1ZlYkNJZVJHOENSWGVTaTd6VWgrcURCd1VmSWpr?=
 =?utf-8?B?bC9BalAwWHl6Sll1R2Q1Q2Evd2MrQlVGalMxSTZHQ2hIVXdvRFVmd0RLdGcz?=
 =?utf-8?B?bjlZZjl2OGM2MlV1aHl0ZU50L3lmZnROSGlUSFZlU0hhSFJPcGRtZEU1Y1J2?=
 =?utf-8?B?YXRYTk1VVVZaMlB2TmtaUXBNTjJKNG9xZUxoVDYvaGNhbFFqSTJiNWlRMTd6?=
 =?utf-8?B?bVZFUm84eVd0WUtiR1FqUzE2d0VCTU5yQXZGVk85aWlpVUUybjRUY1ZHL0Rt?=
 =?utf-8?B?c3AydWZlWTg3WEx4SWpKS3N6NnlKcmlTM2FFRkQ0VlVEU0NSWVV0Yk1FbFBJ?=
 =?utf-8?B?bnAyNHFtVXh6RGEzMmRkL01lM0YyK094V0dBNFlrUEZ0aVBmV3g1TnVNblZI?=
 =?utf-8?B?VEJ0MmR3QWNqaTh1em8vSW83Z29ITXlxS25aM3JqRnBzZEdDT2xIc3NPZVJo?=
 =?utf-8?B?Ly9jem9JY0NvVXFkckkvd0FGOWxXTGNqbm52R0RTcmY0TVlYYnBLN2dGSUxZ?=
 =?utf-8?B?WnR5czBtdzVVTHV0bXBMV0NOR0FQL3RKY0gvay84OE1melpLNlZLdEFWUGFE?=
 =?utf-8?B?S0NuaFNUM3JWYjNWblN1dVNIQXpRUVlydGZiNmRrMVZZajEzNE9odVlXd3ZF?=
 =?utf-8?B?U1hPOGlvMTc1QkdFcndRR0NWVUVNZ1AyZWdYdENRMUpxU2JaVFk1UFRnMVFz?=
 =?utf-8?B?U2w0UFFCcitjSnBFaVBtMkw4SkhBdURjVU1GVTkzVnROdW13Z0xKVm1QWWhm?=
 =?utf-8?B?RUcrSFV3MSt1cksvUURJa0xkRnkwR2NWUnMyYWY1bXV3eDhrR3EyTEJPay9y?=
 =?utf-8?B?bmRYRitRWG1TdVIwZWxoc3hSVk9sYUlOSWNNQzI1bEZyM1VrNUZ4NlAzWGRM?=
 =?utf-8?B?UnQ1VzRsdmxRWVpSdkVWOXpKc2FRK1BjOGR3N1dBdngzblZyOUpxUUtQeE4w?=
 =?utf-8?B?VFZrd2I1QUo0alV2M0RHVGhFZzdhWHV2VEVzMEtqQ29HNVdIZFg2bXN6T2Ux?=
 =?utf-8?B?RWZyaUpJRUp4OTArQVZ0MWxSdlBIN2U5YktzaS9TRFlZM1lZdG8zUUN4bDlH?=
 =?utf-8?B?d21WNTRsbWNxbTJWS3ZyNjRMNVN6Q0cxaG0vNHUwdGlOVyt4ZVkrQVN6Zjhp?=
 =?utf-8?B?cCt6SUs3YUpNeS9XbjZhdHVOL1RBQWdaVkdoME9WMjhVSTdiK3JSamRDdCto?=
 =?utf-8?B?RWc5ckM4L240dW85ZzdnNlFtb29aeGJQMndJcHNsZnRFNVlHanVNR0dBb3hM?=
 =?utf-8?B?bURQcHRXZW5KSE9FbHBKSEYwSWdJcUkrV1diYWN2L1VqQy9WZGo2Mm9nVk1R?=
 =?utf-8?B?RXBsZXVOYUg4eFA4K29Rc1pPenJicVp0djZDZ1BSZjJPWUpjZU1nVnk1eTAr?=
 =?utf-8?B?YUxmWS8xWFhCbkRSVTJFMlFOS016ajk3aE9aYnVHclBWeDVLSUVXSHd0dThD?=
 =?utf-8?B?cHJJTjRVZFc2UU9HRFJGWkJjTnZjRWhLdHU4NlBYdDIwWDdUZ2g5SS9LazNR?=
 =?utf-8?B?ajFNZkdGVU5saWVBOHNBNHJFa21QY2R5Uk92Tmd0b2lySk80QVVLMCtjakVL?=
 =?utf-8?Q?lwmAICfTAqkMOx8f5ZIGc2lFC95YOR3a4dZ6A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(366007)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djg5NVJ2dWo3Szk0d21qVVZmdU5qTnB5RGpYZENpVDQwWFlKL3RwbjBITktw?=
 =?utf-8?B?cTFVZVd3cW5lRUcwRXYyQnVraWN4NWlVZGZETjdMNzl3ZW5Qc2xZR1kvUWEr?=
 =?utf-8?B?Q3ZlVzlvdmVFdi94Q1VlL1JOY0kzMUU5RWkxNU9PMHpzZVRqdWowTis4V3dw?=
 =?utf-8?B?M0tuSkN4MW9KKytPa3NGUlpVRVhWZEhiemdkRDlkbHVaSlIxS3JPcC9NOURL?=
 =?utf-8?B?cGp1NUpySlVkcGJIbE9DN0gvTUtkTzhvWmVtSkdSQmYrMVVLTS9KYURCY3hr?=
 =?utf-8?B?aUJoRFNyTmZyZ1VNL2pXeldlb0N1WDV5bUQyVDBTUmxpaUowYWpqM25MRFhO?=
 =?utf-8?B?Q0VKNVFGV0hGOVRLWEhmODdseFhQY3UrV1dLU2tmNmJwUStMa2t0ZjcwL0to?=
 =?utf-8?B?d2xHaVZkbkhvTThRMnFUOUdFSFNWb1dPRnVUYmxNa0lhbzJzYmFWYXN3MCs0?=
 =?utf-8?B?eEFFOHJHZFlGYzRNbGhEV0hNSjVaOGRKQUQweXpWa2JTeGNpYUlEeWZ3T3pM?=
 =?utf-8?B?T3ozVktBSENBVFNGK0JWYmNYbXRrRDBKaksrSGZUOGlPZ2NEREc3UGFuek1q?=
 =?utf-8?B?dlYrcEdtNE9aQzc3emozWTlOd0s3RkYyN3llV2FWZks4MkR2RTFvYURnQ3pP?=
 =?utf-8?B?WUNiYUhPUVNXYlV0bGJPanBGbmd4VWZ3Yi9PeHc4VWQzRldYOW5VZi94eHhm?=
 =?utf-8?B?cVpDZGJNaTZDVFFCMDZwdjNrUUc3N1F5cUtoaWN2UGVXeUFmZUVSUkJ4M2dP?=
 =?utf-8?B?OXowV0lhSGRsK0YwQkpoTEdXNXhEYTl1WTJob0htMStiYlBJOER3T0k2dEhK?=
 =?utf-8?B?U3VDQlg0M3FTVHVPSFpGOUJ2aUVmN0lXTXVKQ1pETFNUYzd3a3BxZExFc3pW?=
 =?utf-8?B?dGNnTUVJbjJaNHRtbmF4VGx2K3p0NlIyZ1NpRnpvZHcydGFkN2xmTk9nZ2RF?=
 =?utf-8?B?aG9BU0NlRVUxbU1pZC9VZHJPRkcrQXorYmMrRFpoQWVLQzQrTHg4citJa0FG?=
 =?utf-8?B?RVdrZ21zY0dkZkJZQTJpWlFPdEJJVFhPVG5vQ2oxUFB5YjJPcFRNS3dpamNw?=
 =?utf-8?B?eXJWVkwySjA4eERGRDRUajg4dFRxcHBUQ1VRUWYzNHJJYnVzS1hBOEpZNURC?=
 =?utf-8?B?cUVhTW9vaFBiV1RnTVprMk52MGYyVTJHbzZBeC80eVJGakpmZ0Jlcm4zSFdY?=
 =?utf-8?B?dGxEL2xWeGhHaG9haDNVczJrUitGbVYvK2dsRXR0M09QWU9wem5HTFFMK2Zi?=
 =?utf-8?B?OTBTV0o3Q20xMEVlZGpVK2g0NW9valo2UDQ3am1YT2ZkTkg1TkxRWWNJOXV1?=
 =?utf-8?B?bDFSeE55UHRBYlQ3UzlLamJ4WHZFeWFwT0FERG00TGZoMFNzY25BUlVNRUE0?=
 =?utf-8?B?ajg1L01OcGVSRWk5dzMvYU50Lytub2ZNNkx1OXdzQUllY2ZZVlA3TUtEZWdB?=
 =?utf-8?B?bFFMTFN1dTliWU9vN2hjMDF3ZVljUjJwZU1hQWVjWmNwMi9TUjMyY2I3cVcv?=
 =?utf-8?B?Q1pyRUJKRCtodUtuUVBHZDFyQThLWng5dDlvYmhQRE5WN1ZzZUFuUG5xWnp0?=
 =?utf-8?B?L1VmU0E2blV6eG54cjMrQzdsRWhFVVlHQXNEa252UXNiSUpSQzZmYzhqMERq?=
 =?utf-8?B?Mmo3dm1RMXlWVkVxMkFtVmljanN5ZkViK2d6enJCdkJvZGJ0WXRqZ1dCMDZW?=
 =?utf-8?B?UjdxSWtaOU5xM3JTbTZqays0UVk2OXpJVUFrVWVMSTdtUHFnaE5wVnRrdFo3?=
 =?utf-8?B?YnkxZWVUcWhkTGdEQ3Foay9ibHhKeU10clhwY0creDMvWFVFWG1ZdnJqTzRZ?=
 =?utf-8?B?SU51elJtZHhWRmxvOHRpMXpSZ0JLZ2NUNVRYdzBScUIwUTJjUXN1RENBRlZ2?=
 =?utf-8?B?OEYwMmlBaXd6OWZuT01LVFN1OW80TXBTZWtVWDBPYzFnVjh0RWY1NWRmRnpT?=
 =?utf-8?B?eCs5dU50L3MwVE4zZ3JvUGYzeHFTSUcxNFU2WEEwcFFuL2ZVb1RTbEorRUNQ?=
 =?utf-8?B?elVmdUw2R3ZJVDRnRWZJTkRhcG5TeXBkTE9pSmVCUmoyNTE5YzcvWFFjeE8v?=
 =?utf-8?B?c255SWdpcnVkZzYwZm9sWDNhN2VKWEVNYW9BZlVHMTBJTGVidS9HVVhnaFZH?=
 =?utf-8?Q?9jeH8uQVaKdIblxM688D8ZWPq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab0e199-599c-4d59-de91-08dc6bd2fdac
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 00:41:52.3893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoiMg/z813mnowpWNklTM2HKx7AvMNZrXmJEcBjcY3Gq0IwcLFvA+l2i1JVln1E0VPHGj5vBmxLl02onVfH0HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7726

From: Zhipeng Wang <zhipeng.wang_1@nxp.com>

On the i.MX8M*, the TF-A exposes a SiP (Silicon Provider) service
for DDR frequency scaling. The imx8m-ddrc-devfreq driver calls the
SiP and then does clk_set_parent on the DDR muxes to synchronize
the clock tree.

since commit 936c383673b9 ("clk: imx: fix composite peripheral flags"),
these TF-A managed muxes have SET_PARENT_GATE set, which results
in imx8m-ddrc-devfreq's clk_set_parent after SiP failing with -EBUSY:

clk_set_parent(dram_apb_src, sys1_pll_40m);(busfreq-imx8mq.c)

This is safe to do, because updating the Linux clock tree to reflect
reality will always be glitch-free.

commit 926bf91248dd
("clk: imx8m: fix clock tree update of TF-A managed clocks") adds this
method and enables 8mm, 8mn and 8mq. i.MX8MP also needs it.

Another reason to this patch is that powersave image BT music
requires dram to be 400MTS, so clk_set_parent(dram_alt_src,
sys1_pll_800m); is required. Without this patch, it will not succeed.

Fixes: 936c383673b9 ("clk: imx: fix composite peripheral flags")
Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 670aa2bab301..e561ff7b135f 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -551,8 +551,8 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	hws[IMX8MP_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb_root", ccm_base + 0x9080, 0, 1);
 
-	hws[IMX8MP_CLK_DRAM_ALT] = imx8m_clk_hw_composite("dram_alt", imx8mp_dram_alt_sels, ccm_base + 0xa000);
-	hws[IMX8MP_CLK_DRAM_APB] = imx8m_clk_hw_composite_critical("dram_apb", imx8mp_dram_apb_sels, ccm_base + 0xa080);
+	hws[IMX8MP_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mp_dram_alt_sels, ccm_base + 0xa000);
+	hws[IMX8MP_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mp_dram_apb_sels, ccm_base + 0xa080);
 	hws[IMX8MP_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mp_vpu_g1_sels, ccm_base + 0xa100);
 	hws[IMX8MP_CLK_VPU_G2] = imx8m_clk_hw_composite("vpu_g2", imx8mp_vpu_g2_sels, ccm_base + 0xa180);
 	hws[IMX8MP_CLK_CAN1] = imx8m_clk_hw_composite("can1", imx8mp_can1_sels, ccm_base + 0xa200);

-- 
2.37.1


