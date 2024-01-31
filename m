Return-Path: <linux-kernel+bounces-47212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 237F4844A96
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93873B24DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3B139FF2;
	Wed, 31 Jan 2024 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="onem9um9"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB19039AE6;
	Wed, 31 Jan 2024 21:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737900; cv=fail; b=TW6yqu+dFicCnAI034jxHH9aOsFp7fxtUxC44hK3Detzb6rsN4ecGNmnNwzPprgjz1ktz6vU+i4i5+ErolH6JOl/2j/NsZFGvwOi446gncwoP9GJEQKb6JkryhVw4utaX/TFse6j/uRZADaZ5EFn6aA9zBG2TnMHQE8Z0O59+S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737900; c=relaxed/simple;
	bh=ZfglMY0ajlZ9eFy47VmcS1cGTxlxxzmi4xWypVPfVEo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hvM9DDi8ytL9ily57P1pddce4/CMOKnnbhT3pFOH6dqvn1ffiCtm+DtgNs1RoSi4ps+NTBznLhcMAV1xdTubK+9dbu7eAUI2lEq3R34PrIzoZTUN/Js+6zVjYR05s2kfunyCqKdE5ySmzheM3T2yzvaAQAm4GgU4/9sNriSMKJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=onem9um9; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1s7PDL/BLmrfJvTF8aTj9MRCNM4xcMWZmEm4I8lGTNTwIM+ue3aJJpIn32v06CmbTkk36MAwlPxJayjiZUc8LvOs4nuBtKfUcKijRbpm75o7cnw4eMAKaY+qZwX8Q6OOIZbRvZz/tsjJDiUiszBFVRt+X8vfgTJCJsP58qIsaxgZlZTw8vTXSHp3OUDd6Uh8FLS4oH2tJZK+vJMRY1tlBAnnkt03MpP+s2KD9cIlu30+BnxNAlNgjaviu4i5CWFnS7e0cwrtX5MH0jUErY0CxZkgCrsbadsi2Pa3GDti3PUyioEsg1Sou1clsPcSLfmzYPsqbFZgopFwk68SBtFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a18qgjSOIwQT/aC2eyrDdrwJ8mCVZilMw/0ygdXx6c=;
 b=GklP/jOt8y2FhmLEuEV0fBDH+68qzUIJEWZH0HDLj9Hsi01XnfqPALLtweC2eT6D15u7w9QBjOq/671eq1xIiR5rAsEG8KR2u4gUaJDU8f3GzZCtUO0/96kS7KepwRrey2WLudpiEv6O+ptbX+JhM//aEBUgn+CTj1J8NuJ6xYNZEf+emOna5Ce5VETg+bGv5q0LGEu3vmhLbAezNaQeCOEPcIpH28tmVTtm4HxCCc3R/vegAoTiVhEeKsAIUG8bE7OmFa0/niMa4D/xPSlwTWUs51mBLRTksSxviOJyfpSWB6OhrpvbkZKFHeaAK3OYBJTsPFvQ32L0n4zXzoGQSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a18qgjSOIwQT/aC2eyrDdrwJ8mCVZilMw/0ygdXx6c=;
 b=onem9um9kDjUFt5mYxwNO2WYyMjbtAJLPa2PDM6VTLk//dPy9IvhbqzhH41poPmX37uBovhSgJ/Htgur6EuB35f7k2MLNiyA9gQ6Igj2LQbKNvxofeDExCMLPouBUNdkge3QTtDRTwy3xW69tYvWumYS6sgx/3hFAgdKJnVpryw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 21:51:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 21:51:36 +0000
Message-ID: <9f6bea2e-7291-4cf8-a407-8c13653ca10e@amd.com>
Date: Wed, 31 Jan 2024 15:51:33 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] cppc_acpi: print error message if CPPC is unsupported
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706690577.git.perry.yuan@amd.com>
 <a6c3790105fa30e89f39f0dccc7d699f5c1c30b7.1706690577.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <a6c3790105fa30e89f39f0dccc7d699f5c1c30b7.1706690577.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0189.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c23047-f14f-4590-97fd-08dc22a6cbcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8tfk5vUTSso/lORKl+3PoNb2CkqCAemrjCGkwNw1A/1v00P2kXjWSGOSn3Gqj8NjaORc+iffH9ipYrTBN1QcKEAVijPdpcn0o6YOJeWPbU1NFcRIlIp7e3QxnX8jbdkPq4xxWa62gjaP5ROUo17V1LRuMH+DIC+XheJGv+p3JJN8DfdN12gG8lhIrrpATO4ePfC1ub8HFO5E/vVTGo/xVwOrjTaLHai6bfgOpwt8mVfiwy+IILMOzkQSQxl6Mi8E5xqkNT7xMRqn2J3K0TwOj69ar61kGGnmWPp9VHW/3Yy1fPejz2z2qzy/av16OIfM1Zx878vdl5g2qNF4FOmTcMCMhp2UtCTGA9jY2cpZGxH0u+vsPnQP8pi/ghF6tUqDby1jzF1xl5ukyBu01NSCTZssoCKtQX6afhoGjaNU3AAdn0gYq7AGol/f3WIgts0okLFweXLnJcK+vRZHeHVNo/Mt1x5sUcoL/fFP+/w1aUirekEwPjKX2Uly/l63klEaIwXkv157kXyScE2EcCwpWe3KME7JeSXkos4k6dqfufWjm/xXBxAXxYIjaRowo/H/rcwU2OYFR6qvthdnMW1ZG+PQcXNpSUkNt25oX+EPpMt+A+/vDxR3UtSCi0D4cmQkRlV/ZGG73Lo50rZyjal0dQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(15650500001)(44832011)(2906002)(5660300002)(31696002)(86362001)(6486002)(36756003)(38100700002)(26005)(478600001)(6506007)(2616005)(53546011)(83380400001)(41300700001)(6512007)(6666004)(8936002)(316002)(66946007)(8676002)(4326008)(6636002)(66556008)(66476007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVh6WlBaNjZjcEt2ZjQ2THhjRmsveFo0SEFsR291L2JYa0FHL1c4QWt1cHJJ?=
 =?utf-8?B?SFMxaGhzVnJnQWpJS252d3RTWW5qeVc2VkRFY0tuQURiTmorZFMybXJ5Nnpx?=
 =?utf-8?B?a3hKV2pnVG9sM0xRemlkZERCcmp4YjhLQ2R6YkZXUTUwMDl0dEgzczRYbkk5?=
 =?utf-8?B?MkJCcWZGWmxqK3VGTi9VVlowMVNMWXNEcVJ1RU12ckR0RE9mSHAxNFJzMUNm?=
 =?utf-8?B?UmYyRnZtSGp5d3JtOEZvQmVlWUg5R0VhMU5ya2M0MnZydS85WEVaRzNiQVBu?=
 =?utf-8?B?cmF4LzdXcWJRamlIczVLdjVGdDlyV2JNSWJ4ZkMyVGk1Z2IwSHdyMVRWV1B4?=
 =?utf-8?B?ZjFEVGZtRHZzRW9aMDdDdUducFc0SUQ2bGE5Z2M0Yyt5cEw0QXYzek9KV0lm?=
 =?utf-8?B?LytJcmd0aWRpdEZwbHhyVTBoUVJUc0NuenZGZVdCcmg1TU5PQ00ycFpwRXNL?=
 =?utf-8?B?UUFtTUhsWnJ5Znh5NmlRSjdQRmV0OU5jeXVMbXNPclFFclkvdEMxSFdUWlBs?=
 =?utf-8?B?RUp6aXhGa3NuTU1PRk9PMTJCdGtTbGlJdEFxUEFBSXlDTjFxbENtR2ZtTEhK?=
 =?utf-8?B?ZGZwTEtGVGpqMCtHWklaMjR5eWE2YzNVQUNkWEFiZjdoWWhKbGo3dzQwZVJF?=
 =?utf-8?B?YzV2L3RmYmZKUkMzME8zdzVXdHRnN2VxbUlaVW5Db2hRdTFKK2k1ajI0ZGdD?=
 =?utf-8?B?YlIzcUw5dXdOS1hQR05TN0lBRllmUDBwb1FtVDZjTFczaWVZMEoydXd5MVBj?=
 =?utf-8?B?dG15UDJ6VzdndEtqUUhjKzFLSWxQb1dqcHhxTnZ2Z0NCZ08zeng4ZkdPSCt0?=
 =?utf-8?B?d2x3SGhNTGMzYTdORXlkK0dLaGI1amV5QlJlQ0lhVHdlTmxIUEEyNjZTZXlU?=
 =?utf-8?B?eXpOZU01SStKTjJKN2JZMnVKNzNIazlHVUhDVHFFMDZWa1cyZk9pTXE5Tk5n?=
 =?utf-8?B?MHl0RXBSYVZTUDFHZDhYb0Z0MEtkMGhHTWVpQWMrdCsxL3ZQUzZzY0RQWmVs?=
 =?utf-8?B?WmFLZXo3YzVaQ0NtVEZCU3g0R1cxZkZsY0c1YTIxNEN3V0FxbDJlR1ErYS93?=
 =?utf-8?B?ZkpvWWtJek9NeFdKYlo4QlpxRUdUbU55dWF0NnlNbHVWV09PSVAyV1ZVMVFn?=
 =?utf-8?B?Q2d2RHZtSitrdUVxRk5Pb20ra29QOEZFeDNLOUNSc1YvK1JxQmY1NTdhbDZr?=
 =?utf-8?B?cVpWVUViRE1SZGxxMDRBTW14WGFtWmZFY1ZXTWE0VEMzTVJaK1ljM1JSeEs5?=
 =?utf-8?B?VnpOcDQydGU1RjJTQXZSMnpPNlJ5MnJNcG8rczZRRng5U2gxRzNhU2lkSGpS?=
 =?utf-8?B?OWtOTm5jV0gvc3krVFQ2NjFzT0JjQUlJN3BqMjg3aUpnbDNvREMxd253cW4v?=
 =?utf-8?B?MU43c2VMMXcweXl2aWNlOC9jODI5aVVTelBhM0VhK0p4UWFXbUFoai9XSDFh?=
 =?utf-8?B?V3BPb2QxOC9XQkk4YmxYc0ZvUHUwbU1KZ0VESUt2VnVNU0VUUDBWVTh6UTFW?=
 =?utf-8?B?YTFkY2xqQW55VzdKNlhXcEdSWnc4VnFOVDRHRUxCTVRnYUJJQ2k1ZDIvbjZm?=
 =?utf-8?B?MEsyOGZoU3J5eVVkVTBQOGJwMFdiL1VWL1pTWlZRWTJ6OS9JSXU1NFlkYTgy?=
 =?utf-8?B?MTRoZiszMSsvZnZmeEFPMm5TQkEyVldKUk1vS0dFREZBL1h4NnFGMU5jNUFq?=
 =?utf-8?B?RElwV003Q2V2SzZtSVlpRER0RnE5MzRHdkViZ3ZuUE1TYURrUnRCZnk0bUdz?=
 =?utf-8?B?MTBJbzYvWTdIa3RJSzJ6R1VrdkdJKzBZZEN3YWF0WWlDTnp4NCtCQnRLOXBi?=
 =?utf-8?B?TmtmM1FKZmNXQzJsVUxwbmoxcFNTcjEvanE0UnNSL0dhbGtFckFORjZadnIz?=
 =?utf-8?B?MnFybFlpWHl6NElKc21Ta0o0QTZSZGVFU29rWUNKbU5IRmhIaS9Rc00zSTlR?=
 =?utf-8?B?SktKOVB5YzV5ZmFIV1ZocThHcUZzaTFwbFJLVThZZThsV2d1cHV4U0QyS2Zs?=
 =?utf-8?B?TEpTeG1HZFpHNFpMdUtPekVERm5QT0RWVDdLQ2N5SjhwakRWSlF3eGhQZU12?=
 =?utf-8?B?elB0RlczSG13LzkyMzJDZEdTbU9oWkRqUGRhdFF1TVhLZXFjaEZzdzQzMnJh?=
 =?utf-8?Q?6p9xOILIM5kXOaID+KhRRxyHp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c23047-f14f-4590-97fd-08dc22a6cbcf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 21:51:36.0560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idtFhHtrCNdr5ggtXbvyeR0yIivcD6FVg5AGJHjn1zwpLG3jNX3sLoArkfDqH55dYE3qLBC1PI8xze5VzetJHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630

On 1/31/2024 02:50, Perry Yuan wrote:
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
> ---
>   drivers/acpi/cppc_acpi.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 7ff269a78c20..217c11c12b57 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -676,8 +676,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>   
>   	if (!osc_sb_cppc2_support_acked) {
>   		pr_debug("CPPC v2 _OSC not acked\n");
> -		if (!cpc_supported_by_cpu())
> -			return -ENODEV;
> +		if (!cpc_supported_by_cpu()) {
> +				pr_debug("CPPC is not supported\n");

I would argue this doesn't add any value to a user.  To help a user it 
should be "CPPC is not supported by the CPU".

> +				return -ENODEV;
> +			}

This whitespace is wrong

>   	}
>   
>   	/* Parse the ACPI _CPC table for this CPU. */


