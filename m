Return-Path: <linux-kernel+bounces-77421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC24D860500
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACCF1C24D97
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4F912D1F6;
	Thu, 22 Feb 2024 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="s1l/G3Rt"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2118.outbound.protection.outlook.com [40.107.243.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A170673F3D;
	Thu, 22 Feb 2024 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708638163; cv=fail; b=S+neUMm1sPCcc0oeNiKRG/qy5svM+ZblxIoFgOdqihFHah9WRZxpLS6Yyk2Xsi+GHYvvtkkvht/giA75Fe8aeFxDbjzrz7o2Eohh7VCQ7sK34432YqRqdA3SVfSW5bjl1Dw3PI1+La6DkKeIiicF94ac3CXgFQEHrtSezPJ1Lj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708638163; c=relaxed/simple;
	bh=7JQL/CBjfivtvWPLkafk7sJB6jES0+0Js0HXuO9eaN0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=nPz+pN7hPWcGkyc1Eyoqzt8Fbg/g+oSVktmt3Km0te54Yg9px08v9uzHFGAj2kOJ3ESC5h5ewcE8RbyoXStBf6D6EcbWflVctzAclcUPXg8UyDB0qYgYeOl8rPxUC0+e9UDmjyN/Q08t1k7tXM0ArU/dLtx7yA7yex3B9ovlrdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=s1l/G3Rt; arc=fail smtp.client-ip=40.107.243.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLxhMpz3igDlu1T3Q/tMcGN4iwHsR4DbXqBIb4IXJdh4Y9YJB/nGVes3bOv/KB4cdn0wKlZ7fGixCLVhN9UWCVYhfrpP+UtxqkYIcLEjzCQLoJj5qIM9SO8VbegoV0aTgDpKyQqkqz/cAi6gBE92y8+XoqGfJIeuvlFYS8UdX1V0yW72g9Vyz4BQXSvrBq6K6AyRR3s9mwfM861iXNIfBOdHUfGHIRA4g6WH/7PfD+kqy2gSaIdBsUC+hYUpe5h8KHKMuNdX7iI/zp9V1xlsXnT47brfqjMhOOuelsanUuM8hA9ongfj4o41uuo/pclAsTS0ICzALNzhIKbPpuUNeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07ezkU9OaqIh8xJIHwv/C0gmwHt68QM2IrHhHjYAegg=;
 b=lVHW4qWn9K1uugyn+uN0cJA14Mn2DjAH6/0ahw7QhIyNlSweqBxIDov9IyOXnC9+UvRDu6Asq1eSWOy+WHG62c7KrMEubdvlDX573x7HyqDxFthySRWv9GGMOZ39LeNDMLXhrzVPLeVvwnycm310ObQwsL++XxENNZEqYdwiMZ/0LweeHYFxHyL/3oGuXi7J9U9hDwIEX6G0v5lgqEcso8Qj60NtTG0VPpo8TZW8CoOVYuuAhZcMAIjBI4Lqsexb91TEyFwwcLKuDSD7mglOXD4IHrf0VRvFwEAEOoiJRKUSBgi860/DUliMZErG/XBrg/MI08+I08HKtewEADNQkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07ezkU9OaqIh8xJIHwv/C0gmwHt68QM2IrHhHjYAegg=;
 b=s1l/G3RtfqKFgoLHCD4OiWYwtllPXUoHm4FdGSUCo+q1q8sDSH5IC4+f+Eeszk7JpYHRA/K7Jgw19CFcqUvh4muC+g8nQb++/FBrGX3euvP28ZgaPjz5YwW0NOovZq5jRBKJSW8OdDkWcZRCnpCNJ1HazBTCJxhP+LqtbuanyV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8257.prod.exchangelabs.com (2603:10b6:a03:53d::8) by
 SJ0PR01MB6174.prod.exchangelabs.com (2603:10b6:a03:29e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.24; Thu, 22 Feb 2024 21:42:36 +0000
Received: from SJ2PR01MB8257.prod.exchangelabs.com
 ([fe80::ecb2:1446:ac3:26b2]) by SJ2PR01MB8257.prod.exchangelabs.com
 ([fe80::ecb2:1446:ac3:26b2%4]) with mapi id 15.20.7292.043; Thu, 22 Feb 2024
 21:42:36 +0000
Date: Thu, 22 Feb 2024 13:42:23 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@arm.com>
cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>, 
    Evgeny Pistun <kotborealis@awooo.ru>, 
    Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf data convert: Fix segfault when converting to
 json on arm64
In-Reply-To: <20240117215101.77713-1-ilkka@os.amperecomputing.com>
Message-ID: <d77856e0-50e8-b7b4-734-93be3447ed73@os.amperecomputing.com>
References: <20240117215101.77713-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH0PR03CA0413.namprd03.prod.outlook.com
 (2603:10b6:610:11b::11) To SJ2PR01MB8257.prod.exchangelabs.com
 (2603:10b6:a03:53d::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8257:EE_|SJ0PR01MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cbe5187-8b78-43b9-1e40-08dc33ef2f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I8kajm6wQW8QY2jqvMVLceFTs1s6uP5vqRV6hmPpC7wo6wGXuBMuevpdi4zb2ZtbRHYfPXb9m/jzI9jRoQb49TxobVcIPu7BiDqrxniBXK/84gWe/6A0e4PPQNQiHvcmh0vFLrmnX7QA/wRoIVYgVbPlgI2CLCj2qshIHWu25WMGg3scJefI6R/EX6wO6rImJuSyKHvW9kM8mcUu/+rwh1yc8iVeZXSa69g5eypaioxNvKIDHTDK30IURaP4h7guL+KBOz8js8TltIgAlAbwnjyOdD8lt+/3k36SdzpK/g8fXbAEqFxXcoIGmRPoMzIHjgQ0xc0Q/mwJWF6DsAHJh7SCMKYiLxQgYxCsnCSlvGUdB1sUXQvvhpp33pFUFFuWozjj6JnYfOJF9iWEEHJNC5DZXIBy5OvCc1NYy6z+iqJReG4Z+4GLXAfQM728KCFo/rDKLdnuFG8Fa+jRi9FL/RkiAVvUcB7BSb+77Nk0J49FYiszwaN0CyUwXcaFdFPpA2NNpd9Blj/KUHwmyjX6253HGqlRMmN3fNb7ISumUvNlA9jb35d6OsmkgP3dDCU5WGhOqrcAcz7W0MBsCwmj3gwRn0DD0C4W7cdmzsYqgEY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8257.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BCocZK3dbP+sRZIZIw7BurCQYU8cacYJw8uptRjm078TbhnTtFjE/OC96Wrk?=
 =?us-ascii?Q?wPRTVtAxBssgTtolOyF3teRFqCELAGLMfzEVXHJ6lW8oyAMJ7ajQjR8878r1?=
 =?us-ascii?Q?oE1noP9pP34oAA06kRLEDA5EwcFnh4ykwx98979TF96A0F+I57Ny8tqdHoKD?=
 =?us-ascii?Q?phqq+M1PVJCR04PWXcR4bfglTxfhldaIpLg2TAD3wq1AeyGXA0XEORLTJA2K?=
 =?us-ascii?Q?vhOXf77hW9JFI9tlxxfRw5ad2feC976A78IQCXJhxjKV6jZ0qabg2rLezyOb?=
 =?us-ascii?Q?qtbvsmvulijXJT2frDuB5+yxASle3PeeBjL+Iuar6/i2FCZltxEgbRrQHfNc?=
 =?us-ascii?Q?7lZauo9jd18lF78MWsCPLsCkMmWr4fIh7XUoXk05c72TDHHHdzX3VzRq/wXv?=
 =?us-ascii?Q?iw2+mAomOIt8bYjhzightF/655grX9Y4S27RFYP5vJ2tARsWMriMZuIfg3BC?=
 =?us-ascii?Q?z5XAtr9pAVlvM9j03iFv9jo1phlRdm0kjMAyGAmYRJXU9aqIuqZhwTTQdI2W?=
 =?us-ascii?Q?nyb2ktGP7e4BvttLKm0mMUktIH5hRGxljNMbS+BjEv5IjFT5ZjtnyaejCrXu?=
 =?us-ascii?Q?iHOzmM9bJMIItcagmRDcYdd3DEbcz9d/a3wtDTFMN11Jjj94phpOhVeRX01n?=
 =?us-ascii?Q?wBYVTsB54qO2AEcyZxe+bOKXFLu2c/72csRlHQ2Ba8WCBOqTt6QYps6Le2Dm?=
 =?us-ascii?Q?SkIeEZ6JQn47IrKxSo7o25+VEeQICCe06NXGbI3qco5sJ3offKpzvAy36D0j?=
 =?us-ascii?Q?eFCY1DKHmXgaPyizDBf1dljam+NgiNxf9ziG83qjnuyPPi/Z7EkDUHtF+Kao?=
 =?us-ascii?Q?nMrue60KEOYPXDWhzwjiUJvs3lT9L51javbwFS/bvQHjKWQ0zSd4lPLMTqCL?=
 =?us-ascii?Q?wgOyxwJi54F3FDLTo+a3FOw5+daGyZ+Ke+1nj3IUGuXwKfWNpr+aYDgfzOUU?=
 =?us-ascii?Q?WtJrB4rV0p6BmCo8ABsLNazIzV0Hgsp85Tr8m6znjnyhbQqqOMEZG3Z+PA9L?=
 =?us-ascii?Q?AhWTh+TKqM740X/ReJJAbXqIKqdLPFA1q6boLdLNFT+7WiYaxca0KGI+nsx7?=
 =?us-ascii?Q?PMwdsqgUW909npUZccDXWJeJ8ddQ1XSHDc3Rsur7NTvSCSc0r+G0t5CpAIL7?=
 =?us-ascii?Q?fQBFKk4DerA0efAa353Im8bXhHS4HU1mwsUsZ0IXi/o+uytfYJRV6mBzoCwV?=
 =?us-ascii?Q?JyZsYD1RWfDCjqZik4hxreHvnqGnXlpOGAqEcMpSAoUogGud/KoVxvbrmyIf?=
 =?us-ascii?Q?DkQiku+phfh0PByRyhUtHoAgxHaOfAO0zR5Z/OYXgI1Q9HRMWlk5PmhMZN6+?=
 =?us-ascii?Q?6Im19SPmUuoSiBFZy9ueS7Gp/5qrW1bRDrPd4XXiUthFCvHNjiHIftF0lkux?=
 =?us-ascii?Q?rwTLd85YyMHYXVSsAqnbS4eA7LZ1X4GIEKNzoldro/TBQAmEoPfytndIxzNZ?=
 =?us-ascii?Q?GquB1uZnPE1zWvLdgdgrY1mM3t1ho5HJkHPrzXTJFy9NZ7sV2BKgiP2P8oUR?=
 =?us-ascii?Q?qXmpkV74+jg+jkf/d89DMSgELyI6aRVfMErc+YeqRn3/2pBFKr29AHIAB1kv?=
 =?us-ascii?Q?I2eqaOqkudOrRGaVdkUSxs/JDFz6bR4Qy1nx+/E4pp/K5NzkY5mdPaU9Vlxf?=
 =?us-ascii?Q?unopWs1jgOKVqXU8XEb8MH8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbe5187-8b78-43b9-1e40-08dc33ef2f17
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8257.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 21:42:36.1585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfGIh8UV9xGCGvy4HNdbTta2QN9cy86oU9AjKp2M8DK7BJsImDvyJn31JC2ngVzmAJbGpkkIA7xXPh+YHdcRPA9VUxq0XfWb/RZYCwjYE+XunvDVnBhaAQ2j+5gdEYRD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6174


cc: Evgeny Pistun since he submitted a patch pretty similar to my first 
version
(https://lore.kernel.org/all/20240125184411.30757-1-kotborealis@awooo.ru/)



Namhyung and James,

What's your thought on this? Is one of the patches (Evgeny's or mine) 
good enough or should we try some other approach?

Cheers, Ilkka


On Wed, 17 Jan 2024, Ilkka Koskinen wrote:
> Arm64 doesn't have Model in /proc/cpuinfo and, thus, cpu_desc doesn't get
> assigned.
>
> Running
> 	$ perf data convert --to-json perf.data.json
>
> ends up calling output_json_string() with NULL pointer, which causes a
> segmentation fault.
>
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
> v1:
>    - https://lore.kernel.org/all/20240111232923.8138-1-ilkka@os.amperecomputing.com/
> v2:
>    - Changed the patch based on James's comments.
> v3:
>    - The architecture is checked from the actual data file to allow one to do
>      conversion on another system. (thanks to James for the feedback)
> ---
> tools/perf/util/data-convert-json.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
> index 5bb3c2ba95ca..405c38371870 100644
> --- a/tools/perf/util/data-convert-json.c
> +++ b/tools/perf/util/data-convert-json.c
> @@ -284,7 +284,13 @@ static void output_headers(struct perf_session *session, struct convert_json *c)
> 	output_json_key_string(out, true, 2, "os-release", header->env.os_release);
> 	output_json_key_string(out, true, 2, "arch", header->env.arch);
>
> -	output_json_key_string(out, true, 2, "cpu-desc", header->env.cpu_desc);
> +	/*
> +	 * Arm64 doesn't have Model section in /proc/cpuinfo and, thus, cpu-desc
> +	 * is not set.
> +	 */
> +	if (strncmp(header->env.arch, "aarch64", 7))
> +		output_json_key_string(out, true, 2, "cpu-desc", header->env.cpu_desc);
> +
> 	output_json_key_string(out, true, 2, "cpuid", header->env.cpuid);
> 	output_json_key_format(out, true, 2, "nrcpus-online", "%u", header->env.nr_cpus_online);
> 	output_json_key_format(out, true, 2, "nrcpus-avail", "%u", header->env.nr_cpus_avail);
> -- 
> 2.43.0
>
>

