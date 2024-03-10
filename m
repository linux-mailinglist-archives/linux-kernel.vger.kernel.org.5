Return-Path: <linux-kernel+bounces-98078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6238774C8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 02:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2152BB20E25
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 01:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FF21102;
	Sun, 10 Mar 2024 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BvrBEEYR"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2018.outbound.protection.outlook.com [40.92.103.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F935A3D;
	Sun, 10 Mar 2024 01:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710034120; cv=fail; b=MztnVTfRGLEZoH1EHP4G6Zh2sbtctix+PsJMV2QKEuXOXNDjE3LF45ODxV6aK+J3TXYGwVt+65FTgjjU1KPDTN8GcJtCS/zrM62bB7GCvN0eBJXxJID+5cNuHiyair6Glzo0w7s4q9HS+c3+WYnJo3A1NQIy6u9fpt5OHHYbkLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710034120; c=relaxed/simple;
	bh=3Rsv84CeNI9Pa0gyOgOt852LsxFS1qmw6Too6XFhGvY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dIMrGXvdwxXai7wZqnPcbSXEX0DqOHtXsJF4Y6ZoCL7JQck6JQvqrEkHbAnQw1s/et6p1lVE0B+H6nVSlcx1usto7Pqeyt9baE1waKGUNC3wNa2Ys6HuEN5/8qC9L+CTKnlO+ukvwtiBLhj5JwNUpCTDSK/CdcMJezcrmqEdack=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BvrBEEYR; arc=fail smtp.client-ip=40.92.103.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPRxi2WXYjuYHneeJ4CMVnO7P1LsDU2TT/BhDwAr3WWOuHN2ekiSObcN5jdtF8PMd6hiP8IH4yl0FsaFmCSJGfOQYKFUvM8fpYPW7U4Xwawp675yljt0DnxmIrGoI7tkI++BA+H5QsBufwtXnbS0wcOJ9RJILg3LpDw9jqljyy2Ktea0YcktStA+hzVYITVoB9Th6jz2sw2EoXp1x9p9acgavOD06dLoYKapIzH+QZqTenRScMJMbe58KcCGWnph9pUIuz1fAPhYhkBYVuNAD5vVKddtfGnPxu+RRmC/yhtUKdZ6OPVE4Pch9WSzAcO0dt7+Rk+6RDy4NHKz1Q7YSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unwKB+ApOlk/LurKUV01ETkGXytqqN8x6Ibxt+bEHgo=;
 b=hHHpuXwgWlFA5iWv85ner3DslD/zkj5ZE1p3FKt7jku5/Q8azG8EzCQWu59ETX4eME7OR4JakYkY3Do1QZeRMSaTOndVA1vkylQg/ZvHaphaFhIYTxwAMY8jefuASfAR9XJozd6s9aivsqWnb/Qr0um1yq/LxltrKRK+IAXcCPQ5TKgVUxy7oHRoSbk/hHiaj66EjOpB2aXpHINXuJHSMm5MI7t3V8Hj2vMS6ZkVcjTkBq5ifDQQlErg4/liPLJU+Gst44JoMG1dsBS+pevcr83qTfBYHOMfiroXDE3bJP5LoBFWaN5MoqOKaG18ENtUCFsUFIQZ3aH+UcFStCGBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unwKB+ApOlk/LurKUV01ETkGXytqqN8x6Ibxt+bEHgo=;
 b=BvrBEEYRFf3upNxDetg/zZSzbhncf2C1TSmVhXJ9f60ckoEgNJUxK0J5ButD5Q3ZRAegDyJSB0rh63ZPJa3Y866WviztcPHaRo67bT2sMo5qx2SBCet7CG7VD0427sBrvEv2AMiiY7vUk2HQzL7WpkTnWoMSnNzeEFpERpELIa2UjAt96k7oecb+J702cyA5lPl8zDJaQ88gx03fOmrTmOLAtIeQFJlMXDivOlxp1A+ALzxrfR+DPpIdWlY8q4rMKbcES0NjqJR0/RDzQQV/s0JdzvLGTxxMr8dsERG8pOlgzoIl0wfT7/+o9vdBO5N1DkiLTN5VaM8ugbtKtmp3Wg==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB2059.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Sun, 10 Mar
 2024 01:28:29 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::7397:fc50:6da4:7328]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::7397:fc50:6da4:7328%7]) with mapi id 15.20.7362.031; Sun, 10 Mar 2024
 01:28:29 +0000
Message-ID:
 <MA0P287MB2822F618BC80219AF15358A2FE252@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Sun, 10 Mar 2024 09:28:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/5] dt-bindings: clock: sophgo: add RP gate clocks
 for SG2042
To: Stephen Boyd <sboyd@kernel.org>, Chen Wang <unicornxw@gmail.com>,
 aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
 devicetree@vger.kernel.org, guoren@kernel.org, haijiao.liu@sophgo.com,
 inochiama@outlook.com, jszhang@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 richardcochran@gmail.com, robh+dt@kernel.org, samuel.holland@sifive.com,
 xiaoguang.xing@sophgo.com
References: <cover.1708397315.git.unicorn_wang@outlook.com>
 <49faf8ff209673e27338d4b83948ade86b3c66e4.1708397315.git.unicorn_wang@outlook.com>
 <066c6fa4b537561ae6b20388a5497d9e.sboyd@kernel.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <066c6fa4b537561ae6b20388a5497d9e.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [TK0ap0Ci9p/YhxBGnnsB4bVGg0bkscQn]
X-ClientProxiedBy: SGAP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::17)
 To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <17b0fb41-35f9-475e-996e-40ec9c4717b1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB2059:EE_
X-MS-Office365-Filtering-Correlation-Id: a789eb73-156e-497b-e377-08dc40a16288
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	epuNRpP8eWCQFL5zb41LjnJ5xqYUsOges9/3TOpb3gDxshBVbHgRHDmWUej+SJ+Tp0ZnuX6qZ7OVkliWrNi15aJlVHDhEGx4ohfjvoBjWECOjkDjmkUWrOsjozy02YLuawME2kgZAIRze2NaTAl1kK3AOUETaHXhV/9Bbd+IoHlo9SSSQyuLNeL06PCPOltfmmXZfXb53VKra6PZsSayvYmDmEtalD/OP7vBNtT8SCOapy4DvofT1aFU+C87464W8J0SbVY+du1YKDBm7CR0Ik2Wm+1ZCsB0rYJlmVgd164MEIBmnGlqvpTU1InH+erbWP22jdcD1WG8fHZhx1kgO3HdGFXW4CTOxsswweZkIKCZFtOh4Kmz1TQuxyAXhk3mAZNMmHH3ztdbNWQONL3N4r1untG4PLFoFDFbXxBv8BNDFA4UvILnMFb7L5BUgUmjB2Cc0jn3XidI1TWDvuj4+nzFXpZw5hB5OXdEMvOkwmuQiBQ8NPONkbT9knuKe/uinbwOsuphBP9JzXfa/kywy3utPlJUNoKUeTPwp2nepyvVsgGNYBPVR5DOLFBnDPMI
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0Nrc3Q2UDhEbXRJcXlSSjRhV1gxV3dWMmVjOWRzOHM5cllyM2xSZDZrVFJp?=
 =?utf-8?B?VnFDSCtvWWJTd2wrZlorZGpXTG41ZUJJZVZPYWRuUTVXaVJ4TXNtazRiaTZk?=
 =?utf-8?B?VC8yOEdUb1FuVzJGbXh1SnpWY1F4emZod2lBaUVGUkRtZVFHaHJkcHlybkRv?=
 =?utf-8?B?N2MzZ3ZMVldhSEpza1BwejluRUpZdENYVitVWHFMTWsxcUpQRi9rcUtwT0Fw?=
 =?utf-8?B?VmhpcUIzcWJLYkFoVVRkdHJRUFRZSUtOU3NGU2NydlJMMzlCK0VRdTU5S2Er?=
 =?utf-8?B?NHhKNXRSU05lWFN1a3A3bm5pMkdrWHlQcmpKd2dlWWw2VVZqVXovR1VOSmhx?=
 =?utf-8?B?bkJDdDJQdkZRcWN0d29qdFUrNHR0QU9EbXZIMytERHRQdmhnNUd2YW9HRk9X?=
 =?utf-8?B?RzdLeEJYdVdnRzRTcVBQQkwrNUR5ZUZPTVN6clFvSFZRWFBRM0kwbXczN2VV?=
 =?utf-8?B?VHpZalAzZGJHQ2dmWDFuTUNrTW9DeU15YzlhTURaU1A3M2ZKUUVLN1U5L0s1?=
 =?utf-8?B?VDF6akVmYTQ1K2xXQkQ3U0NrbGV5dUdvaWpCa3ZjUk5HN25jNnc3Z1FVQ1I4?=
 =?utf-8?B?ZU5SeVY0TzdoM1N3UStjVjc4aHpqRk9ZWjRmWkhYZTRiK1hxN2tLeXBEOXJv?=
 =?utf-8?B?SDdhSktaY3REcmRHTnFhVkN0Sk5ENFVjM3p1NS9mdFl6bzNpbndPdlNVNEVx?=
 =?utf-8?B?MVQ4cEMrMTlIdFlNWG9zaXZEZE9LWG9iRGNjejRqTk54S1BxQ29yaEs0V0c1?=
 =?utf-8?B?RVY0SE5zVlNaUEp5SjhGMXVNVzhtTlhaeFlxbjRncGszWWkxZWxuVGN0M0I1?=
 =?utf-8?B?M1l5cFlEWmJHeHZiK0xkVWRpaFFTSTJ4dGlDT0U4UDNoa2UrTVU4UnExMGVl?=
 =?utf-8?B?bTlvVUZsdzQ2dkZyT0ZKVGtra0xUcCtPTlh0U0syRk1EMGExSzM4MWtpVkxD?=
 =?utf-8?B?ZnVXTmEzeG8wUGJ3U2ZQTGxIL01OdmEyUHlhaFplV0JHYXNLSkd6VzNZejZr?=
 =?utf-8?B?a0ZGczBoTFk5QlBuQWNUWjQ3VkxFZHluM3FFbisrTzUraHBmV0FXSXU4TTBw?=
 =?utf-8?B?VVZ4Z1pLd1g1UHUzN0dwdG1Xb1RWbjZCQXRvVTNrZVlxYnVDUURac3VkWnNI?=
 =?utf-8?B?bjBKeHNrbE1Uc0hYOUVNdDVGVXFnaVBBQVQ5L0VvdmlTbEhlNFA4MU56NHdL?=
 =?utf-8?B?SGNTMGlLcGxZSlFWRzEwSkxxczNRS29INE1UWnFmTUlsRm1TYXgxbDJKanU0?=
 =?utf-8?B?ZUxobGs2aitWUFEvLytET01aY0tjd2FjaElqbXV4eFJBYWdwdkRpL3Nua1VU?=
 =?utf-8?B?TkFsV1pzdUtiVk5mMldSRi90QnJUam5ya0NIZ2U3VG1ReXRCdXRYSFBOZ1oy?=
 =?utf-8?B?aWpLRkcrb3NiNSs4VDJiV2lkMUZSVmMvYXZyUzBYbGJKVDkrWFdCaXJTUXVt?=
 =?utf-8?B?WjZQME1aQ1gvNlNyL2h0VmcvQnYwUmZIMEpWdkdOTVBuOTR0MG5WK0RSUW11?=
 =?utf-8?B?TkpGd1dVQXNxVXV4alo2UHM5UEYxYkp1bGRVLzYwb3krUWtmR1dLYnFSRFR0?=
 =?utf-8?B?c29DNWN3V2E3Tmd5dWVyTmRMK1pCN1d2K25pVTJoQW1mTWhTZzh4MGh1ZCtO?=
 =?utf-8?B?Ry9pd2t4MkpzQTVjS1RDOVMzUVhPK1o3bUxwdXE5cXNzdmJqRklScDlkSVZh?=
 =?utf-8?Q?yL+luMSwYAhJ4WbHdj9z?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a789eb73-156e-497b-e377-08dc40a16288
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 01:28:28.3899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB2059


On 2024/3/9 10:15, Stephen Boyd wrote:
> Quoting Chen Wang (2024-02-19 19:08:59)
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - '#clock-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    clock-controller@10000000 {
> This is the same address as the pll binding before this. How does that
> work? It's the same register area as the pll node. The resulting DTB
> should only have one compatible for this node.

Hi, Stephen,

This is just examples in bindings file, it should be no problem. The 
resulting DTS/DTB will have different addresses.

And I see you mentined you have alreay applied this binding to clk-next 
in another email. right?

Thanks,

Chen

>
>> +      compatible = "sophgo,sg2042-rpgate";
>> +      reg = <0x10000000 0x10000>;
>> +      clocks = <&clkgen 85>;
>> +      #clock-cells = <1>;
>> +    };

