Return-Path: <linux-kernel+bounces-48810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBA08461DF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6623E28A8CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEEB127B4E;
	Thu,  1 Feb 2024 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rUwZEtAO"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2055.outbound.protection.outlook.com [40.107.104.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718ED8527E;
	Thu,  1 Feb 2024 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706818994; cv=fail; b=ZZtI4As07x3B3InqYeLYTZI0CqPsRwXQXxmSw/6RrHleEi+S+rSApTLEN/raCXn9jp0rTFY/sK0sPpQiegdq+WUWkxc5bVVNhrFaWNcKgdAkGd0c3GTVRD4ePBOClOuJcCpPqB/2nFbFBIN8gabkYAuFBXJQpNrvIpb3gmgspQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706818994; c=relaxed/simple;
	bh=T0y/634CeJ/Y2kFlSehBAzcS+0Apes1r2s2hE52uAOA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Wv4dyC1sfJfHG23U7ZxD3PVEiDwGV5xetHdbn+pshZPTNMoiFoF41imZvyog6PJJyMxmAV4iw5ZZlsP/EKAf+amQWVChp/WcIXUETmGeyzc8M/y7iQZYNiTmzUHeyQ5ADXq5fYckIUjz2XMPv2zUZ2LCHpOh/vgFL55qDSVOTPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rUwZEtAO; arc=fail smtp.client-ip=40.107.104.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkUW1Y3azisgC6riaaSNp70+cWkCBBVmosJuPiMAbhrrzVU72/UJy9s5nx0b7mVVP5L44KYjrzqOyR836omrsYUxnwodXs+t0D6WryjamgbjA75Sbr+2z/vVVQ3j2Fvm+4Fh48VQUVYNv4uwpITgjNrWyoKTHQexng20azkQxyJly1bCe2xtWAabIddmtIDGRFzW3GyvhozzkMKHN8COw5pPFfKR8fBEwd3rZ2hFeW7w99uwtjT38K6MI1CwR7aoJERJzmlla1r0NaSNryR04HIQBRXCnFucEGAgUNZ5yWOmYRmsoD082hRK2nADXBCihTYmNF9G3z/98SFnqVAhRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIRDkGdNzMv6n/KV1aZsbm5lqELADX+lSlm18j/9/ZM=;
 b=b/RyG+CydyzveZjE0gxkxBVyjLjhPtSiSxS5oJo05DVdjnvDnU/lltaLzv/6xYWZ1B6LRxLETV9ZQYeauHsT89Iqgz0SHktwvEjcG8NYGPEc231F/lJ/5p4V/tfGiRaCZGZi0hSJqSPRuHHUMMvxgJa3U5eXIlgwgw9jLXFoCHJpjjjqY30T6icFtoFO55/jcTHn91BlKbBijkZqQFepCEJqgRnRsGNcpo6tqBsoWHmUhsORBHHHD3NIJyqDfVcKG/CoA+dpLFm8nL1qkt3u0rP0upTJzfzfDH1LXI+cIN17T1iiexqW2iWxcKSdsdX0Ko7A8Am/guKE1yDJDrLRtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIRDkGdNzMv6n/KV1aZsbm5lqELADX+lSlm18j/9/ZM=;
 b=rUwZEtAOSl0lE5qLzkM4ZwPmbT28pkZ1k/E1VMJ4ct+zKdWKzxrSZVZIz81V9Yi3Rec6R39RktfsHZLaisviQl5+JMFnKVHo5qs+YfEoGBWy0CWhdq0YPrwfx4V9i5uBV0L5qijcS5YnCaGzHYy8iAdF3zOgcjWuGpKXnNLIWE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8741.eurprd04.prod.outlook.com (2603:10a6:10:2df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Thu, 1 Feb
 2024 20:23:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 20:23:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/4] Add 8qm SMMU information
Date: Thu, 01 Feb 2024 15:22:40 -0500
Message-Id: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJD9u2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxMDIwNDXYvC3Pji3NxSXTNjQ4uURItUSwNDcyWg8oKi1LTMCrBR0bG1tQA
 9fOi3WgAAAA==
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706818983; l=1631;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=T0y/634CeJ/Y2kFlSehBAzcS+0Apes1r2s2hE52uAOA=;
 b=uvtyXXvKXYLeIta215JlT8E2xAkEsOQQZGkanxahynM6HoWnUPxZj/LWu0bjrjWSjbSOGPiD4
 HhUHdVUlLdBAqcX1iqoSdSu67DNET2+3+9NMeFqZgVJGCubXtsGWPkE
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:a03:60::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7be51d-35e8-414a-def4-08dc23639af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oiI74Sto7hWf7/tBDq/Kstsu7YkXc3cZLIRWr1S5kDo5NtiUAON3EfaJPzDVHYqETjjmH8XIOQwQLJMSCjqQqBUxO2gSZJj7HIuK1o1YGGnmnvfhplWrZjMSgXotIaQXhWrawSWs36NUGmggNM4UiOFLH9bxW5nZ72h4lyVstB3kd0bzYKyMDIdTBJX8QLSBQ8pp+SBaBw+omzKb+Ms5TzH9drG2GtWeEdPmClKQJd2tL3Kb8BOThV/pTOKX3DEOdUqRJd5zZc65c5lPf9bTShr8OKSBeG3QYHNQaXyTh900MFsS7qV0U2g8dKQ9FWw8YDF6TOMcB8rpSUSdLtTj0QvJ0LMzxEoKemDsc9gLTcqbw0B0nAiG76xfiHZGQE1rjtqIgBLVRpxAnk3BSSHk2qc0JBD4Hxcr3yWTiP4vzacokmz7X0Yz7n1dCFMFlPvlQp118bhVqaRwqlMrq+biYaY/Srd9hvQNFlxDYEcRFuEZJD0X92J+pmejGu85vfR+8UQxwzvlqphYKvXHMVDSlfMHc0W9omeYXchD4bnz0Lf0GLbjjzmIF7lv1FJSYLHgJhF4X3ujIg7nf6kBjoTTlZbBf39n0QdvXXwDjYkeOabMysU8STfShQxlElf4NhPyq14GAqEcywNnQPw00Kh6xQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(2616005)(921011)(41300700001)(478600001)(6666004)(6512007)(6486002)(6506007)(316002)(52116002)(7416002)(110136005)(66946007)(66556008)(66476007)(36756003)(8936002)(4326008)(8676002)(5660300002)(38100700002)(2906002)(86362001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkkxL3RMaE5vc2JmVXplU0tsbTlkTXJSdmkzb2VwVnZqMFFGS0pmVEZ1eUJJ?=
 =?utf-8?B?Skp5NzVQMVF5TjZBTWx6c1JUYUoveFZUMFY0Ri9KdUVzNExzcXU5TWlkUEsr?=
 =?utf-8?B?VzlsUlpZb0JSTEtDZ1hvRFFiQlJlSU5FMHR4NGgrYnhjeTRkT2pPdFd1UzNX?=
 =?utf-8?B?dHZ6MlVCbmsxbmgxai9ZTWRoQkFrVFI4N1lORWk3UDc4UXhwWXJENUYxQ0VH?=
 =?utf-8?B?a3B5Q1E3RnVHQnB3UGRXSkVFREpPUkRPcHptOWVqdUlJZWZHZkMvZW5ua0Yv?=
 =?utf-8?B?UTFhZmpVT0g3QVhNYktsbVFHUnVURFZrNXBkOE9rQUU4VlhZQjBEL3Brdmp2?=
 =?utf-8?B?aUNrVEhrd0NsQnpvSmlSNDF0cjNOK2VPZmNBTnlFZURrN2JaZk1lOXhBVEZY?=
 =?utf-8?B?WENjVVBjMXhzaXdvSkt4bFlDRytTUkJLV3lvaG5jN3k2R2haTjVGRVJ2VWVS?=
 =?utf-8?B?UklCbjl1Y3FoQ08yZnRiM1RWK3hLK0FYYS8rcUYyclFqM0I3KzRhRU9zSUtZ?=
 =?utf-8?B?ckJQM2xWaFljOTBUb0hKSGh4V3FkZWRsSHBodmorQXJ1M1k4TDNZS0VsYXIw?=
 =?utf-8?B?bktvbWpOdXRoVTBrT0lJMUZqeVVUaEdqOURPWmJZSUM5V3YzbVg5a0pTVDFU?=
 =?utf-8?B?RDREQ3VRb3VDV3JqbytPcVFyVVJMTEpZZE9FUEVFMzE5MTA0MzQybXo2VlV1?=
 =?utf-8?B?eHdlVnQzdU1salM1SFFmZitYV1pMdGZXUi9RbTJLTlpBeFFNTWNTMTZkWlI1?=
 =?utf-8?B?L0dXeUxJYkQxMzFWV0lWbUdFbi9WUVBmazVGaHpSWDZTZUlkWkJqdlRkc1No?=
 =?utf-8?B?TC9lcm5udHpxeitCZ2ZBaVdCREpMNmlLMERnWDBmVzV3MFg1Y2FTdEdrdHoy?=
 =?utf-8?B?c1lWaXJzaVdyWjE3TElneERsenk3dVBOK0hkNm5DRythRmNEWXVlV3ZneGdS?=
 =?utf-8?B?djBxUTZGOW9KM0R5ZUsvMXpSeEVkQzlyV2NKTkJjY2tjeTV5OWFkUDZNWGw4?=
 =?utf-8?B?dG5GeDlzTHRxUHlwaTBja0VScGw2Z0NrYkRBRlhDN0lVRVUxb1cxSXludHVK?=
 =?utf-8?B?MmJXSUFiM3lOQlMxSGpmNjNsaTJLcU0xcG1ZOFNPbXBzQWo3QTFlN0FrWE50?=
 =?utf-8?B?YW92MW5ES3B0TlVPNmdJV3JtWjVUV0JBRU54d25xMS9aaVArUVhVYkJuYlhy?=
 =?utf-8?B?UW5PM0tZckVSMHdBdXZpUyt4dEVzNHJRdldWQVhUMlc1djd6TGlCa0xvSGJu?=
 =?utf-8?B?VURYLytBVkhQU254S3dZNDg3YTZUYUc5K0JXYUZ1YjNUYmNGNjlOM3RGc2lR?=
 =?utf-8?B?ejlLRklIVWtjUHFjZnVPTHFaeitWV3JIYk5wVmVNUHJPM2UxZHhHcGhWN2hZ?=
 =?utf-8?B?QmszZkFkdmp5QWFIMXhVRXdaMU1PcC91K0Q1N2hQZTN2dWg1RGsyWWJKOEpJ?=
 =?utf-8?B?elZYbWkrVWhrK29PcWdEaEtkaGliNllxTEdBN0s4UDA5R2lMck9oZUJlUkJB?=
 =?utf-8?B?cEhhUjdvRnRMVU1WOXFnZURkUWpLN0c1aUtiN1dDODUyYXh4eVRIMVF4dXlk?=
 =?utf-8?B?UTV4K2d4QmxUVTd5clpDdFMzS0JNaHJqZTNOUjA3WEp1SXBhZUw2L29CVjJO?=
 =?utf-8?B?clV4Y3JEazQ1ZDJwVUQ5NnhQeFo3eFRxNEp0YWxJU0tYRDBhMXk2ZEpyVWRB?=
 =?utf-8?B?WDdreHd3NDB4T0M5UUgwUUNydFhjczIyT2tkWkFZdWE1SytCaHpTbWRCbThs?=
 =?utf-8?B?SVlDVTFPbER4N0xDdWlTUjV1NDFqZkM0MmtzZ1p1QXhqaDk1RVRaS2ZDQThG?=
 =?utf-8?B?NlN6RGhuTG5wMXZGdGRvc1ZWVmdEZXZuVEVoV2h0clFWbzB6TEFQTHhkM1RU?=
 =?utf-8?B?dUhZSG5FdWk3WVBiamFGMXlyNjFSN0hPaXZlRFM4anJxWWJGYWtiejZPSlVk?=
 =?utf-8?B?cFpEeThpNzlNMHB6K0ZITWNPWlcrWDEra2hqK09xQ3FFNkFWUzl1bUFPVVJZ?=
 =?utf-8?B?cTNjUUp5Q0M5aSszckxoOTNrVVpvT3JvYlQ2cEc1QWs0bEgrWHhjVnFPRWww?=
 =?utf-8?B?SXlWVlJqWkRIUCtMM25CZXpmSkFGZFJRY0Q0YnIvZVptbzRkTmZHQlVNc254?=
 =?utf-8?Q?hSE+X1E0MQYV+xZAJC6iZrW81?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7be51d-35e8-414a-def4-08dc23639af7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 20:23:08.9614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9CM+ztvej2LKqkc/mfXAwFWyXcQRPr/kTLxVFolEyfIWwN+reesv2f4n1/Uh4XIr5s/wv/yTq7p8Ke+bAICAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8741

Change at v2
- Remove iM95 for fec.

To: Ulf Hansson <ulf.hansson@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: NXP Linux Team <linux-imx@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
To: Clark Wang <xiaoning.wang@nxp.com>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: imx@lists.linux.dev

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (4):
      dt-bindings: mmc: fsl-imx-esdhc: add iommus property
      dt-bindings: net: fec: add iommus property
      arm64: dts: imx8qm: add smmu node
      arm64: dts: imx8qm: add smmu stream id information

 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |  3 ++
 Documentation/devicetree/bindings/net/fsl,fec.yaml |  3 ++
 arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi  |  6 ++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi          | 41 ++++++++++++++++++++++
 4 files changed, 53 insertions(+)
---
base-commit: 99748ff5ee0953610765e9d0cd6015c2eb0f7ace
change-id: 20240201-8qm_smmu-6318da8e9017

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


