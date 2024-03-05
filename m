Return-Path: <linux-kernel+bounces-92560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E0387222A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9938A1C21145
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA37126F0D;
	Tue,  5 Mar 2024 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rhSKK3Xs"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5384585954;
	Tue,  5 Mar 2024 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650700; cv=fail; b=aqM4lkZCwe08nSYTxqAT8NIGy8Q/qZZeHPPXm+8aw09rg1CWaqNPKnPdVXatJXwft+ytXJ433zgL/Sh7XzlgJ/9KIK9DPTL9jrH/CIJiftEz6yKL/imuVTeB0W/mHPsYX7QNkwGwqK9+c754+X3bRG2Vare4lFsFtyb8MZH75LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650700; c=relaxed/simple;
	bh=dcoPOYdI9QVW1SA+pSU7416tXP/n6YM2HYKDdecuBTc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sfXMJmTH8yYLePGuDBoSnhYKCoPFzS1x2EtsnbsUUlrcwRviX57OmnuF+XMUDAAYiRFvQcTKXHT/0OwIPh/Czdi/7wIinSSIr9tFbm6Ro1AAtauBHAeZL2dVhAg01JJoAzkL9KHMXUsKTHo1S7sQ1qTyCPPZisILFiVtXvnWeL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rhSKK3Xs; arc=fail smtp.client-ip=40.107.100.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahrCgzoP8Xud43aJxVSpwn8mrVG8GQv04SYrsSRiA6K3+vQ0YpFXOzFPvnyeVXJ+2SgGgO1rZ0ajEwVLigqEpv2gXI/ydm7wLP2lzVtsg8hcynICPcMpQSw2sMbYKwbHmSPX7FdEF/1N90WUrAhCq4cV5c5+uZVh3u8KJctKLJN7wn7e4ePBeEGjqVRGjEZ/L7CjuuqG82Gic3XUxESSTvoik+cq8C+VeCYU3iLAOt7dQFpa3jIzQ47UdNv/BxSOXe4dqyP6XISanvkhD4bwqSBS0mY2k1nObA+lhPFThv/Cdlm/mN23WSY25axSm0B4xOu3yfk6s10TFwBhoGSQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llGdlL+RyRsHwY/IG387o2WHd/wbfLPvFrg02Ur6PtQ=;
 b=X40J48ttSOfmD0ozf1mVjE63Z+00n/25jMr4LNavElAnqSYF6BZOpmvGA01qA0UCXHIbekgKxV5nRrZtxcWdtsSTYvBzH5NgfNWi/ymjuQKtMpxfQROGjjKg0VC5RFqAk5SZQQrYZo58/82wVlANsZXHFFHhKvrdPzgpjEdM7htqD8EO3YxuAer/13I9lB7mvP8oPFRbMAP+bjGscOtPNg3lNiTTL1VXyjvt0hqTvizrsnE6XtTahwQRA1nHzYY8MEwBjY9DITb14MBOJQ0O5EIQiORDb4Erc1/ed7KppNUj5UBnbBzdqChns53QiYzS0xyJojZAmAIYcmqet2Cgsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llGdlL+RyRsHwY/IG387o2WHd/wbfLPvFrg02Ur6PtQ=;
 b=rhSKK3Xsq3A6LF1i7gOWL4in7YKYmW+Yb28aMD+tpGcoVt1E1Oz8pCxRzVrvgFv3AlgucJrBrOiC6k707TImvEtZWXjfcHmVFrJi4pFMia7IOu/CVp9YmV6NwVqH0N7g7FKenAdjHR+gCVOLAI/5W8EbNOsKBe1FzDbrHSOuqck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 14:58:15 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54%5]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 14:58:15 +0000
Message-ID: <4413cec1-bbc6-9c88-dfdf-9790949a379e@amd.com>
Date: Tue, 5 Mar 2024 08:58:10 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
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
 <11487a31-908e-d474-50c6-65617d417deb@amd.com>
 <c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com>
 <55b545fd-2851-0d0f-ac37-ec59838fb4b4@amd.com>
 <1f366890-d9ff-4ac4-9af9-1ea3128a87fc@intel.com>
 <41ca7504-c3fb-ddb6-e149-4ff82019d678@amd.com>
In-Reply-To: <41ca7504-c3fb-ddb6-e149-4ff82019d678@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0145.namprd02.prod.outlook.com
 (2603:10b6:5:332::12) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a97c2d-a2f8-4de7-c632-08dc3d24af59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n+2GwVpkUpkHJjAJw6GodJRxUtBrH3D+h5xbpHu2lPoOq36T7ZotteCXeZoP4a0+nD5YJ5kULBiJWomReFIOkw9B3voeSZJZt/H8n8ohxE6r10m4rFbFgeds4PBueEdkVE6h+2Wl60wYk5n7z+Zuxt2Y5TzUBMJLjnsyrxgP+IZQ5SBmXfuad1PwazgEX+pdOnz+BH4GieRNwTdZFrCTXmIny6c8t/Tknk9LKlqiY7RFOa5rv6JE7GHg+y7tyOk867Atv0V1iBlWtu72UyGBUITAgS8Qppmo0Qpe4V/99lTxbGqP/sd7R8v2MWM1reXLJPuobOXFUeRo/JclIMbl1xaqOyR6OPJ8DaTm7OhUc9diUd0kqDNUTaylYKYByK2uWhcj15CxFrgzgdpwrnAAoC42DCCcT0eHHE+AEpvkPWw+Pml0syqh1iNN+mewc0YheNNnHV7BCleRkPpyKYOTp43Oj/dZg3X3rHUxUA94ualSqkiVt0WJOKXvqjNlCXzS8cKbsThwRYHDR8kDZ/JjWrS99j6A7sYXth6nFaIKrQdcm3w5fRAitQMvfeDgsIB/PHbltyHlVJiGWSHH5gJsopGuQg56z4jUbajJxPQgD1t4zORw+uw2X7BDp0j7lCJUv7uhpF0pEI4wPNeB5Bm4EuqPWEw/+h+mumgNAOY6vEGjGHFE71Zd2JvYFuiQ+gIRy6BjI7hQklXSo+9zHlv01w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzMvbFNkck5UUENzdXpjdTlFWWw3UE45NmtMRzl5YjBicFFpaDVpWnczcnkw?=
 =?utf-8?B?M2dnUUxweU1FdW5WeFRsMzI1VlFlMTYrZnhFTm05d3ZNT2lBYzFmOEJSUVQ3?=
 =?utf-8?B?Nk5FM05XUStyQWFyenBadmd3YnprNEVOQ3Fka2s1TFo5Z2MvRXBPMDg4UkI3?=
 =?utf-8?B?WGozeUxqOUpxeFhJdDc0OWZOU08rZ1VMSEViZUsvM2YzczNFMlZVSmVZYUJQ?=
 =?utf-8?B?Q2FQWW1OOFBkNzFpeUM5TmQzbEd0VTl1dHRyZzhVVHMxYnNjejgwbzhzVHpo?=
 =?utf-8?B?NDMvVG5jR1VVV1drOENZcDQzd1NXajZrcFJYcEJvY0ZISGR6ZUZvQkhRenE2?=
 =?utf-8?B?NmpXbkIzSTVxVmhzVEhNeVhoSUdoajM4WTJiQzN4c2tPdUJuVnljYUhoMkZE?=
 =?utf-8?B?Q1Z0aXl2ZENqcmlSZ0NjQytKaE1LTXdMT2xKR2JINmltcVV3cEt0blA1dTBH?=
 =?utf-8?B?Wmp5eVJGUXBzM3FDbTgyUTJOLzhHY3VScUhIK3FtdjhRbEZzQXgwUWlvUzRF?=
 =?utf-8?B?aWsxUjdsNkxTRitvdWhxMWFwNnNTbGVqZkplYUZTTWpjUUNVa0NjblpWb01J?=
 =?utf-8?B?TEZBNnV1Z3liK0tJSmtseEpzdndPaDM2S09ON0gzNzhUVTdhdzJISWtXcW9D?=
 =?utf-8?B?NTBYRHVqSWxPRGl2RTRDSkVDb0xSdEQzdTl3U3U3eGhFSFZScjJrWWI4MFp4?=
 =?utf-8?B?OXRrWWgrOC9Qb2JhbHYwaU5LdVZmb3liYlkvUHJHWXdicmJWc2N5cGdmeEhJ?=
 =?utf-8?B?Q1N1N1lYZmp1U0RiOGRUdm5vN1NhL0JmR1REaEozdEFSWUp0RmR1TEtHUUdU?=
 =?utf-8?B?eGlqNXQvZzU3UEMyNVEzQ1NiQjM4Tys4aklGMVdsZFVycUQ0T1RwVC9nVmhE?=
 =?utf-8?B?YXdWNnJnMVFERnhRczdqSnN1dXJuS2VmWDFRNEZXWlMrZi85T3pxZEt2V1ZO?=
 =?utf-8?B?cHBGUUJnOW00MDl0b2UvTldBeFF3bm1QUkx0L004TUl1VURrN0JxT0FIN1NY?=
 =?utf-8?B?b1NYcytBQ3oybjBDQTJrUStWNHRTK2s3WmJCTFdPbDdaaXd5QlZ6NXhyNnJ1?=
 =?utf-8?B?K1c0ZDcwUVBvRmVOZTJGU2JMZGFYTTBVcGRyOExJK2NVcVFzSnNXOCtYY0Js?=
 =?utf-8?B?Qm83a09CWXErcUtiTGFhdWlMU014c29pRkRzaENlK1ZYaGFXZWpFajNraHkr?=
 =?utf-8?B?ZE9TRXQwWUZOQ09FclVnQWpyTFZPbXM1YnU0M0lnTkFvbnd1UWN5cFkyWnpH?=
 =?utf-8?B?Y2NVR3NoRHRyOUVZQjZ3eDdrSHg4R3pxYXVFU2k3bDMyeE40cUhOOVdKZjZv?=
 =?utf-8?B?N3dlYzVKbXM2bXNRNjk4OWJoZ2dnUVdzMEp3YnJsV1BxVk9iWmY4WXc2Zm4x?=
 =?utf-8?B?L3JZR2dwZFB0VGkyOUdxK1piWUQ4NTBiYTlIWk9HcE5TN2VZZERkU24xcS9l?=
 =?utf-8?B?djhDeXRCMVN2QVRLRDhiL0o0ZUgwS0JwYUt5QmErOWcxQWZONzJUb21xbjJU?=
 =?utf-8?B?blhFUjBqL2daWFFBRFEyQXFscWV0UjNCN2xnSkV6U3VLWGJWNlczdGQ5Unc4?=
 =?utf-8?B?N0VHb2taNU95TTZSaUs0YXFWMjJYeVczemFPR1krN2ZpZVpkbnFoRnhGc0pW?=
 =?utf-8?B?aGI3bWVZTTJrWkxEQlhTb0tVYkV4RmVwN3Axb3p3S25CTk9HK3BtTDdNRi9o?=
 =?utf-8?B?Q204MFJDNk04bkhRZ2k5THErbGhUR2prVFBocFJXRkZJS1ZCTzRqM0dKS2tq?=
 =?utf-8?B?SWtKUHN6Q0xvOGtlZ0hrUDVSQjZhVlR0SmtZVkNkZjZEdVBMZmY4LzN2MWhF?=
 =?utf-8?B?TFFtb3VzSnZqWHhGWVN0L0FVVG5vWWRDTVNqOXVsaDhPVUoxeXVrMVR6Z01o?=
 =?utf-8?B?eDMzTU4rQmo1V0d6c2t3Q0dsT0hLaWVZZXNFcCswaFFOWFpod0xac3BpTVFG?=
 =?utf-8?B?ZmQrUEdnbXhLVnRxTUFxTjVjQ0tRK0RqbmFtMTF5M2Q2aVVoMDlFdHM3NTc2?=
 =?utf-8?B?MFo1QmxFcnhXZWlhSEZiVkFFSFVadHAxYTZ1VURRQXEyaGNhdmtYT29pUnJS?=
 =?utf-8?B?SWxFQ29qbWJQMllqOWN2RWlMSUhlVE5zaXhaYmhSMzNXQzA1UENBdUorWkh6?=
 =?utf-8?Q?kVeg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a97c2d-a2f8-4de7-c632-08dc3d24af59
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 14:58:15.2363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpevgEYa1BDjQHXgfwLiy2yiFvbTyQDHAvPK2tFpl+89lTAYF68efrLuOkXMeRBP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751

Hi Peter,

I want to get your feedback on this approach before I start working on 
it.  Please look at few examples below.

Thanks

Babu

On 3/4/2024 4:24 PM, Moger, Babu wrote:
> Hi Reinette,
>
> On 3/4/2024 1:58 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 3/4/2024 11:34 AM, Moger, Babu wrote:
>>> On 3/1/2024 5:20 PM, Reinette Chatre wrote:
>>>> On 3/1/2024 12:36 PM, Moger, Babu wrote:
>>>>> On 2/29/24 15:50, Reinette Chatre wrote:
>>>>>> On 2/29/2024 12:37 PM, Moger, Babu wrote:
>>>>> To assign a counters to default group on domain 0.
>>>>> $echo "//00=+lt;01=+lt" > 
>>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>> It should not be necessary to use both "=" and "+" in the same 
>>>> assignment.
>>>> I think of "=" as "assign" and "+" as append ("-" as remove).
>>> Here are our options.
>>>
>>> a. assign one event (+)
>> I prefer that we use consistent interface with what users may be used to
>> in other kernel interfaces, like dynamic debug.
>> Considering that, "+" will not be "assign one event" but instead
>> (let me copy text from dynamic debug to help):
>> "+    add the given flags"
>>
>> So + will add (append) the provided flags to the matching domain, it
>> can be multiple flags and does not impact existing flags.
>
> ok. Sure.
>
>
>>
>>> b. unassign one event (-)
>> "-    remove the given flags" - it can be multiple flags that should be
>> removed from domain.
>>
>>> c. assign both (++ may be?)
>> No. Please do not constrain the interface with what needs to be 
>> supported
>> for ABMC. We may want to add other flags in the future, do not limit 
>> it to
>> two flags.
> ok Sure.
>>
>>> d. unassign both (_)
>> "=_" will unassign all flags without consideration of which flags
>> are set. User can also use "-l" to just unassign local MBM, "-t" to
>> unassign total MBM, or "-lt" to unassign local and total MBM 
>> specifically.
>
> oh ok. got it.
>
>
>>
>>> I think append ( "=") is not required while assigning.  It is 
>>> confusing.
>> "=" is not append. It is assign:
>>
>> " =    set the flags to the given flags"
> ok.
>>
>>> Assign or Add both involve same action.
>>>
>>> How about this? This might be easy to parse. May be space (" ") 
>>> after the domain id.
>> Why a space?
>>
>>> <group>/<domain id> <action><event>; <domain id> <action><event>
>>>
>> <control group>/<monitor group/<domain id><action><flags or 
>> _>;<domain id><action><flags or _>
>
>
> Based on our discussion, I am listing few examples here. Let me know 
> if I missed something.
>
>   mount  -t resctrl resctrl /sys/fs/resctrl/
>
> 1. Assign both local and total counters to default group on domain 0 
> and 1.
>    $echo "//00=lt;01=lt" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>
>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>    //00=lt;01=lt
>
> 2. Assign a total event to mon group inside the default group for both 
> domain 0 and 1.
>
>    $mkdir /sys/fs/resctrl/mon_groups/mon_a
>    $echo "/mon_a/00+t;01+t" > 
> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>
>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>    //00=lt;01=lt
>    /mon_a/00=t;01=t
>
> 3. Assign a local event to non-default control mon group both domain 0 
> and 1.
>    $mkdir /sys/fs/resctrl/ctrl_a
>    $echo "/ctrl_a/00=l;01=l"  > 
> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>
>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>    //00=lt;01=lt
>    /mon_a/00=t;01=t
>    /ctrl_a/00=l;01=l
>
> 4. Assign a both counters to mon group inside another control 
> group(non-default).
>    $mkdir /sys/fs/resctrl/ctrl_a/mon_ab/
>    $echo "ctrl_a/mon_ab/00=lt;01=lt" > 
> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_contro
>
>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>    //00=lt;01=lt
>    /mon_a/00=t;01=t
>    /ctrl_a/00=l;01=l
>    ctrl_a/mon_ab/00=lt;01=lt
>
> 5. Unassign a counter to mon group inside another control 
> group(non-default).
>    $echo "ctrl_a/mon_ab/00-l;01-l" > 
> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
>
>   $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>   //00=lt;01=lt
>   /mon_a/00=t;01=t
>   /ctrl_a/00=l;01=l
>   ctrl_a/mon_ab/00=t;01=t
>
> 6. Unassign all the counters on a specific group.
>    $echo "ctrl_a/mon_ab/00=_" > 
> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
>
>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>    //00=lt;01=lt
>    /mon_a/00=t;01=t
>    /ctrl_a/00=l;01=l
>    ctrl_a/mon_ab/00=_;01=_
>
> Thanks
> Babu Moger
>

