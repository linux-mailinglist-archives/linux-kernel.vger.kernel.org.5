Return-Path: <linux-kernel+bounces-45228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A00842D61
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E05B254D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04B8762C8;
	Tue, 30 Jan 2024 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MiFmK+/F"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F244469970;
	Tue, 30 Jan 2024 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644503; cv=fail; b=Q9g74aYSh5Q+PihnFYTgQOg4GddyCiOWMzzvWfgteJvv+LWTRuN1kGJI119+LWSioBPVuYGopXAwPdNEFo3Tw1UAyibOjzej/SngkvQagICXch+5QI34WUEE4VVIJFJqFVdeIyCuWTDvsZiQThucMWIOhr+EA7xSr3wRQq3oxQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644503; c=relaxed/simple;
	bh=lvq1233Vd8LCzTpj2zaeonzVGJzy06AtGwoDk16am4I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AgM5/kNyULUkYm9zf3AgVB6+aVNsnbHPo5uS7fc5OTZ0+6Kj7zNVV6ggB/sO4OlXoLV89KXPCHe8xzFdxsJ4t7GF7AzKfxpXtsEFkFgOJoYQdtMWX+vIVzWJrrh52gguEhVBc9dpkXBKvoZRr6IpN4BIXxYV1xQiaxuAQDwBM2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MiFmK+/F; arc=fail smtp.client-ip=40.107.95.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHxxbNVpGbHsalngSRoUkG8S4a4IsQeLaQNQaB7xLLRf79xRnjVUBVJnKp/e+FWzKOIGKuwTqTUW2sirjvkVKPwO0cbqaf++ffgqhaU2pLCEZB7Zg0MlRObFPjk3zc8ZFrpjUMJ1CP+jrieWDd43UsQFJNGZH+EID9p5dQb8J97svvkr5dEu95gTX3eX8hj2Hh8ti2slsFbpwobBF9j/my3HRShg1EVBciZVljop6vkY7+IbygNURYHoa8jMNMkUIyabYbBU+YYDzQ4oTsCmF3gXD1NrphFTz2AdsGr/VaZARje0VPZ7BC+bNvRyUx29COuY8ESdv5asp/eHY1EokA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkRpCPgBGLMMfH9361rHjgnBeF4YySDReUpcMTlEWNg=;
 b=Kbwv+hArmXdLI3INjL4GxrAjDTZLYzhsBysgCEWs/2EGdswEzDBn/LZzuC8nxpek624bwG8DBU+ZuWRklzRVx5dVohzbGvp3fSnt9i2aTGk6XlqinZOzRskP+TI8GppsxWHh0/eD0Wd7uDcm0T9grvTkppkF43REf9WJ6PDAfGgcdeDJWsgS1gycJKXsbQf+je+s1sbkli846ZLv9NouuRkeV19whxg/bKrmVWT5KwY8pvDb1oU5aOFdeOt9LswlkUc95v+ArJTupe8TxVkI+dQxDGAbf21knCFTDPqFZSGM4vriT8xR4VyPZ+jFEc/an5sEj6wotOxOBV6t1jHUFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkRpCPgBGLMMfH9361rHjgnBeF4YySDReUpcMTlEWNg=;
 b=MiFmK+/FH2lleQSe/Q4+78tOBFmhgH3f5JDaDhLstvYpPiXWwIXJyyrmDH0yU0aWPpr9uwAJA5JCLH8zbFomrRo9lW36LHwUaHh3gKc6HgGBccn1/m+009mBYtq0wPU7qL4EoFHiTmeyWzGrsX7H/BmV0wM9BblQxG37NpWMAzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7172.namprd12.prod.outlook.com (2603:10b6:930:5b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 19:54:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 19:54:57 +0000
Message-ID: <9ed01851-f430-466b-a103-0ced8b4b4828@amd.com>
Date: Tue, 30 Jan 2024 13:54:56 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Resend 6/8] tools/power x86_energy_perf_policy: remove the
 invalid feature options for AMD processors
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 Borislav.Petkov@amd.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 gautham.shenoy@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706592301.git.perry.yuan@amd.com>
 <bc53456d6748a7fcb6a0c3ea3f136873fbf1d646.1706592301.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <bc53456d6748a7fcb6a0c3ea3f136873fbf1d646.1706592301.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0200.namprd04.prod.outlook.com
 (2603:10b6:806:126::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 354a455a-546c-4aad-39ed-08dc21cd55ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q4Qzj0wNsrm44M+XaGRFu0iZ9sp7Wa7ZHpEKul9lBivu/rVDenvuHN1DGOW8o/g13mcPDpIPHBROi75Z04norCsMJc1osWhvk3i1PxGVwuMtnLDHPYkJuJcbEKlhVLoAwhg/o4tKOo0zVZVRmvLakj6QQI68kqxxZYA8231fs53L1JcYjX9xFcjujEYOCUwqrLRvmX6SLVOrU5JIxBRei+PibJisLnz3log/0qrAsDFGs5kpJSaorG07zcmePTToshoxmbXLVUaUc0GIwjdq1Zo+BiteiNRViPBr0CwboqEZYIx79EzWnZ7MpDCzsAqSIlg73uf7QVa8UD0nGLJtrhAyebIx7nxOOyrHF+kT3SZrGFSXM01fgtRGiwDAQieEhKu6vFnxqxTf7iWnjdM+lQkPMVPE5zh1kHzhEODaks7PYgOVyy2h+igKQWKKVOSTV6Mq6tzrnQAcL/54183qrPN55uAztIZBNvZePgCn1VOXWwwJ4stnTL0XGQjAyO5LQeae2ECreLGl7RXl6l6dFalicEpuklA/8rkjqAQ2GnITIUtPpArQg56p0YCSkmjWAtQVNb5nr+koYSmsxmjVzvc4oFhhrC/Wv7KyEnP/xoD4Ez0r4UCsEq7Ypkml27mOCzPGueDrLWx+XY2FCJfLyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(136003)(366004)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2906002)(36756003)(2616005)(41300700001)(26005)(6512007)(66556008)(53546011)(6506007)(83380400001)(31696002)(478600001)(316002)(6636002)(66476007)(66946007)(86362001)(6486002)(31686004)(38100700002)(44832011)(8676002)(8936002)(4326008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWo2MU5LNlZyQ2k4OVRkQklCSmpWL0QrTW1kS21Pc3k0WVdXYVd5akNUdy9r?=
 =?utf-8?B?ejZpajI4VVRwUG93ZGU3M0tmU05oQnloQ2xWTHlnRHJrd2sxdWR2QUd6NHpR?=
 =?utf-8?B?QzJ1REhTMXlNUkwvdktZVDNBRVg5cGZNNStHZlVhVzJBaWdKTkZMZkVraWNr?=
 =?utf-8?B?a3JkVC9WdkVsNFhwd2F5QVo3SVRYWVJZZk4yMitxZWxBczN5L0tCL3phYkFV?=
 =?utf-8?B?TEpjUldZVE9NNTBCVERnRkVpVnEvR3F1Z1NiRkpXU0pFRWdKd2E0UUREb1dP?=
 =?utf-8?B?bXNHa3lTRS9CcWw4RkUvQmZLZlQrRXVYdDlkUlFGaTFhR24veFplZENjUHIv?=
 =?utf-8?B?YUh5SnorK3FWYlZxcG5PVDNJWENvZVlnTm1jc01uL0djKzBxZzJjV3dlK0dJ?=
 =?utf-8?B?dlhBaWhZNVZLdktZQ1FOYzFaMU8wVVhHR3piY2pBTXEvVVU1b1h6NW1NRXNt?=
 =?utf-8?B?Yk1SY3VYdVcvK2lWbFhYV2w5SzA3QnFNUGFKV0cvL3p4OFNpVkNlaEtFTGN3?=
 =?utf-8?B?aElwMmNReS9oZ0hNSStjYmxSd2ZGcGVOK2hHZm1selRnMTFHeEs0emxMdURU?=
 =?utf-8?B?Lysraml0TXV2RXJ6dGllczNpZHhhbEZJL1VBcVdCZzZXNE9sbzFqR0cyVm5j?=
 =?utf-8?B?OHMrbUUvenN6d2o3VHFtSkd1ak1OVzUyQkdiSTlDM21jd2luSFhWc3NXT1E4?=
 =?utf-8?B?MmNGdm9lKzZmNzJDQ0FXU1BBQmErQ2VlMU4xdzNoTXB2ZUJUZE9ZMjBseFNU?=
 =?utf-8?B?eldvWmF2T3duQmdMREhCTHJUTkZuVUt0UjFXNDdMYUJ3NXpQRUdmRnBOeGpj?=
 =?utf-8?B?UkVFR013SHF3d1NWM1NTZW1pU0ZaZWtIOUFsTXhpeHNpQzBiejBXOXZuK3JT?=
 =?utf-8?B?SktZd3V6SWNkM1FVdEVHSkdVY3oxcllSUHlPSjQ1WG91VFh5eDU2L0ZSZmVm?=
 =?utf-8?B?RUlVMU1tSVZHaHhSMkZWUklDWXJPZ01yUTVpcDd3Q2NCQUpXcE8wMWVKSm9O?=
 =?utf-8?B?S2ZEZzlicU9FQzluMS9haHcyM1pXWkF5akVQM3B1Z3QzOWhoSlRmUk8xTGNs?=
 =?utf-8?B?VjNRQkxQTzEvMW9ybWJoQm9IVGVjRUpVOHRIK2huRWdDTW9Ta21WUmhlTTl4?=
 =?utf-8?B?Wlo5NmM5ckoxRnZXb210LzNqYW5laUxmNTJyd1BuakcrNXM2NFhiQTVZbG9D?=
 =?utf-8?B?UFlFcEM1djhrb2thMy9PTGxzU0V3ZDFjVnQzUTlmQ29Pemp4ZXIxelhDVmwy?=
 =?utf-8?B?QnFEYitKVWd1MnUwbkFaMldtSVYxV2dGWlF6MW1xRWd5NktGUXZFZDBQQVR3?=
 =?utf-8?B?N0FFVkFwaEtnckxEYjNzcTMrZkRMenFqamREc00yTGZ3ZG1UcGxONXRBWlBG?=
 =?utf-8?B?Tlp3TldyT1ZvVWVqZG1FQTJBd0Z2bWN5YUtNQnFaY3dlamxpK0w3SEhYTXpo?=
 =?utf-8?B?YkFBV3NkTmsyaVdyN240M1hFdU1yUllOVE9xUzRDOVg3OXZHbXRaalpCNlAx?=
 =?utf-8?B?V3ZQRWUyVkN0RXBUMm1BSzQ0cVdFTktCb1NyM3ZLeWQ3V2NsSEY0cDhSeWlN?=
 =?utf-8?B?VEFzRkh0OExOZWdxR2x1TDB6UUZNRUhzMm5IRnpTbU13S2dKbXh3MHpyOERZ?=
 =?utf-8?B?UUd5WTFaSnJtMU9EZGpUT0YxRVNVSWRQbzlPY2poN2taTi8wUzl1RHNMY0Zl?=
 =?utf-8?B?c2ppVTlURzZFTFBNa2dQKzZhTnRqd0dpajU3TVkrYTF0d3JRQ2UyL2doS21l?=
 =?utf-8?B?aFAvTS9lemdoMzRLMnhuQTIwMTdGV2dyTXpjUUhLRDZRbzNObjVTMGdqZjR6?=
 =?utf-8?B?NG5OeFc4Y3RLRTZ2ak9wZGgyRkNuVVVma3A5bjFGMnVkWG1XRFNFTUtwYXE2?=
 =?utf-8?B?VGtMakIzYVF0cy9xWDh2a1VXVmFlekpsMXo0bzdrVzNVQk9oWFhUekJTdU01?=
 =?utf-8?B?eVJiZkF2VnRTYTdWNGY2Y2RFaHlUdlpzMnp6VHcyUHMzNmRpaE9JTWtJSWxq?=
 =?utf-8?B?VGZ4ZzlzUjZ5ZDFKcUo0cDFLSnVRU0ZsQTRJK3FFYUxYcXhwTHhWZmlpdlJq?=
 =?utf-8?B?WE5ISStRelRQZnFuNmVhN3UvcDJDb2JVRXE0RDU4NC9JWW9PYit6U2pQOW5p?=
 =?utf-8?Q?FaNlddALg5R5zMxv2wtllT718?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354a455a-546c-4aad-39ed-08dc21cd55ed
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:54:57.4953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mE8ndXM5hGY6yQ/27uEqup/QD1twIA6nAD+oStRuKwPoQoIOsqi2pP8DUjJ6FGSJsfGClXJtnSgkfLUStZNO2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7172

On 1/29/2024 23:56, Perry Yuan wrote:
> EPB feature is not supported by AMD CPU, remove the unsupported options
> to advoid confusion for the failure result when using the parameters.
> 
> Here is the new help output with  below command.
> $ sudo ./x86_energy_perf_policy -h
> 
> ./x86_energy_perf_policy [options] [scope][field value]
> scope: --cpu cpu-list [--hwp-use-pkg #] | --pkg pkg-list
> field: --all | --hwp-epp | --hwp-min | --hwp-max | --hwp-desired
> other: --hwp-enable | --turbo-enable (0 | 1) | --help | --force
> value: ( # | "normal" | "performance" | "balance-performance" |
> "balance-power"| "power")
> --hwp-window usec
> ./x86_energy_perf_policy: [-c cpu] [-v] (-r | policy-value )
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   .../x86_energy_perf_policy.c                      | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> index 7bc668d22728..ada1aaabad8c 100644
> --- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> +++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> @@ -105,13 +105,18 @@ void usage(void)
>   {
>   	fprintf(stderr, "%s [options] [scope][field value]\n", progname);
>   	fprintf(stderr, "scope: --cpu cpu-list [--hwp-use-pkg #] | --pkg pkg-list\n");
> -	fprintf(stderr, "field: --all | --epb | --hwp-epp | --hwp-min | --hwp-max | --hwp-desired\n");
> +
> +	if (genuine_intel)
> +		fprintf(stderr, "field: --all | --epb | --hwp-epp | --hwp-min | --hwp-max | --hwp-desired\n");
> +	else if (authentic_amd)
> +		fprintf(stderr, "field: --all | --hwp-epp | --hwp-min | --hwp-max | --hwp-desired\n");
> +
>   	fprintf(stderr, "other: --hwp-enable | --turbo-enable (0 | 1) | --help | --force\n");
>   	fprintf(stderr,
>   		"value: ( # | \"normal\" | \"performance\" | \"balance-performance\" | \"balance-power\"| \"power\")\n");
>   	fprintf(stderr, "--hwp-window usec\n");
> -
> -	fprintf(stderr, "Specify only Energy Performance BIAS (legacy usage):\n");
> +	if (genuine_intel)
> +		fprintf(stderr, "Specify only Energy Performance BIAS (legacy usage):\n");
>   	fprintf(stderr, "%s: [-c cpu] [-v] (-r | policy-value )\n", progname);
>   
>   	exit(1);
> @@ -1309,7 +1314,7 @@ int update_cpu_msrs(int cpu)
>   	unsigned long long msr;
>   	int epb;
>   
> -	if (update_epb) {
> +	if (update_epb && genuine_intel) {
>   		epb = get_epb(cpu);
>   		set_epb(cpu, new_epb);
>   
> @@ -1318,7 +1323,7 @@ int update_cpu_msrs(int cpu)
>   				cpu, epb, (unsigned int) new_epb);
>   	}
>   
> -	if (update_turbo) {
> +	if (update_turbo && genuine_intel) {
>   		int turbo_is_present_and_disabled;
>   
>   		intel_get_msr(cpu, MSR_IA32_MISC_ENABLE, &msr);


