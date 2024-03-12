Return-Path: <linux-kernel+bounces-100083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D2A879192
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3734EB2215A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C03E78299;
	Tue, 12 Mar 2024 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JvHBhK+P"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DB177F32;
	Tue, 12 Mar 2024 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710237582; cv=fail; b=jFg9z/cD/ayovKvzDDIhNS6zw/Qua06GDOzP1SV2tuWsv9I6tfmsULaZho68gOCGhTDvNi9Xs7vB88yYlOYLkboFaB5DW7KAbxaaLkGAnrjR8OswSyV6DCqjmAeHqm2pjUUAyyhNkHt74258pSgKw2eiYzuRIOt504j5mWtoWbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710237582; c=relaxed/simple;
	bh=OACp1nH4REljyLAay6XzNvFfchubv4NVK7YzwpDLKtg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T1J4AFZm+y69u30Y+CL1k3AO+x5kyLKopYOc4nS8gKHMKhpolO0saI060emUYeE2wATzdsPBx82F7ofFNXzH8p5Kbx4nfeR3p/EYsxaP97KZfQLE9+S7lcHwZxsJHB7rk70PxD8Z8Ash684Uy0GhcEOGZD+VFVRM2cTs5rMu9Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JvHBhK+P; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvQ4x6F6eEEx1OlnwOaBFFCtuDoVmMX68HQttK1Oh/m+JVVGzHsDYpfJ9kexXsPNNs0Hy6GM+P+kqxK/isR8G9W54SXoyj4fDNR5L80ZVUB3xP5A9o3Li6iLdX7T4NiDmX/dEzhIadSGVExEt1QB3o9AaJSuYLXbM3sVKkMDq3hPzeHwCrrXCM6YdDNAMwXYxI+yG4yDwgGV8rff78JUweu9D06MXWh/fVhWTLsDj6HvRNGELfkQ+ixqv+OuIPa8AEyBekPYf5UiyoNJUh45s0Dle+5wJ0nk5mG1qD9JaKO30aejK6q812WcVf27/OG+ghstM/LNMMzV+TeMEcZ1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hB3gntr3TXpoBwP0sncA5cPKjAGXe+wDUTCw1rR1XbM=;
 b=IOpoRrEF5UZCoIs8TJvhWu0gDjE1UO+/u8b4/j1X7/b2NuuiilP1F4QBHKQer6GpGMMWitV5LhHCgFuhKvk+sYFFP94e2X4kQlAc8tDtqISQBGKDX5n/2sX8bupgXUnDfhntrPwKg+jYaQgQ7/VslRAKk2CAXTpBv94V1Gv9c/TMX0ta15G3YNx+pUAIQPW+65Bgxmk2D7lloxJrOm4pDZQJmGvqqq9bkuvAipdqEzvHvjEmRtXrjLqf5SOB3nXDSPlNhwJ5Gyxnv2ckELKTj/FWMol5YSRBFl8TSI8QgtQSQaxSi9ljVkRZD1nY25eB5wUZoyX9w/5hvT7Yuq1ENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hB3gntr3TXpoBwP0sncA5cPKjAGXe+wDUTCw1rR1XbM=;
 b=JvHBhK+PhmcYsa8PcPKs+3c1NED8NDjuQFeaCaDbBJHBG9w0G+Qjgb+K406H4xzgYTTzeXpR9fQrMt7EO4DupkOmK6XNJ1PQPpFkgen/X8J1rvvYv2zKDiy1VaItzMnzEeV6QnZJw/F/yxeJ1X7rcyVyemZnDIH4ZZ79pePRWBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:59:37 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::9dcb:30:4f52:82f5]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::9dcb:30:4f52:82f5%5]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 09:59:37 +0000
Message-ID: <ae49f714-24c9-485d-b2f3-a319a53ba1a3@amd.com>
Date: Tue, 12 Mar 2024 15:29:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] perf vendor events amd: Add Zen 5 core events
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, eranian@google.com, ravi.bangoria@amd.com,
 ananth.narayan@amd.com
References: <cover.1710133771.git.sandipan.das@amd.com>
 <0d18c3a93083f12481f27dcc5f5795877fa02b90.1710133771.git.sandipan.das@amd.com>
 <CAP-5=fUV=6my-+z0Qc+TS2+CbKT1DqsLbpHZrZLitqpAnDd2-A@mail.gmail.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAP-5=fUV=6my-+z0Qc+TS2+CbKT1DqsLbpHZrZLitqpAnDd2-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::11) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|IA1PR12MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: c10d07fa-a2b9-43c1-21c1-08dc427b2044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9N0VVnOMX5gbzToL1Pv/2+8gx6HjdsOtuHVforawRGIbK5poiAFrfvSldhJojYYpDuiyBXMNq8GIl/IQfw0WeMS/Sgb7mhsmYipbKDG0m/sBT2drlqMh0RriRUiu4c4ddOReLawhw1WCLzP5iYgM6BtdrXnffAxkYnJ5dOqpFDoV666lH7pBTotXJoAnO+1Ltg8ta3kmmI29HuvUW0EYeSsbtPcOVGKNqwTG2OVB55oN2YcgvVOr3YmwM4U+x9cF+OYth2/hdJ/Z4mTTzEtmJsUA30sVE1OQxANIWPlAZC+clZ6KWpiaBZrXm9jn9tk5LYh/D7UMdpysskpKV7VCr3zY5RYGssUOBWeN1Q6JoL6Nr0PH7mYkdXFJ2Tupl+swrOotTebAGRl0pb8PtotlXHFTPLaxGN+rSHekO9iBpD33l7cy3HFUUrJjh8UIRQCzhwmsUhEdSN6KZ6mqLQxKD0fwe3Oxz9XjantAvdRZ39w4wX714YXz3KdfizcZkJQ1WPG03Ai/EQFHr66/A7PnS4ViaSxD1PkPyQdtHyx6gJkJy4eQ55sTvr+a69qqBwcBbyUNZNtf3w5gySq+13lVIOLwVDi+a6Uox56dYoZaC/k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VytFQW96eHl6dnBqY2VMM3ZjYVRwaW1vaWpUMWg5UnFnRTJBUGlieHAwQS9j?=
 =?utf-8?B?dVJmMnJBdm9hT3M5eVMzcnhzUHhvT0RvenE0a1hIcTZuZXFMVnU0VmpOQ1BL?=
 =?utf-8?B?bWY0b2t1STFjd01kSllOVC95cWpuWTBtcE1FU0xNWjg1TmNXVll3d2xoODN3?=
 =?utf-8?B?MTE4N0c2SEl0OVEraGI2TXQ3OXV0TllkcDUvSzZ0MjhZNFIxeGJ3RXJ3alNF?=
 =?utf-8?B?T0lmTkpFTURNQ3RiYWVTZmFNUzMybC9lRXgrVmMxUkF6OGdoRXA1RWlhekZs?=
 =?utf-8?B?Y1RoS0ZySmpVUTFXRG11TTZXUk9rRktvZmlzSTA2K1VHMXRlOXYrYXcwMUd6?=
 =?utf-8?B?Y1BQZEZFZUdHNGllVkVDOVBCUitFR3dJS1pDM0JnNVliZ0d6Njg1U1lscHpo?=
 =?utf-8?B?ZzEvb2NDWUpVUG9YaEJqZE9MVk45cEN4L2JleElwNVFqeXBqQk1iVXNINDF3?=
 =?utf-8?B?NElEZXZ4Nk5tam52NG5FUFhUSDVSdlF0VWpmMy85Y1VOUDF6Q1QrZklwWjVF?=
 =?utf-8?B?Uzc4Z09reXNUdU5NRUhuSXJhMElwQXpHQzdnVnVCMnRBZi93eEIzb08xUXVZ?=
 =?utf-8?B?dWl3VFEwM21Oa2xpZjQzM3U3YUpaU1ZpS3k2c1ljVmJBYTd0Sm5iOWRRM1Nr?=
 =?utf-8?B?dS9zTTQ1dnA2dUpkUmRaamNWckdncHFtQk1Uc0ZJLzVBYWlCYUZNM3p6eHJ5?=
 =?utf-8?B?K08zQ1F5ZkJTRGhrUWFoc1ExbDMxQ3B5ZlNxV2xPK3huSlZOYjhiZTZDSHYw?=
 =?utf-8?B?bFJSWkwwbm9sMnVIa211YnJUWis3NW8rVTN0anFPVXU4MFBQMDFzQ0dlOXUr?=
 =?utf-8?B?VHM3anVXNDF6blRsRnFxK251bDFoNWZLVVV2eFVUVW9ubUNlNHJQTU1URm40?=
 =?utf-8?B?N2xOOE1iRzh5ZGpCSHc0NzNYZ2RONnV5MDFTQkh5SUxGZjdEcnhGd0szd0dY?=
 =?utf-8?B?MEtGY2dNdE43aWZlcUVjMWtleGdEWmo2Zk5oRm1iaUprL2xQaUtGRTRydGlR?=
 =?utf-8?B?dmpvdlBCeHZNWkowS2ZlUHhqZUhMdUx4VlkrRlVmWkwwQUFtby9ZNWtuUFM5?=
 =?utf-8?B?S0g4cnRIeUZORldMQ2R0dERFN1RwMStWd21JdFVqM3F2em1FR2YwcHpBSDhy?=
 =?utf-8?B?THBqcTdrY3JHZnZVWE40NFhhUzFuSjJ6d0FUQ1J1QTE0Z1JYT0dQUmxWVjRz?=
 =?utf-8?B?Uk50VHl0cERHWVZXQW4vYXZvamgwKy9CYWNpeXZCb1JVTWZZdWVUUWlkZ25S?=
 =?utf-8?B?QzVBTjNwWEx6WG14MHJXNmViN21UWW5ld3IyV1IwWTYwZlRhbERJcEI4dEpl?=
 =?utf-8?B?SENQVStmSG9xbCt5L0wyMW1uVzNWWmJ5TDM2NDI5SllyZWV5djZwWUFWN25D?=
 =?utf-8?B?YnBONDB6eW5GRWovbTBBRTNvRWUzNzl0K3BDSnlVZ3BGUXUxakVlVmxDbTkv?=
 =?utf-8?B?MHFxMUIvQmpnUG01cWEzMWZVMjR3Tno3ZDdpMVdJNm9SanEzWUovVExjL0Fv?=
 =?utf-8?B?eWp0OVArYWg3N0tPZG52SWI4YzY1VStHZkNZYXJ0Und5cUh3L2Y2bjY5eDN1?=
 =?utf-8?B?K2FoU0RvVVNIalJkWnNUdTZPb0U2MFNGUEFHTTdJVko5eXo1c3F5VUR1NlNG?=
 =?utf-8?B?V0lNNFYvRm5VYWZFM0dlNDJudzdNQms2VEVQTHZtSXdtTVV4STQ2Sld3UTh1?=
 =?utf-8?B?V0x1eHVkTlltUmt5dVNFdmVidjRHUWhVSGZFN0xiYXZEc1FoYkh4YmlQd1Jj?=
 =?utf-8?B?SFM5RG5SL0djSndUdkRibUFnVDFkV2Rua1JTc3krZXhsQnd6SXhvcWxWQ21h?=
 =?utf-8?B?aEtldHpBbERVUFZ5YUdNbjZ6K3lRS0RGN1ErYkVyWDZaVkVqSmU2ZWcvYngx?=
 =?utf-8?B?ZWZYSzE1blA4NmkzRDBIWlN5VENBWmFyajFnQTBlVVBVQ3FWWXZENWdSVG9r?=
 =?utf-8?B?RFRPME5xUDBUMW41T0lYZFBXandxODRRejU4aTVlRVFNY3FwZTUxcVBFWVg3?=
 =?utf-8?B?c1M3cmt4cUZTUjZXM2tBNGhmdm45RDlVa0E3L0N6aFhsRHp2d1hkRWJDSHFM?=
 =?utf-8?B?RG9ZcnVGRnNTUlY5NzRoQkNIeDIrdWh1QjR6Z1BGdE1RSDYraEUwOVpuNUNO?=
 =?utf-8?Q?Bq6J/k8AiNdR4Lv1wvdYnFtQj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10d07fa-a2b9-43c1-21c1-08dc427b2044
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:59:37.3010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaSI+3+CAwBJpDLnEr+Uzr3UytnIM3rLBMvX7+g2znsx1Pxs4V2NlU9hpUTUMR83HuRlXG25+mmKUQVljEATFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542

On 3/11/2024 11:10 PM, Ian Rogers wrote:
> On Sun, Mar 10, 2024 at 10:23 PM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> Add core events taken from Section 1.4 "Core Performance Monitor
>> Counters" of the Performance Monitor Counters for AMD Family 1Ah Model
>> 00h-0Fh Processors document available at the link below. This
>> constitutes events which capture information on op dispatch, execution
>> and retirement, branch prediction, L1 and L2 cache activity,
>> TLB activity, etc.
>>
>> Link: https://bugzilla.kernel.org/attachment.cgi?id=305974
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> ---
>>  .../pmu-events/arch/x86/amdzen5/branch.json   |  82 ++
>>  .../pmu-events/arch/x86/amdzen5/cache.json    | 605 +++++++++++++
>>  .../pmu-events/arch/x86/amdzen5/core.json     | 122 +++
>>  .../arch/x86/amdzen5/floating-point.json      | 830 ++++++++++++++++++
>>  .../pmu-events/arch/x86/amdzen5/memory.json   | 180 ++++
>>  .../pmu-events/arch/x86/amdzen5/other.json    | 168 ++++
>>  6 files changed, 1987 insertions(+)
>>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/branch.json
>>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/cache.json
>>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/core.json
>>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
>>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/memory.json
>>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/other.json
>>
>> diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/branch.json b/tools/perf/pmu-events/arch/x86/amdzen5/branch.json
>> new file mode 100644
>> index 000000000000..208c646c59ca
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/x86/amdzen5/branch.json
>> @@ -0,0 +1,82 @@
>> +[
>> +  {
>> +    "EventName": "bp_l2_btb_correct",
>> +    "EventCode": "0x8b",
>> +    "BriefDescription": "L2 branch prediction overrides existing prediction (speculative)."
>> +  },
>> +  {
>> +    "EventName": "bp_dyn_ind_pred",
>> +    "EventCode": "0x8e",
>> +    "BriefDescription": "Dynamic indirect predictions (branch used the indirect predictor to make a prediction)."
>> +  },
>> +  {
>> +    "EventName": "bp_de_redirect",
>> +    "EventCode": "0x91",
>> +    "BriefDescription": "Instruction decoder corrects the predicted target and resteers the branch predictor."
>> +  },
>> +  {
>> +    "EventName": "ex_ret_brn",
>> +    "EventCode": "0xc2",
>> +    "BriefDescription": "Retired branch instructions (all types of architectural control flow changes, including exceptions and interrupts)."
>> +  },
> 
> So the "bp_" prefix means branch predictor, but here this is an "ex_"
> prefix. You've put them both in the topic "branch".
> 
> [ ... snip ... ]
> 
>> diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/other.json b/tools/perf/pmu-events/arch/x86/amdzen5/other.json
>> new file mode 100644
>> index 000000000000..9d49a23622e9
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/x86/amdzen5/other.json
>> @@ -0,0 +1,168 @@
>> +[
>> +  {
>> +    "EventName": "bp_redirects.resync",
>> +    "EventCode": "0x9f",
>> +    "BriefDescription": "Redirects of the branch predictor caused by resyncs.",
>> +    "UMask": "0x01"
>> +  },
> 
> Here is a branch predictor "bp_" event but the topic is "other", why
> isn't it a topic of branch?
> 
> Given the number of events categorized as topic "other" wouldn't it be
> better to regenerate the events just using the prefix to set the
> topic?
> 

Sure, I'll reorganize them.

