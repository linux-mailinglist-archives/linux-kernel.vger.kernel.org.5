Return-Path: <linux-kernel+bounces-156355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDF58B01B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D2C1F23887
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923B8156C6B;
	Wed, 24 Apr 2024 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nVn89AbM"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE0A15687B;
	Wed, 24 Apr 2024 06:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713939771; cv=fail; b=W5HtHaP7ZnAVbvhJMKg/SnOyDPW7BK4SGYcg3oEa5D0X5Th/2EliDeERHegEwz3xQMSitI0eVW9vCjlGgTb1SWFxJZzNAPXlxr9TMhVvwzFStlpfUzCdbrppko+NNfmFNzH2NegFtxy1XDdxbygXA7Hplwjnk9+o8+to1Suss88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713939771; c=relaxed/simple;
	bh=OW7fbIYvnUHLhEcuUH9qq+dY26wCDbHEltlpuBL1oug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S0cu8OYPp3jIDgNBHO/FvFiBP8C2qX8CPAFl5jOzpPUeBJyow3LCkW2PTjTQrIQkDnJZZMFjZjPvKT8cL8PLXvfhgQB1hIgqy4PtMlTeXLyc6C9+fb6mVSASyaM0VWTRJEwxmfYK1A6CqLb83YHAaDF9ZCfkFolOV6U8WTjH56E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nVn89AbM; arc=fail smtp.client-ip=40.107.212.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHIIzTKWDWy5qhihM2Pxlt7NPQV67HntrUJS1cL8jFMoOJnPLwk/p2BigxZ93A/UlJVk/aE6lLj0RyyU90VrtSMc4oRlMXQykEBkCEOIsM9Cu/lBzVX0qXk0tL8xpByjS9f8/3+SD7/5Wfb7khwKSLiCCGqj/JENAI5E2pv58wu8qjn2KXwuL8KQCQ9OCFGa2vrI88gWAobD+tXpEEQqIxNniRvdaYEWN9liCyzkj/YDLqHvk08096tIjVcYwNYziTyF5q3yj/Fns7xm5a6iuAs8/jgu6fiq7oi+U4fGhgSUn45NO3PQiKD/0BgCCMCTz6P21zzrYg6ZbY7Z0P8m4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVh32F9lHBSO2uItqpTOgvUs1072iuwwKAPNBDk6OH4=;
 b=DO7ZFMtSwZw1XikLDyvXN3ZK4HjbMJRuEyS+Oq1wT4zLSqbIAvjgQ6gu9ztFrIhRsOSEgeyE/DTMMAdWTDhc0sKjEApN207fqBgdNHrG7RRCPOSIH2U4JL+FUAQ9bLWOI5B7usVT4ENxrPbCRC8GbLoi7fPiBbwflFsNAhMyg9V0eZ+3JqIV3rO8967GU9pJ+uhEFNIQyCZHQRzsMFAEHETVeo/UXP/4mO8Wz6mgiXtRCGBaikw4c1HqeS1+LpdDuJUhgoJ9/Jeh1MoBTrfgyNHLMqPsTeC6cjRW6/pu0Z8TJXAfxVl/jeOXPNFdWTpee1pVxYl38SWZdkynwYMRrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVh32F9lHBSO2uItqpTOgvUs1072iuwwKAPNBDk6OH4=;
 b=nVn89AbMYbn+NOFdN1a9XqDpk/FIrVqmX06GXKEjK1sHyOOaq9hureUe16re9cR214AQ45Fee27GHMUN2gNJ1uSGAdWa2KcHlQLRLu9eaYdYVl95Jg4ryBEldqprGLIpnD/31gmpzmyZ/4HoTGwmpQK5F403kKYcVrFm9aOxUD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 06:22:46 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 06:22:45 +0000
Message-ID: <f42fd731-ba2d-4000-99b2-c98f0ce77b67@amd.com>
Date: Wed, 24 Apr 2024 08:22:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: pinctrl: zynqmp: Valid pin muxings cannot be configured
To: Sean Anderson <sean.anderson@linux.dev>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <5bb0dc7e-4c89-4f3d-abc6-41ae9ded5ae9@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <5bb0dc7e-4c89-4f3d-abc6-41ae9ded5ae9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::32) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 1926a65f-a10b-45e8-6d23-08dc6426f4a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGNXSGhDeXVjNDF0R3RTQ0FOZFYzLzVKSDBFbTVaSk5URXErZ0hHNnhmdUtr?=
 =?utf-8?B?RHRYZEFkTENybnZlTDllNWNJc3RNMDl2T3V2Wi8yS3pnNlc4VUpGbHR2dG5z?=
 =?utf-8?B?VmJkdEp3bVBvMzBqT0JDZzhTTGoydlRweXN6a21UWlFGZlhLTDVHamwyTDRC?=
 =?utf-8?B?WVA2TTMyT1VxUEh5Wk5mTG1PZjkvbXRXbjVGTGQ5ZGtIRzUvTG12bUFjNytr?=
 =?utf-8?B?bDVVMUx6dThDNzVFazg4Qno3ZWRSdytqYU43a3hPOVpxdnN5ei85VlI5R2di?=
 =?utf-8?B?TnptZkdYUjVXcW5VQkF0dkt2ZFN0SjhmbDFIbG9vaFJQMFJPM0I3OU1CdW9h?=
 =?utf-8?B?LytES21qQWl2QVB5UUtBNVRGSGV4SEp4ald5VjF0U3B5QUJXSmtHZ2wzZWpS?=
 =?utf-8?B?VXIwbnMvZUNaUHJ2aDZDMUhlckI1Q1RLTVpRWmJvM1BVQWhtZ3ZBK3k3M244?=
 =?utf-8?B?VzVkMmpWTG9uYmJscEplY2tNRUhNMlpVRitEb3VpSTBOemxTSmtya0NjVEFX?=
 =?utf-8?B?b3c3VWorbEt4dzhIRmc0bjhHZ0xEaGhXakF4STVZZWZIcU1SdzNwVDhaSUlz?=
 =?utf-8?B?TFBTWlhzQWVOaHY2dzVrQ0NCN1V4TU1MN3pTWXIzb1JSanVxYS9ONHRYQndL?=
 =?utf-8?B?QjJBanlKTzE2TzZMMU0wSEM3am9HMVBsQkNCYnQ4U0JIN1B5NStjSSt4WFJT?=
 =?utf-8?B?NGNORWFmNEcxdDYxU2hJLzhHSlI2SmFFT3NwRTdhU08yOHVZZDF5Z1JnbWNp?=
 =?utf-8?B?RXk4U1NENnFoUzR2MHVDMFViZUlEcWZqZHU3WVhmUUFHZDkvbENZblNQcDlL?=
 =?utf-8?B?VXNtSFBvV3YwRWpwSTlUNGZrNWthRmVDSXNVeStZam1Fb2NwMUpWeWpqTHd0?=
 =?utf-8?B?WFFYSnFIRndJMGR4QVhvUE83SHFReFpFbWp6Y3BheWJPTlpJN2RHaGQ5N1Bt?=
 =?utf-8?B?VVI5QWFLUmZ1YjY2VGFqU2dzTUxHL3ViVC9TN09TQXovaW9yL1d1TGRzaW1h?=
 =?utf-8?B?clF4MkQrQndLSGdDNVliTktJS0draE9qRkdDVUNXUXRvTW9NaXM1cm5RNWxt?=
 =?utf-8?B?a2lvenN1SktrSFdmTDBzd1VlbmtsV1N5MHBNalRSUWo5MjAxS3Vpc3pObHly?=
 =?utf-8?B?djNaK3FTTG1SNk52VllUeEtLRnQyZXVvTUNRcWk0akY2QXVrZjhhTkpMZGV6?=
 =?utf-8?B?RTBNU211ZGRoa3psN3VIc1k3ZVBub3NEV2VWU3Y3eW9zd3pmM3dYVFhla3NQ?=
 =?utf-8?B?U2Q4UWtCRS9PWmNBUlFDYVpxNjVGd0swZVEra29iZjZLdU1lM29xbzAxRDM2?=
 =?utf-8?B?NGZOTGRBcFM0amE2VmFpQXRVaS9TbHY1Ry8zeWVNTit1bG9iaS9NS0VMbmt6?=
 =?utf-8?B?aWRmNVZ6WmY3WVVYbk9IaUt1anJaQXZyOU92MkszZFpCcjRpTzVBRGxDVUVB?=
 =?utf-8?B?aU5SQjVaNU44cFFYSjgwOGxPMDVxUTYvVWFRdzh4VGJ0TjY5MWF6U0twQlha?=
 =?utf-8?B?MnE4MG5POWlINW9UYm5EMmFTbjNheWxQUlBuUEtON1pZU3djM2phbmZIclph?=
 =?utf-8?B?Uk1GbWM1UUpLR3ltZDdIbUhZUDJlR21qTzl6RisyNjRDZmk4WUx5UVNrZElO?=
 =?utf-8?B?SXFKTVE0VnpKeHJiOFZDTG9TQlA4NnpQSjFDTndRSjRVc0p6K0YvaldGR2xU?=
 =?utf-8?B?S29QSDBoMXNOVURtNFlic3J2UmNIR0p6QXhiNzBkbmwxSWZQOEZnWDFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ny82L1Z6Rm00MGFvN0hseFh3U082UkRBUEdUWDJYMWJIKzEveTZNR1l1SHk3?=
 =?utf-8?B?eExBbUF2MUNFcTcyUThDNTVPNXNKd3h4NTE3VlAzUEIvOHhxQXZUZzBhSHhM?=
 =?utf-8?B?NXFJcWRnZ3lBVG9jOHZENFRkM2dNTVNTUjFka1QrQlZxVFVmNFEwUWUyaTdv?=
 =?utf-8?B?Lyt0KzF2cnQzUkxJaGt6ZjNZQ2VwY1JEZ3RuZHdPWEtkMEdSRmVRYXBHbElM?=
 =?utf-8?B?dlJpeGkrZmNySGE2NDJHeUNkZVlUVG5ObWl4SmFBYmdKMTJ5V09WcG53ckc2?=
 =?utf-8?B?THRlK2daWlRUU0JwekdrMEZkLzNVY0dLVE1YQzZkZ01OcmJmQ21LWGl5QkM2?=
 =?utf-8?B?M3lWb3VNZG9XVU5NQzk2SDhUZ0I5bEVLQmoxY3BHb1B3SGdGZ3p4ZzJkV1M1?=
 =?utf-8?B?VkhlZE45TVRzU3BCOE5LZ1hoNFBkbWxEYjZqN013ZnEyT1N1eDh4MlpHYzNH?=
 =?utf-8?B?YzZSazRPWExFUjdNcTI4S0FWeUNKVTJIYTU5cnhGM2g3ZTlqNlJ0djl3bHF4?=
 =?utf-8?B?RGpWRWhpWEdTN28xYy9ncTNtdk01cmp1RXBHSmlzYkFQZ1NEcFN1dDAyNEtx?=
 =?utf-8?B?dDNmcUhWSTh3SFVFL0RzeDdDbGYwTXppSW14ZmZIemVqVWhEeXdIelRmNHM3?=
 =?utf-8?B?eVFScEM3eVo1aVhFQzNldmVxbTJoUHcwVkFVZ1AwYTNucG13dGRER3cxK3VY?=
 =?utf-8?B?RWJlclVWUUp3d2hCTDZEUjF4YmhEYi9GN1BHZ2xxeElZRjlUcFVJT1R6ZjhJ?=
 =?utf-8?B?ZWRUbzFvYVpFZW13Ti9TWUJXVFRNWmc1cEY5MHVkeEhicFlhdzlKMzN2ZWxh?=
 =?utf-8?B?NjdsRy9qMW9IT0ZhTGliVGRNb2I2MDM0RWM2cGx3TVRXY1lOZCtkNHFCZllQ?=
 =?utf-8?B?TWlwV3BUcjJFNjl0azdWRktGRDlaUFVBeGV1ek9IZStRczVYeCtmVzVPbmlk?=
 =?utf-8?B?ZjhFcnkyQUFodTZZUk1EYm5kS0c0aTlldE9zMjIyOHpaRFRVc05IQjh3UG1x?=
 =?utf-8?B?T1NlUWVIeXc5TEROUXJtaklRQTlTZUVvcmFpelVwQzdZZXRSS0t3M3V0cTBK?=
 =?utf-8?B?ODhZdVNDbU03QnVYUVNENEdMZVlad0hzQ05oRmF2eWxIMXhkaXpZTVNKUVZi?=
 =?utf-8?B?cmJjNmtqYy80SG1HZXZpOUIrMmtEbnlSTXR6QWVJMWZjOEUrZG9IcVh4Zlgv?=
 =?utf-8?B?Nks1c0F1ejkxR3RPdzZLQTZlNGFhRTkwL1FrTEJOeEs2NmNtNlRCTEVzNVlZ?=
 =?utf-8?B?eWNQbTBqZWJyalpYaGVjWTUweXJxODBFN3d4cEZ3elpvZUE0Y0pjSDg2am9y?=
 =?utf-8?B?ZlBEc0NkVTdYQVpha0pDRkcrKzR4Q09DZit6ekdZb2dtN3F6M1NqK2syMEYy?=
 =?utf-8?B?ZnhmODlOTEE0MHpJZzZvOUswRkFlU1BhQlFVQXZqQmFiTGdUdExqSlNmWm5L?=
 =?utf-8?B?ZHVvalRKVkJ0N2luS0JRN1dxaWx4SUJudUVFT25OWS9RSTRKUXZ3ZEhWZnF3?=
 =?utf-8?B?K21uVjkwYVQzcUlvRk1sY3VsYXZZb2d4aGpsZlpVMHkxRXUvNTJnbFBxWEtS?=
 =?utf-8?B?YnZPTnpnZWcyaTBadHdXbVcrS2dxNWhDY2VVMTlVWnNzcGNCRktuaVE2R0tM?=
 =?utf-8?B?bHcyTU8yMExhQWRySU81N1pUMkhBYUN4cXNpTzYzWTdaYVU4UHU4OGg2Nlc2?=
 =?utf-8?B?bWtNS2IrZW9zR1MwbFFLdXJTcHB3d0pmNVBjVlIvV2hIWmYvcUZrdGxiS3B0?=
 =?utf-8?B?ajlYaUoxNkdMUGF6VSs0c3NTaDZQWmU1UDJjOTJXeGRFcm45U3d0WFBSTnpH?=
 =?utf-8?B?b3Z0M0xaSmQyNU9GTmQzK1lYM2hyNmJSNmc4a08ySEdrTEF6MUhuRGZUTWpT?=
 =?utf-8?B?VTdCdnlFMnVOSWFlcFpBblRTRit3SUZvSzN3S095ejNDSnhEZ2dRZE9wTnFt?=
 =?utf-8?B?WkxSaHlHdmFPbjFQQ3J2RGFheXpEZTdKcUhGM0kvYnRwSlNsOHY2UGlYWXg1?=
 =?utf-8?B?Um5KRXM3R1hsR3JSak9RblBPeVhhQnVvZWVLS25yOXVFS3VscGRlLzI1V0tj?=
 =?utf-8?B?L3E0bjVaa0ZibE5ta1BXeU1kK29jZjdTZEVRNjZxN0hjRTlzU01BaXlsdytm?=
 =?utf-8?Q?HXq2LuLQurF660z+OSU4NBH6E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1926a65f-a10b-45e8-6d23-08dc6426f4a5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 06:22:45.8435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clTpHTyU4F7p2yG1rqVeZNBY4mdh7E1w/7RIpljqjtc3R3IuG9Enh/7q+03Ds269
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863

Hi Sean,

On 4/24/24 01:04, Sean Anderson wrote:
> Hi Michal,
> 
> I was looking to upstream one of our ZynqMP boards, and I ran into an
> issue with the pinmuxing. We use almost all of the I/Os, so everything
> is tightly packed into the MIO. For example, we have the QSPI on MIO0 to
> MIO5, and MIO6 to MIO11 are used for SPI1. However, I cannot select this
> configuration using the pinmux driver. I am using the following
> configuration:
> 
> pinctrl_qspi_default: qspi-default {
> 	mux {
> 		groups = "qspi0_0_grp";
> 		function = "qspi0";
> 	};
> 
> 	mux-cs {
> 		groups = "qspi_ss_0_grp";
> 		function = "qspi_ss";
> 	};
> };
> 
> pinctrl_spi1_default: spi1-default {
> 	mux {
> 		groups = "spi1_0_grp";
> 		function = "spi1";
> 	};
> 
> 	mux-cs {
> 		groups = "spi1_ss_0_grp", "spi1_ss_1_grp";
> 		function = "spi1_ss";
> 	};
> };
> 
> But I get the following errors on boot:
> 
> [    4.261739] zynqmp-pinctrl firmware:zynqmp-firmware:pinctrl: pin MIO8 already requested by ff050000.spi; cannot claim for ff0f0000.spi
> [    4.274506] zynqmp-pinctrl firmware:zynqmp-firmware:pinctrl: error -EINVAL: pin-8 (ff0f0000.spi)
> [    4.283789] zynqmp-pinctrl firmware:zynqmp-firmware:pinctrl: error -EINVAL: could not request pin 8 (MIO8) from group qspi0_0_grp  on device zynqmp_pinctrl
> 
> This is because the qspi0_0_grp and spi1_0_grp groups overlap:
> 
> group: qspi0_0_grp
> pin 0 (MIO0)
> pin 1 (MIO1)
> pin 2 (MIO2)
> pin 3 (MIO3)
> pin 4 (MIO4)
> pin 8 (MIO8)
> pin 9 (MIO9)
> pin 10 (MIO10)
> pin 11 (MIO11)
> pin 12 (MIO12)
> 
> group: qspi_ss_0_grp
> pin 5 (MIO5)
> pin 7 (MIO7)
> 
> group: qspi_fbclk_0_grp
> pin 6 (MIO6)
> 
> group: spi1_0_grp
> pin 6 (MIO6)
> pin 10 (MIO10)
> pin 11 (MIO11)
> 
> group: spi1_ss_0_grp
> pin 9 (MIO9)
> 
> group: spi1_ss_1_grp
> pin 8 (MIO8)
> 
> group: spi1_ss_2_grp
> pin 7 (MIO7)
> 
> However, we are not using the "upper" pins of the QSPI device.
> Therefore, these pins should not be included in the qspi0_0_grp. This
> stems from the driver placing all possible pins into a function's group,
> even though each pin can be muxed individially and it is not necessary
> to mux all pins for full functionality.

Correct. These configurations were not consider at that time when code was 
written. The same issue is there if you want to combine pins from different 
groups. IIRC uart rx via MIOX and tx not from MIOX+1.

> 
> I think it would be better to have a single group for each pin:
> 
> pinctrl_qspi_default: qspi-default {
> 	mux {
> 		groups = "mio0", "mio1", "mio2", "mio3", "mio4";
> 		function = "qspi0";
> 	};
> 
> 	mux-cs {
> 		groups = "mio5";
> 		function = "qspi_ss";
> 	};
> };
> 
> pinctrl_spi1_default: spi1-default {
> 	mux {
> 		groups = "mio6", "mio10", "mio11";
> 		function = "spi1";
> 	};
> 
> 	mux-cs {
> 		groups = "mio8", "mio9";
> 		function = "spi1_ss";
> 	};
> };
> 
> This allows the full functionality of this chip to be configured. Does
> that sound good? I can send a patch to this effect if you agree.

The only question is if this can be done without changing TF-A code because we 
are running out of space in OCM for it.

Just a generic question to your problem. It doesn't sound like a dynamic case. 
You have static assignment for pins which likely won't change over lifecycle. 
QSPI can be even boot device. Do you really need to describe pins via DT that it 
is not enough to have them configured via psu_init directly?
Driver has been developed for i2c bus recovery via gpio which was the main 
application. Right now Kria SOM is using it for carrier card pins configuration.
And Kria is pretty much only platform where this is regularly tested.

Thanks,
Michal

