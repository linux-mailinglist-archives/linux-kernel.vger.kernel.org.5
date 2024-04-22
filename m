Return-Path: <linux-kernel+bounces-153853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0297C8AD42C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8A628337A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303C915533F;
	Mon, 22 Apr 2024 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q4R0RAq4"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF84155313;
	Mon, 22 Apr 2024 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811527; cv=fail; b=ZsKlPBbTnlLXlAImzbj5XBaRxOjcrlhzhmM0Rin+cyJH0Tkio3WP6oWtRp4dW1v6J1pnUawt4Q8vtumlF08skwKjVU0LPVLwCyp7uoCU46M3k0wKcOAFkiknllagtuSoUxXn0CiR7/CvGTTY7+hN4UH8bSxzWlFO2f+QmUzcPdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811527; c=relaxed/simple;
	bh=N0RdEHUZsI1zzW6nCuPZ4hZFLMrkfmr6Old8d5fO7aM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TtM1mZmUAmJftH08IduWWt7wL8+Tk76ehgMm3PVl2qXq5duLDz3OaUNSyEThX9Y7uh0EhpW2sRF5duiouqEJc3qNf/PWJoFFGZ6UAIYyRlmxFvRyng71eoMR7zpM0w3fNok9iYLsLXrU73Bs2m5MwHQTGeCxJyZIPunCrPH3es0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q4R0RAq4; arc=fail smtp.client-ip=40.107.21.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5+G4T1pNPSkOkWtdl9d44GuWBZQ0336LuWc4TEDpVJuvoYBfT6s/L1nB4MYHa8wXpyFwovNwoUfJ95TtP5D9+TwMA2OON3jOU9/ZxPq3VKMiKxI00smQHGKIW8JAcOUNygjJqhcaIaAL57b4+fJOUVASIGvfBaRhvdczt3e6qNIYN7atrjPzHzxZ7+WiYaD+qkqcUfCXRxQVO58hQRu7yuOP54yCqN2oMfXYKSU6bywSNQQxkLWh6QjFqKCtP76cqTcupMGZ1OPZ4hTEMY0Bvv2BclpWl/MQtul+MB5+tMQr3xoTRaQmKYWzKGmutucxcuLY/cr6qyTfiUpj34kig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7rGWxaI5aeMHq6ZQYbO3rxp1eHNz45A7eYB681GZT0=;
 b=GsYbO3OVS3J9kJRHHu1qw9hjtJF/sazBAdwGgmAqSZ6tv1DW1bPpj5ZAm+W2warcFVO6B9D0Uk8xVk2vQzPOFP5g7LFcLVlq5+iO4TdCTo2b6q0eK6hgEdUSEX8uHczDOgMpVtkDqk4yTvaB7mqJGXx9AAQp4nNOaeWPZQf4uqoH1j3FPWsifFlozFF0dFKDJPn8fjkxtHCYfvKuzDScKfuB2aGSWrIlSYEro36UziMqw26imKClCYE6FcuEe7ruHlF3tYUUsBuQWx5HbOfQA6H6D6mu4Mh3NOYRI07iTyCt89Uxt8lJ/RF2hyXzxP6TRrF0aDLfNiGdP38CGMGQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7rGWxaI5aeMHq6ZQYbO3rxp1eHNz45A7eYB681GZT0=;
 b=Q4R0RAq4lyj4gmilYYYm9aaK0lFF0xAC5AawV691PNLk59+wURuV4kwiKWK5LdWKJ0UQaxqNEllXYw3ALOPX/EONIMnRagHNVinZgz3r2WkcRJgSXDRaUGQMVotBGng9o90olFOsTJhUWWqjnWVq1Ru2464rcHoJziLzmLrlch0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8853.eurprd04.prod.outlook.com (2603:10a6:10:2e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 18:45:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 18:45:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 22 Apr 2024 14:44:52 -0400
Subject: [PATCH v3 1/3] arm64: dts: imx8dxl-ss-adma: delete unused node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-b4-dts_dxl_audio-v3-1-5017511f399e@nxp.com>
References: <20240422-b4-dts_dxl_audio-v3-0-5017511f399e@nxp.com>
In-Reply-To: <20240422-b4-dts_dxl_audio-v3-0-5017511f399e@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713811515; l=949;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=N0RdEHUZsI1zzW6nCuPZ4hZFLMrkfmr6Old8d5fO7aM=;
 b=vCZ5rxI9RwAMCE6Zk0hgf4BLLOfqeRfyXTUHVr/LsQxfkOpSp8+lT1h+uKrAr8V/AZwLBGfig
 rAZv2fU6l0zAcft00jvzCepbVrrrXjpcNaHDCrE94h6pRlcZW6Nh0aV
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0126.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc67183-558b-44b1-ae7e-08dc62fc5d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aytOTHN6Wm9VYVl5Y1NnM2pJQ3p3WGswVHFZU1p6bmhTNUU5R001L2pLN0FY?=
 =?utf-8?B?aG9KVmhWK09VaGV4aHVaOXlxcnY0dVZwdCsyMGllRml6MXFUKzJ6K3JQUHk1?=
 =?utf-8?B?YkhQUkJObW5xZWtwK0dJdkF6NWtiTzJHb2Jpcm5MNW1pWTVKZXBpamtEWWlD?=
 =?utf-8?B?RHpzcWF5dlR5M1VzRnB6V1dCS0JRQURCaDFuakJTbG9pZHhabWdzc2FnU1Fh?=
 =?utf-8?B?aG5Dd1NieWgySitOMVp2cEREaGNJSGJQb2s3cnFLT0tYbFVnZXpKMUVXUDBl?=
 =?utf-8?B?SlI3UG9DaFFCNUxFcHJ6YXF1UC82QnMyVDFjVi9xU0RCcHdiZnhNeEtLYk42?=
 =?utf-8?B?aUIwZmQ5SXJKWUdYWUp1cFUyQ2xiaWlETWF2NU9PdFgvTUtSMTlSdkpvMUg0?=
 =?utf-8?B?SE5USlo0aWRucnU5dTRuUDcySFFHZnliOC9kRVpCMDRzMy9EZTlZWTdmNlJQ?=
 =?utf-8?B?VVJZUTdQRHM1UmV1UUxnbVltaC94bTNpT2xMSXlnNnVXOXJUMCtDYldwZjEy?=
 =?utf-8?B?M0k0UFRWenhMaXU1MjhuMjdRVjhUOFN4dzlDdXdlc3J4MGdmbHVGa2I5MERM?=
 =?utf-8?B?NkZXY1BPTUNGT3dZRC9uUlczZGNSaVc4TC9INkxKMzZOekpoRzlwam00ZkVV?=
 =?utf-8?B?eGVXUmNWZEdSa2YxZ1FGQWc4NzBDalBlWEh1RUNjc1UydVVVWVFSMnp4bC9G?=
 =?utf-8?B?b25VRnRpWXByUnFVOUpLSVlVS2srM0pNZ1hPZVlyS1NTRFEzMHJzd2lIaUZv?=
 =?utf-8?B?SFptSmRwc2tCM1lFN2NHemE1RWYzQVdZaWhhN3o4WDRLWEFDd3ZrQmNzRTVC?=
 =?utf-8?B?bVpDQ0JtZHRjcW9XZ1ExZVpjNTRGWXU4S1JyQ3FURkp5dnh2QkRmQm9nRkVP?=
 =?utf-8?B?K0JRdjFORlZrTGRDb2QxSlV5UzJMT3B2ZThoNjQ0bWo1cFJ5M2EwRC9DSEJR?=
 =?utf-8?B?TitWT1dNZFZSZC8wLzNqMDI1T3h3Ym8ycHVCa2J5SE5KMEJ4N2ZZVS9vVzhC?=
 =?utf-8?B?VHNqdjFrMjZvTGZpT0lrb1NrWTlDaWtHOFNNeDlad2hvUnJYME12emJaUXpo?=
 =?utf-8?B?YTE1UjRqMDlLNVoyZHpieERLa3hpdFREUXQrdGhzdUsrSngyZEJCdWgzRnJ3?=
 =?utf-8?B?bUQ4MmdCczJQZ3lnck9iOGVlRzEwcys3cGl2UVlMdVZ5MmN6SThrdGQ3T3NL?=
 =?utf-8?B?azRaRm11dm93K0dLMVRmQ3YvdzBXZW5LNEQ1Z3Z2T1J4ak9JK1d1Q1lvdTBS?=
 =?utf-8?B?TzBjRi9SZmFqa1NpR2hhQ3ZFdzVsOFBDanN5V2pMaDBkZExoTHlZb3hkdFlZ?=
 =?utf-8?B?WDZUSVhHS0FlMk1meVN4M2VONnM5TmpTWGcxcXdUaWxIR1N1d1Qyc2h3U2Yw?=
 =?utf-8?B?Z3NyQUdVV0hpVllVTTBZalBERjdQOEtEWFJXb2pSK3hSc3FrVEpqNVlwMUpt?=
 =?utf-8?B?bk12VnZhc3I2YW1lK1BWOGdoaWdVcXlVNmhCRkhFK1BqYmJCeUZjMFpvSllk?=
 =?utf-8?B?RHhkNUNsODZ3aG9uTThUdFl3WTRRWUVQQzg2R1hjUGZtOTlIekxNMWFiQnFY?=
 =?utf-8?B?MXJFeXUrNGRqdWxhaHNPTUlVRERQVnFRbVRMTmRoNVdYSVlXdUtWSFA4aUxG?=
 =?utf-8?B?cGNkelpUR0ZWRGc2MWtZNHJ1V2xXM1pwSnE1SU10UloveGdiUFR4WCtlc2lk?=
 =?utf-8?B?WkE0TkgzMzZLM1U0Y3lsbi9vdnl0WWVWa1lQMVpUcktySTVleDl4cjBQTFlE?=
 =?utf-8?B?V3lsZFhwOEM0T3VyMHIvVWxSRFFoaXhYRVZDYmJOTDN0WnZxRXZqWmdzYmkz?=
 =?utf-8?B?dUp6a1ExdUZ3WkYvd2lGUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXBxcVJvbWs2UVd4dS9rS1BGNlFPU2F4Y1dnQmF4WFN3a2E2V3hra3pOMDMy?=
 =?utf-8?B?RFNHTGYydllOUVdiQytNQVF0eTlxZEZUWjhzOHlNaW1BSjZSeGpLRm5EaExl?=
 =?utf-8?B?Y0Q3b2wweDhYZmdmSDVLNVBnQWtPUlEyRjQrVFdvaHhtSHpBZll6TGRwZjR1?=
 =?utf-8?B?MGpqSnFyVS9ZZTlHSlhWR1E4OEJVZ1FBWXR0OXFOMGJCM2R2Z294VFRSRjJV?=
 =?utf-8?B?aDNac0Vyd2tTeDNaUk9xQThRVnliTFIrbjRLcWFhU2lQa1ZvM0lpZHNBUEx0?=
 =?utf-8?B?L3FTN2dxcG1wbXVDZ0puTTBCNGZ2MHB6eWlKSDFLa1N3ZUdDd3k0YTE2ZEht?=
 =?utf-8?B?cUJYN0p2UHYwNG8xV0hGN0tYcnRveTdZQnNNcUlscmV6c0E2d0ZoRDh6eHM3?=
 =?utf-8?B?bXFPQU5sTWt3aTNQNUR2SzN4dFNpUkpZQnVPRFhESVNRMlFvNlRpWHBoK1R1?=
 =?utf-8?B?TzBDNDVqWjVhVW5wdERwZVhxNW13WlF5VklYSGdOeXh1LzVibzNCaXg4dGdm?=
 =?utf-8?B?ZUcwOVR1eFlNM2I1QlM1VGw1MVIxVDgzZ3JqNVpVNENGK0lqVm1FVXlpcEtm?=
 =?utf-8?B?elR0dDA4YTlzU1hTbFp6UGV3WnlBckhsVk5hRTNkaVpRMHMrV21ZUWZ3M2dX?=
 =?utf-8?B?TDB0QnhNWmpCWm1KbzlZWWkwV3RteHVRRVlDRDYwMmFyM05pV3NlRGd6RkJp?=
 =?utf-8?B?TndHUXFwZUV3Z0RIZ2JkR3l1QUFvUm50Z01nLzl6clpVS1g4QjFTcldBOVdB?=
 =?utf-8?B?Y0lWRUg4MzRZM2IyVlB1Ulk5Qy93b0c3VSt4clpUV05WYk10NXA1Z0xFS1ZG?=
 =?utf-8?B?U0p0a3dxcE1JdzBkSFdvYW5vTnpjUmE1MmtZQ1JSNmlONm41eW9QKzhEWXF2?=
 =?utf-8?B?UzF2eG1YNVIvZCtNUk1BYUh3S1lQMnFiZ2RMVytwck9CTVN0WlZzR3IxT1Vi?=
 =?utf-8?B?dXRqMSthS2s5R09BbHdkWFJBeXk5TnIvVmlJOEJycmpNRDFlclpDV2JUSzdw?=
 =?utf-8?B?eFgwMTBraEdsaloxMEpsYTE1T1FXWGUySEJpVE1sZ2RwY2Z2VUpXQnRKaG5F?=
 =?utf-8?B?aHNxSHg5N1ExWFYvWjBjeHdHbHJCOGRNOUhhendKYXQ1R1JMa0VEdE54SFBW?=
 =?utf-8?B?TFdydVV1QXFjTHRrTjFvRXNMN2ROY2xCUGpxL3Z2TlAxWXJuenNjQ3FYMWN1?=
 =?utf-8?B?OHVleWtXTnpPVytXYWVLSDZwdXdpekwwempGaENzVkJEWStoRmxiTFhNa1pW?=
 =?utf-8?B?OUpuVlB4Z2xpTU9vTzBNNTdtZ1EyWkVGenlzWFFzMGwwR1NScTBrVVR0LzBM?=
 =?utf-8?B?dklFSVZOSEZiVjNMZ05nTWcyR1FsTDcyTVo3dDAyb1daS2NkZVZYanRLS2hN?=
 =?utf-8?B?TlQvQlRvcFhZcWVQM2tGM1hldko3R2FRSFkxZzFiWE5QdmNibXZSUlhNYWVY?=
 =?utf-8?B?d0lCWGN6Wm9hajBNbmdDbXdwa1p6Vm10dXNsSDIwZmdJa0RBN1cwMGwxNCtY?=
 =?utf-8?B?UG9NZ0s4NE9XNE5NcGZXVXJkdFExSkluZWZDQktUS3p3OTRrUXV2YlRGYkdV?=
 =?utf-8?B?UHIzd1F6enNFcEZPZTdCYjZyaFBOQWx1RDlZL2lQOWdNMlU0bUlLL0lVaFdt?=
 =?utf-8?B?QjZhQzJyYitwbXlXNnpxMWJUZXJGYnk4Z09UcWR6QURwVWR1Z1NWaXRvM2Ex?=
 =?utf-8?B?NGpwckpBWExoRVlabkhuZFFVS2g1SkdLWU9iNFhSKzJBaCt1MjVPTFM2dU5k?=
 =?utf-8?B?SGk4L3BHVTVwY3VIaW44SGVYUXZaS2VCU3djWkhUKzRIcmR2T3dPSDFFVE1p?=
 =?utf-8?B?ZjRqakdRVnRUSGEvU3QvNkVkWVBRVmpvdC95b2o2ZlV5RDJab0prMkx0ME1G?=
 =?utf-8?B?Q3JaY1VzL2xoeUZHamRyN0lJTGphR1Y5OFFycytUaHIzZ1RGWUJNNHZCUGNy?=
 =?utf-8?B?d0tNd3A0c1dBWnU2Z2NiRWZQSzM5VTZwN0QzeEdIMVpreENMMEgrbkJkcGR0?=
 =?utf-8?B?SkRlQTRiN3NIQmgyVkozTTFsbC9ESjJGNC94azl0OEpHOFJwcS9PNXQrbjN4?=
 =?utf-8?B?a090NXQ2bEdPSGpTYnR3M0xvSG9rUHdTdU9tVWQ0bGpTaWI1RmdPUGpQcDhQ?=
 =?utf-8?Q?MdnrI+n1xhadArEtiG2+edhpX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc67183-558b-44b1-ae7e-08dc62fc5d82
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 18:45:22.0761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tu5gbS48T89YqMSszwzULfcrsJpKjBEU3GToXvCad2E93fGewGCcr7gbOAe7cPtpIkEcG9RWTKpMKeURj6uXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8853

Delete unused node in adma subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index 5d012c95222f5..f5dcdd9405928 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -3,6 +3,20 @@
  * Copyright 2019~2020, 2022 NXP
  */
 
+/delete-node/ &asrc1;
+/delete-node/ &asrc1_lpcg;
+/delete-node/ &adc1;
+/delete-node/ &adc1_lpcg;
+/delete-node/ &amix;
+/delete-node/ &amix_lpcg;
+/delete-node/ &edma1;
+/delete-node/ &esai0;
+/delete-node/ &esai0_lpcg;
+/delete-node/ &sai4;
+/delete-node/ &sai4_lpcg;
+/delete-node/ &sai5;
+/delete-node/ &sai5_lpcg;
+
 &audio_ipg_clk {
 	clock-frequency = <160000000>;
 };

-- 
2.34.1


