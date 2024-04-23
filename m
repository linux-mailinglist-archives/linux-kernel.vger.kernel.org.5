Return-Path: <linux-kernel+bounces-155227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD608AE71F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045021F261F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F2F12C814;
	Tue, 23 Apr 2024 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="UZOSq0uk"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2134.outbound.protection.outlook.com [40.107.8.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BAE86AC2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877039; cv=fail; b=qxpP3YfNlnZXaImSe1p1jvFk7xrI/GnlnYouIhPacGE1wfiUA0f7NGA4E2/JsD9+l05/ssNGiS5Mjts7OXsN2aRJbGyU3w4UreWHiaEbbTfqzwENl1B6qt0ZYvdxumTXV1k4XhfxPe3Vah7Kchx4PFtR1MnvXRKU8eKyo028U9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877039; c=relaxed/simple;
	bh=2j246LpH9jZCftMxN5S5zVSfiFXyiuIzmRilw7AxLY0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pu+NQ1kdFukqhlWYLCxkrCetSmOX7lREhrDtK+0Brh+rB573SseMxzkpt4hAHgvf/nQ7OoypPAuYTxJTematTELBrAYKxc5PWbqB+wvOTLcXXj3QBysD3HRKhU2s7W461al1U0u55/8RP2B0q7uxRAzWzk8JWk66zqB0Iq6/UlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=UZOSq0uk; arc=fail smtp.client-ip=40.107.8.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7LRaA9Agxafr++RbPfMlpKJh5KorelhWLc6vgdx+tsVIVsblJ+neO1A2W8fSJa6uNdZV+ke3GnMhy+aAc7UaJRTQY+cn+Vf/bI60fz29nVnjKE00SsNAD0eewEhIlZ0HqMAcHfXNadt++Hr7wSXICkr9j8d+apQWForrRv3hpTqcBy3Fv0DnQna7EdbEgw4+YdKLt4h8QNsYYTVgJ9vuEsrKNpf2pdj9mOVcm2e9mdOBtmONmvPmAWnrP41tmzmiQ7si305oPIhea0UejUUTWxB/uRZzDF836fd5gWRHXBWmTTL/J2ZSx1xAnaltpC9NwjXYeLCvkcQ6+PcgZsZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3b3lVLxsbG8rHIE88A2+056GUMFZxR91NyHLTm7FI1w=;
 b=Ny5eSY82RwcjM14ldbT4ZNgPz6bGwFjHBPLJVWn5t69ikgB07vDbbUXJBQ/TW7/OdQHs1HF3HiAgZSxaeUP+sZgSI7kK30kKduhLggSTYNB5RIkricllRelQ4RSfFeqjZFkrzIve09NBJrz8PT30gp6lP9suDQhxOW5m8kXRjKwJvtKR10vRVWoSX2LQ3yIbmULW5SPwfjQ9k04OAbeMvc5cIOpD9mYkRRTj2TDyxONTc7wsXdVG6UfJNIfGP3PPMmKcXtMRt/n81BhalKduiRCrQJGFy33C/DXr94QzxWGlhnL5HUueG13/RMNHanBcDHZpoAoNbXCVqgpuSRyvgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3b3lVLxsbG8rHIE88A2+056GUMFZxR91NyHLTm7FI1w=;
 b=UZOSq0ukjF+HphNSpl/rnJ7vF27TXqHPP177WM2Ex92ALOYRfhFTh85Kd32V2yc3ebRR+3hIkBkLaswAvLVDY0mwlauu+6oJwBU72KVW1AIMqJf+G259UkeSMAOHC2RYXzV8liOFWnLREse8jtmHpHwRz8zGYophRbKz8c3SVHkp5uu83l2FIrcDTudKbPcAkfJIGpMk+sxw3P2YevEkdliDxcnALaT18abhUeQalVvxUB7msnZ9tmq3frhYfTM+IjqnOoiQJV29DGuIbbhYu1i5EiStpofvhtLzKEXOmPGXLaSfU91b6yLri56gcZH0gq+8Uq5zKoQ3C6iL6G0jJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR04MB4833.eurprd04.prod.outlook.com (2603:10a6:208:c2::30)
 by AS8PR04MB8166.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 12:57:15 +0000
Received: from AM0PR04MB4833.eurprd04.prod.outlook.com
 ([fe80::70be:f731:f7e6:a785]) by AM0PR04MB4833.eurprd04.prod.outlook.com
 ([fe80::70be:f731:f7e6:a785%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 12:57:15 +0000
Message-ID: <8c044e13-fa87-46ad-92bc-9a5bced4259b@theobroma-systems.com>
Date: Tue, 23 Apr 2024 14:57:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: fix pcie-refclk frequency on rk3588
 tiger
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20240423114635.2637310-1-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240423114635.2637310-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::11) To AM0PR04MB4833.eurprd04.prod.outlook.com
 (2603:10a6:208:c2::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4833:EE_|AS8PR04MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: 475b7618-01d5-4692-7899-08dc6394e664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3h1Y3FpRE9vTkdyZ1hlZ2ljclBXUWk0R0s4dHZmTjNPUytoNm5udEhHSyts?=
 =?utf-8?B?VU83cm9Hdit6WTQrTEllQ3NHVm9JSi9aOHVLdlYxbmZtaU9CUDNNSW9wbnpS?=
 =?utf-8?B?R1FubmlpbkpQRmRMUHJEMzFPOTVZeVJPdTRGbk9PSWtudzZ0QzlteStxakkx?=
 =?utf-8?B?MnQwS3NTVktnQUtEMW9XM0gvSFNiL2x1U2FXdEhGcVE3TzVwK1hmOWlDdFlw?=
 =?utf-8?B?WmE3T3FadFBibCtlYmRnZ3JZMTEzWkticG9LL3FodGRndVBvNzBlRWQrTUJ0?=
 =?utf-8?B?cFpWc1BEcEIyYVh1YmZNWllzN0hFMXRpV3dibE9TbTZNNnNWWk9NUld6OWtN?=
 =?utf-8?B?aGJxT0wzYXMrNFJTc0plaStQc1NodjhZSEowaDFFNG5LTEI1ZzhzZG10U24z?=
 =?utf-8?B?U09KMFVzaHJQV2lwcjkwbG1YQjNEZjhSb2xLdnJNR25lY3Z0TG1TSFQ4ZHFN?=
 =?utf-8?B?QlVNZjUwaWtlbHJ0c0VFSm9rWHJab3BOdmt5dm5Sdk85SnVuT2FJWWhYQlg3?=
 =?utf-8?B?cjdTbmxIaXhqaHRiaVdKR01rajBPZzJSQmx6d1p0ZGZ6VDlFdjU5Q0wwVDk5?=
 =?utf-8?B?ZjJBYXIvb0VIWWRLRTlwVE1UQ2VxaytpaTN4TkxUL2g1NTVXUUNodlZHTDVJ?=
 =?utf-8?B?bHJXbys1VTkyTC8wWk5NakNkNG1CeWFIUnpYRzlxMG1jMEMweDVrc3RqYk5r?=
 =?utf-8?B?b2xpell5clYxYmdnandlZ3ZiN3FuZDlWeklRY3RXRXZscng4Nm9BZVd6QjNN?=
 =?utf-8?B?eWw3MW52TSt5VnZnWUc2c1VYc3JOVlhKWVhnTWVBZTI2M2VmRm5GZ2lZcWNV?=
 =?utf-8?B?cnZpRnV1QTR2bEZMMlZXRGNxR3BWb01kYjVHalBaTmZReTZpVnFmZVhzbEZi?=
 =?utf-8?B?U2l6R2l4WVoxaGZOakFmcFdObDhYSDFNSExRQ1JuR3RQa3E3dVlmUjU5cCtu?=
 =?utf-8?B?VUs1YmxxeldEK2RLZU5rY2trTDB4UWc1Yzl4UWUvZUd2TjhKUVNYenNNTVkz?=
 =?utf-8?B?QjJiUDRqSWUvQmVaRVhtdmc3blk4OEg0V3JDVTRYTGt4c2JzSFRFYzc1bS9C?=
 =?utf-8?B?bTFuQzJQLzBsY0pXbkRUR3BVQ1lZMENOZ1kvam5YSVhXTmJTSHNJaW4yTENO?=
 =?utf-8?B?aFIrNTYrSEJqQ2gwaWU1eDNCQzNMWXlmTW5OQnV2T3plNUZlOFQ1NUZvbHRZ?=
 =?utf-8?B?Z0Rad0lrV2hUTWZBejNCc0cvbFdjTXdmVnN5bDZFek54cGNDSnRjdElzNUYy?=
 =?utf-8?B?YUNmdDh1RjdhdWMzcS9uSFV5UG9RcFM5VjIyRW0zb2NubUFUck85c1RTbjEw?=
 =?utf-8?B?QTZ4aTg1WEZPUlcyK1ZKUkhYRUxkejdGT0k2SVJmSXdFdjhvMkc3dGt2SGxL?=
 =?utf-8?B?YnJJckNySmtIZXlhNmRrN3Z6aWR2YjFQK2Ziek5oV2h4b01GWTM5ZkZIMnFP?=
 =?utf-8?B?N1BZdWNmTUY0SWw1dURoSFpHeURKQWhqQXVtS240QzV3dW5vRnZtQmFQZCtt?=
 =?utf-8?B?MWJPbWZYZlBHZUpULzBRYjNBRHVQR1I4b1NDSGJEdyt4c1dNUnlpTUt3UVJG?=
 =?utf-8?B?b2NwSGE5TG13ckxLenQ1cVNRVFpMWnRWcmtyS3FMVUhhSUtSa2F1aGVoc3lk?=
 =?utf-8?B?bWhuNEhEWHllUDFsOE8vRHZod0ZVYmVPdHk1aEtXQ0xuV2pVK0FKcFJlYmZB?=
 =?utf-8?B?V01IcXE2cVRHZk9TUkVEWlViNmo2R2dBN0NDZ1NPYTFBMlN0R3g1VEhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTFrYmZrclVlSnA4bWxjWE8rdnUxNEw2V1lSZ0dFakpxL3oxeEhOenZoVWI0?=
 =?utf-8?B?ZktBM3BiUTdCUmRhVzhYclBmZWFqdW5RVTZNNFZTQ2hCa3YwdXdJOGxtRUdY?=
 =?utf-8?B?cDdRaTRlQWIzZlI1akRIVnI2N2F3aXRaM3NUODZsNGY0OTZ4aHFqMDBBUVhB?=
 =?utf-8?B?NU5BcGFNK2J2VC9oNm1IVHZzYmFNa1NEMDlqQzdCeVB5K0Z1WmViMTJuYlFs?=
 =?utf-8?B?YVYyeVE1dkV1T1hhTXdweHVER3RobG04SjdxYjBRMXRlR2JvOXRML1AyQTBm?=
 =?utf-8?B?cUFSMWprYkRtdHFJcFdtMjRudTNvR0RaZldtcUtLQklQT1g1UHpmYjIyTG82?=
 =?utf-8?B?MHRRVXI5YTc0THd2cWx5NmZ4d3c4ZXpWRHBHeWFqTGEvYUM4SWlCZ2pLbWxU?=
 =?utf-8?B?blp2TVV4M0JrVVZVMVhCSHdpNGtvTTJZTkUxNCtUNTN4Y3Qxc0lFeXZwTHhC?=
 =?utf-8?B?TGRXOUNlaUVLMXgyL3dYc251Vm5qSkNSRys0VHRtdW1rWGdkYnF2WnJhbHU3?=
 =?utf-8?B?YnYwcVNyeVh0TWxnT0dZS3U5YTNtNDYveFI0SHJrVTJsZjVZZmFjb1ZpNU04?=
 =?utf-8?B?THVoUy9hNXFCZmlrNm1JdnA5NkQ4TEVaZUsrME5IUWpidUJnenFhbjhBa05R?=
 =?utf-8?B?Yy9VakxaZHppTjZHenovUTFVdkE0cVFsZjZzQktiUGE5TVYyWFh2L2JVVWQz?=
 =?utf-8?B?VHpIUHA5Q1EwczFyVDBacVdheE1HNnp2akRSVlBxbStKK3hGZXJjVkhhSEZx?=
 =?utf-8?B?b2JJRVRjQXpHcXAvdVRMMGxac2l6Y21SUndFWGVZRWREV2NJVzl3eVNSUFdl?=
 =?utf-8?B?ZFVwclA4REVhOG1Qd0FEd1lRNTRSWU1hWWlleHRyNlV0UGdzUzhoT09WeU1p?=
 =?utf-8?B?MTRhZXk0VGdZLzZYREt0T1BSYTNUSmg4Z3ZWNy83OUxwRExXRkl6QndMNDVF?=
 =?utf-8?B?K3lOTDMxMDZza1dZeE42L1FUNnJTVlVvbkFRdVhQZmgzV0JNRTQ1RTRBdGxo?=
 =?utf-8?B?cHJKUDdzRGNXZW0xelFJTHlqZ0VETW5oc3J6OFRubnp0S2ErbkFpWWhUdTh3?=
 =?utf-8?B?UHdmTmdZTDZZZHpDK0lwRzFTV2owMitMbE5PaVFPSnYxc1JNWmxPR3YrTlo4?=
 =?utf-8?B?YzZCZ1JJTDEwRkIzRXJneTBBdExQRkpNRnpRMkNlOElLekI2QjhHZjlzK2hG?=
 =?utf-8?B?eG5iR2hFS01RZkV4MDNwZDFBbFhBcVFSMjNqOExrTk5PNk14UWJsQyt4NEdF?=
 =?utf-8?B?V1BSTTdZbTlyWUg3dkRvZmVKejdqMHNYN1htcU5sOUQrQ0R6dkh2OWRONnRq?=
 =?utf-8?B?VzNJOEJMa0dNV2tiYXk3WjdCclBXWktmREY4ZGJmc1A4aUhPcXRFeEl3ZjM2?=
 =?utf-8?B?ZVJONjQwM0RFNVBNcUhMUzNMOUd6a1U5Uk9ZMEJTWk9uRWg2UmcyejVhclVU?=
 =?utf-8?B?QTFONkJpQnFMcnQ1ZkpQQy85ZGZMUlUxOVhUdXBrL2VIQXltOWU0SUx1enB5?=
 =?utf-8?B?TjhMTVBuQ0ZVN2FvUDFHV01NRmlRMnE5dnFONHdHYWdrMXJPVmp5S0g2STh4?=
 =?utf-8?B?SFBSS1NLaENMQVMyVFZld2VKZ0piSDhUV25JU1NQUkNUUVBBZERVaTMyUTVz?=
 =?utf-8?B?TklKZTQydVkrWUpBa1lwY21reHJYMmkzOXNPVjNEYWFRZGRieE9GdWNNM1cr?=
 =?utf-8?B?T2RSazZUUWZkbVM5bWpJM0VMczBYWldDS2gwcEltZ2t6eGF0cFoxdEk1RGFx?=
 =?utf-8?B?azdkbFkzbmlXSWFjeTY1YnhSaTlYUGc4Yy94QU9rcHFmc3ljaXo4eHp6OTZE?=
 =?utf-8?B?MXBGbmIyWXQ0ZWdjR1ZHTnBxV3ZrcFVQYWRtRlZjOElJUnFGOHBrV0pLeDRi?=
 =?utf-8?B?dDh3Zk0vSTd6V1ZiSURNZmVmZ3hsQlpmM0pNQTdIQ0RrQzBCRHlYU0ZtdVVQ?=
 =?utf-8?B?cit3VUZFblBQVVRwdnU3VTcyM0lmVkdZT1drazZOdEoxRTlnWjRMaW5wby9r?=
 =?utf-8?B?WEllcWhWUERRc0VaVUVXODRCUUNySk9SdHlhcURzNEhHVnFIdkdnaUdienlG?=
 =?utf-8?B?THFHbGxpZEFqVkJXeitpWGl6UU5naUovZnY5M1NGSE50N1d2M1FpYnoweklR?=
 =?utf-8?B?OXpNL3JiY2pMaWxLUVp4cEgzaHVXWFdiakF3Q1JFRVA0L0hQZ1pjVVdwbDRu?=
 =?utf-8?Q?dtZjdtW/7JlZJcZBCDVseLc=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475b7618-01d5-4692-7899-08dc6394e664
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 12:57:15.2923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qktdzbq7SWAIABONRoLKEZ1Omz1u0HYVuAWSyoTQlaBf8z7KgFrpvgjjJlmrAdkqN6rmuRMK4eNaXp/Xf1T7dFzTi9t/DNHxx68qtGLMFvv302hXMgS9B6naYYHwO1XD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8166

Hi Heiko,

On 4/23/24 13:46, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The clock-generator of course only produces a 100MHz clock rate,
> not 1GHz.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks!
Quentin

