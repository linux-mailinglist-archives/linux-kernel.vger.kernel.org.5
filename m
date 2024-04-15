Return-Path: <linux-kernel+bounces-145419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9804A8A55F1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9F31C22049
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E365E78C6B;
	Mon, 15 Apr 2024 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AmWLDqEP"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B56D762EF;
	Mon, 15 Apr 2024 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193481; cv=fail; b=EUMALtTJMcBDWH7Ci7+H5gQQ7CTTs6160euITLSgy/R2qkCpJgqxp7SdnwqVecqhK1wDPHzmM6Oq4NcwieE/F8Z5FX5hsd8McM9xfTgZOKwJigiFvPjmjbiGQo+epZkdDsVQs/pXHrunYdMoC+is8uKk0+cu7KkbSXPVTSKPq2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193481; c=relaxed/simple;
	bh=hxLRNF17RS2p9IYsaSsxnKSQ7ze8Ppv601IcALBnA8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ctwrmFY50rhQwssoCLCqnMV+r+/0mvr+8KlY8yHgD2+0rp8+0w+Ww7s4XVMpOh2SaBjQHt7OJLEkDx/VIGC1j2s+OVhy6DtYV+LSeZOAQ+VEUTUW4A9/TjFgEpVfXGUo9aGQOB4MJz84VIdJohlquxmJK3qy5mVxTOq7PvJxwVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AmWLDqEP; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GURRqsgZRZXvz4mzdnkq4wAFEYadMo183swF2rrRQ0FgKiaqPDsZg6gCxiVqYKQSUJGSov+TpO9QOZa7FOw85awig5K3Ri1WyZ58366swXAk7jMItamKAD9pm5o3aVZ2Nz1qhzV9qkNIBOmxrbAEU20ClGX9sh1x0gcQaCAuiSk3hpylTnExYDaGsXIocRnPozz/bxaKwKnao254JEDtVYWc2jqKS+LdOV3vvsB56oPM/lFi4HEh5aq/YyKESL0U6IFP8/AKISRAqiTaeF9u9WFLOjQWBsMz9lCJiTyEbhfstgvAKMv4oiHPBTZ9Mmqt+Qc31td4wFVVJnPSiPOKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwmJp1NT3U3z+4Xi0MPR1ldZzZrN2oXdc9EYSIB7XwQ=;
 b=IXtYX42JK+K43bNyzYK/UD08BWj7Fxs8v4jAjWO+0becbG17UaQPDYkCiBvSk4w9BlczbAVtWsT4A8bCjHM4i6Fg1EXnf5HbGkLL2EzmZDSazPQK97GP7tnYD5qSpnT3cqUqzL1/kPBbctKkpBaK9QJNH3hDSL1RqhcUkBBp9EfZ2uoekJUkOBT5oPUVg5i2ai2tqr4iCLc8Eq00M4lxvsTAzzspR7gg3RbTaCGmyfO1huQII8xXE0M4YEXIqli4CLxRixPW+SuPEwQP3R8BFV3ldyEZIA1pmV/kOUNUN2GRVjesy8rBzwvMx/JzrPA7U2jgMlxDZeMEUOyAXGhpLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwmJp1NT3U3z+4Xi0MPR1ldZzZrN2oXdc9EYSIB7XwQ=;
 b=AmWLDqEP0z0NFTa7NguntPPTFA69F1ScQ2iOrIDLVPtf7Pm7qsSPDhAjyPMED1oIesP16NUNP3P3NCQsExJ6RJGI5RyeoxOCMul7jYKquzfptqSX5RhBNA2RS2ayJrRHMOVM1cLKzOmet2ROSfPbWOEuooTIP8HwxPG0QzfGkLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 15:04:28 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::e7a:5022:4b7d:ade1]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::e7a:5022:4b7d:ade1%7]) with mapi id 15.20.7409.042; Mon, 15 Apr 2024
 15:04:28 +0000
Date: Mon, 15 Apr 2024 23:04:04 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"Du, Xiaojian" <Xiaojian.Du@amd.com>,
	"Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 7/8] cppc_acpi: print error message if CPPC is
 unsupported
Message-ID: <Zh1B5IeK53G4A2B4@amd.com>
References: <cover.1711335714.git.perry.yuan@amd.com>
 <bb32631f684446ae6380bdac0260ccd66290e222.1711335714.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb32631f684446ae6380bdac0260ccd66290e222.1711335714.git.perry.yuan@amd.com>
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 654f5016-cf72-4af2-5be0-08dc5d5d58b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	11OpsiJe5VQKgIkdzuPoGli4quFTcdbsqk7V3oWI2lzXgrOmUFKNbRFrUoCm1yKOZ0ou3JeFawz1MqUTJtJUnE40uNu16hnmNir/1OboSZd2QXQkiVlVqweYUWPbk+MPPMBq1E5i1bz95BI/VAmZjSroIV1r9DHJbR3IMAPcjOTBtVw+Jzj+q79CUdCEnoOKV8AIHHm1XMzf5O+9XNSZfj4FJOQMBBHTYRdqBZmfKrjUo0/6ig/XZiEv9ZADVkn4S7/CiLpqbLz2PYyjAUhux3gnjw3pTpP7amOWLujilkk1NTrZSt9vQptLm5YqkhIv0oFWv9Mc1QDdXnIIj4y562lrFuwFgXY9QuUkY9jpiADduV+uvqKUMuDgylpsWJx8mBcwlZSBGOXTiIJnRkAz0eKLJU3g49ek5PceQuqADC97eNu8j43cwiIxUjSf9FbJOU0S79aQ/tuVh803qOW4582SwFymu7ZlGBIw+0t4CxHVghh5LA4MWvygLWsSqbcbCPo1x2UfiLBdc8OnZ1jhF58GT3aD/WxE1Cl77+ffXcSOOaiPyV/rUyBxmhIaauOhpJ4APU8K8ber+djNyBDu6WAWJP3MMdf5koobIvn6nVouL0Vf7tcDdVDrutGi7qeayX/xYclA9iH49RifsWwGwbPi/mSp9Xf5maeDPqIKhrQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eWCW6VrHW5NBPBptGNyK2M8qKyQVry30CvyiH0RugcRdaK/zGZEcBEurRONZ?=
 =?us-ascii?Q?47wWid00MM5lkbCgFbdsPqVPxpxABUwcNQctOKZ0TArpfywn0OLKP9Ip6TDP?=
 =?us-ascii?Q?JAWbmlodPmqAktP2QUygWq+tcDICDZhDddeb/0bfw/CDTjPdISn6zstrAiFm?=
 =?us-ascii?Q?aEXdGszRsr8jZs/kUkLRi55hf9iU4OEcSnvhLXjpw+SKnusLPc6l7am1KZbR?=
 =?us-ascii?Q?iUmJ0puuTIaqbUlCJSfRVRTSNM+b1LZFUiDLJqkopfRIzf5QHzETUoVt4rLF?=
 =?us-ascii?Q?REN7jZHKAZGBaBmIuTA2vF60/S+MDesRD5rE4wgDsq3a6dqjTH2T4m1BBgxy?=
 =?us-ascii?Q?vFmjMEwWKBaW6xZwg2yr1TCA54I7LQKdhV9GKDGc65aMeqdla9arJNitriEE?=
 =?us-ascii?Q?6Jli77umHASAlx542ULACT7/Gd+q6IlfIr2gvqEogF9ZBhjCCpnK8tyB+Cyf?=
 =?us-ascii?Q?ZGCaBCjGMpna4GjJ8sc8KekTcMIeIWQo8beCaIr1W9HkaBh2TpmE6s0jFXjd?=
 =?us-ascii?Q?LhUZq8VtQFRY5PDw8kFK/uPMgdiQ7vYwVtcAtDYHiqUKHcyKR0nl1J6nv62L?=
 =?us-ascii?Q?nH+Ij/BgJM7CB32pXMsCjxs7G0RNlzDekX+u9C3gjUTjrD/5Ikw2XmDb0iMN?=
 =?us-ascii?Q?kW57fGQfTuecYSpxkMh7yrpkk5aqshFn68x7QqJe+issrVGNFHiy0/9sP4Ka?=
 =?us-ascii?Q?MkQGV8/ilSJvm+3Q8LzTnpLp6/P/iv/r2BKoLZwppQHWlf1WukFbL+fDbsMv?=
 =?us-ascii?Q?Jho68K7pRchhr9Fze9EA3S0pfhtKAXCVOUIB6OIJXr3W2otshuaOf5T4WfVu?=
 =?us-ascii?Q?uRvvkNIKeiKqmV+YSgq0OpbjMS8Fjbq5cJaJSIUxYbOgPwDvJX0LJg/czzDt?=
 =?us-ascii?Q?2RteD8l8NhCiVz9UIdvhsNJaiWf5t0zOeatpZsG2zPfqzDFbCoYvNCn9Wajn?=
 =?us-ascii?Q?YCibF8nNwTUVUKMM//bnwiO/Ppj9kyYi+OKsFuQEDO9x8k4ESaFJH00b9jHi?=
 =?us-ascii?Q?ph2mtmbA/9qNNzXMaHOsEzusKW7krg8cL4K7nvzBZvfHieHNfefR7RFMs+sk?=
 =?us-ascii?Q?wzRrjtTyhN9PGDmN0q/yZ0bs6gff127u8QEBTOgogoybeYHdQZhCeHZ+HWg9?=
 =?us-ascii?Q?CZHB60s0vHKDTIUMNPEa2J/+v8CXe2Qbay846Oeyuxtd27GFrbEKMqrPVMhP?=
 =?us-ascii?Q?RQBJFkBRSTeDOI2WqeZnieXl68ifEheu2+t61l+nwA1u0gylU0sX2kAtwyP3?=
 =?us-ascii?Q?4Q+B554U+4kVOsmHGL+WUKnlVcvkOlcPqDoa2hZjv0nu9aWSZ8eS9hettOeX?=
 =?us-ascii?Q?PoWkWnX4t5Xakej1O1jvITAxcpUbzSvansfKUUHGqFGvQXaEZ6x/IDCQ1OGq?=
 =?us-ascii?Q?KNaoOmudyyg97yE0LVOwpSNK2l+V2JCvZUzDYj8HWaa+HK4ovnC1WEzKl2Ej?=
 =?us-ascii?Q?zezsWQeQE/F244p3udYoD7SpcipwPiRaysbTIQqFhdMVHP90e1Kdblyoqz79?=
 =?us-ascii?Q?kYbM+izs2yjEskH15U47LGJiTmRTrECDIxjoAe0LS0hkYtUBMcFBj5cdHRYU?=
 =?us-ascii?Q?eBBY1HIYSZv7bEwKZARIDCXHAxkBaR+g0wHvmruN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654f5016-cf72-4af2-5be0-08dc5d5d58b1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 15:04:28.3713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PylgMxPIXwdkQUFiqW/CqVV1zMCVNMw9WWc9TrsGT9DVZkNyZwblJUIR0Y4y9XiT2uz6irz/yqBZKr9pL3qMqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205

On Mon, Mar 25, 2024 at 11:03:27AM +0800, Yuan, Perry wrote:
> The amd-pstate driver can fail when _CPC objects are not supported by
> the CPU. However, the current error message is ambiguous (see below) and
> there is no clear way for attributing the failure of the amd-pstate
> driver to the lack of CPPC support.
> 
> [    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
> 
> Fix this by adding an debug message to notify the user if the amd-pstate
> driver failed to load due to CPPC not be supported by the CPU
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/acpi/cppc_acpi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 4bfbe55553f4..3134101f31b6 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -686,8 +686,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  
>  	if (!osc_sb_cppc2_support_acked) {
>  		pr_debug("CPPC v2 _OSC not acked\n");
> -		if (!cpc_supported_by_cpu())
> +		if (!cpc_supported_by_cpu()) {
> +			pr_debug("CPPC is not supported by the CPU\n");
>  			return -ENODEV;
> +		}
>  	}
>  
>  	/* Parse the ACPI _CPC table for this CPU. */
> -- 
> 2.34.1
> 

