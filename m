Return-Path: <linux-kernel+bounces-84841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833E086AC51
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA52CB23F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFFC126F1A;
	Wed, 28 Feb 2024 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="Im8OIepH"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2109.outbound.protection.outlook.com [40.107.6.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84957E599;
	Wed, 28 Feb 2024 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709117059; cv=fail; b=cvm6iDgT7wcVDhACDsI/KXr0SyM+cvGl/9hZSfJzZ4MPdRka9lzjFxT/1Q+UmJzfHrRdGL0V1NrqwkN1Qym1cdDWQ0+Pw8tf3YMhvInjJFvM1lxOTRPPu3GOqy/oPwpIBzpJyNIRIVi2/lFTW6WQeOeUGQuMM43vzhB/uUdbe1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709117059; c=relaxed/simple;
	bh=pVSgw7iwNlU94s9sATEaTrcZvtVXc1keuhjsWzqUo2w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ud2T8AkxgtEWTZABzwDtUPcYIwXzM4XVv5uIWz7oB4UNv6wU+HpXyW9/V1YeWUjNL/ipRnNnUkEfNvRxwHKyE7nxpmwfEB9vlIOkPI5arRNUswJ/4UCBIwgdxvU/IIpoM+UeZPrrHwfiIqLALlt8Gmm8CqoW/DI1EVQ4Nr0aJLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=Im8OIepH; arc=fail smtp.client-ip=40.107.6.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EX55C0YrSmrjzroTK1uOrFJ9QC8DHCXTb3qkxnFskyjqnVxaFehShQz/UajKHPB24ShjQeKCv1pX0qy/RX+NJe2JDkmPfpJltVojH2BCCCh2TI4QRqDzkpgEtnrUq1SJ6pWsPi2i52FbV6LROzRXFe5mwHPgxNJZmC4aI68NbPdWNQEOdq5EryEp4C/4/WstjPQ8BPkU8mpmqqQEfkGSlUMIBeZp+KS/6OGwNYvCKyAV9NwcwYASyV/zhVs536LyytI3R2+gfgygOdUvxZGIeVLSn5mvzObrzvozTf/4OMwL7lVn5BKr4G3AzyCefiWn7KjP9DRZnf7Sh22ufAVV3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojMhzQHxt/LB+jp/Wj+PNiFoE1fF+Qj+NUn8kcy52Gs=;
 b=fXSXimvlklj7QwlgYnSyVv3bnZghy9ufisWSq8LdJvB/fVQVYDgE9HE2/Nhx6CJGZble/C9cYPynCrLJgOwHU+c7+RkT6Vi8VJmjPHmyLKQ9eYQmols6cytnLpNAyHbgYbWPpMug6+EouM622A8Lr0aB3F3DY6XztAxZFSBZ2360SjDm9scrZcwOcKP4U0hcVKEaTmDo8kG94RaH4Y6D5pLz6tbjn3t3lZuqDEij7y7RdrpKIylCXO45Oed9WmPDfjxVU5EIK9/NO8pCNqDWjIvR4Bij1nrRJZ5OJx5UKx5rBGr4/DKUQHcvpChvhHLuhK7/T5dAnv0ywgPVvxBd7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojMhzQHxt/LB+jp/Wj+PNiFoE1fF+Qj+NUn8kcy52Gs=;
 b=Im8OIepH1pVvHsnghpI8gvu5qWOXYMKncsi2Re1DIjQwAxjgC3ppEeWeTxOwmVtvRZjJVJyYjhTXjh0S+rUjhqTlpCnXNBJfFSerBsvdi7Z5ueEulfOZKcqPpZFC5WU6G8p23+bgfbP4Mta47vLUstqQZkkHJKrGOKX2fY2lEzfYD934F3xMNwjnvB7KZTKorz+KhWBiDYG21xJQdCPXMUbTXAscVL41eRZuT8zQJxZw+cjWU+pMWKdMt7gtg2FxHv4stau8+6QWNMer2UvYjB9Ca3qnb4FKiXvhdM7rIHb0BikipkAWaLquUEutmFejU7DoRgwzfN2aKt8KdCWaog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM7PR04MB6967.eurprd04.prod.outlook.com (2603:10a6:20b:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 10:44:14 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7316.039; Wed, 28 Feb 2024
 10:44:14 +0000
Message-ID: <cc8c2bf9-af56-4952-9c80-552a1b8c6790@theobroma-systems.com>
Date: Wed, 28 Feb 2024 11:44:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: arm: rockchip: Add Theobroma-Systems
 RK3588 Q7 with baseboard
Content-Language: en-US
To: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20240227164659.705271-1-heiko@sntech.de>
 <20240227164659.705271-3-heiko@sntech.de>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240227164659.705271-3-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::10) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM7PR04MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: c4225fa9-6383-43b9-8a50-08dc384a3496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t2TAJ798YNTqg15oG+kKsT6fdf7miW8xBRQK5WautiNYytFBQhCOxTvHTaHrb2sj1KgFPcVFcShQsnveKgif1kwnwuDtVEuN+0XvfH8/kAPPQ1qkuH0a/2m/K/5leuFx7hvvq0X6AKSbrd3Gu5C7hSJG/tqkl3D4nNVDFR5i84wUdXuDRQYbaRonhHjWK7HaOqJ6SP3yAv+Aan2b2XOdAh5CuWnZOb1Kbn6gDHvuQWpR03bUef1HwfCnLqri55U2uCOfbVeW2BFp7mfKOByij2Wjj8rxLc3N/ELsL4oUaT1dLvApyxzwBke99F1W8okNu7ngyhCZiataNQhTIKJfnfT6bp8NnHgQPEMw2IvkgVh7550BvvXdTQjzdMnFFN/jP+6stKHBpCgm5PGNh5roGnOEyoO7/mSVSjueLeoTjc+6yVotQdW1o8TcEzeylYQW6QBEVv7X1TpcRIRaNCLtzb7hG0wy2PehhRw+2SoGS9e248VPFHDp+zrxkqXRCzBnt9Tk4HhMqPvpplOcN9n6mDO2QkQHttJHE2oZGIPibEHNqw7dvenDEpOL2tcChP0MnFuIm2IabQuU96dKC1jughEiy5FbEa9gPpulvB7ISZsJaCVKJQlTgbDU/ham8t0dfBp+ig7BXJdU2asuxImCSg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0IzRzBOeXFsU0Y3S0FrbDJzMkQzbjFwMkVNSUxqamZLZW9JUnlTa05qb0tR?=
 =?utf-8?B?ME9tU1VQZ3dQT1RiNzRpdk9zZlBxQUpNNjByTHB0SDEzb3ROMEpwRDVBZFRK?=
 =?utf-8?B?M3gvL2F5REx1cnVTLzEyckFEWVdnUld1QnNuQWZ3aXh6NURmamNPU05WbUUw?=
 =?utf-8?B?cmREM2tJSDhMd2wxT0FVNENvenNaaURJTWFwVEd5OUwrSGJrZ1ZIcFNyRzkv?=
 =?utf-8?B?UE05bUpZUmFFVldPTTBuQjE2ajRMQkJoRzZ6TmpuUEdOMTh5dnBZaUxVWXpK?=
 =?utf-8?B?V2ZXajJkMTJNaTJBY1V5Z3ZtUXdJQlJQREpNemJoT3FscmpRdE55RHNkc1g1?=
 =?utf-8?B?Smh2a0lnSHJzYTlROFF0LzZ1N1hSMUZRS2daL0ZrS2lNUGt4ZWxpaDFZamJu?=
 =?utf-8?B?QTRWM29xQ2huWFQ1WWRockxvTkhYK05xVXBOOVFDWUI4N0FkcDdRdUNBZW9N?=
 =?utf-8?B?VjZmbzFLQVYwMWl2V1NPeU1peHlYY28xTjkvc05sZHo4MTFWY3RSMXk3cXpH?=
 =?utf-8?B?NkFzN0NIVXdYWE02UVVjRXF1Um5LUjZtL285TEtZcEZKN0c4QndsSEc3dk5O?=
 =?utf-8?B?RkJUUWRXS3I4eTRxL2I1MmNoMktxYUM0cnNYMG5JdUo3VjVnOEdFVkg0THhs?=
 =?utf-8?B?OXBpcHdjSkVHUkFsdStsa3NKZ2w1Mmc1WGsrdnpPL2dHK1hXVmxVeC85S1hy?=
 =?utf-8?B?ZThJSjdLVnBIYVZlek05SmNjNEt0VCtoeFJocm5zdUZCb3RKVXNhU2V4VHFM?=
 =?utf-8?B?NGQ4RFpDSGtwZkJrR3hjaHZLbTRyajNFSmhFZzBaNG5qUXlDaVMzYVMyVkY0?=
 =?utf-8?B?dEFQa3NFYXNwMSt0TDZUdUI5a002VVFndEpZaTlKdHoraGhkV3dlb3RHQzR2?=
 =?utf-8?B?V3pIZVI4QlBxQXR4cW15aVNrcFpDZXFla09remhsY0JRR3hScWlteHpDVGhG?=
 =?utf-8?B?RDBscmhsTzl0UHcvZklzNFZUS1dWNFl2MTFwZlJZZ3BVWU9QT1A1V3NrMG5z?=
 =?utf-8?B?LzduTS9XN0toM2RJY2hjUENRUU1aR2VzOGJpSFp6RGJ6M0kyT3dMNDdQWHVN?=
 =?utf-8?B?blJNMmFNTkJsaUV1VzF0OEN3a1poSDF0V0l0VWk3OGFvOXI3alJuanNlc1BD?=
 =?utf-8?B?a1B0c0V0N3Z1QVJKRmU5blZqVlpkYXhqeEJVVzhZSGg2ZVMxY2grZDZtaDRB?=
 =?utf-8?B?a1JETXoybVJYUmt6VTQ2dmFPVXB5ZFNJaWR1eUgzT05XdWxJeXRzU3RqS0FL?=
 =?utf-8?B?bnNvV2h5VXR4clRsajg2TFJ5azE5TFYwa2ppVklrczRQUTBhMjQxbDZGR2x1?=
 =?utf-8?B?UzMyV2FVVlNXN3dQNm1rTWpFOHB1cUdzalYwalpsRU5rZ1YxcUJMNVUzZStD?=
 =?utf-8?B?WWlNalU3Z1hsM3RNNy8rNktNOWlrQjBtS0RFbGN4cTR4K1JUY0VHbGRFUm44?=
 =?utf-8?B?ZVNvWDlnejc2QUJMY3BaQmpxTUtVazRDa3JoN3pxakpkSUlQOFdQTG1SSE4v?=
 =?utf-8?B?dVVJSVpSM1VaZFRZVUJrTVRlbXh1Y1ZaSDFEd3NsS1RTNkUyc3RSYXJjNklr?=
 =?utf-8?B?R2xIaUpYcXppZEdvMFkvZHRyQkJGb29HZ204eUxzRmZwRkRUVEVyQTQ3b1FL?=
 =?utf-8?B?eEZwRTUraERjZW1NbXgzMkQxZWUwNmUzRE9sb0RGZkMwbkFIK0Qyamh4MitL?=
 =?utf-8?B?R05Rd2FFcFhZUnVCdUJzQWtkWTVTTlFyVElkTHVROGd5SnN3YVoxMDI4Snlk?=
 =?utf-8?B?U0VMVkxvRDVvdDh0amY2RFVJY3kvekU4NnNPR0xLcURCbE94azRsamxCSDgw?=
 =?utf-8?B?bEYvY3U1TmFlUjR1WS9HN2lQeTRWMXBCVUUwamRaaU9seVUrR2hyTUNQeENm?=
 =?utf-8?B?dlI3ZE5ITGthV05Qa0JwQ3lyT1N3WmdZWUZHL0VVNlBnRDNYYldVQnRFTzRF?=
 =?utf-8?B?SnB6UitzTnVDamcyeis3dnBHeGJILzRnckdTd2FHaEhCUEI1WUtvaTNNRTRC?=
 =?utf-8?B?dEdWalIwMGhZc2lOSXBWdkROQ3FyOHZBejFtWjFTMnFxRlZwL1I4MThqQzNI?=
 =?utf-8?B?dWk2N1FyRFA2ZWtpdWl2OHZUTkVKRlcrenI2cWpsOGd2cjJoamk2OU5tUkxT?=
 =?utf-8?B?NXVxbVdPY0p2Q1NxWWVyd1UvTUgwSWNleVRFckQvZE1hVlA0anZ2Q1l6OEZy?=
 =?utf-8?B?R2p6TUxUWW5pbjhscWRHNnVnUWNSR09JMjNKRGNhTitQcVVRMkdGNGUwaTlI?=
 =?utf-8?B?ajlFemRQbkF5ZEEzRWNtZkRkR2FnPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4225fa9-6383-43b9-8a50-08dc384a3496
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 10:44:14.2437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwT1KYVG0+Rd8JjKv7wr8cRWEknfmNRuvsziOQfnk3khQyrr5bqChbiER4yOfLPSNjjTCWps+jwzkTQMlLlfAU6SV6lQ7K8EB0nf39lecV/6umT64qSi2qDaSW5ZHJwI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6967

Hi Heiko,

On 2/27/24 17:46, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> Add binding for the Tiger Q7 SoM when used in conjunction with the Haikou
> baseboard.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin

