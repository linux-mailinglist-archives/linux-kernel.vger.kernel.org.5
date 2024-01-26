Return-Path: <linux-kernel+bounces-40303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C2583DE10
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9915A1F24338
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50D61D545;
	Fri, 26 Jan 2024 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="btxND4l4"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650A91CFBC;
	Fri, 26 Jan 2024 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706284473; cv=fail; b=sHCudcCoRhuOfqH04G0pPWb7zdaqq0aqOk8QbknoUeGbGhF5cRM3E+YdDvPRJZLiNzSVM+AkkKRz1I/vWTgpm6fnRbAGw13ZTaLJ2+ukXLkAT+hFCctAoksd4CDszCFDIh6ge8hUGW2fc82Rg39voa8WpEZRTAV3odXlkQfewE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706284473; c=relaxed/simple;
	bh=oQVqljrUzujs4W+UjctZlRKf34gB3k1T9+94C4p3jsI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NcKx6sX+d2RMOfEwB8tl/SZoDh8yAsSU5eRbOtDzUTKKzN8CUNoKaORkfMVHyk5L8LwGsTNXLHrxqcghKQrFilWaberDOzL7Jto06zWeMJjVyJVhWkGpewBR2ZhArvchm7Gp4znHQp7pprO/bc9DuL1dhRytbmV3PirjCBq0VLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=btxND4l4; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKcCFsY1/AIFs6aGlN8U8VEkgjsq+YGbiJAvNxAKqdvd76vm6yUcqDrkH+jqyCb6cnDu2YoMZYjxp4Ngy+/DRo1ioV1IhIqlY1YGN7iNl7Dw16DqDzH3PLeIFFMtfLR0RHa01KvUvO1eWPG9ztX0K3jmtoyX24kt1zGNFWTivBmi13eDYBSIRGtiQF/eOAotrufrFDoldaDHHSH1d85pSN8Gekn1+Q4Go54zDo2temvbQsizr0Y3+654OO6VyKaXUKg2I0kKftJkWNIHqOh+HEGJvEmRDVB1mAOE4m6LGVHS0zVGaTfeUzF8u0+CyhSvek6vjySfqgdf0KCAkp5VHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZvbQJ9kc+jfMZlEOaoVecHSV4ZblcMtVaec47jJ74o=;
 b=bSH2Yycx39i6yU5pC53Q9ci92tCvrdeaZyYLM2Up5h0LUTUilxi+/j0DZg0UY/eBZnhPIzmyUNZXIDzKxVocmyz7XAYXjErvf1NG2XWfIH3DNWbQJrfIsNtO+kh9uO1I3KsomyNaKA1XEmK/JdswQex08jX+TjQT5XnB54Skk7gFZUb+RhWUrJCTqQtLtnMwm0v7lbxXXpQVqG1hjlohDLVqNZlswUN2RDhGTamEMIfo5nboPCP3iIaNRFIlZXdfDayKpZLObEDBbROjYQEBJ+8g0U39dKEUIyueCkc9VB39G9G8k8pRnPDadEIYQV1Qp0di4j4wYFTtlt0ygu7A6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZvbQJ9kc+jfMZlEOaoVecHSV4ZblcMtVaec47jJ74o=;
 b=btxND4l4OfFrh3KKK9MdaroS+nuShMJ+kZcT0qNq5KmfiIRJWUJ5Kml8m//QKjNhCTY/Ogz+S5AGnuMurK9HflHWcpiPuDCsW9diMroGwM/l6THlPIkAksrnNVdysTiHtI1ph9SQoMbwvLXQ32tAQxGnhcgqn2rRJ+4Uy2Q6BPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Fri, 26 Jan
 2024 15:54:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 15:54:28 +0000
Message-ID: <81830013-a956-4dd1-b3b7-88c419de77b3@amd.com>
Date: Fri, 26 Jan 2024 09:54:26 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] cpufreq: amd-pstate: fix max_perf calculation for
 amd_get_max_freq()
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706255676.git.perry.yuan@amd.com>
 <675807d1888f77d7d0f3bc335b5bb3bd2c023670.1706255676.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <675807d1888f77d7d0f3bc335b5bb3bd2c023670.1706255676.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0052.namprd17.prod.outlook.com
 (2603:10b6:a03:167::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f3a151a-6bc2-4093-6791-08dc1e871422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BzomyJSMV0XMJwwYTLbFGwUp8HKAMt8YQc25hfzhqDN8MqoQX9UoIzHDPwhoMBbldBoTsaQiLljyF7ylnfOQaYOgxsDnYf1VPa1G6b01QvsjIiHUP4KoTYQrMIOx8v/3CS6dLA1PewZ+psTcQpJgBxyV5PI4SNoMuv+j4NaSyr53c2GDg7L9HXSG42tNu7D+cDf7858Le6UeBfS6LUGCeCE4WIH1tRFHXNxm4wKR5ILqObyHnXM4Hb4SYM736s+hbiEtdP1mJYBgERlsze7JIoHtijUkzWEu3PIfSs4Wfbz+qiPwJXDtW6HC/YHsmujwJqixyyAHUt8700RmomCOw5jZMOnDLIAoNV9UMXxC8PQOaAIrNJK2+uqlQ1H4ykoan0Q7BHwfN16JyBUyj/ENBMY9Ro4eQManodtX+/Cr7SrX6BWhMWGmg2bTBavCkisvJsJhVnErKkmnykc4efsqlNQ4N6tKwovjkGBheqR2jFSrnqJ3EC6klP9GE87y5jhWoQBlVHHDSOYRSnD7JUfwSxxEAoMrWkRMPmxPPeuBU0hBat3IMVu9HgfX4eDRr+EQGKXImKjvGjNLfvSGjMFQoIjIH6TfPHsjue9EJdSTS75Yg0O3DBJxhCeXWYlMEJC1CDqi8o0xhRlQmVWjwEGRJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(86362001)(41300700001)(26005)(38100700002)(2616005)(83380400001)(6506007)(66476007)(2906002)(8676002)(5660300002)(8936002)(6636002)(44832011)(66556008)(4326008)(316002)(478600001)(66946007)(53546011)(6486002)(36756003)(31686004)(31696002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OER3SUhkbHgwYUFiMFlpY1owZ3c3OTN3T1ZHVGgxenpJdGhBbTUyVCtxYktX?=
 =?utf-8?B?UVZ2dnZQdmp2L1dZR2I1RFJTLzJxM1Nlcmx3RkJjODBUTGZ3VUVnRnZQNW5Z?=
 =?utf-8?B?ZUlFUnU3YTdhVU5NS0UyK3VuN0xkOU5ad1VXU01zSUI0WUt6cVIwNFRkMW1B?=
 =?utf-8?B?WkozUWVvNzBlN0dzNklET0VnQzJIdjN0YXc3V3dnS2JPdUtqdDhqMnpObXNP?=
 =?utf-8?B?Ly8yM1k4aVpUZWczbGFUclZLYmdieXNQcUoyN0NOQmN2ejlMMjlRS2xiaTJD?=
 =?utf-8?B?d3AzTGRPSnFrWmZuZW1oVVN1alZHY21LVEFKZ3dXbUQ5NU5IZFlzazd2M2NU?=
 =?utf-8?B?aEVsOWloNDNZYUtlTWtGTGZEVFZ3TTJDTEZHYjF0NlRWMS9iNlBlc1hYRDlY?=
 =?utf-8?B?SEtvanhYbTdtcllvOGJTeURwOFdVd01pSlU0SUhwSm9SNXhOay9FN0htSW9a?=
 =?utf-8?B?eEdJalBNdE5idE9YR0kxVjljeEhqOG4wQWFRZytmK05GOGtVOVVneFZTWFQ2?=
 =?utf-8?B?K2hDVys0OEVNSFJ1ZWVXVDAyaTY0YkFCdndSei9MT1VKYXBENHorRzc1eDc4?=
 =?utf-8?B?K0VqamNwVDdBc3Zac3AzZXhkZXJ5RlpqVGlHRU4zUys2dFBpQUJQV3RIVk9X?=
 =?utf-8?B?ZFBPZmk0RG54YTVQUGlHM3JjNk9DMjJxdHRvclgxaVJWWWNxMlVKbVQ4d0Fx?=
 =?utf-8?B?U24ySVpJZzRVNG1iUHBUeUtqZWVRcXRNODUvMUNDd3pTQnZKR1dWV2s3bXhm?=
 =?utf-8?B?T2VlRU9NWE9Ea3V0d3VPUUU1WUhtcytjMkw4aXZVeWxrSGQ5eDRkYytMSVJK?=
 =?utf-8?B?Y1VVcVZvNjJxS0wwT0VHOWRlTDMwN1BKNG4vUXdEYS80UTB6UDBHWnhOdlVx?=
 =?utf-8?B?bDNaZUEyWkNxcm0yT1p0Wm1BT0dGbS82eDZ2VFBST1lWOWVFMXE1cUhxdEpB?=
 =?utf-8?B?R0Q4QUg3UmpsNUo1bWN5bTY2cWd3VUlrK0JuRWhGSmRZdm5qZEsvWVlSUkx1?=
 =?utf-8?B?RzB1RStsUVlvNnE3bDNleGUxWXBPYWpuMHNXWnJ1QnJzc2lwQXBwaC80THRa?=
 =?utf-8?B?UkdTS3hkV3pnbG9vbldHaUJ2dW1CdnI3OVJrY3diQnBXdTZzVHpoSGxDdmpG?=
 =?utf-8?B?ckRQOFJtTTRkWnBxZjNFL2VyNDFva2xINmszWkl5UVYwd09Rd2VTNGx1WHAy?=
 =?utf-8?B?cEFJVzNTdUtOMHlGYWh3UEtaaForaVpjbVd2RW0wSXBiSGllME14a21rckQ1?=
 =?utf-8?B?TmZnS2hTa0RLZEtpazh6WktzRnEvQ3VXaHRvSDdNbTNUdFBhRFg3aElUc1JK?=
 =?utf-8?B?YkpscU9LR0ZKS09hZDA4OHh2R1k5NkxDc0RTYUhVZXJTemU5SitFZmkwUS9T?=
 =?utf-8?B?ZnkreHIzNG8wZHZnWkwwdUlUMUxqWWZLTGJtVE1vSmZXNVdZQmppWmZqUG5t?=
 =?utf-8?B?Qm1jM09maW9zZzJVR2hOUkNPS3dncDZuNm5ERlNRd24yd2NiOWxITjM5YnJq?=
 =?utf-8?B?ekNGVktQWmhrRVFuWmxvaUVOY2srZ0V1SmRTMUJXeldzV2dHMXZPOFRBY3M1?=
 =?utf-8?B?OGlOSjBqeEJOZnZzR2hDVmhhY25jMjZpWkswR2U5T243eC9FRTRON0ZkcFIy?=
 =?utf-8?B?K3lOV2dQenNpK2Eyb1IvdEFqbGh4cTVlS1l0UlJHOUs0UUlwYTJkbHZWYjZO?=
 =?utf-8?B?TnNNTHZGdlF5UGYrdUpuSEFLT0hRdHplM3c4N1N4TU1kemVXRllRVjFYbkZn?=
 =?utf-8?B?Q0VDOGdwK1RJcUNIbmZ4dERGak9WRVZ2SnBEZ2taTzFaRDZzVE9xa1NtSEtX?=
 =?utf-8?B?MUJuZ2JIWGNtaWkwOGViT3gybzdhZjRjdlV1OGYrcnJ1d3N6S2ZYdTRKTVdH?=
 =?utf-8?B?bGcza0Q1Mk1FemZCb1dlSzI3NytGOVFjcUFwcURpanFyYm5zVzVZdUh4aFQr?=
 =?utf-8?B?ZmZlTURocWZNTlU1MnlScmpXMzQ0QmVhV3QyQkk5UG5uc25WZm43NWxqR1pS?=
 =?utf-8?B?SnlxemhsQTJPcmlZaDkvY1U4YnJHclErQXBwV0dQd29vL3hrdlF4S3RiQ282?=
 =?utf-8?B?bUFGbzVPVE9oUkNiRjlMZnN6SXRNQjhtNm9zZ0JVTndqNTBNU1doQmJ2dVln?=
 =?utf-8?Q?QX+sAOIxekV/SprlQTqE96gpr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3a151a-6bc2-4093-6791-08dc1e871422
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 15:54:28.8811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8H1tOpZOuii+zPu5tnm+LBBWeJ31naxDAnfhB8lPi5S0abRQ3NmTsilRbI6uTU6OFsJ06ft5l2k6QLMEXUtYMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456

On 1/26/2024 02:08, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> When CPU core Precision Boost state changed, the max frequency will also
> need to be updated according to the current boost state, if boost is
> disabled now, the max perf will be limited to nominal perf values.
> otherwise the max frequency will be showed wrongly.

What about the previous cppc_req?  Shouldn't it be explicitly updated as 
a result of this too?

> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index b37bea7440b9..3286d72f375e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -599,6 +599,10 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
>   	nominal_perf = READ_ONCE(cpudata->nominal_perf);
>   	max_perf = READ_ONCE(cpudata->highest_perf);
>   
> +	/* when boost is off, the highest perf will be limited to nominal_perf */
> +	if (!global.cpb_boost)
> +		max_perf = nominal_perf;
> +
>   	boost_ratio = div_u64(max_perf << SCHED_CAPACITY_SHIFT,
>   			      nominal_perf);
>   


