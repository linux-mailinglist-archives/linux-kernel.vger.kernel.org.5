Return-Path: <linux-kernel+bounces-155350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234C88AE939
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE79D284418
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E8D136E1A;
	Tue, 23 Apr 2024 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mq6/IY7z"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E4913B590;
	Tue, 23 Apr 2024 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881492; cv=fail; b=GrkxrVyHTaIWZdfjEDOmQ8Z8ZLTWFqtbXAkQKOrBiRYyd489tiwnVcwPKKvEj02pUuPs1S9eP3cO6RJ7Gg8NQ70Ox+z8U7LUdkjdTf64lfS6Z24qHgZ1NvhyFBaFQEf1GC4dbXn1HLZMRsscfCxASuVsx7HT1psNRZVS7tzkF5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881492; c=relaxed/simple;
	bh=p8vdcvIu/jGl9YElNP5C9gcehzRlZvEtdSYDpJQ4uhw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iwdrIKqMmN6Btpm1aF2PEtbMqYv3WCwtjLE8dNW/AD17LWXKbhywfiV7rVeoOyaUO2RspfX4tHHG2onVfMsvrFMp/9I5BUtdeJwBM31dUpnnqlUzoLr+4srvhQdvMhIoRb/nT4JPgoaSDo6FT2ibQr2CpZaMDYC0Sbvy1Rt93Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mq6/IY7z; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5CJawN1dHHRXiOyk1CBScbqzsKyEarzqZCKVQ/H6xBkk9OOdm9anNDpMTrmQaCcAgAjWCIN66P8LE3GTl0QqzuaXQVf4iBex2UG4hRgm5HJYbCF6faH9sk8AcDIaFb2cDeTM+mDAbkK9h1UJGYfYcyFg9RuhpUR6SG6EIhCG8Ee5uBlR+iDNtCQ4pJTmxyG1cBY+vy0zGoSAJQZq8/EDWCl0xmRAxO4cH/dY3pfZclzZux1ybGCgIfElb6rw7B46mhLcQ8ldrrL52NQwCmpXvyZR6Ir+NYdkNHYAwmRm6yfZD+gETaeieD1wtRvQa/01tKOloEj2/fuS/YxlOO3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85hNXh4LDMGO9JJQxkOWEdPyQphnyUFJYav2LP26zIY=;
 b=AdpkpCiFXv8m/TouoFXOLCzIQjSr5tI4XlB5tia/9yny6Y+EoW2aXHbiISVTsZDVbGxDPxtC6TMNDPB1N+fz2CDy63jgoqvvODmJT69m573Jjm19iM+XG15AGbsZmkLNMD5Jn8pRAgJoWAtrIwYb2Ob8Y3kd6xMfty/x68HtoLz5jN0x3IeN7vcp3iOyTwEajgUVQUKIxZ24Sb4sfo3zzp+U/HkEXsnJkfU79ReiRG8sA8RC3oBP9K9TFZyLZVx04dHp3gslvWzGgnMxoHVmsKlXaQYHjNqFpB/LuYUN+nhmycMUnkN65L7zAAzniz6bEnndUPPjFGVcJBDCeartLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85hNXh4LDMGO9JJQxkOWEdPyQphnyUFJYav2LP26zIY=;
 b=Mq6/IY7zWQAEq4ycBBT1hyG57wdoPOwE1lVRwMPBiG3wfUsMOqHoTKws1r7aqkOSIZSPEPJSypvIFn1ZPkeoEUCpI0kW3oI2fwa5l9/9AMFmGnQvESHfVGji/ANDr+LTNtB2cnLoSNGBRtKGGiaMOhWDtvNIfrM9z9v65POQrvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9018.eurprd04.prod.outlook.com (2603:10a6:10:2d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 14:11:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 14:11:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 23 Apr 2024 10:11:14 -0400
Subject: [PATCH v4 2/3] arm64: dts: imx8dxl-ss-adma: update audio node
 power domains and IRQ number
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240423-b4-dts_dxl_audio-v4-2-0c57eb7399a7@nxp.com>
References: <20240423-b4-dts_dxl_audio-v4-0-0c57eb7399a7@nxp.com>
In-Reply-To: <20240423-b4-dts_dxl_audio-v4-0-0c57eb7399a7@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713881481; l=2570;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=p8vdcvIu/jGl9YElNP5C9gcehzRlZvEtdSYDpJQ4uhw=;
 b=HqbMZ/OnCpnNnjIbNk2mBiYEzyL3Y/yBw43Lr+SKf7yam6VIe2f3eEI2p1rtlnf1fQfEalFeL
 O+BwKJj4V9xAvpuzLZ21z5LjpxlP7bor6MxtPAb2TDlGDi5nVCR0qqp
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: cdaacdb2-bfa6-4400-e2b6-08dc639f43ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|7416005|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFE2bktjdUFDUE5jZ0gzSC8yczhjY0tKeFl4bWJxL0p6V1pMdGp2RlptQlJK?=
 =?utf-8?B?SFUzRmo3alFBaCtndWRMdHFBV3Bjb0RmSHRHWldHa1BFTTRwOXRhWXJnTjV1?=
 =?utf-8?B?elIxT0FiOWlWa0pSYW5CVGE0aXhtNmQvQXBGS2FsZ1I1TitGSFk4YlhySzlx?=
 =?utf-8?B?L05CbmYwR2tib3RWUTJ6bldBTmNMQmdZR1ZYSXVZS2V5NDMrZmZsTUZMVlRq?=
 =?utf-8?B?dzIwRDZmK1ZZb05DUFNrQUNkVCtWV2hZSktoc05TQzBubnQzYnNacnlQUWx6?=
 =?utf-8?B?UkI0RXRLcjIxZEZpTWwwZDc2WUplM2xBN0JQV2VSSmphMDBldmVvMGxqYVFw?=
 =?utf-8?B?WElhNHB4NVdQeGIxU1hNb3dNRjVuVlZseExkRTZKRnpwd3Ftb1dOd2c3NDF6?=
 =?utf-8?B?VTJmV01GdFBXY0RkRG1idVVyc1o0UmZjb0UyNFdXU05vTlpBUER6V1RnbVVS?=
 =?utf-8?B?QklpNVIxMWVYaU04MnZ5SUlsY3BIWGNyQXhvb2ZZdkRqS01KWlRpWnBzdEI3?=
 =?utf-8?B?TUVHamx4NVZiSXorNE9xN3pQaDZ5OFVEWGJxSlc1dS81RXRrU0pBTW9vNTFP?=
 =?utf-8?B?SUlDYjYrbWhNRWNGcFM2SHB1QUFmc2xRUU9RQVhmMjhZR01yQzl0MzZ1YjFQ?=
 =?utf-8?B?QVBURDVqTDYvRlJwVzNoWkhYajRzK1c2ajVNVU5WVHc5SFk5emdvTGcyUXFB?=
 =?utf-8?B?am9ibGUra3BBdHFHR2N0SkFoUjA1OWt6bzBTa3BIdVBsNmtuM1FFMDhSWmlu?=
 =?utf-8?B?QlBlczI2M3NpYW0wVGU0VmFJOXpJWHd0c0RrbzFyN0krWFJ0emFvcWFXZHR5?=
 =?utf-8?B?WXdmTDE0QnpuZ3ZpQk1OZ0wrNzJFejNjUzAyV2Y5VjVtNW1xNGhjSTRrK3g5?=
 =?utf-8?B?NXJ2S1RjdXlPSVEyNXNLN3pGd0hnc2xPQjJLWFFQYjFpc3dLMTJjZmt5NUNZ?=
 =?utf-8?B?OVRUTlNWY2xDU2VDWXkwUDk5K3hlTkNLZDVoOGJzUFBIb3hWWUw4UDRyQkhZ?=
 =?utf-8?B?NUl6cjRRcGZNZC9HdTg5NTNtTGRpWGZRUjJkU3FJVzdRc3BTelJQSjJzbGwy?=
 =?utf-8?B?NG1pNU44WGZPZzYvM1ZqUWpGUVE0eVFabnBINnVqZ3NqcllIMUt6WWJGWVUy?=
 =?utf-8?B?NzByU3BRTURIR2REOXJlaVliVkZ3S253dGlRelF0MVhPOTFzQnN1TllGTWll?=
 =?utf-8?B?S1ZxbXJFRGZIOWc5eXFsampuM0J1OVU0NWR0dzdRVUl6R0dJejVlSGJ2b3Fp?=
 =?utf-8?B?aXl2akxVdG5DTDd2K2oxdWdQUFB3NU5TUkpOMFpmZTQ1K2JjbVJqcm83UURW?=
 =?utf-8?B?S3p5RmdnVGNGczdXcWsyWUhEQW12UHZaZ1RaR2lhNW9oa1hwSUp2Yjk3R21R?=
 =?utf-8?B?VndOb2dTZFppVjkrTzNTQmFVUFZuWG9JSDRLckNmeXdOZTkwSG5Hc2ZzNGdH?=
 =?utf-8?B?dU1IRWZ2NkVjZUdMcmJlVXQwM3U5QXdGTmJISUJIdVlUMWFTRlFBUFB4L2VO?=
 =?utf-8?B?UU45dFFNdnlXRENGMkVTbWVMb0dmNW5XSzhlRmpDem4zcjh2UXBrWWQ1THZX?=
 =?utf-8?B?WW1lbjA0bzFna2liZG55dkpIY1dwZkp3MGQ2a0tJNXVuOWVjaVJFOC9xaUgz?=
 =?utf-8?B?NnBIUnlQTUZaSTQyTkY1b1NnQVg2UXI0VFBnSExKZk90Y1NqQU1GTlIwRy9N?=
 =?utf-8?B?cVZpWlRpTWFMcWtuclFnbnEwS1BzS3BDQ1MyZnd4UDJBWXpEVjNhQUx4RTM4?=
 =?utf-8?B?Nzkvbm55amN2cXZWb28vTjFTNjRnRm9hdTl5RTZCUDhrUGl4bkhwVjZzQ0R4?=
 =?utf-8?B?OUtRektYMWlqZ0lucXUrQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Lzc3T0E4bTg2T3FBZDgwTnVNZVYzbTRjVC8wcHlOM1o0TGV0YXNQem9rMHNW?=
 =?utf-8?B?blM2Tk81cjM3enU2cFdyQTFrcnlNdm5NRVpqMkNLZXFuK1RZL2czcENVSEVW?=
 =?utf-8?B?MVI4UHY3NHpXK3JIT2FVQlZiREFnekQ1Wi9DVk1HcDJFanJKL0FxTlFESng1?=
 =?utf-8?B?aXNkVDF4cE9HL0RCZ21MdVFJU0h0bkM0T2tTbk0vWFdUMUtLSmlmTXBoS2RO?=
 =?utf-8?B?WFppOHZUTHowaUpxTWtZcW9VRVZ2cVBOcXQ5UnhkbWNYeWRHcGlvUDNZWHdx?=
 =?utf-8?B?NVdReFVnRk9RR0xsekk1N1ZMUlVJUUp0N00yT3UvSTNIa0tsTnZ2dHVQWlVF?=
 =?utf-8?B?dUxVazg1dllEcndKZ094cWFrZVMwME5ZVUxVSmIrVnZJM2lSend3RTgzNGZv?=
 =?utf-8?B?L3dITm9TSjN4L01ZWTIxc1pKaGFvODVBa3REV1BFSHdNVjkzakNIdmhSaDRv?=
 =?utf-8?B?bGF6NS9qYUxOVVJPaFpwQnVKL3hGZzZuZWJrT1FVTUU0SlZTOHM2OW9tSjFw?=
 =?utf-8?B?MXB5YjVoZ2M3QUZFdEtVVFlWblM4b2lKYzNNeldId1VMNGVmdlZyemlKOFA2?=
 =?utf-8?B?TGlvQU1vNHRaZFlKVGhmMmFvYmg2b0ZyUVpNM1d0d2lFVktzWURlWmFXbzFp?=
 =?utf-8?B?c1pVQjMzeEZOc3VzQ0lnQm1GMzJSN2NpQkxFSlliODJSK2ZkdW1TdS94Mmov?=
 =?utf-8?B?LytKaWZtd1BSN1d4K1IwMlkrck5meFpFQzJTelM0MzZ3T25vU0NudFJNQUto?=
 =?utf-8?B?ekxoaTdReWJiZUFobkFkNVFUVDVHNVQvc3V1VVNCMlgzY0doMHFWV3EvNjVp?=
 =?utf-8?B?Yy91bEZNQ0k3dUFPV1ZWSFFNYStRSG9rS3cwak16czJ3OEdCODZtY0VQL3NU?=
 =?utf-8?B?V0NwSWRUdWJRbDVhMktzRkFJKzRxRXQ3Uk45NU5mL2ZXQ3E4VWdzekJQdEN2?=
 =?utf-8?B?SUl4SmRWTjJkVXJvV0wvT2lmWVRoVnhPSXcyWnBYNWRFWXk3NFI5NXdVZUla?=
 =?utf-8?B?eWRGOXFSMjg3WExLbDNyRWJaa09Vc0o2MU1NWEtRamNYZ3JyR0JFenR1YVp3?=
 =?utf-8?B?YlE1REtISEoxM21icVRQQlV0N1FYRTNOUUs2NU1VSmJZT1VPR2gxVUVEUllU?=
 =?utf-8?B?Wk44RlAyWDdJaWtpS1ZHMlVoWVZEeG10ZnlWdWFXbHkrcHdXdFBsSTVJa3h5?=
 =?utf-8?B?M0UyUys4ODdmL3dVS1pWYVg0a3Q2UFcvaFRhekc5bGo0VWE1UlVjR1lUcDE2?=
 =?utf-8?B?N0d2VlA2RGhmL1hQSVllaFpLTEx5MktBRWR5RTdmdWtIaGRxR01BUTFwN0RV?=
 =?utf-8?B?S3Q3SWE3dGxENDh5eWM3ZzFRckd3SUYza2NQaEtEMUdjOEw4RWhBcDV0WmRO?=
 =?utf-8?B?VlNYSHNzcks0cWw2NGU5WTVRR3g2eHB3WFdaNzdRUXAzekdRYUtETDlFcGM5?=
 =?utf-8?B?ZWc3bEZnSXZIWm80cWRnVlV4Z2pVc1k3U3YvcE5Famd3R05pOEpPTmdwUmJX?=
 =?utf-8?B?R2xCTVhvRno2cVpPSmdhU1BvY2h6TElTMGovK1ZCdFBZNlBVdVBRYVBaS0Yw?=
 =?utf-8?B?MXY3R0tPQ1NaMEwwQUZjVTkxVmJvZFdFYVRUdzQ4T1EvL3gvb1pyQ3JTVUVq?=
 =?utf-8?B?a0dFTElwZkJIaGZIYnFJYkVvUkMrTWhJN1paUVVrTWp6SVBTQWxHNFRRTGdp?=
 =?utf-8?B?UnVjZFJaQUUwTzBUNDlDdkFWRGJLUGtpK0tzMmVGekZmdGdKUTF5bW1rVlNT?=
 =?utf-8?B?WnR2bmMrV0ZocTRIbGhRK3JEbDB2eXlTRis0c3dtdWNPRHNia2I1ZDc2YVp6?=
 =?utf-8?B?RGQzd3AzQi8rSThlNlIvcFFrN2FlVGFSK2hESWw3ME56d05TRzNGZDdkb09U?=
 =?utf-8?B?aUtpWFRoamUyTWdUeC82WFFGN0prRzlsQkZCeGRwN1RBZ2FGUFpuL2xzZVEy?=
 =?utf-8?B?N01OU3JtZUxRYWwvY2x4NTdITy94RWVMc25SVWRqdUFlYmJudFpuWGdGNERn?=
 =?utf-8?B?UlpGZVVEZEJpR05rVWswckVvM1dmRmRYOU1tM3BpaGorVWxiQjdWdTMxb283?=
 =?utf-8?B?VkNCQ2tZSDBIekhTbG1DQkd3NWs3NEpwczRXUGwxcFA2T1dIdCtzdWpJNkFQ?=
 =?utf-8?Q?MQhKUVPKSLaa6i7t0Nr1U9uBM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdaacdb2-bfa6-4400-e2b6-08dc639f43ff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 14:11:27.2647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vJLeutfSV2QBmDx68semhOV3wI4O6cieEykOBki7rdFE6nVKBWrDQiOJhD/XAl0Gg6bUF0x/0xcEyrlLiBs0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9018

The power domains of i.MX8DXL's acm is difference i.MX8QXP. IRQ number of
sai[0..3] and spdif0 are also difference.

Update power domains information for i.MX8DXL.

Update sai[0..3] and spdif0's IRQ number for i.MX8DXL.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index f5dcdd9405928..72434529f78e6 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -17,6 +17,49 @@
 /delete-node/ &sai5;
 /delete-node/ &sai5_lpcg;
 
+&acm {
+	compatible = "fsl,imx8dxl-acm";
+	power-domains = <&pd IMX_SC_R_AUDIO_CLK_0>,
+			<&pd IMX_SC_R_AUDIO_CLK_1>,
+			<&pd IMX_SC_R_MCLK_OUT_0>,
+			<&pd IMX_SC_R_MCLK_OUT_1>,
+			<&pd IMX_SC_R_AUDIO_PLL_0>,
+			<&pd IMX_SC_R_AUDIO_PLL_1>,
+			<&pd IMX_SC_R_ASRC_0>,
+			<&pd IMX_SC_R_SAI_0>,
+			<&pd IMX_SC_R_SAI_1>,
+			<&pd IMX_SC_R_SAI_2>,
+			<&pd IMX_SC_R_SAI_3>,
+			<&pd IMX_SC_R_SPDIF_0>,
+			<&pd IMX_SC_R_MQS_0>;
+	clocks = <&aud_rec0_lpcg IMX_LPCG_CLK_0>,
+		 <&aud_rec1_lpcg IMX_LPCG_CLK_0>,
+		 <&aud_pll_div0_lpcg IMX_LPCG_CLK_0>,
+		 <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>,
+		 <&clk_ext_aud_mclk0>,
+		 <&clk_ext_aud_mclk1>,
+		 <&clk_spdif0_rx>,
+		 <&clk_sai0_rx_bclk>,
+		 <&clk_sai0_tx_bclk>,
+		 <&clk_sai1_rx_bclk>,
+		 <&clk_sai1_tx_bclk>,
+		 <&clk_sai2_rx_bclk>,
+		 <&clk_sai3_rx_bclk>;
+	clock-names = "aud_rec_clk0_lpcg_clk",
+		      "aud_rec_clk1_lpcg_clk",
+		      "aud_pll_div_clk0_lpcg_clk",
+		      "aud_pll_div_clk1_lpcg_clk",
+		      "ext_aud_mclk0",
+		      "ext_aud_mclk1",
+		      "spdif0_rx",
+		      "sai0_rx_bclk",
+		      "sai0_tx_bclk",
+		      "sai1_rx_bclk",
+		      "sai1_tx_bclk",
+		      "sai2_rx_bclk",
+		      "sai3_rx_bclk";
+};
+
 &audio_ipg_clk {
 	clock-frequency = <160000000>;
 };
@@ -191,3 +234,24 @@ &lpspi2 {
 &lpspi3 {
 	interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 };
+
+&sai0 {
+	interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&sai1 {
+	interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&sai2 {
+	interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&sai3 {
+	interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&spdif0 {
+	interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>, /* rx */
+		     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>; /* tx */
+};

-- 
2.34.1


