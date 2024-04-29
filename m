Return-Path: <linux-kernel+bounces-162645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E416E8B5E83
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A206E281A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707A6839FF;
	Mon, 29 Apr 2024 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oM72ZrcQ"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5882E82D62
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406587; cv=fail; b=gpzDlqa74JpyKaYhiX4heIt0cLAIbavqx2LFg7FkZMVsQOiTQyjFHpFNXKv/c6EhIaKH/8Krj8J484jUzu7pnd8KM6oMlTJ1hxNMkUzyXGUCjuYqgBXFBgWwTaJe0c2jOV+IKxAI93DEv7cMeZXRr2nr9393NkN+URF3KO98Wvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406587; c=relaxed/simple;
	bh=7Ycy26uugWlIGe5iHEQSNnL81Pt1T6dOPfKDe/9z0ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HO9jQEOTff5gNtw/gYwHdA3rHoz4/+kGSrTHhc7vwrETgFOB+D/ucUfkdyG+c99RkWNy7g5aCkzBDQFkLxGuJLudQIeaiA5ei7XPO6arOgeTnbKZ2ofNhigioINJg3rscPRR1Nm/OCKYoVnB721SL9GiL6kaeWnUhssSi1qC/PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oM72ZrcQ; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M19lJPSU+vJZv1cQySC518EkwCSVIakzGuJKXRd9OqsLNYHlXT/btNolgmmn36JOowBy4gr2qQ2QfVzsqIVQQtK7/jgEVV6tgMn+ET5ckunSxAZxCBx1tcW0roNZ8jHLAsnTRTfj/VJAiSdWij3phR/JNfmHNBa5xXChKaE/SMinVQMcYcOExaJMmZjuVE0XR3sxGIoNvs6U9tlSBhTXzfmQBnFAyU+2WIEl/DM1QJUGfRqMojLvev+5emYjDxZ3mD+j44ur4by4vLKWDjm/4A9/XBtVQdNcS7OlrwUgAdjVMm4zQ2Nvu9UP2YvYZj0AZh1NGSJS/YIjgrfWwgttTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2Mqtq98m0AZe4K3ukJokdP+v9UKpun2somdENiMv1s=;
 b=Ykiz+N505tDTDaMWQn4492GwpvSwAlzMutY3FXBOwPaDhgwrluydsrECkBVCc4GbNoT9oRfoGMdPjrecmJBJ+7ypCN+1yDcoiAvl7oA4/0O2Dbdf96wQb/HSrcAw7qvGW9SUE/srEQQJ9SqXK2k+UZm1iHapPIyambaBEfSzq2gsxrGnW7MsbEPjEYd6Ao5gzbnLg8Til1QzdAlFB1A4+iXA7QLIVkjvpEdJWIZNaqPwor6bPwdL4WdefSAdD96wPRdhxGtOR9NaBFC822EVa8BJGpGstK4ar83QhzaftfWliKp5kSSyjOfVqkIUkhIRwBPfNhttzQyteIZJTh1e0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2Mqtq98m0AZe4K3ukJokdP+v9UKpun2somdENiMv1s=;
 b=oM72ZrcQFS98rp5mZntogb7FvclWZzL84uCvnblipwgtQTzDlp2mtvPSGF5OtwH8QI/DwxaISI4A3/+yDHNujYxO58aJVh469L9dL7QiozFf/ZExdSyOj2QgVZ58VxTCMGejxZRzbs58hFTXAREla8eVf70DBjJN5pwayPPUoTUiMskTuL8v1Zw4LiKCg/sqwNo2mhiukSkd0+C3oQJpwQh9+ZjaM99EPcYCootI1IExN+IgcnSJqtcGoy4M3LZbkjrU1nWlUeoL++GQ/6oTFzt70g/Xw78btd8x7CY8MrADB47xBhQBXPqkjhiB03N7npOHP0htEkEmCfchn4TdGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 16:03:02 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 16:03:02 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <zi.yan@cs.rutgers.edu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
Date: Mon, 29 Apr 2024 12:02:59 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <FF2DE3E1-0A11-4DAC-9176-969B7DCAE3A1@nvidia.com>
In-Reply-To: <99384a25-9ff5-43c9-b09d-5a048c456d02@arm.com>
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
 <17956e0f-1101-42d7-9cba-87e196312484@nvidia.com>
 <2C9D897B-0E96-42F0-B3C4-9926E6DF5F4B@nvidia.com>
 <328b2b69-e4ab-4a00-9137-1f7c3dc2d195@nvidia.com>
 <23fbca83-a175-4d5a-8cf7-ed54c1830d37@arm.com>
 <64037B35-3E80-4367-BA0B-334356373A78@nvidia.com>
 <99384a25-9ff5-43c9-b09d-5a048c456d02@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_CEEAA46B-5331-4857-9DF4-263C6FE31C93_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:208:234::13) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b2216dc-8a89-42b8-7070-08dc6865d8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1lIZ1hnczhNUlNVT2NHMlJkdVE2QW9DaUJuWSsrUFJrQklXRzNGZ3BzZnlt?=
 =?utf-8?B?MUQ4YmVTVGlNTVg3Q21kZEk2UXJCaWo3SHJWTFhTNTQzeTBUNkVPbmlOYXgy?=
 =?utf-8?B?UnJVck5zUlZ4VEZld0txajNkazVldzBqRTFxRDY4a1A1N3lEVTVDWlQ3OE1C?=
 =?utf-8?B?OFdMYS96VmZUMEVvM25FZExabFJDTmJZOWdXaDFTMWQvcjV2THFFQWZOaGJM?=
 =?utf-8?B?d3RXcGpCUTVCRDdacmpzVStSVHc4L1hxaTZnZnRoSHhwZEdqZ1lLK0I2bUVj?=
 =?utf-8?B?S2J1YU9pbHJXZ2UyRmUrM0xybGR3bXBCMXgyd0VFbVNMaGN6TnBOb3BodlRT?=
 =?utf-8?B?bUhuTUM5MHppNGhUblpXTXJzczlWZmtYeVU3UWgvZS9mdUQ1ZFpkSDFMaUE1?=
 =?utf-8?B?YTlnWkZtRmczenFTbXdML0NmNDg2UzQrQjYvS0RldmcydzNDSVNCeVY4Y0kz?=
 =?utf-8?B?dzZPTU16OVM1dE9IZUZ6akhpTEtHQlUwT2xZUEZ3RHEzZVlBK0pBRk9Fb0d5?=
 =?utf-8?B?dytldFhFODFQclB5MWdFTnhibzhEN0Y3MXFpM00yUGI5cTdrbVRkaHR2SzhB?=
 =?utf-8?B?QkN2TzNwMi82Z1M2OU0yeVZ6VU9lQy9NbUhTMFZhMUk0b3ROZzZJTWtSVkFI?=
 =?utf-8?B?bFNvbUxmOFdjdDJGVDZGSG9lU3F0MlZWRUwxcGIxVlZTSTI1bzhwNzhkYnBz?=
 =?utf-8?B?M3Fua3dFWC8yaXBPWU1Za3VCVHBkcmNxdDhwSmJlaDd0TDJlYVYwNkRETXZV?=
 =?utf-8?B?TDE5WUJUS1UrSzR3b0d5WTdRRmx1YlZuVFozSTdvcEZmZUtxKzBNQU9ZMnJI?=
 =?utf-8?B?WDgvSXY0SllKRW9TbEFvVUx5cU1mOUVyRlBMWGtXY3ZrMkhCSGhpS3hzN09n?=
 =?utf-8?B?ZDNIUmZ4cEY4MllVV3VtNVl1b0ROcWpOS0tLSXFjZWtFOTBLdURaOFRyUy9S?=
 =?utf-8?B?TWwzRFNZTncxWnJTdkJBck54VVM1S2JJRzJaNDEwSUVNSm5SVUFQdHRBUi9D?=
 =?utf-8?B?OVNZK3JOMy9uYnJzWGQ3bkNvNW1sOFoxMGludy9RQWs2cWhlVWt1aGxXalBF?=
 =?utf-8?B?UzRuRm9NOGg1UTY2WUJOSjdpYUpFQmNCdjdOcXJ4a0t4TlJPY29zSStjOVNj?=
 =?utf-8?B?RC93MURBeWFxYnZGR2tndkwxbkNQZlNQRHoyVHZzV3M0V00xeXpsaTlnTUZF?=
 =?utf-8?B?RUFhODR6OXlKb3NzNS9pSGwvL0V0Q2grUFFIUUpoSVo2NXhPeHhVTGlzVUtM?=
 =?utf-8?B?TmZJN0ZYS0Y5OEdEMHdyK1p2LzduMGRodkQrTlF6MWQ5dXBRNThDR2pRTUVY?=
 =?utf-8?B?clpGZFoxd1VKMFQwd2hOcHkwcFNudVVpTlhNTEhON29HOVdKUTRRRkVBTGFM?=
 =?utf-8?B?OTAvN0xUdjdsVGZzbk5TSXFuRE5tNnorTUs5WXhyOWZBanE4ajQxcEZzL2Vi?=
 =?utf-8?B?eExWQ24yQjhnQ1pLRTRyc2REZU1LbGZpZ3djK1M5TGR6ckE1Q2dlaGRDNFQw?=
 =?utf-8?B?TWJtTTZ1bUtyYzgwTmpaK3hhdXBGeVlIQ3R3b29kYjYwa1BlekxoTlRPMU5Q?=
 =?utf-8?B?aUlUTGRuMFc3RFl1RWF4cjNJOUJZandjUVVzVnc5dkJxQVZCRlR2M3oyNWpW?=
 =?utf-8?B?UXYySTVpSTFwZElpVlRmRGJxem5YSWI5ZC9VMFV0bkZIRVNnNHNMejg0TjBt?=
 =?utf-8?B?bTFHblo2N0VlZ2VLTjNsK3YreEVZM2hLVzlSK2RjSHNTR2IzV1o3RE1nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEdoS01PSGhISkxwR0V2VnVLN21YengxcXhDU1BIOFl4RFJiUDVUZXNJWmxF?=
 =?utf-8?B?SlYxQlh2Ni9JN3cxL0NnVmdQSDJYangxTHArTTRTTE5WbEJvL1R3Rkd5b21J?=
 =?utf-8?B?YlBrVzVaT1Jlb1NKdTNIckZISmhsNTAwaDZoZytnRzdzb3hsaUVNV0pJWmFt?=
 =?utf-8?B?K0hHYzRPWkw2R2gyTkRNYjkwZFdRWlFsMTNEc2sxc1lwVjFObTVsalZ3Q1dU?=
 =?utf-8?B?enhUR3B0eXZRUUY1N0JaV1EyeXV4MDRhdlhrYU5rNWlybE0zV281NFlJSWE5?=
 =?utf-8?B?UVZJZTV0UFlNTE9hQ0xST3I5VVIwOW9la2c0THYwY0xxckZ2bmdxV0d3V2ZG?=
 =?utf-8?B?S1NJT2NuTk8yYVR1ZmFLU1NJVjBEaS9mUmtQSEdWMXkzSS9NNncybnBqTWxN?=
 =?utf-8?B?TFpxdkw4L0FqMDFuSFMzczVISFNmL3o3bEQvcEVxZER0Rzk4UHpVNzVCTjJW?=
 =?utf-8?B?T2RGc3N2cFJvYkRSODBoYmtCaTRTejNyOFNIbEdqcUZJZWpWZS9LWEtBTmIv?=
 =?utf-8?B?NEpEUElJQkJld1dIb0trYmZuUFJiNVlVVy8raDc5QzlLL1gwQjBMS2hrZkFz?=
 =?utf-8?B?TStKc3FEYnQ2RmFmZzloL2IyNkxBQWVKWEJPWDd1dmlUL2lSM25NdFE0dkVz?=
 =?utf-8?B?eWdsRGxwUTFudjhFSVBwdFpMN0dDWWZ3eHFlbUthbXBEMk1semtaWU5xSnNi?=
 =?utf-8?B?bEZRNmtScklrZENtYXdUV1lzdE9BZFVsaVJuMkVJUUI0T0kwU01pUWovL1BZ?=
 =?utf-8?B?N2pwNjMwTkFtWTFmR0wrL3ZSeDBmZ0dwZ1pKbXBFV09Vam5TTzMrWXRaZkpJ?=
 =?utf-8?B?bHdaR0pIek16RmFDNy9vditvZmk5VWxUQkJJSGlyR2x3TmhsRHAyK2thaW5P?=
 =?utf-8?B?cmRIZVd2Vm5RUHpndDd3RTlQcUtyL0NMRHZsdTltYmlwUm9rZnZrSDhXSzRn?=
 =?utf-8?B?YmpmRW95R1llR2VURXhPL01iSlY4QlhYZzFPakxoY1o1dlVmOWdZZy9ndGtX?=
 =?utf-8?B?VngxdmE3TXR3VlUzdnNlS1Z4dlNxRlNycTJ4SG9CTlU2VkQrcVRkR0lHNFNQ?=
 =?utf-8?B?VlNuOXJwK2U4NUZzNk54cHQzNEhvWWg2aXZMVE5aK2treHJRNlJISHM2ZmRP?=
 =?utf-8?B?eXgzZFlVamhWRjRDOVJ0QXlPU1IvbVROVTdwV0hWcThTSmdvTFhwVEpHOG54?=
 =?utf-8?B?UVZLenlSanJ2RkxoT1ZqTlUyYXRwWGFKRitUZWx1VGhkeTFTbDE5RmdNUkg5?=
 =?utf-8?B?N0J0UXlseCtyRmM5RDhJSmQ5aS9GamkzV1VVRDdlMzg3WHVORzBlOTd0Mzl3?=
 =?utf-8?B?ZkZ5OG10NW1wb1FCaDFOTVZXczN1T1kzNGU1bWprUGpNV2d1Wk8zQzZvckFi?=
 =?utf-8?B?ZUQzZVAzOFlVYm12S3VFTUpUaG1WbzdpQm1oZWtEY2d0aDRxeDFCZUhoam9E?=
 =?utf-8?B?MWwrUDFiRjJjejBPQnlOdzlOSUtPU3pSWnFZYWpuVjYyUEQ2NXFEcE0rOEFH?=
 =?utf-8?B?UFFHYWV6Y0J3VURLdHNnY3BPNm53bEVxOTI5NTFjWHRlQ2N2ekJ2Smt5aGQ3?=
 =?utf-8?B?Uzd0a0VwZnRjK1JmOUxHVkJVK0tURS9PSE5QK1pra0xPaXdjNFVMazNidHNh?=
 =?utf-8?B?Tmk2MnZYMEVPQjA2LzFqVk4xRVFQSXR0YUZnMitpN1U4UGJkclgydGFzbkYw?=
 =?utf-8?B?d25NWFhVUWRrdThhQ2NrSGpJNFJLZFBjM0RuWnVESDlrdEdZNXhOUGd1MXFK?=
 =?utf-8?B?cGttcTZFN0MvVUo2YytFNFNzNFBSMFdJa05hU1NXUXJ4UWdBeVF0ZkVGOG41?=
 =?utf-8?B?bDdsZmNVQ01uUEY4MytheHo1RC93SnVrc2daVVAwcmFGN2RZY0VDb0ttRyt3?=
 =?utf-8?B?VWtrZTFDSUFqbHp6WmNhMTkzSFhrWTRXQkdnY2JLRjlSQlFFZy9mdzB2R1BX?=
 =?utf-8?B?N0R3TzZOVGM5Q0E5aXJYeCtlcEN5R1RwRUtHZnRPSVUyRGFvZFlvM0lZSCt0?=
 =?utf-8?B?ZHpKRXFEVW80UGZQOWxGTXZUSUVDcUtidHlsQW5pTXQ1bUNBdWZXYUlQWUdz?=
 =?utf-8?B?RlRsRmZVOWxINW55Wk5zUHY1STh0dVBiZEJzRmJtU1R3MHV6eFBHWFJ5ZGQ4?=
 =?utf-8?Q?uiLRWPlpun0edsGVdZCmYUcO2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2216dc-8a89-42b8-7070-08dc6865d8c7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 16:03:01.9628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kco58AuorVnU2j2grwyjirz7xmSmH8SN4r+UHOhGXmOhKo/eoYNRXzCSmqCnyYVi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008

--=_MailMate_CEEAA46B-5331-4857-9DF4-263C6FE31C93_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 29 Apr 2024, at 11:34, Ryan Roberts wrote:

> On 29/04/2024 15:45, Zi Yan wrote:
>> On 29 Apr 2024, at 5:29, Ryan Roberts wrote:
>>
>>> On 27/04/2024 20:11, John Hubbard wrote:
>>>> On 4/27/24 8:14 AM, Zi Yan wrote:
>>>>> On 27 Apr 2024, at 0:41, John Hubbard wrote:
>>>>>> On 4/25/24 10:07 AM, Ryan Roberts wrote:
>>>>>>> __split_huge_pmd_locked() can be called for a present THP, devmap=
 or
>>>>>>> (non-present) migration entry. It calls pmdp_invalidate()
>>>>>>> unconditionally on the pmdp and only determines if it is present =
or not
>>>>>>> based on the returned old pmd. This is a problem for the migratio=
n entry
>>>>>>> case because pmd_mkinvalid(), called by pmdp_invalidate() must on=
ly be
>>>>>>> called for a present pmd.
>>>>>>>
>>>>>>> On arm64 at least, pmd_mkinvalid() will mark the pmd such that an=
y
>>>>>>> future call to pmd_present() will return true. And therefore any
>>>>>>> lockless pgtable walker could see the migration entry pmd in this=
 state
>>>>>>> and start interpretting the fields as if it were present, leading=
 to
>>>>>>> BadThings (TM). GUP-fast appears to be one such lockless pgtable =
walker.
>>>>>>> I suspect the same is possible on other architectures.
>>>>>>>
>>>>>>> Fix this by only calling pmdp_invalidate() for a present pmd. And=
 for
>>>>>>
>>>>>> Yes, this seems like a good design decision (after reading through=
 the
>>>>>> discussion that you all had in the other threads).
>>>>>
>>>>> This will only be good for arm64 and does not prevent other arch de=
velopers
>>>>> to write code breaking arm64, since only arm64's pmd_mkinvalid() ca=
n turn
>>>>> a swap entry to a pmd_present() entry.
>>>>
>>>> Well, let's characterize it in a bit more detail, then:
>>>
>>> Hi All,
>>>
>>> Thanks for all the feedback! I had thought that this patch would be e=
ntirely
>>> uncontraversial - obviously I was wrong :)
>>>
>>> I've read all the emails, and trying to summarize a way forward here.=
=2E.
>>>
>>>>
>>>> 1) This patch will make things better for arm64. That's important!
>>>>
>>>> 2) Equally important, this patch does not make anything worse for
>>>> =C2=A0=C2=A0 other CPU arches.
>>>>
>>>> 3) This patch represents a new design constraint on the CPU arch
>>>> =C2=A0=C2=A0 layer, and thus requires documentation and whatever enf=
orcement
>>>> =C2=A0=C2=A0 we can provide, in order to keep future code out of tro=
uble.
>>>
>>> I know its only semantics, but I don't view this as a new design cons=
traint. I
>>> see it as an existing constraint that was previously being violated, =
and this
>>> patch aims to fix that. The generic version of pmdp_invalidate() unco=
nditionally
>>> does a tlb invalidation on the address range covered by the pmd. That=
 makes no
>>> sense unless the pmd was previously present. So my conclusion is that=
 the
>>> function only expects to be called for present pmds.
>>>
>>> Additionally Documentation/mm/arch_pgtable_helpers.rst already says t=
his:
>>>
>>> "
>>> | pmd_mkinvalid             | Invalidates a mapped PMD [1]           =
          |
>>> "
>>>
>>> I read "mapped" to be a synonym for "present". So I think its already=

>>> documented. Happy to explcitly change "mapped" to "present" though, i=
f it helps?
>>>
>>> Finally, [1] which is linked from Documentation/mm/arch_pgtable_helpe=
rs.rst,
>>> also implies this constraint, although it doesn't explicitly say it.
>>>
>>> [1] https://lore.kernel.org/linux-mm/20181017020930.GN30832@redhat.co=
m/
>>>
>>>>
>>>> 3.a) See the VM_WARN_ON() hunks below.
>>>
>>> It sounds like everybody would be happy if I sprinkle these into the =
arches that
>>> override pmdp_invalidate[_ad]()? There are 3 arches that have their o=
wn version
>>> of pmdp_invalidate(); powerpc, s390 and sparc. And 1 that has its own=
 version of
>>> pmdp_invalidate_ad(); x86. I'll add them in all of those.
>>>
>>> I'll use VM_WARN_ON_ONCE() as suggested by John.
>>>
>>> I'd rather not put it directly into pmd_mkinvalid() since that would =
set a
>>> precedent for adding them absolutely everywhere. (e.g. pte_mkdirty(),=
 ...).
>>
>> I understand your concern here. I assume you also understand the poten=
tial issue
>> with this, namely it does not prevent one from using pmd_mkinvalid() i=
mproperly
>> and causing a bug and the bug might only appear on arm64.
>
> Are you saying that arm64 is the *only* arch where pmd_mkinvalid() can =
turn a
> swap pte into a present pte? I hadn't appreciated that; in your first r=
eply to

Yes.

> this patch you said "I notice that x86, risc-v, mips behave the same" -=
 I
> thought you were saying they behaved the same as arm64, but on re-readi=
ng, I
> think I've taken that out of context.
>
> But in spite of that, it still remains my view that making arm64's
> pmd_mkinvalid() robust to non-present ptes is not the right fix - or at=
 least
> not sufficient on its own. That change on its own would still result in=
 issuing
> a TLBI for the non-present pte from pmdp_invalidate(). That's not a cor=
rectness
> issue, but certainly could be a performance concern.

I agree with you that using pmd_mkinvalid() on non-presenet entries does =
not make
sense, but there is no easy way of enforcing it to prevent anyone doing t=
hat. And
if people do it and they are not working or testing on arm64, they can br=
eak arm64
without noticing it. It becomes arm64's burden to watch out for this pote=
ntial
break all the time.

Yes, TLB invalidation should be avoided in pmdp_invalidate() to recover p=
erformance
loss. It is a separate issue from the pmd_mkinvalid() correction issue. T=
hank you
for pointing this out explicitly.

>
> I think its much better to have the design constraint that pmd_mkinvali=
d(),
> pmdp_invalidate() and pmdp_invalidate_ad() can only be called for prese=
nt ptes.
> And I think the combination of WARNs and docs that we've discussed shou=
ld be
> enough to allay your concerns about introduction of arm64-specific bugs=
=2E

Yes. I also understand that putting a WARN in pmd_mkinvalid() might not b=
e desirable.

>
>>
>>>
>>>>
>>>> 3.b) I like the new design constraint, because it is reasonable and
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 clearly understandable: don't invalidate a =
non-present page
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 table entry.
>>>>
>>>> I do wonder if there is somewhere else that this should be documente=
d?
>>>
>>> If I change:
>>>
>>> "
>>> | pmd_mkinvalid             | Invalidates a mapped PMD [1]           =
          |
>>> "
>>>
>>> To:
>>>
>>> "
>>> | pmd_mkinvalid             | Invalidates a present PMD; do not call =
for       |
>>> |                             non-present pmd [1]                    =
          |
>>> "
>>>
>>> Is that sufficient? (I'll do the same for pud_mkinvalid() too.
>>
>> Sounds good to me.
>>
>> Also, if you move pmdp_invalidate(), please move the big comment with =
it to
>> avoid confusion. Thanks.
>
> Yes good spot, I'll move it.
>
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_CEEAA46B-5331-4857-9DF4-263C6FE31C93_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYvxLMPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUZkgQAKPohuRh2FC1Jjftnh86DhRQy04nN5Ygobeq
fkNI7ztVfZIJjGG9AORdK4R1pqEW2hqguZnCPjjr++a7fqMvgxmozNEHrRaa1ER8
46ijqjkCcX5Jm5hi9mNgqHO59grQBRliEKiIyTRksrPLQ5iKmjzKf/p6bCCMvME5
tyQuB5lK0JbingO5HWyo2JMXJbjIv5GSHsfZrNHCx7c1KHMHWYOd8q4YT1o/SgJf
EJcx0ShvmrKP/j3R25Yn0vnhDmx6BC1Gm3LIZ0Dh6B7cj/v+x5AbXYkLzgI4FzwO
LTqU2P0cCGjsjGEqaUXqYYLS/x0qy5cenWno66DrhDfJx3ioc/6rGhymXqIlbCkF
JFedflyiy4YZwthRGV5tFtt6GnxYJAE8Dp8W2xYJj7akRtn4W/8pkjlv4S0Zg4I4
IWT9Y8reSvobfIsOk3Jr+k4p4TH8onILhslsGMt5YIzRGs1mwSBxaYIq8gid484J
BnwRKYYJ20bdCvDgapYLScaw3gQHuIfpohuuhHrlsLHDTvX7uGf9UCvpk3+OmhU0
fj+T9kAKYzjkevUwHyUyZ3u+kLg7j2cdT4Gog5hlSbgykxwMEUJKDAl00v4OxNu8
AiJwFu7+nmc/26NcYzlxg9sIRPlJUn4bkO14OofQJnB+oDXk+/jTpHkSlknaIEFX
g3jFX+AL
=lLXt
-----END PGP SIGNATURE-----

--=_MailMate_CEEAA46B-5331-4857-9DF4-263C6FE31C93_=--

