Return-Path: <linux-kernel+bounces-33185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 929B98365CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33997B23F49
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31273D574;
	Mon, 22 Jan 2024 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sgwprZir"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2050.outbound.protection.outlook.com [40.92.53.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520B420DF0;
	Mon, 22 Jan 2024 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934783; cv=fail; b=OpAaRHDrRvb0IcaXeUjA0aweCNXmKWU/MjYh/nDIbxSNF6v8hpe8ug8bPI49qrvKSbpeOyip37IvVOcczuACZN/3VZLIP/rs0mVCwKVQYnTpRlAs+QoAkXmD/t2J7pybXZM8idw9R3HY7mzK/r7tZO13euNdnb73Sjpo3T0Z1O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934783; c=relaxed/simple;
	bh=Blhn+OkI7MFJnk3MfHUCF0S+IJtqI15FTAJUP1tvx/U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h2bq0D2KzfI1kxwahdys7wRB3lM7c5rjE6BKMa8oAnvaKC4Mvp2cp8+tK91mRnHGbzDf1cVkrceq8m79iBqKhb0qLp35aQoHavc6TZC6RalnLcrpGEcoGk6nX2vdFEvKFbfUrquDg2Uj1XZ3JAlHm2N619wRGCOnVZvSgvMm4V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sgwprZir; arc=fail smtp.client-ip=40.92.53.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anxULeN9Eedn65Y3djIkLcjlLO+6Qrmh+mH53k/izRyp+BFMgot//kjb7E9Q+c0XWQUwbWAFKo9BhqY1l1pW+41ZjD+leMKLYaZhaVSSCVSltnDEb5h9xYdcHA3El8+CAiGI5iKEPW7PUUcoJ0SkMRYlw2jJhlN6KXPXxnmXkopWmPbmlnI4QclKaOi7Y1v0T6WbtFSWmViL3Qjje1TeAVixY8pQ8qKHO2Dlj3I6Ud9YCGsKE2eyzy3O8FEkmIw7lFCaujr5lmZ70eHQlltIWNBvgvowiJKEmIpScCS2GR7xxIu20aS51umyN7FSCzHPc7iFSjt+LbzPSIQMT6VuXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBsE+d7HnRRXH0y3oYTeyfKkPOtquEwVJ5KaCXbBAzo=;
 b=luuqhLSdTm44IZwFZ8RQxlCPtb0QGb4csWh+orJ+ApWw4uF86CEvcoOBRRo1L1l7yMDHIOccgFr2F++86XkQSDmcmo9maudOP2xC90eURB+lejgolg5yIT6u6ABzMQJnp4I3euB+KLPULZ+7bOlcH45F5rG2UiNUrjyj8Gc4Nrvh7NcN6hQFWspWeSCV8FjBvFZnRo8J4BMzsYO9nQ59TcBckebGEfstMpBJZP4iNj/QhNOVTxaUzLUvXOAIBwyEuJRx4zB3+lofXeiNJhxl9ZMZhJGwAlFv3ZeBJjxMfqdvKY/zbJc2SKPwz+Xhly4RcfeciLBlGzSXy3GCdLw64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBsE+d7HnRRXH0y3oYTeyfKkPOtquEwVJ5KaCXbBAzo=;
 b=sgwprZirPbWrVIC5bXe0zONMiTr/15NuJr3NB3vZjbCHfElshFm0398GACavTlPFzggS1A5pC30gjt53uDplYjwEyGi1S5tJnXCAab2/ajkPw3ELPfT9FV5tE3WxLTIX8eSyA6+jsFg/0SrQgx5+CkOPxNMEE6LNAdZ9HeY30MzhoH/NI2vJ2/NlTa/h/7SIA9QPg9GZZFOZcTvmFDeCL8YcCBpxRpLfEAGmLeO47TDpRazQOuWIcp1qknhQNrjWL6h6QuTdi+2gsdbMcYQW9X1JECqpEkg13C0Rjk1Y59eySSqsRKGWZhVCkD6cTJpV5Rt5MG/OWIhe2aN1aB+A+g==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by JH0PR01MB5558.apcprd01.prod.exchangelabs.com
 (2603:1096:990:18::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.27; Mon, 22 Jan
 2024 14:46:16 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a639:b02c:5189:7140]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a639:b02c:5189:7140%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 14:46:16 +0000
Message-ID:
 <TYZPR01MB55568359B28ABD550C8ECCDFC9752@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date: Mon, 22 Jan 2024 22:45:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] ipq5018: enable ethernet support
To: Andrew Lunn <andrew@lunn.ch>, krzk@kernel.org
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, p.zabel@pengutronix.de, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <830a2717-c7f5-4bec-83b2-be14ba59337d@lunn.ch>
From: Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <830a2717-c7f5-4bec-83b2-be14ba59337d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [bIcTYmDZQVsWO7qrmZ6wAKLe5DZDQAxE]
X-ClientProxiedBy: TYAPR01CA0070.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::34) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID:
 <42876a08-2079-40d3-9306-3faa86ad257d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|JH0PR01MB5558:EE_
X-MS-Office365-Filtering-Correlation-Id: a5380066-748e-4f87-3bb5-08dc1b58e2e3
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnozpoe5DD7mC3EAaljaQdX1WXrohiKbJ2I11XDaE2xxt2HE3PlY0xvsWBiKKO0GWyNtZdAYT07gBeqQVyzTnIc9P3cw8q272O7V97S8ak+3bHjSuLIdJRNajOBT+n8giyc+rszfPoywiR4VMHdAC1Eqhkc2W5nWXMEwKCQbLsXOAhmea21SRo0ao2JAQlS1pHw9tl7fMUkQnOB656g7QMG8PyPm6EcwW+Egy2rNZkzLRgjBl1DfvuiG7BYumQk8CcUedtXyvyDZ8zTqpz4KbMW/kQMUv00tPhLXF5Sw6atnKaeTStwNaT/Ka5rwugFtEE0Sh21gR1mHclC69X6zQzSDCL/AIDMc1tpxbMGkOrfCYynevM5FdgIbnMxBu/xlaXJwh0cDQ/01gLT6lzqzIBp7tEVByChBV85az5sfGZPhCb9R7AsbA55xiLyaKb1RnsWFHvtr4ggHVWTeW8uGNdKdAMfddYPlS5aVsl3bprXhvFKWjGWo6giJpS+nYHH6PKioUgvNgtDFy6cG7IdHv4IxOGrYKHODtRkqxc6003zJTdL054bEDKfKeW3pztqbL1pcdKjx1VJPTGR5dki2GtuDKyq7RHMeKZWAhY8lrMsgfNOG/kB6reI+5Nmdlf9r01wpy1aGLdxhadoqZV5wCOw6H8svGoau5wfRAbj6FtA9dECiXDBBmbmeAtZ9uQ0AwZ/O+41Qz1sZCLia42ExC/hEwV/EEUNBz2fIE27udquavPUkYiC1Xp6mDktXwQvkqC8=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tFazeITe/3j2hj/izMPo+h7f3BvW7/t251ZohJTbh8Grp+/Ny0DX3Ekqj+CD18/qcJne3TlEonwigFgNGAdPWXVB7bl995e8fJKTar46l/woqMG8rAqHfJicWg0hL44eVheGq5hfcJae6QSu3QLFN4YeTqcOKOGd+BkpR5smKrPn8irUuI2aD8bjDD882F4UDHeIxC8G4HZ0+PlYVb0tv4nxN3ApDOCbzYYBnuUDx5x726Vquzii0c8p3kxgcOBttVQZSXsDDlU7tyfk2G2rzWWFelih6sTSQZjlXj2UyO/zA2cmEjLJlSt8NdqyOKwI+Ny5tPVmPfjtKJ7Xpi/HgTeHp98r+KggGamaEQhhushQU5wBaIS9csYmw2o3UrCXY8GLVFAsX0JO5FqIO+CWmPjGcSEjpx7ndYfIG5VOK7X5XGnDCFiPd1UvAxREdvlb02zf70T0yU67rfB6Ml6mZP6sGoXeggpvJBmm5vIrSlbvUh26EZ2+4QSWyffWmg6hcippI4KokDQ1dwjybiH9dNi1OXi7+hRQPdoIFFdAZdXgSVh2tx3Im+Z0lYz+7aNA
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkRSeXVxNzNsRHpPVEVoVzBKTldqbTA3WVRWTzEzSGdwOFp0UDgweW9ENjZJ?=
 =?utf-8?B?QjNOSmlsTy9ZSElHZ3RNYlNra0l3RGlUUFplOVgwNTdBay8rb1E3emNySHBo?=
 =?utf-8?B?N0FFbDh5OXRyb2d0cTVhNTNlTzR1bjl6dUlmWTZ1OWVibmMwTzk1cmJBMDNP?=
 =?utf-8?B?dTc0cEpyLzd2ODVKV0hFVWpRTnloRFErS0taNytZWGRLOVQra1RxT2RJUDdH?=
 =?utf-8?B?VWNLdVNGcG1IRGdTMnNBWEZaZmhyV2gyaGZtVkRvSWRGeGdZV09wcXQwOWZC?=
 =?utf-8?B?MVFDSktQK2c0YnBVMXZRejArMVdxSDY2NncySjRWeGRkaURPb3J0OEZ1WFVm?=
 =?utf-8?B?TTU1cCtzRjFUWVpMYUVtS2x1SmZ4SEFoU2w3OW9wcmFsa0l3dW5mT0FyZ3ZI?=
 =?utf-8?B?dytXMUJBOEo1YSt0R0czUlFwdE9pZFAxZ1BXY2UvbHZWODRSM0hTSklmdldl?=
 =?utf-8?B?OEtrbmdScjVBU3lXMVFibzRPVkdhZ3R1VEw3VzhGVytsZE8wMUllT3c1bWhp?=
 =?utf-8?B?WDBwemFVbUpMbjRzc1YxL1gyVlo2MnR6Y3pyL0ZxM2YzOGZqSnlURldEU2Iy?=
 =?utf-8?B?eURMRHhlTGRNWFltRVp4L29Va3M4blExbmhERHRHNWUwKy9OWmtHYzNIalov?=
 =?utf-8?B?Sit6T1VYTGxNOUhBUWVnbVQ5UW5CYTNBV3F1YWxueGxWWExWSE5FT05GU3Zt?=
 =?utf-8?B?cUZJVGs2b1YrM0Y3eXlSWlgwQll6eWFxaEFtRGYxWDdJTmJpdzJnRUFoLzQr?=
 =?utf-8?B?eVVIeVU1MEsrZjF3WEVhbnUvTjcrWWFRTURRbDZnU3lyUGYwSkVHWEFmakVO?=
 =?utf-8?B?MzlMNnRUL1dxS0VadHhVeXNnejFvOG05akdBa3p1em00Z05ya0hYS0Racncx?=
 =?utf-8?B?SkZwODZNS1NxSllzUjFObGRjdCtNbUFLY1RGakdyblpOdFV3dWlUNm55UFNo?=
 =?utf-8?B?Qm9lSGh6cEpwMHdIbHE5ZFp2R0xjZzZOMXBKSktzaUVqSG0wQkRENkpYMlht?=
 =?utf-8?B?bndUdllsWklOSUJ0Mi9PbnNTb2RoT2Q5WVJnVlorVjdqekNBS3M2RDZEbHY0?=
 =?utf-8?B?WDJUaC9WT05WNmt3Q1h4dkVXMHArTXBpZFMxblp0enVnUmlQd2xBUTZ6V0Nr?=
 =?utf-8?B?bkN6eW54TTU2VDA1ZWdGTjlqb0hBSmc2VFVuVDdqTHJUWkYxYk45N0s2YVBJ?=
 =?utf-8?B?ZzJWczVsUU9tZUZXUmtXY2lzc2RJTlJwa0lFKzM4UytBNTJvbVZQS2ZiV21k?=
 =?utf-8?B?SER1elJqMFdYNlcvaHRCNm1zdlczblZVY2xmMmIyR3didXFqdUM3a2xDSXdY?=
 =?utf-8?B?S1pIS1F2V1RVaUtKYjhVM2s4VVFldUoxVUp0YTVocjFHWEQvL1g0Z2RMbXVS?=
 =?utf-8?B?UDRFMnVZeEo1M1JCWmQvNmZPTjQxRUFBVGZqWXFvSGZZS0xMLzRNZGpyUGlH?=
 =?utf-8?B?RFNsM25BNDdqOW9Kc0pvUmZ5SGNOSnhIcDZXVUpMODlHaXZEWWRWVWV2ZjJG?=
 =?utf-8?B?V1lFV255emRiQnMrejlGMlRQa09WOU00V1dFeGRqU3hxNGxCS0NYdWVHNHB1?=
 =?utf-8?B?LzlpMGsrSkp1V09RellmblByTFBUa2Y4Zi9hQ0xrWHhDWSsyR1RqMy9RTFY1?=
 =?utf-8?B?ZkRhV0FIL0xoREx0WkgwTG9OUWxIOXc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5380066-748e-4f87-3bb5-08dc1b58e2e3
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 14:46:15.9164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5558

在 2024/1/21 23:51, Andrew Lunn 写道:
> On Sun, Jan 21, 2024 at 08:40:39PM +0800, Ziyang Huang wrote:
>> Enable ethernet support for IPQ5018.
>>
>> Praveenkumar I (1):
>>    clk: qcom: support for duplicate freq in RCG2 freq table
>>
>> Ziyang Huang (7):
>>    net: phy: Introduce Qualcomm IPQ5018 internal PHY driver
>>    phy: Introduce Qualcomm ethernet uniphy driver
>>    net: stmmac: Introduce Qualcomm IPQ50xx DWMAC driver
>>    clk: qcom: gcc-ipq5018: correct gcc_gmac0_sys_clk reg
>>    net: mdio: ipq4019: support reset control
>>    arm64: dts: qcom: ipq5018: enable ethernet support
>>    arm64: dts: qcom: ipq5018-rdp432-c2: enable ethernet support
> 
> Hi Ziyang
> 
> You failed to Cc: a number of Maintainers here. e.g for the PHY and
> MDIO patches i would of expected the PHY and maintainers to be Cc:ed.
> 
>       Andrew

Hi Andrew,

Sorrr for my mistake. For easily comparison, I added these patches to 
git index, which mess up ./scripts/checkpatch.pl and 
/scripts/get_maintainer.pl and led to wrong results. Will add correct 
Cc: in next patches.

