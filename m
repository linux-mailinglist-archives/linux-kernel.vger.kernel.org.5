Return-Path: <linux-kernel+bounces-137487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1303889E2CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F52B2276F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C50156F58;
	Tue,  9 Apr 2024 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bi4FTvxb"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2122.outbound.protection.outlook.com [40.107.22.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B929D146D48;
	Tue,  9 Apr 2024 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689157; cv=fail; b=h9xomIzFL87IC1DZj4wSB3lqFgsgAZMkHO0AEdKSESaObJkVlvXFEg/C2O0K/DSPmUlEztOKAMoNzSKsZ4/UXvx+F9Q1u7lpNhYFnOhMOJUaZ7R9Vqzuz9BMYfGnBE5KyA3eVD5QrrtkS2q4tCFrBHgwfTtFnwKJ3Zq+vSQ8gjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689157; c=relaxed/simple;
	bh=1i0F0SBHenpqm8t5WrECwJ5xaHQp1XBduhVLnj8wtpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U4M1qSvy7PpbTFR6yfgWFU/+Akx/dV9oxMuYYsh3wLV1w9Q/orv3uWsH4yqekGAYmbdQzydq/87mMTs5xzS4cgAhYCBVsem5Dut3uHrVW9tmXh9J856Yb8anLqG4945sQ1co2YX1gIvTy+zPbT8/63gyBnrtGIYiXpFczsETzT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bi4FTvxb; arc=fail smtp.client-ip=40.107.22.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGB6Mspzi2I3wfvS5jh/Sw73ckPLp1yUc9VoPb80CvdNIdZP3NUUnQsT9Po7wFNTu5zTAdREqCd9gMLqf8upad22wj+YZal+CnwSZfnrELGv6is7C15YLYSn8jgbJBTAICRbFqskDo4JviTxU6gtQpkaN5vICNpboRsemJeFR6Dj0JGOtz3F3xyftTKhioWI76+5idv1ezIg+ap1ohThNgAVCZ33MjTia1Jm9c8JJFKdZy5cGcmIlACoipcs2UqpVWzCSzn8dCfATe/eKy37mo0oMY3w/GDijBOrIFFaW2QPpeM2ifWBIJmpGRrSc1n0MYsTNpJc1LgxsBSrYmdG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhcAid7+3Y7R7+BgTZ3zUHmIPaT5mPU2BTd1U0Vtox0=;
 b=kLjyRfpHJpFSj+pLVXzATdpdbbngStFb8+kEYHwWle34dlqHXMVF2kVf5xH5l9wbEXhTzP/JnPIxK1+YUEL5R0vhvrHuaXd++YRyzHgrkDgumeGcFLXocnL090JpzshnAoWqbyzFjLnGGv/IwJIEDAayZHJErbokfCDNWSGl7jz7vpRFcx8/vxf45U19SqDTJtPl8+eLvogentNOShg4Jz6ww1pnaRQ5Db7ATGZz8IRzVCQ/SISjoPhy32V4muA0o3yMy8E98uVqbLLdsmfY9i0LrLP7WZDQn2oDp2J8CmXOLTZqfp7FWt9K1uTDltqMW4cG9zzKF04oSz0GKvX4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhcAid7+3Y7R7+BgTZ3zUHmIPaT5mPU2BTd1U0Vtox0=;
 b=bi4FTvxb9ORzKgGo73qM2KxiUQ1RxCtdIbYAG3leaQcFJr4TzdqBWUwt2tp2dfMXZNlF+iadC4Us/LUVuBZoLW3EHGmkMilKxyMw3aXKLddnaUcooU4spXmtPLJoP9rbfuwXAvOdNFKDIXPkhYM3EO9mbySYlMn1hKF69XHC0oM=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7673.eurprd04.prod.outlook.com (2603:10a6:10:202::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Tue, 9 Apr
 2024 18:59:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 18:59:13 +0000
Date: Tue, 9 Apr 2024 14:59:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] ASoC: dt-bindings: fsl-esai: Convert fsl,esai.txt
 to yaml
Message-ID: <ZhWP+Cxy9yMAYXJC@lizhi-Precision-Tower-5810>
References: <20240322145406.2613256-1-Frank.Li@nxp.com>
 <CAL_JsqLJDhJd_uoL05Z=s3Mc7PRkcJWsQGGjdG0Q0GFp0zA8xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLJDhJd_uoL05Z=s3Mc7PRkcJWsQGGjdG0Q0GFp0zA8xw@mail.gmail.com>
X-ClientProxiedBy: BY3PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7673:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XOnI6uAdhYxAl7QGGUR8aVJwHuqnFmPE4NyQ6sOEB2vFPLncvZhEUD1v8DRZJccyl3GcXfAQAqfIxch7cEIIOvtP1trk93aM5KfYYZjxbHUYJYc8pKMV9xNNX1t5fKXDvNNiNVsN0xkXnZF2p2G1seS1RxXAqVyMRVjZD//nzgP7ktUrWZTfPEaKSKsXhY9BM/oKfsqEEojSO0lsJYUh3+tpEIkHVNq1Xcc2VDnER4GVHyJ0YB8mX5tRyWSeAvPr2OagIBwRgisFZpZ6LLZXvnbDBCgpUrHzi+WBVHDVseJrpQate1hhRGiXm3uALlxlxOQ5TplOdPl4txfiUbLUFAknrAKf0AbVGnU3UkeSt551Fo4ol3kxYJrZJdM9oIV7H68d4KFy1nMhYxAApgBHvjkJa1MVgo549x1DEQydwIOCorY+3GSwOKP7s1ICKHuwLP1QrKh7OAW85jewJ6OhXM4J9gbGwyXEiXqwz1J14tOtviS5zCGIduqmQgT12o9AUpicU9fuzzWqzw8nrpBicQ/ZDvQt1BLX+XGLb4Sn1B0aEc/6scuL+3XX28U9f/FT9Z1aJmPk27CY2HkSW2WCY0+dD6ddprEPeNCSlbLnw3U17tqKMDiC/UjRtzMSBsxFaBUe4lmp01oxf29snQSHhR9EqUMMDAshQYQQhA+QJfvy/TmB07bMau/047VJ5/wRJ4/a6tUT7t0Ck8yil/xb5w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0VET3NSYlFPcVI1L2Ntb3phUTZIZ2xpVkZOR3EwdnQyK0EvSDFlbnUySWhM?=
 =?utf-8?B?TnVDM0xzS1hYbEpqNU94SFByUTduYjhJajFkWE1CcWpyUkFXdnBIYVdZcHBj?=
 =?utf-8?B?UjdVbFJvMWhYUXpqZ08yKzdoYzB2bVF1NTR6a09JRm00Y1g0OUJRQkFQVEJh?=
 =?utf-8?B?YzBhT25NZVA5RWxYRnBLT1ZBU0lUWU04U0p0VFJVZmx2T1J2akdISEtXQ0p3?=
 =?utf-8?B?SWp6NzFnaUZKNWxUelgwVkpqTnN0NEJmdEljNmpWVHZhSVY5cEJkakZZN1Fu?=
 =?utf-8?B?SWhRUmk5Mkc3WDRXd3dES1EraW5oSVhyb3cyMTNMb1FxU0JBY09tUy9pWjg3?=
 =?utf-8?B?bzFnS2pROUFJaGdGaFlqY2JVMHVnS0t1cng3dUgxZ1VvOXhZOWdMdXNCczZ3?=
 =?utf-8?B?VVlpRVVtUitEZk8zSFhDL01rVDVWR2sybGZUVXJLRGErK1N6bHd2a3RPUng4?=
 =?utf-8?B?VE4vd1BNRVhwNytSZnppeFlKa0poOGxJMXZRZnNFWXB3MllMNnpUb05vbXYz?=
 =?utf-8?B?eXBWalMxWnA2VnRjaEZVS0FldlVPeGt3TnA4eU01R2V4L3dLVEEyU0g3cG5h?=
 =?utf-8?B?UUp3OVJQQ3JoTDAyNG9UU2xDb0V4ZjBMQTZJeVFNdW4zZDc0cXlxQ3FSSGts?=
 =?utf-8?B?eDhsam9TdzZKdzVlNmNERUVucU1JQzVCZ3gyUmMyQ21DVEdLaFpJR3FFaDlX?=
 =?utf-8?B?bGdvOHRoYzBYNGJ3cHFMRG1DSjdYTWpMY2t5OFBiQnZEb1lMYThuam5VRjls?=
 =?utf-8?B?TmJQaDFwZFRHUGpOZ283VFBabHJXNWF6ZXZCeWpBVHZzdWxtVmZoenkxKzZ6?=
 =?utf-8?B?UlNtcTY5czFTaXFwLzlZUHRzd0VINUZnQ0RCbXp3Nk5hMjdid3JaQU1LK3B1?=
 =?utf-8?B?M1duSWxyVXVzbUJaVlI4RzFBZ25JT1BLeHZOeUJJZHF3TC9FSUtZSm1sRVRB?=
 =?utf-8?B?MXVGK20ySUZKZ1ZEdjBDUXRjNksrQXZDU3hBNGZURHJyYjN5c2ozRFpnREpC?=
 =?utf-8?B?eXVHdkxaVThHUFZjRjJETXBha2VvSFk4Z1FhcWZRL3BxQzhBcjI1dk91U1Vr?=
 =?utf-8?B?Vk1NZk5MTTNrcS93R3J3ZXBPOFV5TVdsckJRQXJmWHdyWnhzVUNxbUxaTWlp?=
 =?utf-8?B?a1NsSmxpdmFpMDB1WXFKMnRSOFFEUTRLUVJhdk1SRzlVQ2p0TUpvZlc4eWZE?=
 =?utf-8?B?V09nczBNZk4yUG8xeWRKWUxYZ0xPc3p1elRUSFo2ZG4yNTAwNHFXZ2JhdWpY?=
 =?utf-8?B?c0tpTzQvSU1LaHo1Z1EyeXFXRFd0d0JIcmRrOEtLQlhUclhBOEF3K0Zrd2pU?=
 =?utf-8?B?MW1KS1k1MHhxd2s5SzhqZU5XSjI2NWloWlV1aE9WVG51WnU1NUx5T21UYXJS?=
 =?utf-8?B?OXFsR1RnVW8zd1FHc0UxWnhOZndPU2JiWmRmVzBEU0dELzBvRkl1WTF6R0lT?=
 =?utf-8?B?K0FFVnFML1drVWpROGMyWk93WFo1ZURwSXhLSTlFVHh1Y3M0czlpa2l0VzBn?=
 =?utf-8?B?a1hTV2JaMk1RNnBMeFpYRjc5RkhVbVlMTHVteTZ3c09TWXVqazVtUHgvM2Vq?=
 =?utf-8?B?bnJwTVZHNXY0RFgrT2s5aktZc1dmSjhCVWppOTB2OFV1RFVnajd4dVcrQkV4?=
 =?utf-8?B?d0xRVmZQU0g4WkJ0Q1FFRVJvOXNjNkxQTkp5MXVVWmxyMUJlZzMvUlVKK3hY?=
 =?utf-8?B?TWhQUUZROUxWL0JLNHlVWmNWTW5GVzRTQS9FZHBuMDFFOFJDS1ExaE51My80?=
 =?utf-8?B?dWt5Y3dvei9aazBhallxWnY2dWxjOTFHY1NGaWpHbXJHL0QrQnBUaWdYSXAz?=
 =?utf-8?B?SW5tWFBFSDRYNEpIVDJDdHdLbUhIVXVFWGNUQ3JsUGNqVkhRUHpJOE1HQWRk?=
 =?utf-8?B?NTdndktEc2lJeitucHRFNXZYVzN6aGkydlBxeUowcHl5UHRIVWJOcWRHK0da?=
 =?utf-8?B?U2FBdGIrejc5QUZXbVU5LzhYcUFQbmlQWmxOK00xeHVsY3R4WEFYUXp3aVJp?=
 =?utf-8?B?UmNSSDI2Q0ZPZGx5UlE3WTBUckFZS1p2azJaOEE1bmNlOXhxY204U0pnWlBo?=
 =?utf-8?B?VXZ2bGV3bnVaZGtrbEppYWZVSndHMXFHckRyL2dHVnJBM1duZ0lWOGZQcDVl?=
 =?utf-8?Q?MV8yjwEaS09kR5q1WcgmQkMoP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406fa6fa-a8f0-42de-f91e-08dc58c72557
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 18:59:13.0368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFFd3pXfqt7dhabXNQywHX9co2Aw3UbDnTYpxXL8axyMXh7o92LIyGUPDugHnoZU+ou0Da0By8VFI5IXLhNOTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7673

On Tue, Apr 09, 2024 at 12:26:52PM -0500, Rob Herring wrote:
> On Fri, Mar 22, 2024 at 9:54 AM Frank Li <Frank.Li@nxp.com> wrote:
> >
> > Convert fsl,esai.txt to yaml. So DTB_CHECK tools can verify dts file about
> > esai part.
> >
> > clock-names 'spba' is optional according to description. So minItems of
> > clocks and clock-names is 3.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >
> > Notes:
> >     Change from v1 to v2
> >     - alphabetical order compatible string according to rob's suggestion
> >     - clock description move under 'clock' according to kryszof's suggestion
> >     - fix descritpion indent according to rob's suggestion
> >
> >     Pass dt_binding check
> >      make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml
> >       DTEX    Documentation/devicetree/bindings/sound/fsl,esai.example.dts
> >       LINT    Documentation/devicetree/bindings
> >       CHKDT   Documentation/devicetree/bindings/processed-schema.json
> >       SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> >       DTC_CHK Documentation/devicetree/bindings/sound/fsl,esai.example.dtb
> 
> Did you run dtbs_check too? Probably not arm32 at least (first number
> is number of warnings):
> 
>     218  esai@2024000: clocks: [[2, 208], [2, 209], [2, 118], [2,
> 208], [2, 156]] is too long
>     218  esai@2024000: clock-names:3: 'spba' was expected
>     218  esai@2024000: clock-names:2: 'fsys' was expected
>     218  esai@2024000: clock-names:1: 'extal' was expected
>     218  esai@2024000: clock-names: ['core', 'mem', 'extal', 'fsys',
> 'spba'] is too long

Yes, I run dtb_check for one platform. Which dtb report this warning?

Frank

> 
> Conversions can leave warnings, but any you think should be fixed in
> the binding should be fixed in the conversion.
> 
> Rob

