Return-Path: <linux-kernel+bounces-167203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 994E68BA58C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B81DFB22B00
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613F31C6BD;
	Fri,  3 May 2024 03:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cBYxGN9H"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B811B94F;
	Fri,  3 May 2024 03:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714705556; cv=fail; b=aSm96Y+tTwLXA6QQrTcmc7J/1TLCxicaaYT2TT0wc59KU83QTY7GFwuTxF7C5+xeeIcglHvpIPRIqiQMmrrdSwvErZVMmqEa0kuT6sJmEJiBfprItVDe5F7KVBjYUP6gZlSztIg2GRN9CYPzNneSpamj5PxZfVEW3eOkRuLevjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714705556; c=relaxed/simple;
	bh=Dw3U9TiTwaQW24akzQquY4S7nJc5ejd6hZVM3s0URcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fpCI6HpSyCCfZancK8FKJfcD6ngjzEvtYsiuohKaVrnmVTerJXyBbYG4ah6bUHUW3r0p6RCFOZzDEck/bs9IDlGXOOb6N36spXgTJpX/+aCHPpwOO4d8PC30mfsaxdqU1QMqOg0mjZkA7BxKqyZn0XazwH9yxL8J2WfRyX8XWoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cBYxGN9H; arc=fail smtp.client-ip=40.107.21.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXMH1IQZJaXqqrZmt6AbLXyVwjlFDp51xQGptQRnV4clxbIKVY/etogOGScupswanPd8XHw0y8OOey+e/aI1OdcKtYWAY9111QJ69GcHQBVA9FgEKvcBcgNcwaKOiquaTTCmBiGQjDsKVonYDoXECbJUAatf4AnapnsSjAYmBE6dY5GMIysHp4mPSYtHZWlVDlLJNEQfhWR7hp1kS63wGfwV0R7FTqOG7yml5hKPJ62tbtPEWwCFekyFKupcBm/C7DXs/EYkEcijXIFZWf3b+fmVSojper53xsCkpuDNjcZxisfSZEL5bJlTDATnqHBlgkat9/vJLCeuMjmUJmD6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uz/29feL1Xomi8816wkoD8rVAaGF96HD9S8usTHJ9ho=;
 b=T17q6zxSk4lmtLs6aqAC8/L2YKGF9zWdeXKWVaWLxhqfNh4qdtGlNmwTw/crGXBzSGb0yHtSNVmqO5N+N6fkbStpxDDmtlYiBfgyB7yAZbpgVwhZxSi1Ltt28gDpUgT3cG9mZ6kAK1eyBueHYR1RKCqn8AZPoAXJ8VdIbDo4tYw6w8ybUFPikou628ljhRNxmsjSbfoUaneBnST5auBACc1YLWjrEkei/N5Oo6trTdJHnneIjiLgbzNVRD0k9i3sA29qAUD0HcNPr+M3cdlgunJPwK9O/NYJiXanJv47w10cu14VAF66qAAg/E8G3dst6xIz9oXomVXqnPYsd+lR+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uz/29feL1Xomi8816wkoD8rVAaGF96HD9S8usTHJ9ho=;
 b=cBYxGN9HiJdzuo1+bAElMdAzpT36ehS7vK3+aoItB6jde9RxpyXW6mh+t5GKZRQXeyJx/127eimAwNg9T+ScxKrZqvImEbo+8Q9m0kf6E52OwhzBZeiIG3cXrNARCppB9K0vNYn1gNZWcWmrVX5qE177Ixxes8yF78y3iWHiCVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7152.eurprd04.prod.outlook.com (2603:10a6:800:12b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 03:05:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 03:05:50 +0000
Date: Thu, 2 May 2024 23:05:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Christian Gmeiner <cgmeiner@igalia.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8qm: Add GPU nodes
Message-ID: <ZjRUgze4iC5O0Iy9@lizhi-Precision-Tower-5810>
References: <20240502215747.2832126-1-christian.gmeiner@gmail.com>
 <CAOMZO5CY8PQN7b01N+oNO=92CVtPPfWzuzxphs49gh+4H+58Mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5CY8PQN7b01N+oNO=92CVtPPfWzuzxphs49gh+4H+58Mw@mail.gmail.com>
X-ClientProxiedBy: BY3PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:254::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b6f227-cc92-474e-90ca-08dc6b1def9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|52116005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1JORnRKWmFqN1B1R3BZN3VOQ0gwUDZuQ1BTbi9iSCt0WHJaQy9Ecld3TXBK?=
 =?utf-8?B?TEF1VFp5MWl1RlJOUnRjZXBVTTA4MlBWWnh0ZTNFbGJMeGJTRll6aGZZekpK?=
 =?utf-8?B?am1oZVZyWEMxTmI2V1VXdVl5VkE5Vko1WHRURFNONWFid1g4M014cnpoL2Fw?=
 =?utf-8?B?WWtBbDJyclVvVVlhMzZ1Mm1rWk9KZjEyRXpRUlBMY0VTaXpRbUh0QVV4amZV?=
 =?utf-8?B?djdsQjlodGg0cVlsOUxLZzhwWDErNittb1Y4aDRROE5iSmFnSVJPRWNVWnJW?=
 =?utf-8?B?RzA2UFpOWXZJbjVWU0I3UHFCRkQ1NStwNnVLTXc2d3lQY0JrbGJsNVdza1pY?=
 =?utf-8?B?dWErNVRTbys5T21sem55ZUJYOXE3WWlRbm45UnI5b2xPNnNvMytOVDVnRVl0?=
 =?utf-8?B?T0VSaDBMZVpEbFY0L2NEbDhEOGJjOXdMQUJIbTNPTlJWT2c5cmlrcmNDWm5v?=
 =?utf-8?B?WEROdHcvT1g3bGlMYWFVdUxzNFExSmJPRjNvRWJJbmJyb1N0ZHkrUmxzMlJC?=
 =?utf-8?B?c1AzeTkxYk5EaWl1Rmo5aDhkWUpXdXEwWFJxRzNyL0VzeXUzNmxPQlRHRFR1?=
 =?utf-8?B?U1Z6MFl5NUlUUkcyUUlvQ21kMGsvQmhPeTR0NjdVL3g5SlVIZFVUSm5rOWhx?=
 =?utf-8?B?OGg3bVUwT2Z0dUxYaXRvNkNJSUJhNlpmeDM5V2RqV1R2WjZtWTNBVXAxWFRK?=
 =?utf-8?B?WXI3azBJV1BEZmZiWHNzNHhWWktkZmEyZ2NnWU9LeWlVUVE1Wi95TGYwcCsw?=
 =?utf-8?B?QzIvSUoyV3BySzBpdkNFeFpBalFWMkVhNU0ySzRxU1gxZG0wd0hNSG9jTmZw?=
 =?utf-8?B?TEVNN3JsTEtLUEc3OFJLVUpsQU5qOHZLWDRxb2RTWjI3ODVxZlZZS2kvWXNV?=
 =?utf-8?B?WWlhY0Rlb09uN3VIUEJsYUpyQzhLb09PZHlJRHNvbi8vdGo2eTQvSkI2TW1R?=
 =?utf-8?B?LzU5MStRaEhwbllJU3doTHdRR3hjOVMrSTI4eEpXV3BjY3lPTGF1YlliclY3?=
 =?utf-8?B?ZjdLOG5ibkRXcjgvWHpTZElCVFlPNXAvcWdkeHBKQks4cWwzdS81VU1CL1F1?=
 =?utf-8?B?RGRVSHNTakh0dG1lanM5aHIyaXF2dHU2OURST1VmREJLN1Q2YmxsaWUvQ3Uv?=
 =?utf-8?B?elRtdDUzQjVkVUdYZC9sSjByMjRRUUlyTDBFTHlaM2l0VklDb2pzOE1KUXRT?=
 =?utf-8?B?NUtmdUg5K1V1NUNXRHphc1l6WWI4MnNBakdwdmsra1lYTTdaVzF4WnJjYjc4?=
 =?utf-8?B?Zmh3Vldkblo2NURxdUdkcTYwbGk5NnRiSytTb2RuWWpkamh3ekNNOUo5dkpX?=
 =?utf-8?B?VERiUHpsT1ZiY1dhdDh2aTZrYlJMMnVmNGtHSTdlRlJWM3VneFlKWkdtNWs2?=
 =?utf-8?B?cGl1b3g3N0YyWWZGYXRkS2ZlRjFFWEZUZEY0a1BRT25lRnoyZm9GYlFZQjVE?=
 =?utf-8?B?aGkrL1Y2cC93Q1c3SDdvVXh2aDdQVmc0T2ZyUmhYa1hRSGlKUEVQazJwRVh3?=
 =?utf-8?B?em1FRjB4Vnl2OVNEYU9uZ0pud21HUWRSZTFxdEJzWXhPbEFqeG16S2ZtMzU3?=
 =?utf-8?B?ZTR6c0dyZ3pBMlg0WjhFeFBvMmdTVEdoUVMyZk1OYWNBK2RJOG9KemxVbVBv?=
 =?utf-8?B?L1BoT2VaNGZrRzFlVjJ4RExpK1dpQjRDUTdURkZKTVVYRDJVL0RES1o2T0V4?=
 =?utf-8?B?dE5zSTlXWDdVdHp4UGdGZ1JiWTlWZkg3SDJJTzBTUHRLa2VxNDJnc2o5aVI1?=
 =?utf-8?B?T0JDMkIzYkpXdGswZmlYdHhWckxNNnVWcEFQVFpKa1FxcjY4MTJPNUZzeFlP?=
 =?utf-8?B?WXRvWWx6aytUNW5HbzZNdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjVVMU1mQjFDd29PdkNPendkYzRzZVNmVms4QmY4WVRvTTUwdTJtMUtLYW5M?=
 =?utf-8?B?NndxS2hyd1hLUEVJSGlmL2dZTGFkeEdQVHpKVGEvMDk0ajFwUG1yS3lxbGUy?=
 =?utf-8?B?cDhRZVN6Vkc2UWFvcmkvUFpRbENMeGthSVlGanBFelJ6bjQ4ZEdKWmsyQ0k0?=
 =?utf-8?B?M2FFQ1NYaVY5K0pJVnVwSEtqQm1LeVg0UnA1VlV5RmxqR0tLdU8wMytRZ3FC?=
 =?utf-8?B?UHJZM2p4ZGtpWjRxeFduVlFBd3BWbDdPMGZUdDNoZEZXMWs0QmRiS0dKZE9C?=
 =?utf-8?B?UjJ1ek9RMkpmcmFJakFsblpWUG1iT1dKYUNzalFxS2ZhbDlrSUNiTlV2aVBV?=
 =?utf-8?B?aUM4eEtrbGpTUWtuemZrazMyeVhBOXByUHBka1dJelFLTENpbC9rY2RveGNN?=
 =?utf-8?B?eTFXblZjU3BNZnA1N1NjZ05xWXN4WXB0ZnlVT0IzOHR0d0tWNUFrNS9EWGVB?=
 =?utf-8?B?ZHVQNktLeWNITytCWVFrdnJqNVNTcHVLckhJTk1pZUMrTVUvYjhvdkZJY1lV?=
 =?utf-8?B?YzZWcFlFK0hVMktldVRXRlpsZ2Z1b1B6WW5tWEtSZjlGTjdPZVpaMUY1NnR1?=
 =?utf-8?B?OTNaYi9qNlFHcXR5RUZncWkyWXNKc3NCWnF3UXdDY2trTjg0b0FJRW85ay9H?=
 =?utf-8?B?RVR3VnpZTnNzTzFsUXhEcTBPSTJDdUlUZEJobTJOajBEREd2RysyTk8xZFVp?=
 =?utf-8?B?ZlhDV0FlNlM5c1duMmJrMUIzUHBRTldIeS93V1o4dlB5Wnlicnlzc01SNlNH?=
 =?utf-8?B?M2ZhYkVpTUU4M2IwZW9pZGxONEozTWxaN1VUN0hzZFJJZTNlUmhWZ1BtbGZk?=
 =?utf-8?B?ZTExWCt3YnUyOXBXYk9WMGFLTzVGclk3WUNwN0haRzRTd3NudWEvTVh0ZDZh?=
 =?utf-8?B?eHloekVoSUsxZUx3M1NsMHNPZkZKQ0pEZGhER2liY2gxY0ppNm54UGdHYlcz?=
 =?utf-8?B?M3JJVkN6OFpMZVNRa3F4aTZ6d24yNlhjamNOdndjallkTkhvRXJDMHJDTkxm?=
 =?utf-8?B?SGZWdWxBcVkvYzdZb3Q3Y0JaMHZIUWFFWUU4YU0xVGxCbVBNYTlsam5LNEFj?=
 =?utf-8?B?V052V0FYTDJIY0tad2luZ3NiQkF1YUlQak5WWW5TRUthTC9OSnR6U1ZGZWhU?=
 =?utf-8?B?dFhyZ1BuWmRtVjh6b1o5SXNtWWFEZDFqRVFVVkhVbWx6cmdIVG9GcnN5M2c0?=
 =?utf-8?B?eTJhYUozSEdUMjBFMEZBVklCTzJNTjJMbHJOeHlYSVU5akdPdXEya1kzVEkr?=
 =?utf-8?B?bVVNSnhVM01WcDhZdUZtcGtvVVF0TGw0T0J0aHM3d3ljNU1Kd2hJeWdQenQ0?=
 =?utf-8?B?UWFBdjNBYkcyRTJsZVN3dDgvQkNaM05UR0o1ejVtNXk4SE5Ga2R3M1o3WGs0?=
 =?utf-8?B?UDNzSjl4cXFsSmpORnpjVnhDQ0x0MU1KT2JpUzlMc3pLbytoTkJqeDVXSWtG?=
 =?utf-8?B?UjBNYzl6bHFXdmN0Q081R0c2Y3BuQm9rYUJBYVA1cHRMelNTeUNKREVsYW1y?=
 =?utf-8?B?bGNOMy9NdGszV3ZJNnhXTWo1QXNTQ1R1QUt6K1hZOXFoNU5HdWNERGkrclVo?=
 =?utf-8?B?VDdYL3VRdXRvaUZNYXcyak1aK25ERnk2cHhrQjB4SlZnZzJOSUh6UzErdjBa?=
 =?utf-8?B?MkpNc1VJUEREajhOdyt3Z2JVUnZZU2pCWUdYZDkrYmlzQUhFZVh3QTRNVTNv?=
 =?utf-8?B?V3VvZ0tYMThUVUgzRTR1ODNOYm0xb1Y1VnhEbFR6dFlzTGk4eHpXdTBWeXNz?=
 =?utf-8?B?cmdPUWRqTW1sVUZxY241dzZtQ3lKR2hvVlIvNTdVckpBSmxaQzc1cWtHczlp?=
 =?utf-8?B?eG1QODVJN2JzTE9vcjBMbTlvZUFqNG9YcnFyeVl6UXNSaUNFMXg4R2tubzBZ?=
 =?utf-8?B?TGVHdjVmQkprL1pyOG1LOVRWdnVIMG82UzVTSllla0dGOU5BdThITmQrSkFi?=
 =?utf-8?B?cTltMXlFOXY3dTh2U3RHeWMyTFZWQThaV1Bydm1KVDRzM2RpSXdNenArd0xm?=
 =?utf-8?B?cUlkMlNVZmtRaXp1TndzSFM5ekVBSHU1aFEvcnFZTXU5VithUEIreHJ3R0Uy?=
 =?utf-8?B?ZG5hSmt0M3dFaUQvMlhkczJVcmExSnRGNDNEUm13MDZxMitRY2h4eUJrNlgw?=
 =?utf-8?Q?hL3woe2edtQCoYlUZaxiBRMPk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b6f227-cc92-474e-90ca-08dc6b1def9f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 03:05:49.9691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yG8ZZtxAviabZeauBkmrw/BPU3yZ5qUYnDqozJFdwdEr8VgFXAa3pKE1upNGSAJXr3l6LZzvxSh6Wlj7ejYTQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7152

On Thu, May 02, 2024 at 08:01:37PM -0300, Fabio Estevam wrote:
> Hi Christian,
> 
> On Thu, May 2, 2024 at 6:58 PM Christian Gmeiner
> <christian.gmeiner@gmail.com> wrote:
> >
> > From: Christian Gmeiner <cgmeiner@igalia.com>
> >
> > Add the DT node for the GPU core found on the i.MX8QM.
> >
> > etnaviv-gpu 53100000.gpu: model: GC7000, revision: 6009
> > [drm] Initialized etnaviv 1.4.0 20151214 for etnaviv on minor 0
> >
> > Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8qm.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> > index b3d01677b70c..54879ae1d7d5 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> > @@ -467,6 +467,7 @@ drc_crit0: trip1 {
> >         #include "imx8-ss-dma.dtsi"
> >         #include "imx8-ss-conn.dtsi"
> >         #include "imx8-ss-lsio.dtsi"
> > +       #include "imx8-ss-gpu0.dtsi"
> 
> Nit: better put it in alphabetical order.

No, it should be order by subsystem register address. gpu is 53100000.
should be between imx8-ss-vpu and imx8-ss-img. 

Frank

> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

