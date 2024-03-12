Return-Path: <linux-kernel+bounces-100293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B6D879522
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69BD1F2390E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23DF7A135;
	Tue, 12 Mar 2024 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nzpdpbZC"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7CD79B91;
	Tue, 12 Mar 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710250236; cv=fail; b=ajStugiVEGpiMZEDu912bgambXHV6x9kYoQgyQXHSNzI/deBJ85y68VVVfFZ1I+kUGx/Jmqj6w+sAFmcTdxoAEKQp9pyYV4WEyZ+YLTPl8zAj6tBW4nmFbwMRFRa72eeQQT8Dsze9fBoYoh+BsxzR2355YEmBWx71SDWHkWFO4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710250236; c=relaxed/simple;
	bh=uKa4ySdzNc1cZ5h8Iwex/A/+EZ08ZUjZb1uh2Va7MH8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TzoAYiVtsEUWhNaFYzM4fUJSNMZ/v+cJVL1fMIbhr8YL1H1KWj4Kq0XqjUM6uU+sx92Uy+YaBNA9O1jPqvAf+CNgQL/Hh8FAWAXIxgblJ+rGXnObqT89Yw1L97sQo/Hv8mn8EmTmdNrzVgosTUvD+5PXmPjDGq1Lg15HnW+KPrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nzpdpbZC; arc=fail smtp.client-ip=40.107.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mp9QRQOw1hq5PsbSHWLh47/uVUtx3r9ioHvA/MKUgY9WdJg9fHl5EacAYGKax4ZPbPJ2E0xWYypOXt59TWjduuXwhu0amX2UVTIoHY2o1VmfO0CYUgvGtniQ8xBDZ6aLWzgskCVGI/6vYyC966X4Kb+efL0KK/1wcrh0YxsPrGfwdcw6RADsQ2Iw3V9bmknbmA4tlnVdgTsDFkumlcdcX81H/LGjjhrsRM7mguDvJx6WiyGpoIr+vHMFCsH7+N9GQtBOyyQqyw+uFr+QahGf+yTSzOrljITL3mzqf6Dgorc+iI1XzCFtvh5NpfD65DDY1U7+FyP6QqcHzyN1E2ORDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQIkRgtMO98DMD2R864vzuS9HeYyFfC2IuP6wuMQduc=;
 b=dHhBYY0ybQk/tn7SzKCEftBL9In2HktywZle7xrtbKwnSKcIm8NVnNhOILE9h48/NGEoEEqNBHjYzwmqmhV/b9ogx0aLh+Mvk8QUT5lr/A1nRa0WYXZR8eW4EhtXsrQ7Ie9tdp2VagfO40pwTdYrMIYUnUW/T3ZZ3Tb51DfEbs+GkIy9rqt9U9auP3uWA/5KZMx7LCAe7J5NpGVXA4SabcXz3e+zMPhwFLArvSMcQbVh2CGqCSrG0fHcRkB9Z5pcUayrFf6qOk9Y+qFpiKyHTk2MNMV42J6JHc51WlOrWUaPKWEHxCzyFPejMMu0BWkNTHAnG1SPGYGoLDG8T+iEGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQIkRgtMO98DMD2R864vzuS9HeYyFfC2IuP6wuMQduc=;
 b=nzpdpbZCaKKiMXkbRE6gs9x+lasLnFab2ibUMuIoNOKs63lkIFPPvUbgk4xHmJSFRfeElreuFRAi6oC+QodDJtU2z4HR7mqi6jNZXaKRwHsLWlxFeZ/0y/pmI30Vx/2z7U/UzXgJwR9zBmLkU0USQKxJ4vkwk5y6hKkuRLygeRc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8715.namprd12.prod.outlook.com (2603:10b6:208:487::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 13:30:30 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::873e:e31:6eff:36a4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::873e:e31:6eff:36a4%5]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 13:30:30 +0000
Message-ID: <af8acdb7-8cc9-422a-a38d-8a4507ab11a1@amd.com>
Date: Tue, 12 Mar 2024 08:30:24 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>
Cc: James Morse <james.morse@arm.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <32a588e2-7b09-4257-b838-4268583a724d@intel.com>
 <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
 <9b20589b-6220-4ae7-bfc4-4a826b7114b1@intel.com>
 <5ddb7031-a828-4001-bfdf-5477cb85e9ed@amd.com>
 <1738493b-3248-4c9e-82a8-1599a033440d@intel.com>
 <369ab28a-f3fa-4359-8e73-4dcf214c9b6e@amd.com>
 <54687d59-d0e4-4fe7-b25f-dc1fead01ea1@intel.com>
 <11487a31-908e-d474-50c6-65617d417deb@amd.com>
 <c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com>
 <55b545fd-2851-0d0f-ac37-ec59838fb4b4@amd.com>
 <1f366890-d9ff-4ac4-9af9-1ea3128a87fc@intel.com>
 <41ca7504-c3fb-ddb6-e149-4ff82019d678@amd.com>
 <CALPaoCi=PCWr6U5zYtFPmyaFHU_iqZtZL-LaHC2mYxbETXk3ig@mail.gmail.com>
 <1d3e8b68-28fa-419b-b129-0c39df34f718@intel.com>
 <CALPaoChJPkfrMgFDhtZqwK7O8=A71CKLzQjEMG6LbgB9RhdzvA@mail.gmail.com>
 <e90ce54c-a830-4ba5-8b28-aeef06705d01@intel.com>
 <46065d68-8334-4b76-bc68-c2695e7b98de@amd.com>
 <ec15db92-24bb-46eb-963c-e872ff2ac9e3@intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ec15db92-24bb-46eb-963c-e872ff2ac9e3@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:4:60::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc0601b-0243-48a9-80b4-08dc429895ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rnUUMfolqyQqALCgrChkEFSnApAZQ31sIJV4jsoujZaTzzs8btAeEvNjjjVl1DU/QOVhoqMtASiusyMxnlZMY9OONuYmGqmDG1oH7s33lUR2xoRQmafLmLCs/47aXqRdnULJ0olaKWR338zAsPqQQyzmYPk0kxNjCQDXVlc/18/2oOT+2rKuqfoUcIggPhe7vIiZS2tB82gF2UCFsFCg4Wb8bc5ngTX0HIs8iSTB/snStbOQ/CQKkKw5TBq8BCnrwydP4zCuRLoDNFtHp84mtKCcVhA2+6okvL527gFaOy+WW3q5kBk/Fh3VSnvOreYkpAIJ9vn8brL+i/56DKftzYHIu27r/UGDgQgtRCzvpv8lGIqMztBenp43WZS7EKgCFX6Zg4B/jnG0yyLl3DsmeqGqeuqiPvPPjmt1Kb1Ds6bOFAY0bdLR3J803LK16CgRZVFJippm5C0wwtXL8r0m6BWgnZad7tAWJGTzOpNwIEpjGqlhQWHLFJ2tmdS2EqHPZsJfpIsZ/UMVTGzVyWLPHNL3Q7zmCH9qFo3k1jxYwDCoLpHoOEyx0ON0GuHqPm49yUGGC3Q8OZO/VHmIsHJ2IcJO+tfKJjxY2CrD4wU7aQEA6FenaQ5QtR/tKbLNLtveUOe1cBgFm4WajYWqw9BrmPg650QUsnhpcEtcBcTgp10=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejMyaWlsQ2FqdmhvaE1rQ25WblJZVzE5U0lrSVRWdlFheEdzMlk3NW1XYjZX?=
 =?utf-8?B?WitHRVAxNnJaeTZRYUh2R3NaWXZSK2pCTVk3ek1lUVhzNXo0M0ZBRDFGeWdM?=
 =?utf-8?B?V2FMdEZCd05qSjcybDQwcGFXc3piRjZzbk5hWGsydTdXSHFYSUM0eFkraldh?=
 =?utf-8?B?RjJEZjVyR25sdkJWdXpXaTN3Q01kTmxNTGlnNUdya0hYVk1PTW5Qem1mNXdJ?=
 =?utf-8?B?RDJETkdTZ1Y2WFFKSUxNQ1N1QmtNRWRyT3I1TXBPSEg4Nm11eXkyOEFETzVo?=
 =?utf-8?B?YTI4OGluMG52eDNPZ09DSXdDb24wR1ZySzNvOXY2N0ZOUytoMTBWRTNaWGti?=
 =?utf-8?B?OUZkYmhoamtCVklhWDU5d2dhVzVuQjI2ODB1RVgwV0ZYK1VDb3AwZVFldU9a?=
 =?utf-8?B?aXYzZTRrN0tPZVNnRFcvN2dLTk02a1dnM1lMbnE1dEdTZGJobEZzdlN6UjFq?=
 =?utf-8?B?SFk1K2hkQTFBNVZHUnZBNGpXY1RSY2UxVi96eDk2clJIZG1ETnZKb05GTmhx?=
 =?utf-8?B?bDMvOEQ3ZVA3OTVDOWFkVkhZODdvYnF0TmZXaVNzVUZaRGc2Qkl4aXpPSHpD?=
 =?utf-8?B?NU1XN3ZteEduMW43aU1pM3Q2NHFjR3hVd09BK3ZLNHRQWFE1OUZXcVVONy9m?=
 =?utf-8?B?VXpzNitlcmJySklGaGNQTnJVakhNeXZlYW5UWE9JeHRiS3VIVWQzVkFVSW1w?=
 =?utf-8?B?WEE1SjB4SzZHOUlqTWRvU090NFpMdmRNYm1xZ2pVblJQNXc3eTBKOUp3UlU5?=
 =?utf-8?B?d2c5RG9EK2dEYm9DTjB3QmxwclZ6aHVQOFNUMVpZLzJGd2ZHdnBWSkRZMXVP?=
 =?utf-8?B?dnVnU0NNNXRjMXphU0lBOTN4ajRDYVBxbUl6blJmYnJlcW1SVzl5enVscXpr?=
 =?utf-8?B?VU9NWkJVTGxKVUw5dDVFVk9OUllRcmhOamVWZUdSQWVYcnhBbCs3Mnh2ZnFt?=
 =?utf-8?B?TW1pSm52REdmaGNZelIwdUhoNC9zenNUUmVWRlNMOFdtTGFaRlkvMElqNWpL?=
 =?utf-8?B?KzFROTNQQlg3ZENpdzREa1VJTWlBWkhJSHFLRlFUM0N5VTd3VnFRWVk0RHA3?=
 =?utf-8?B?WWwzOEFVazRIS3B5UGZUR0llSlF4REt3enM5RE9mdUhzdHpqS2JzUzFTZW1v?=
 =?utf-8?B?bURsc29GZHRDWXhDR0lVa05oZUFIYzFwZ3orZFkzQUs1VjhuSWdFKzAzelA3?=
 =?utf-8?B?YnF3ZU5qNjBhR1BlZHNzcFBCaVdDTzVkL3lQVnJNbU94MlM4czk2VEVmdUlN?=
 =?utf-8?B?Nks0dTV3UUQzbWVNT3ZtaW9qZ3hNZ1JPZzlFM0tWaXpnOVN5dktOdEh2TVVZ?=
 =?utf-8?B?TUdpME5HclY2bXU4S0doRldmRVp0SGZTTkgxa2xuV2laK2JSbHhQUTZ6aGxO?=
 =?utf-8?B?THB2NHEzU0Zwd1BqUmttMkpVMlpxV0FjZnlEbnlpblNnL0Rub0RaUENqZmdT?=
 =?utf-8?B?R015OWhKUDJoeFpaVnJOYzgvOHcxSEg0N1dONVAwb2hHbFlWNGFpdUJSQmtD?=
 =?utf-8?B?STRGbFdOalNPVFBMbHBIN1lsVXhRM2Yxd240QUVuWnpPZEdRbEl4LzFtL0Za?=
 =?utf-8?B?MGdCR0Q1MmltbUhvd2RRemh2RXJGcDhieFlFWExDRjluN1RQZldrN0lGKzZp?=
 =?utf-8?B?Y08wSkE3eEZQYU03dVVTS3hYYS9FemRFTlZYeWlYbkR0ckRvbEIvV29la0Ux?=
 =?utf-8?B?VnlDL3JqVmRVZ1NzVXFHbCs4RVN6YXBLd1l1OFpBN1c0NytJOHBUMHV3K2hw?=
 =?utf-8?B?VEJPbGN0eDZaLytWaTJiTG11RlhpbG9xcFBEVTlSNWQzczRZQ29ydGpyM2Js?=
 =?utf-8?B?S0t1MmN3Y2EzN0NtWk5CUGZoUk1KaVFCL2lBWC9VVE5GblZsMnhKVFJaRCti?=
 =?utf-8?B?UnUwYndteElWVklkK000YVhLM1o0RzZvYTVpQTRRZnpQSjY5NnVvRXRHUjh2?=
 =?utf-8?B?azlkakpGS29pUEV6cGN5YURKT2pqVmVFbVlNb3VVTU9SVjF5MXo2aDY3bTlZ?=
 =?utf-8?B?VnI1bWYwNTFEd0xVT04wdzFaTThlT3VNcmduZjBEeCs5VnE1UkVSYXBnTDhw?=
 =?utf-8?B?OEpTNXdWRDRSdXZta21KYVRCSmZmekJGUDRJTXJrVmg2OEx3RDk1UUhhdzJK?=
 =?utf-8?Q?96LY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc0601b-0243-48a9-80b4-08dc429895ee
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 13:30:29.9193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDKt/H5sAsJ4MZa2Fhuxbk/6NYQfqsWIJtD0jUwE/aSp7OxQFGcJzzxQvTqS2bdy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8715


On 3/8/24 11:20, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/7/2024 7:50 PM, Moger, Babu wrote:
>> I am also thinking about replacing the newline requirement for multiple
>> groups. Domains separate by "," and groups separate by ";".
>>
>> Something like this..
>>
>> "/c1/m1/00=_,01=_;/c1/m2/00=_,01=_;/c1/m3/00=lt,01=lt"
>>
>> Thoughts?
>>
> 
> I would prefer that resctrl uses as consistent interface as possible
> between the different files. There are a few files that already
> take domains as input (schemata, mbm_total_bytes_config,
> mbm_local_bytes_config) and they all separate domains by ";".
> I thus find it most appropriate to stick with ";" between domains.
> 
> Regarding separation of groups, in schemata file for example it is
> already custom to separate groups (resources in that case) with "\n".
> 

Ok. Sure.

-- 
Thanks
Babu Moger

