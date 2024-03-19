Return-Path: <linux-kernel+bounces-106868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D794587F4B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122CB1C2158E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BF5A29;
	Tue, 19 Mar 2024 00:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fe4grokg"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2100.outbound.protection.outlook.com [40.107.223.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC553D69;
	Tue, 19 Mar 2024 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710808804; cv=fail; b=EC3pngoDNwWWnhbjaUQ/xcIofsr4UYvx5vqGVpiTq7iFgFhvA2m1dzJ6KvZzBF3TsJPgm8R/fRSp5gKsYgzDbcu1JL6N5+xi/Hdl9PfzETwWmt64ZumMfOnaWCyeggtSC/FjlNrvn+FAvITp0yld+ihW1EU9IO+BwQnDytvsagw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710808804; c=relaxed/simple;
	bh=SxItKw6n2HbvXmCdnEuuBPO/QOsJqWeOnL+Q3AJRl0I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U5PYSRqVEUHl3qIE/QCNDNrGcqKtvO21WQA56Ajaw7nknz2sZN5WyvEjrHqLvOaKrrQxjoo9nXXuDZW6roRPviz9HUOD1V4sT1HQ8WAgYwYUGFQF/mee6hxG46nUEjGJZFzaNGAVEBO7pw1zMWw3WxYNxuzzSnVRoztgOfbtFCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fe4grokg; arc=fail smtp.client-ip=40.107.223.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFaSRIIU+VU0BTT/CuzR75HhMUuJDP0g8CIH+Fin1bOW0qFOg3BZira58vUUQB0IVMLHuY/6oOEduRm0/x/cLIuSpSYgzKZ96h4UDiVIlRqlf8cL0E+KotBwAnM10jFFj2iYj1QLn1JJK09HvZdpjXh3E45Il58jGi9srN5lwirmfrLT9lFiZRtYMiDla6T1X7u7U+QfU164hs45fqSLyUW2LBGQVzZmjTVD2KLFtRCEZD7JK3M7gqIsST8YtyrQTYU4WHQBetxIxeSSTLuPxMx+/CiFVRn0TGGZy8iOswSjpXC4uW9T9r8o+CQeUgy4kU/UpnGqC/ufyLxbaxQVwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vu5Y66atNVdZuesX/ozTf0VWFMfcao1ATyEOEQHDDNo=;
 b=SbeFhovUFXzEAWFCzl/S8E3n9NR8rJnzKM7ePHVPU9mkwuv91lmmsv2k4cS9DixV37uQsosGC9jTZu92dNpLT/s6WzAfLcYZeb10TopgcnlEZfIM2cd5lkA0bkFAKXTBPle+YuIX5gDVCo5scE6/4FEtDSkn9AI2ApzutgeWoJgVaYq2S34gB20O7heiCG9d+po7Upx6aBW7xCjd+O1/lETBPcGGfnpn2LCR6MScSLO4YBK7rkp50Ha00nAMDdlUy2EkhqKPol56LKCKJTH/IH8l+DHxei0puJFYvu+jSPnQyqM+HWq8HKDXiatLALCzaRNUIn3tbu2PLNQ4T9BAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vu5Y66atNVdZuesX/ozTf0VWFMfcao1ATyEOEQHDDNo=;
 b=Fe4grokgysFJl6AeUJqQ/fHMcrMJw2Ti7FeCPRphaImTojEMJDahhTIludWNS+KwqyiLzcMIAZ8yu+ds/S5hr3QkM4u16eVtHTERqhIK4uKzLLvVT7PicUlCqRBD+HyxLz5DBq6rMmDMgBii+cNJaK8BrKPQHcRAa0xL3A8qb3s=
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 00:39:59 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 00:39:59 +0000
Message-ID: <fe7f271c-1e16-4aff-8d72-4c9e9b2bc2b2@amd.com>
Date: Mon, 18 Mar 2024 19:39:56 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 1/3] dt-bindings: remoteproc: add Versal platform support
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 andersson@kernel.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240315211533.1996543-1-tanmay.shah@amd.com>
 <20240315211533.1996543-2-tanmay.shah@amd.com>
 <b81d86b4-eb3c-4996-bbe6-32a8bc1de028@linaro.org>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <b81d86b4-eb3c-4996-bbe6-32a8bc1de028@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:806:125::30) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DS7PR12MB6189:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	higlTmK10Yyi8BxWAXgW5QaLsIB4UN9bCOB5f0FtemfJBdvOlZTqdmrll/Sx2h/yz2TCDXADh516fStfiYgk/DlwMHeK1KqkytDofu/OWElL7A0yPjRtexY49qs/GVq4eiz5XLzPlmrPEJlNwe4n9uIrrZ7qMHEVs1afq9w/AYHBkGtqyXq1i/pO8pjMaYB0diSIGhLTJ4EBQxKBoZTnGF583CiRfAu2PjJeWgWs7Ftr1Kw4IUd0ix2jxZkumQOJGsQ7at9J3juEnCpJiF2I5lGwSftBVYlR9SU54MhTv2oj+8fjkni8YgXQf0/8JT0F5pM01ahcOFt8enGmOcOdWFNNCXkh1h9Al3HnrVGwHro+RnvcvDY3MGIsbHvhHdLkEdO6hT8uFFszmhpru777RKHjN2VycYOhFFX/k+o/RkWcJVk9heAcUin2MvuaA4sS53jBnOasf0wuP80yJ0z6kZZZ2AcYW7W+gSyWcfwSraGuHk0RcG7Ur9XU5/zNzLIt7/stuY6wqHj1nIEjhCjL9qe/sycW+YAhpCtq5X8CxzA/UxA10DRnk184w5qvWlWAQ3eYsJbuDGUhqfPuUbXmf835PyuTk35LiJfLt3yZ+kI88Wm4z2AaAYFCeDeD112fTq2CZhgYi2O+95qaiZMrAF/FQKC9pL2YMruRUHETZHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWFVeFBmZ0VteUt6VnphZmtxTElsbE5DOHZTVHVpa2ozeEZ0R0RFbzBSMXYr?=
 =?utf-8?B?VGhDS2lCOVpQZWYyWEx2QjBwVDVHMXZIbTJ1RjgxMEpMTWc5elB2ZitSb3JO?=
 =?utf-8?B?cUEwcHp3Z2hPSUVWUGF6UzFDanJVZHZBMXgzQyt1Z0srQkc2TFdQdHpSTDdN?=
 =?utf-8?B?VWVwdTN0QjRmcDBHZzFBUzdGSVRscHpRL0wrNmVjb3ZXc2NTNGlkYTZOWXUy?=
 =?utf-8?B?amhjNGlWVHJ6S3lOblg5amRaL0RjWWRucE0zMXMvNUlxUEY5YzBMbnNjM0JI?=
 =?utf-8?B?V1FRcVAxclU4WnUwQ01wenJ6dXRUeW5KTzg3SW9FZjljNFQ1RkJFSm8zNm1y?=
 =?utf-8?B?M2drWk5pS3p4RlVrNlFvMzM1ZG9CVnphdm02azdYQTI4djZJT3FxWHpUckJa?=
 =?utf-8?B?YWJEbmNPZ29VU0JTZ09MNHNhUVhxY013OEFZS25aZ3FOeHhQS3g2UCtCWHBS?=
 =?utf-8?B?L3hFY3MxT0VMOGJuUUdjR2YwUVV1Rjk1V2ZvTjVuZlc2ZzN0aFY2TFpjc1oz?=
 =?utf-8?B?L3JyanZIZ1lRZXJBM2VEZWhXSmxkaHMwUzZLbkpSR1dOaEtlVFdwOE5ZYzdm?=
 =?utf-8?B?R0YyMzVBSENuWS81V25DODBPVlpURXA3TTNIeGo5K1ZadmMySVBnNzVRZGdF?=
 =?utf-8?B?VTFPYnEyY0ZzTFEzeThQL09XY3h4U1YyY2lBQlY5bndjS0k4WWpBWVg0eHRu?=
 =?utf-8?B?MXVXNDBtdzJUUTRVU2hOTjR3b3FMT0VtWXZTbWsyWWp2UE9zY3piTTFqZUp2?=
 =?utf-8?B?MjRxZENJc0UwSzJTRnpER1VzS3hQQ0FvRHFBa1ZHSmtxcm9PaytqVnBTZW9T?=
 =?utf-8?B?REo1cnhQeW1ZcFc5ODZUSWFpWjFndTRuRHRVUVorcjlubEphZ01mbXoxYWlY?=
 =?utf-8?B?VUNzY0N4ZVd6K0FoeW03b0YwWE93RjkrdjFPQ3JnTnBVZ2tHdUxyM3h5YU5k?=
 =?utf-8?B?Mlk1MG1LN29OUFV3S01oOEQyNTFoSDdLS1M5enExWCtVc213K2p3NXppNEJF?=
 =?utf-8?B?L0tvQVp2aU5rNk1paXhVQmw0VHFSSWVhTFcvYTFxVmIrMGxsaXgvT3ZjTVRm?=
 =?utf-8?B?bkRHZFFyQm5VV0ZQYmNvS0MzTTR2TjJDQlVpeFQxdTVsZzZ5S3JlMFZFQ0VZ?=
 =?utf-8?B?NHRsYXBrQklLN1h6UTlJRGErV3hHOXhVVjFSU3RQemFYbmxaTEZDRmVQT0k3?=
 =?utf-8?B?bk9QMFZBVWpRZ2ZQS1FVSWg1bFlCR2hJZ1Zobzg5NDJSeVY1aWhRZ1VYRFdh?=
 =?utf-8?B?eWZiMkFiTDJiOUc5TmtlSXRNalV3cXo1S2RTRkE0SmdybzN2enBNdkhZck11?=
 =?utf-8?B?eUlKd09IWWN4Ulp2R2I0c0Q0Rm5aTlFpT3V4ZStsREUzTDJMUzhkbUlGTTE2?=
 =?utf-8?B?Q2Njbm42bUNYK3BKSGNHeUs5dmFsemZpU0J3UUQ2QzRncnR5cVN6N3owcUFl?=
 =?utf-8?B?RVlhY2NQZzVpaGNRQlU3R05SUm1McUdTTTRxT3ZwOHNyOTlTbkRHdEkraG9D?=
 =?utf-8?B?c05GTWMwVitFY0RlNVh3ZFZJTjE5YXVrcUtRUGErUVdCL2xaTGM3OG1CTGhi?=
 =?utf-8?B?RnovbG5qMmRycHEwWHZqN0Z1MGwwNW5EdHZmRDBhWWQydng0eEUwWUY0VWFN?=
 =?utf-8?B?RkpFWkdxL3VBTUNsZXBrbjdsbCtxZXNGajRGMmFKQnZJakU2KzRCY21DbCtE?=
 =?utf-8?B?cmpvZVJRMEduZWwvZ3NRUFVxalJoSjZ0U241MSt0Tm9SZ29KRk5pa1RVTkhv?=
 =?utf-8?B?ZTZSS21vQWtYRGs4L25mbHp1c1pxYWI4RTM2SXBneDBXZ0hxMnEwLzRSaVdG?=
 =?utf-8?B?cmNCY0JlV1hRVW1nVXZzS2xwaDJFcVB0YmZ6YXM4Z2o4TFFsakFxUnBFTHBC?=
 =?utf-8?B?VXZhT1IwMUsycThHWTB4YmxtOFVqWmZPSUxCRHRKSFZtNE8rQTFhVFVQcWU4?=
 =?utf-8?B?UDhEODFjdkNwUFhCOG5FUkxYSzh6eDRVdnlzMlBYV05ONVB5d2RwT094UENE?=
 =?utf-8?B?N1dFaC82SmZ1VHBHRVVuNFRyTkc2UGFxdW14MDdqKzdpVCs1K3YzcXU1cnZD?=
 =?utf-8?B?OEprdUxBWllNek0weVJibmpic3Jzc1ZqSnQ3U1FKUXl3SUx6M2RxUzQyYkI3?=
 =?utf-8?Q?4Z3V3CbxrPnEe2/ur35lKgk+9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f57223-58ea-4d50-7c18-08dc47ad1b2c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 00:39:59.1562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1IVlIQl3tCktj5Lkuoq3KY7XcnjS4LKnmwHTvcwSRZaZia23+MgZ9pc7p0JFxAs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189



On 3/17/24 1:50 PM, Krzysztof Kozlowski wrote:
> On 15/03/2024 22:15, Tanmay Shah wrote:
>> AMD-Xilinx Versal platform is successor of ZynqMP platform. Real-time
>> Processor Unit R5 cluster IP on Versal is same as of ZynqMP Platform.
>> Only difference is power-domains ID needed by power management firmware.
>> Hence, keeping the compatible property same as of zynqmp node.
>> 
>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> 
> There is no binding change, so NAK. Platform is not being added to
> examples. You changed nothing in  Versal support...

Thanks for reviews.

Okay got it. That means I don't really need to add anything related to Versal.
I will get rid of patch that says "Versal support". Looks like it's not needed
at all.

Thanks.

> 
> Best regards,
> Krzysztof
> 


