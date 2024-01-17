Return-Path: <linux-kernel+bounces-29467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBB8830EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B25EB21192
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9752E2557B;
	Wed, 17 Jan 2024 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="J8rGgR+u"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2101.outbound.protection.outlook.com [40.107.93.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFE063A5;
	Wed, 17 Jan 2024 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705527537; cv=fail; b=V2CchFBuFikiDM21d1EHO6wBXxCOi7zualslRNdSukHHmVo7fZufdsYaxdIDGNqEXLWOW8DbbJg0ZJgPFBe0udfJVKTYz2idby5HR5r+KIdCQE5XAUOIf/lz1ONG3dPiXUVaruJYGL+UkJtYxctffq6e4NBu5NAySWXmcgFMELk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705527537; c=relaxed/simple;
	bh=wh00fxBG/Kx1ht8TWYj2EhqGHlm67X4WnIGJ1cSAG40=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=j0dzN5HYHLTXhD+LdxXRTFqFIptuc0p7n7k9fhM+lpX3Wjub0ngd6gbE+7YhsC80paaIBAYFEIjNZLghqo2ulvGuoPw78O3iCzmn9OwYe25CGG2U/en129rKXvsiSwUHsc2o4C6vSX7HnIOCX7dBxXOvP3o2UZAK2ghlh9Vc5F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=J8rGgR+u; arc=fail smtp.client-ip=40.107.93.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIbZSGdNZNCKXKNAo2kI7lc8KHYTGDls8TmktClYkCcJ80RTE5sxDO/PgUC8GWxLGswwO+yp/k9wmCIf+uAfgqDM+YLMAlsTx5J4DMkHjz3FKPFHANXy3y9KBuM8FNix9a14TGZ5flIiGdrv5bvtzpUVpBA1gkapu/Q7Oix6qsHSHWGQgHMfEWkY8OeXZYep9aJ9HNGNYPrurmYivEidoX9jPvlO9LSXXpGFLx+Hht1M4Lno7oUeiyKxyyiJxE+0+YUtgSovq3tcfFYZv2ZFchTIIGOIAb79wTJ591gSPnbXvI9BhMMOEgUYIIPA+tHJvMHxCHcks+iIz2/eb++I0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6xOSn5HHPZni32V7XGYGwCtMwu0uY7JZ0CUKoDQbQo=;
 b=NKz5BS/MbJ9mU7OfJ2L/f1+os8STxGPjsk7hjogLJtc5uwOGy5Wr9bQjo1EVhej2C1ACkQqfMcNeO4pMtl+hFJCniW/fcx5LFHAJ3oa3ljS3t4Lg7s0slqA5mG7M6gOsRsLdl6LResWt0daKVEHX8Zg+W9MSAVB86Mv12SXDUUvjL2OA9pgeg5nKiTG8SJ9/wrQgN1GBfdieK9RK0fmhhBe8uB3hRjYDlgjk63to83AeEGr2eTs9kAxmJZKd6OYJAj+oAtNcL+XSF9KNN3+yV6uQmPGUMJYZk5ewyEaSTvMgngd8Z/eunMLvluVN2tQ1mEgFRXf3wj3EcWWxwNaSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6xOSn5HHPZni32V7XGYGwCtMwu0uY7JZ0CUKoDQbQo=;
 b=J8rGgR+u9X+u7DqzH201cFXzTOHjIOss1locdcP1za1X9LxUIsw4qC++6AoR6seWEUTydhhE47SS5iYqf2+DLCpHWX7R6HOZPMjBYHJCoSMSvVLoZUJ8sMATO+i6Id3xlS4p/FL4yBfGQIksNC1jOdsi6Pz9ZTZvNmtDssG8arA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB8166.prod.exchangelabs.com (2603:10b6:510:293::17) by
 BY3PR01MB6578.prod.exchangelabs.com (2603:10b6:a03:364::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.23; Wed, 17 Jan 2024 21:38:51 +0000
Received: from PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::5549:ab3d:70af:8693]) by PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::5549:ab3d:70af:8693%7]) with mapi id 15.20.7202.024; Wed, 17 Jan 2024
 21:38:50 +0000
Date: Wed, 17 Jan 2024 13:38:37 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: James Clark <james.clark@arm.com>
cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
    Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2] perf data convert: Fix segfault when converting to
 json on arm64
In-Reply-To: <19913e91-b055-d767-2cb8-c6bc53671728@arm.com>
Message-ID: <afa5f15-1898-3731-c275-397e41b3c8f3@os.amperecomputing.com>
References: <20240117071331.59725-1-ilkka@os.amperecomputing.com> <19913e91-b055-d767-2cb8-c6bc53671728@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH2PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:610:58::12) To PH0PR01MB8166.prod.exchangelabs.com
 (2603:10b6:510:293::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB8166:EE_|BY3PR01MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c357e33-e433-48aa-df53-08dc17a4b1dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4DKjAwM6L/poEpKqrS0BjQxyvDLd4RcKZio6RLyZiyCgDVQXDGKtq2UQi+kC55wdpJsZE1aSPxg8pHChsb2ixSbRqJgCPkIHRs7VWRY0Oy+SkItdJ1C0An6uF+1kjWK2Fe9PvvA3ZkQgQKPHJLg4WlLHy+3rF12GscqtaB/+Ij9GzSnJVNozlChNtmJn2x/FavHg4Zman2/3BvVQjcLqXoeSCR11n5I8e0c4SgPHbBIg3U9Y6sqOXZdOfelnYnGdpMvFy4RGMRh2Pw0jKUdJToxDfWwW37yyS/5BS0UlIb/Dju7EZ5JUfL8FPkJqM4o7P8Spd2RDcWZVqUpGzgiCNJczmKYrbx1Eps76PcSro5wMqIHQ6sDzD51SM86KUQgzzeRonznVXh2maLuqvYmDb49I43iJ1msVbgJlAjRTGGTV8eLGGLkVjX3wflW9BNjN7RfV4dSQ3pgC1NdMZhzOgqxXxMxI0PxDEy7b6/LfmT2b3WHMmIa1mo8CRcnnaEKepOlvHItJWs2cnUdPL8jB4imYoFwYQusjXlx9qalcKpAi1I0uqM5BnUPctyBSQFICnsKYVfJ+WW5DnFj9azY4mtB95nbocZy1Q1Z4MFruQaU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB8166.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39850400004)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6506007)(26005)(6666004)(6512007)(86362001)(2616005)(53546011)(52116002)(5660300002)(7416002)(8676002)(4326008)(41300700001)(83380400001)(8936002)(966005)(6486002)(66946007)(316002)(54906003)(6916009)(66476007)(66556008)(478600001)(2906002)(38100700002)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NG64OKRWe8ToW+b7o9RtmK7p1q9Rgxku9cQw0GXX1kste8MZDE3I3cdGiwnY?=
 =?us-ascii?Q?KzUc8bWAfkqfSW0EURp8i+JrLtSZUEWJTqiRvQJOyUKbZl/bti01uUbWtiIj?=
 =?us-ascii?Q?gKbWUXQ43A0I64KBDAeg9BkJi6gPqfse/jt3H1VqOfp9rZrI5JXqa0cgb9hi?=
 =?us-ascii?Q?N9UkSHG2UFLZ/1QhTn8uQwOCymzmSzwa5LyMaMUeQc2u+6poPe7Zemr+9bNX?=
 =?us-ascii?Q?XR1OZEaHVeKBe78TlRjL4S3BbLvmwHDNPauTmeXZ0jHTR+7KZR+2HgHoBt91?=
 =?us-ascii?Q?d4/Rmwq2aApygKUQ/XAUOOLO0r7wSSzsFymoswvs3QkwSa7JBjt3KKzhl1Dk?=
 =?us-ascii?Q?+9c7MriNl4piS7pkudyC6X6BMF1maibhMF8k2zTeHg+ntkjt5iM+NQ517Hjo?=
 =?us-ascii?Q?fWxbwch9YMO7SukqHHMeQxBiPPAue+ioIMpW5WEzgImmJ4FJ2wiMMkb8JVbz?=
 =?us-ascii?Q?M5LmSqwkFfT0WDvNqqPAufpgg8eFxbl65rG21HMV0ApPZRs+G5AuWPDdkjkR?=
 =?us-ascii?Q?66RENVWInOKW+lwtbIqzhEkvQBIkhEYCR53Bg15vH6mnhbfcIH0DMr6DOSEi?=
 =?us-ascii?Q?LlImaDA4FX5lmOdCPhYC7HuvxD26Jv5wTXsvAMhjldyP6zbJa7BDJw5uIu16?=
 =?us-ascii?Q?aOot9emZhv4dP7tQtkCBsOTqRONVEdQw3DQMUwamEwmvSwcHy6jvi821ma3j?=
 =?us-ascii?Q?vMKPXW5phu9wKLU36MSMpeALzyYQcGerhkB2uKxNS20ZTfc1Rdom4ptTiR9T?=
 =?us-ascii?Q?GKhP0bw87G7AyxDqZpZdtpUXVh3edP5NcMW4t8KLtiSNjDW44ijbVXPp6K0I?=
 =?us-ascii?Q?VyOdyAPJS9IvOuSTVRHGb/zubCXJDXSua/Xq7Tr1icO8+QX+010ksMVqEWuC?=
 =?us-ascii?Q?GmvCedkGCtoNNIjTiCGGVtkJaQYa51xYRhzx3JbNqr/kidzoponuAjx6EMZ9?=
 =?us-ascii?Q?UCoaW1VT+n5omiLnhAvE5DDjrHBGnLkxIHGoVwQskZqilxqgwkDbCkK2JTIa?=
 =?us-ascii?Q?xGb0OnVwzrnI4HVRzuGS+80YdRp+NT6+aWaEUd35+agOpo4x8vmTWyq6HI0M?=
 =?us-ascii?Q?MU1NyjDZ2qYUuk7G2HUw9smFSQV6vUByhIyCPr69IrtMlah2vMh781OxfLAf?=
 =?us-ascii?Q?3yWZb5FlBNLrAL6EDTWI36DUzupB1CNL88U8Du01wW5ZbgewI0/9AJKQVnTV?=
 =?us-ascii?Q?hscD65ilh872e8DDPs4L6BsRb9EwwFLNnVIhCu37E3y7P6ZbipRF0OSrB8i+?=
 =?us-ascii?Q?T0fWORq63drcXpSbKkgJlflN+bEEw6kP53y3pYwaxwigqpb144XsSoNHnTNQ?=
 =?us-ascii?Q?v8e702pdZ4WZ8F1TGSFZATlwxtFIJQY8n1FfOuu1gGEqbKQUc+yGw01ruWYj?=
 =?us-ascii?Q?kEr8MPMk0ejcNFyyLqiSQIv+9h8PsqsyXM5SU33DiC5NeA3Byff3BMvmSs1z?=
 =?us-ascii?Q?nE8Jd1264FeHXVovfS217a7yO/9Jj/kH0LxfeKheeuXaFKx47hXio+bK5kjs?=
 =?us-ascii?Q?dgrPY8zNjV74ukKfnZ6ujDMGe8CRjm9nnLC5TX6nBtLu1kPLfiMtVuo/5jaL?=
 =?us-ascii?Q?4b2iT6WPaKpBEDTfjrBFfniI9ZXOtfOcfG51AL1AgeafunIYSDQNcAn3RyEA?=
 =?us-ascii?Q?JJ+S4GlTHp+xQXTlZNLfMpU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c357e33-e433-48aa-df53-08dc17a4b1dc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB8166.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 21:38:50.7520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJCmqZd3irq9FNbbyPKAngoisMsveYbrRycvo2M7K51TBstJj4KmtYiBVdEG+LVQwss3EFy2ZiQiQg0Rl4J6LfWYggFE5LHjGTi0HlRnk2w6uqc+4rRAiUTxoSYlwp0R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6578



On Wed, 17 Jan 2024, James Clark wrote:

>
>
> On 17/01/2024 07:13, Ilkka Koskinen wrote:
>> Arm64 doesn't have Model in /proc/cpuinfo and, thus, cpu_desc doesn't get
>> assigned.
>>
>> Running
>> 	$ perf data convert --to-json perf.data.json
>>
>> ends up calling output_json_string() with NULL pointer, which causes a
>> segmentation fault.
>>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>> v1:
>> 	- https://lore.kernel.org/all/20240111232923.8138-1-ilkka@os.amperecomputing.com/
>> v2:
>> 	- Changed the patch based on James's comments.
>> ---
>> tools/perf/util/data-convert-json.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
>> index 5bb3c2ba95ca..e8b006c3581f 100644
>> --- a/tools/perf/util/data-convert-json.c
>> +++ b/tools/perf/util/data-convert-json.c
>> @@ -284,7 +284,13 @@ static void output_headers(struct perf_session *session, struct convert_json *c)
>>  	output_json_key_string(out, true, 2, "os-release", header->env.os_release);
>>  	output_json_key_string(out, true, 2, "arch", header->env.arch);
>>
>> +#if !defined(__aarch64__)
>
> I think this needs to read from header->env.arch, otherwise it won't
> work if you run data convert on another machine.
>
> I'm assuming that perf data convert is one of the commands that runs on
> a pre-recorded file, rather than a command that creates the perf.data
> file to begin with?

Oh, right. I'll fix it right away.

Cheers, Ilkka

>
>> +	/*
>> +	 * arm64 doesn't have Model section in /proc/cpuinfo and, thus, cpu-desc
>> +	 * is not set.
>> +	 */
>>  	output_json_key_string(out, true, 2, "cpu-desc", header->env.cpu_desc);
>> +#endif
>>  	output_json_key_string(out, true, 2, "cpuid", header->env.cpuid);
>>  	output_json_key_format(out, true, 2, "nrcpus-online", "%u", header->env.nr_cpus_online);
>>  	output_json_key_format(out, true, 2, "nrcpus-avail", "%u", header->env.nr_cpus_avail);
>

