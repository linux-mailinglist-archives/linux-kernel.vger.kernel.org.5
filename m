Return-Path: <linux-kernel+bounces-89092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D656486EA5E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C016287C81
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73B53C492;
	Fri,  1 Mar 2024 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V1wqXDci"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A823A8FF;
	Fri,  1 Mar 2024 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325382; cv=fail; b=ZLH1up2kbYJ0A5iKRBfgOFZgsly31JZz/mG5T4g0uCKdG/1v0qGEtOxoRbB/zSzsH3ArTK+DELgjVy+hUcrp6I6/GHs5a+uiLGxe/P/q9YTLdPfdk/n13cwSNYaI2WXVymXyzBxmJCaJ7vOpJGedEv2vRrzavOjk8MFoH73x4ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325382; c=relaxed/simple;
	bh=imllWSI2RmiSV1ZtQyKlqsrT0DLQz1EE30UQZCbceTU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IdSf53dlStnkA28pZ8tO4keId25cz2b18VOP846vlFSDiH6jhk4IPbbZ2T2hEHnBCS/ILmE6XbF5+c18XShqKkGF1SkjFK7828beGCCYemMChIKRwLbVCfak0dX9ZbZkXzqcjNUtyv7e786Oye7XKlNV81n73HtjpnB7rpNWEZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V1wqXDci; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lv2Rea172gtzfvXYjaem3jWtfb9cp7Fmn4E1dRgIoh0cuxbeVBWHtZ6DjrIiwzAAdfm0bqs/iXJ8wwdE2ViXkCu8+fyHRcmdP4mMiw75RvxDsV560CKqJeHHgxi1QIL0txF4qmG+DvzBEgG8AjdpxPmYsgLiI83VC8vKvL3sYJIsGJZEvhjcCfkQI2HgWsfOknz5uteOj57zBgGyZFsFYOH+QMG51LXF97rvLAej65tBUMKhrceWsc7kBPZGI1ABGUL3mzl4Xt4HhyOMvdRN4Y+MshmMVU78Wae1L4OGjF3GoviCFod2VcmVlS8neRwZ2V1KZ5miwC2btgRE5Ip2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiptFgSoML+WiXH/ASSFZTfuW8vYfzS5foNhfv5nEI0=;
 b=Wo3OaoDIES/Q7JfNrSbhvyMLmKrb9qlsy7Hsr67MH3njMzl+vgBnYk5ubrwWEpFLUxj6A6Lga2G/y+XD74NaVeI7GdNn/vdx5iGTO9xkZb/OOBVFEHRUjeVIoE3kHK/CppvWH3VSBBdq8ufphgHrj7ykqQogOyCZHyjp5gRjZdG82kHLldhJwmEYWzqsGUDq0+MOIbSULKnB4buCvH4hICyATHWpb/EC8YBa8104M0S0CVQnSA0vuVETGQwU3t8yOiCvEzpwKqOS/hIOMBXBDeIZJ46gGs5Q2efci3GsCGFFaGTHyMF+hzvRucBKgqtKJ1vPCdBJu6NlRol4bp+EWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiptFgSoML+WiXH/ASSFZTfuW8vYfzS5foNhfv5nEI0=;
 b=V1wqXDciLjUMPiGVXcOGRnEq/IGkDbhPPtubm4pTNOzEumoME2ZQUzmfbpqtpIiDM7LLYLgH2ThBZVVP3vX+9tcjObc0VfxrC3Yy0YpH1M81I/sK6aixD5FW+8JgHw/e3ioSt8f8WnZAlRLlOZBD1Ne0LZaakhgDRkVRVWGBZ2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 20:36:17 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54%4]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 20:36:17 +0000
Message-ID: <11487a31-908e-d474-50c6-65617d417deb@amd.com>
Date: Fri, 1 Mar 2024 14:36:10 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Reply-To: babu.moger@amd.com
To: Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, Peter Newman <peternewman@google.com>
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
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
 <5ddb7031-a828-4001-bfdf-5477cb85e9ed@amd.com>
 <1738493b-3248-4c9e-82a8-1599a033440d@intel.com>
 <369ab28a-f3fa-4359-8e73-4dcf214c9b6e@amd.com>
 <54687d59-d0e4-4fe7-b25f-dc1fead01ea1@intel.com>
Content-Language: en-US
In-Reply-To: <54687d59-d0e4-4fe7-b25f-dc1fead01ea1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: bc58ed27-3dbb-47c6-f565-08dc3a2f3e9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A2Sv7bJHt5FVnDfkl/0tail2QjMsisWa7UEr1cSBxRn/I8UeAbDvSIaI3lNFj3Cm/wVHGDpMJCD/CZQM0OckVacclNLNPld/H0S1E0ZIgUZPQsyXtyyrLMy7EnFYViDtl+eLc5DW5a+eUgvOXklSx4nlDYRu+63Fpes6nQFRvZe/qNPZsrBCn2FCFT883j10JEcec8o2Gkh6kmN5tTd7z467gKpclAjPWtWY/jaMeYolUqMLELq7VEs1npGGN6jV2Qok353reZta8pPOhqTkjFUdJfmcdiTVpbXAbc1/PAoeSEVC+KrGlVyCW7ycNTd3hAOs03CD7RLk9+LT58KMTPOKOi08Cr2yUoNDxheA1HykzKm+jCId+oexWz+jB+zqk81HLPv4bsBtikys1DTHBi6DcHF8ItUUE/0mfx8P+57p3Ha67N1rzq/Bvf4S3BjJJlCIBLElMTEvrAVdyQonwGaRhUZP3OtGgrmLAhd+txOqwfd3W8OXvyzl2+YhYi1YR6MMGW2ZMO5hZTcrF0/SjsEdO1esW6UHXY3haIE+Z0wOnWan+kz2HFIGWYrvBDZDt0IgqvWT1RIB+mE3CrmAFaUc5c7F5QrOiCu0D2idtNtTaPzE6Y73OYN3id2L2AL4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDg0THo0Q1dnOW14cUJ1cFVrOHF2ZG5kUlZadTVKaDh6VW94TDM4RysxQzJr?=
 =?utf-8?B?bWZRK1puVUNaZytYOFFUUTlaZ2pGQU1rTW1nc1o2QTJhWDhUSXp3Y09zWnhL?=
 =?utf-8?B?N1R5VWwwbm9OTWNtY09wL1p2bnlDb3ZLc3lndkFab3B1YlNpejBwZm04SkIy?=
 =?utf-8?B?TWxDZW1BN0pFK2tVbW90UGc4TUJNN1pXWmRHRnBOdVMwejFabHhJL0JZSGta?=
 =?utf-8?B?Zm9rUUVhWTUwanlheXBDV3lzeXhwbG44QnhqcHo0YkZXRHl3RURGMmpWSGo3?=
 =?utf-8?B?RGdqWkFNM01qL0dmWnlKMDJvSVQ4Z0tFL1psbm9tWkFpckl6VEZEZnBZMTNw?=
 =?utf-8?B?SUZnek5Wc0NQS0JRQkQvbWo1V2NRcU9mMUpzUUdoTWpMRnU3bkxxQko2ZmJk?=
 =?utf-8?B?dHZEWUVINTZUUDdKdDNSVE9vLzBTKzMxZXJ6MWowdm93SmdHYWp3Qyt4bDJG?=
 =?utf-8?B?aDFaaWgwZFlEVEk3YnJESk96K0o2UDZVMktIeUorWFhnNW9MWVluaUxSZ1dr?=
 =?utf-8?B?V3IraTMyUUFpU2s0MHJZWGQyNnBXOUF0aFFxTm51WXhhM0VMTkU5SVRFWFp1?=
 =?utf-8?B?NmFwcGN3Q0xKdEhxblhZMHNkNkFTS3lHNnJJTnJrVDk1ZWFXWVRGWk04eEVC?=
 =?utf-8?B?UUhZdTI5TXRKZmdwWEJqdHpjeWZXVlVNN3BWb3V6SlBQSFlRc2J5a3JaRUx4?=
 =?utf-8?B?VmJTa3NwYmR1V1MrV2RuR3FRb2laS1VHZHhuQ1lUOWpUZ0pmN252NmxVZFAz?=
 =?utf-8?B?MGlscUZ6TzlqVjhaZlhxM0xaMDZIczBDK2RFK2hUd2NnVlkrUDVXK3lhOURO?=
 =?utf-8?B?RVpRZllRMXhycEZjdHFkeWZGdFFSbHdXdEVTai9neDJPd3Z6K2JvZ1BFSVhs?=
 =?utf-8?B?aEF1QVVDRlB4L0YwaDAzaCtoclhqa0Y0ajFuOHJhakIzTGkrMi83N1ZZL08r?=
 =?utf-8?B?ZFR2WGRKUEJIcnIxWnpkZDBqeDJ5cjNTWWhUUDdaWUphVyt6MWJKU3BHeWU0?=
 =?utf-8?B?VVo0V1doUEkxRVlPbjVsVmJXN2FzWGlGendiTkNKVUw5cm5rSGt3cFdyakJV?=
 =?utf-8?B?VXNobWEwLysvUUxIRGVLRVN6cTZkNlZSUmZSZWpQNE5uVXZLbjk1emRyL2dP?=
 =?utf-8?B?bVU4Y25HWWpCcE80WjFCYUViRXVXZHN1WnljVnpjS25LMnR3ME9ON3ZCc1Ni?=
 =?utf-8?B?U0JNM0dXdDZHc0djdTViUVZpeURSZndLUmJOOEllN2MwS2pGNHMvR2pkemdM?=
 =?utf-8?B?VEZ0azdHcStGV2VnaWtZUVFMSlFVcTNXSmJsNjBDR0dBeGpvSjdOWHpXczIr?=
 =?utf-8?B?M2dFMnJvVnBocTQzZU4yZHN5aUNIZlhISjdxNUw0WEQvNTd4MnY5QU4vaENZ?=
 =?utf-8?B?MUxBY3lUN2F2bW82VEtJV0VwWDJRUDEyWHZad0pib0RPR0JwUjk3endVQkZr?=
 =?utf-8?B?WUFIeVVnL1BiSXhMdlk2VXI1Q2laNyt1ejc2b2taMjd4ZmtkZzVPMXMxNzN1?=
 =?utf-8?B?eEluQVlLY1hXdDB4SzNjUElCYWM5RklDZlVTd0I1VTgwSUNKdDViUG11RWNJ?=
 =?utf-8?B?MlRpMFE2Q2t0Wm1BaFZWc0tHK0UzN0VxSkI0SFEyVXJaZXkvZnpxSGd6N0VS?=
 =?utf-8?B?V29uc0d5WDlvdllPVUJrekJ4KzlXMzE2cHBKL3JoV0IyVVBiN0NvWEdEMy9a?=
 =?utf-8?B?QS9pbUNvUmN3ZXhnWXdIMWtEVlg4OGJPWE1BMzZpMEkzZS9aNUFUNGtVWnFl?=
 =?utf-8?B?VGNhVzd5RGhzbmhESHRMVTBuSGtlUElSU1AzU2ZSdVNaeGdSdWRyOUdKOFRE?=
 =?utf-8?B?dFpmVWV1ZmdvQldpSXh2b3JqbG5OWURieXcrZkdWTXJQVkJNT3VtNFY4NUV6?=
 =?utf-8?B?MkJ3TktlNVNzN01hUGM5VS9aU1VndEpRYzNCMVhvVklHL2ZiemJoU2pYNDF1?=
 =?utf-8?B?c3BVNXY5T3docURqVjVSa25MSWlBUTdRZ3ptQ3Jjb3RXYU5xZFdUYVNyYkV0?=
 =?utf-8?B?cjFxeUx2R1FEVUNRMUEyNjJyU1BrSXIwTEg4TjBjdzVtN2VoQXVtUC93enVP?=
 =?utf-8?B?eWFEKzMreDlySiszbnNKUnloalV3OWV5MVJIVVpBbktubEZTMCsvV0xZYm5p?=
 =?utf-8?Q?U77U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc58ed27-3dbb-47c6-f565-08dc3a2f3e9f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 20:36:17.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCvI0lso2BB706+cVSodoeVDbIBCuoa8bq2ZRvhSXvae7d/9U53aopmVf1tb+opL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076

Hi Reinette,

On 2/29/24 15:50, Reinette Chatre wrote:
> Hi Babu,
> 
> On 2/29/2024 12:37 PM, Moger, Babu wrote:
>> On 2/28/24 14:04, Reinette Chatre wrote:
>>> On 2/28/2024 9:59 AM, Moger, Babu wrote:
>>>> On 2/27/24 17:50, Reinette Chatre wrote:
>>>>> On 2/27/2024 10:12 AM, Moger, Babu wrote:
>>>>>> On 2/26/24 15:20, Reinette Chatre wrote:
>>>>>>> On 2/26/2024 9:59 AM, Moger, Babu wrote:
>>>>>>>> On 2/23/24 16:21, Reinette Chatre wrote:
>>>>>
>>>
>>>>>>> For example, if I understand correctly, theoretically, when ABMC is enabled then
>>>>>>> "num_rmids" can be U32_MAX (after a quick look it is not clear to me why r->num_rmid
>>>>>>> is not unsigned, tbd if number of directories may also be limited by kernfs).
>>>>>>> User space could theoretically create more monitor groups than the number of
>>>>>>> rmids that a resource claims to support using current upstream enumeration.
>>>>>>
>>>>>> CPU or task association still uses PQR_ASSOC(MSR C8Fh). There are only 11
>>>>>> bits(depends on specific h/w) to represent RMIDs. So, we cannot create
>>>>>> more than this limit(r->num_rmid).
>>>>>>
>>>>>> In case of ABMC, h/w uses another counter(mbm_assignable_counters) with
>>>>>> RMID to assign the monitoring. So, assignment limit is
>>>>>> mbm_assignable_counters. The number of mon groups limit is still r->num_rmid.
>>>>>
>>>>> I see. Thank you for clarifying. This does make enabling simpler and one
>>>>> less user interface item that needs changing.
>>>>>
>>>>> ...
>>>>>
>>>>>>>> 2. /sys/fs/resctrl/monitor_state.
>>>>>>>> This can used to individually assign or unassign the counters in each group.
>>>>>>>>
>>>>>>>> When assigned:
>>>>>>>> #cat /sys/fs/resctrl/monitor_state
>>>>>>>> 0=total-assign,local-assign;1=total-assign,local-assign
>>>>>>>>
>>>>>>>> When unassigned:
>>>>>>>> #cat /sys/fs/resctrl/monitor_state
>>>>>>>> 0=total-unassign,local-unassign;1=total-unassign,local-unassign
>>>>>>>>
>>>>>>>>
>>>>>>>> Thoughts?
>>>>>>>
>>>>>>> How do you expect this interface to be used? I understand the mechanics
>>>>>>> of this interface but on a higher level, do you expect user space to
>>>>>>> once in a while assign a new counter to a single event or monitor group
>>>>>>> (for which a fine grained interface works) or do you expect user space to
>>>>>>> shift multiple counters across several monitor events at intervals?
>>>>>>
>>>>>> I think we should provide both the options. I was thinking of providing
>>>>>> fine grained interface first.
>>>>>
>>>>> Could you please provide a motivation for why two interfaces, one inefficient
>>>>> and one not, should be created and maintained? Users can still do fine grained
>>>>> assignment with a global assignment interface.
>>>>
>>>> Lets consider one by one.
>>>>
>>>> 1. Fine grained assignment.
>>>>
>>>> It will be part of the mongroup(or control mongroup). User has the access
>>>> to the group and can query the group's current status before assigning or
>>>> unassigning.
>>>>
>>>>    $cd /sys/fs/resctrl/ctrl_mon1
>>>>    $cat /sys/fs/resctrl/ctrl_mon1/monitor_state
>>>>        0=total-unassign,local-unassign;1=total-unassign,local-unassign;
>>>>
>>>> Assign the total event
>>>>
>>>>   $echo 0=total-assign > /sys/fs/resctrl/ctrl_mon1/monitor_state
>>>>
>>>> Assign the local event
>>>>
>>>>    $echo 0=local-assign > /sys/fs/resctrl/ctrl_mon1/monitor_state
>>>>
>>>> Assign both events:
>>>>
>>>>    $echo 0=total-assign,local-assign > /sys/fs/resctrl/ctrl_mon1/monitor_state
>>>>
>>>> Check the assignment status.
>>>>
>>>>    $cat /sys/fs/resctrl/ctrl_mon1/monitor_state
>>>>        0=total-assign,local-assign;1=total-unassign,local-unassign;
>>>>
>>>> -User interface is simple.
>>>
>>> This should not be the only motivation. Please do not sacrifice efficiency
>>> and usability just to have a simple interface. One can also argue that this
>>> interface can only be considered simple from the kernel implementation perspective,
>>> from user space it seems complicated. For example, as James pointed out earlier [1],
>>> user space would need to walk the entire resctrl to find out where counters are
>>> assigned. Peter also pointed out how the multiple syscalls needed when adjusting
>>> hundreds of monitor groups is inefficient. Please take all feedback into account.
>>>
>>> You consider "simple interface" as a motivation, there seems to be at least two
>>> arguments against this interface. Please consider these in your comparison
>>> between interfaces. These are things that should be noted and make their way to
>>> the cover letter.
>>>
>>>>
>>>> -Assignment will fail if all the h/w counters are exhausted. User needs to
>>>> unassign a counter from another group and use that counter here. This can
>>>> be done just querying the monitor state of another group.
>>>
>>> Right ... and as you state there can be hundreds of monitor groups that
>>> user space would need to walk and query to get this information.
>>>
>>>>
>>>> -Monitor group's details(cpus, tasks) are part of the group. So, it is
>>>> better to have assignment state inside the group.
>>>
>>> The assignment state should be clear from the event file.
>>>
>>>> Note: Used interface names here just to give example.
>>>>
>>>>
>>>> 2. global assignment:
>>>>
>>>> I would assume the interface file will be in /sys/fs/resctrl/info/L3_MON/
>>>> directory.
>>>>
>>>> In case there are 100 mongroups, we need to have a way to list current
>>>> assignment status for these groups. I am not sure how to list status of
>>>> these 100 groups.
>>>
>>> The kernel has many examples of interfaces that manages status of a large
>>> number of entities. I am thinking, for example, we can learn a lot from
>>> how dynamic debug works. On my system I see:
>>>
>>> $ wc -l /sys/kernel/debug/dynamic_debug/control
>>> 5359 /sys/kernel/debug/dynamic_debug/control
>>>
>>>>
>>>> If user is wants to assign the local event(or total) in a specific group
>>>> in this list of 100 groups, I am not sure how to provide interface for
>>>> that. Should we pass the name of mongroup? That will involve looping
>>>> through using the call kernfs_walk_and_get. This may be ok if we are
>>>> dealing with very small number of groups.
>>>>
>>>
>>> What is your concern when needing to modify a large number of groups?
>>> Are you concerned about the size of the writes needing to be parsed? It looks
>>> like kernfs does support writes of larger than PAGE_SIZE, but it is not clear
>>> to me that such large sizes will be required.   
>>>
>>> There is also kernfs_find_and_get() that may be more convenient to use.
>>
>> Will look at this. There is also kernfs_name and kernfs_path.
>>
>>> I believe user space needs to provide control group name for a global
>>> interface (the same name can be used by monitor groups belonging to
>>> different control groups), and that can be used to narrow search.
>>>
>>> Reading your message I do not find any motivation _against_ a global
>>> interface, except that it is not obvious to you how such interface may look
>>> or work. That is fair. Peter seems to have ideas and a working implementation
>>> that can be used as reference. So far I have only seen one comment [2] from James
>>> that was skeptical about the global interface but the reason notes that MPAM
>>> allocates counters per domain, which is the same as ABMC so we will need more
>>> information from James here on what is required since he did not respond to
>>> Peter.
>>>
>>> Below is a *hypothetical* interface to start a discussion that explores how
>>> to support fine grained assignment in an interface that aims to be easy to use
>>> by user space. Obviously Peter is also working on something so there
>>> are many viewpoints to consider.
>>>
>>> File info/L3_MON/mbm_assign_control:
>>> #control_group/mon_group/flags
>>> ctrl_a/mon_a/00=_;01=_
>>> ctrl_a/mon_b/00=l;01=t
>>> ctrl_b/mon_c/00=lt;01=lt
>>
>> I think you left few things here(Like the default control_mon group).
> 
> No. Similar to proc_resctrl_show() the fields can be empty for
> the default group or mon groups belonging to control group.

ok. Need to understand this better. Hope I learn while doing this work.

> 
>>
>> To make more clear, let me list all the groups here based this.
>>
>> When none of the counters assigned:
>>
>> $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> resctrl/00=none,none;01=none,none (#default control_mon group)
>> resctrl/mon_a/00=none,none;01=none,none (#mon group)
>> resctrl/ctrl_a/00=none,none;01=none,none (#control_mon group)
>> resctrl/ctrl_a/mon_ab/00=none,none;01=none,none (#mon group)
> 
> I am concerned that inconsistent use of "/" will make parsing hard.

Do you mean, you don't want to see multiple "/"?

resctrl/ctrl_a/mon_ab/

Change to

mon_ab/

> 
> I find "resctrl" and all the "none" redundant. It is not clear what
> this improves.
> Why have:
> resctrl/00=none,none;01=none,none
> when this could do:
> //00=_;01=_

ok.

"//" meaning root of resctrl filesystem?


> 
> 
>> When some counters are assigned:
>>
>> $echo "resctrl/00=total,local" >
>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control (#assigning counter to
>> default group)
>>
>> $echo "resctrl/mon_a/00=total;01=total" >
>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control (#assigning counter to mon
>> group)
>>
>> $echo "resctrl/ctrl_a/00=local;01=local" >
>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>
>> $echo "resctrl/ctrl_a/mon_ab/00=total,local;01=total,local" >
>> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
>>
> 
> We could learn some more lessons from dynamic debug (see 
> Documentation/admin-guide/dynamic-debug-howto.rst). 
> For example, "=" can be used to make an assignment while "+"
> can be used to add a counter and "-" can be used to remove a counter.
> "=_" can be used to remove counters from all events in that domain.

Yes. Looked at dynamic debug. I am still learning this interface. Some 
examples below based on my understanding.

To assign a counters to default group on domain 0.
$echo "//00=+lt;01=+lt" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

To assign a counters to mon group inside the default group.
$echo "mon_a/00=+t;01=+t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

To assign a counters to control mon group inside the default group.
$echo "ctrl_a/00=+l;01=+l"  > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

To assign a counters to control mon group inside another control group.
$echo "mon_ab/00=+lt;01=+lt" > /sys/fs/resctrl/nfo/L3_MON/mbm_assign_contro

To unassign a counters to control mon group inside another control group.
$echo "mon_ab/00=-lt;01=-lt" > /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control

To unassign all the counters on a specific group.
$echo "mon_ab/00=_" > /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control

It does not matter control group or mon group. We just need to name of 
the group in this interface.

Listing will be

$cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
//00=lt;01=lt
/mon_a/00=t;01=t
/ctrl_a/00=l;01=l
/mon_ab/00=_;01=_

> 
> The interface should also support assign/un-assign to multiple groups with
> a single write. To start this could use '\n' as separator as is the custom
> with other resctrl interfaces. 

Yes. that should be fine.

> 
>> $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> resctrl/00=total,local;01=none,none (#default control_mon group)
>> resctrl/mon_a/00=total,none;01=total,none (#mon group)
>> resctrl/ctrl_a/00=none,local;01=none,local (#control_mon group)
>> resctrl/ctrl_a/mon_ab/00=total,local;01=total,local (#mon group)
>>
>>
>> Few comments about this approach:
>> 1.This will involve lots of text processing in the kernel. Will need to
>> figure out calls for these processing.
> 
> I see that additional parsing will be needed to determine control group
> and monitor group. For these it sounds like you already have a few options
> for kernfs API to use.
> Apart from that the counter assignment will be similar parsing as what
> was done in your previous versions. I think parsing will be easier if it
> does not try to use words for the events but just use one letter flags.
> For example, there is thus no need to look for "," in the parsing of the
> events, just parse one character at a time where each character has a
> specific meaning.

ok.

> 
>>
>> 2.In this approach there is no way to list assignment of a single
>> group(like group resctrl/ctrl_a/mon_ab alone).
> 
> Should the kernel be responsible for enabling this? User space can just
> do a "cat mbm_assign_control | grep mon_ab". Is this not sufficient?

That may be ok. Peter, Please comment on this.

> 
>>
>> 3. This is similar to fine grained approach we discussed but in global level.
> 
> That is what I have been trying to get across. This has full benefit of the
> original implementation while also addressing all problems raised against it.
> 
>>
>> Want to get Pater/James comments about this approach.
> (Peter)
> 
> Of course. I look forward to that. Once agreed it may also be worthwhile to
> approach x86 maintainers with an RFC of the proposed new user interface to learn
> their guidance. This is where it is important to keep track of all the requirements,
> as well as pros and cons of different options.

Ok. Sure. I am fine making next version as RFC.

> 
> Reinette

-- 
Thanks
Babu Moger

