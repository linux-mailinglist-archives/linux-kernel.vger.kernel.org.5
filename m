Return-Path: <linux-kernel+bounces-99142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0147C8783FD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239341C21AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0F04207A;
	Mon, 11 Mar 2024 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MVZSyR6U"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA1F41C92;
	Mon, 11 Mar 2024 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171645; cv=fail; b=XZwpR2Wv/A0OBjLZyHuh6HEuIq5oyq6Wh7ex7xrXd1k14J5MuUK1YJOYOQTQNhOilvxLuGuIGKxW9IKwTPA3Hmn+wJNF1yUd81essOYb4XeRGQZuf79HlvLYY84KWLD3eQnrHB3Iw1DDHqfYt6Hy0bSARdqWfh3JB2jA2Z53Mos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171645; c=relaxed/simple;
	bh=vWqLhp+FLexoMjfDMJNXXUFkPVYWtw3uVWpGRNXKr9I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kvd7afdKZ/vmLZmqvbiMsNWzTUP/w8ZuTwRf42MDkphWiY9FiSDHiDyBtmwUw3MCujai5OjNEY5a6LsuvImPAlUioywf8b0u7WxTcF0aPJj/g9zo68gntlyAlwQ1MN3njrWJIe1lQnrbW2wVzbo5eQNGM+IhnGbKQ850RFt9wKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MVZSyR6U; arc=fail smtp.client-ip=40.107.101.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZe7g6cMHugRe2yN71ClbPzzWgSYJhlas52lrfJotggxGvkbKHxBR6ahAaB1EYy3kF6gCN9gMU4UMwo4OStMyhzSWHkYqb3C5+Iax3AOZ3INJ/T3h+CDNiLpmuzcqsRR8pE0AtW6UNTXQf/i2BIZabGFEE6uIgVf38/Ng+8hhTX0uMIpVxKyBcRcUYulgXzpHvRBxDaDeeF1NpLaoFU2IqYHqmPWv0Loccu/1Int+lFiLFGcYFRRD/tr95yol5gWwI79wwGU64pBcGTozk6ZQMjv4KlhxwsVpgTES7r4Skr3O2qUUB5RWOp1+Gh0jlx012atMmn232lyD94EcRHRMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mj7s/OOvsdZqaBwZ9jRfhxgkUvpihhdr6b/APsSgIs=;
 b=mJxymhN07fEvxL7DJm/M+O3RWOKQ6L0cWKlGueFufXrv44v0HedZDOmKp6gkS411OalDXNm9mtB+vbjdftnWDYos6bV95C63KY1qR/42cDbgTcd4SuqttzouMgld4KwSqwGl53e0CFNVDMnwqHkT7euQ5jfyb1gL+HjGlQcQGNuNAw2HOMpz2sVhp/DxmgO2NvBvMTq38zzYFHMPzUV5GUq8khxFri+HZNgEEX8E8UJ0JIPcI1y4J8zRpwhMEc+FbwuseQq+IOFZkSlzjQpz+5GoWZImT0t7A6VSGKDxbGCO6SLdA7RVDrkC2zSXZ1llHJ4sOsG2DbOcsW8TxEUv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mj7s/OOvsdZqaBwZ9jRfhxgkUvpihhdr6b/APsSgIs=;
 b=MVZSyR6U8+7XRDlWP9ZRoSiD2pwk6a6TLK961txmI9L4F+TWRk5vepVRWA1qNkVb63vylJ6PrhSayYqUKPiSAskx5ue4bEu75xpr0/JHSJEwou3QPkHXbHqBQuyT7WpdYsT4IoG2Pnfv7jIIRIL39hYf2k7cqExb15sz4TrezFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV3PR12MB9234.namprd12.prod.outlook.com (2603:10b6:408:1a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 15:40:40 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::873e:e31:6eff:36a4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::873e:e31:6eff:36a4%5]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 15:40:40 +0000
Message-ID: <4b3418ed-751d-4e37-8d72-f2b4891eb714@amd.com>
Date: Mon, 11 Mar 2024 10:40:35 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
 <474ebe02-2d24-4ce3-b26a-46c520efd453@amd.com>
 <b6bb6a59-67c2-47bc-b8d3-04cf8fd21219@intel.com>
 <3fe3f235-d8a6-453b-b69d-6b7f81c07ae1@amd.com>
 <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com>
 <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com>
 <32a588e2-7b09-4257-b838-4268583a724d@intel.com>
 <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
 <9b20589b-6220-4ae7-bfc4-4a826b7114b1@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <9b20589b-6220-4ae7-bfc4-4a826b7114b1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:806:21::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|LV3PR12MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6e9f04-887e-4f34-ffe9-08dc41e19a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bCZ3WKeDYSFzQhfZKugiqP06gWVt+VDrdvk0qiUtbxHGD9VvYpKqMrulm2nAF7LESNSX7fbzhuH6smqH0qZocTtXNQ4D0ArYewGgc4MOYBs/Fccgj1sdi6S2y9YDXs/Y/GbprUuMVN5b/JBDgzCmItJxAXjj1mhXsuy6/rC9UxvBjRY5yHURGbvhCTuP1fukfjk4Qys6mx4aZMSsJLJez78FDfm5YEK71PsiQrfJ5YuC3+dZOeNQQyFY8hrF8zd/u9rVrRNMVb1yKqr9JniF+ncLjyLFBP0h6JqWav/EXH944V9nghQo+QGqIy9k1bZjIjGGDFdP1MhNhXEV5DSqlEK9GJ05vUe2KaqUdyfc2w73KP5Ah4xKn6GRZ3mc1rU0pmmBGaPfK5HVrwJcsHx0XVO58NvSM4+PJeEFMDXg2ECisLQuiW85N5oB1agzeHX3fFk3rGa4nGJ8BRrK4+bzFway2H68Um8KIqq/CdGojzZBDZd121M5ilg3C2Bzyf/I/6SJ7/Fh8IzfBIEStzYwZL4l0fnxHLU+QGe1s6lUVZZUk0yFy5zR3Wrsy8tNONMQ1rEPMcran5C1rxT/DsnoEj0dg5QZFWrNP5O8TyX8JnhlnziKFi6iSTCC6r6ma5Nh4e6DvXusqQQdpxfvg8Tl2ie42qQr43qU1oFp6tF6FN8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2pQNkcvN1B2SlE1WTJLcW1sQVhraTE1akdqbms2SzZKc0Rkam1UL1haeUk5?=
 =?utf-8?B?ckVHZG1lWmVWQkdSdi8yUk1XQkdkdFBic2lOalI2UGl0UXdRaCtiTHJNMDQ1?=
 =?utf-8?B?YVlVdFViRkhSL211eThwYUE3Wkd5SEloYWo5L1RrNFVlYm1tbXE4VVJCQ3Bm?=
 =?utf-8?B?R2NBQXVVNHZnSkxTQlpaOTY2dkNXOGh0T01iL0x0Y0h6UFNJczJVR05pT2Nz?=
 =?utf-8?B?akpQSkp5d0pYN0NxWmYvRzZ0M2FWSTNWRDdhU3FIQ0hPQkhjVUZ0SElyR0d4?=
 =?utf-8?B?czIvVXpENWtvSS8ycDc3Y0NzdEorbDZnSWg1cVZCL3grSU9oNWV3VndTWTVT?=
 =?utf-8?B?NzNPNHNyVzlnMzJJRmxWZEc0YkdwWFEzaWJHYmxLS1pwbFpVVzJCNWg2VEQ0?=
 =?utf-8?B?aVFVZThjNmZlelVDMTkyd0hxYkZvMDFIZFZlZERWSVc4Sm51L1JIUEhiUGVk?=
 =?utf-8?B?TlZxRzdXNUNiYytIYmZKNjFrSlpEOVV4OWMxUjdXOGxidHA0VFZkUnNrOEdv?=
 =?utf-8?B?a2hFdEhDSGxWaHpCMW04UUZWeEdGVk9YNjdUL09vUEprZnZuRUM0T1pCQ3R4?=
 =?utf-8?B?dmU3UlErVDlhOVlzdzBTWGRKUzg2Y1RWUFZMZUNqSUJVZFgrby9NMEZnaTA1?=
 =?utf-8?B?a1hEcDhZbHkwN3pNMXZJOVZoRGdZelZVeUxwRlBJR0hPNVBjby82ODM3SFZo?=
 =?utf-8?B?U2pBK2tNQzRyZmdMNUVuTklrK3Fxbmg1UjBDS2JLWkxOTTBoNUl2dnB5QjBN?=
 =?utf-8?B?N0NPdVpJazE1cjlyT0pINHF5Yzd6cTdvRnVjK3dicFJidTc1ZXpoREFoZEE5?=
 =?utf-8?B?Rzczb2dyS2pZRW93NWlocjhsZy8xQ0k4Rk5lT2E5cDFUU2tCWktGRDlMZzQw?=
 =?utf-8?B?VDM2Wm9MOFY2b0x5Ung4dkR1bElFUnArbEVHMWFzNjNNQ09jOVRaTTRkaTY4?=
 =?utf-8?B?VUIwRzBvek10dzgwUEhsN3MvVitwZ3lGNitjckJSNndYZ1ZSL2N3d2t4WlY2?=
 =?utf-8?B?b0tGSERmaFJqb0QyRUVBSHoyKzh4d0lSRlA3cUdjdWFoTkdoc1ZoMWpCS1hu?=
 =?utf-8?B?UG55SkpENW83M2hLZ05zbnl2SHFlbGdsMUVlWERRM3IrbStJc0JWVlE1emFO?=
 =?utf-8?B?VUdXTTAzaUVJVUR4VGtYNmNOYXFYUjI4SDV3aXpMWjRhWVRWcXNNejNmb3Jr?=
 =?utf-8?B?SXZMK2MxT2dyTjlnSVNKRURmU1hBNmlhdFRZWHZKVjlrM2NYcGsrZE0yTEtZ?=
 =?utf-8?B?eklBeEpIajB4WEd0MVJwMk80clpla0ZIQXRlQkFhVmNCTFYrRHRMNThvaU5x?=
 =?utf-8?B?YjVxOUE2VUpuYlVac3pXNERWcWVSNlpLWlV1cnM2YVVnSnNady9YQ0FCaml6?=
 =?utf-8?B?UTFpZ0ZyaVpEU0lYRmZsUXAyLzlzV2pLWGI2R3ZYWkh0VmJ6Mkw5YXhuN0Z5?=
 =?utf-8?B?L3ByRG9uemFPRjI1RnpQaXhTVXQ0L25yRXU4bGlYbGJzNEZRQUxlam5MdnlF?=
 =?utf-8?B?eVQyaGFQZTU4MFhuUG9DVXpHWGVjZGV5cW1mK0JITzBIM3RPVXNhRmEwL1hM?=
 =?utf-8?B?QnoreFM5anlLM0tQNWVjSXhiVDFPOFRVRXlURVhRWXJteUJzUFRteDBvNlN1?=
 =?utf-8?B?ZmV2ekkyVVBzdDVuZnI0ZlBRSnVDaGk3QUtrS2JrT1BEUUxEQ3N0bWR0UVVk?=
 =?utf-8?B?d2F5RzVENEdZVEpHVW5sYmRlS21wYTYxSW9HWXlQRUhveWFyZHVvTG5oc2FI?=
 =?utf-8?B?SFQ3YWJ2bUN4cG1wTDBLTHJNSmdzZFJ0VWEvS2lEZ1AzQTlnTEgrR3F5MEsy?=
 =?utf-8?B?S2NpME1sWmUrQ094djBDUVVRZDZucHBHc2VZRDNjdmNVUGRnWWd5emFRSG5C?=
 =?utf-8?B?K2MyelRNbER5RzhPTmQ1STduVThBZkhBMmI5VWZLMllEaFc1OUNJbFNTSXpL?=
 =?utf-8?B?K1ZUMHZsMWlLQlZjeHFnSkhNcHVDbmZuL0szZkttN0NFcm82TnpwcTVJSzlr?=
 =?utf-8?B?dHByZjNRZjBqOW9LbERlUEp0OGxxbTg2eWc3TEp6bGZaR2pWRmhYMmlDL3RB?=
 =?utf-8?B?VmN2aGxLNUFTYWN1UTJsRVJta1FLaVgzWTVVazVDZlNjeTlkaG5RZ1o3bkVw?=
 =?utf-8?Q?9BlY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6e9f04-887e-4f34-ffe9-08dc41e19a2e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 15:40:39.7615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLBCCBAgXfTE/qZXrONWiEC6neMSreNBr1tMO/DfBaht2HwwT3beOlHuKXaSJbdd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9234

Hi Reinette,

On 2/27/24 17:50, Reinette Chatre wrote:
> Hi Babu,
> 
> On 2/27/2024 10:12 AM, Moger, Babu wrote:
>> On 2/26/24 15:20, Reinette Chatre wrote:
>>> On 2/26/2024 9:59 AM, Moger, Babu wrote:
>>>> On 2/23/24 16:21, Reinette Chatre wrote:
> 
>>>>> Apart from the "default behavior" there are two options to consider ...
>>>>> (a) the "original" behavior(? I do not know what to call it) - this would be
>>>>>     where user space wants(?) to have the current non-ABMC behavior on an ABMC
>>>>>     system, where the previous "num_rmids" monitor groups can be created but
>>>>>     the counters are reset unpredictably ... should this still be supported
>>>>>     on ABMC systems though?
>>>>
>>>> I would say yes. For some reason user(hardware or software issues) is not
>>>> able to use ABMC mode, they have an option to go back to legacy mode.
>>>
>>> I see. Should this perhaps be protected behind the resctrl "debug" mount option?
>>
>> The debug option gives wrong impression. It is better to keep the option
>> open to enable the feature in normal mode.
> 
> You mentioned that it would only be needed when there are hardware or
> software issues ... so debug does sound appropriate. Could you please give
> an example of how debug option gives wrong impression? Why would you want
> users to keep using "legacy" mode on an ABMC system?

We may not be able to use "-o debug" option to enable "legacy_mbm".
With debug option it will always go to legcay mbm even if ABMC is supported.

For example when ABMC is supported, I cannot mount the resctrl with debug
option to test ABMC.

I need to have a way to mount resctrl with ABMC and debug option. I can
add "-o legacy_mbm" to enable lecacy_mbm.

Thanks
Babu

