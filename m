Return-Path: <linux-kernel+bounces-59555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 320FE84F8DE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5695A1C20D7E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06B87603A;
	Fri,  9 Feb 2024 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZOmdLR68"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388EB74E28;
	Fri,  9 Feb 2024 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707493800; cv=fail; b=ChXiq6A/9KrZsjgHs7IH0BbV9wA8F9dbVVyjBq0du9EQcfhvFCxyVMNRaUcDL5lF+W6COLat11ZqeknNYHKYJJCJFNrAYPtOs08YO8l9i4ls1cfvIH3WL+npaFaOm1MJv3xrWyanOiYAuCBGnBZaaonTbXZPY8iXnxLzbWt8FWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707493800; c=relaxed/simple;
	bh=djvr1T9bKfSxp5ooDRk5vLbEyZMiF9m0epB0b02xXUY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KVtjVvLHnwaOi3B1/X5XQA8Mq5e5PbkLrCPHWcaoysJ/7jHeWrxk3EjYRNTqDbaBoRRY54/5oHI6+pNTPg95ywE4bNpAg2oM2vKFJBCZ8xNTBZ9VaB09BRLBiJQ8dgRcj4v3e1IMklZelRF5DZfI0+bjTu1nJULlO4yjDAoDUwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZOmdLR68; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eY+cGXDRuCsf0z+Mwhl1cur8hqBi2X3qPHukadixpc7wHn6zRT737KUQxNUnM3zewrNuV1UhanRd8OQJIW33u+ujL0juo9Spvf3o+RShvE4qH1XcQ3hI7sXL24Y+Gvguzi+N+NCHWbWBA1GJA1be71RANY/MssclcBuEh0vbLjwKo9BTmlQKJV8ZRcpaRrpGncALkyDaW99r06CorTPgbxSqZtUtMqFuiOg/AvdEc/Yfjjxtw+E8jkwWajwXVrOHJP/JbSZ6fS8k+W/bITfX+e11fo+zpGDloscubG5VkX9XF4JY2ZpbCqSVIzltWkK+Tjf0FbEICGukSKlefRtCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2W9WjKSeSw9YyCFAHexA9/LpeS7MlLDXVvPyuTRJEw=;
 b=nOhHPaFWr6T7ClxVYuWJIQx0B4YZAMQvSEGP2kG2j4e4K8ZM8Z4HbFDW08i25mFWnE9sKF0iA9HSUAjKKgO3Tx4TT0hL4lhqYpo11OUrRvRsTDPjrHALc7M+zMBJoh8FiGIqVC7IObdDidm0+CbOcoLI77Ysd4dLjAwnA8Mc01GNKJtP77mDdfzJ6IV0ZAX6jsphT6mfcPmqOskSndCdtNDil0FjK9ZuWZBpenvY4g0HZzGR+jymxyt/M+yrhbWKVujNvzpiwX8Iv4fHfAClUTrEjwk74i80MjM8sqBijqZlUYLDFYEb+6jg4ySU/DyU2pEcY/4S2/dKI+lu5SZe+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2W9WjKSeSw9YyCFAHexA9/LpeS7MlLDXVvPyuTRJEw=;
 b=ZOmdLR68BuvkVPfg6JFi/Xqb7FPKBHbU+o2QSQMAsvLip6pN1EAXIw6KoNdfSRsNVrm3sA8bODCymc9MvYww3FYbuvZJuAUaO5iV9mTFnH8HB9IVbrL6VY2aoym0nYztTvnfEtphFp1huotiT8U+Z4Vc8k1t2IdSx9pZY0a/wcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.14; Fri, 9 Feb 2024 15:49:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826%5]) with mapi id 15.20.7270.016; Fri, 9 Feb 2024
 15:49:56 +0000
Message-ID: <d06441c9-db33-4c44-81cd-dc1052f48e43@amd.com>
Date: Fri, 9 Feb 2024 09:49:55 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpufreq: amd-pstate: Fix min_perf assignment in
 amd_pstate_adjust_perf()
Content-Language: en-US
To: Tor Vic <torvic9@mailbox.org>, Perry.Yuan@amd.com, ray.huang@amd.com,
 gautham.shenoy@amd.com, rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Oleksandr Natalenko <oleksandr@natalenko.name>
References: <8eefeeb7-f8e8-49f4-b83c-e67a9e728f41@mailbox.org>
 <20240209154336.7788-1-torvic9@mailbox.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240209154336.7788-1-torvic9@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0169.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: 92582d73-3a52-46a5-d968-08dc2986c36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gOKsxDcR/3OttuPbindYtiZAUHNxx8fbBbytfOR5Wr1GZXL1H+qhYIXG8G0aijzniESRJFD9pM2vydA/bjsjwCpjT86im0wReImWFGoc2rRmJjvq/PWKWO7XGmkXF9AOZXIgOVWM8Mjqefs+tWG3LmCWu1YWYBcZnftlm05BB9xQDJ9usXOm3zWWj1hf0WUQhd+pazP28USt1vNUubapokjHMdhxbstFVcmvfmYzlPTYzAJHHMR355o3J0CVt3SIDsayIl7otgEGmQiWS0/dur4HgIQXht+BqSN3Nj1ShYgTgPWA9TUs1oawkH/FIo253Erpfjjl9yizsEDEDE9LiEk/RTd33ZWQzQfLrJO17oAcMpBWpufqO/rtmzoDXqT9Ra9uTZwVYPFyhqj40ng6V4jg9+dUt6VJDZi2AxvZUwfi9mFxhnqlq9ouxyO53RLg8BK7RJQ+ct+W1hOcy1ir70eMlnxEcyB/AltixLOq0v5yLNpYBrVyRex+jhT3wmdck3FeVKKGQLz2C2vEBZJjbKkoUbSTbolbxGSVr3G3hgBVWsD+jSbE4ZsKzZfAOPVv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(316002)(83380400001)(38100700002)(478600001)(4326008)(31696002)(26005)(6506007)(86362001)(6512007)(2616005)(53546011)(6486002)(5660300002)(66946007)(44832011)(8676002)(8936002)(31686004)(36756003)(66476007)(66556008)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkIvMEQyK1FUeXQzZ1kzbmhnd3lVb21OL1NtRDJ4MGR4R3gzZjdvVTlQM25X?=
 =?utf-8?B?cGJlTmRwMmZ4WC93WnlhcENrVWdMV21qNGFjaDdOWDJUZ3pUaGtiOEJIaWdq?=
 =?utf-8?B?dFJpcit4OUJWZkdhMEg0cGN0YndtUHU3dTlJU3J0U2o4UU5yTGlwWElKcUVl?=
 =?utf-8?B?RmFnT0dGcHhEdjFTRFRML2ZxZ2JuVmRzVFBKU1FwMHlMcE14dzYrUElQckJZ?=
 =?utf-8?B?enFyMittZGVDcGhBSDlxdmVQdjZ6S3E2SXRNVFpCVTU0eGFUelhadjIxZnB2?=
 =?utf-8?B?aVVNSXBoQW9ScW5BUytaR1VaejQ5bzMzeWZTcVpwQlMzOWpIT3kyc21IME5w?=
 =?utf-8?B?SGl5aFRzUFQzdnVuMENrMklVa1VPSU5weGsyeGRYRE9uYkRRaSt1RCtBYlVU?=
 =?utf-8?B?cUdJVUdLV0wveGp5aHdQOEtCM3d1ZGMwRGE5RklJS0E4bWhqalZkUVd0OVhq?=
 =?utf-8?B?UXRKWXczV0drQyt4amJVWGl1dmZPeEFDa1U3cTE2YkJRKzBZR1JRazVDeEdR?=
 =?utf-8?B?TXBUV2F0cmN5cTVwU3JxVmE2SVI0ZndReUx6bXorTm1Cd09hOXJsTmN5ZUJj?=
 =?utf-8?B?bmgwNTBIWlkxbDFhbGFjUGo4VUNxdFY0Z3BiTWcxWFkvc2tLY3RwTTczZVJ0?=
 =?utf-8?B?UUVpNEZCeUEyWW5oOG96dW40OUpnNGxGbjFVVEF0WjJwalBiL2Riazk2TGtT?=
 =?utf-8?B?eS9DMHlkbFBLOTlzOThRM2REWkpyU0J0dC94aHlrTDJNVUxRS0lmWDNOMXN6?=
 =?utf-8?B?Z01Xd1NkS1g3S0V2VXluZlIwNnJ4OW5GOUhHNmJTcWJHbXBWTmFRaWNmY3lI?=
 =?utf-8?B?R2RQS2VSQ0lwcWZxcFN0OE8reVBFaERlUDJYNzhnUE0xTWVpbmx4VDZoYi9s?=
 =?utf-8?B?cGl0SzhlQ05ObHpIN1RkZWFMVkJSd1U0b2NVZUFCemQweXlIV2xUSEU3WTZ0?=
 =?utf-8?B?WEkzLzdyYUlNeC9aOGFSNmlrVEMrcnZWS2xBRVpjK0loNkFuYk9wenBMUC9W?=
 =?utf-8?B?ZHpJY3RaL0E1MGJEdHhTOHhVbHN0K0R2NFN2TnowRWoxMkxFUUcrQzFFWFJL?=
 =?utf-8?B?VzJxNnFjL3NvZ1J1allubFBVS1JpMXVpRitDTjlGZ2lQMDkydENXMWxkYnlY?=
 =?utf-8?B?TThTazF1YmlxdEgyUjAvUHJSMWRwYklNZ0dOUHJtbnN3U0gxTVY4SGd2aEQz?=
 =?utf-8?B?SHRCenYrbnh5Y0VITVZ1WnNhbmlNRkJUYjNJNmtJcXJ0d3ZvT1ozeDFXRXFX?=
 =?utf-8?B?cXBxaSs4Slc5dGd2VUNFOFdkWFUvZzZBK08xWWpKRzl3ejQvajQvZko5aU9L?=
 =?utf-8?B?Wjg3ZkJzVzcyTjFFOW5jbzRRNk1RMEtyNGI2Q2EvN2NWRmNYSFhTKzRJQm1T?=
 =?utf-8?B?ZmpHdWZ4a0xWQjBBNzdPRTFaRXNSUmxta0xSSkZKWktrdHBmMkU1WVVuU1Fm?=
 =?utf-8?B?dHpUU2s1aUVGWnVGQmFobGhWdVhsTkpJQTVpcmE1MFZhOXAyN040TXZiWW50?=
 =?utf-8?B?aFoyOXgyODNXelJZcEYrWWhpRWtOU2FWQW5uUDA2RWhkZXo5RWN1aHNBOHBm?=
 =?utf-8?B?VjJ6VGxFbkM5OXN3YUZucHlRQVNxYVAxaFQwOGlNMlU2QXlRb2hVZWorbXFQ?=
 =?utf-8?B?cTdGaE9nRUJibHZlZDJJbjVySTV5OE9VWVdkMHRFSm5LZHBaaisyU1k0eUZW?=
 =?utf-8?B?Y2tRbDZOMHN2WUU1SHFUb2RvNXVvWk1tbWpBL1pubWdtQ3kwWDlmQ2V1ZldT?=
 =?utf-8?B?SFFOVDAzODBTbUFiYjBCUVFhNmJhZzNxNTRlWEFsUGx2Z3NYYmw2bUMzb1BM?=
 =?utf-8?B?TURvQmRqTExpK3RJcU5ZV294elY3cTVwRFZFZE1ETlM4dzF5N0wxVjdvTHU0?=
 =?utf-8?B?NnBYR202WXRmK0hnQlRzdjRNZjZhQk95WC9nTTBrVENzTUtoZm9kRFVxdVNr?=
 =?utf-8?B?MHpOSVZTRHlzWDFOcXFYRDEvZmR0ZHkxUithc21TWHYySzh6UlNKaFg2MGN6?=
 =?utf-8?B?V0FmTnJGZUdXQk1VZk5ucFVpOU5qcGdMNDZtbllIaWEyN0JrcWU0WE0wNTlm?=
 =?utf-8?B?TTVUbGcySVQxd0NOVjEvTGdYWHFjRGcySlFXUmhDTnFzT2w4QW82WkdJejFR?=
 =?utf-8?Q?VJ+wNdazWOGWaOr/zgOCPFHxm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92582d73-3a52-46a5-d968-08dc2986c36e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 15:49:56.2268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UG52lP3iHocbi7YiklS35yPorDbSCqpwuR0NA+6EqfMGRdF+HEmXa5DHOvvOHiTEGdqhtxTlJBlCctiplzaMfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837

On 2/9/2024 09:42, Tor Vic wrote:
> In the function amd_pstate_adjust_perf(), the 'min_perf' variable is set
> to 'highest_perf' instead of 'lowest_perf'.
> 
> Cc: <stable@vger.kernel.org> # 6.1+
> Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for AMD P-State")
> Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Reviewed-by: Perry Yuan <Perry.Yuan@amd.com>
> Signed-off-by: Tor Vic <torvic9@mailbox.org>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2->v3: Resend with git, misconfigured mail client borked v2
> v1->v2: Add Perry's 'Reviewed-by' and 'Cc: stable' tag
> ---
>   drivers/cpufreq/amd-pstate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 08e112444c27..aa5e57e27d2b 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -577,7 +577,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>   	if (target_perf < capacity)
>   		des_perf = DIV_ROUND_UP(cap_perf * target_perf, capacity);
>   
> -	min_perf = READ_ONCE(cpudata->highest_perf);
> +	min_perf = READ_ONCE(cpudata->lowest_perf);
>   	if (_min_perf < capacity)
>   		min_perf = DIV_ROUND_UP(cap_perf * _min_perf, capacity);
>   


