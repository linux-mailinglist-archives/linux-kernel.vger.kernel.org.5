Return-Path: <linux-kernel+bounces-33614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E5A836C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C121F23E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C18482DF;
	Mon, 22 Jan 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GdvuaYOT"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2016.outbound.protection.outlook.com [40.92.107.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A963D985;
	Mon, 22 Jan 2024 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937991; cv=fail; b=UxcBe1GD1jjZ8Jpj+uZCeLhw4hPFzGoWgPWjHLiS3V+2P25WUtqP0SKX+obHhBjkg5fGfWhESPjoelYbS9FBhk1F06dhIlEWGLunnbeVxqhowBc0TqhmRxPw7g/GgtUY4Wb6X1I90EEpEyHAR2Lysw/3QewcTCydTd95Xqfy0mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937991; c=relaxed/simple;
	bh=vHk8NNW7WGlMJI43vH092GEycuoDr8DkDQVC/JzDtmM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zl++TeTNCjla0a9+k+3smkO54bbVLjzobQ4d95Ma7EvLEb8/ISPDk55IQfdbxUN4CMqvpyIB4ulyd1k9nXeRc6n9D9HKxdSkKF2wyutTFTIAGEkycMT4yfei9m30CCkGbWBYFeAiD0BNxPnPYBPzXl/PA5SxuJHx0c9p4Rq4LzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GdvuaYOT; arc=fail smtp.client-ip=40.92.107.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZgR68SPBaN5D/4GF+eaRZMskA1uJ+TkWu17ZljBBJMB+gRL5ssL/jyQylEhtYSzHC7j/sPDGzZHPftrlisfYn1/hyPff9FuRmWZRbFJyZKDWnwSPE+y9YWg7gXDekcncSGjJODL/+US+htA7txWDL4On/nyo2BDOTL7c9JpV2GaSKWrOo3n8MokRoSNh7UoGlYFrBnMPOvPaRE4bWsnDgmEK5EwdJ7q+k16ona2UdIHGKyWrWwvZe6k1veOyIa3wUK+No2Ykr6wgvD3ynVZlcf3hnFxrKYl0VwbuiwXOG8Ua5JLijw5Nz6TSUJ/L/nC7FnBELiCrxI+W5nQWtRKIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmzVzUkVx9nhFumr/kG23IDIJenfBFsojQ4cVaue8FY=;
 b=Fd/EO/506VZVhUmbcCsJmgw4XbaPlNe7sLDBoSSowzjWvj4AtWSolCwsh2mLyCPQhx+UQprJjdVX1aSpLOC2TYrLQU2HJCcqgvuJjbfRiQ8wVgHctODh463MeOc5ThqFbhunfA7udGTPwNxBGd3F4+xrdus6uTNORB/+vBiJfc/dKOVoI5P+PpBxg9L457uDJLx6R4+Lb3DjeTIhNxr0I3ISHwwGfClUKA7+bgC+p2SM8FpezRIJG66BShLLzeGBF+3l0b2inqJ95bGzJzyXg350VjSMY5tiqACgehgpogOiwLt12vv6FTL8ktzoGAmLqWLZB07SKGzO0kB/n9kkWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmzVzUkVx9nhFumr/kG23IDIJenfBFsojQ4cVaue8FY=;
 b=GdvuaYOTRu82dNGDAkwEYz/CVOnJkROvGZlG8Pzye7F5lZ4K5/Zxkd6boVO4QzH/zoQHBkAS3WiizATtEjRJU0IZss/vaAMVR187/9iOUz8pUBqDSsdmBfHrLwN87wdR6ucXmcvmC60YnzAUj9GS9qWekaxm3gx2fMBV8M7XityuomcvCxDCQhc4QGj4KFOJoQadcgq+sOAyUfmKyE+Q54KyC6mLyj8IpAmvu6B4skkvvpB+nF0zpF6NgNNvJNPZYcM4WXYEJniL/VRbdBPSiyzGSDeYosSdtD/x/0LrLTjw06WjrwPZMAHW7JpXkdo6xNDfNg2+FJhpR7Pj2swCRg==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by TYZPR01MB4140.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Mon, 22 Jan
 2024 15:39:45 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a639:b02c:5189:7140]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a639:b02c:5189:7140%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 15:39:45 +0000
Message-ID:
 <TYZPR01MB5556E09DFC54574C9C7AD1A6C9752@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date: Mon, 22 Jan 2024 23:39:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] clk: qcom: gcc-ipq5018: correct gcc_gmac0_sys_clk reg
To: Andrew Lunn <andrew@lunn.ch>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, p.zabel@pengutronix.de, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB555644D4AF2C3C528BC6E6C0C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <b616c6aa-9241-4eb0-a9cc-a7bc2e706d72@lunn.ch>
From: Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <b616c6aa-9241-4eb0-a9cc-a7bc2e706d72@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [q9iFeM4qEw7mO7JKhlDhyYEPbAgJbJm8]
X-ClientProxiedBy: SG2PR04CA0183.apcprd04.prod.outlook.com
 (2603:1096:4:14::21) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID:
 <98b77626-c19f-4d75-8dbb-62cf6848e1ab@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|TYZPR01MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: e1676250-cebf-4438-e75e-08dc1b605bf1
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnozpoe5DD7mC6QHwETenhSvwWCfBzBse7YzRt/N+QLGg0hBohGMdoC+3+yu1OfoToS65752KYThc1LnafsU7hsjtOQtqamOgmTYzrEvn+Hu4uSM4KDX3pb/4rwacHuBO7txmFD7GfQjaxgvSBjfwGp4mGHn5WwimGKfPGfsmL1XqAmm36TcTU7k8E8WX//X9Gooe+bTC55+XUMeTTqQEj63jQP1X5Ix6nVf7XGvS+SOW5+QsTG6bNzuM2g1G4AkMAZQAV3pOCp0YGnNOg29Rg0GjhiN1vQKRjTQF+F30QLUeCP2Za7bS5bX9WcEGqd3MzhzRE96JPo1VFkAXnF9db+au1+o1S6F2Ccu/AV4/dnfSz+RvW2eEG2Lr3Xg5nqr5dN4SM28TJFUjvFS8xu87BNda6OvPbjqkIfexhklfoAFJpwEpkD6KCLyr8dDiLa+wt1rgR7LFozg5oZp1XgGFEbNKw2st3y5wUwxsAfj06n0pI3ADvU3S2QZKXbPgRsfrLQm7BIg4zSuzeGzV4EZCle+CBSCiBIxFcrrPTXsjDxWE1JTNAatcDYep7j1i5Rf5jJ7jlZqH3CJJsxqgQMGpP0IJ/sC3PbJhSy9FZOAYE0k34MbvjnHj+p2EXdrLEOnQGIHKEq5WwtqODbzqdulkJkq7feF0O2op2cS5jt0drCJASkmd8rEgp5KpcRomcgp7UTFspdXlatKoE0p/v9RahaQjVL3cy/V9Ufw19+i7pzPMv3vKzFFXFn4mIIhrDAhBIc=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YB/NV2k6murVbjbbEEt7K4wxhjbpH8Mz5gbbKMrhLSiUCN/b/yZNs7h48EkV5vu2UXWHefSN1lf+LrJb7ROMxIMCFuJdyAmfKHbSFyyiDWfXVi5PIkie2gr7qMQ3GZqVjcOn7rKFPHB+tfugmKEZ/3o0UT60gkIHQnuZ80cjRMCyB4kz3tb5nOR7qDQNuBiLTHzF0GnUdlUD4YFIjRPMfGc8Be57x0ahGWa4ClinFdIMVubHAuDy1GJN4OJmKnVlObefugOjGc2WycBzIkB9Uq13K225XXAAaSSQ7tmNeCrenR2A9O+wc6zasrWUNjVqYZS5PydE7mceJep8p9eAp4DJIwjwMELKJc1/368aOpIjzMOmoWxs2xse4q//nssnWVcenFZyj5cldhRxNI59yFgchkxl8TR79TFl5Y+2wCyuF4Pj9q5HxN9up818L3RvVH4VOhZqBlB3dwPJla97PIBFd1qSaDpfVkCT48wnMfGbSIaoWTdV2n5FdlH39A2X9pZNQHRLUvIMIOjWQQzYWEM5noFP7yguG0Zv2GgKBYHx9C3MDnEvWQs9/Wbxvisr
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHJvTmpZK2RpWGxkaytUbUU1bFVqUU8xUmtEejVEb3JVRldDd1l5UDBHb3g1?=
 =?utf-8?B?c2VuSzIrRDVTNHlteEFRM2NrNDB1bFNtby9UTTBoV1dCck43MDZJTjNjcExU?=
 =?utf-8?B?cnVNRk5EMEJ3aXZkbFdMUi95OWQ3WC82VkhHejJIL00veWNuNXlBcmFGMTNH?=
 =?utf-8?B?Z1VheWxmczVsTHdrSm8yd0pNWUs3ZlBweHhsZjZFMmduRFFXMGNEa1Y5YzZv?=
 =?utf-8?B?TGl3Z3BzeHNDRkJKdUQ2amJKT3QydHFtdk44MVRyWVY4cWgxNDVHUzVvejQw?=
 =?utf-8?B?S1Uwb0FSNklyS0VoNWlJNElDeWlJc1J6dHZ6TEcza1JmaWZtNWR0Ry9Qa0Zn?=
 =?utf-8?B?KzArelRKYWx2cTZ6Ujl0d0IzVDJRNzgxTTU5V1MzUys1a1lZNktLWWU5L1hn?=
 =?utf-8?B?cUh2T1lGcjdKcFRyaTZ0V2tkZmZCakd3ZW9BOHRaaDJyMGMzR0gvODM4M1JP?=
 =?utf-8?B?MEtnekJPOFNHMEtQMkdxT1FOVEJvcm1ncUt0eVNnRDRrbmk3Y0paT2ZYWWYv?=
 =?utf-8?B?ekxaNEx4dnp4M21XLzdRVlZnVTQzblVwbWVQMFVNaTZ3bGFPUXJrYS80UjZN?=
 =?utf-8?B?QlMxd1oyUlRTSDZkcElIbklJRDgxcGUvYWdLVW1UT3lFWjBmRlVPeHJVYmxi?=
 =?utf-8?B?UU5ZS3FHMzFHUnYyU0hXaWE1bmdpSzVBTWMwUUhVdXg3S2N6YTNRRmZ6a1pt?=
 =?utf-8?B?WHFDN2xSODVwN1d6ckp1dzllNVgxcGxJVGcwZnZJak01QVFEWHAwbzJYaDE4?=
 =?utf-8?B?WUJmOXRlc3FQNkIyRzRCR013K2s3QW9pSko4bngvK3ZnVXUwRW5ZN0QrWUFw?=
 =?utf-8?B?eVNBOXZTVzZMRkRtaTdiTzlHa2d4cnl3ZEljcmJrRTg4SHdnMTVvU2tqT1J0?=
 =?utf-8?B?eElpenFCamtuUFBINHljT0sydVRsaDI4elhvRFVBM2RENW1QbnplQ1J2UEpp?=
 =?utf-8?B?MUJDb3cwUXZSbCt6TDQvcndnODc5NlpiMmNYNWJrVy9BK0lRdWNzT0hIZlB5?=
 =?utf-8?B?cG1nYSsyMFRpZG9rdkVlMEFORHRDRHdTeCtmMEx3MExBRXViUTRGYnBUcldY?=
 =?utf-8?B?SUxpSFRnQU1YaldsMTJXSFlwRTYrT1RiUzBMKzhIdUZBMkZINVdjZVZXMkNH?=
 =?utf-8?B?TmNCaWU4ZFJpUHAxQlpIOFI0NmllcGZuYzk4ZFlxME0yWXdTUXVNYWJuMkFm?=
 =?utf-8?B?RElyNW1NLzExeTBLb3U2MVVaSnRoUFJCTkxtay8rUjlsUUUyS2grZGVtRU5h?=
 =?utf-8?B?OTVaUUxJVk9VRGtubndWWnd5eWhyMnl5V0JFT0E1OU5QNm5vSytwT1BaYjA4?=
 =?utf-8?B?S1JXenFRaUxmSVBYazR6S2hGSUY3THlqZEtxZVdsbjNWTVpPNGpIaFRKVHpw?=
 =?utf-8?B?WG94NTg0Q3JsVjhMV1k1WS85djFmNytLL1oyNG5BNUhvSnpJb3p5dUMxU1o2?=
 =?utf-8?B?eUt2NWhRUVhXbS91KzV6L1hJQ1BxYk9jcWM2UkY4MWRWTTFtVXZZNWFUenFT?=
 =?utf-8?B?NGF1eGhJWjIyOTdZTFFScGhOOXlId0tna0FEd0FONGkza3h6TFd1cURYdVRB?=
 =?utf-8?B?eW9vazV4MFFrNjNYTW4vQmNlNzNjeTBCQnFRRHJicDFFK3B2YXRHTy9YWHpq?=
 =?utf-8?B?YTM0Y3hRR0htcXgxa0NoZFNCUkV5dUE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1676250-cebf-4438-e75e-08dc1b605bf1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 15:39:45.4092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4140

在 2024/1/22 0:28, Andrew Lunn 写道:
> On Sun, Jan 21, 2024 at 08:42:33PM +0800, Ziyang Huang wrote:
> 
> This, and all your patches need a Commit message.
> 
> What is the effect of this typo? What is broken because of it? Should
> this be backported to stable? Does it need a Fixed: tag?
> 

Sorry for this, will add in upcoming patches.

>> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
> 
> 
>      Andrew
> 
> ---
> pw-bot: cr


