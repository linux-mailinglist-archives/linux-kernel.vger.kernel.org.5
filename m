Return-Path: <linux-kernel+bounces-50005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E388472EB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC60628359F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B28413E200;
	Fri,  2 Feb 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5bFs81fr"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9198083CCF;
	Fri,  2 Feb 2024 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887036; cv=fail; b=g8z2fD/lUB+xVcipWEFh3aldwuyG4EQ3dgXC9pyOC10v29wr6E6BQj0aHGJQp6dNjF4BuUdRBgsbTl9mGUqFeVHNESvlqj/lsmQtWehHz0hDXi1A/FWCxfWrnKtwiJPczs6dttmAWltJxLFeUhfyzVze5nmsizdNVsKobIxxmpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887036; c=relaxed/simple;
	bh=p16mZ9B6RZxYoN8q5yFPH3a4wMUPzHvKy5T419C0DEI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z6Y393JBdmE6bM2BZFWVerkWxxI1TCAz7mKlutYngJk8tidMC7JApsmdMOvF+VHfAbrLZQENBWAfUAP6F9CYL6cz5WbTZiT1FsQjAJFM4e/FTaEhI7d5W81HtLUW1k4LryKjpgi5pz78Lpp/r0i66hrJIrtMQK+0pxTkG1+4/ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5bFs81fr; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLQKFPqT7ge/Gm8mRCowTVN3d3OQ4U4G4mR52NKFLfSgSvcDQoUEv8AQaBFpIqi3fql2fNyW/aStSMAdFZJiFjd9Rh8JFEJmUaprf0JnasDtvkVar5uTnbE0J/B4lRq/TbMQuOEdt09FvaQFNFYWFUanN/TT8ZAxxzlCzKQXH+7qBTxtMkutiO6hblF4xO4Tja61ozawb6+VYQv0n8awCXQNbgfPxKzcxg32xEuY1Jggz2UmnFYdo5Ywfldd9EDyQq3fVgOw1WtDi5xnad90tXpdMsYvecYk4JXDAwZBgMbVFifhTu+3G9JT/LXS5rL5JIaXU8lHXdHQ3lQa+jKw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rrbzbpa7AXEJ2/ON1hskK6ThQqtGdOepC0Mcly7bwM=;
 b=WSgjYeSKaLY4smPPI9xlmNr9AMhwameM+m6Vxruip8gRGUz7yCwK5EWG8ICvlW5EwKucSgRp0ZpkU/4nzL85uMQBh9QueXtdaXd5hLshY7YdpLoR6h4ZOjXLTjm1IwlQEv41qzXBvNArSnHrmpiAai3HGcBAqMv7efuhagp8VPgilJMurmbxsHpE17lUZPHdwuk7OjjsSaW3B8KLV1s4vpp/PsrcbzKCyML0/gIBVlikS7mVfuabqlNo1q2V5IxHEPQF/Zc99Q4bh50DXv6PbJbPBLLr7RFMo7qCbyGk6U5B8o30rNyq644JKvfvQft4w2TITDXZIRRLFfI3Sf6GLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rrbzbpa7AXEJ2/ON1hskK6ThQqtGdOepC0Mcly7bwM=;
 b=5bFs81fr7yBrwZC157cYmOEAoC59Z9bixFB5CK6m3M2HBOhi7yMIuICqdMiPPKH6cqmNp3hWq0gtEK1dPLk+A4kwwWyfvfNg+vImAMFiRn7x+13gOYcEic7yDp3vPYpXb5E0eAQGyUmojLy7sRxrdlP72zuW2qZgR8w05jhcEn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6703.namprd12.prod.outlook.com (2603:10b6:806:253::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Fri, 2 Feb
 2024 15:17:11 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7249.024; Fri, 2 Feb 2024
 15:17:11 +0000
Message-ID: <70494a84-d5ee-4050-87b9-f4356ef23a13@amd.com>
Date: Fri, 2 Feb 2024 09:17:10 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] cppc_acpi: print error message if CPPC is
 unsupported
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706863981.git.perry.yuan@amd.com>
 <7ff16a39e508eeadf26afbffb2f621de180bcde8.1706863981.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <7ff16a39e508eeadf26afbffb2f621de180bcde8.1706863981.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0208.namprd04.prod.outlook.com
 (2603:10b6:806:126::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be8cf12-bdff-4488-5a9e-08dc240207a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C1b6I7jgDbyofi+ul0eT1tpA9awx80CDGB5ZvqEgmQcM6YiEBVwPn89hSORguC67Riz3gTMxwOJVEqM4X0xaBcGu/lYARABl0Aru+rwykqr0va7g12orXyc/20v45Z0pGRYYXFi6nwOmSJji1vQk25JsQc2q9wZZYdMibXCf9VGeMznnPGn9HnghKcrOq8ajegzfX634eD6de1dppnKj3VN79/1GCHR5k6YvhRcW4njiS5n8+DnsNOk7CcagwDUlB+frSMwiAWatJegBb27F5bax0NML+Ik+r9mFiEUcEUuZ3CfvrMfdrB4mgLcn2pg+h4UZ3brcsiPiU+eb1YWghExMgyqycMtHN4YfKjwJNyyZkoT4l14wD03Td9uwUTABnq7Wu7dn/aa/4Gvsc5QSo2PyE0zmYz8Nf/yFenY0GO3rd6pUN4O61MsPxVprtzBbAl43Hhmjqfcl+iqzwDe7Vj2yomK7qxFqDgxiN06deYhMhbxyujREHqA+hrrAtxOAlVt0Sxt2V9z3o5a1Ql+zPTCXg/wrRmlXmxJttTCz/txnleI39tldeMRKRXY60sQ8vnzjDJZNYqTEVoy6aOD+KvQTNfKOGeOQi/KE8ylida6+k8txq8BUkoRkuXRjq9cCkSJDCF3fz7AAghL+RVudHg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(366004)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(83380400001)(26005)(53546011)(6486002)(6506007)(478600001)(41300700001)(6512007)(36756003)(8676002)(8936002)(4326008)(66556008)(44832011)(66476007)(6636002)(316002)(66946007)(2906002)(5660300002)(38100700002)(31686004)(31696002)(15650500001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE1DcDBteVNLYkFYYVVIcWVjcWZNaGJzbFFaMDFqaXJxVlZ6TUNpak85RnMv?=
 =?utf-8?B?dUxyZ3ZNNE9wVStzVDcwQWhhNjZDalNjdFE4dWc5MUI3QkNwQUJGa28yU0Qz?=
 =?utf-8?B?MnBhRFJobmhqZGEvSXBNTXhrMlhFM2hGc253R2U2bGhnSWY5dXJKb3hLcVZE?=
 =?utf-8?B?VDMraGtDR3lFbEwrc2pZaC9SRVBxRU91VGN4VXIwbTQ3YmRsdllOU2JjTnU2?=
 =?utf-8?B?cC83WVZzUVVySzlBQXFEUDBJdjdSWEFRYTRRWFJVTjZNNHJBL2h1MWJpVlgw?=
 =?utf-8?B?TW1FMDdEa2lXUEh3S2JlV0NsZlU1OXlLd21MUjRIdFZzMCtROFhJL0RpNGZv?=
 =?utf-8?B?SFdHbmloNUZLWWRJUFQ3MjZobGNpbVhqTjdSVjdUbHhRK1Z3RmhnaDFQYVpy?=
 =?utf-8?B?aW93R1JHQm5QUDNvbm5hM25meE1pdXl0NUdkV0hYTFhIUVR2ck9FNjBKNUNw?=
 =?utf-8?B?dzVUdFBobGxzRVFGNUxTQXBNVTA0RlZkM2pLNjk2U0EzWTFmdlpkZmFoWFAz?=
 =?utf-8?B?Y1pXUGVZTWdHakRjZVhXMVRvQndZditEMmJwR2piRHZoakt6SFo0enlNb2Zo?=
 =?utf-8?B?NFZuaGVQM2hTV2xvRXQ3NFF0R1pERmsxK3BPMWV4cGNWRXNqcGY5U05DdHR2?=
 =?utf-8?B?d3VrbXZGd3JmRVRmb214TXU1MzZYaU1EbUxMQkd1SG5ZUGN3RGx6Vi9OM0VK?=
 =?utf-8?B?OCtFWW16d1k3QVVoaERPemJkUURGemxXVVUrSVZmcWFjdlg5UjhUNjhYUVRN?=
 =?utf-8?B?VXI3YjdaREhZMzZHeEtGNXlQa3QwbFVDNDVKRE43Zy9BZmRqd09xd2kxWWZO?=
 =?utf-8?B?Ykg1YTRjUWtDNkF0MVNiNDJlSWQ3T3l6WUZqY3dlNERPSng5LzVIdW82SEd1?=
 =?utf-8?B?bzlzZmcydjBiNXVSK3RTeGRxYUZjKzdlbmd5QzhwOFZMNTM0Zi9YT25sTWVC?=
 =?utf-8?B?dkxxVVFOZk00SjFxNHNQTk9waGRrbEc5WU9tc3BleFdHM1hrVTNTS3UzQTVJ?=
 =?utf-8?B?SW04UFYxY1BqaFJUcGEwOG8wdDFJV2p2ekJmYndiRER6ZFRHc2U2dWZlYjlX?=
 =?utf-8?B?QXRRSklQeWRDVFplQXZPWmxTUys2eU5HYWpEZ2ZUbFRNbzM0KzFhNkNMcFoz?=
 =?utf-8?B?cy9LZzlucms5RWlFa1IzcE0wQldhQlpGOUd1bXBkVDVFNnZuNmFsSWJLYi9C?=
 =?utf-8?B?eG95R1ZKNS9ab01yZ283MVMwVXlHS3VxbzM5bTlKVUw4UGwwUnNZNE1PbVZn?=
 =?utf-8?B?K21EWmRXZUNMV3BLdXBWbmsyY0Z6UCtnSnQyZjRQS1hXNkQ2Z0JwUWR0VTVy?=
 =?utf-8?B?cU5FUW41b0NxV0ZUMjJuQWcvN1dxeWVKWW5FNEMzQXJRcnlaUFkyWmxkK0V1?=
 =?utf-8?B?Z0FBYkJzZzhyeGJuU3Q3QWdNUFViNWdjZFMvek00NjJCRW1tbTJvTXdoY3pT?=
 =?utf-8?B?S1dZOFZVbSt0bDd4SDZucFFoeWlFeWtkaGQ1ci94SC9Ta2Ribkt1QUg1QTBU?=
 =?utf-8?B?VmlVQTNrS2xvbnZnSk9oblZjcHdpQ1BxaFc1a2NjcWhRZTRqMHpKYTRRQzVJ?=
 =?utf-8?B?ZDNZSWxRODdrY3VocWZTSUhSanFsZkdGSW0xZ1hRdks3aitLamhnT1NVV0dQ?=
 =?utf-8?B?QWhOYk10ZHE0NkRhOHVBU2t4c3NzUFpnWC96MisxbkxYa1piOWJFL21hKzQ3?=
 =?utf-8?B?TGVER09mQkk0VndGTjNxZW0yTkdicW9XdUE5SXd1NWNFbzlaS0VsSVphV3lP?=
 =?utf-8?B?RkN0Zno2N3JDNFBZM2V2WXg3bzk3VjhDangwVDZSUk4rcEZNaSsrcGdGNVJT?=
 =?utf-8?B?bHFqVHg2UlNRMDFOV28xaCtKZUpKcm1ISkx5clJIc2YyQXYzWVpqc2JjQnd6?=
 =?utf-8?B?VFNkOGFnb0svOVhUdnBQNjRtS2FYem5oNEpJZXpUNFJPZEFTeVpaQmN2TUFq?=
 =?utf-8?B?a0E5VnJoR0tVRVNSY0wrK2R0VXoyKy92bVkydzFzcUhaOWQrUjR6YzNzcCtH?=
 =?utf-8?B?MFNkVGQ0Z0lWS2U5OWZKVmNxMkpTZklWeWJnR0w4QjUwMjAzV0twL3d4YlFt?=
 =?utf-8?B?ZWNDblptbURXMjJqbkFFWmlNVzl3Vzc2b2sweWZ0NGtXb2RpckhlTmVuNmVV?=
 =?utf-8?Q?V8aMrrKWJaHf9XPkNV3lQ/LOe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be8cf12-bdff-4488-5a9e-08dc240207a9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:17:11.8537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEIH4zllRuGHRv24ogkDGq5hVLslweqoksugXPKsWUSmLkpaNUHhx/dOD1WuSiC7QRyyncpXxVBUozN9kkL13g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703

On 2/2/2024 02:55, Perry Yuan wrote:
> to be more clear what is wrong with CPPC when pstate driver failed to
> load which has dependency on the CPPC capabilities.
> 
> Add one more debug message to notify user if CPPC is not supported by
> the CPU, then it will be easy to find out what need to fix for pstate
> driver loading issue.
> 
> [    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
> 
> Above message is not clear enough to verify whether CPPC is not supported.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/cppc_acpi.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a50e70abdf19..e23a84f4a50a 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -679,8 +679,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>   
>   	if (!osc_sb_cppc2_support_acked) {
>   		pr_debug("CPPC v2 _OSC not acked\n");
> -		if (!cpc_supported_by_cpu())
> +		if (!cpc_supported_by_cpu()) {
> +			pr_debug("CPPC is not supported by the CPU\n");
>   			return -ENODEV;
> +		}
>   	}
>   
>   	/* Parse the ACPI _CPC table for this CPU. */


